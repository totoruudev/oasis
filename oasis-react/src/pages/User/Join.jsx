import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import DaumPostcode from "react-daum-postcode";
import axios from "axios";
import "./Join.css";

export default function Join() {
    const [form, setForm] = useState({
        username: "",
        name: "",
        password: "",
        password2: "",
        tel: "",
        address: "",
        addressDetail: "",
        email: "",
        agreeAll: false,
        agree1: false,
        agree2: false,
        agree3: false,
    });
    const [showAddressModal, setShowAddressModal] = useState(false);
    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");
    const [showModal, setShowModal] = useState(false);
    const [isEmailSent, setIsEmailSent] = useState(false);
    const [isEmailVerified, setIsEmailVerified] = useState(false);
    const [emailCode, setEmailCode] = useState("");
    const [emailCheckMsg, setEmailCheckMsg] = useState("");
    const navigate = useNavigate();

    // 주소 검색 완료시
    const handleComplete = (data) => {
        setForm((prev) => ({
            ...prev,
            address: data.address,
        }));
        setShowAddressModal(false);
    };

    // 체크박스 등 기타 핸들러
    const handleAllAgree = (e) => {
        const checked = e.target.checked;
        setForm((prev) => ({
            ...prev,
            agreeAll: checked,
            agree1: checked,
            agree2: checked,
            agree3: checked,
        }));
    };
    const handleAgree = (e) => {
        const { name, checked } = e.target;
        setForm((prev) => ({
            ...prev,
            [name]: checked,
            agreeAll:
                name === "agreeAll"
                    ? checked
                    : checked && prev.agree1 && prev.agree2 && prev.agree3,
        }));
    };
    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm((prev) => ({ ...prev, [name]: value }));
    };

    // 이메일 인증 메일 발송
    const handleSendEmail = async () => {
        setEmailCheckMsg("");
        setIsEmailSent(false);
        setIsEmailVerified(false);
        if (!form.email) {
            setEmailCheckMsg("이메일을 입력하세요.");
            return;
        }
        try {
            await axios.post("/api/email/send", { email: form.email });
            setIsEmailSent(true);
            setEmailCheckMsg("이메일로 인증번호가 발송되었습니다.");
        } catch (err) {
            setEmailCheckMsg("인증메일 발송 실패. 이미 등록된 이메일이거나 형식이 올바르지 않습니다.");
        }
    };

    // 이메일 인증번호 확인
    const handleVerifyEmail = async () => {
        setEmailCheckMsg("");
        if (!emailCode) {
            setEmailCheckMsg("인증번호를 입력하세요.");
            return;
        }
        try {
            await axios.post("/api/email/verify", {
                email: form.email,
                code: emailCode,
            });
            setIsEmailVerified(true);
            setEmailCheckMsg("이메일 인증이 완료되었습니다.");
        } catch (err) {
            setEmailCheckMsg("인증번호가 올바르지 않습니다.");
            setIsEmailVerified(false);
        }
    };

    // 폼 제출
    const handleSubmit = async (e) => {
        e.preventDefault();
        setError("");
        setSuccess("");
        if (form.password !== form.password2) {
            setError("비밀번호가 일치하지 않습니다.");
            return;
        }
        if (!form.agree1 || !form.agree2 || !form.agree3) {
            setError("필수 약관에 모두 동의해 주세요.");
            return;
        }
        if (!isEmailVerified) {
            setError("이메일 인증을 완료해 주세요.");
            return;
        }
        try {
            await axios.post("/api/users/join", {
                username: form.username,
                name: form.name,
                password: form.password,
                tel: form.tel,
                address: form.address + " " + form.addressDetail,
                email: form.email,
            });
            setSuccess("회원가입이 완료되었습니다.");
            setShowModal(true);
            setForm({
                username: "",
                name: "",
                password: "",
                password2: "",
                tel: "",
                address: "",
                addressDetail: "",
                email: "",
                agreeAll: false,
                agree1: false,
                agree2: false,
                agree3: false,
            });
            setTimeout(() => {
                setShowModal(false);
                navigate("/login");
            }, 1800);
        } catch (err) {
            setError(
                err.response?.data?.message ||
                "회원가입에 실패했습니다. 다시 시도해주세요."
            );
        }
    };

    return (
        <div className="join-bg">
            <div className="join-container">
                <h3 className="join-title">회원가입</h3>
                <form onSubmit={handleSubmit} autoComplete="off">
                    {/* ...상단 필드 동일 ... */}
                    <label className="join-form-label">아이디 *</label>
                    <input type="text" name="username" className="join-input" value={form.username} onChange={handleChange} required placeholder="아이디를 입력해 주세요" />

                    <label className="join-form-label">비밀번호 *</label>
                    <input type="password" name="password" className="join-input" value={form.password} onChange={handleChange} required placeholder="비밀번호를 입력해 주세요" />

                    <label className="join-form-label">비밀번호 확인 *</label>
                    <input type="password" name="password2" className="join-input" value={form.password2} onChange={handleChange} required placeholder="비밀번호를 한 번 더 입력해 주세요" />

                    <label className="join-form-label">이름 *</label>
                    <input type="text" name="name" className="join-input" value={form.name} onChange={handleChange} required placeholder="이름" />

                    <label className="join-form-label">휴대폰 번호 *</label>
                    <input type="tel" name="tel" className="join-input" value={form.tel} onChange={handleChange} required placeholder="휴대폰 번호" />

                    {/* 이메일 인증 영역 */}
                    <label className="join-form-label">이메일 *</label>
                    <div style={{ display: "flex", gap: 8, alignItems: "center" }}>
                        <input
                            type="email"
                            name="email"
                            className="join-input"
                            value={form.email}
                            onChange={handleChange}
                            required
                            placeholder="이메일 입력"
                            style={{ flex: 1 }}
                            autoComplete="off"
                            disabled={isEmailVerified}
                        />
                        <button
                            type="button"
                            className="btn btn-outline-success"
                            onClick={handleSendEmail}
                            disabled={isEmailVerified}
                        >
                            인증메일 발송
                        </button>
                    </div>
                    {isEmailSent && !isEmailVerified && (
                        <div style={{ display: "flex", gap: 8, marginTop: 5 }}>
                            <input
                                type="text"
                                className="join-input"
                                placeholder="인증번호 입력"
                                value={emailCode}
                                onChange={e => setEmailCode(e.target.value)}
                                style={{ flex: 1 }}
                            />
                            <button
                                type="button"
                                className="btn btn-outline-info"
                                onClick={handleVerifyEmail}
                            >
                                인증확인
                            </button>
                        </div>
                    )}
                    {emailCheckMsg && (
                        <div className={`mb-2 ${isEmailVerified ? "text-success" : "text-danger"}`}>{emailCheckMsg}</div>
                    )}

                    {/* 주소 영역 */}
                    <label className="join-form-label">주소</label>
                    <div style={{ display: "flex", gap: "8px", minHeight: 49 }}>
                        <input
                            type="text"
                            name="address"
                            className="address-input join-input"
                            value={form.address}
                            readOnly
                            placeholder="주소 찾기를 클릭하세요"
                            style={{ flex: 1, cursor: "pointer", background: "#fafcfa" }}
                            onClick={() => setShowAddressModal(true)}
                        />
                        <button
                            type="button"
                            className="address-input-btn btn btn-outline-success"
                            style={{ height: 48 }}
                            onClick={() => setShowAddressModal(true)}
                        >
                            주소찾기
                        </button>
                    </div>
                    <input
                        type="text"
                        name="addressDetail"
                        className="join-input"
                        value={form.addressDetail}
                        onChange={handleChange}
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
                                    onComplete={handleComplete}
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

                    {/* 약관 등 체크 */}
                    <div className="join-guide">
                        오아시스에서 이용약관 및 개인정보 동의 내용을 확인하였으며,
                        회원님이 동의하실 때, 만 14세 미만 아동은 회원가입이 불가합니다.
                    </div>
                    <div className="join-checkbox-wrap">
                        <div className="form-check">
                            <input className="form-check-input" type="checkbox" name="agreeAll" id="agreeAll" checked={form.agreeAll} onChange={handleAllAgree} />
                            <label className="form-check-label" htmlFor="agreeAll">전체 약관 동의</label>
                        </div>
                        <div className="form-check">
                            <input className="form-check-input" type="checkbox" name="agree1" id="agree1" checked={form.agree1} onChange={handleAgree} required />
                            <label className="form-check-label" htmlFor="agree1">[필수] 만 14세 이상입니다.</label>
                        </div>
                        <div className="form-check">
                            <input className="form-check-input" type="checkbox" name="agree2" id="agree2" checked={form.agree2} onChange={handleAgree} required />
                            <label className="form-check-label" htmlFor="agree2">[필수] 이용약관 동의</label>
                        </div>
                        <div className="form-check">
                            <input className="form-check-input" type="checkbox" name="agree3" id="agree3" checked={form.agree3} onChange={handleAgree} required />
                            <label className="form-check-label" htmlFor="agree3">[필수] 개인정보 수집 및 이용동의</label>
                        </div>
                    </div>
                    {error && <div className="text-danger mb-3">{error}</div>}
                    {success && <div className="text-success mb-3">{success}</div>}
                    <button type="submit" className="btn btn-join-main">
                        회원가입
                    </button>
                    {showModal && (
                        <div className="custom-modal-bg">
                            <div className="custom-modal">
                                <div className="custom-modal-title">🎉 회원가입 완료</div>
                                <div className="custom-modal-content">로그인 페이지로 이동합니다!</div>
                            </div>
                        </div>
                    )}
                    <div className="join-login-link">
                        이미 계정이 있으신가요? <Link to="/login">로그인</Link>
                    </div>
                </form>
            </div>
        </div>
    );
}
