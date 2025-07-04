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
SET banner_img = REPLACE(banner_img, '', '')
WHERE banner_img LIKE '%';

select * from event;

INSERT INTO category (name, icon) VALUES
('농산',   'Recommend_icon_01.png'),
('축산',   'Recommend_icon_02.png'),
('수산',   'Recommend_icon_03.png'),
('간편식', 'Recommend_icon_04.png'),
('간식',   'Recommend_icon_05.png');
select * from category;

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

delete from sub_category where name = '잼류';
delete from category where name = '정기구독';

select * from product;
ALTER TABLE product DROP COLUMN category;

INSERT INTO product (name, category_id, sub_category_id, price, description, thumbnailimg, detailimg, percent, created_at, active, views) VALUES
('해남 프리미엄 초당옥수수(특품/10개)', 1, 1, 14800, '해남산 프리미엄 초당옥수수 10개입', 'haenam_corn_thumb.jpg', 'haenam_corn_detail.jpg', 35, NOW(), true, 0),
('우리밀 치즈폭탄 시카고피자(390g)', 4, 7, 9900, '우리밀 치즈폭탄 시카고피자 390g', 'chicago_pizza_thumb.jpg', 'chicago_pizza_detail.jpg', 16, NOW(), true, 0),
('[특가] 리코 치즈감자 3종 (택1)', 5, 78, 3480, '리코 치즈감자 3종 택1', 'rico_cheese_potato_thumb.jpg', 'rico_cheese_potato_detail.jpg', 36, NOW(), true, 0),
('오트사이드 프로틴 바닐라맛 (250ml)', 5, 82, 1850, '오트사이드 프로틴 바닐라맛 250ml', 'oatside_vanilla_thumb.jpg', 'oatside_vanilla_detail.jpg', 26, NOW(), true, 0),
('한우 국거리용 토막(500g)', 2, 38, 17980, '한우 국거리용 토막 500g', 'beef_chunk_thumb.jpg', 'beef_chunk_detail.jpg', 27, NOW(), true, 0),
('한우 국거리용 덩어리(500g)', 2, 38, 17980, '한우 국거리용 덩어리 500g', 'beef_block_thumb.jpg', 'beef_block_detail.jpg', 27, NOW(), true, 0),
('[존쿡델리미트] 사각 잠봉(400g)', 2, 45, 6800, '존쿡델리미트 사각 잠봉 400g', 'johncook_jambon_thumb.jpg', 'johncook_jambon_detail.jpg', 45, NOW(), true, 0),
('맑은농장 유기농 NFC 푸룬스틱 (20gX14입)', 1, 2, 7790, '유기농 NFC 푸룬스틱 20gX14입', 'prune_stick_thumb.jpg', 'prune_stick_detail.jpg', 43, NOW(), true, 0),
('[입점특가] 베지밀 국산 검은콩두유(190ml x 16팩)', 5, 82, 11900, '베지밀 국산 검은콩두유 16팩', 'vegemil_blackbean_thumb.jpg', 'vegemil_blackbean_detail.jpg', 30, NOW(), true, 0),
('[입점특가] 100% 땅콩 스프레드 스틱(20g x 14포)', 5, 11, 12200, '100% 땅콩 스프레드 스틱', 'peanut_spread_thumb.jpg', 'peanut_spread_detail.jpg', 38, NOW(), true, 0),
('오트사이드 프로틴 초콜릿맛 (250ml)', 5, 82, 1790, '오트사이드 프로틴 초콜릿맛 250ml', 'oatside_choco_thumb.jpg', 'oatside_choco_detail.jpg', 28, NOW(), true, 0),
('[입점특가] 더 부드러운 꿀버터 식빵(380g)', 5, 8, 4800, '더 부드러운 꿀버터 식빵 380g', 'honey_butter_bread_thumb.jpg', 'honey_butter_bread_detail.jpg', 29, NOW(), true, 0),
('제주자연방사 유정란 계란 장인(10구)', 2, 34, 8600, '제주자연방사 유정란 계란 장인 10구', 'egg_jeju_thumb.jpg', 'egg_jeju_detail.jpg', 47, NOW(), true, 0),
('한우 불고기용(500g)', 2, 38, 17980, '한우 불고기용 500g', 'beef_bulgogi_thumb.jpg', 'beef_bulgogi_detail.jpg', 27, NOW(), true, 0),
('제주 하우스 감귤 (1kg이상/L 단일사이즈)', 1, 2, 12500, '제주 하우스 감귤 1kg이상', 'jeju_mandarin_thumb.jpg', 'jeju_mandarin_detail.jpg', 26, NOW(), true, 0),
('[입점 특가] 제주 무항생제우유 (115mlx24입)', 5, 83, 14900, '제주 무항생제우유 115mlx24입', 'jeju_milk_thumb.jpg', 'jeju_milk_detail.jpg', 39, NOW(), true, 0),
('[입점특가] 국산원유로 만든 무가당 플레인 요거트 (970ml)', 5, 83, 4980, '국산원유 무가당 플레인 요거트 970ml', 'plain_yogurt_thumb.jpg', 'plain_yogurt_detail.jpg', 41, NOW(), true, 0),
('[입점특가] 유기농 감자전분 (500g)', 1, 1, 5580, '유기농 감자전분 500g', 'potato_starch_thumb.jpg', 'potato_starch_detail.jpg', 46, NOW(), true, 0),
('[입점특가] 국산원유로 만든 무가당 플레인 요거트 (1.8L)', 5, 83, 6800, '국산원유 무가당 플레인 요거트 1.8L', 'plain_yogurt18_thumb.jpg', 'plain_yogurt18_detail.jpg', 35, NOW(), true, 0),
('리코타치즈 발사믹 샐러드 (200g)', 1, 1, 3990, '리코타치즈 발사믹 샐러드 200g', 'ricotta_salad_thumb.jpg', 'ricotta_salad_detail.jpg', 29, NOW(), true, 0),
('[마감특가] 닭가슴살 발사믹 샐러드(200g)', 1, 1, 3890, '닭가슴살 발사믹 샐러드 200g', 'chicken_salad_thumb.jpg', 'chicken_salad_detail.jpg', 31, NOW(), true, 0),
('마이노멀 저당 파인트 아이스크림 (그린티/바닐라/초콜릿 474ml)', 5, 14, 7880, '저당 파인트 아이스크림 474ml', 'my_normal_ice_thumb.jpg', 'my_normal_ice_detail.jpg', 29, NOW(), true, 0),
('무지개 망고(700g내외/2입)', 1, 2, 7400, '무지개 망고 700g내외', 'rainbow_mango_thumb.jpg', 'rainbow_mango_detail.jpg', 38, NOW(), true, 0),
('지리산 흑돈 양념구이 (300g)', 2, 47, 3800, '지리산 흑돈 양념구이 300g', 'blackpork_yang_thumb.jpg', 'blackpork_yang_detail.jpg', 36, NOW(), true, 0),
('간소 손모아 때장갑 1켤레(2개입)', 5, 16, 7800, '간소 손모아 때장갑 2개입', 'gloves_thumb.jpg', 'gloves_detail.jpg', 28, NOW(), true, 0),
('지리산 흑돈 떡갈비 (200g)', 2, 47, 3600, '지리산 흑돈 떡갈비 200g', 'blackpork_tteokgalbi_thumb.jpg', 'blackpork_tteokgalbi_detail.jpg', 25, NOW(), true, 0),
('[시즌특가] 소백산 풍기 수삼 (150g)', 1, 57, 11500, '소백산 풍기 수삼 150g', 'sam_thumb.jpg', 'sam_detail.jpg', 31, NOW(), true, 0),
('연어&광어회(200g)', 3, 65, 13800, '연어&광어회 200g', 'salmon_halibut_sashimi_thumb.jpg', 'salmon_halibut_sashimi_detail.jpg', 30, NOW(), true, 0),
('대광어회(200g)', 3, 64, 15800, '대광어회 200g', 'big_halibut_sashimi_thumb.jpg', 'big_halibut_sashimi_detail.jpg', 20, NOW(), true, 0),
('커피빈 카페라떼 파우치(190mLX10P)', 5, 50, 12900, '커피빈 카페라떼 파우치 10팩', 'coffeebean_latte_thumb.jpg', 'coffeebean_latte_detail.jpg', 32, NOW(), true, 0),
('생연어회(200g)', 3, 65, 13800, '생연어회 200g', 'raw_salmon_sashimi_thumb.jpg', 'raw_salmon_sashimi_detail.jpg', 30, NOW(), true, 0),
('[입점특가] 수제 감자빵 1박스(100gx6개입)', 5, 8, 14900, '수제 감자빵 100gx6개입', 'potato_bread_thumb.jpg', 'potato_bread_detail.jpg', 37, NOW(), true, 0),
('인쉘 마카다미아(310g)', 5, 11, 8900, '인쉘 마카다미아 310g', 'macadamia_thumb.jpg', 'macadamia_detail.jpg', 25, NOW(), true, 0),
('[입점특가] 요즘 그릭요거트 블루베리 콩포트 (130g)', 5, 83, 4800, '그릭요거트 블루베리 콩포트 130g', 'greek_yogurt_blueberry_thumb.jpg', 'greek_yogurt_blueberry_detail.jpg', 20, NOW(), true, 0),
('우리쌀 마들렌 단호박 (21gx3입, DMZ미술관빵)', 5, 8, 3800, '우리쌀 마들렌 단호박 3입', 'madeline_pumpkin_thumb.jpg', 'madeline_pumpkin_detail.jpg', 44, NOW(), true, 0),
('우리쌀 마들렌 말차 (21gx3입, DMZ미술관빵)', 5, 8, 3800, '우리쌀 마들렌 말차 3입', 'madeline_matcha_thumb.jpg', 'madeline_matcha_detail.jpg', 44, NOW(), true, 0),
('[입점특가] 요즘 그릭요거트 플레인/소프트/알룰로스 (각 100g)', 5, 83, 3500, '그릭요거트 플레인/소프트/알룰로스 100g', 'greek_yogurt_plain_thumb.jpg', 'greek_yogurt_plain_detail.jpg', 22, NOW(), true, 0),
('[입점특가] 림미 레몬쥬스(500ml)', 5, 15, 5900, '림미 레몬쥬스 500ml', 'limmi_lemon_thumb.jpg', 'limmi_lemon_detail.jpg', 21, NOW(), true, 0),
('[오늘담근] 남도명품 포기김치(2kg)', 4, 6, 11500, '남도명품 포기김치 2kg', 'korean_kimchi_thumb.jpg', 'korean_kimchi_detail.jpg', 42, NOW(), true, 0),
('우리 콩 간장 국내산 깐새우장 500g', 3, 68, 19090, '우리 콩 간장 국내산 깐새우장 500g', 'shrimp_jiang_thumb.jpg', 'shrimp_jiang_detail.jpg', 27, NOW(), true, 0),
('[샐러드판다] 귀리불고기 샐러드(215g)', 1, 1, 6500, '귀리불고기 샐러드 215g', 'oat_bulgogi_salad_thumb.jpg', 'oat_bulgogi_salad_detail.jpg', 26, NOW(), true, 0),
('GAP 황귀비유도 복숭아(500g)', 1, 2, 5500, 'GAP 황귀비유도 복숭아 500g', 'gap_peach_thumb.jpg', 'gap_peach_detail.jpg', 33, NOW(), true, 0),
('[오늘담근] 칼국수 마늘 겉절이(2kg)', 4, 6, 13900, '칼국수 마늘 겉절이 2kg', 'garlic_kimchi_thumb.jpg', 'garlic_kimchi_detail.jpg', 33, NOW(), true, 0),
('아임리얼 토마토 (700ml)', 5, 15, 9980, '아임리얼 토마토 700ml', 'imreal_tomato_thumb.jpg', 'imreal_tomato_detail.jpg', 9, NOW(), true, 0),
('동물복지 한돈 제육볶음(500g) l 하이포크', 2, 39, 8800, '동물복지 한돈 제육볶음 500g', 'pork_stirfry_thumb.jpg', 'pork_stirfry_detail.jpg', 40, NOW(), true, 0),
('슈퍼너츠 100% 피넛버터 스무스(460g)', 5, 11, 14400, '슈퍼너츠 100% 피넛버터 스무스 460g', 'peanutbutter_smooth_thumb.jpg', 'peanutbutter_smooth_detail.jpg', 10, NOW(), true, 0),
('슈퍼너츠 100% 피넛버터 크런치(460g)', 5, 11, 14400, '슈퍼너츠 100% 피넛버터 크런치 460g', 'peanutbutter_crunch_thumb.jpg', 'peanutbutter_crunch_detail.jpg', 10, NOW(), true, 0),
('동물복지 한돈 돼지불백(500g) l 하이포크', 2, 39, 9900, '동물복지 한돈 돼지불백 500g', 'pork_bulbaek_thumb.jpg', 'pork_bulbaek_detail.jpg', 33, NOW(), true, 0),
('국산 100% 찹쌀가루(400g)', 1, 10, 3900, '국산 100% 찹쌀가루 400g', 'glutinous_rice_powder_thumb.jpg', 'glutinous_rice_powder_detail.jpg', 29, NOW(), true, 0),
('오뚜기밥 흰밥(박스 | 210g x 12개)', 4, 10, 13200, '오뚜기밥 흰밥 210g x 12개', 'ottogi_rice_thumb.jpg', 'ottogi_rice_detail.jpg', 19, NOW(), true, 0),
('아삭한 알배기샐러드(150g)', 1, 1, 3290, '아삭한 알배기샐러드 150g', 'babycabbage_salad_thumb.jpg', 'babycabbage_salad_detail.jpg', 14, NOW(), true, 0),
('유기농 미니로메인 (170g 내외)', 1, 1, 2950, '유기농 미니로메인 170g', 'mini_romaine_thumb.jpg', 'mini_romaine_detail.jpg', 34, NOW(), true, 0),
('유기농 버터헤드 (170g 내외)', 1, 1, 3100, '유기농 버터헤드 170g', 'butterhead_thumb.jpg', 'butterhead_detail.jpg', 31, NOW(), true, 0),
('유기농 카이피라 (170g 내외)', 1, 1, 2950, '유기농 카이피라 170g', 'kaipira_thumb.jpg', 'kaipira_detail.jpg', 34, NOW(), true, 0),
('유기농 유러피안 채소 모듬 (4종, 1kg 내외)', 1, 1, 12500, '유기농 유러피안 채소 모듬 1kg', 'european_vege_mix_thumb.jpg', 'european_vege_mix_detail.jpg', 51, NOW(), true, 0),
('제스프리 골드키위(1.7kg 13-17입 중대과)', 1, 2, 18900, '제스프리 골드키위 1.7kg', 'gold_kiwi_thumb.jpg', 'gold_kiwi_detail.jpg', 20, NOW(), true, 0),
('바르다 한우 핫도그(770g,110gx7개)', 5, 8, 16900, '바르다 한우 핫도그 770g', 'hanwoo_hotdog_thumb.jpg', 'hanwoo_hotdog_detail.jpg', 28, NOW(), true, 0),
('유기농 프릴아이스 (170g 내외)', 1, 1, 2950, '유기농 프릴아이스 170g', 'frill_ice_thumb.jpg', 'frill_ice_detail.jpg', 34, NOW(), true, 0),
('GAP 머스크멜론(2kg)', 1, 2, 12000, 'GAP 머스크멜론 2kg', 'musk_melon2_thumb.jpg', 'musk_melon2_detail.jpg', 29, NOW(), true, 0),
('GAP 머스크멜론(1.6kg)', 1, 2, 10500, 'GAP 머스크멜론 1.6kg', 'musk_melon16_thumb.jpg', 'musk_melon16_detail.jpg', 30, NOW(), true, 0);

