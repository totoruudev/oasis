import { BrowserRouter, Routes, Route, useNavigate } from "react-router-dom";
import { useState, useEffect } from "react";
import "./App.css";
import { getUserInfo, getWishlist, getReviewList } from "./api";

import Header from "./components/Header";
import Footer from "./components/Footer";
import LoginPage from "./pages/User/LoginPage";
import Join from "./pages/User/Join";
import MyPageMain from "./pages/User/MyPageMain";
import Home from "./pages/Home";

function MyPageWrapper() {
  const [user, setUser] = useState(null);
  const [wishlist, setWishlist] = useState([]);
  const [reviewList, setReviewList] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // 비동기 데이터 패칭
    async function fetchData() {
      try {
        const [userRes, wishRes, reviewRes] = await Promise.all([
          getUserInfo(),
          getWishlist(),
          getReviewList(),
        ]);
        setUser(userRes.data);
        setWishlist(wishRes.data);
        setReviewList(reviewRes.data);
      } catch (err) {
        // 로그인 안 된 경우 등
        setUser(null);
        setWishlist([]);
        setReviewList([]);
      } finally {
        setLoading(false);
      }
    }
    fetchData();
  }, []);

  if (loading) return <div className="container my-5">로딩 중...</div>;
  if (!user) return <div className="container my-5">로그인이 필요합니다.</div>;

  return (
    <MyPageMain user={user} wishlist={wishlist} reviewList={reviewList} />
  );
}

export default function App() {
  const [user, setUser] = useState(null);

  // 로그인 성공시 user 정보를 저장
  const handleLoginSuccess = (userData) => {
    setUser(userData); // 로그인 성공 후 받은 user 객체 (role 포함!)
  };

  const handleLogout = () => {
    setUser(null);
  };

  return (
    <BrowserRouter>
      <div className="oasis-container">
        <Header isLoggedIn={!!user} userName={user?.name || ""} onLogout={handleLogout} />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route
            path="/login"
            element={
              <LoginPage onLoginSuccess={handleLoginSuccess} />
            }
          />
          <Route path="/join" element={<Join />} />
          {/* 마이페이지는 Wrapper로 관리 (user, wishlist, reviewList 전달) */}
          <Route path="/mypage" element={<MyPageWrapper />} />

          {/* <Route path="/ㅇㅇㅇ" element={<ㅇㅇㅇ />} /> */}
        </Routes>
        <Footer />
      </div>
    </BrowserRouter>
  );
}