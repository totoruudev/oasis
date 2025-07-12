import React from "react";
import { Link, useNavigate } from "react-router-dom";
import "./Header.css";

export default function Header({ isLoggedIn, userName, userRole, onLogout }) {
  
  const navigate = useNavigate();

  const handleLogoutClick = () => {
    onLogout();
    navigate("/", { replace: true });
  };

  return (
    <header className="header border-bottom bg-white">
      {/* 상단: 로고/유저메뉴 */}
      <div className="container py-2">
        <div className="row align-items-center">
          {/* 좌측: 로고 */}
          <div className="col-auto">
            <Link to="/" className="d-flex align-items-center">
              <img src="/images/components/logo_header_oasis.png" className="logo" alt="OASIS 로고" style={{height: 40}} />
            </Link>
          </div>
          {/* 우측: 유저 메뉴 */}
          <div className="col d-flex justify-content-end align-items-center gap-3">
            {isLoggedIn ? (
              <>
                <span className="user-name">{userName}님</span>
                {userRole === "ADMIN" ? (
                  <Link to="/admin" className="user-menu nav-link d-inline px-1">관리자페이지</Link>
                ) : (
                  <Link to="/mypage" className="user-menu nav-link d-inline px-1">마이페이지</Link>
                )}
                <button
                  className="user-menu logout-btn btn btn-link px-1"
                  style={{ textDecoration: "none" }}
                  onClick={handleLogoutClick}
                >
                  로그아웃
                </button>
                <Link to="/cart" className="user-menu nav-link d-inline px-1">장바구니</Link>
                <Link to="/chat" className="user-menu nav-link d-inline px-1">AI 상담</Link>
              </>
            ) : (
              <>
                <Link to="/login" className="user-menu nav-link d-inline px-1">로그인</Link>
                <Link to="/join" className="user-menu nav-link d-inline px-1">회원가입</Link>
                <Link to="/cart" className="user-menu nav-link d-inline px-1">장바구니</Link>
                <Link to="/chat" className="user-menu nav-link d-inline px-1">AI 상담</Link>
              </>
            )}
          </div>
        </div>
      </div>
      {/* 하단: 네비게이션 */}
      <nav className="header-nav bg-white border-top py-2">
        <div className="container">
          <ul className="nav justify-content-center align-items-center nav-list">
            <li className="nav-item"><Link to="/products/category/1" className="nav-link">오감동</Link></li>
            <li className="nav-item"><Link to="/support" className="nav-link">고객센터</Link></li>
          </ul>
        </div>
      </nav>
    </header>
  );
}
