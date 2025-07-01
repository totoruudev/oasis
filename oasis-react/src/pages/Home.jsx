import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation } from "swiper/modules";
import "swiper/css";
import "swiper/css/navigation";
import "bootstrap/dist/css/bootstrap.min.css";
import { motion } from "framer-motion";
import axios from "axios";
import "./Home.css";
import "./EventCarousel.css";

export default function Home() {
  // 상태
  const [events, setEvents] = useState([]);
  const [categories, setCategories] = useState([]);
  const [sectionProducts, setSectionProducts] = useState({});
  const [notices, setNotices] = useState([]);

  // 데이터 불러오기
  useEffect(() => {
  (async () => {
    const [eventRes, catRes, sectionRes, noticeRes] = await Promise.allSettled([
      axios.get("/api/event/carousel"),
      axios.get("/api/categories/recommend"),
      axios.get("/api/products/sections"),
      axios.get("/api/notices/latest?limit=4"),
    ]);
    if (eventRes.status === "fulfilled") {
      setEvents(eventRes.value.data);
    }
    if (catRes.status === "fulfilled") {
      setCategories(catRes.value.data);
    }
    if (sectionRes.status === "fulfilled") {
      setSectionProducts(sectionRes.value.data);
    }
    if (noticeRes.status === "fulfilled") {
      setNotices(noticeRes.value.data);
    }
    // 에러는 필요시 따로 처리
  })();
}, []);


  console.log("렌더링 시점 events:", events);

  return (
    <div className="container-fluid px-0 Home">
      {/* === 1. 이벤트 캐러셀 === */}
      <section>
  <h2>이벤트 리스트 테스트</h2>
  {events.length === 0 ? (
    <p>이벤트 없음</p>
  ) : (
    events.map((ev, idx) => (
      <div key={idx}>
        <img src={ev.url} style={{ width: 200 }} />
      </div>
    ))
  )}
</section>


      {/* === 2. 추천 카테고리 === */}
      <section className="category-section py-4">
        <div className="container d-flex flex-wrap justify-content-center gap-3">
          {categories.map((cat) => (
            <motion.div whileHover={{ scale: 1.14 }} className="category-icon text-center" key={cat.id}>
              <Link to={`/category/${cat.id}`}>
                <div
                  className="rounded-circle bg-light shadow-sm d-flex align-items-center justify-content-center"
                  style={{ width: 80, height: 80, overflow: "hidden", margin: "0 auto" }}
                >
                  <img src={cat.icon} alt={cat.name} style={{ width: 48, height: 48 }} />
                </div>
                <div className="mt-2 small">{cat.name}</div>
              </Link>
            </motion.div>
          ))}
        </div>
      </section>

      {/* === 3. 카테고리별 상품 섹션 === */}
      {Object.entries(sectionProducts).map(([sectionTitle, sectionData], idx) => (
        <section className="product-section py-4" key={idx}>
          <div className="container">
            <div className="d-flex justify-content-between align-items-center mb-3">
              <h5>
                <Link to={sectionData.link} className="text-dark text-decoration-none">
                  {sectionTitle} &gt;
                </Link>
              </h5>
              <div>
                {sectionData.subCategories?.map((sub, i) => (
                  <Link to={sub.link} key={i} className="btn btn-outline-secondary btn-sm mx-1">
                    {sub.name}
                  </Link>
                ))}
              </div>
            </div>
            <div className="row row-cols-2 row-cols-md-4 g-3">
              {sectionData.products?.slice(0, 4).map((prod) => (
                <div className="col" key={prod.id}>
                  <div className="card h-100 border-0 shadow-sm product-card">
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

      {/* === 4. 공지사항 섹션 === */}
      <section className="notice-section border-top py-3 bg-light mt-5">
        <div className="container">
          <h6 className="fw-bold mb-3">공지사항</h6>
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
