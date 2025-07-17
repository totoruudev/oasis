import React, { useEffect, useState } from "react";
import axios from "../api";
import { Link, useNavigate } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";

function getProductImageUrl(path) {
    if (!path) return "/default_thumb.jpg";
    if (path.startsWith("/")) return `${process.env.REACT_APP_API_BASE_URL}${path}`;
    return `${process.env.REACT_APP_API_BASE_URL}/images/products/${path}`;
}

export default function CartPage() {
    const [cartItems, setCartItems] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    // 장바구니 목록 불러오기
    const fetchCart = async () => {
        setLoading(true);
        try {
            const res = await axios.get("/api/cart", { withCredentials: true });
            setCartItems(res.data);
        } catch (err) {
            alert("장바구니 불러오기 실패");
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchCart();
    }, []);

    // 수량 변경
    const handleQtyChange = async (productId, quantity) => {
        if (quantity < 1) return;
        try {
            await axios.put(`/api/cart/${productId}`, { quantity }, { withCredentials: true });
            fetchCart();
        } catch (err) {
            alert("수량 변경 실패");
        }
    };

    // 삭제
    const handleRemove = async (productId) => {
        if (!window.confirm("이 상품을 삭제하시겠습니까?")) return;
        try {
            await axios.delete(`/api/cart/${productId}`, { withCredentials: true });
            setCartItems(items => items.filter(item => item.productId !== productId));
        } catch {
            alert("삭제 실패");
        }
    };

    // 전체 비우기
    const handleClear = async () => {
        if (!window.confirm("장바구니를 모두 비우시겠습니까?")) return;
        try {
            await axios.delete(`/api/cart/clear`, { withCredentials: true });
            setCartItems([]);
        } catch {
            alert("장바구니 비우기 실패");
        }
    };

    // 합계 계산
    const getSum = () =>
        cartItems.reduce((sum, item) => sum + (item.price * item.quantity * (100 - (item.percent || 0)) / 100), 0);

    const handleCheckout = () => {
        const checkoutItems = cartItems.map(item => ({
            id: item.productId,
            name: item.productName,
            price: item.price,
            percent: item.percent,
            qty: item.quantity,
            thumbnailimg: item.thumbnailimg
        }));
        navigate("/order/checkout", { state: { items: checkoutItems } });
    };

    return (
        <div className="container py-4" style={{ maxWidth: 600 }}>
            <h2 className="mb-4 fw-bold text-center">장바구니</h2>
            {loading ? (
                <div className="d-flex justify-content-center align-items-center" style={{ minHeight: 220 }}>
                    <div className="spinner-border text-success" role="status">
                        <span className="visually-hidden">로딩중...</span>
                    </div>
                </div>
            ) : cartItems.length === 0 ? (
                <div className="alert alert-info text-center">장바구니에 담긴 상품이 없습니다.</div>
            ) : (
                <div>
                    <table className="table align-middle mb-3">
                        <thead className="table-light">
                            <tr>
                                <th style={{ width: 80 }}>이미지</th>
                                <th>상품명</th>
                                <th style={{ width: 90 }}>수량</th>
                                <th style={{ width: 90 }}>금액</th>
                                <th style={{ width: 60 }}></th>
                            </tr>
                        </thead>
                        <tbody>
                            {cartItems.map(item => (
                                <tr key={item.productId}>
                                    <td>
                                        <img src={getProductImageUrl(item.thumbnailimg)}
                                            alt={item.productName}
                                            className="rounded"
                                            style={{ width: 56, height: 56, objectFit: "cover" }}
                                        />
                                    </td>
                                    <td>
                                        <Link to={`/products/${item.productId}`} className="text-decoration-none text-dark fw-semibold">
                                            {item.productName}
                                            {item.percent > 0 && (
                                                <span className="badge bg-danger ms-2">{item.percent}%</span>
                                            )}
                                        </Link>
                                    </td>
                                    <td>
                                        <div className="d-flex align-items-center">
                                            <button className="btn btn-outline-secondary btn-sm me-1"
                                                onClick={() => handleQtyChange(item.productId, item.quantity - 1)}>-</button>
                                            <span style={{ width: 24, display: "inline-block", textAlign: "center" }}>{item.quantity}</span>
                                            <button className="btn btn-outline-secondary btn-sm ms-1"
                                                onClick={() => handleQtyChange(item.productId, item.quantity + 1)}>+</button>
                                        </div>
                                    </td>
                                    <td>
                                        <span>
                                            <del className="text-muted small">{item.percent > 0 ? (item.price * item.quantity).toLocaleString() + "원" : ""}</del><br />
                                            <span className="fw-bold text-success">{Math.floor(item.price * item.quantity * (100 - (item.percent || 0)) / 100).toLocaleString()}원</span>
                                        </span>
                                    </td>
                                    <td>
                                        <button className="btn btn-sm btn-outline-danger"
                                            onClick={() => handleRemove(item.productId)}>삭제</button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                    <div className="d-flex justify-content-between align-items-center border-top pt-3 mb-3">
                        <button className="btn btn-outline-secondary btn-sm" onClick={handleClear}>전체 비우기</button>
                        <span className="fw-bold fs-5">합계: <span className="text-success">{Math.floor(getSum()).toLocaleString()}원</span></span>
                    </div>
                    <div className="d-grid gap-2">
                        {/* 주문하기 버튼 */}
                        <button className="btn btn-success btn-lg mb-2" onClick={handleCheckout}>
                            주문하기
                        </button>
                        <Link to="/products" className="btn btn-outline-primary btn-lg">쇼핑 계속하기</Link>
                    </div>
                </div>
            )}
        </div>
    );
}
