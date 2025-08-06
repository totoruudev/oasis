import axios from "axios";

// ✅ 인증 필요 요청용 인스턴스
const axiosInstance = axios.create({
    baseURL: process.env.REACT_APP_API_BASE_URL,
    withCredentials: true,
});

// ✅ 인증 필요 없는 공개 요청용 인스턴스
const axiosPublic = axios.create({
    baseURL: process.env.REACT_APP_API_BASE_URL,
    withCredentials: false,
});

const chatAPI = axios.create({
    baseURL: `${process.env.REACT_APP_API_BASE_URL}/api/admin/images`,
    headers: {
        'Content-Type': 'application/json',
    },
});

// ====================== 인증 필요 요청들 ======================
export const getUserInfo = () => axiosInstance.get("/api/users/my");
export const logout = () => axiosInstance.post("/api/users/logout");
export const getCart = () => axiosInstance.get("/api/cart");
export const addToCart = (data) => axiosInstance.post("/api/cart", data);
export const updateCartItem = (id, data) => axiosInstance.put(`/api/cart/${id}`, data);
export const removeCartItem = (id) => axiosInstance.delete(`/api/cart/${id}`);
export const clearCart = () => axiosInstance.delete("/api/cart/clear");

// ======================== 공개 요청들 =========================
export const getEventCarousel = () => axiosPublic.get("/api/event/carousel");
export const getRecommendedCategories = () => axiosPublic.get("/api/categories/recommend");
export const getSections = () => axiosPublic.get("/api/products/sections");
export const getSubCategories = () => axiosPublic.get("/api/products/subcategories");

// ======================== 생성형 이미지 =========================
export const generateImage = async (prompt) => {
    const res = await chatAPI.post('/generate', { prompt }, { responseType: 'arraybuffer' });
    return URL.createObjectURL(new Blob([res.data], { type: 'image/png' }));
};
export const editImage = async (formData) => {
    const res = await axios.post(`${process.env.REACT_APP_API_BASE_URL}/api/admin/images/edit`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
        responseType: 'arraybuffer',
    });
    return URL.createObjectURL(new Blob([res.data], { type: 'image/png' }));
};
export const variationImage = async (formData) => {
    const res = await axios.post(`${process.env.REACT_APP_API_BASE_URL}/api/admin/images/variation`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
        responseType: 'arraybuffer',
    });
    return URL.createObjectURL(new Blob([res.data], { type: 'image/png' }));
};

export default axios;