select * from product;
SELECT * FROM category;
SELECT * FROM sub_category;
DELETE FROM product WHERE category_id IS NULL;
SELECT id, name, category_id FROM product WHERE category_id IS NULL;

-- 농산 (1)
UPDATE sub_category SET category_id = 1 WHERE id IN (1, 6, 14, 15, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 61, 100);

-- 축산 (2)
UPDATE sub_category SET category_id = 2 WHERE id IN (2, 17, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47);

-- 수산 (3)
UPDATE sub_category SET category_id = 3 WHERE id IN (3, 16, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76);

-- 간편식 (4)
UPDATE sub_category SET category_id = 4 WHERE id IN (4, 7, 8, 9, 12, 13, 18, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 62, 77);

-- 간식 (5)
UPDATE sub_category SET category_id = 5 WHERE id IN (5, 10, 11, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 95, 96, 97, 98, 99, 101, 102, 103, 104, 105, 106, 107);

SELECT * FROM product WHERE category_id IS NULL;
SELECT id, name, category_id FROM sub_category WHERE category_id IS NULL;
SELECT * FROM category WHERE name IS NULL;


SELECT id, name, category_id, sub_category_id
FROM product
WHERE category_id NOT IN (SELECT id FROM category)
   OR sub_category_id NOT IN (SELECT id FROM sub_category);
   
   SELECT p.id, p.name, c.name AS category_name
