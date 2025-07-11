import React from "react";
import { useNavigate } from "react-router-dom";
import NotificationsIcon from '@mui/icons-material/Notifications';
import LiveHelpIcon from '@mui/icons-material/LiveHelp';
import SupportAgentIcon from '@mui/icons-material/SupportAgent';
import './SupportMain.css';

export default function SupportMain() {
    const navigate = useNavigate();

    function handleNotReady(e) {
        e.preventDefault();
        window.alert("아직 지원되지 않는 기능입니다.");
    }

    return (
        <div className="support-main-bg py-5">
            <div className="container">
                <div className="text-center mb-5">
                    <h2 className="fw-bold">고객센터</h2>
                    <div className="mt-2 text-secondary fs-5">원하시는 서비스를 선택하세요</div>
                </div>
                <div className="row justify-content-center g-4">
                    {/* 공지사항 카드 */}
                    <div className="support-card-wrap col-12 col-md-4">
                        <button
                            type="button"
                            onClick={handleNotReady}
                            className="support-card-btn"
                        >
                            <div className="support-card notice">
                                <div className="support-card-icon-wrap">
                                    <NotificationsIcon style={{fontSize: 96, color:"#156fdc",  marginBottom: 30 }} />
                                </div>
                                <h4 className="support-card-title">공지사항</h4>
                                <div className="support-card-desc">오아시스몰의 새로운 소식과 안내</div>
                                <span className="support-card-label notice">공지사항 보기</span>
                            </div>
                        </button>
                    </div>
                    {/* FAQ 카드 */}
                    <div className="support-card-wrap col-12 col-md-4">
                        <button
                            type="button"
                            onClick={handleNotReady}
                            className="support-card-btn"
                        >
                            <div className="support-card faq">
                                <div className="support-card-icon-wrap">
                                    <LiveHelpIcon style={{ fontSize:96, color:"#ffb700", marginBottom: 30 }} />
                                </div>
                                <h4 className="support-card-title">자주묻는질문</h4>
                                <div className="support-card-desc">고객님들이 많이 묻는 질문 모음</div>
                                <span className="support-card-label faq">FAQ 보기</span>
                            </div>
                        </button>
                    </div>
                    {/* AI상담 카드 */}
                    <div className="support-card-wrap col-12 col-md-4">
                        <button
                            type="button"
                            className="support-card-btn"
                            onClick={() => navigate("/chat")}
                        >
                            <div className="support-card ai">
                                <div className="support-card-icon-wrap">
                                    <SupportAgentIcon style={{ fontSize: 96, color:"#19bb5e", marginBottom: 30 }} />
                                </div>
                                <h4 className="support-card-title">AI 상담</h4>
                                <div className="support-card-desc">실시간 AI 챗봇 상담</div>
                                <span className="support-card-label ai">AI 상담 시작</span>
                            </div>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}
