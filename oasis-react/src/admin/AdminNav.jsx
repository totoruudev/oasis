import { Link } from "react-router-dom";

export default function AdminNav() {
    return (
        <nav
            className="d-flex flex-column flex-shrink-0 p-3 bg-light border-end"
            style={{ width: "220px", minHeight: "100vh" }}
        >
            <Link to="/admin" className="mb-4 text-decoration-none text-dark fw-bold fs-4" style={{ letterSpacing: '2px' }}>
                관리자
            </Link>
            <ul className="nav nav-pills flex-column mb-auto">
                <li className="nav-item">
                    <Link className="nav-link text-dark" to="/admin/orders">
                        주문관리
                    </Link>
                </li>
                <li>
                    <Link className="nav-link text-dark" to="/admin/products">
                        상품관리
                    </Link>
                </li>
                <li>
                    <Link className="nav-link text-dark" to="/admin/users">
                        회원관리
                    </Link>
                </li>
                <li>
                    <Link className="nav-link text-dark" to="/admin/reviews">
                        리뷰관리
                    </Link>
                </li>
                <li>
                    <Link className="nav-link text-dark" to="/admin/qnas">
                        Q&amp;A관리
                    </Link>
                </li>
            </ul>
        </nav>
    );
}
