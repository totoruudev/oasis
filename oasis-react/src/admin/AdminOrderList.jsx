import React, { useEffect, useState } from "react";
import axios from "axios";

export default function AdminOrderList() {
    const [orders, setOrders] = useState([]);
    const [page, setPage] = useState(0);
    const [totalPages, setTotalPages] = useState(1);

    useEffect(() => {
        fetchOrders(page);
    }, [page]);

    function fetchOrders(pageNum) {
        axios.get(`/api/admin/orders?page=${pageNum}&size=10`, { withCredentials: true })
            .then(res => {
                setOrders(res.data.content);
                setTotalPages(res.data.totalPages);
            });
    }

    function handleStatusChange(id, status) {
        axios.patch(`/api/admin/orders/${id}/status`, { status }, { withCredentials: true })
            .then(() => fetchOrders(page));
    }

    return (
        <div className="container my-4">
            <h2>주문 관리</h2>
            <table className="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>주문번호</th>
                        <th>회원</th>
                        <th>금액</th>
                        <th>상태</th>
                        <th>주문일</th>
                        <th>변경</th>
                    </tr>
                </thead>
                <tbody>
                    {orders.map(order =>
                        <tr key={order.id}>
                            <td>{order.id}</td>
                            <td>{order.username}</td>
                            <td>{order.totalAmount.toLocaleString()}</td>
                            <td>{order.status}</td>
                            <td>{order.createdAt && order.createdAt.replace("T", " ").substring(0, 16)}</td>
                            <td>
                                <select
                                    value={order.status}
                                    onChange={e => handleStatusChange(order.id, e.target.value)}
                                    className="form-select"
                                >
                                    <option value="결제완료">결제완료</option>
                                    <option value="상품준비중">상품준비중</option>
                                    <option value="배송중">배송중</option>
                                    <option value="배송완료">배송완료</option>
                                    <option value="취소">취소</option>
                                </select>
                            </td>
                        </tr>
                    )}
                </tbody>
            </table>
            <div className="d-flex justify-content-center">
                <button className="btn btn-outline-secondary mx-1" disabled={page === 0} onClick={() => setPage(page - 1)}>이전</button>
                <span className="mx-2">{page + 1} / {totalPages}</span>
                <button className="btn btn-outline-secondary mx-1" disabled={page + 1 >= totalPages} onClick={() => setPage(page + 1)}>다음</button>
            </div>
        </div>
    );
}
