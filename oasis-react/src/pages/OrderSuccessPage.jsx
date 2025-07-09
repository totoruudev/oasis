import React, { useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import axios from "axios";

export default function OrderSuccessPage() {
    const location = useLocation();
    const navigate = useNavigate();

    useEffect(() => {
        const search = new URLSearchParams(location.search);
        const paymentKey = search.get("paymentKey");
        const orderId = search.get("orderId");
        const amount = Number(search.get("amount"));

        // 결제 정보가 없으면 에러 처리
        if (!paymentKey || !orderId || !amount) {
            alert("잘못된 접근입니다.");
            navigate("/order/checkout");
            return;
        }

        // 결제 검증 요청
        axios.post("/api/orders/confirm", {
            paymentKey,
            orderId,
            amount
        }, { withCredentials: true })
            .then(res => {
                // 주문 완료 페이지로 이동
                navigate(`/order/complete?orderId=${orderId}`);
            })
            .catch(err => {
                alert("결제 확인에 실패했습니다.");
                navigate("/order/checkout");
            });
    }, [location, navigate]);

    return (
        <div className="container py-5 text-center">
            <h2 className="mb-4">결제 검증 중입니다...</h2>
            <div className="spinner-border text-success" role="status">
                <span className="visually-hidden">Loading...</span>
            </div>
        </div>
    );
}
