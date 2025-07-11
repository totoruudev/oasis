import React, { useState } from 'react';
import axios from 'axios';

export default function DallEModal({ show, onClose, onSelect }) {
    // 공통 state
    const [mode, setMode] = useState('generate'); // generate | edit | variation
    const [prompt, setPrompt] = useState('');
    const [imageUrl, setImageUrl] = useState('');
    const [loading, setLoading] = useState(false);

    // 파일 state (edit/variation에 사용)
    const [imageFile, setImageFile] = useState(null);
    const [maskFile, setMaskFile] = useState(null);

    // --- 각 기능별 핸들러 ---
    // 1. 이미지 생성
    const handleGenerate = async () => {
        if (!prompt) return alert("프롬프트를 입력하세요.");
        setLoading(true);
        try {
            const res = await axios.post("/api/admin/generate", { prompt }, { responseType: "blob" });
            setImageUrl(URL.createObjectURL(res.data));
        } finally {
            setLoading(false);
        }
    };

    // 2. 이미지 편집 (Edit)
    const handleEdit = async () => {
        if (!imageFile || !maskFile || !prompt) return alert("이미지, 마스크, 프롬프트 모두 필요합니다.");
        setLoading(true);
        try {
            const formData = new FormData();
            formData.append('image', imageFile);
            formData.append('mask', maskFile);
            formData.append('prompt', prompt);
            const res = await axios.post("/api/admin/edit", formData, { responseType: "blob" });
            setImageUrl(URL.createObjectURL(res.data));
        } finally {
            setLoading(false);
        }
    };

    // 3. 이미지 변형 (Variation)
    const handleVariation = async () => {
        if (!imageFile) return alert("원본 이미지를 업로드하세요.");
        setLoading(true);
        try {
            const formData = new FormData();
            formData.append('image', imageFile);
            const res = await axios.post("/api/admin/variation", formData, { responseType: "blob" });
            setImageUrl(URL.createObjectURL(res.data));
        } finally {
            setLoading(false);
        }
    };

    // 이미지 선택(업로드까지 완료)
    const handleSelect = async () => {
        if (!imageUrl) return;
        // blobUrl -> File로 변환해서 서버 업로드 (상품 썸네일 용도)
        const res = await fetch(imageUrl);
        const blob = await res.blob();
        const file = new File([blob], "ai_generated.png", { type: blob.type });
        const formData = new FormData();
        formData.append("file", file);
        const uploadRes = await axios.post("/api/upload", formData, {
            headers: { "Content-Type": "multipart/form-data" }
        });
        onSelect(uploadRes.data.path);
        onClose();
    };

    // 상태 리셋
    const handleClose = () => {
        setPrompt('');
        setImageUrl('');
        setImageFile(null);
        setMaskFile(null);
        setMode('generate');
        onClose();
    };

    // 모달 스타일용 변수 (show/hide)
    const modalClass = `modal fade ${show ? "show d-block" : ""}`;

    return (
        <div className={modalClass} tabIndex="-1" style={{ background: "rgba(0,0,0,0.35)" }}>
            <div className="modal-dialog modal-dialog-centered">
                <div className="modal-content">

                    <div className="modal-header">
                        <h5 className="modal-title">🖼️ DALL·E 이미지 생성기</h5>
                        <button type="button" className="btn-close" onClick={handleClose}></button>
                    </div>

                    <div className="modal-body">
                        <div className="mb-3">
                            <div className="btn-group w-100" role="group">
                                <button
                                    className={`btn btn-outline-primary ${mode === "generate" ? "active" : ""}`}
                                    onClick={() => setMode("generate")}
                                >
                                    이미지 생성
                                </button>
                                <button
                                    className={`btn btn-outline-warning ${mode === "edit" ? "active" : ""}`}
                                    onClick={() => setMode("edit")}
                                >
                                    이미지 편집
                                </button>
                                <button
                                    className={`btn btn-outline-success ${mode === "variation" ? "active" : ""}`}
                                    onClick={() => setMode("variation")}
                                >
                                    이미지 변형
                                </button>
                            </div>
                        </div>

                        {/* 이미지 생성 */}
                        {mode === "generate" && (
                            <>
                                <input
                                    type="text"
                                    className="form-control mb-2"
                                    placeholder="프롬프트 입력"
                                    value={prompt}
                                    onChange={e => setPrompt(e.target.value)}
                                    disabled={loading}
                                />
                                <button className="btn btn-primary w-100 mb-2" onClick={handleGenerate} disabled={loading}>
                                    {loading ? "생성 중..." : "이미지 생성"}
                                </button>
                            </>
                        )}

                        {/* 이미지 편집 */}
                        {mode === "edit" && (
                            <>
                                <input
                                    type="file"
                                    className="form-control mb-2"
                                    accept="image/*"
                                    onChange={e => setImageFile(e.target.files[0])}
                                    disabled={loading}
                                />
                                <input
                                    type="file"
                                    className="form-control mb-2"
                                    accept="image/*"
                                    onChange={e => setMaskFile(e.target.files[0])}
                                    disabled={loading}
                                />
                                <input
                                    type="text"
                                    className="form-control mb-2"
                                    placeholder="프롬프트 입력"
                                    value={prompt}
                                    onChange={e => setPrompt(e.target.value)}
                                    disabled={loading}
                                />
                                <button className="btn btn-warning w-100 mb-2" onClick={handleEdit} disabled={loading}>
                                    {loading ? "편집 중..." : "이미지 편집"}
                                </button>
                            </>
                        )}

                        {/* 이미지 변형 */}
                        {mode === "variation" && (
                            <>
                                <input
                                    type="file"
                                    className="form-control mb-2"
                                    accept="image/*"
                                    onChange={e => setImageFile(e.target.files[0])}
                                    disabled={loading}
                                />
                                <button className="btn btn-success w-100 mb-2" onClick={handleVariation} disabled={loading}>
                                    {loading ? "변형 중..." : "이미지 변형"}
                                </button>
                            </>
                        )}

                        {/* 결과 이미지 */}
                        {imageUrl && (
                            <div className="text-center mt-3">
                                <img src={imageUrl} alt="result" className="img-fluid rounded border" />
                            </div>
                        )}
                    </div>

                    <div className="modal-footer">
                        <button className="btn btn-secondary" onClick={handleClose}>취소</button>
                        <button className="btn btn-success" onClick={handleSelect} disabled={!imageUrl}>
                            이 이미지 선택
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}
