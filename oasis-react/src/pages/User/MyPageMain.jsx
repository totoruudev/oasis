import React from "react";
import { Link } from "react-router-dom";

export default function MyPageMain({ user, wishlist = [], reviewList = [] }) {
    console.log("user값 확인:", user);
    // 최신순 3개
    const recentWish = (wishlist ?? []).slice(0, 3);
    const recentReview = (reviewList ?? []).slice(0, 3);

    return (
        <div className="container my-5">
            <h2 className="mb-4">마이페이지</h2>
            {/* 상단 버튼 (내 정보, 주문내역, 관리자 이동) */}
            <div className="row mb-4 g-3">
                <div className="col-12 col-md-auto">
                    <Link to="/mypage/verify-password" className="btn btn-outline-primary w-100">
                        내 정보 관리
                    </Link>
                </div>
                <div className="col-12 col-md-auto">
                    <Link to="/mypage/orders" className="btn btn-outline-secondary w-100">
                        주문 내역
                    </Link>
                </div>
                {user?.role === "ADMIN" && (
                    <div className="col-12 col-md-auto">
                        <Link to="/admin" className="btn btn-danger w-100">
                            관리자 페이지로 이동
                        </Link>
                    </div>
                )}
            </div>

            {/* 본문: 2단(모바일은 1단) */}
            <div className="row g-4">
                {/* 찜한 상품 */}
                <div className="col-12 col-md-6">
                    <div className="card h-100 shadow-sm">
                        <div className="card-header d-flex justify-content-between align-items-center">
                            <span className="fw-semibold">찜한 상품</span>
                            <Link to="/mypage/wishlist" className="small text-decoration-none">
                                더보기 &gt;
                            </Link>
                        </div>
                        <ul className="list-group list-group-flush">
                            {recentWish.length === 0 ? (
                                <li className="list-group-item text-muted">찜한 상품이 없습니다.</li>
                            ) : recentWish.map(item => (
                                <li key={item.id} className="list-group-item d-flex align-items-center gap-3">
                                    <img
                                        src={item.image}
                                        alt={item.name}
                                        width={48}
                                        height={48}
                                        className="rounded"
                                        style={{ objectFit: "cover", border: "1px solid #eee" }}
                                    />
                                    <div className="flex-grow-1">
                                        <div className="fw-bold">{item.name}</div>
                                        <div className="small text-muted">{item.price?.toLocaleString()}원</div>
                                    </div>
                                </li>
                            ))}
                        </ul>
                    </div>
                </div>

                {/* 내가 쓴 리뷰/문의 */}
                <div className="col-12 col-md-6">
                    <div className="card h-100 shadow-sm">
                        <div className="card-header d-flex justify-content-between align-items-center">
                            <span className="fw-semibold">내가 쓴 리뷰/문의</span>
                            <Link to="/mypage/reviews" className="small text-decoration-none">
                                더보기 &gt;
                            </Link>
                        </div>
                        <ul className="list-group list-group-flush">
                            {recentReview.length === 0 ? (
                                <li className="list-group-item text-muted">작성한 리뷰나 문의가 없습니다.</li>
                            ) : recentReview.map(item => (
                                <li key={item.id} className="list-group-item">
                                    <div className="fw-bold">{item.title}</div>
                                    <div className="small text-muted">{item.content?.slice(0, 30)}{item.content?.length > 30 && '...'}</div>
                                    <div className="small text-secondary">{item.date}</div>
                                </li>
                            ))}
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    );
}
