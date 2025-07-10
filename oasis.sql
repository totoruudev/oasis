-- drop database oasis;
-- create database oasis;
use oasis;
show tables;

insert into user (id, address, created_at, email, name, password, profile_img, role, social, tel, username) values
(1, 'admin_adress', NOW(), 'admin_email', '관리자', 1234, '', 'ADMIN', 0, '', 'admin');

UPDATE user
SET password = '$2a$12$PWrupq1D6MV03/2gGFbXhOWMh7YzGgfvkfRMh5B5XwZUrdRUIN3ti'
WHERE id = 1;

select * from user;

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
select * from event;

-- 카테고리
INSERT INTO category (name, icon) VALUES
('농산',   'Recommend_icon_01.jpg'),
('축산',   'Recommend_icon_02.jpg'),
('수산',   'Recommend_icon_03.jpg'),
('간식',   'Recommend_icon_04.jpg');
-- UPDATE category
-- SET icon = REPLACE(icon, '.png', '.jpg');

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


-- 농산물: GAP
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- GAP 하우스감귤(500g/2S-S)
(1, NOW(), 'GAP 하우스감귤(500g/2S-S)', 20, 8700, '', 'gap_mandarin_500g_detail.jpg', 'gap_mandarin_500g_thumb.jpg', 1, 1, 0),
-- GAP 하우스감귤(2kg/L-2L)
(1, NOW(), 'GAP 하우스감귤(2kg/L-2L)', 30, 25600, '', 'gap_mandarin_2kg_detail.jpg', 'gap_mandarin_2kg_thumb.jpg', 1, 1, 0),
-- GAP 달콤 부사사과(1.5kg/5-7입)
(1, NOW(), 'GAP 달콤 부사사과(1.5kg/5-7입)', 25, 21400, '', 'gap_apple_15kg_detail.jpg', 'gap_apple_15kg_thumb.jpg', 1, 1, 0),
-- 저탄소GAP 의성 부사사과(5-6입/1kg)
(1, NOW(), '저탄소GAP 의성 부사사과(5-6입/1kg)', 18, 18400, '', 'gap_uisung_apple_1kg_detail.jpg', 'gap_uisung_apple_1kg_thumb.jpg', 1, 1, 0),
-- 저탄소GAP 하우스 꼬마밀감(1kg)
(1, NOW(), '저탄소GAP 하우스 꼬마밀감(1kg)', 25, 19500, '', 'gap_baby_mandarin_1kg_detail.jpg', 'gap_baby_mandarin_1kg_thumb.jpg', 1, 1, 0),
-- 저탄소 백도 복숭아(4-6입/1.25kg)
(1, NOW(), '저탄소 백도 복숭아(4-6입/1.25kg)', 21, 18400, '', 'gap_white_peach_125kg_detail.jpg', 'gap_white_peach_125kg_thumb.jpg', 1, 1, 0),
-- GAP 블랙스완포도(500g)
(1, NOW(), 'GAP 블랙스완포도(500g)', 25, 18600, '', 'gap_black_swan_grape_500g_detail.jpg', 'gap_black_swan_grape_500g_thumb.jpg', 1, 1, 0),
-- GAP 부드러운 복숭아(1.25kg/4-6입)
(1, NOW(), 'GAP 부드러운 복숭아(1.25kg/4-6입)', 25, 18700, '', 'gap_soft_peach_125kg_detail.jpg', 'gap_soft_peach_125kg_thumb.jpg', 1, 1, 0);

