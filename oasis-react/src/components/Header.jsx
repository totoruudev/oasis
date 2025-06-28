import React from "react";
import { Link } from "react-router-dom";
import "./Header.css";

export default function Header({ isLoggedIn, userName, onLogout }) {
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
                <Link to="/mypage" className="user-menu nav-link d-inline px-1">마이페이지</Link>
                <button className="user-menu logout-btn btn btn-link px-1" style={{textDecoration: 'none'}} onClick={onLogout}>로그아웃</button>
                <Link to="/cart" className="user-menu nav-link d-inline px-1">장바구니</Link>
              </>
            ) : (
              <>
                <Link to="/login" className="user-menu nav-link d-inline px-1">로그인</Link>
                <Link to="/join" className="user-menu nav-link d-inline px-1">회원가입</Link>
                <Link to="/cart" className="user-menu nav-link d-inline px-1">장바구니</Link>
              </>
            )}
          </div>
        </div>
      </div>
      {/* 중단: 검색창 */}
      <div className="container my-2">
        <div className="row justify-content-center">
          <div className="col-12 col-md-8 col-lg-6">
            <form className="search-form d-flex align-items-center" role="search" onSubmit={e => e.preventDefault()}>
              <input
                type="text"
                className="form-control search-input text-center"
                placeholder="바른먹거리를 찾으세요?"
                aria-label="검색"
              />
              <button className="btn search-btn d-flex align-items-center justify-content-center" type="submit">
                {/* SVG 돋보기 아이콘 */}
                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="none" stroke="#78b440" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="feather feather-search" viewBox="0 0 24 24">
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </button>
            </form>
          </div>
        </div>
      </div>
      {/* 하단: 네비게이션 */}
      <nav className="header-nav bg-white border-top py-2">
        <div className="container">
          <ul className="nav justify-content-center align-items-center nav-list">
            <li className="nav-item"><Link to="/products" className="nav-link">오감동</Link></li>
            <li className="nav-item"><Link to="/promotion" className="nav-link">오아시스 톡방</Link></li>
            <li className="nav-item"><Link to="/review" className="nav-link">생생후기</Link></li>
            <li className="nav-item"><Link to="/support" className="nav-link">고객센터</Link></li>
          </ul>
        </div>
      </nav>
    </header>
  );
}
