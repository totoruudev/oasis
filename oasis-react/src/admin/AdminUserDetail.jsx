import React, { useEffect, useState } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import axios from "axios";

export default function AdminUserDetail() {
    const { id } = useParams();
    const navigate = useNavigate();
    const [user, setUser] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        axios.get(`/api/admin/users/${id}`)
            .then(res => {
                setUser(res.data);
                setLoading(false);
            })
            .catch(err => {
                alert("유저 정보를 불러올 수 없습니다.");
                setLoading(false);
            });
    }, [id]);

    if (loading) return <div className="text-center my-5">로딩 중...</div>;
    if (!user) return <div className="text-center my-5">회원 정보를 찾을 수 없습니다.</div>;

    return (
        <div className="container py-5" style={{ maxWidth: 500 }}>
            <h3 className="fw-bold mb-4">회원 상세 정보</h3>
            <table className="table">
                <tbody>
                    <tr>
                        <th>회원번호</th>
                        <td>{user.id}</td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>{user.name}</td>
                    </tr>
                    <tr>
                        <th>아이디</th>
                        <td>{user.username}</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>{user.email}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>{user.tel}</td>
                    </tr>
                    <tr>
                        <th>가입일</th>
                        <td>{user.createdAt ? user.createdAt.substring(0, 10) : ""}</td>
                    </tr>
                    <tr>
                        <th>상태</th>
                        <td>{user.status || "정상"}</td>
                    </tr>
                </tbody>
            </table>
            <div className="d-flex gap-2">
                <button
                    className="btn btn-secondary"
                    onClick={() => navigate(-1)}
                >뒤로가기</button>
                <Link
                    to={`/admin/users`}
                    className="btn btn-outline-primary"
                >목록</Link>
            </div>
        </div>
    );
}
