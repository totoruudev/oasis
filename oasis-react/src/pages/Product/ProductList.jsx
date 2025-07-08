import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import axios from "axios";

// 부트스트랩 css는 index.js 등 전역에서 이미 import돼 있다고 가정

const CATEGORY_TITLES = { 1: "농산", 2: "축산", 3: "수산", 4: "간식" };

// 상품 이미지 경로 함수 (Home.jsx 스타일 맞춤)
function getProductImageUrl(path) {
    if (!path) return "/default_thumb.jpg";
    if (path.startsWith("/")) return `http://localhost:8094${path}`;
    return `http://localhost:8094/images/products/${path}`;
}

// 할인 가격 함수 (Home.jsx와 통일)
function getPrettyPrice(price, percent) {
    if (!percent || percent === 0) return price;
    const discounted = price * (1 - percent / 100);
    // 100원 단위 내림
    return Math.floor(discounted / 100) * 100;
}

function CategoryTabs({ activeId }) {
    const categories = [
        { id: 1, name: "농산" },
        { id: 2, name: "축산" },
        { id: 3, name: "수산" },
        { id: 4, name: "간식" },
    ];
    return (
        <div className="d-flex mb-3 border-bottom">
            {categories.map((cat) => (
                <Link
                    key={cat.id}
                    to={`/category/${cat.id}`}
                    className={`py-2 px-3 fw-bold text-decoration-none ${activeId === String(cat.id) ? "border-bottom border-success text-success" : "text-body"}`}
                >
                    {cat.name}
                </Link>
            ))}
        </div>
    );
}

export default function ProductList() {
    const { categoryId } = useParams();
    const [products, setProducts] = useState([]);
    const [totalCount, setTotalCount] = useState(0);
    const [page, setPage] = useState(1);
    const pageSize = 20;

    useEffect(() => {
        setPage(1); // 카테고리 변경시 1페이지로 리셋
    }, [categoryId]);

    useEffect(() => {
        axios
            .get(`/api/products/category/${categoryId}?page=${page}&size=${pageSize}`)
            .then((res) => {
                setProducts(res.data.content);
                setTotalCount(res.data.totalElements);
            });
    }, [categoryId, page]);

    const totalPages = Math.ceil(totalCount / pageSize);

    if (!CATEGORY_TITLES[categoryId]) {
        return <div>존재하지 않는 카테고리입니다.</div>;
    }

    return (
        <div className="container py-4">
            <h2 className="fw-bold mb-4">{CATEGORY_TITLES[categoryId]}</h2>
            <CategoryTabs activeId={categoryId} />

            {/* 상품 그리드 */}
            <div className="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-3">
                {products.map((p) => (
                    <div key={p.id} className="col">
                        <div className="card h-100 border-0 shadow-sm">
                            <Link to={`/products/${p.id}`} className="text-decoration-none text-dark">
                                <div className="img-wrap overflow-hidden" style={{ borderRadius: "14px 14px 0 0", background: "#fafafa" }}>
                                    <img
                                        src={getProductImageUrl(p.thumbnailimg)}
                                        alt={p.name}
                                        className="card-img-top"
                                        style={{ width: "100%", height: 320, objectFit: "cover", transition: "transform 0.18s" }}
                                    />
                                </div>
                                <div className="card-body px-2 pt-3 pb-2">
                                    <h6 className="card-title mb-1" style={{ minHeight: 40 }}>{p.name}</h6>
                                    <div className="d-flex align-items-end gap-2">
                                        {p.percent > 0 && (
                                            <span className="fw-bold" style={{ color: "#1bbd54" }}>{p.percent}%</span>
                                        )}
                                        <span className="sale-price fw-bold fs-5" style={{ color: "#222" }}>
                                            {getPrettyPrice(p.price, p.percent).toLocaleString()}원
                                        </span>
                                        {p.percent > 0 && (
                                            <span className="origin-price text-muted ms-1" style={{ fontSize: "1rem" }}>
                                                <del>{p.price?.toLocaleString()}원</del>
                                            </span>
                                        )}
                                    </div>
                                </div>
                            </Link>
                        </div>
                    </div>
                ))}
            </div>

            {/* 페이징 */}
            <nav>
                <ul className="pagination justify-content-center mt-4">
                    <li className={`page-item ${page === 1 ? "disabled" : ""}`}>
                        <button
                            className="page-link"
                            onClick={() => setPage((p) => Math.max(1, p - 1))}
                            tabIndex={page === 1 ? -1 : 0}
                            aria-disabled={page === 1}
                        >
                            이전
                        </button>
                    </li>
                    {Array.from({ length: totalPages }, (_, idx) => (
                        <li key={idx + 1} className={`page-item ${page === idx + 1 ? "active" : ""}`}>
                            <button className="page-link" onClick={() => setPage(idx + 1)}>
                                {idx + 1}
                            </button>
                        </li>
                    ))}
                    <li className={`page-item ${page === totalPages ? "disabled" : ""}`}>
                        <button
                            className="page-link"
                            onClick={() => setPage((p) => Math.min(totalPages, p + 1))}
                            tabIndex={page === totalPages ? -1 : 0}
                            aria-disabled={page === totalPages}
                        >
                            다음
                        </button>
                    </li>
                </ul>
            </nav>
        </div>
    );
}
