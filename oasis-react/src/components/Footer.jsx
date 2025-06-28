import React from "react";
import { Link } from "react-router-dom";
import "./Footer.css";

export default function Footer() {
  return(

  <footer className="footer">
    <div className="footer-top">
      <nav className="footer-menu">
        <Link to="#">소개</Link>
        <Link to="#">매장안내</Link>
        <Link to="#">약관 및 정책</Link>
        <Link to="#">개인정보 처리방침</Link>
        <Link to="#">고객센터</Link>
        <Link to="#">입점문의</Link>
        <Link to="#">광고/제휴문의</Link>
        <Link to="#">인재채용</Link>
        <Link to="#">오아시스비디(파트너스)</Link>
      </nav>
      <div className="footer-row">
        <div className="footer-col">
          <div className="footer-company">
            <b>(주)오아시스</b><br />
            서울특별시 중구 충무로1 50 (충무동, 케이토센터) A5 113호 오아시스마켓<br />
            사업자등록번호: 126-86-45211 <a href="#">사업자정보확인</a><br />
            대표자: 한홍섭 &nbsp;|&nbsp; 통신판매업신고: 2019-성남중원-0623<br />
            이메일: oasis@oasis.co.kr
          </div>
          <div className="footer-sns">
            <a href="#"><img src="/images/components/ico_instagram_32.png" alt="instagram" /></a>
            <a href="#"><img src="/images/components/ico_facebook_32_2.png" alt="facebook" /></a>
            <a href="#"><img src="/images/components/ico_youtube_32.png" alt="youtube" /></a>
            <a href="#"><img src="/images/components/ico_naverBlog_32.png" alt="blog" /></a>
          </div>
        </div>
        <div className="footer-col">
          <div className="footer-center-title">고객센터 1577-0098</div>
          <div className="footer-center-info">
            평일 07:00~18:30<br />
            토요일/일요일 09:00~18:00<br />
            점심시간 12:00~13:00
          </div>
          <div>
            <Link to="#" className="footer-center-link">고객센터바로가기</Link>
          </div>
          <div className="footer-cert">
            [인증범위] 오아시스 온라인 쇼핑몰 운영<br />
            (유효기간) 2023.08.02~2026.08.01
          </div>
        </div>
      </div>
    </div>
    <div className="footer-bottom">
      Copyright © OASIS Corp. All Rights Reserved.
    </div>
  </footer>
  );
}
