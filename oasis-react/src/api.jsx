import axios from "axios";

const axiosInstance = axios.create({
    withCredentials: true,
    // baseURL: "/api", // 필요한 경우 기본 경로 지정
});

// 1. 내 정보 조회 (로그인한 유저)
export const getUserInfo = () => axiosInstance.get("/api/users/my");

// 2. 찜한 상품 목록 조회
export const getWishlist = () => axiosInstance.get("/api/wishlist");

// 3. 내가 쓴 리뷰 목록 조회
export const getReviewList = () => axiosInstance.get("/api/reviews/my");

// 4. 주문내역 조회
export const getOrderList = () => axiosInstance.get("/api/orders/my");

// 5. 내 배송지 목록
export const getAddressList = () => axiosInstance.get("/api/addresses/my");

// 6. 내 1:1 문의내역
export const getQnaList = () => axiosInstance.get("/api/qnas/my");

// === 회원정보 수정 ===
export const updateUserInfo = (data) => axiosInstance.put("/api/users/my", data);