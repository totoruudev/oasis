import React, { useEffect, useState, useMemo } from "react";
import { useParams, useNavigate, useSearchParams } from "react-router-dom";
import axios from "axios";

export default function AdminProductDetail() {
    // params에서 id 받아오기
    const { id } = useParams();
    const navigate = useNavigate();
    const [product, setProduct] = useState(null);

    // 상품 데이터 로딩
    useEffect(() => {
        if (!id) return;
        axios.get(`/api/admin/products/${id}`, { withCredentials: true })
            .then(res => {
                console.log("[ProductDto 실제 구조]", res.data);
                setProduct(res.data);
            })
            .catch(() => {
                alert("상품 정보를 불러오지 못했습니다.");
                navigate("/admin/products");
            });
    }, [id, navigate]);

    // 이미지 경로 반환 함수
    const getProductImageUrl = (filename) => {
        if (!filename) return "/default_thumb.jpg";
        // 이미 전체 경로로 저장되어 있는 경우 (ex. /uploads/xxx.jpg 또는 /images/products/xxx.jpg)
        if (filename.startsWith("/uploads/") || filename.startsWith("/images/products/")) {
            return filename;
        }
        // 그냥 파일명만 있으면 /images/products/로 접근 (초기 쿼리 상품)
        return `/images/products/${filename}`;
    };

    // 할인가 계산
    const discountedPrice = useMemo(() => {
        if (!product) return null;
        const { price = 0, percent = 0 } = product;
        if (!price) return null;
        if (!percent) return price; // 할인율 0이면 원가 반환
        return Math.floor(price * (1 - percent / 100) / 100) * 100;
    }, [product]);

    // 날짜 포맷팅
    const formatDate = (dateString) => {
        if (!dateString) return "-";
        return dateString.split("T")[0];
    };

    const handleDelete = async () => {
        if (!window.confirm("정말로 이 상품을 삭제하시겠습니까?")) return;
        try {
            await axios.delete(`/api/admin/products/${product.id}`);
            alert("상품이 삭제되었습니다.");
            navigate("/admin/products");
        } catch (err) {
            alert("삭제 실패: " + (err.response?.data?.message || err.message));
        }
    };

    if (!product) {
        return (
            <div className="container py-5 text-center">
                <div className="spinner-border text-secondary mb-3" />
                <div>상품 정보를 불러오는 중...</div>
            </div>
        );
    }

    return (
        <div className="container py-5">
            <h3 className="mb-4 fw-bold">상품 상세</h3>
            <div className="row">
                <div className="col-md-4 text-center mb-4 mb-md-0">
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
                    <table className="table table-bordered align-middle">
                        <tbody>
                            <tr>
                                <th style={{ width: "30%" }}>카테고리</th>
                                <td>{product.categoryName || product.category?.name || "-"}</td>
                            </tr>
                            <tr>
                                <th>서브카테고리</th>
                                <td>{product.subCategoryName || product.subCategory?.name || "-"}</td>
                            </tr>
                            <tr>
                                <th>상품명</th>
                                <td>{product.name || "-"}</td>
                            </tr>
                            <tr>
                                <th>가격</th>
                                <td>{product.price != null ? product.price.toLocaleString() + "원" : "-"}</td>
                            </tr>
                            <tr>
                                <th>할인율</th>
                                <td>{product.percent != null ? `${product.percent}%` : "-"}</td>
                            </tr>
                            <tr>
                                <th>할인가</th>
                                <td>
                                    {discountedPrice != null
                                        ? discountedPrice.toLocaleString() + "원"
                                        : "-"}
                                </td>
                            </tr>
                            <tr>
                                <th>등록일</th>
                                <td>{formatDate(product.createdAt)}</td>
                            </tr>
                            <tr>
                                <th>수정일</th>
                                <td>{formatDate(product.updatedAt)}</td>
                            </tr>
                        </tbody>
                    </table>
                    <div className="d-flex gap-2 mt-3">
                        <button
                            className="btn btn-outline-secondary"
                            onClick={() => navigate("/admin/products")}
                        >
                            목록으로
                        </button>
                        <button
                            className="btn btn-primary"
                            onClick={() => navigate(`/admin/productform?id=${product.id}`)}
                        >
                            수정하기
                        </button>
                        <button
                            className="btn btn-danger"
                            onClick={handleDelete}
                        >
                            삭제하기
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}
