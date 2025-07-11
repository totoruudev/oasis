import React, { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

export default function AdminProductList() {
    const [products, setProducts] = useState([]);
    const [categories, setCategories] = useState([]);
    const [subCategories, setSubCategories] = useState([]);
    const [categoryId, setCategoryId] = useState("");
    const [subCategoryId, setSubCategoryId] = useState("");
    const navigate = useNavigate();

    // 카테고리, 서브카테고리 불러오기
    useEffect(() => {
        axios.get("/api/admin/categories").then(res => setCategories(res.data));
    }, []);
    useEffect(() => {
        if (categoryId) {
            axios.get("/api/admin/subcategories", { params: { categoryId } })
                .then(res => setSubCategories(res.data));
        } else {
            setSubCategories([]);
            setSubCategoryId("");
        }
    }, [categoryId]);

    // 상품 불러오기(필터 적용)
    useEffect(() => {
        let url = "/api/admin/products";
        const params = {};
        if (categoryId) params.categoryId = categoryId;
        if (subCategoryId) params.subCategoryId = subCategoryId;
        axios.get(url, { params, withCredentials: true })
            .then(res => setProducts(res.data.content || res.data)); // Page일 경우 .content
    }, [categoryId, subCategoryId]);

    const getProductImageUrl = (filename) =>
        filename
            ? `/images/products/${filename}`
            : "/default_thumb.jpg";

    // 할인가 계산 함수
    const getDiscounted = (price, percent) => Math.floor(price * (1 - percent / 100) / 100) * 100;

    return (
        <div className="container py-4">
            <div className="d-flex justify-content-between align-items-center mb-3">
                <div className="d-flex gap-2">
                    <select className="form-select" style={{ width: 140 }}
                        value={categoryId} onChange={e => setCategoryId(e.target.value)}>
                        <option value="">카테고리 전체</option>
                        {categories.map(c => <option value={c.id} key={c.id}>{c.name}</option>)}
                    </select>
                    <select className="form-select" style={{ width: 160 }}
                        value={subCategoryId} onChange={e => setSubCategoryId(e.target.value)} disabled={!subCategories.length}>
                        <option value="">서브카테고리 전체</option>
                        {subCategories.map(sc => <option value={sc.id} key={sc.id}>{sc.name}</option>)}
                    </select>
                </div>
                <button className="btn btn-success" onClick={() => navigate("/admin/productform")}>상품 추가</button>
            </div>
            <table className="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>썸네일</th>
                        <th>카테고리</th>
                        <th>서브카테고리</th>
                        <th>상품명</th>
                        <th>원가</th>
                        <th>할인율</th>
                        <th>할인가</th>
                        <th>등록일</th>
                        <th>수정일</th>
                    </tr>
                </thead>
                <tbody>
                    {products.map(p => (
                        <tr key={p.id} style={{ cursor: "pointer" }} onClick={() => navigate(`/admin/products/${p.id}`)}>
                            <td><img src={getProductImageUrl(p.thumbnailimg)} alt="썸네일" style={{ width: 60, height: 60, objectFit: "cover", borderRadius: 8 }} /></td>
                            <td>{p.categoryName}</td>
                            <td>{p.subCategoryName}</td>
                            <td>{p.name}</td>
                            <td>{p.price.toLocaleString()}원</td>
                            <td>{p.percent}%</td>
                            <td>{getDiscounted(p.price, p.percent).toLocaleString()}원</td>
                            <td>{p.createdAt && p.createdAt.split("T")[0]}</td>
                            <td>{p.updatedAt && p.updatedAt.split("T")[0]}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}
