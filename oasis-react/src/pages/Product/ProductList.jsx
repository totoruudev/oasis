import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import axios from "axios";

function getSectionTitleByCategoryId(catId) {
    switch (Number(catId)) {
        case 1: return "신선하게 자라난 농산물";
        case 2: return "농장에서 식탁까지 신선축산";
        case 3: return "바다향 가득 품은 수산물";
        case 4: return "요즘 인기있는 간식";
        case 5: return "테스트카테고리" ;
        default: return "";
    }
}

const CATEGORY_TITLES = { 1: "농산", 2: "축산", 3: "수산", 4: "간식" , 5: "테스트카테고리"};

function getProductImageUrl(path) {
    if (!path) return "/default_thumb.jpg";
    if (path.startsWith("/")) return `${process.env.REACT_APP_API_BASE_URL}${path}`;
    return `${process.env.REACT_APP_API_BASE_URL}/images/products/${path}`;
}

function getPrettyPrice(price, percent) {
    if (!percent || percent === 0) return price;
    const discounted = price * (1 - percent / 100);
    return Math.floor(discounted / 100) * 100;
}

function CategoryTabs({ activeId }) {
    const categories = [
        { id: 1, name: "농산" },
        { id: 2, name: "축산" },
        { id: 3, name: "수산" },
        { id: 4, name: "간식" },
        { id: 5, name: "테스트" },
    ];
    return (
        <div className="d-flex mb-3 border-bottom">
            {categories.map((cat) => (
                <Link
                    key={cat.id}
                    to={`/products/category/${cat.id}`}
                    className={`py-2 px-3 fw-bold text-decoration-none ${Number(activeId) === cat.id ? "border-bottom border-success text-success" : "text-body"}`}
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
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState("");
    const pageSize = 20;

    useEffect(() => {
        setPage(1);
    }, [categoryId]);

    useEffect(() => {
        setLoading(true);
        setError("");
        axios
            .get(`/api/products/category/${categoryId}?page=${page}&size=${pageSize}`)
            .then((res) => {
                setProducts(res.data.content || []);
                setTotalCount(res.data.totalElements || 0);
                setLoading(false);
            })
            .catch((err) => {
                setProducts([]);
                setTotalCount(0);
                setLoading(false);
                setError("상품을 불러오지 못했습니다.");
            });
    }, [categoryId, page]);

    // 최소 1페이지는 보장
    const totalPages = Math.max(1, Math.ceil(totalCount / pageSize));

    // 숫자 페이지 5개씩만 표시 (실전 UX)
    let start = Math.max(1, page - 2);
    let end = Math.min(totalPages, start + 4);
    if (end - start < 4) start = Math.max(1, end - 4);
    const pageNumbers = [];
    for (let i = start; i <= end; i++) {
        pageNumbers.push(i);
    }

    if (!CATEGORY_TITLES[categoryId]) {
        return <div className="text-danger text-center py-5">존재하지 않는 카테고리입니다.</div>;
    }

    return (
        <div className="container py-4">
            <h1 className="text-center" style={{ marginBottom: "20px" }}>오감동</h1>
            <h4 className="text-center mb-4">
                {getSectionTitleByCategoryId(categoryId)}
            </h4>
            {/* <h2 className="fw-bold mb-4">{CATEGORY_TITLES[categoryId]}</h2> */}
            <CategoryTabs activeId={categoryId} />

            {/* 에러/로딩 */}
            {loading && <div className="text-center py-5 text-muted">불러오는 중...</div>}
            {error && <div className="text-center py-5 text-danger">{error}</div>}

            {/* 상품 그리드 */}
            {!loading && !error && (
                products.length > 0 ? (
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
                ) : (
                    <div className="text-center py-5 text-muted">등록된 상품이 없습니다.</div>
                )
            )}

            {/* 페이징 */}
            <nav>
                <ul className="pagination justify-content-center mt-4">
                    {/* < 버튼 */}
                    <li className={`page-item ${page === 1 ? "disabled" : ""}`}>
                        <button className="page-link" onClick={() => setPage(Math.max(1, page - 1))} disabled={page === 1}>&lt;</button>
                    </li>
                    {/* 숫자 페이지 */}
                    {Array.from({ length: totalPages }, (_, idx) => (
                        <li key={idx + 1} className={`page-item ${page === idx + 1 ? "active" : ""}`}>
                            <button className="page-link" onClick={() => setPage(idx + 1)}>
                                {idx + 1}
                            </button>
                        </li>
                    ))}
                    {/* > 버튼 */}
                    <li className={`page-item ${page === totalPages ? "disabled" : ""}`}>
                        <button className="page-link" onClick={() => setPage(Math.min(totalPages, page + 1))} disabled={page === totalPages}>&gt;</button>
                    </li>
                </ul>
            </nav>
        </div>
    );
}