FROM product p
JOIN category c ON p.category_id = c.id
WHERE c.name IN ('농산', '축산', '수산', '간편식', '간식');

SELECT p.id, p.name, p.active, c.id as category_id, c.name as category_name
FROM product p
JOIN category c ON p.category_id = c.id
WHERE p.active = true AND c.name IN ('채소', '과일', '수산', '축산', '국', '반찬', '간편식', '빵', '잼');

SELECT name FROM category WHERE name IN (
  '무항생제한돈', '무항생제한우', '유정란', '알류', '한돈', '한우', '닭', '소고기', 
  '오리', '유기농소고기', '족발', '양념육', '육가공', '제주돼지'
);

INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES

-- 유정란/알류 (서브카테고리 34: 유정란)
(1, NOW(), '깐 메추리알(450g)', 10, 7980, '', 'egg_quail_450g_detail.jpg', 'egg_quail_450g_thumb.jpg', 2, 34, 0),
(1, NOW(), '동물복지 유정 반숙란 10구', 22, 6950, '', 'egg_halfboiled_10_detail.jpg', 'egg_halfboiled_10_thumb.jpg', 2, 34, 0),
(1, NOW(), '완전방사 동물복지 유정란 (10구)', 30, 4300, '', 'egg_free_10_detail.jpg', 'egg_free_10_thumb.jpg', 2, 34, 0),
(1, NOW(), '신선한 깐메추리알(270g)', 20, 3840, '', 'egg_quail_270g_detail.jpg', 'egg_quail_270g_thumb.jpg', 2, 34, 0),
(1, NOW(), '동물복지 구운 유정란 6구(258g이상)', 24, 3800, '', 'egg_baked_6_detail.jpg', 'egg_baked_6_thumb.jpg', 2, 34, 0),
(1, NOW(), '동물복지 구운 유정란 4구(172g이상)', 32, 2900, '', 'egg_baked_4_detail.jpg', 'egg_baked_4_thumb.jpg', 2, 34, 0),
(1, NOW(), 'NON-GMO 동물복지 유정란(난각번호2번)', 21, 5300, '', 'egg_nongmo_2_detail.jpg', 'egg_nongmo_2_thumb.jpg', 2, 34, 0),
(1, NOW(), '동물복지 구운 유정란 20구(860g이상)', 22, 10100, '', 'egg_baked_20_detail.jpg', 'egg_baked_20_thumb.jpg', 2, 34, 0),

