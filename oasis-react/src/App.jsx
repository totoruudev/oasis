import { BrowserRouter, Routes, Route } from "react-router-dom";
import "./App.css";

import Header from "./components/Header";
import Footer from "./components/Footer";

import Home from "./pages/Home";

export default function App() {
  return (
    <BrowserRouter>
      <Header />
      <Routes>
        <Route path="/" element={<Home />} />

        {/* <Route path="/ㅇㅇㅇ" element={<ㅇㅇㅇ />} /> */}
      </Routes>
      <Footer />
    </BrowserRouter>
  )
}
