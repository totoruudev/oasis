import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import styles from './ProductDetail.module.css';
import axios from "axios";



function getProductImageUrl(path) {
    if (!path) return "/default_thumb.jpg";
    if (path.startsWith("/")) return `http://localhost:8095${path}`;
    return `http://localhost:8095/images/products/${path}`;
}

export default function ProductDetail() {
    const { id } = useParams();
    const [product, setProduct] = useState(null);
    const [qty, setQty] = useState(1);
    const [mainIdx, setMainIdx] = useState(0); // 현재 메인 이미지 인덱스
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();
    const [showCartModal, setShowCartModal] = useState(false);

    useEffect(() => {
        async function fetchProduct() {
            setLoading(true);
            try {
                const res = await fetch(`/api/products/${id}`);
                if (!res.ok) throw new Error("상품 정보를 불러오지 못했습니다.");
                const data = await res.json();
                setProduct(data);
            } catch (e) {
                setProduct(null);
            } finally {
                setLoading(false);
            }
        }
        fetchProduct();
    }, [id]);

    if (loading) return <div className="text-center py-5">Loading...</div>;
    if (!product)
        return (
            <div className="container py-5 text-center text-danger">
                상품 정보를 불러올 수 없습니다.
            </div>
        );

    const salePrice =
        product.percent && product.percent > 0
            ? Math.round(product.price * (1 - product.percent / 100))
            : product.price;

    // 여러 썸네일 배열 지원
    const thumbnails = product.thumbnails && product.thumbnails.length
        ? product.thumbnails
        : [product.thumbnailimg];

    const handleAddToCart = async () => {
        try {
            await axios.post("/api/cart", {
                productId: product.id,
                productName: product.name,
                price: product.price,
                percent: product.percent,
                quantity: qty,
                thumbnailimg: product.thumbnailimg
            }, { withCredentials: true });

            setShowCartModal(true);
        } catch (err) {
            alert("장바구니 담기 실패");
        }
    };

    const handleDirectBuy = () => {
        // 현재 상품 + 수량을 객체로 만들어 배열에 넣어서 state로 전달
        navigate("/order/checkout", { 
            state: { 
                items: [{ 
                    id: product.id,
                    name: product.name,
                    price: salePrice, // 할인 적용가로!
                    qty: qty,
                    thumbnailimg: product.thumbnailimg 
                }]
            }
        });
    };

    return (
        <div className="container py-5" style={{ maxWidth: 1150 }}>
            <div className={styles.wrapper}>
                {/* 좌: 썸네일/서브썸네일 */}
                <div className={styles.leftCol}>
                    {/* 메인 썸네일 */}
                    <div className={styles.mainThumbBox}>
                        <img
                            src={getProductImageUrl(thumbnails[mainIdx])}
                            alt={product.name}
                            className={styles.mainThumb}
                        />
                    </div>
                    {/* 서브썸네일: 우측 세로 정렬 */}
                    <div className={styles.subThumbList}>
                        {thumbnails.map((img, idx) => (
                            <img
                                key={idx}
                                src={getProductImageUrl(img)}
                                alt={`서브썸네일${idx + 1}`}
                                className={`${styles.subThumb} ${mainIdx === idx ? styles.selected : ""}`}
                                onClick={() => setMainIdx(idx)}
                            />
                        ))}
                    </div>
                </div>
                {/* 우: 상품 정보 */}
                <div className={styles.rightCol}>
                    <div>
                        <div className={styles.productTitle}>{product.name}</div>
                        <div className={styles.priceRow}>
                            {product.percent > 0 && <span className={styles.percent}>{product.percent}%</span>}
                            {product.percent > 0 && (
                                <span className={styles.originalPrice}>{product.price.toLocaleString()}원</span>
                            )}
                            <span className={styles.price}>{salePrice.toLocaleString()}원</span>
                        </div>
                    </div>

                    {/* 옵션선택 + 수량 */}
                    <div>
                        <div className="fw-semibold mb-2">옵션선택</div>
                        <div className={styles.optionBox}>
                            <div className={styles.qtyInputBox}>
                                <button className={styles.qtyBtn} onClick={() => setQty(q => Math.max(1, q - 1))}>-</button>
                                <input className={styles.qtyInput} value={qty} readOnly />
                                <button className={styles.qtyBtn} onClick={() => setQty(q => q + 1)}>+</button>
                            </div>
                            <div className={styles.optionPrice}>{(salePrice * qty).toLocaleString()}원</div>
                        </div>
                        <div className={styles.totalRow}>
                            <span>총 상품금액</span>
                            <span className={styles.totalPrice}>{(salePrice * qty).toLocaleString()}원</span>
                        </div>
                    </div>
                    {/* 버튼 */}
                    <div className={styles.btnRow}>
                        <button className={styles.cartBtn} onClick={handleAddToCart}>장바구니</button>
                        {showCartModal && (
                            <div className="modal fade show d-block" tabIndex="-1" style={{ background: "rgba(0,0,0,0.3)" }}>
                                <div className="modal-dialog modal-dialog-centered">
                                    <div className="modal-content">
                                        <div className="modal-header">
                                            <h5 className="modal-title">장바구니 담기 완료</h5>
                                        </div>
                                        <div className="modal-body text-center">
                                            <p>상품이 장바구니에 담겼습니다.</p>
                                        </div>
                                        <div className="modal-footer justify-content-center">
                                            <button className="btn btn-outline-primary"
                                                onClick={() => { setShowCartModal(false); navigate("/cart"); }}>장바구니 보기</button>
                                            <button className="btn btn-success"
                                                onClick={() => { setShowCartModal(false); handleDirectBuy(); }}>바로 결제하기</button>
                                            <button className="btn btn-secondary"
                                                onClick={() => setShowCartModal(false)}>쇼핑 계속하기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        )}
                        <button className={styles.buyBtn} onClick={handleDirectBuy}>구매하기</button>
                    </div>
                </div>
            </div>
            <hr className="my-5" />

            {/* 하단 상세 이미지 */}
            <div className="bg-light rounded-4 p-3 mb-5 text-center">
                <img
                    src={getProductImageUrl(product.detailimg)}
                    alt="상세정보"
                    className="img-fluid"
                    style={{ maxWidth: "700px", width: "100%", borderRadius: "1.5rem" }}
                />
            </div>
        </div>
    );
}