-- 무항생제한우 (서브카테고리 36)
(1, NOW(), '무항생제 신선한우 등심 (구이용, 200g)', 36, 22900, '', 'beef_fresh_loin_200g_detail.jpg', 'beef_fresh_loin_200g_thumb.jpg', 2, 36, 0),
(1, NOW(), '무항생제 신선한우 채끝 (스테이크용, 200g)', 35, 26900, '', 'beef_fresh_striploin_200g_detail.jpg', 'beef_fresh_striploin_200g_thumb.jpg', 2, 36, 0),
(1, NOW(), '무항생제 신선한우 국거리 (300g)', 26, 14900, '', 'beef_fresh_soupmeat_300g_detail.jpg', 'beef_fresh_soupmeat_300g_thumb.jpg', 2, 36, 0),
(1, NOW(), '1등급이상 무항생제 한우 불고기용 (300g/냉장)', 39, 12800, '', 'beef_fresh_bulgogi_300g_detail.jpg', 'beef_fresh_bulgogi_300g_thumb.jpg', 2, 36, 0),
(1, NOW(), '무항생제 신선한우 안심 (스테이크용, 200g)', 10, 41900, '', 'beef_fresh_tenderloin_200g_detail.jpg', 'beef_fresh_tenderloin_200g_thumb.jpg', 2, 36, 0),
(1, NOW(), '무항생제 한우 우둔 다짐육(1kg)', 46, 41000, '', 'beef_fresh_groundround_1kg_detail.jpg', 'beef_fresh_groundround_1kg_thumb.jpg', 2, 36, 0),
(1, NOW(), '무항생제 한우 등심 구이용(300g)', 25, 33800, '', 'beef_fresh_loin_300g_detail.jpg', 'beef_fresh_loin_300g_thumb.jpg', 2, 36, 0),
(1, NOW(), '무항생제 신선한우 부채살 (구이용, 200g)', 18, 29900, '', 'beef_fresh_chuckflap_200g_detail.jpg', 'beef_fresh_chuckflap_200g_thumb.jpg', 2, 36, 0),

