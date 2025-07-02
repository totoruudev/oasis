import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";
import { motion } from "framer-motion";
import { sectionGroups } from "../constants/sectionGroups";
import axios from "axios";
import "./Home.css";

function chunkArray(array, size) {
  const result = [];
  for (let i = 0; i < array.length; i += size) {
    result.push(array.slice(i, i + size));
  }
  return result;
}

export default function Home() {

  const [events, setEvents] = useState([]);
  const [categories, setCategories] = useState([]);
  const [allSubCategories, setAllSubCategories] = useState([]);
  const [activeTabs, setActiveTabs] = useState(Array(sectionGroups.length).fill(0));
  const [sectionProducts, setSectionProducts] = useState({});
  const [notices, setNotices] = useState([]);
  

  useEffect(() => {
    (async () => {
      const [eventRes, catRes, subCatRes, sectionRes, noticeRes] = await Promise.allSettled([
        axios.get("/api/event/carousel"),
        axios.get("/api/categories/recommend"),
        axios.get("/api/subcategories"),
        axios.get("/api/products/sections"),
        axios.get("/api/notices/latest?limit=4"),
      ]);
      if (eventRes.status === "fulfilled") setEvents(eventRes.value.data);
      if (catRes.status === "fulfilled") setCategories(catRes.value.data);
      if (subCatRes.status === "fulfilled") setAllSubCategories(subCatRes.value.data);
      if (sectionRes.status === "fulfilled") setSectionProducts(sectionRes.value.data);
      if (noticeRes.status === "fulfilled") setNotices(noticeRes.value.data);
    })();
  }, []);

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
              <button
                className="carousel-control-prev"
                type="button"
                data-bs-target="#eventCarousel"
                data-bs-slide="prev"
              >
                <span className="carousel-control-prev-icon" aria-hidden="true"></span>
                <span className="visually-hidden">Previous</span>
              </button>
              <button
                className="carousel-control-next"
                type="button"
                data-bs-target="#eventCarousel"
                data-bs-slide="next"
              >
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
          <div className="section-title">
            <h2>추천 카테고리</h2>
          </div>
          <div className="category-main-box p-3 mb-4">
            <div className="container d-flex flex-wrap justify-content-center gap-3">
              {categories.map((cat) => (
                <motion.div whileHover={{ scale: 1.13 }} className="category-icon text-center" key={cat.id}>
                  <Link to={`/category/${cat.id}`}>
                    <div
                      className="rounded-circle bg-light d-flex align-items-center justify-content-center"
                      style={{ width: 80, height: 80, overflow: "hidden", margin: "0 auto" }}
                    >
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

      {/* === 3. 카테고리별 상품 섹션 === */}
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
                      // 섹션별 활성탭 변경
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
              {/* 상품카드: sectionProducts[section.title]에 맞게 표시 */}
              <div className="row row-cols-2 row-cols-md-4 g-3">
                {(sectionProducts[section.title]?.products ?? []).slice(0, 4).map((prod) => (
                  <div className="col" key={prod.id}>
                    <div className="card h-100 border-0">
                      <div className="position-relative overflow-hidden">
                        <motion.img
                          whileHover={{ scale: 1.1 }}
                          src={prod.thumbnailimg}
                          alt={prod.name}
                          className="card-img-top"
                          style={{ transition: "transform 0.2s" }}
                        />
                      </div>
                      <div className="card-body">
                        <h6 className="card-title">{prod.name}</h6>
                        <div className="fw-bold mb-1">{prod.price?.toLocaleString()}원</div>
                        {prod.percent > 0 && <span className="badge bg-danger">{prod.percent}%</span>}
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        ))}
      </div>

      {/* === 4. 공지사항 섹션 === */}
      <section className="notice-section border-top py-3 bg-light mt-5">
        <div className="section-title">
          <h2>공지사항</h2>
        </div>
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
