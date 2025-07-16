// AdminCategoryForm.jsx
import React, { useEffect, useState } from "react";
import axios from "axios";

export default function AdminCategoryForm() {
    const [categoryName, setCategoryName] = useState("");
    const [subCategoryName, setSubCategoryName] = useState("");
    const [categories, setCategories] = useState([]);
    const [selectedCategoryId, setSelectedCategoryId] = useState("");

    useEffect(() => {
        axios.get("/api/admin/categories").then(res => setCategories(res.data));
    }, []);

    const handleCategorySubmit = async (e) => {
        e.preventDefault();
        await axios.post("/api/admin/categories", { name: categoryName });
        alert("카테고리 등록 완료");
        setCategoryName("");
        const updated = await axios.get("/api/admin/categories");
        setCategories(updated.data);
    };

    const handleSubCategorySubmit = async (e) => {
        e.preventDefault();
        if (!selectedCategoryId) {
            alert("카테고리를 선택해주세요");
            return;
        }
        await axios.post("/api/admin/categories/sub", {
            name: subCategoryName,
            categoryId: selectedCategoryId,
        });
        alert("서브카테고리 등록 완료");
        setSubCategoryName("");
    };

    return (
        <div className="container mt-5">
            <h3>카테고리 등록</h3>
            <form onSubmit={handleCategorySubmit} className="mb-4">
                <div className="input-group mb-2">
                    <input
                        type="text"
                        className="form-control"
                        placeholder="카테고리명"
                        value={categoryName}
                        onChange={(e) => setCategoryName(e.target.value)}
                    />
                    <button type="submit" className="btn btn-primary">등록</button>
                </div>
            </form>

            <h3>서브카테고리 등록</h3>
            <form onSubmit={handleSubCategorySubmit}>
                <div className="input-group mb-2">
                    <select
                        className="form-select"
                        value={selectedCategoryId}
                        onChange={(e) => setSelectedCategoryId(e.target.value)}
                    >
                        <option value="">카테고리 선택</option>
                        {categories.map(c => (
                            <option key={c.id} value={c.id}>{c.name}</option>
                        ))}
                    </select>
                </div>
                <div className="input-group mb-2">
                    <input
                        type="text"
                        className="form-control"
                        placeholder="서브카테고리명"
                        value={subCategoryName}
                        onChange={(e) => setSubCategoryName(e.target.value)}
                    />
                    <button type="submit" className="btn btn-success">등록</button>
                </div>
            </form>
        </div>
    );
}
