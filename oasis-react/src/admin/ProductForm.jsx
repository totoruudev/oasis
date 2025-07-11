import React, { useState, useEffect } from "react";
import axios from "axios";
import DallEModal from "../components/DallEModal";
import "./ProductForm.css";

export default function ProductForm({ initialData, onSubmit }) {
    // 상품 정보 state
    const [name, setName] = useState(initialData?.name || "");
    const [categoryId, setCategoryId] = useState(initialData?.category_id || "");
    const [subCategoryId, setSubCategoryId] = useState(initialData?.sub_category_id || "");
    const [categories, setCategories] = useState([]);
    const [subCategories, setSubCategories] = useState([]);
    const [price, setPrice] = useState(initialData?.price || 0);
    const [percent, setPercent] = useState(initialData?.percent || 0);
    const [thumbnailimg, setThumbnailimg] = useState(initialData?.thumbnailimg || "");
    const [detailimg, setDetailimg] = useState(initialData?.detailimg || "");
    const [uploadThumbFile, setUploadThumbFile] = useState(null);
    const [uploadDetailFile, setUploadDetailFile] = useState(null);
    const [imgType, setImgType] = useState("upload");
    const [showModal, setShowModal] = useState(false);

    // 카테고리/서브카테고리 데이터 불러오기 (최초 1회)
    useEffect(() => {
        axios.get("/api/admin/categories").then(res => setCategories(res.data));
    }, []);
    useEffect(() => {
        if (categoryId) {
            axios.get("/api/admin/subcategories", { params: { categoryId } })
                .then(res => setSubCategories(res.data));
        } else {
            setSubCategories([]);
        }
    }, [categoryId]);

    // 썸네일 업로드
    const handleThumbFileChange = e => setUploadThumbFile(e.target.files[0]);
    const handleThumbUpload = async () => {
        if (!uploadThumbFile) return alert("파일을 선택하세요.");
        const formData = new FormData();
        formData.append("file", uploadThumbFile);
        const res = await axios.post("/api/upload", formData, {
            headers: { "Content-Type": "multipart/form-data" }
        });
        setThumbnailimg(res.data.path);
        alert("썸네일 이미지 업로드 성공");
    };

    // 상세 이미지 업로드
    const handleDetailFileChange = e => setUploadDetailFile(e.target.files[0]);
    const handleDetailUpload = async () => {
        if (!uploadDetailFile) return alert("파일을 선택하세요.");
        const formData = new FormData();
        formData.append("file", uploadDetailFile);
        const res = await axios.post("/api/upload", formData, {
            headers: { "Content-Type": "multipart/form-data" }
        });
        setDetailimg(res.data.path);
        alert("상세 이미지 업로드 성공");
    };

    // AI 생성 썸네일 선택
    const handleAIImageSelect = async (blobUrl) => {
        const res = await fetch(blobUrl);
        const blob = await res.blob();
        const file = new File([blob], "ai_generated.png", { type: blob.type });
        const formData = new FormData();
        formData.append("file", file);
        const uploadRes = await axios.post("/api/upload", formData, {
            headers: { "Content-Type": "multipart/form-data" }
        });
        setThumbnailimg(uploadRes.data.path);
        setImgType("ai");
        alert("AI 이미지 업로드 성공!");
    };

    // 등록
    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!name || !categoryId || !subCategoryId || !thumbnailimg || !detailimg) {
            alert("모든 필수 항목을 입력하세요!");
            return;
        }
        const productData = {
            name,
            category_id: categoryId,
            sub_category_id: subCategoryId,
            price,
            percent,
            thumbnailimg,
            detailimg,
        };
        await axios.post("/api/admin/products", productData);
        alert("상품 등록 완료!");
        if (onSubmit) onSubmit();
    };

    return (
        <form onSubmit={handleSubmit} className="product-form-wrapper">
            <h2>상품 등록</h2>
            <div className="mb-3">
                <label>상품명</label>
                <input className="form-control" value={name} onChange={e => setName(e.target.value)} required />
            </div>
            <div className="mb-3 row">
                <div className="col">
                    <label>카테고리</label>
                    <select className="form-select" value={categoryId} onChange={e => setCategoryId(e.target.value)} required>
                        <option value="">선택</option>
                        {categories.map(cat => (
                            <option key={cat.id} value={cat.id}>{cat.name}</option>
                        ))}
                    </select>
                </div>
                <div className="col">
                    <label>서브카테고리</label>
                    <select className="form-select" value={subCategoryId} onChange={e => setSubCategoryId(e.target.value)} required>
                        <option value="">선택</option>
                        {subCategories.map(sub => (
                            <option key={sub.id} value={sub.id}>{sub.name}</option>
                        ))}
                    </select>
                </div>
            </div>
            <div className="mb-3 row">
                <div className="col">
                    <label>원가</label>
                    <input className="form-control" type="number" value={price} onChange={e => setPrice(Number(e.target.value))} required />
                </div>
                <div className="col">
                    <label>할인율(%)</label>
                    <input className="form-control" type="number" value={percent} onChange={e => setPercent(Number(e.target.value))} min={0} max={100}/>
                </div>
            </div>

            {/* 썸네일 이미지 업로드 */}
            <div className="mb-3 ai-section">
                <label>썸네일 이미지 선택</label>
                <div className="form-check">
                    <input className="form-check-input" type="radio" name="imgType" value="upload"
                        checked={imgType === "upload"} onChange={() => setImgType("upload")} id="imgUploadRadio"/>
                    <label className="form-check-label" htmlFor="imgUploadRadio">파일 직접 업로드</label>
                </div>
                <div className="form-check">
                    <input className="form-check-input" type="radio" name="imgType" value="ai"
                        checked={imgType === "ai"} onChange={() => setImgType("ai")} id="imgAIRadio"/>
                    <label className="form-check-label" htmlFor="imgAIRadio">AI 이미지 생성(DALL·E)</label>
                </div>
                {imgType === "upload" && (
                    <div className="mt-2">
                        <input className="form-control" type="file" accept="image/*" onChange={handleThumbFileChange} />
                        <button type="button" className="btn btn-secondary mt-2" onClick={handleThumbUpload}>썸네일 업로드</button>
                        {thumbnailimg && (
                            <div className="mt-2">
                                <img src={thumbnailimg} alt="썸네일 미리보기" className="preview-img" />
                            </div>
                        )}
                    </div>
                )}
                {imgType === "ai" && (
                    <div className="mt-2">
                        <button type="button" className="btn btn-primary" onClick={() => setShowModal(true)}>
                            AI 이미지 생성하기
                        </button>
                        {thumbnailimg && (
                            <div className="mt-2">
                                <img src={thumbnailimg} alt="AI 썸네일" className="preview-img" />
                            </div>
                        )}
                    </div>
                )}
            </div>

            {/* 상세 이미지 업로드 */}
            <div className="mb-3 ai-section">
                <label>상세 이미지 업로드</label>
                <input className="form-control" type="file" accept="image/*" onChange={handleDetailFileChange} />
                <button type="button" className="btn btn-secondary mt-2" onClick={handleDetailUpload}>상세 이미지 업로드</button>
                {detailimg && (
                    <div className="mt-2">
                        <img src={detailimg} alt="상세 미리보기" className="preview-img" />
                    </div>
                )}
            </div>

            <div className="d-flex justify-content-center">
                <button type="submit" className="btn btn-success">상품 등록</button>
            </div>

            {/* DALL-E 모달 */}
            {showModal && (
                <DallEModal
                    show={showModal}
                    onClose={() => setShowModal(false)}
                    onSelect={handleAIImageSelect}
                />
            )}
        </form>
    );
}
