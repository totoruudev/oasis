import { BrowserRouter, Routes, Route } from "react-router-dom";
import "./App.css";

import Header from "./components/Header";
import Footer from "./components/Footer";

import LoginPage from "./pages/User/LoginPage";
import Join from "./pages/User/Join";

import Home from "./pages/Home";

export default function App() {
  return (
    <BrowserRouter>
      <div className="oasis-container">
        <Header />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/join" element={<Join />} />

          {/* <Route path="/ㅇㅇㅇ" element={<ㅇㅇㅇ />} /> */}
        </Routes>
        <Footer />
      </div>
    </BrowserRouter>
  )
}
