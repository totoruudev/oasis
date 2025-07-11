import React, { useState } from 'react';
import { generateImage, editImage, variationImage } from '../api';

const ChatBox = () => {
    const [prompt, setPrompt] = useState('');
    const [imageUrl, setImageUrl] = useState('');
    const [imageFile, setImageFile] = useState(null);
    const [maskFile, setMaskFile] = useState(null);
    const handleGenerate = async () => {
        const url = await generateImage(prompt);
        setImageUrl(url);
    };
    const handleEdit = async () => {
        const formData = new FormData();
        formData.append('image', imageFile);
        formData.append('mask', maskFile);
        formData.append('prompt', prompt);
        const url = await editImage(formData);
        setImageUrl(url);
    };
    const handleVariation = async () => {
        const formData = new FormData();
        formData.append('image', imageFile);
        const url = await variationImage(formData);
        setImageUrl(url);
    };
    return (
        <div className="container mt-5">
            <h2 className="mb-4">:액자에_담긴_그림: DALL·E 2 이미지 생성기</h2>
            <input
                type="text"
                className="form-control mb-3"
                placeholder="프롬프트 입력"
                value={prompt}
                onChange={(e) => setPrompt(e.target.value)}
            />
            <div className="mb-3">
                <label className="form-label">이미지 파일</label>
                <input
                    type="file"
                    className="form-control"
                    onChange={(e) => setImageFile(e.target.files[0])}
                />
            </div>
            <div className="mb-3">
                <label className="form-label">마스크 파일</label>
                <input
                    type="file"
                    className="form-control"
                    onChange={(e) => setMaskFile(e.target.files[0])}
                />
            </div>
            <div className="d-flex gap-2 mb-4">
                <button className="btn btn-primary" onClick={handleGenerate}>이미지 생성</button>
                <button className="btn btn-warning" onClick={handleEdit}>이미지 편집</button>
                <button className="btn btn-success" onClick={handleVariation}>이미지 변형</button>
            </div>
            {imageUrl && (
                <div>
                    <h5>결과 이미지:</h5>
                    <img src={imageUrl} alt="result" className="img-fluid rounded border" />
                </div>
            )}
        </div>
    );
};
export default ChatBox;