-- 무항생제한돈 (서브카테고리 37)
(1, NOW(), '무항생제 한돈 삼겹살(수육용, 1kg)｜목우촌', 21, 33800, '', 'pork_fresh_belly_1kg_detail.jpg', 'pork_fresh_belly_1kg_thumb.jpg', 2, 37, 0),
(1, NOW(), '무항생제 한돈 통항정살 구이/수육용(500g)', 2, 32000, '', 'pork_fresh_jowl_500g_detail.jpg', 'pork_fresh_jowl_500g_thumb.jpg', 2, 37, 0),
(1, NOW(), '무항생제 우리한돈 삼겹살(수육용/1kg)ㅣ우리농장', 14, 28800, '', 'pork_fresh_belly_ourfarm_1kg_detail.jpg', 'pork_fresh_belly_ourfarm_1kg_thumb.jpg', 2, 37, 0),
(1, NOW(), '무항생제 한돈 찜갈비(1kg)', 16, 19900, '', 'pork_fresh_steamedribs_1kg_detail.jpg', 'pork_fresh_steamedribs_1kg_thumb.jpg', 2, 37, 0),
(1, NOW(), '무항생제 한돈 목심 구이용(500g)', 18, 18500, '', 'pork_fresh_neck_500g_detail.jpg', 'pork_fresh_neck_500g_thumb.jpg', 2, 37, 0),
(1, NOW(), '무항생제 한돈 삼겹살 수육용(500g)', 22, 18500, '', 'pork_fresh_belly_500g_detail.jpg', 'pork_fresh_belly_500g_thumb.jpg', 2, 37, 0),
(1, NOW(), '무항생제 한돈 목심대패(500g)', 18, 18500, '', 'pork_fresh_slicedneck_500g_detail.jpg', 'pork_fresh_slicedneck_500g_thumb.jpg', 2, 37, 0),
(1, NOW(), '무항생제 한돈 삼겹살 구이용(500g)', 22, 18500, '', 'pork_fresh_grilledbelly_500g_detail.jpg', 'pork_fresh_grilledbelly_500g_thumb.jpg', 2, 37, 0),

