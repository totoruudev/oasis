import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";
import "./LoginPage.css";

axios.defaults.withCredentials = true;

export default function LoginPage({ onLogin }) {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [error, setError] = useState("");
    const navigate = useNavigate();

    const handleLogin = async (e) => {
        e.preventDefault();
        setError("");
        try {
            const res = await axios.post(
                "/api/users/login",
                { username, password },
                { withCredentials: true }
            );

            localStorage.setItem("user", JSON.stringify(res.data));
            
            // 👇 로그인 성공 직후 바로 유저정보 fetch!
            fetch("/api/users/my", { credentials: "include" })
            .then(res => res.json())
            .then(data => {
                console.log("[로그인 후 내 정보]", data);
            });

            if (onLogin) onLogin(res.data);
            navigate("/", { replace: true });

        } catch (err) {
            setError("아이디 또는 비밀번호를 다시 확인해 주세요.");
        }
    };


    return (
        <div className="container login-page">
            <div className="login-wrap row justify-content-center">
                <div className="col-12 col-sm-8 col-md-5 col-lg-4">
                    <div className="login-box">
                        <h2 className="login-title mb-4">로그인</h2>
                        <form onSubmit={handleLogin}>
                            <div className="mb-3">
                                <div className="input-group">
                                    <span className="input-group-text bg-white border-end-0">
                                        <svg width="18" height="18" fill="none" stroke="#999" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" viewBox="0 0 24 24">
                                            <circle cx="12" cy="7" r="4" />
                                            <path d="M6 21v-2a6 6 0 0 1 12 0v2" />
                                        </svg>
                                    </span>
                                    <input
                                        type="text"
                                        className="form-control border-start-0"
                                        placeholder="아이디를 입력해 주세요."
                                        value={username}
                                        onChange={e => setUsername(e.target.value)}
                                        autoComplete="username"
                                        required
                                    />
                                </div>
                            </div>
                            <div className="mb-3">
                                <div className="input-group">
                                    <span className="input-group-text bg-white border-end-0">
                                        <svg width="18" height="18" fill="none" stroke="#999" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" viewBox="0 0 24 24">
                                            <rect x="3" y="11" width="18" height="10" rx="2" />
                                            <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                                        </svg>
                                    </span>
                                    <input
                                        type="password"
                                        className="form-control border-start-0"
                                        placeholder="비밀번호를 입력해 주세요."
                                        value={password}
                                        onChange={e => setPassword(e.target.value)}
                                        autoComplete="current-password"
                                        required
                                    />
                                </div>
                            </div>
                            <div className="d-flex align-items-center mb-3 justify-content-between">
                                <div className="form-check">
                                    <input className="form-check-input" type="checkbox" id="rememberId" />
                                    <label className="form-check-label" htmlFor="rememberId">
                                        아이디 저장
                                    </label>
                                </div>
                                <div>
                                    <Link to="/find-id" className="text-muted me-2">아이디 찾기</Link>
                                    <Link to="/reset-password" className="text-muted">비밀번호 찾기</Link>
                                </div>
                            </div>
                            {/* 로그인 버튼 */}
                            <button
                                type="submit"
                                className="btn login-main-btn w-100 mb-2"
                            >
                                로그인 하기
                            </button>
                            {/* 회원가입 버튼 */}
                            <div className="join-guide text-center mb-3">
                                <span className="me-2">아직 회원이 아니신가요?</span>
                                <Link to="/join" className="btn login-join-btn ms-1">회원가입</Link>
                            </div>
                            {/* 에러 메시지 */}
                            {error && <div className="alert alert-danger py-2">{error}</div>}
                        </form>
                        {/* 구글 로그인 */}
                        <button className="btn login-google-btn w-100 mb-2">
                            <img src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" alt="구글" style={{ width: 22, marginRight: 8, verticalAlign: 'middle' }} />
                            구글로 로그인
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}
