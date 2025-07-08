import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";
import { motion } from "framer-motion";
import { sectionGroups } from "../constants/sectionGroups";
import "./Home.css";
import {
  getSections,
  getEventCarousel,
  getRecommendedCategories,
  getLatestNotices,
} from "../api";

function chunkArray(array, size) {
  return Array.from({ length: Math.ceil(array.length / size) }, (_, i) =>
    array.slice(i * size, i * size + size)
  );
}

function getProductImageUrl(path) {
  if (!path) return "/default_thumb.jpg";
  if (path.startsWith("/")) return `http://localhost:8094${path}`;
  return `http://localhost:8094/images/products/${path}`;
}

function getPrettyPrice(price, percent) {
  if (!percent || percent === 0) return price;
  const discounted = price * (1 - percent / 100);
  // 100원 단위로 내림
  return Math.floor(discounted / 100) * 100;
}

export default function Home() {
  const [events, setEvents] = useState([]);
  const [categories, setCategories] = useState([]);
  const [activeTabs, setActiveTabs] = useState(Array(sectionGroups.length).fill(0));
  const [sectionProducts, setSectionProducts] = useState({});
  const [notices, setNotices] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    (async () => {
      const [eventRes, catRes, sectionRes, noticeRes] = await Promise.allSettled([
        getEventCarousel(),
        getRecommendedCategories(),
        getSections(),
        getLatestNotices(),
      ]);
      if (eventRes.status === "fulfilled") setEvents(eventRes.value.data);
      if (catRes.status === "fulfilled") setCategories(catRes.value.data);
      if (sectionRes.status === "fulfilled") setSectionProducts(sectionRes.value.data);
      if (noticeRes.status === "fulfilled") setNotices(noticeRes.value.data);
    })();
  }, []);

  // 섹션별 탭 필터링
  const filterSectionProducts = (section, sectionIdx) => {
    const products = sectionProducts[section.title]?.products ?? [];
    if (!section.buttonGroups.length) return products.slice(0, 4);

    // 탭별 필터 부분
    const keys = section.buttonGroups[activeTabs[sectionIdx]].keys;

    return products
    .filter(prod => keys.map(Number).includes(Number(prod.subCategoryId)))
    .slice(0, 4);
};


  // 이벤트 캐러셀 그룹핑
  const eventSlides = chunkArray(events, 3);

  return (
    <div className="container-fluid px-0 Home">

      {/* === 1. 이벤트 캐러셀 === */}
      <section>
        <div id="eventCarousel" className="event-slide carousel slide mb-4" data-bs-ride="carousel">
          <div className="carousel-inner">
            {eventSlides.length === 0 ? (
              <div className="carousel-item active text-center">
                <div style={{ height: 350, display: "flex", alignItems: "center", justifyContent: "center" }}>
                  <span>이벤트 없음</span>
                </div>
              </div>
            ) : (
              eventSlides.map((slide, idx) => (
                <div className={`carousel-item${idx === 0 ? " active" : ""}`} key={idx}>
                  <div className="container">
                    <div className="row justify-content-center g-3">
                      {slide.map((ev, i) => (
                        <div className="col-12 col-md-4" key={i}>
                          <div className="card h-100 border-0 shadow-sm">
                            <img
                              src={ev.url}
                              className="card-img"
                              style={{ height: 350, objectFit: "cover" }}
                              alt={`event-${i}`}
                            />
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              ))
            )}
          </div>
          {eventSlides.length > 1 && (
            <>
              <button className="carousel-control-prev" type="button" data-bs-target="#eventCarousel" data-bs-slide="prev">
                <span className="carousel-control-prev-icon" aria-hidden="true"></span>
                <span className="visually-hidden">Previous</span>
              </button>
              <button className="carousel-control-next" type="button" data-bs-target="#eventCarousel" data-bs-slide="next">
                <span className="carousel-control-next-icon" aria-hidden="true"></span>
                <span className="visually-hidden">Next</span>
              </button>
            </>
          )}
        </div>
      </section>

      {/* === 2. 추천 카테고리 === */}
      <div className="category-sections-wrap">
        <section className="category-section py-4">
          <div className="section-title"><h2>추천 카테고리</h2></div>
          <div className="category-main-box p-3 mb-4">
            <div className="container d-flex flex-wrap justify-content-center gap-3">
              {categories.map(cat => (
                <motion.div whileHover={{ scale: 1.13 }} className="category-icon text-center" key={cat.id}>
                  <Link to={`/products/category/${cat.id}`}>
                    <div className="rounded-circle bg-light d-flex align-items-center justify-content-center"
                      style={{ width: 80, height: 80, overflow: "hidden", margin: "0 auto" }}>
                      <img src={cat.icon} alt={cat.name} style={{ width: 80, height: 80, objectFit: "cover" }} />
                    </div>
                    <div className="cate-icon-name mt-2 small">{cat.name}</div>
                  </Link>
                </motion.div>
              ))}
            </div>
          </div>
        </section>
      </div>

      {/* === 3. 섹션별 상품 === */}
      <div className="category-sections-wrap">
        {sectionGroups.map((section, sectionIdx) => (
          <section className="product-section py-4" key={sectionIdx}>
            <div className="section-title">
              <h2>{section.title}</h2>
            </div>
            <hr />
            <div className="container">
              <div className="d-flex align-items-center mb-3">
                {section.buttonGroups.map((group, tabIdx) => (
                  <button
                    key={tabIdx}
                    className={`tab-btn${activeTabs[sectionIdx] === tabIdx ? " active" : ""}`}
                    onClick={() => {
                      setActiveTabs(prev => {
                        const copy = [...prev];
                        copy[sectionIdx] = tabIdx;
                        return copy;
                      });
                    }}
                    type="button"
                  >
                    {group.label}
                  </button>
                ))}
              </div>
              <div className="row row-cols-2 row-cols-md-4 g-3">
                {filterSectionProducts(section, sectionIdx).map(prod => (
                  <div
                    className="col product-card"
                    key={prod.id}
                    style={{ cursor: "pointer" }}
                    onClick={() => navigate(`/products/${prod.id}`)}
                  >
                    <div className="card h-100 border-0">
                      <div className="img-wrap position-relative overflow-hidden mx-auto">
                        <motion.img
                          whileHover={{ scale: 1.1 }}
                          src={getProductImageUrl(prod.thumbnailimg)}
                          alt={prod.name}
                          className="card-img-top"
                          style={{
                            width: "100%",
                            height: "100%",
                            objectFit: "cover",
                            transition: "transform 0.2s"
                          }}
                        />
                      </div>
                      <div className="card-body">
                        <h6 className="card-title">{prod.name}</h6>
                        <div className="mb-1 d-flex align-items-end gap-2">
                          {prod.percent > 0 && (
                            <span className="discount-percent me-1">{prod.percent}%</span>
                          )}
                          <span className="sale-price fw-bold">
                            {getPrettyPrice(prod.price, prod.percent).toLocaleString()}원
                          </span>
                          {prod.percent > 0 && (
                            <span className="origin-price text-muted ms-1">
                              <del>{prod.price?.toLocaleString()}원</del>
                            </span>
                          )}
                        </div>
                      </div>


                    </div>
                  </div>

                ))}
              </div>
            </div>
          </section>
        ))}
      </div>

      {/* === 4. 공지사항 === */}
      <section className="notice-section border-top py-3 bg-light mt-5">
        <div className="section-title"><h2>공지사항</h2></div>
        <div className="container">
          <ul className="list-group list-group-flush">
            {notices.map((notice) => (
              <li className="list-group-item" key={notice.id}>
                <Link to={`/notice/${notice.id}`} className="text-dark">
                  {notice.title}
                </Link>
                <span className="float-end text-muted small">{notice.createdAt?.slice(0, 10)}</span>
              </li>
            ))}
          </ul>
        </div>
      </section>
    </div>
  );
}
