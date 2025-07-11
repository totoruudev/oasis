import React, { useState, useRef, useEffect } from "react";
import { Link } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";

const presetQuestions = [
    "배송은 얼마나 걸리나요?",
    "교환/반품은 어떻게 하나요?",
    "비회원도 주문할 수 있나요?",
    "결제수단은 무엇이 있나요?",
];

export default function Chatbot() {
    const [messages, setMessages] = useState([
        { sender: "bot", text: "안녕하세요! 무엇을 도와드릴까요? 자주 묻는 질문을 눌러보세요." }
    ]);
    const [input, setInput] = useState("");
    const [loading, setLoading] = useState(false);
    const scrollRef = useRef(null);

    useEffect(() => {
        // 새 메시지마다 스크롤 다운
        if (scrollRef.current) {
            scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
        }
    }, [messages]);

    // 프리셋 클릭 시
    const handlePresetClick = async (question) => {
        if (loading) return;
        await sendMessage(question);
    };

    // 폼 제출 시
    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!input.trim() || loading) return;
        await sendMessage(input.trim());
        setInput("");
    };

    // 서버로 메시지 보내기
    const sendMessage = async (userInput) => {
        setMessages(prev => [...prev, { sender: "user", text: userInput }]);
        setLoading(true);

        try {
            const res = await fetch("/api/chat", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ message: userInput })
            });
            const data = await res.json();
            setMessages(prev => [
                ...prev,
                { sender: "bot", text: data.reply || "죄송해요, 답변을 찾지 못했어요." }
            ]);
        } catch {
            setMessages(prev => [
                ...prev,
                { sender: "bot", text: "서버와 연결이 불안정해요. 잠시 후 다시 시도해주세요." }
            ]);
        }
        setLoading(false);
    };

    return (
        <div className="container p-0" style={{ minHeight: 500 }}>
            <div className="card shadow rounded-4" style={{ minHeight: 500 }}>
                <div className="card-header bg-success text-white py-2 rounded-top-4">
                    <div className="d-flex align-items-center justify-content-between">
                        <span>오아시스몰 FAQ 챗봇</span>
                        <Link to="/" className="btn btn-light btn-sm rounded-pill">홈</Link>
                    </div>
                </div>
                <div className="card-body p-2 bg-light" style={{ minHeight: 380, maxHeight: 380, overflowY: "auto" }} ref={scrollRef}>
                    {messages.map((msg, idx) => (
                        <div key={idx} className={`d-flex mb-2 ${msg.sender === "user" ? "justify-content-end" : "justify-content-start"}`}>
                            <div className={`p-2 rounded-3 ${msg.sender === "user" ? "bg-success text-white" : "bg-white border"}`}
                                style={{ maxWidth: "70%", wordBreak: "break-all" }}>
                                {msg.text}
                            </div>
                        </div>
                    ))}
                    {loading && (
                        <div className="d-flex justify-content-start mb-2">
                            <div className="p-2 bg-white border rounded-3" style={{ maxWidth: "70%" }}>
                                <span className="spinner-border spinner-border-sm me-2"></span>답변을 찾는 중...
                            </div>
                        </div>
                    )}
                </div>
                {/* 프리셋 버튼 */}
                <div className="px-2 pb-2">
                    <div className="d-flex flex-wrap gap-2 mb-2">
                        {presetQuestions.map((q, i) => (
                            <button key={i}
                                className="btn btn-outline-success btn-sm rounded-pill flex-grow-1"
                                onClick={() => handlePresetClick(q)}
                                disabled={loading}
                            >
                                {q}
                            </button>
                        ))}
                    </div>
                    {/* 입력 폼 */}
                    <form onSubmit={handleSubmit} className="input-group">
                        <input
                            className="form-control"
                            value={input}
                            maxLength={50}
                            placeholder="궁금한 점을 입력하세요"
                            onChange={e => setInput(e.target.value)}
                            disabled={loading}
                            style={{ borderRadius: "2rem 0 0 2rem" }}
                        />
                        <button className="btn btn-success" type="submit" disabled={loading || !input.trim()} style={{ borderRadius: "0 2rem 2rem 0" }}>
                            전송
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
}
