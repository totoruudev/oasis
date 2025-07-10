import { Navigate } from "react-router-dom";

export default function RequireAdmin({ user, children }) {
    if (!user || user.role !== "ADMIN") {
        return <Navigate to="/" replace />;
    }
    return children;
}
