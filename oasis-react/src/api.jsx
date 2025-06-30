import axios from "axios";

const axiosInstance = axios.create({
    baseURL: "http://localhost:8094",
    withCredentials: true,
});

// 1. 내 정보 조회 (로그인한 유저)
export const getUserInfo = () => axiosInstance.get("/api/users/my");
export const getWishlist = () => axiosInstance.get("/api/wishlist");
export const getReviewList = () => axiosInstance.get("/api/reviews/my");
export const logout = () => axiosInstance.post("/api/users/logout");

// 4. 주문내역 조회
export const getOrderList = () => axiosInstance.get("/api/orders/my");

// 5. 내 배송지 목록
export const getAddressList = () => axiosInstance.get("/api/addresses/my");

// 6. 내 1:1 문의내역
export const getQnaList = () => axiosInstance.get("/api/qnas/my");

// === 회원정보 수정 ===
export const updateUserInfo = (data) => axiosInstance.put("/api/users/my", data);