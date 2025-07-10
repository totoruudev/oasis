import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";

function getOrderStatusKor(status) {
    switch (status) {
        case "PAID":
            return "결제 완료";
        case "READY":
            return "상품 준비중";
        case "DELIVERING":
            return "배송중";
        case "DELIVERED":
            return "배송완료";
        case "CANCELED":
            return "취소됨";
        default:
            return status || "-";
    }
}

export default function MyOrdersPage() {
    const [orders, setOrders] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState("");

    useEffect(() => {
        async function fetchOrders() {
            setLoading(true);
            try {
                const res = await fetch("/api/orders/list", {
                    credentials: "include"
                });
                if (!res.ok) throw new Error("주문 정보를 불러올 수 없습니다.");
                const data = await res.json();
                setOrders(data);
            } catch (e) {
                setError(e.message);
            } finally {
                setLoading(false);
            }
        }
        fetchOrders();
    }, []);

    if (loading) return <div className="text-center py-5">로딩 중...</div>;
    if (error) return <div className="alert alert-danger">{error}</div>;
    if (!orders.length) return <div className="text-center py-5">주문 내역이 없습니다.</div>;

    return (
        <div className="container py-4">
            <h2 className="fw-bold mb-4">주문 내역</h2>
            <div className="table-responsive">
                <table className="table table-bordered align-middle text-center">
                    <thead className="table-light">
                        <tr>
                            <th>주문번호</th>
                            <th>주문일자</th>
                            <th>결제금액</th>
                            <th>배송상태</th>
                            <th>주문상품</th>
                            <th>상세보기</th>
                        </tr>
                    </thead>
                    <tbody>
                        {orders.map((order) => (
                            <tr key={order.id || order.orderId}>
                                <td>{order.orderId || order.id}</td>
                                <td>{order.createdAt?.substring(0, 10)}</td>
                                <td>
                                    {order.totalAmount? order.totalAmount.toLocaleString()
                                        : order.amount? order.amount.toLocaleString()
                                        : "-"}원
                                </td>
                                <td>
                                    {getOrderStatusKor(order.deliveryStatus || order.status)}
                                </td>
                                <td className="text-start">
                                    {order.items?.map(item => (
                                        <div key={item.id} className="small">
                                            {item.productName} x {item.quantity}
                                        </div>
                                    ))}
                                </td>
                                <td>
                                    <Link
                                        to={`/mypage/orders/${order.orderId || order.id}`}
                                        className="btn btn-sm btn-outline-success"
                                    >
                                        상세보기
                                    </Link>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