-- 농산물: 우리땅과일
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- 하미과 멜론(1.8kg)
(1, NOW(), '하미과 멜론(1.8kg)', 24, 16500, '', 'hamigua_melon_18kg_detail.jpg', 'hamigua_melon_18kg_thumb.jpg', 1, 2, 0),
-- 유기농 성주 참외(4-6입/1.2kg)
(1, NOW(), '유기농 성주 참외(4-6입/1.2kg)', 30, 17200, '', 'seongju_melon_12kg_detail.jpg', 'seongju_melon_12kg_thumb.jpg', 1, 2, 0),
-- 저탄소 경산 샤인머스캣(500g)
(1, NOW(), '저탄소 경산 샤인머스캣(500g)', 0, 14500, '', 'shine_muscat_500g_detail.jpg', 'shine_muscat_500g_thumb.jpg', 1, 2, 0),
-- 국내산 초당옥수수 (5개입)
(1, NOW(), '국내산 초당옥수수 (5개입)', 43, 15000, '', 'corn_sweet_5_detail.jpg', 'corn_sweet_5_thumb.jpg', 1, 2, 0),
-- 친환경 블루베리(250g/상)
(1, NOW(), '친환경 블루베리(250g/상)', 30, 13600, '', 'organic_blueberry_250g_detail.jpg', 'organic_blueberry_250g_thumb.jpg', 1, 2, 0),
-- [13brix] 저탄소 당도선별 자두(500g)
(1, NOW(), '[13brix] 저탄소 당도선별 자두(500g)', 0, 7000, '', 'carbonlow_prune_500g_detail.jpg', 'carbonlow_prune_500g_thumb.jpg', 1, 2, 0),
-- 달콩 대추방울 허니마토(500g)
(1, NOW(), '달콩 대추방울 허니마토(500g)', 0, 5800, '', 'honey_tomato_500g_detail.jpg', 'honey_tomato_500g_thumb.jpg', 1, 2, 0),
-- 제주 달콤 하우스감귤(500g)
(1, NOW(), '제주 달콤 하우스감귤(500g)', 20, 9900, '', 'house_mandarin_500g_detail.jpg', 'house_mandarin_500g_thumb.jpg', 1, 2, 0);

-- 농산물: 수입과일 
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- 컷팅 파인애플 (400g)
(1, NOW(), '컷팅 파인애플 (400g)', 26, 7300, '', 'cutting_pineapple_400g_detail.jpg', 'cutting_pineapple_400g_thumb.jpg', 1, 3, 0),
-- [특가] 스위티오 파인애플 슬라이스(540g)
(1, NOW(), '[특가] 스위티오 파인애플 슬라이스(540g)', 23, 13000, '', 'sweetio_pineapple_slice_540g_detail.jpg', 'sweetio_pineapple_slice_540g_thumb.jpg', 1, 3, 0),
-- 유기농 블루베리 (500g/냉동)
(1, NOW(), '유기농 블루베리 (500g/냉동)', 35, 13900, '', 'organic_blueberry_500g_frozen_detail.jpg', 'organic_blueberry_500g_frozen_thumb.jpg', 1, 3, 0),
-- [특가] 스위티오 파인애플 조각(400g)
(1, NOW(), '[특가] 스위티오 파인애플 조각(400g)', 27, 8700, '', 'sweetio_pineapple_chunk_400g_detail.jpg', 'sweetio_pineapple_chunk_400g_thumb.jpg', 1, 3, 0),
-- 700m 고산지 바나나(1.3kg내외)
(1, NOW(), '700m 고산지 바나나(1.3kg내외)', 27, 5400, '', 'highland_banana_13kg_detail.jpg', 'highland_banana_13kg_thumb.jpg', 1, 3, 0),
-- [추천상품] 대용량 블루베리 (1kg)
(1, NOW(), '[추천상품] 대용량 블루베리 (1kg)', 25, 14000, '', 'bulk_blueberry_1kg_detail.jpg', 'bulk_blueberry_1kg_thumb.jpg', 1, 3, 0),
-- 유기농 블루베리 (500g,냉동)
(1, NOW(), '유기농 블루베리 (500g,냉동)', 20, 13200, '', 'organic_blueberry_500g_frozen2_detail.jpg', 'organic_blueberry_500g_frozen2_thumb.jpg', 1, 3, 0),
-- 트리플베리 (500g)
(1, NOW(), '트리플베리 (500g)', 28, 13500, '', 'tripleberry_500g_detail.jpg', 'tripleberry_500g_thumb.jpg', 1, 3, 0);

