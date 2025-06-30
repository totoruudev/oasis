import { BrowserRouter, Routes, Route } from "react-router-dom";
import { useState, useEffect } from "react";
import "./App.css";
import { getUserInfo, getWishlist, getReviewList, logout } from "./api";

import Header from "./components/Header";
import Footer from "./components/Footer";
import LoginPage from "./pages/User/LoginPage";
import Join from "./pages/User/Join";
import MyPageMain from "./pages/User/MyPageMain";
import Home from "./pages/Home";

// 🚩 마이페이지 Wrapper: 단순히 props만 받아서 렌더링
function MyPageWrapper({ user, wishlist, reviewList, loading }) {
  if (loading) return <div className="container my-5">로딩 중...</div>;
  if (!user) return <div className="container my-5">로그인이 필요합니다.</div>;

  return <MyPageMain user={user} wishlist={wishlist} reviewList={reviewList} />;
}

export default function App() {
  // ⭕ App 최상단에서 모든 유저 데이터 상태 관리
  const [user, setUser] = useState(null);
  const [wishlist, setWishlist] = useState([]);
  const [reviewList, setReviewList] = useState([]);
  const [loading, setLoading] = useState(true);

  // ⭕ 최초 진입 또는 로그인/로그아웃 후에도 재조회
  const fetchUserData = async () => {
    setLoading(true);
    try {
      const [userRes, wishRes, reviewRes] = await Promise.all([
        getUserInfo(),
        getWishlist(),
        getReviewList(),
      ]);
      console.log("userRes.data", userRes.data);
      setUser(userRes.data);
      setWishlist(wishRes.data);
      setReviewList(reviewRes.data);
    } catch (err) {
      setUser(null);
      setWishlist([]);
      setReviewList([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUserData();
  }, []);

  // ⭕ 로그인 성공시, 다시 유저 데이터 조회!
  const handleLoginSuccess = () => {
    fetchUserData();
  };

  // ⭕ 로그아웃시
  const handleLogout = async () => {
  try {
    await logout();
    await fetchUserData();
  } catch {
    setUser(null);
    setWishlist([]);
    setReviewList([]);
  }
};

  return (
    <BrowserRouter>
      <div className="oasis-container">
        <Header isLoggedIn={!!user} userName={user?.name || ""} onLogout={handleLogout} />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/login" element={
            <LoginPage onLoginSuccess={handleLoginSuccess} />
          } />
          <Route path="/join" element={<Join />} />
          <Route
            path="/mypage"
            element={
              <MyPageWrapper
                user={user}
                wishlist={wishlist}
                reviewList={reviewList}
                loading={loading}
              />
            }
          />
        </Routes>
        <Footer />
      </div>
    </BrowserRouter>
  );
}
