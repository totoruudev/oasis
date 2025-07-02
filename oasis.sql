create database oasis;
use oasis;
show tables;

select * from user;
select * from event;
UPDATE user
SET role = 'ADMIN'
WHERE id = 1;

INSERT INTO event (title, description, banner_img, link_url, start_at, end_at, sort_order, active) VALUES
('여름엔 밀키트가 진리', '간편하게 즐기는 미식여행', 'Carousel_item_01.jpg', '/event/detail/1', '2025-06-30', '2025-07-09', 1, true),
('경기도 사회적 가치 생산품 착한소비 기획전', '여성/청년/장애인/노인일자리 상품', 'Carousel_item_02.jpg', '/event/detail/2', '2025-06-01', '2025-07-31', 2, true),
('2025 상반기 결산 최대 70% 할인', 'HOT 인기 아이템', 'Carousel_item_03.jpg', '/event/detail/3', '2025-06-30', '2025-07-09', 3, true),
('1A등급 국산원유로 만든 순수한 그릭요거트', '시리얼, 그래놀라, 샐러드와 함께 해도 좋아요', 'Carousel_item_04.jpg', '/event/detail/4', '2025-06-25', '2025-07-07', 4, true),
('늘 고민되시죠? 건강한 간식거리', '고민 해결! 오아시스표 간식', 'Carousel_item_05.gif', '/event/detail/5', '2025-06-01', '2025-07-31', 5, true),
('경기도 사회적 경제조직 특별 기획전', '사회적기업, 마을기업, 협동조합, 자활기업 상품', 'Carousel_item_06.jpg', '/event/detail/6', '2025-06-27', '2025-07-31', 6, true),
('삼성카드로 결제하면 최대 2,000원 즉시 할인!', '', 'Carousel_item_07.jpg', '/event/detail/7', '2025-07-01', '2025-07-15', 7, true),
('[아임닭 여름 식단 기획전 2탄] 천원대로 즐기는 여름맞이 가벼운 한끼', '고물가시대, 살도 빼고 식비도 줄여요', 'Carousel_item_08.jpg', '/event/detail/8', '2025-06-18', '2025-07-18', 8, true),
('[전북특별자치도 중소기업 상생 특가대전] 맛의 고향, 전북으로 떠나는 여름 맛캉스', '지역 농가가 선사하는 건강한 여름의 맛', 'Carousel_item_09.jpg', '/event/detail/9', '2025-06-15', '2025-07-14', 9, true);

SET SQL_SAFE_UPDATES = 0;

UPDATE event
SET banner_img = REPLACE(banner_img, '/images/products/', '')
WHERE banner_img LIKE '/images/products/%';

select * from event;

select * from category;

INSERT INTO category (name, icon) VALUES
('농산',   'Recommend_icon_01.png'),
('축산',   'Recommend_icon_02.png'),
('수산',   'Recommend_icon_03.png'),
('간편식', 'Recommend_icon_04.png'),
('간식',   'Recommend_icon_05.png');

INSERT INTO sub_category (name) VALUES
('채소'), ('과일'), ('수산'), ('축산'),
('국'), ('반찬'), ('간편식'), ('빵'), ('잼'), ('쌀'),
('견과'), ('양념'), ('면'), ('간식'), ('음료'), ('생활'), ('주방'),
('브랜드상품'), ('농산'), ('제철 음식'), ('산지직송'), ('GAP'),
('우리땅과일'), ('수입과일'), ('친환경채소'), ('우리땅채소'), ('샐러드채소'), ('즙용채소'), ('간편채소'),
('버섯'), ('건나물'), ('잡곡'), ('선식'), ('유정란'), ('알류'),
('무항생제한우'), ('무항생제한돈'), ('한우'), ('한돈'), ('제주돼지'),
('닭'), ('오리'),  ('소고기'), ('유기농소고기'), ('육가공'), ('족발'), ('양념육'), ('건강즙'),  ('생수'),
('커피'), ('식혜'), ('영양제'), ('천연과즙'), ('액상'), ('엑기스'), ('홍삼'),
('인삼'), ('죽염'), ('흑마늘'), ('환'), ('곡물'), ('차류'),
('새벽수산'), ('일반생선'), ('연어'), ('참치'), ('오징어'), ('새우'), ('조개'), ('멸치'), ('액젓'), ('젓갈'), ('김'), ('해조'), ('건어물'), ('어묵'),
('가공'), ('과자'), ('떡'), ('한과'), ('엿'), ('두유'), ('유제품'),
('사탕'), ('젤리'), ('초콜릿'), ('시리얼'), ('파스타'), ('밀가루'), ('분말'), ('오일'), ('참기름'), ('케찹'),
('소금'), ('설탕'), ('향신료'), ('된장'), ('장류'), ('참깨'), ('고춧가루'), ('식초'), ('조청'), ('꿀'), ('소스'), ('드레싱'), ('육수');

select * from sub_category;
select * from category;

delete from sub_category where name = '잼류';
delete from category where name = '정기구독';

select * from product;