-- 농산물: 친환경채소
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- [BEST]무농약이상 대파(500g)
(1, NOW(), '[BEST]무농약이상 대파(500g)', 37, 4000, '', 'best_eco_green_onion_500g_detail.jpg', 'best_eco_green_onion_500g_thumb.jpg', 1, 4, 0),
-- 무농약이상 양파(800g.3~6개)
(1, NOW(), '무농약이상 양파(800g.3~6개)', 40, 2990, '', 'eco_onion_800g_detail.jpg', 'eco_onion_800g_thumb.jpg', 1, 4, 0),
-- [신규]즙용 당근(1kg)/무농약
(1, NOW(), '[신규]즙용 당근(1kg)/무농약', 28, 5600, '', 'new_juice_carrot_1kg_detail.jpg', 'new_juice_carrot_1kg_thumb.jpg', 1, 4, 0),
-- [쿠폰20%,특가]감자 (800g이상)/무농약
(1, NOW(), '[쿠폰20%,특가]감자 (800g이상)/무농약', 32, 4200, '', 'coupon_special_potato_800g_detail.jpg', 'coupon_special_potato_800g_thumb.jpg', 1, 4, 0),
-- 얼갈이 (400g)/무농약
(1, NOW(), '얼갈이 (400g)/무농약', 26, 3150, '', 'eco_ulgari_400g_detail.jpg', 'eco_ulgari_400g_thumb.jpg', 1, 4, 0),
-- 적상추(120g) / 무농약이상
(1, NOW(), '적상추(120g) / 무농약이상', 25, 2200, '', 'eco_red_lettuce_120g_detail.jpg', 'eco_red_lettuce_120g_thumb.jpg', 1, 4, 0),
-- 무농약이상 흙당근(1kg)
(1, NOW(), '무농약이상 흙당근(1kg)', 38, 8000, '', 'eco_soil_carrot_1kg_detail.jpg', 'eco_soil_carrot_1kg_thumb.jpg', 1, 4, 0),
-- 시금치 (200g)/무농약
(1, NOW(), '시금치 (200g)/무농약', 25, 5700, '', 'eco_spinach_200g_detail.jpg', 'eco_spinach_200g_thumb.jpg', 1, 4, 0);

-- 농산물: 우리땅채소
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- 친환경 양배추
(1, NOW(), '국내산 양배추(1통,800g-1kg)', 34, 2280, '', 'k_cabbage_800g_detail.jpg', 'k_cabbage_800g_thumb.jpg', 1, 5, 0),
-- 무농약 꿀맛 고구마
(1, NOW(), '무농약 꿀맛 고구마 (3kg)', 31, 17800, '', 'sweetpotato_3kg_detail.jpg', 'sweetpotato_3kg_thumb.jpg', 1, 5, 0),
-- 국내산 두백 햇감자 (특~대, 1.7kg내외)
(1, NOW(), '국내산 두백 햇감자 (특~대, 1.7kg내외)', 34, 6500, '', 'potato_big_17kg_detail.jpg', 'potato_big_17kg_thumb.jpg', 1, 5, 0),
-- 저탄소 햇 홍감자 (1kg, 5~10개)
(1, NOW(), '저탄소 햇 홍감자 (1kg, 5~10개)', 44, 4440, '', 'red_potato_1kg_detail.jpg', 'red_potato_1kg_thumb.jpg', 1, 5, 0),
-- 친환경 양배추 (1통, 1.3kg내외/무농약이상)
(1, NOW(), '친환경 양배추 (1통, 1.3kg내외/무농약이상)', 34, 4250, '', 'eco_cabbage_13kg_detail.jpg', 'eco_cabbage_13kg_thumb.jpg', 1, 5, 0),
-- 국내산 감자(1kg.6~10개)
(1, NOW(), '국내산 감자(1kg.6~10개)', 43, 3990, '', 'k_potato_1kg_detail.jpg', 'k_potato_1kg_thumb.jpg', 1, 5, 0),
-- 저탄소 두백 햇감자 (1kg, 5~10개)
(1, NOW(), '저탄소 두백 햇감자 (1kg, 5~10개)', 46, 3780, '', 'double_potato_1kg_detail.jpg', 'double_potato_1kg_thumb.jpg', 1, 5, 0),
-- 국내산 양파1.5kg(6개입)
(1, NOW(), '국내산 양파1.5kg(6개입)', 25, 3590, '', 'k_onion_15kg_detail.jpg', 'k_onion_15kg_thumb.jpg', 1, 5, 0);

select * from product;
select * from cart_item;
select * from orders;
