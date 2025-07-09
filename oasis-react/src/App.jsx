import React, { useEffect, useState, useCallback } from "react";
import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import "./App.css";

import Header from "./components/Header";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import LoginPage from "./pages/User/LoginPage";
import Join from "./pages/User/Join";
import MyPageMain from "./pages/User/MyPageMain";
import CartPage from './pages/CartPage';
import ProductList from "./pages/Product/ProductList";
import ProductDetail from "./pages/Product/ProductDetail";
import CheckOutPage from "./pages/CheckoutPage";

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
          onLogout={handleLogout}
        />

        <Routes>
          <Route path="/" element={<Home user={user} onLogout={handleLogout} />} />
          <Route path="/login" element={<LoginPage onLogin={handleLogin} />} />
          <Route path="/join" element={<Join />} />
          <Route
            path="/mypage"
            element={user ? <MyPageMain user={user} /> : <Navigate to="/login" />}
          />
          <Route
            path="/cart"
            element={user ? <CartPage user={user} /> : <Navigate to="/login" />}
          />
          <Route path="/order/checkout" element={<CheckOutPage />} />
          <Route path="/products" element={<ProductList />} />
          <Route path="/products/:id" element={<ProductDetail />} />
          <Route path="/products/category/:categoryId" element={<ProductList />} />
        </Routes>
        <Footer />
      </div>
    </BrowserRouter>
  );
}
