import React, { useEffect, useState, useCallback } from "react";
import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import "./App.css";

import AdminDashboard from "./admin/AdminDashboard";
import AdminOrderList from "./admin/AdminOrderList";
import RequireAdmin from "./admin/RequireAdmin";
import AdminLayout from "./admin/AdminLayout";
import ChatBox from "./admin/AdminChatBox";
import AdminProductList from "./admin/AdminProductList";
import ProductForm from "./admin/ProductForm";
import AdminUserList from "./admin/AdminUserList";
import AdminUserDetail from "./admin/AdminUserDetail";

import Header from "./components/Header";
import Footer from "./components/Footer";

import Home from "./pages/Home";

import LoginPage from "./pages/User/LoginPage";
import Join from "./pages/User/Join";
import MyPageMain from "./pages/User/MyPageMain";
import MyOrdersPage from "./pages/User/MyOrdersPage";
import MyOrderDetailPage from "./pages/User/MyOrderDetailPage";

import CartPage from './pages/CartPage';

import Chatbot from "./pages/Support/Chatbot";

import ProductList from "./pages/Product/ProductList";
import ProductDetail from "./pages/Product/ProductDetail";
import CheckOutPage from "./pages/CheckoutPage";
import OrderSuccessPage from './pages/OrderSuccessPage';

import SupportMain from "./pages/Support/SupportMain";



function loadUserFromStorage() {
  try {
    const str = localStorage.getItem("user");
    return str ? JSON.parse(str) : null;
  } catch {
    return null;
  }
}

export default function App() {
  const [user, setUser] = useState(loadUserFromStorage());

  useEffect(() => {
    setUser(loadUserFromStorage());
  }, []);

  const handleLogin = useCallback((userData) => {
    localStorage.setItem("user", JSON.stringify(userData));
    setUser(userData);
  }, []);

  const handleLogout = useCallback(() => {
    localStorage.removeItem("user");
    setUser(null);
  }, []);

  return (
    <BrowserRouter>
      <div className="oasis-container">
        {/* Header는 항상 고정 */}
        <Header
          isLoggedIn={!!user}
          userName={user?.username || ""}
          userRole={user?.role}
          onLogout={handleLogout}
        />

        <Routes>

          {/* 일반 사용자용 라우트 */}
          <Route path="/" element={<Home user={user} onLogout={handleLogout} />} />
          <Route path="/login" element={<LoginPage onLogin={handleLogin} />} />
          <Route path="/join" element={<Join />} />
          <Route path="/mypage" element={user ? <MyPageMain user={user} /> : <Navigate to="/login" />} />
          <Route path="/mypage/orders" element={<MyOrdersPage />} />
          <Route path="/mypage/orders/:orderId" element={<MyOrderDetailPage />} />
          <Route path="/cart" element={user ? <CartPage user={user} /> : <Navigate to="/login" />} />
          <Route path="/order/checkout" element={<CheckOutPage />} />
          <Route path="/order/success" element={<OrderSuccessPage />} />
          <Route path="/products" element={<ProductList />} />
          <Route path="/products/:id" element={<ProductDetail />} />
          <Route path="/products/category/:categoryId" element={<ProductList />} />
          <Route path="/support" element={<SupportMain />} />
          <Route path="/chat" element={<Chatbot />} />

          {/* 관리자 전용 라우트 */}
          <Route path="/admin/*" element={
            <RequireAdmin user={user}>
              <AdminLayout />
            </RequireAdmin>
          }>
            <Route index element={<AdminDashboard />} />
            <Route path="*" element={<Navigate to="/admin" />} />
            <Route path="orders" element={<AdminOrderList />} />
            <Route path="products" element={<AdminProductList />} />
            <Route path="productform" element={<ProductForm />} />
            <Route path="users" element={<AdminUserList />} />
            <Route path="users/:id" element={<AdminUserDetail />} />
            <Route path="ai-images" element={<ChatBox />} />
          </Route>
        </Routes>
        <Footer />
      </div>
    </BrowserRouter>
  );
}