-- 한우 (38)
(1, NOW(), '1등급이상 한우 국거리용 세절(300g/냉장)', 50, 10900, '', 'beef_korean_soupcut_300g_detail.jpg', 'beef_korean_soupcut_300g_thumb.jpg', 2, 38, 0),
(1, NOW(), '1등급이상 한우 다짐육 (200g/냉장)', 38, 7400, '', 'beef_korean_ground_200g_detail.jpg', 'beef_korean_ground_200g_thumb.jpg', 2, 38, 0),
(1, NOW(), '[특가] 1등급이상 한우 갈비살 (200g/냉장)', 43, 22500, '', 'beef_korean_rib_200g_detail.jpg', 'beef_korean_rib_200g_thumb.jpg', 2, 38, 0),
(1, NOW(), '미경산한우 1+등급 채끝 구이용(200g)', 23, 29900, '', 'beef_korean1p_striploin_200g_detail.jpg', 'beef_korean1p_striploin_200g_thumb.jpg', 2, 38, 0),
(1, NOW(), '미경산한우 1+등급 등심 구이용(200g)', 31, 26900, '', 'beef_korean1p_loin_200g_detail.jpg', 'beef_korean1p_loin_200g_thumb.jpg', 2, 38, 0),
(1, NOW(), '1등급이상 화식한우 등심 구이용(300g)', 46, 24900, '', 'beef_korean_fire_loin_300g_detail.jpg', 'beef_korean_fire_loin_300g_thumb.jpg', 2, 38, 0),
(1, NOW(), '1등급이상 화식한우 채끝 구이용(200g)', 52, 18900, '', 'beef_korean_fire_striploin_200g_detail.jpg', 'beef_korean_fire_striploin_200g_thumb.jpg', 2, 38, 0),
(1, NOW(), '1등급이상 화식한우 양지 국거리(300g)', 42, 17900, '', 'beef_korean_fire_brisket_300g_detail.jpg', 'beef_korean_fire_brisket_300g_thumb.jpg', 2, 38, 0),

-- 한돈 (39)
(1, NOW(), '한돈 대패 생삼겹살(냉장/300g)', 20, 11500, '', 'pork_korean_sliced_belly_300g_detail.jpg', 'pork_korean_sliced_belly_300g_thumb.jpg', 2, 39, 0),
(1, NOW(), '한돈 삼겹+목살 멀티팩(1kg)', 11, 30900, '', 'pork_korean_belly_neck_1kg_detail.jpg', 'pork_korean_belly_neck_1kg_thumb.jpg', 2, 39, 0),
(1, NOW(), '한돈 등갈비 (1kg)', 27, 26900, '', 'pork_korean_ribs_1kg_detail.jpg', 'pork_korean_ribs_1kg_thumb.jpg', 2, 39, 0),
(1, NOW(), '한돈 대패 항정살(냉장/300g)', 9, 19900, '', 'pork_korean_sliced_jowl_300g_detail.jpg', 'pork_korean_sliced_jowl_300g_thumb.jpg', 2, 39, 0),
(1, NOW(), '한돈 두꺼운 삼겹살 (500g)', 10, 17900, '', 'pork_korean_thick_belly_500g_detail.jpg', 'pork_korean_thick_belly_500g_thumb.jpg', 2, 39, 0),
(1, NOW(), '한돈 칼집삼겹살 구이용(500g)', 10, 17900, '', 'pork_korean_scored_belly_500g_detail.jpg', 'pork_korean_scored_belly_500g_thumb.jpg', 2, 39, 0),
(1, NOW(), '[특가] 무항생제 한돈 수제양념갈비 (800g)', 26, 16900, '', 'pork_korean_special_sauce_rib_800g_detail.jpg', 'pork_korean_special_sauce_rib_800g_thumb.jpg', 2, 39, 0),
(1, NOW(), '우리돼지 삼겹살 구이용(500g)', 14, 14450, '', 'pork_our_belly_grill_500g_detail.jpg', 'pork_our_belly_grill_500g_thumb.jpg', 2, 39, 0),

