import AdminNav from "./AdminNav";
import { Outlet } from "react-router-dom";

export default function AdminLayout() {
    return (
        <div className="d-flex" style={{ minHeight: "100vh" }}>
            <AdminNav />
            <main className="flex-grow-1 p-4" style={{ background: "#fff" }}>
                <Outlet />
            </main>
        </div>
    );
}
