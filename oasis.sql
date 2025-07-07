drop database oasis;
create database oasis;
use oasis;
show tables;

-- select * from event;
-- UPDATE user
-- SET role = 'ADMIN'
-- WHERE id = 1;

-- select * from user;

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

select * from event;

-- 카테고리
INSERT INTO category (name, icon) VALUES
('농산',   'Recommend_icon_01.png'),
('축산',   'Recommend_icon_02.png'),
('수산',   'Recommend_icon_03.png'),
('간식',   'Recommend_icon_04.png');

select * from category;

-- 농산
INSERT INTO sub_category (name, category_id) VALUES
('GAP', 1), ('우리땅과일', 1), ('수입과일', 1), ('친환경채소', 1), 
('우리땅채소', 1), ('샐러드채소', 1), ('즙용채소', 1), ('간편채소', 1),
('버섯', 1), ('건나물', 1), ('쌀', 1), ('잡곡', 1), ('견과', 1), ('선식', 1);

-- 축산
INSERT INTO sub_category (name, category_id) VALUES
('유정란', 2), ('알류', 2), ('무항생제한우', 2), ('무항생제한돈', 2),
('한우', 2), ('한돈', 2), ('제주돼지', 2), ('닭', 2), ('오리', 2), 
('소고기', 2), ('유기농소고기', 2), ('육가공', 2), ('족발', 2), ('양념육', 2);

-- 수산
INSERT INTO sub_category (name, category_id) VALUES
('새벽수산', 3), ('일반생선', 3), ('연어', 3), ('참치', 3), ('오징어', 3),
('새우', 3), ('조개', 3), ('멸치', 3), ('액젓', 3), ('젓갈', 3), 
('김', 3), ('해조', 3), ('건어물', 3), ('어묵', 3), ('가공', 3);

-- 간식
INSERT INTO sub_category (name, category_id) VALUES
('과자', 4), ('빵', 4), ('떡', 4), ('한과', 4), ('엿', 4),
('두유', 4), ('유제품', 4), ('선식', 4), ('사탕', 4), ('젤리', 4), ('초콜릿', 4), ('시리얼', 4);


select * from sub_category;

select * from product;

INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- GAP 하우스감귤(500g/2S-S)
(1, NOW(), 'GAP 하우스감귤(500g/2S-S)', 20, 8700, '', 'gap_mandarin_500g_detail.png', 'gap_mandarin_500g_thumb.png', 1, 1, 0),
-- GAP 하우스감귤(2kg/L-2L)
(1, NOW(), 'GAP 하우스감귤(2kg/L-2L)', 30, 25600, '', 'gap_mandarin_2kg_detail.png', 'gap_mandarin_2kg_thumb.png', 1, 1, 0),
-- GAP 달콤 부사사과(1.5kg/5-7입)
(1, NOW(), 'GAP 달콤 부사사과(1.5kg/5-7입)', 25, 21400, '', 'gap_apple_15kg_detail.png', 'gap_apple_15kg_thumb.png', 1, 1, 0),
-- 저탄소GAP 의성 부사사과(5-6입/1kg)
(1, NOW(), '저탄소GAP 의성 부사사과(5-6입/1kg)', 18, 18400, '', 'gap_uisung_apple_1kg_detail.png', 'gap_uisung_apple_1kg_thumb.png', 1, 1, 0),
-- 저탄소GAP 하우스 꼬마밀감(1kg)
(1, NOW(), '저탄소GAP 하우스 꼬마밀감(1kg)', 25, 19500, '', 'gap_baby_mandarin_1kg_detail.png', 'gap_baby_mandarin_1kg_thumb.png', 1, 1, 0),
-- 저탄소 백도 복숭아(4-6입/1.25kg)
(1, NOW(), '저탄소 백도 복숭아(4-6입/1.25kg)', 21, 18400, '', 'gap_white_peach_125kg_detail.png', 'gap_white_peach_125kg_thumb.png', 1, 1, 0),
-- GAP 블랙스완포도(500g)
(1, NOW(), 'GAP 블랙스완포도(500g)', 25, 18600, '', 'gap_black_swan_grape_500g_detail.png', 'gap_black_swan_grape_500g_thumb.png', 1, 1, 0),
-- GAP 부드러운 복숭아(1.25kg/4-6입)
(1, NOW(), 'GAP 부드러운 복숭아(1.25kg/4-6입)', 25, 18700, '', 'gap_soft_peach_125kg_detail.png', 'gap_soft_peach_125kg_thumb.png', 1, 1, 0);

INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- 하미과 멜론(1.8kg)
(1, NOW(), '하미과 멜론(1.8kg)', 24, 16500, '', 'hamigua_melon_18kg_detail.png', 'hamigua_melon_18kg_thumb.png', 1, 2, 0),
-- 유기농 성주 참외(4-6입/1.2kg)
(1, NOW(), '유기농 성주 참외(4-6입/1.2kg)', 30, 17200, '', 'seongju_melon_12kg_detail.png', 'seongju_melon_12kg_thumb.png', 1, 2, 0),
-- 저탄소 경산 샤인머스캣(500g)
(1, NOW(), '저탄소 경산 샤인머스캣(500g)', 0, 14500, '', 'shine_muscat_500g_detail.png', 'shine_muscat_500g_thumb.png', 1, 2, 0),
-- 국내산 초당옥수수 (5개입)
(1, NOW(), '국내산 초당옥수수 (5개입)', 43, 15000, '', 'corn_sweet_5_detail.png', 'corn_sweet_5_thumb.png', 1, 2, 0),
-- 친환경 블루베리(250g/상)
(1, NOW(), '친환경 블루베리(250g/상)', 30, 13600, '', 'organic_blueberry_250g_detail.png', 'organic_blueberry_250g_thumb.png', 1, 2, 0),
-- [13brix] 저탄소 당도선별 자두(500g)
(1, NOW(), '[13brix] 저탄소 당도선별 자두(500g)', 0, 7000, '', 'carbonlow_prune_500g_detail.png', 'carbonlow_prune_500g_thumb.png', 1, 2, 0),
-- 달콩 대추방울 허니마토(500g)
(1, NOW(), '달콩 대추방울 허니마토(500g)', 0, 5800, '', 'honey_tomato_500g_detail.png', 'honey_tomato_500g_thumb.png', 1, 2, 0),
-- 제주 달콤 하우스감귤(500g)
(1, NOW(), '제주 달콤 하우스감귤(500g)', 20, 9900, '', 'house_mandarin_500g_detail.png', 'house_mandarin_500g_thumb.png', 1, 2, 0);

select * from product;
DELETE FROM product
WHERE id IN (13, 14, 15, 16);