-- 제주돼지 (40)
(1, NOW(), '제주 흑돼지 간장 불고기(300g)', 37, 5480, '', 'pork_jeju_soy_bulgogi_300g_detail.jpg', 'pork_jeju_soy_bulgogi_300g_thumb.jpg', 2, 40, 0),
(1, NOW(), '제주 흑돼지 고추장 불고기(300g)', 32, 5900, '', 'pork_jeju_chili_bulgogi_300g_detail.jpg', 'pork_jeju_chili_bulgogi_300g_thumb.jpg', 2, 40, 0),
(1, NOW(), '제주돼지 삼겹살(샤브용, 300g)', 14, 15800, '', 'pork_jeju_belly_shabu_300g_detail.jpg', 'pork_jeju_belly_shabu_300g_thumb.jpg', 2, 40, 0),
(1, NOW(), '제주 흑돼지 뒷다리살(불고기용, 500g)', 8, 7800, '', 'pork_jeju_ham_bulgogi_500g_detail.jpg', 'pork_jeju_ham_bulgogi_500g_thumb.jpg', 2, 40, 0),
(1, NOW(), '제주돼지 앞다리살(불고기용, 500g)', 26, 13800, '', 'pork_jeju_shoulder_bulgogi_500g_detail.jpg', 'pork_jeju_shoulder_bulgogi_500g_thumb.jpg', 2, 40, 0),
(1, NOW(), '제주 흑돼지 목살(300g)', 23, 17500, '', 'pork_jeju_neck_300g_detail.jpg', 'pork_jeju_neck_300g_thumb.jpg', 2, 40, 0),
(1, NOW(), '제주돼지 목살(샤브용, 300g)', 14, 15800, '', 'pork_jeju_neck_shabu_300g_detail.jpg', 'pork_jeju_neck_shabu_300g_thumb.jpg', 2, 40, 0),
(1, NOW(), '제주돼지 목살(구이용, 300g)', 14, 15800, '', 'pork_jeju_neck_grill_300g_detail.jpg', 'pork_jeju_neck_grill_300g_thumb.jpg', 2, 40, 0),

-- 닭 (41) / 오리 (42)
(1, NOW(), '무항생제 아랫날개 (윙/300g)', 24, 4900, '', 'chicken_fresh_wing_300g_detail.jpg', 'chicken_fresh_wing_300g_thumb.jpg', 2, 41, 0),
(1, NOW(), '10無 무항생제 더건강한 오리훈제(400g)', 35, 10900, '', 'duck_fresh_smoked_400g_detail.jpg', 'duck_fresh_smoked_400g_thumb.jpg', 2, 42, 0),
(1, NOW(), '춘천식 닭갈비 (2~3인분, 600g/냉장)', 34, 8400, '', 'chicken_chuncheon_rib_600g_detail.jpg', 'chicken_chuncheon_rib_600g_thumb.jpg', 2, 47, 0), -- 양념육
(1, NOW(), '간장 닭갈비(2~3인분, 600g/냉장)', 34, 8400, '', 'chicken_soysauce_rib_600g_detail.jpg', 'chicken_soysauce_rib_600g_thumb.jpg', 2, 47, 0), -- 양념육
(1, NOW(), '무항생제 닭가슴살 두배더 절단육 (1.3kg)', 34, 7900, '', 'chicken_fresh_breast_1_3kg_detail.jpg', 'chicken_fresh_breast_1_3kg_thumb.jpg', 2, 41, 0),
(1, NOW(), '무항생제 오리 다리살 슬라이스 (350g)', 27, 7200, '', 'duck_fresh_leg_350g_detail.jpg', 'duck_fresh_leg_350g_thumb.jpg', 2, 42, 0),
(1, NOW(), '[특가] 춘천 순살 닭갈비 (400g)', 26, 7100, '', 'chicken_chuncheon_boneless_400g_detail.jpg', 'chicken_chuncheon_boneless_400g_thumb.jpg', 2, 47, 0), -- 양념육
(1, NOW(), '자연실록 치킨스테이크 (250g)', 35, 4500, '', 'chicken_nature_steak_250g_detail.jpg', 'chicken_nature_steak_250g_thumb.jpg', 2, 41, 0),

