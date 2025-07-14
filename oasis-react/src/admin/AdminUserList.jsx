// src/admin/AdminUserList.jsx
import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import axios from "axios";

export default function AdminUserList() {
    const [users, setUsers] = useState([]);
    const [search, setSearch] = useState("");
    const [page, setPage] = useState(1);
    const [totalPage, setTotalPage] = useState(1);
    const [loading, setLoading] = useState(true);

    // 회원 리스트 조회
    useEffect(() => {
        setLoading(true);
        axios.get("/api/admin/users", { params: { search, page } })
            .then(res => {
                setUsers(res.data.users);
                setTotalPage(res.data.totalPage);
                setLoading(false);
            })
            .catch(() => setLoading(false));
    }, [search, page]);

    // 회원 삭제(탈퇴)
    function handleDelete(userId) {
        if (!window.confirm("정말로 탈퇴시키겠습니까?")) return;
        axios.delete(`/api/admin/users/${userId}`)
            .then(() => setUsers(prev => prev.filter(u => u.id !== userId)));
    }

    return (
        <div className="container py-4">
            <h2 className="mb-4 fw-bold">회원 관리</h2>
            <div className="mb-3 row">
                <div className="col-9 col-sm-10">
                    <input
                        className="form-control"
                        placeholder="이름/아이디/이메일 검색"
                        value={search}
                        onChange={e => setSearch(e.target.value)}
                        onKeyDown={e => e.key === "Enter" && setPage(1)}
                    />
                </div>
                <div className="col-3 col-sm-2">
                    <button className="btn btn-primary w-100" onClick={() => setPage(1)}>
                        검색
                    </button>
                </div>
            </div>

            <div className="table-responsive">
                <table className="table table-bordered align-middle text-center">
                    <thead className="table-light">
                        <tr>
                            <th>#</th>
                            <th>이름</th>
                            <th>아이디</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>가입일</th>
                            <th>상세</th>
                            <th>탈퇴</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={8}>로딩중...</td></tr>
                        ) : users.length === 0 ? (
                            <tr><td colSpan={8}>회원이 없습니다.</td></tr>
                        ) : users.map(user => (
                            <tr key={user.id}>
                                <td>{user.id}</td>
                                <td>{user.name}</td>
                                <td>{user.username}</td>
                                <td>{user.email}</td>
                                <td>{user.tel}</td>
                                <td>{user.createdAt?.substring(0, 10)}</td>
                                <td>
                                    <Link to={`/admin/users/${user.id}`} className="btn btn-outline-secondary btn-sm">
                                        상세
                                    </Link>
                                </td>
                                <td>
                                    <button className="btn btn-outline-danger btn-sm" onClick={() => handleDelete(user.id)}>
                                        탈퇴
                                    </button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            {/* 페이지네이션 */}
            <div className="d-flex justify-content-center my-3">
                <nav>
                    <ul className="pagination mb-0">
                        <li className={`page-item${page === 1 ? " disabled" : ""}`}>
                            <button className="page-link" onClick={() => setPage(p => Math.max(1, p - 1))}>&laquo;</button>
                        </li>
                        {[...Array(totalPage)].map((_, i) => (
                            <li key={i + 1} className={`page-item${page === i + 1 ? " active" : ""}`}>
                                <button className="page-link" onClick={() => setPage(i + 1)}>{i + 1}</button>
                            </li>
                        ))}
                        <li className={`page-item${page === totalPage ? " disabled" : ""}`}>
                            <button className="page-link" onClick={() => setPage(p => Math.min(totalPage, p + 1))}>&raquo;</button>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    );
}
