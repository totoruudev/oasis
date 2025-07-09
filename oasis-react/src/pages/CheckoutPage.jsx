import React, { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import DaumPostcode from "react-daum-postcode";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";

export default function CheckoutPage() {
    const location = useLocation();
    const navigate = useNavigate();
    const items = location.state?.items || [];

    // 주문자/배송지 정보
    const [receiver, setReceiver] = useState("");
    const [phone, setPhone] = useState("");
    const [address, setAddress] = useState("");
    const [addressDetail, setAddressDetail] = useState("");
    const [showAddressModal, setShowAddressModal] = useState(false);
    const [loadingAddress, setLoadingAddress] = useState(false);

    // 결제수단 상태
    const [paymentMethod, setPaymentMethod] = useState("TOSS");

    const totalPrice = items.reduce((sum, item) => sum + item.price * item.qty, 0);

    // 결제수단 버튼 클릭 핸들러
    const handleSelectMethod = (method) => {
        if (method === "TOSS") {
            setPaymentMethod(method);
        } else {
            alert("아직 지원되지 않는 결제수단입니다.");
        }
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        if (paymentMethod !== "TOSS") {
            alert("아직 지원되지 않는 결제수단입니다.");
            return;
        }
        // 결제 로직 연결
        alert("토스 결제 진행!");
        navigate("/order/complete");
    };

    // const handlePayment = async (e) => {
    //     e.preventDefault();

    //     // 1. 주문 정보 서버로 전송
    //     const prepareRes = await axios.post("/api/orders/prepare", { ... });

    //     // 2. 응답값으로 Toss 결제창 호출
    //     const { orderId, amount, orderName, customerName } = prepareRes.data;
    //     const tossPayments = window.TossPayments(process.env.REACT_APP_TOSS_CLIENT_KEY);

    //     await tossPayments.requestPayment("카드", {
    //         amount,
    //         orderId,
    //         orderName,
    //         customerName,
    //         successUrl: `${window.location.origin}/order/success`,
    //         failUrl: `${window.location.origin}/order/fail`
    //     });
    // };


    return (
        <div className="container-fluid" style={{ minHeight: "100vh", background: "#f7f7f9" }}>
            <div className="row justify-content-center">
                {/* 왼쪽: 주문정보 */}
                <div className="col-lg-7 col-md-12 py-5">
                    <form onSubmit={handleSubmit}>
                        {/* 1. 주문자/배송지 */}
                        <div className="mb-4 bg-white rounded-4 shadow-sm p-4">
                            <h5 className="fw-bold mb-3">주문자 / 배송지 정보</h5>
                            <div className="row g-2">
                                <div className="col-md-6">
                                    <label className="form-label">이름</label>
                                    <input className="form-control" required value={receiver} onChange={e => setReceiver(e.target.value)} />
                                </div>
                                <div className="col-md-6">
                                    <label className="form-label">연락처</label>
                                    <input className="form-control" required value={phone} onChange={e => setPhone(e.target.value)} />
                                </div>
                                <div className="mb-3">
                                    <label className="form-label">주소</label>
                                    <div style={{ display: "flex", gap: "8px", minHeight: 49 }}>
                                        <input
                                            type="text"
                                            className="form-control"
                                            value={address}
                                            readOnly
                                            placeholder="주소 찾기를 클릭하세요"
                                            style={{ flex: 1, cursor: "pointer", background: "#fafcfa" }}
                                            onClick={() => setShowAddressModal(true)}
                                        />
                                        <button
                                            type="button"
                                            className="btn btn-outline-success"
                                            onClick={() => setShowAddressModal(true)}
                                            style={{ height: 48 }}
                                        >
                                            주소찾기
                                        </button>
                                    </div>
                                    <input
                                        type="text"
                                        className="form-control"
                                        value={addressDetail}
                                        onChange={e => setAddressDetail(e.target.value)}
                                        placeholder="상세주소 (예: 아파트, 동/호수 등)"
                                        style={{ marginTop: "2px" }}
                                    />
                                    {showAddressModal && (
                                        <div
                                            style={{
                                                position: "fixed",
                                                top: 0, left: 0, right: 0, bottom: 0,
                                                background: "rgba(0,0,0,0.32)",
                                                zIndex: 10000,
                                                display: "flex", alignItems: "center", justifyContent: "center"
                                            }}>
                                            <div style={{
                                                background: "#fff",
                                                borderRadius: 10,
                                                boxShadow: "0 4px 24px 0 rgba(0,0,0,0.10)",
                                                padding: 16,
                                                width: "95vw",
                                                maxWidth: 620,
                                            }}>
                                                <DaumPostcode
                                                    onComplete={data => {
                                                        setAddress(data.address); // 선택한 주소
                                                        setShowAddressModal(false); // 모달 닫기
                                                    }}
                                                    autoClose
                                                />
                                                <button
                                                    type="button"
                                                    className="btn btn-light mt-2"
                                                    style={{ float: "right" }}
                                                    onClick={() => setShowAddressModal(false)}
                                                >닫기</button>
                                            </div>
                                        </div>
                                    )}

                                </div>

                            </div>
                        </div>
                        {/* 2. 주문 상품정보 */}
                        <div className="mb-4 bg-white rounded-4 shadow-sm p-4">
                            <h5 className="fw-bold mb-3">주문 상품</h5>
                            <ul className="list-group list-group-flush">
                                {items.map(item => (
                                    <li className="list-group-item d-flex align-items-center" key={item.id}>
                                        <img
                                            src={`http://localhost:8094/images/products/${item.thumbnailimg || "default_thumb.jpg"}`}
                                            alt={item.name}
                                            width={100}
                                            height={100}
                                            style={{ objectFit: "cover", borderRadius: "12px", marginRight: 15, border: "1px solid #eee" }}
                                        />
                                        <div className="flex-grow-1">
                                            <div className="fw-semibold">{item.name}</div>
                                            <div className="small text-muted">수량: {item.qty}</div>
                                        </div>
                                        <div className="fw-bold">{(item.price * item.qty).toLocaleString()}원</div>
                                    </li>
                                ))}
                            </ul>
                        </div>
                        {/* 3. 결제수단 - 버튼 방식 */}
                        <div className="mb-4 bg-white rounded-4 shadow-sm p-4">
                            <h5 className="fw-bold mb-3">결제수단</h5>
                            <div className="d-flex gap-3">
                                <button
                                    type="button"
                                    className="btn btn-outline-secondary fw-bold flex-fill py-2"
                                    onClick={() => handleSelectMethod("CARD")}
                                    style={{ fontSize: "1rem" }}
                                >
                                    신용/체크카드
                                </button>
                                <button
                                    type="button"
                                    className="btn btn-outline-secondary fw-bold flex-fill py-2"
                                    onClick={() => handleSelectMethod("NAVERPAY")}
                                    style={{ fontSize: "1rem" }}
                                >
                                    네이버페이
                                </button>
                                <button
                                    type="button"
                                    className={`btn btn-outline-success fw-bold flex-fill py-2 ${paymentMethod === "TOSS" ? "active border-2" : ""}`}
                                    onClick={() => handleSelectMethod("TOSS")}
                                    style={{ fontSize: "1rem" }}
                                >
                                    토스페이
                                </button>
                            </div>
                            <div className="small text-muted mt-2">* 현재 토스 결제만 지원됩니다.</div>
                        </div>
                        {/* 모바일 결제버튼 */}
                        <div className="d-lg-none mb-5">
                            <button className="btn btn-success w-100 fw-bold py-3 rounded-4" style={{ fontSize: "1.2rem" }}>
                                {totalPrice.toLocaleString()}원 결제하기
                            </button>
                        </div>
                    </form>
                </div>

                {/* 오른쪽: 결제금액/결제 버튼 고정 */}
                <div className="col-lg-3 d-none d-lg-block position-relative">
                    <div
                        className="shadow-sm rounded-4 bg-white p-4"
                        style={{
                            position: "sticky",
                            top: "220px",
                            zIndex: 10,
                        }}
                    >
                        <div className="mb-3 fw-semibold" style={{ fontSize: "1.08rem" }}>최종 결제금액</div>
                        <div className="mb-4">
                            <span className="fs-2 fw-bold text-success">
                                {totalPrice.toLocaleString()}<span className="fs-5 fw-normal">원</span>
                            </span>
                        </div>
                        <button
                            className="btn btn-success w-100 fw-bold py-3 rounded-4"
                            style={{ fontSize: "1.2rem" }}
                            onClick={handleSubmit}
                            type="button"
                        >
                            결제하기
                        </button>
                        {/* 안전결제, 안내 메시지 등 */}
                        <div className="text-secondary small mt-3">
                            ※ 결제 버튼 클릭 시 주문이 완료됩니다.<br />
                            <span className="text-success fw-bold">토스페이</span>로만 결제 가능합니다.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
