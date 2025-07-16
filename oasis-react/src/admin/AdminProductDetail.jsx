import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";

export default function AdminProductDetail() {
    const { id } = useParams();
    const navigate = useNavigate();
    const [product, setProduct] = useState(null);

    useEffect(() => {
        axios.get(`/api/admin/products/${id}`, { withCredentials: true })
            .then(res => setProduct(res.data))
            .catch(err => {
                alert("상품 정보를 불러오지 못했습니다.");
                navigate("/admin/products");
            });
    }, [id, navigate]);

    const getProductImageUrl = (filename) =>
        filename ? `/images/products/${filename}` : "/default_thumb.jpg";

    const getDiscounted = (price, percent) =>
        Math.floor(price * (1 - percent / 100) / 100) * 100;

    if (!product) return <div className="container py-5 text-center">불러오는 중...</div>;

    return (
        <div className="container py-5">
            <h3 className="mb-4 fw-bold">상품 상세</h3>
            <div className="row">
                <div className="col-md-4 text-center">
                    <img
                        src={getProductImageUrl(product.thumbnailimg)}
                        alt="상품 썸네일"
                        className="img-fluid rounded"
                        style={{ maxHeight: 250, objectFit: "cover" }}
                    />
                    <div className="mt-3">
                        <img
                            src={getProductImageUrl(product.detailimg)}
                            alt="상세 이미지"
                            className="img-fluid rounded"
                        />
                    </div>
                </div>
                <div className="col-md-8">
                    <table className="table table-bordered">
                        <tbody>
                            <tr>
                                <th>카테고리</th>
                                <td>{product.categoryName}</td>
                            </tr>
                            <tr>
                                <th>서브카테고리</th>
                                <td>{product.subCategoryName}</td>
                            </tr>
                            <tr>
                                <th>상품명</th>
                                <td>{product.name}</td>
                            </tr>
                            <tr>
                                <th>가격</th>
                                <td>{product.price.toLocaleString()}원</td>
                            </tr>
                            <tr>
                                <th>할인율</th>
                                <td>{product.percent}%</td>
                            </tr>
                            <tr>
                                <th>할인가</th>
                                <td>{getDiscounted(product.price, product.percent).toLocaleString()}원</td>
                            </tr>
                            <tr>
                                <th>등록일</th>
                                <td>{product.createdAt?.split("T")[0]}</td>
                            </tr>
                            <tr>
                                <th>수정일</th>
                                <td>{product.updatedAt?.split("T")[0]}</td>
                            </tr>
                        </tbody>
                    </table>
                    <div className="d-flex gap-2 mt-3">
                        <button className="btn btn-outline-secondary" onClick={() => navigate("/admin/products")}>목록으로</button>
                        <button className="btn btn-primary" onClick={() => navigate(`/admin/productform?id=${product.id}`)}>수정하기</button>
                    </div>
                </div>
            </div>
        </div>
    );
}
