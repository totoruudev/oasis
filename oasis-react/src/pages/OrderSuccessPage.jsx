import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import axios from "axios";
import "./OrderSuccessPage.css"; 

export default function OrderSuccessPage() {
    const location = useLocation();
    const navigate = useNavigate();
    const [order, setOrder] = useState(null);
    const [error, setError] = useState("");
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const search = new URLSearchParams(location.search);
        const paymentKey = search.get("paymentKey");
        const orderId = search.get("orderId");
        const amount = Number(search.get("amount"));

        // 결제 정보가 없으면 에러 처리
        if (!paymentKey || !orderId || !amount) {
            alert("잘못된 접근입니다.");
            return;
        }

        // 결제 검증 요청
        axios.post("/api/orders/confirm", {
            paymentKey,
            orderId,
            amount
        }, { withCredentials: true })
            .then(res => {
                setOrder(res.data);
            })
            .catch(err => {
                setError("결제 확인에 실패했습니다.");
            })
            .finally(() => setLoading(false));
    }, [location, navigate]);

    if (loading) {
        return (
            <div className="container py-5 text-center">
                <h2 className="mb-4">결제 검증 중입니다...</h2>
                <div className="spinner-border text-success" role="status">
                    <span className="visually-hidden">Loading...</span>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className="container py-5 text-center">
                <h2 className="mb-4">{error}</h2>
                <button className="btn btn-primary" onClick={() => navigate("/order/checkout")}>돌아가기</button>
            </div>
        );
    }

    return (
        <div className="container order-success-container py-5 text-center">
            <h2 className="mb-4">결제 완료!</h2>
            <div className="order-box card mx-auto mb-4 shadow-lg border-success">
                <div className="order-box-inner card-body">
                    <p className="order-label">주문일자: <span>{order.createdAt}</span></p>
                    <p className="order-label">총 결제금액: <b className="order-amount">{order.totalAmount?.toLocaleString()}원</b></p>
                    <p className="order-label">구매자: <span>{order.name}</span></p>
                    <p className="order-label">배송지: <span>{order.address}</span></p>
                    <p className="order-label">전화번호: <span>{order.phone}</span></p>
                </div>
            </div>
            <div className="order-items-box mb-4">
                <h5 className="order-items-title">주문상품</h5>
                <ul className="list-group order-items-list">
                    {order.items && order.items.map(item => (
                        <li key={item.productId} className="list-group-item d-flex align-items-center justify-content-between order-item">
                            <span className="d-flex align-items-center">
                                <img src={item.thumbnailimg} alt={item.productName} className="order-item-img" />
                                <span className="fw-bold">{item.productName}</span>
                                <span className="text-muted ms-2">x{item.quantity}</span>
                            </span>
                            <span className="fw-bold">{(item.price * item.quantity).toLocaleString()}원</span>
                        </li>
                    ))}
                </ul>
            </div>
            <button className="btn btn-success px-4 py-2 fw-bold" onClick={() => navigate("/")}>메인으로</button>
        </div>
    );
}