import axios from "axios";

// ✅ 인증 필요 요청용 인스턴스
const axiosInstance = axios.create({
    baseURL: "http://localhost:8094",
    withCredentials: true,
});

// ✅ 인증 필요 없는 공개 요청용 인스턴스
const axiosPublic = axios.create({
    baseURL: "http://localhost:8094",
    withCredentials: false,
});

// ====================== 인증 필요 요청들 ======================
export const getUserInfo = () => axiosInstance.get("/api/users/my");
export const getWishlist = () => axiosInstance.get("/api/wishlist");
export const getReviewList = () => axiosInstance.get("/api/reviews/my");
export const logout = () => axiosInstance.post("/api/users/logout");

// ====================== 공개 요청들 ======================
export const getEventCarousel = () => axiosPublic.get("/api/event/carousel");
export const getRecommendedCategories = () => axiosPublic.get("/api/categories/recommend");
export const getLatestNotices = () => axiosPublic.get("/api/notices/latest?limit=4");
export const getSections = () => axiosPublic.get("/api/products/sections");
export const getSubCategories = () => axiosPublic.get("/api/products/subcategories");
export const getCart = () => axiosInstance.get("/api/cart");
export const addToCart = (data) => axiosInstance.post("/api/cart", data);
export const updateCartItem = (id, data) => axiosInstance.put(`/api/cart/${id}`, data);
export const removeCartItem = (id) => axiosInstance.delete(`/api/cart/${id}`);
export const clearCart = () => axiosInstance.delete("/api/cart/clear");
