import React, { useEffect, useState } from "react";
import axios from "axios";

export default function AdminDashboard() {
    const [summary, setSummary] = useState(null);

    useEffect(() => {
        axios.get("/api/admin/summary", { withCredentials: true })
            .then(res => setSummary(res.data));
    }, []);

    if (!summary) return <div>로딩중...</div>;

    return (
        <div className="container my-4">
            <h2>관리자 대시보드</h2>
            <div className="row g-3 mb-4">
                <div className="col">
                    <div className="card p-3 text-center">
                        <div>회원수</div>
                        <strong>{summary.userCount}</strong>
                    </div>
                </div>
                <div className="col">
                    <div className="card p-3 text-center">
                        <div>상품수</div>
                        <strong>{summary.productCount}</strong>
                    </div>
                </div>
                <div className="col">
                    <div className="card p-3 text-center">
                        <div>주문수</div>
                        <strong>{summary.orderCount}</strong>
                    </div>
                </div>
            </div>
            <div className="row">
                <div className="col-md-6">
                    <h5>최근 주문</h5>
                    <ul className="list-group">
                        {summary.recentOrders.map(o =>
                            <li className="list-group-item" key={o.id}>
                                {o.username} / {o.totalAmount.toLocaleString()}원
                            </li>
                        )}
                    </ul>
                </div>
            </div>
        </div>
    );
}
