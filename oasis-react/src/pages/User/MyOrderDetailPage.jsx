import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";

export default function MyOrderDetailPage() {
    const { orderId } = useParams();
    const [order, setOrder] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState("");


    useEffect(() => {
        async function fetchOrder() {
            setLoading(true);
            try {
                const res = await fetch(`/api/orders/${orderId}`, {
                    credentials: "include"
                });
                if (!res.ok) throw new Error("주문 상세 정보를 불러올 수 없습니다.");
                const data = await res.json();
                setOrder(data);
            } catch (e) {
                setError(e.message);
            } finally {
                setLoading(false);
            }
        }
        fetchOrder();
    }, [orderId]);

    if (loading) return <div className="text-center py-5">로딩 중...</div>;
    if (error) return <div className="alert alert-danger">{error}</div>;
    if (!order) return null;

    return (
        <div className="container py-4">
            <h2 className="fw-bold mb-4">주문 상세 내역</h2>
            <div className="mb-3">
                <strong>주문번호:</strong> {order.orderId || order.id} <br />
                <strong>주문일자:</strong> {order.createdAt?.substring(0, 10)} <br />
                <strong>받는분:</strong> {order.name} <br />
                <strong>연락처:</strong> {order.phone} <br />
                <strong>주소:</strong> {order.address}
            </div>
            <div className="table-responsive">
                <table className="table table-bordered align-middle">
                    <thead className="table-light">
                        <tr>
                            <th>상품명</th>
                            <th>수량</th>
                            <th>상품금액</th>
                            <th>주문금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        {order.items?.map(item => {
                            const name = item.productName ?? item.name ?? "-";
                            const price = Number(item.price ?? item.unitPrice ?? 0);
                            const quantity = Number(item.quantity ?? 0);
                            const subtotal = price * quantity;

                            return (
                            <tr key={item.id}>
                                <td>{name}</td>
                                <td>{quantity}</td>
                                <td>{price.toLocaleString()}원</td>
                                <td>{subtotal.toLocaleString()}원</td>
                            </tr>
                            );
                        })}
                    </tbody>
                </table>
            </div>
            <div className="text-end fw-bold fs-5 mt-3">
                총 결제금액: {order.totalAmount
                    ? order.totalAmount.toLocaleString()
                    : order.amount.toLocaleString()}원
            </div>
            <Link to="/mypage/orders" className="btn btn-outline-secondary mt-4">
                주문 목록으로 돌아가기
            </Link>
        </div>
    );
}
