import React, { useState, useEffect } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import axios from "axios";
import DallEModal from "../components/DallEModal";
import "./ProductForm.css";

export default function ProductForm({ onSubmit }) {

    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const id = searchParams.get("id");
    const [initialData, setInitialData] = useState(null);

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

    const MAX_FILE_SIZE = 10 * 1024 * 1024;

    const getOnlyFileName = path => path?.split('/').pop() ?? "";

    const uploadsUrl = "/uploads/";

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

    useEffect(() => {
        if (id) {
            axios.get(`/api/admin/products/${id}`)
                .then(res => {
                    setInitialData(res.data);
                })
                .catch(() => alert("상품 정보를 불러오지 못했습니다."));
        }
    }, [id]);

    useEffect(() => {
        if (initialData) {
            setName(initialData.name || "");
            setCategoryId(
                initialData.categoryId ??
                initialData.category_id ??
                initialData.category?.id ??
                ""
            );
            setSubCategoryId(
                initialData.subCategoryId ??
                initialData.sub_category_id ??
                initialData.subCategory?.id ??
                ""
            );
            setPrice(initialData.price ?? 0);
            setPercent(initialData.percent ?? 0);
            setThumbnailimg(initialData.thumbnailimg || "");
            setDetailimg(initialData.detailimg || "");
        }
    }, [initialData]);


    // 썸네일 업로드
    const handleThumbFileChange = e => {
        const file = e.target.files[0];
        if (!file) return;

        if (file.size > MAX_FILE_SIZE) {
            alert("파일 크기는 10MB를 초과할 수 없습니다.");
            return;
        }

        setUploadThumbFile(file);
    };
    const handleThumbUpload = async () => {
        if (!uploadThumbFile) return alert("파일을 선택하세요.");
        if (uploadThumbFile.size > MAX_FILE_SIZE) {
            alert("파일 크기는 10MB를 초과할 수 없습니다.");
            return;
        }
        const formData = new FormData();

        formData.append("file", uploadThumbFile);

        const res = await axios.post("/api/upload", formData, {
            headers: { "Content-Type": "multipart/form-data" }
        });

        console.log("썸네일 업로드 응답:", res.filename);
        
        setThumbnailimg(`${uploadsUrl}${res.data.filename}`);
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
        setDetailimg(`${uploadsUrl}${res.data.filename}`);
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
        setThumbnailimg(uploadRes.data.filename);
        setImgType("ai");
        alert("AI 이미지 업로드 성공!");
    };

    // 등록
    const handleSubmit = async (e) => {
        e.preventDefault();

        console.log("🔥 name:", name);
        console.log("🔥 categoryId:", categoryId);
        console.log("🔥 subCategoryId:", subCategoryId);
        console.log("🔥 thumbnailimg:", thumbnailimg);
        console.log("🔥 detailimg:", detailimg);

        if (!name || !categoryId || !subCategoryId || !thumbnailimg || !detailimg) {
            alert("모든 필수 항목을 입력하세요!");
            return;
        }
        const productData = {
            name,
            categoryId: Number(categoryId),
            subCategoryId: Number(subCategoryId),
            price,
            percent,
            thumbnailimg: getOnlyFileName(thumbnailimg),
            detailimg: getOnlyFileName(detailimg), 
            description: "",
            active: true
        };
    
        try {
            if (initialData?.id) {
                // 수정
                await axios.put(`/api/admin/products/${initialData.id}`, productData);
                alert("상품 수정 완료!");
            } else {
                // 등록
                await axios.post("/api/admin/products", productData);
                alert("상품 등록 완료!");
            }
            navigate("/admin/products");
            if (onSubmit) onSubmit();
            } catch (err) {
                alert("오류: " + (err.response?.data?.message || err.message));
            }
    };

    if (id && !initialData) return <div className="container py-5 text-center">상품 정보 로딩중...</div>;

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