-- 소고기 (43)
(1, NOW(), '티본 스테이크(550g)', 12, 49500, '', 'beef_tbone_550g_detail.jpg', 'beef_tbone_550g_thumb.jpg', 2, 43, 0),
(1, NOW(), '엘본 스테이크(450g)', 6, 45500, '', 'beef_elbone_450g_detail.jpg', 'beef_elbone_450g_thumb.jpg', 2, 43, 0),
(1, NOW(), 'U.S.비프 우삼겹(냉동/500g)', 13, 9990, '', 'beef_us_brisket_500g_detail.jpg', 'beef_us_brisket_500g_thumb.jpg', 2, 43, 0),

-- 유기농소고기 (44)
(1, NOW(), '호주 청정 오가닉 소고기 등심(250g)', 26, 17900, '', 'beef_au_organic_loin_250g_detail.jpg', 'beef_au_organic_loin_250g_thumb.jpg', 2, 44, 0),
(1, NOW(), '호주 청정 오가닉 소고기 채끝(200g)', 9, 16900, '', 'beef_au_organic_striploin_200g_detail.jpg', 'beef_au_organic_striploin_200g_thumb.jpg', 2, 44, 0),
(1, NOW(), '호주 청정 오가닉 소고기 불고기(300g)', 17, 14500, '', 'beef_au_organic_bulgogi_300g_detail.jpg', 'beef_au_organic_bulgogi_300g_thumb.jpg', 2, 44, 0),
(1, NOW(), '호주 청정 오가닉 소고기 안심(200g)', 6, 29900, '', 'beef_au_organic_tenderloin_200g_detail.jpg', 'beef_au_organic_tenderloin_200g_thumb.jpg', 2, 44, 0),
(1, NOW(), '호주 청정 오가닉 소고기 다짐육(200g)', 9, 12900, '', 'beef_au_organic_ground_200g_detail.jpg', 'beef_au_organic_ground_200g_thumb.jpg', 2, 44, 0),

-- 육가공 (45) / 족발 (46)
(1, NOW(), '[존쿡델리미트] 팜프레시 전G 베이컨(100g)', 7, 5880, '', 'ham_johncook_bacon_100g_detail.jpg', 'ham_johncook_bacon_100g_thumb.jpg', 2, 45, 0),
(1, NOW(), '자연별곡 궁중 소불고기(4인분,600g)', 8, 16300, '', 'beef_nature_bulgogi_600g_detail.jpg', 'beef_nature_bulgogi_600g_thumb.jpg', 2, 45, 0),
(1, NOW(), '자연공법 프리미엄 훈제오리(400g)', 15, 13500, '', 'duck_premium_smoked_400g_detail.jpg', 'duck_premium_smoked_400g_thumb.jpg', 2, 45, 0),
(1, NOW(), '참숯 등갈비 (500g)', 24, 12900, '', 'pork_chamsut_rib_500g_detail.jpg', 'pork_chamsut_rib_500g_thumb.jpg', 2, 47, 0), -- 양념육
(1, NOW(), '바베큐폭립 (500g)', 25, 11900, '', 'pork_bbq_rib_500g_detail.jpg', 'pork_bbq_rib_500g_thumb.jpg', 2, 47, 0), -- 양념육
(1, NOW(), '참맛다한 유황먹인 오리훈제(400g)', 25, 11800, '', 'duck_uhwang_smoked_400g_detail.jpg', 'duck_uhwang_smoked_400g_thumb.jpg', 2, 45, 0),
(1, NOW(), '오리지널 쪽갈비 (500g)', 27, 10900, '', 'pork_original_rib_500g_detail.jpg', 'pork_original_rib_500g_thumb.jpg', 2, 47, 0), -- 양념육

-- 양념육 (47)
(1, NOW(), '[특가] 맛있는 숯불 양념 막창(200g/냉장)', 29, 6980, '', 'pork_yangnyeom_makchang_200g_detail.jpg', 'pork_yangnyeom_makchang_200g_thumb.jpg', 2, 47, 0),
(1, NOW(), '동물복지 한돈 제육볶음(500g) l 하이포크', 33, 9900, '', 'pork_welfare_jeyuk_500g_detail.jpg', 'pork_welfare_jeyuk_500g_thumb.jpg', 2, 47, 0),
(1, NOW(), '[특가] 동물복지 소금구이 닭갈비 (400g)', 19, 8900, '', 'chicken_salt_rib_400g_detail.jpg', 'chicken_salt_rib_400g_thumb.jpg', 2, 47, 0),
(1, NOW(), '구어조은닭 순살 치킨(500g/냉장)', 28, 7900, '', 'chicken_grilled_boneless_500g_detail.jpg', 'chicken_grilled_boneless_500g_thumb.jpg', 2, 47, 0)
;
