import { BrowserRouter, Routes, Route } from "react-router-dom";
import { useState, useEffect, useCallback } from "react";
import "./App.css";
import { getUserInfo, getWishlist, getReviewList, logout } from "./api";

import Header from "./components/Header";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import LoginPage from "./pages/User/LoginPage";
import Join from "./pages/User/Join";
import MyPageMain from "./pages/User/MyPageMain";
import CartPage from './pages/CartPage';
import ProductList from "./pages/Product/ProductList";
import ProductDetail from "./pages/Product/ProductDetail";

function MyPageWrapper({ user, wishlist, reviewList, loading }) {
  if (loading) return <div className="container my-5">로딩 중...</div>;
  if (!user) return <div className="container my-5">로그인이 필요합니다.</div>;
  return <MyPageMain user={user} wishlist={wishlist} reviewList={reviewList} />;
}

// 유저 정보 불러오기 util
function loadUserFromStorage() {
  try {
    const str = localStorage.getItem("user");
    if (!str) return null;
    const obj = JSON.parse(str);
    // 토큰/유저 등 구조 맞게 파싱
    return obj.user ? obj.user : obj;
  } catch {
    return null;
  }
}

export default function App() {
  // 초기값: localStorage에 있으면 로그인상태
  const [user, setUser] = useState(loadUserFromStorage());
  const [wishlist, setWishlist] = useState([]);
  const [reviewList, setReviewList] = useState([]);
  const [loading, setLoading] = useState(false);

  // 유저 정보 및 기타 데이터 재조회
  const fetchUserData = useCallback(async () => {
    setLoading(true);
    try {
      const [userRes, wishRes, reviewRes] = await Promise.all([
        getUserInfo(),
        getWishlist(),
        getReviewList(),
      ]);
      setUser(userRes.data);
      // 로컬스토리지에도 동기화
      localStorage.setItem("user", JSON.stringify(userRes.data));
      setWishlist(wishRes.data);
      setReviewList(reviewRes.data);
    } catch (err) {
      setUser(null);
      localStorage.removeItem("user");
      setWishlist([]);
      setReviewList([]);
      console.error("[App] 유저 데이터 조회 실패:", err, err?.response);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    // 새로고침 시 user가 있으면 검증 or 데이터 동기화
    if (user) {
      fetchUserData();
    }
  }, [user, fetchUserData]);

  // 로그인 성공시(토큰, 유저 등 받아오면) 로컬스토리지에 저장 후 fetch
  const handleLoginSuccess = useCallback((userObj) => {
    localStorage.setItem("user", JSON.stringify(userObj));
    setUser(userObj);
    fetchUserData();
  }, [fetchUserData]);

  // 로그아웃시
  const handleLogout = async () => {
    localStorage.removeItem("user");
    setUser(null);
    setWishlist([]);
    setReviewList([]);
    try {
      await logout();
    } catch (err) {
      console.error("[App] 로그아웃 에러:", err, err?.response);
    }
  };

  return (
    <BrowserRouter>
      <div className="oasis-container">
        <Header isLoggedIn={!!user} userName={user?.username || ""} onLogout={handleLogout} />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/login" element={
            <LoginPage onLoginSuccess={handleLoginSuccess} />
          } />
          <Route path="/join" element={<Join />} />
          <Route path="/mypage" element={
              <MyPageWrapper user={user} wishlist={wishlist} reviewList={reviewList} loading={loading} />
            }
          />
          <Route path="/cart" element={<CartPage />} />
          <Route path="/products" element={<ProductList />} />
          <Route path="/products/category/:categoryId" element={<ProductList />} />
          <Route path="/products/:id" element={<ProductDetail />} />
        </Routes>
        <Footer />
      </div>
    </BrowserRouter>
  );
}
