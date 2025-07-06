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

-- category_id = 1 (농산)
UPDATE sub_category SET category_id = 1 WHERE id IN (
  1, 6, 14, 15, 19, 20, 21, 22, 23, 24,
  25, 26, 27, 28, 29, 30, 31, 32, 33, 61,
  100
);

-- category_id = 2 (축산)
UPDATE sub_category SET category_id = 2 WHERE id IN (
  34, 35, 36, 37, 38, 39, 40, 41, 42, 43,
  44, 45, 46, 47, 107
);

-- category_id = 3 (수산)
UPDATE sub_category SET category_id = 3 WHERE id IN (
  63, 64, 65, 66, 67, 68, 69, 70, 71, 72,
  73, 74, 75, 76
);

-- category_id = 4 (간편식)
UPDATE sub_category SET category_id = 4 WHERE id IN (
  3, 4, 6, 7, 8, 9, 10, 11, 12, 13,
  88, 89, 90, 91, 92, 93, 95, 96, 97, 98,
  99, 101, 102, 103, 104, 105, 106
);

-- category_id = 5 (간식)
UPDATE sub_category SET category_id = 5 WHERE id IN (
  78, 79, 80, 81, 82, 83, 84, 85, 86, 87,
  50, 15, 9, 48, 49, 52, 53, 54, 55, 56,
  57, 58, 59, 60, 62
);

UPDATE sub_category SET category_id = 1 WHERE id = 2;   -- 과일 → 농산
UPDATE sub_category SET category_id = 1 WHERE id = 5;   -- 국 → 농산
UPDATE sub_category SET category_id = 5 WHERE id = 14;  -- 간식 → 간식
UPDATE sub_category SET category_id = 4 WHERE id = 16;  -- 생활 → 간편식
UPDATE sub_category SET category_id = 4 WHERE id = 17;  -- 주방 → 간편식
UPDATE sub_category SET category_id = 4 WHERE id = 18;  -- 브랜드상품 → 간편식
UPDATE sub_category SET category_id = 4 WHERE id = 51;  -- 식혜 → 간편식
UPDATE sub_category SET category_id = 4 WHERE id = 77;  -- 가공 → 간편식
UPDATE sub_category SET category_id = 3 WHERE id = 94;  -- 소금 → 수산


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

SELECT id, name, category_id FROM product WHERE category_id IS NULL;

select * from product;

INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES

DELETE FROM product
WHERE id NOT IN (
    SELECT MIN(id)
    FROM (
        SELECT MIN(id) AS id
        FROM product
        GROUP BY name, price, category_id
    ) AS sub
);

SELECT COUNT(*) AS cnt
FROM product p
JOIN category c ON p.category_id = c.id
WHERE c.name IN ('GAP', '우리땅과일', '수입과일', '친환경채소', '우리땅채소', '샐러드채소', '즙용채소', '간편채소', '버섯', '건나물', '쌀', '잡곡', '견과', '선식')
  AND p.active = 1;
  
-- [신선하게 자라난 농산물 섹션]
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- GAP
(1, NOW(), 'GAP 하우스감귤(500g/2S-S)', 20, 6900, '', 'gap_mandarin_500g_detail.jpg', 'gap_mandarin_500g_thumb.jpg', 2, 22, 0),
(1, NOW(), 'GAP 하우스감귤(2kg/L-2L)', 30, 17900, '', 'gap_mandarin_2kg_detail.jpg', 'gap_mandarin_2kg_thumb.jpg', 2, 22, 0),
(1, NOW(), 'GAP 달콤 부사사과(1.5kg/5-7입)', 25, 15900, '', 'gap_apple_15kg_detail.jpg', 'gap_apple_15kg_thumb.jpg', 2, 22, 0),
(1, NOW(), '저탄소GAP 의성 부사사과(5-6입/1kg)', 18, 15000, '', 'gap_apple_1kg_detail.jpg', 'gap_apple_1kg_thumb.jpg', 2, 22, 0),
(1, NOW(), '저탄소 백도 복숭아(4-7입/1.25kg)', 18, 15000, '', 'lowcarbon_peach_white_detail.jpg', 'lowcarbon_peach_white_thumb.jpg', 2, 22, 0),
(1, NOW(), '저탄소GAP 하우스 꼬마밀감(1kg)', 25, 14500, '', 'gap_kid_mandarin_1kg_detail.jpg', 'gap_kid_mandarin_1kg_thumb.jpg', 2, 22, 0),
(1, NOW(), '저탄소 황도 복숭아(4-7입/1.25kg)', 26, 13500, '', 'lowcarbon_peach_yellow_detail.jpg', 'lowcarbon_peach_yellow_thumb.jpg', 2, 22, 0),
(1, NOW(), 'GAP 청송 부사사과(5-7입/1.3kg)', 18, 13000, '', 'gap_apple_cheongsong_13kg_detail.jpg', 'gap_apple_cheongsong_13kg_thumb.jpg', 2, 22, 0),

-- 우리땅과일
(1, NOW(), '유기농 성주 참외(4-6입/1.2kg)', 30, 12000, '', 'organic_chamoe_12kg_detail.jpg', 'organic_chamoe_12kg_thumb.jpg', 2, 23, 0),
(1, NOW(), 'GAP 머스크멜론(2kg)', 20, 12000, '', 'gap_muskmelon_2kg_detail.jpg', 'gap_muskmelon_2kg_thumb.jpg', 2, 23, 0),
(1, NOW(), 'GAP 머스크멜론(1.6kg)', 15, 11000, '', 'gap_muskmelon_16kg_detail.jpg', 'gap_muskmelon_16kg_thumb.jpg', 2, 23, 0),

-- 수입과일
(1, NOW(), '유기농 블루베리 (500g/냉동)', 42, 7990, '', 'imported_blueberry_500g_detail.jpg', 'imported_blueberry_500g_thumb.jpg', 2, 24, 0),
(1, NOW(), '[특가] 스위티오 파인애플 슬라이스(540g)', 23, 9900, '', 'imported_pineapple_slice_540g_detail.jpg', 'imported_pineapple_slice_540g_thumb.jpg', 2, 24, 0),
(1, NOW(), '[특가] 스위티오 파인애플 조각(400g)', 27, 6300, '', 'imported_pineapple_piece_400g_detail.jpg', 'imported_pineapple_piece_400g_thumb.jpg', 2, 24, 0),
(1, NOW(), '컷팅 파인애플 (400g)', 26, 5350, '', 'imported_pineapple_cut_400g_detail.jpg', 'imported_pineapple_cut_400g_thumb.jpg', 2, 24, 0),
(1, NOW(), '700m 고산지 바나나(1.3kg내외)', 27, 3900, '', 'imported_banana_13kg_detail.jpg', 'imported_banana_13kg_thumb.jpg', 2, 24, 0),
(1, NOW(), '700m 고산지 바나나 (1kg내외)', 36, 2800, '', 'imported_banana_1kg_detail.jpg', 'imported_banana_1kg_thumb.jpg', 2, 24, 0),
(1, NOW(), '[추천상품] 대용량 블루베리 (1kg)', 25, 10500, '', 'imported_blueberry_1kg_detail.jpg', 'imported_blueberry_1kg_thumb.jpg', 2, 24, 0),

-- 친환경채소
(1, NOW(), '유기농 유러피안 채소 모듬 (4종, 1kg 내외)', 51, 12500, '', 'organic_european_vege_1kg_detail.jpg', 'organic_european_vege_1kg_thumb.jpg', 1, 25, 0),
(1, NOW(), '무농약 유러피안 채소 모둠 (500g/박스)', 41, 7810, '', 'pesticidefree_european_vege_500g_detail.jpg', 'pesticidefree_european_vege_500g_thumb.jpg', 1, 25, 0),
(1, NOW(), '유기농 미니로메인 (170g 내외)', 34, 2950, '', 'organic_mini_romaine_170g_detail.jpg', 'organic_mini_romaine_170g_thumb.jpg', 1, 25, 0),
(1, NOW(), '[BEST]무농약이상 대파(500g)', 37, 2490, '', 'pesticidefree_greenonion_500g_detail.jpg', 'pesticidefree_greenonion_500g_thumb.jpg', 1, 25, 0),
(1, NOW(), '무농약 프릴아이스 1봉 (90g내외)', 29, 2490, '', 'pesticidefree_frill_90g_detail.jpg', 'pesticidefree_frill_90g_thumb.jpg', 1, 25, 0),
(1, NOW(), '[신규]오이맛고추 (150g) /무농약', 26, 2100, '', 'pesticidefree_cucumberpepper_150g_detail.jpg', 'pesticidefree_cucumberpepper_150g_thumb.jpg', 1, 25, 0),
(1, NOW(), '[신규]즙용 당근(1kg)/무농약', 28, 4000, '', 'pesticidefree_juice_carrot_1kg_detail.jpg', 'pesticidefree_juice_carrot_1kg_thumb.jpg', 1, 25, 0),
(1, NOW(), '[쿠폰20%]감자 (800g이상)/무농약', 25, 3350, '', 'pesticidefree_potato_800g_detail.jpg', 'pesticidefree_potato_800g_thumb.jpg', 1, 25, 0),

-- 우리땅채소
(1, NOW(), '[20% 쿠폰] 국내산 두백 햇감자 (특~대, 1.7kg내외)', 34, 6500, '', 'korean_newpotato_17kg_detail.jpg', 'korean_newpotato_17kg_thumb.jpg', 1, 26, 0),
(1, NOW(), '국내산 친환경 와일드루꼴라 (50g)', 24, 2830, '', 'korean_wild_rucola_50g_detail.jpg', 'korean_wild_rucola_50g_thumb.jpg', 1, 26, 0),
(1, NOW(), 'GAP 삼겹살용 모둠쌈 (350g/팩)', 32, 5990, '', 'gap_samgyeopsal_ssam_350g_detail.jpg', 'gap_samgyeopsal_ssam_350g_thumb.jpg', 1, 26, 0),
(1, NOW(), '국내산 초당옥수수 (특/3입)', 44, 4990, '', 'korean_chodang_corn_3ea_detail.jpg', 'korean_chodang_corn_3ea_thumb.jpg', 1, 26, 0),
(1, NOW(), '친환경 양배추 (1통, 1.3kg내외/무농약이상)', 34, 4250, '', 'pesticidefree_cabbage_13kg_detail.jpg', 'pesticidefree_cabbage_13kg_thumb.jpg', 1, 26, 0),
(1, NOW(), '[행사] GAP 파프리카 3-4입 (특/혼합/550g이상)', 33, 3980, '', 'gap_paprika_mix_550g_detail.jpg', 'gap_paprika_mix_550g_thumb.jpg', 1, 26, 0),
(1, NOW(), '국내산 양파1.5kg(6개입)', 25, 3590, '', 'korean_onion_15kg_detail.jpg', 'korean_onion_15kg_thumb.jpg', 1, 26, 0),

-- 샐러드채소
(1, NOW(), '파프리카 혼합믹스 샐러드 (200g)', 45, 2990, '', 'paprika_salad_mix_200g_detail.jpg', 'paprika_salad_mix_200g_thumb.jpg', 1, 27, 0),
(1, NOW(), '고소한 리코타 치즈와 시금치 페스토 샐러드 (185g/240kcal)', 10, 6550, '', 'ricotta_spinach_salad_185g_detail.jpg', 'ricotta_spinach_salad_185g_thumb.jpg', 1, 27, 0),
(1, NOW(), '[저스트그린] 국내산 당근 라페(200g)', 25, 5450, '', 'justgreen_carrot_rappe_200g_detail.jpg', 'justgreen_carrot_rappe_200g_thumb.jpg', 1, 27, 0),
(1, NOW(), '방울토마토 믹스 샐러드 (200g)', 45, 2990, '', 'cherrytomato_salad_200g_detail.jpg', 'cherrytomato_salad_200g_thumb.jpg', 1, 27, 0),
(1, NOW(), '어린잎&캐비지 실속샐러드 (200g)', 45, 2990, '', 'youngleaf_cabbage_salad_200g_detail.jpg', 'youngleaf_cabbage_salad_200g_thumb.jpg', 1, 27, 0),

-- 즙용/간편채소
(1, NOW(), '[특가]당근 (500g,특등품)/무농약', 31, 2760, '', 'pesticidefree_carrot_500g_detail.jpg', 'pesticidefree_carrot_500g_thumb.jpg', 1, 28, 0),
(1, NOW(), '[특가]양배추 (1통, 1.1kg 내외)/무농약', 34, 2680, '', 'pesticidefree_cabbage_11kg_detail.jpg', 'pesticidefree_cabbage_11kg_thumb.jpg', 1, 28, 0),
(1, NOW(), '친환경 이탈리안 믹스샐러드(80g)', 20, 2500, '', 'pesticidefree_italianmix_80g_detail.jpg', 'pesticidefree_italianmix_80g_thumb.jpg', 1, 28, 0),
(1, NOW(), '국내산 햇양파 (1kg 내외)', 40, 2350, '', 'korean_onion_1kg_detail.jpg', 'korean_onion_1kg_thumb.jpg', 1, 28, 0),
(1, NOW(), '국내산 당근(2-3입/500g내외)', 36, 1980, '', 'korean_carrot_500g_detail.jpg', 'korean_carrot_500g_thumb.jpg', 1, 28, 0),
(1, NOW(), '[특가]양배추(소, 700g 내외)/무농약', 39, 1950, '', 'pesticidefree_cabbage_s_700g_detail.jpg', 'pesticidefree_cabbage_s_700g_thumb.jpg', 1, 28, 0),
(1, NOW(), '[특가]GAP 쌈케일 (100g)', 23, 1300, '', 'gap_ssamkale_100g_detail.jpg', 'gap_ssamkale_100g_thumb.jpg', 1, 28, 0),

-- 버섯/건나물
(1, NOW(), '국산 데친 곤드레 (250g)', 36, 4600, '', 'korean_gondre_250g_detail.jpg', 'korean_gondre_250g_thumb.jpg', 1, 30, 0),
(1, NOW(), '국산 데친 취나물 (250g)', 20, 4300, '', 'korean_chwinamul_250g_detail.jpg', 'korean_chwinamul_250g_thumb.jpg', 1, 30, 0),
(1, NOW(), '국산 데친 비름나물 (250g)', 28, 3300, '', 'korean_bireumnamul_250g_detail.jpg', 'korean_bireumnamul_250g_thumb.jpg', 1, 30, 0),
(1, NOW(), '[행사]무농약 팽이버섯 (350g)', 41, 1090, '', 'pesticidefree_enoki_350g_detail.jpg', 'pesticidefree_enoki_350g_thumb.jpg', 1, 30, 0),
(1, NOW(), '[행사]무농약 표고버섯(특/180g전후)', 38, 3300, '', 'pesticidefree_shiitake_180g_detail.jpg', 'pesticidefree_shiitake_180g_thumb.jpg', 1, 30, 0),
(1, NOW(), '[건강버섯추천]무농약 갈색팽이버섯(200g)', 30, 1880, '', 'pesticidefree_brown_enoki_200g_detail.jpg', 'pesticidefree_brown_enoki_200g_thumb.jpg', 1, 30, 0),
(1, NOW(), '국산 건고사리 (70g)', 36, 9500, '', 'korean_dried_gosari_70g_detail.jpg', 'korean_dried_gosari_70g_thumb.jpg', 1, 30, 0),

-- 쌀/잡곡
(1, NOW(), '용추 유기농 백미 (10kg 단일품종)', 33, 46500, '', 'rice_white_10kg_detail.jpg', 'rice_white_10kg_thumb.jpg', 1, 32, 0),
(1, NOW(), '월향미 국내산 미호 품종/특등급 10kg', 17, 42100, '', 'rice_miho_10kg_detail.jpg', 'rice_miho_10kg_thumb.jpg', 1, 32, 0),
(1, NOW(), '용추 유기농 백미 (8kg, 단일품종)', 32, 37500, '', 'rice_white_8kg_detail.jpg', 'rice_white_8kg_thumb.jpg', 1, 32, 0),
(1, NOW(), '용추 유기농 현미 (4kg, 단일품종)', 28, 21000, '', 'rice_brown_4kg_detail.jpg', 'rice_brown_4kg_thumb.jpg', 1, 32, 0),
(1, NOW(), '용추 유기농 찹쌀 (2kg)', 11, 15800, '', 'rice_glutinous_2kg_detail.jpg', 'rice_glutinous_2kg_thumb.jpg', 1, 32, 0),
(1, NOW(), '용추 유기농 오분도미 (4kg, 단일품종)', 22, 22900, '', 'rice_obundomi_4kg_detail.jpg', 'rice_obundomi_4kg_thumb.jpg', 1, 32, 0),
(1, NOW(), '월향미 국내산 미호 품종/특등급 소포장 5kg(500gx10개입)', 25, 22500, '', 'rice_miho_5kg_detail.jpg', 'rice_miho_5kg_thumb.jpg', 1, 32, 0),
(1, NOW(), '용추 유기농 백미 (4kg, 단일품종)', 38, 19000, '', 'rice_white_4kg_detail.jpg', 'rice_white_4kg_thumb.jpg', 1, 32, 0),

-- 견과/선식
(1, NOW(), '웰콩 서리태볶음가루(500g)', 25, 16500, '', 'wellkong_blackbean_powder_500g_detail.jpg', 'wellkong_blackbean_powder_500g_thumb.jpg', 1, 33, 0),
(1, NOW(), '크리스피코코넛(300g)', 12, 13000, '', 'crispy_coconut_300g_detail.jpg', 'crispy_coconut_300g_thumb.jpg', 1, 33, 0),
(1, NOW(), '유가원 호두강정 (120g)', 6, 12000, '', 'yugawon_walnut_120g_detail.jpg', 'yugawon_walnut_120g_thumb.jpg', 1, 33, 0),
(1, NOW(), '무농약 볶은땅콩(200g)', 23, 9900, '', 'pesticidefree_roasted_peanut_200g_detail.jpg', 'pesticidefree_roasted_peanut_200g_thumb.jpg', 1, 33, 0),
(1, NOW(), '무농약 생땅콩(200g)', 25, 9600, '', 'pesticidefree_raw_peanut_200g_detail.jpg', 'pesticidefree_raw_peanut_200g_thumb.jpg', 1, 33, 0),
(1, NOW(), '인쉘 마카다미아(310g)', 25, 8900, '', 'inshell_macadamia_310g_detail.jpg', 'inshell_macadamia_310g_thumb.jpg', 1, 33, 0),
(1, NOW(), '달콤바삭 호두정과 (140g)', 21, 5900, '', 'sweet_walnut_jeonggwa_140g_detail.jpg', 'sweet_walnut_jeonggwa_140g_thumb.jpg', 1, 33, 0),
(1, NOW(), '유기농 병아리콩(칙피) 병조림 (350g)', 12, 4800, '', 'organic_chickpea_350g_detail.jpg', 'organic_chickpea_350g_thumb.jpg', 1, 33, 0);

-- [ 농장에서 식탁까지 신선축산 ]
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

-- [ 내 몸은 내가 챙긴다! 건강/음료 ] 
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES

-- 건강즙류 (간식-건강즙)
(1, NOW(), '맑은농장 힘내요 흑염소 진액(70ml x 30포)', 32, 29900, '', 'health_blackgoat_detail.jpg', 'health_blackgoat_thumb.jpg', 5, 48, 0),
(1, NOW(), '[특가] 밀양 얼음골 사과즙 (110mlx30포)', 18, 17900, '', 'health_apple_detail.jpg', 'health_apple_thumb.jpg', 5, 48, 0),
(1, NOW(), '면역플러스 엘더베리 시럽(280ml)', 15, 30500, '', 'health_elderberry_detail.jpg', 'health_elderberry_thumb.jpg', 5, 48, 0),
(1, NOW(), '자연을담은 조은여주즙(100ml×30포)', 21, 28900, '', 'health_bittermelon_detail.jpg', 'health_bittermelon_thumb.jpg', 5, 48, 0),
(1, NOW(), '김소형원방 장어진액 70g*30포', 42, 28800, '', 'health_eel_detail.jpg', 'health_eel_thumb.jpg', 5, 48, 0),
(1, NOW(), '코프레시 1박스(15포)', 20, 25600, '', 'health_cofresh_detail.jpg', 'health_cofresh_thumb.jpg', 5, 48, 0),
(1, NOW(), '정직한 칡즙 (120mlx30포)', 30, 24900, '', 'health_arrowroot_detail.jpg', 'health_arrowroot_thumb.jpg', 5, 48, 0),
(1, NOW(), '김소형원방 흑염소진 70ml*30포', 46, 24000, '', 'health_blackgoatjin_detail.jpg', 'health_blackgoatjin_thumb.jpg', 5, 48, 0),

-- 영양제류 (간식-영양제)
(1, NOW(), '무설탕 멀티비타민 구미(4봉/4주분/84알)', 50, 8900, '', 'supplement_multivitamin_detail.jpg', 'supplement_multivitamin_thumb.jpg', 5, 52, 0),
(1, NOW(), '라엘밸런스 질건강 리스펙타 프로바이오틱스(여성유산균,30캡슐)', 33, 36500, '', 'supplement_respecta_detail.jpg', 'supplement_respecta_thumb.jpg', 5, 52, 0),
(1, NOW(), '허벌랜드 비타민B 컴플렉스 맥스 에너지 식물성젤리(35구미)', 20, 19900, '', 'supplement_vitaminb_detail.jpg', 'supplement_vitaminb_thumb.jpg', 5, 52, 0),
(1, NOW(), '[3박스] 장인정신 10억 유산균 3개월분 (2g*30포*3개)', 55, 35900, '', 'supplement_lactic3_detail.jpg', 'supplement_lactic3_thumb.jpg', 5, 52, 0),
(1, NOW(), '라엘밸런스 미오 이노시톨 앤 콜린(5gX30포)', 22, 35000, '', 'supplement_myo_detail.jpg', 'supplement_myo_thumb.jpg', 5, 52, 0),
(1, NOW(), '장인정신 에브리데이 10억 프로바이오틱스 유산균 (2g*30포)', 52, 12900, '', 'supplement_lactic_detail.jpg', 'supplement_lactic_thumb.jpg', 5, 52, 0),

-- 홍삼/인삼류 (간식-홍삼)
(1, NOW(), '한삼인 산삼배양근 본(本) 16병 (+쇼핑백증정)', 57, 37200, '', 'extract_sansam_detail.jpg', 'extract_sansam_thumb.jpg', 5, 56, 0),
(1, NOW(), '6년근 홍삼정 농축진액(240g)', 38, 120000, '', 'ginseng_6y_extract_detail.jpg', 'ginseng_6y_extract_thumb.jpg', 5, 56, 0),
(1, NOW(), '[특가] 6년근 진한 홍삼 (80ml x 60포)', 51, 97000, '', 'ginseng_6y_jinhan_detail.jpg', 'ginseng_6y_jinhan_thumb.jpg', 5, 56, 0),
(1, NOW(), '6년근 홍삼정 진한스틱(10ml x 30포)', 50, 48000, '', 'ginseng_6y_stick_detail.jpg', 'ginseng_6y_stick_thumb.jpg', 5, 56, 0),
(1, NOW(), '[젤리타입] 똑똑한 어린이홍삼(20g* 30포)', 51, 39000, '', 'ginseng_kidsjelly_detail.jpg', 'ginseng_kidsjelly_thumb.jpg', 5, 56, 0),
(1, NOW(), '[특가] 6년근 순한홍삼(80ml x 60포)', 45, 33000, '', 'ginseng_6y_soft_detail.jpg', 'ginseng_6y_soft_thumb.jpg', 5, 56, 0),
(1, NOW(), '황풍정 홍삼양갱(45g x 16개입) [쇼핑백포함]', 16, 25200, '', 'ginseng_yanggan_detail.jpg', 'ginseng_yanggan_thumb.jpg', 5, 56, 0),
(1, NOW(), '한삼인 멀티비타G이뮨샷 10병(+쇼핑백증정)', 50, 27500, '', 'extract_multivita_detail.jpg', 'extract_multivita_thumb.jpg', 5, 56, 0),

-- 환류 (간식-환)
(1, NOW(), '김소형원방 녹용산삼배양근침향단 60환', 61, 38500, '', 'pill_antler_detail.jpg', 'pill_antler_thumb.jpg', 5, 60, 0),
(1, NOW(), '국산 마늘 청국장환(150g)', 30, 7000, '', 'pill_garlic_detail.jpg', 'pill_garlic_thumb.jpg', 5, 60, 0),

-- 죽염 (간식-죽염)
(1, NOW(), '태평 대나무 구운 죽염 (300g)', 17, 9800, '', 'pill_bamboo_detail.jpg', 'pill_bamboo_thumb.jpg', 5, 58, 0),

-- 건강 분말/쉐이크류 (간편식-분말)
(1, NOW(), '무농약 강황분말(100g)', 19, 9700, '', 'pill_turmeric_detail.jpg', 'pill_turmeric_thumb.jpg', 4, 90, 0),
(1, NOW(), '[맘메이크] 진한단백 쑥 단백질쉐이크(500g/통)', 22, 25600, '', 'grain_mugwortshake_detail.jpg', 'grain_mugwortshake_thumb.jpg', 4, 90, 0),
(1, NOW(), '[맘메이크] 비건 단백질 미숫가루(500g/통)', 20, 23900, '', 'grain_veganpowder_detail.jpg', 'grain_veganpowder_thumb.jpg', 4, 90, 0),

-- 잡곡/선식류 (농산-잡곡/선식)
(1, NOW(), '100% 땅콩 스프레드 스틱(20g x 14포)', 20, 15800, '', 'grain_peanutspread_detail.jpg', 'grain_peanutspread_thumb.jpg', 1, 32, 0),

-- 두유류 (간식-두유)
(1, NOW(), '소이퀸 서리태 콩물(500ml)', 25, 7400, '', 'extract_blackbean_detail.jpg', 'extract_blackbean_thumb.jpg', 5, 82, 0),
(1, NOW(), '소이퀸 진한콩물(500ml)', 25, 5400, '', 'extract_soy_detail.jpg', 'extract_soy_thumb.jpg', 5, 82, 0),
(1, NOW(), '소이퀸 두유(350ml)', 26, 3700, '', 'extract_soymilk_detail.jpg', 'extract_soymilk_thumb.jpg', 5, 82, 0),
(1, NOW(), '[입점특가] 베지밀 국산 검은콩두유(190ml x 16팩)', 25, 12700, '', 'grain_blackbeanmilk_detail.jpg', 'grain_blackbeanmilk_thumb.jpg', 5, 82, 0),

-- 액상/엑기스 (간식-엑기스)
(1, NOW(), '유기농 알로에베라겔 주스(1050ml)', 18, 23500, '', 'extract_aloevera_detail.jpg', 'extract_aloevera_thumb.jpg', 5, 55, 0),

-- 엑기스 (간식-엑기스)
(1, NOW(), '면역플러스 엘더베리 시럽(280ml)', 15, 30500, '', 'health_elderberry_detail.jpg', 'health_elderberry_thumb.jpg', 5, 55, 0),

-- 천연과즙 (간식-천연과즙)
(1, NOW(), '정직한 도라지배즙 (110ml×30포)', 45, 17500, '', 'juice_pearplatycodon_detail.jpg', 'juice_pearplatycodon_thumb.jpg', 5, 53, 0),
(1, NOW(), '맑은농장 당근사과주스 (100mlx10개)', 17, 11500, '', 'juice_carrotapple_detail.jpg', 'juice_carrotapple_thumb.jpg', 5, 53, 0),
(1, NOW(), '아임리얼 스트로베리 (700ml)', 0, 10980, '', 'juice_strawberry_detail.jpg', 'juice_strawberry_thumb.jpg', 5, 53, 0),
(1, NOW(), '아임리얼 당근 (700ml)', 0, 10980, '', 'juice_carrot_detail.jpg', 'juice_carrot_thumb.jpg', 5, 53, 0),
(1, NOW(), '아임리얼 케일사과 (700ml)', 0, 10980, '', 'juice_kaleapple_detail.jpg', 'juice_kaleapple_thumb.jpg', 5, 53, 0),
(1, NOW(), '아임리얼 토마토 (700ml)', 9, 9980, '', 'juice_tomato_detail.jpg', 'juice_tomato_thumb.jpg', 5, 53, 0),

-- 음료 (간식-음료)
(1, NOW(), '유기농 하늘보리 (500mL x 6개)', 57, 6300, '', 'drink_barley_detail.jpg', 'drink_barley_thumb.jpg', 5, 15, 0),
(1, NOW(), '야쿠르트 1971(750ml×2입)', 16, 5980, '', 'drink_yakult1971_detail.jpg', 'drink_yakult1971_thumb.jpg', 5, 15, 0),
(1, NOW(), '자연은 알로에 제로 (500mL x 6개)', 51, 6300, '', 'beverage_aloezero_detail.jpg', 'beverage_aloezero_thumb.jpg', 5, 15, 0),
(1, NOW(), '[박스] 캐치! 티니핑 솔브앤고 아이튼튼 딸기 (150mL x 24입)', 56, 21060, '', 'beverage_tinyping_strawberry_detail.jpg', 'beverage_tinyping_strawberry_thumb.jpg', 5, 15, 0),
(1, NOW(), '[박스] 캐치! 티니핑 솔브앤고 아이튼튼 초코 (150mL x 24입)', 56, 20900, '', 'beverage_tinyping_choco_detail.jpg', 'beverage_tinyping_choco_thumb.jpg', 5, 15, 0),
(1, NOW(), '야쿠르트 1971 제로(190ml×24팩)', 38, 14800, '', 'beverage_yakultzero_detail.jpg', 'beverage_yakultzero_thumb.jpg', 5, 15, 0),

-- 식혜 (간편식-식혜)
(1, NOW(), '[특가]하늘청 유기농 식혜 (1.8L)', 30, 6900, '', 'beverage_sikhye_detail.jpg', 'beverage_sikhye_thumb.jpg', 4, 51, 0),
(1, NOW(), '찰보리쌀 냉식혜(500ml, 냉동)', 33, 2380, '', 'juice_barleyshikhye_detail.jpg', 'juice_barleyshikhye_thumb.jpg', 4, 51, 0),

-- 잼 (간식-잼)
(1, NOW(), '마이노멀 저당 매실청 (550g)', 31, 10900, '', 'beverage_plum_detail.jpg', 'beverage_plum_thumb.jpg', 5, 9, 0),

-- 커피 (간식-커피)
(1, NOW(), '커피빈 카페라떼 파우치(190mLX10P)', 32, 12900, '', 'drink_coffeebeanlatte_detail.jpg', 'drink_coffeebeanlatte_thumb.jpg', 5, 50, 0),
(1, NOW(), '커피빈 바닐라라떼 파우치(190mLX10P)', 36, 12120, '', 'drink_coffeebeanvanilla_detail.jpg', 'drink_coffeebeanvanilla_thumb.jpg', 5, 50, 0),
(1, NOW(), '하노이트림 드립백커피 10g×20개 (고소한맛)', 17, 11900, '', 'drink_hanoitrim_detail.jpg', 'drink_hanoitrim_thumb.jpg', 5, 50, 0),
(1, NOW(), '커피빈 디카페인 아메리카노 파우치(230mLX10P)', 39, 11420, '', 'drink_coffeebeandeca_detail.jpg', 'drink_coffeebeandeca_thumb.jpg', 5, 50, 0),

-- 차류 (간식-차류)
(1, NOW(), '햄스테드 유기농 허브티 컬렉션 (5종 x 4티백)', 26, 9450, '', 'grain_herbtea_detail.jpg', 'grain_herbtea_thumb.jpg', 5, 62, 0),
(1, NOW(), '햄스테드 유기농 루이보스(2g x 20티백)', 0, 11900, '', 'grain_rooibos_detail.jpg', 'grain_rooibos_thumb.jpg', 5, 62, 0),
(1, NOW(), '햄스테드 유기농 페퍼민트&스피아민트(1.5g x 20티백)', 0, 11900, '', 'drink_peppermint_detail.jpg', 'drink_peppermint_thumb.jpg', 5, 62, 0),
(1, NOW(), '햄스테드 유기농 차 선물세트 56티백', 0, 39900, '', 'grain_teaset_detail.jpg', 'grain_teaset_thumb.jpg', 5, 62, 0)
;

-- [ 바다향 가득 품은 수산물 ]
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
-- 🐟 새벽수산 (sub_category_id=63)
(1, NOW(), '생연어회(200g)', 15, 16900, '', 'fish_salmon_200g_detail.jpg', 'fish_salmon_200g_thumb.jpg', 3, 63, 0),
(1, NOW(), '국산 생물 오징어(3~4미 550g)', 33, 17800, '', 'fish_squid_3_4_detail.jpg', 'fish_squid_3_4_thumb.jpg', 3, 63, 0),
(1, NOW(), '대광어회(200g)', 20, 15800, '', 'fish_flatfish_200g_detail.jpg', 'fish_flatfish_200g_thumb.jpg', 3, 63, 0),
(1, NOW(), '국내산 자숙 문어 (자숙후/1kg이상)', 21, 50900, '', 'fish_octopus_1kg_detail.jpg', 'fish_octopus_1kg_thumb.jpg', 3, 63, 0),
(1, NOW(), '제주 손질 갈치(1미, 380g 이상)', 17, 29800, '', 'fish_hairtail_jeju_1_detail.jpg', 'fish_hairtail_jeju_1_thumb.jpg', 3, 63, 0),
(1, NOW(), '[판매가인하]노르웨이 생연어(횟감용 / 500g)', 26, 28500, '', 'fish_salmon_500g_detail.jpg', 'fish_salmon_500g_thumb.jpg', 3, 63, 0),
(1, NOW(), '프리미엄 칠레 성게알 (100g)', 8, 21900, '', 'fish_urchin_100g_detail.jpg', 'fish_urchin_100g_thumb.jpg', 3, 63, 0),
(1, NOW(), '제주 손질 갈치 (먹갈치/3미/650g)', 35, 19980, '', 'fish_hairtail_jeju_3_detail.jpg', 'fish_hairtail_jeju_3_thumb.jpg', 3, 63, 0),

-- 🐟 일반생선 (sub_category_id=64)
(1, NOW(), '손질 자반 고등어(2미)', 25, 8700, '', 'fish_mackerel_2_detail.jpg', 'fish_mackerel_2_thumb.jpg', 3, 64, 0),
(1, NOW(), '[특가] 영광 법성포 굴비 (10미/950g 이상)', 25, 71250, '', 'fish_croaker_10_detail.jpg', 'fish_croaker_10_thumb.jpg', 3, 64, 0),
(1, NOW(), '광어필렛(횟감용/250g)', 25, 17800, '', 'fish_flatfish_fillet_detail.jpg', 'fish_flatfish_fillet_thumb.jpg', 3, 64, 0),
(1, NOW(), '노르웨이 저염 고등어 스테이크(900g,특대 5팩)', 29, 16500, '', 'fish_mackerel_steak_detail.jpg', 'fish_mackerel_steak_thumb.jpg', 3, 64, 0),
(1, NOW(), '국내산 가시제거 고등어 (700g)', 18, 15900, '', 'fish_mackerel_nobone_detail.jpg', 'fish_mackerel_nobone_thumb.jpg', 3, 64, 0),

-- 🐟 연어 (sub_category_id=65)
(1, NOW(), '[판매가인하]노르웨이 생연어(횟감용 / 300g)', 27, 17500, '', 'fish_salmon_300g_detail.jpg', 'fish_salmon_300g_thumb.jpg', 3, 65, 0),

-- 🐟 참치 (sub_category_id=66)
(1, NOW(), '[패키지]태평양 황다랑어 참치 (100gx4)', 30, 10050, '', 'fish_tuna_100gx4_detail.jpg', 'fish_tuna_100gx4_thumb.jpg', 3, 66, 0),
(1, NOW(), '태평양 황다랑어 참치 (대용량/150g)', 26, 3860, '', 'fish_tuna_150g_detail.jpg', 'fish_tuna_150g_thumb.jpg', 3, 66, 0),
(1, NOW(), '[특가/패키지]MSC인증 태평양 야채참치 (100gx4)', 30, 8540, '', 'fish_tuna_veg_100gx4_detail.jpg', 'fish_tuna_veg_100gx4_thumb.jpg', 3, 66, 0),
(1, NOW(), 'MSC인증 태평양 고추참치 (대용량/150g)', 28, 3300, '', 'fish_tuna_chili_150g_detail.jpg', 'fish_tuna_chili_150g_thumb.jpg', 3, 66, 0),
(1, NOW(), 'MSC인증 태평양 야채참치 (대용량/150g)', 35, 2900, '', 'fish_tuna_veg_150g_detail.jpg', 'fish_tuna_veg_150g_thumb.jpg', 3, 66, 0),

-- 🦑 오징어 (sub_category_id=67)
(1, NOW(), '국내산 바로 먹는 손질문어(300g)', 32, 17400, '', 'fish_octopus_ready_300g_detail.jpg', 'fish_octopus_ready_300g_thumb.jpg', 3, 67, 0),
(1, NOW(), '자연산 손질 왕쭈꾸미 (330g 이상)', 27, 9980, '', 'fish_webfoot_octopus_detail.jpg', 'fish_webfoot_octopus_thumb.jpg', 3, 67, 0),
(1, NOW(), '자숙 홍가리비살 (500g)', 34, 9900, '', 'fish_scallop_500g_detail.jpg', 'fish_scallop_500g_thumb.jpg', 3, 69, 0),
(1, NOW(), '국산 손질오징어 1미 (190g 이상)', 35, 6900, '', 'fish_squid_1_detail.jpg', 'fish_squid_1_thumb.jpg', 3, 67, 0),
(1, NOW(), '오동통 오만둥이 (300g)', 24, 1880, '', 'fish_mandungi_300g_detail.jpg', 'fish_mandungi_300g_thumb.jpg', 3, 67, 0),
(1, NOW(), '바로먹는 문어 슬라이스 (200g)', 25, 12900, '', 'fish_octopus_slice_200g_detail.jpg', 'fish_octopus_slice_200g_thumb.jpg', 3, 67, 0),

-- 🦐 새우 (sub_category_id=68)
(1, NOW(), '자연산 국산 대하(1kg)', 12, 35800, '', 'fish_shrimp_korea_1kg_detail.jpg', 'fish_shrimp_korea_1kg_thumb.jpg', 3, 68, 0),
(1, NOW(), '무항생제 손질새우 (500g)', 13, 33000, '', 'fish_shrimp_clean_500g_detail.jpg', 'fish_shrimp_clean_500g_thumb.jpg', 3, 68, 0),
(1, NOW(), '국내산 왕새우 소금구이 (500g)', 27, 14500, '', 'fish_shrimp_bbq_500g_detail.jpg', 'fish_shrimp_bbq_500g_thumb.jpg', 3, 68, 0),

-- 🦪 조개 (sub_category_id=69)
(1, NOW(), '통영 자연산 바지락 (800g)', 29, 8500, '', 'fish_clam_800g_detail.jpg', 'fish_clam_800g_thumb.jpg', 3, 69, 0),
(1, NOW(), '완도 활전복 (5-7미, 320g 이상)', 25, 13700, '', 'fish_abalone_320g_detail.jpg', 'fish_abalone_320g_thumb.jpg', 3, 69, 0),
(1, NOW(), '통영 홍가리비 (봉지,1kg내외)', 45, 6500, '', 'fish_scallop_tongyeong_1kg_detail.jpg', 'fish_scallop_tongyeong_1kg_thumb.jpg', 3, 69, 0),
(1, NOW(), '통영 생홍합살(200g)', 18, 6500, '', 'fish_mussel_200g_detail.jpg', 'fish_mussel_200g_thumb.jpg', 3, 69, 0),

-- 🐟 멸치 (sub_category_id=70)
(1, NOW(), '[진한맛] 로스팅 멸치 국물팩 (13g x 10팩)', 25, 6600, '', 'fish_anchovy_pack_detail.jpg', 'fish_anchovy_pack_thumb.jpg', 3, 70, 0),

-- 🦑 액젓 (sub_category_id=71)
(1, NOW(), '프리미엄 참치액 (500ml)', 22, 14300, '', 'fish_tuna_sauce_500ml_detail.jpg', 'fish_tuna_sauce_500ml_thumb.jpg', 3, 71, 0),
(1, NOW(), '한라참치액 (500ml)', 16, 7900, '', 'fish_halla_tuna_sauce_500ml_detail.jpg', 'fish_halla_tuna_sauce_500ml_thumb.jpg', 3, 71, 0),

-- 🧂 젓갈 (sub_category_id=72)
(1, NOW(), '신안새우추젓(1kg)', 26, 20500, '', 'fish_shrimp_jeot_1kg_detail.jpg', 'fish_shrimp_jeot_1kg_thumb.jpg', 3, 72, 0),
(1, NOW(), '정갈한 명란젓 (230g)', 29, 11000, '', 'fish_pollock_roe_jeot_230g_detail.jpg', 'fish_pollock_roe_jeot_230g_thumb.jpg', 3, 72, 0),
(1, NOW(), '정갈한 멍게젓(200g)', 25, 10800, '', 'fish_seasquirt_jeot_200g_detail.jpg', 'fish_seasquirt_jeot_200g_thumb.jpg', 3, 72, 0),
(1, NOW(), '정갈한 창난젓 (230g)', 26, 9200, '', 'fish_cod_intestine_jeot_230g_detail.jpg', 'fish_cod_intestine_jeot_230g_thumb.jpg', 3, 72, 0),
(1, NOW(), '정갈한 꼴뚜기젓(200g)', 25, 8400, '', 'fish_baby_squid_jeot_200g_detail.jpg', 'fish_baby_squid_jeot_200g_thumb.jpg', 3, 72, 0),
(1, NOW(), '정갈한 명태초무침(200g)', 27, 7600, '', 'fish_pollock_mix_200g_detail.jpg', 'fish_pollock_mix_200g_thumb.jpg', 3, 72, 0),

-- 🥢 김 (sub_category_id=73)
(1, NOW(), '곱창김 (100장,350g이상)', 24, 37900, '', 'fish_gopchang_100_detail.jpg', 'fish_gopchang_100_thumb.jpg', 3, 73, 0),
(1, NOW(), '쌈싸먹는 곱창김(7.2g*20입)', 32, 28500, '', 'fish_gopchang_7_2g_20_detail.jpg', 'fish_gopchang_7_2g_20_thumb.jpg', 3, 73, 0),
(1, NOW(), '곱창김 (60장,180g이상)', 20, 15900, '', 'fish_gopchang_60_detail.jpg', 'fish_gopchang_60_thumb.jpg', 3, 73, 0),
(1, NOW(), '구운곱창김 1봉 20g', 22, 3500, '', 'fish_gopchang_roasted_20g_detail.jpg', 'fish_gopchang_roasted_20g_thumb.jpg', 3, 73, 0),
(1, NOW(), '쌈싸먹는 곱창김(7.2g)', 32, 1700, '', 'fish_gopchang_7_2g_detail.jpg', 'fish_gopchang_7_2g_thumb.jpg', 3, 73, 0),

-- 🥢 해조/건어물 (sub_category_id=74/75)
(1, NOW(), '오봉산 꽃부각 오리지널맛(100g)', 19, 8500, '', 'fish_flower_snack_100g_detail.jpg', 'fish_flower_snack_100g_thumb.jpg', 3, 74, 0),
(1, NOW(), '[시원한맛] 꽃게해물 로스팅 국물팩(13gx10팩)', 25, 6600, '', 'fish_crab_pack_detail.jpg', 'fish_crab_pack_thumb.jpg', 3, 75, 0),

-- 🐠 어묵/가공 (sub_category_id=76/77)
(1, NOW(), '강고집 육수한포 80g(4g*20ea)', 22, 6900, '', 'fish_soup_pack_80g_detail.jpg', 'fish_soup_pack_80g_thumb.jpg', 3, 76, 0),
(1, NOW(), '순살광어 솥밥키트 (425g/2인분)', 12, 10500, '', 'fish_flatfish_ricekit_detail.jpg', 'fish_flatfish_ricekit_thumb.jpg', 3, 77, 0),
(1, NOW(), '붉은대게살 (100g/냉장)', 42, 7500, '', 'fish_red_crab_100g_detail.jpg', 'fish_red_crab_100g_thumb.jpg', 3, 77, 0),
(1, NOW(), '정직한 네모 꼬치어묵 (320g/10개입)', 4, 6900, '', 'fish_square_fishcake_detail.jpg', 'fish_square_fishcake_thumb.jpg', 3, 76, 0),
(1, NOW(), '동태전 슬라이스 (400g)', 10, 6430, '', 'fish_pollock_slice_400g_detail.jpg', 'fish_pollock_slice_400g_thumb.jpg', 3, 77, 0),
(1, NOW(), '정직한 부산어묵 얇은사각(200g) x 3개입', 50, 5900, '', 'fish_thin_fishcake_200gx3_detail.jpg', 'fish_thin_fishcake_200gx3_thumb.jpg', 3, 76, 0)
;

-- [ 요즘 인기있는 간식 ]
-- 인기 간식: 과자/빵
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
(1, NOW(), '[특가] 우리밀 대추 약과세트 (50gX10개입)', 19, 11900, '', 'yakgwa_detail.jpg', 'yakgwa_thumb.jpg', 5, 80, 0),
(1, NOW(), '모센즈스위트 카이막 (84g)', 38, 10500, '', 'kaymak_detail.jpg', 'kaymak_thumb.jpg', 5, 8, 0),
(1, NOW(), '우리밀 순한 소시지 핫도그(80gX5입)', 20, 8800, '', 'hotdog_detail.jpg', 'hotdog_thumb.jpg', 5, 8, 0),
(1, NOW(), '[입점특가] 수제 감자빵 1박스(100gx6개입)', 37, 14900, '', 'potatobread_detail.jpg', 'potatobread_thumb.jpg', 5, 8, 0),
(1, NOW(), '알곡 그대로 통밀 식빵 (450g)', 20, 5200, '', 'wholewheat_bread_detail.jpg', 'wholewheat_bread_thumb.jpg', 5, 8, 0),
(1, NOW(), '아비삭 딸기 라이스볼 (30g)', 22, 3900, '', 'strawberry_riceball_detail.jpg', 'strawberry_riceball_thumb.jpg', 5, 78, 0),
(1, NOW(), '아비삭과일칩 딸기 (14g)', 10, 3500, '', 'strawberry_chip_detail.jpg', 'strawberry_chip_thumb.jpg', 5, 78, 0),
(1, NOW(), '통밀 크림빵 (60g)', 16, 3000, '', 'cream_bread_detail.jpg', 'cream_bread_thumb.jpg', 5, 8, 0);

-- 인기 간식: 떡/한과/엿
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
(1, NOW(), '[선물하기/쇼핑백] 안동참마 모나카(12입)', 30, 15900, '', 'monaka12_detail.jpg', 'monaka12_thumb.jpg', 5, 81, 0),
(1, NOW(), '[1+1]안동참마 모나카(5입)', 14, 11900, '', 'monaka5_detail.jpg', 'monaka5_thumb.jpg', 5, 81, 0),
(1, NOW(), '우유 가득 설기(450g)', 0, 6900, '', 'sulgi_detail.jpg', 'sulgi_thumb.jpg', 5, 79, 0),
(1, NOW(), '엄마손 우리쌀떡볶이(700g)', 45, 6800, '', 'tteokbokki_detail.jpg', 'tteokbokki_thumb.jpg', 5, 79, 0),
(1, NOW(), '낭만부부 고구마가래떡(235g)', 22, 3500, '', 'sweetpotato_tteok_detail.jpg', 'sweetpotato_tteok_thumb.jpg', 5, 79, 0),
(1, NOW(), '모짜렐라 치즈가래떡(235g)', 22, 3500, '', 'mozzarella_tteok_detail.jpg', 'mozzarella_tteok_thumb.jpg', 5, 79, 0),
(1, NOW(), '초코 쌀 오란다(28gx10개입)', 10, 13000, '', 'choco_oranda_detail.jpg', 'choco_oranda_thumb.jpg', 5, 80, 0),
(1, NOW(), '달곰 쌀 오란다(26gx10개입)', 20, 12000, '', 'sweet_oranda_detail.jpg', 'sweet_oranda_thumb.jpg', 5, 80, 0);

-- 인기 간식: 두유/유제품
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
(1, NOW(), '마시는 그릭 요거트 정석(1.8L 플레인요거트)', 37, 7300, '', 'greek_yogurt_detail.jpg', 'greek_yogurt_thumb.jpg', 5, 83, 0),
(1, NOW(), '[임실치즈마을] 프로바이오 요거트 (120mlX3개, 플레인 | 스트로베리 | 블루베리)', 18, 4900, '', 'probiotic_yogurt_detail.jpg', 'probiotic_yogurt_thumb.jpg', 5, 83, 0),
(1, NOW(), '[특가] 그릭타임 그릭요거트 소프트 2구 번들 (100gx2개)', 44, 4980, '', 'greek_time_detail.jpg', 'greek_time_thumb.jpg', 5, 83, 0),
(1, NOW(), '[특가] 비락 올바른 클래식우유 200ml(낱개)', 23, 990, '', 'classic_milk_detail.jpg', 'classic_milk_thumb.jpg', 5, 83, 0),
(1, NOW(), '프로바이오 블루베리 요거트 (450ml)', 15, 5100, '', 'probiotic_blueberry_detail.jpg', 'probiotic_blueberry_thumb.jpg', 5, 83, 0),
(1, NOW(), '검은콩 영양 두유 (180ml×20)', 26, 17000, '', 'blackbean_soymilk_detail.jpg', 'blackbean_soymilk_thumb.jpg', 5, 82, 0),
(1, NOW(), '[반짝특가] 베지밀 국산 검은콩두유(190ml x 16팩)', 30, 11900, '', 'vegemil_soymilk_detail.jpg', 'vegemil_soymilk_thumb.jpg', 5, 82, 0),
(1, NOW(), '비락 올바른 클래식우유 12개입(박스)', 25, 11880, '', 'classic_milk_box_detail.jpg', 'classic_milk_box_thumb.jpg', 5, 83, 0);

-- 인기 간식: 선식
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
(1, NOW(), '[맘메이크] 진한단백 쑥 단백질쉐이크(500g/통)', 22, 25600, '', 'ssuk_shake_detail.jpg', 'ssuk_shake_thumb.jpg', 5, 33, 0),
(1, NOW(), '[맘메이크] 블랙 단백질쉐이크(500g/통)', 19, 25900, '', 'black_shake_detail.jpg', 'black_shake_thumb.jpg', 5, 33, 0),
(1, NOW(), '[맘메이크] 비건 단백질 미숫가루(500g/통)', 20, 23900, '', 'vegan_misugaru_detail.jpg', 'vegan_misugaru_thumb.jpg', 5, 33, 0),
(1, NOW(), '웰콩 서리태볶음가루(500g)', 25, 16500, '', 'seritae_powder_detail.jpg', 'seritae_powder_thumb.jpg', 5, 33, 0),
(1, NOW(), '찰보리쌀 냉식혜(500ml, 냉동)', 33, 2380, '', 'barley_sikhye_500_detail.jpg', 'barley_sikhye_500_thumb.jpg', 5, 33, 0),
(1, NOW(), '찰보리쌀 냉식혜(1500ml, 냉동)', 30, 4900, '', 'barley_sikhye_1500_detail.jpg', 'barley_sikhye_1500_thumb.jpg', 5, 33, 0),
(1, NOW(), '유기농 미숫가루(500g)', 7, 8800, '', 'organic_misugaru_detail.jpg', 'organic_misugaru_thumb.jpg', 5, 33, 0),
(1, NOW(), '프리미엄 현미마죽(30gx20스틱)', 18, 13000, '', 'brownrice_porridge_detail.jpg', 'brownrice_porridge_thumb.jpg', 5, 33, 0);

-- 인기 간식: 사탕/젤리/초콜릿
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
(1, NOW(), '무설탕 멀티비타민 구미(4봉/4주분/84알)', 50, 8900, '', 'multi_gummy_detail.jpg', 'multi_gummy_thumb.jpg', 5, 85, 0),
(1, NOW(), '[신제품] 젤리블리 애플망고 (60gX6입)', 9, 5000, '', 'applemango_jelly_detail.jpg', 'applemango_jelly_thumb.jpg', 5, 85, 0),
(1, NOW(), '허벌랜드 비타민B 컴플렉스 맥스 에너지 식물성젤리(35구미)', 20, 19900, '', 'vitaminB_jelly_detail.jpg', 'vitaminB_jelly_thumb.jpg', 5, 85, 0),
(1, NOW(), '초코헬스 말차넛츠 박스 (25g x 10봉)', 32, 14200, '', 'matcha_nuts_choco_detail.jpg', 'matcha_nuts_choco_thumb.jpg', 5, 86, 0),
(1, NOW(), '벨기에 수제초콜릿 스틱 선물세트 (5구)', 30, 13900, '', 'belgium_choco_stick_detail.jpg', 'belgium_choco_stick_thumb.jpg', 5, 86, 0),
(1, NOW(), '초코헬스 제로넛츠 박스 (25g x 10봉)', 22, 13900, '', 'zero_nuts_choco_detail.jpg', 'zero_nuts_choco_thumb.jpg', 5, 86, 0),
(1, NOW(), '유기농 다크 100% 초콜릿(80g)', 20, 9900, '', 'dark100_choco_detail.jpg', 'dark100_choco_thumb.jpg', 5, 86, 0),
(1, NOW(), '유기농 다크 85% 초콜릿(100g)', 20, 7800, '', 'dark85_choco_detail.jpg', 'dark85_choco_thumb.jpg', 5, 86, 0);

-- 인기 간식: 시리얼
INSERT INTO product (
  active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views
) VALUES
(1, NOW(), '갓구운 유기농 통곡물 크리스피 (400g)', 25, 15600, '', 'organic_crispy_detail.jpg', 'organic_crispy_thumb.jpg', 5, 87, 0),
(1, NOW(), '크놀라 솔티드 캬라멜 그래놀라 (200g)', 0, 12000, '', 'salted_caramel_granola_detail.jpg', 'salted_caramel_granola_thumb.jpg', 5, 87, 0),
(1, NOW(), '벨기에산 오리지널 100% 그래놀라 (900g)', 16, 10900, '', 'belgium_granola_detail.jpg', 'belgium_granola_thumb.jpg', 5, 87, 0),
(1, NOW(), '모던구루 크런치 츄러스 수제 그래놀라 (230g)', 10, 9900, '', 'guru_churros_granola_detail.jpg', 'guru_churros_granola_thumb.jpg', 5, 87, 0),
(1, NOW(), '열풍으로 구워낸 오곡 혼합곡 (410g)', 16, 9900, '', 'mixed_grains410_detail.jpg', 'mixed_grains410_thumb.jpg', 5, 87, 0),
(1, NOW(), '열풍으로 구워낸 고소한 현미 (300g)', 16, 9900, '', 'roasted_brownrice_detail.jpg', 'roasted_brownrice_thumb.jpg', 5, 87, 0),
(1, NOW(), '유기농 단백한 견과바(33g*5입)', 9, 9800, '', 'nutbar_detail.jpg', 'nutbar_thumb.jpg', 5, 87, 0),
(1, NOW(), '유기농 그래놀라 사과&건포도 (400g)', 11, 8800, '', 'granola_apple_raisin_detail.jpg', 'granola_apple_raisin_thumb.jpg', 5, 87, 0);

-- [ 더 건강하게! 더 맛있게! 양념 ]
INSERT INTO product (active, created_at, name, percent, price, description, detailimg, thumbnailimg, category_id, sub_category_id, views) VALUES
-- 파스타/면
(1, NOW(), '하인즈 바질페스토(230g)', 0, 7480, '', 'heinz_basilpesto_230g_detail.jpg', 'heinz_basilpesto_230g_thumb.jpg', 4, 13, 0),
(1, NOW(), '바른식 얼큰미나리 샤브샤브 (2~3인분/밀키트)', 34, 13700, '', 'bareunsik_minari_shabushabu_2_3_detail.jpg', 'bareunsik_minari_shabushabu_2_3_thumb.jpg', 4, 13, 0),
(1, NOW(), '에머이 소고기 쌀국수 2인분(240g*2)', 17, 11900, '', 'emoi_beef_pho_2_detail.jpg', 'emoi_beef_pho_2_thumb.jpg', 4, 13, 0),
(1, NOW(), '바른식 메밀 물막국수 (2인분/밀키트)', 42, 8600, '', 'bareunsik_buckwheat_coldnoodle_2_detail.jpg', 'bareunsik_buckwheat_coldnoodle_2_thumb.jpg', 4, 13, 0),
(1, NOW(), '가벼운 고단백 두부면(넓은면,100g)', 22, 2480, '', 'light_highprotein_tofunoodle_100g_detail.jpg', 'light_highprotein_tofunoodle_100g_thumb.jpg', 4, 13, 0),
(1, NOW(), '우리밀 라면 - 매운맛(4입)', 20, 6880, '', 'woorimil_ramen_spicy_4_detail.jpg', 'woorimil_ramen_spicy_4_thumb.jpg', 4, 13, 0),
(1, NOW(), '어니언&갈릭 토마토 파스타소스(680g)', 16, 6500, '', 'onion_garlic_tomato_pastasauce_680g_detail.jpg', 'onion_garlic_tomato_pastasauce_680g_thumb.jpg', 4, 13, 0),
(1, NOW(), '트레디셔널 토마토 파스타소스(680g)', 16, 6500, '', 'traditional_tomato_pastasauce_680g_detail.jpg', 'traditional_tomato_pastasauce_680g_thumb.jpg', 4, 13, 0),

-- 밀가루/분말
(1, NOW(), '유기농 감자전분 (500g)', 42, 5980, '', 'organic_potato_starch_500g_detail.jpg', 'organic_potato_starch_500g_thumb.jpg', 4, 90, 0),
(1, NOW(), '바른식 생면 비빔국수 (2인분/밀키트)', 43, 8900, '', 'bareunsik_fresh_bibimnoodle_2_detail.jpg', 'bareunsik_fresh_bibimnoodle_2_thumb.jpg', 4, 13, 0),
(1, NOW(), '양념시간 우리밀 크림분말 100g', 36, 3800, '', 'yangnyumtime_cream_powder_100g_detail.jpg', 'yangnyumtime_cream_powder_100g_thumb.jpg', 4, 90, 0),
(1, NOW(), '양념시간 우리밀 짜장가루 100g', 36, 3800, '', 'yangnyumtime_jjajang_powder_100g_detail.jpg', 'yangnyumtime_jjajang_powder_100g_thumb.jpg', 4, 90, 0),
(1, NOW(), '국산 100% 찹쌀가루(400g)', 29, 3900, '', 'korean_glutinousrice_powder_400g_detail.jpg', 'korean_glutinousrice_powder_400g_thumb.jpg', 4, 89, 0),
(1, NOW(), '껍질벗긴 국산 들깨가루 (190g)', 20, 12000, '', 'peeled_perilla_powder_190g_detail.jpg', 'peeled_perilla_powder_190g_thumb.jpg', 4, 90, 0),
(1, NOW(), '메밀부침가루(500g)', 20, 5500, '', 'buckwheat_pancake_mix_500g_detail.jpg', 'buckwheat_pancake_mix_500g_thumb.jpg', 4, 89, 0),
(1, NOW(), '양념시간 우리밀 하이라이스 100g', 31, 4100, '', 'yangnyumtime_hayrice_100g_detail.jpg', 'yangnyumtime_hayrice_100g_thumb.jpg', 4, 90, 0),

-- 오일/참기름
(1, NOW(), '만토바 오가닉 엑스트라 버진 바질 올리브오일 (250ml)', 33, 14670, '', 'mantova_organic_basil_oliveoil_250ml_detail.jpg', 'mantova_organic_basil_oliveoil_250ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '모니니 클라시코 엑스트라버진 올리브유(1L)', 17, 32000, '', 'monini_classico_oliveoil_1l_detail.jpg', 'monini_classico_oliveoil_1l_thumb.jpg', 4, 91, 0),
(1, NOW(), '유기농 모니니 엑스트라버진 올리브유(500ml)', 28, 25000, '', 'monini_organic_oliveoil_500ml_detail.jpg', 'monini_organic_oliveoil_500ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '아페이론 엑스트라버진 올리브오일 (500ml)', 30, 20900, '', 'apeyron_oliveoil_500ml_detail.jpg', 'apeyron_oliveoil_500ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '돈나소피아 엑스트라버진 올리브오일 (500ml)', 26, 13900, '', 'donnasophia_oliveoil_500ml_detail.jpg', 'donnasophia_oliveoil_500ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '만토바 트러플향 엑스트라 버진 올리브오일 스프레이 (200ml)', 34, 13790, '', 'mantova_truffle_oliveoil_spray_200ml_detail.jpg', 'mantova_truffle_oliveoil_spray_200ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '만토바 레몬향 엑스트라 버진 올리브오일 스프레이 (200ml)', 30, 13230, '', 'mantova_lemon_oliveoil_spray_200ml_detail.jpg', 'mantova_lemon_oliveoil_spray_200ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '모니니 엑스트라버진 블랙트러플향 올리브오일(250ml)', 35, 12980, '', 'monini_blacktruffle_oliveoil_250ml_detail.jpg', 'monini_blacktruffle_oliveoil_250ml_thumb.jpg', 4, 91, 0),

-- 케찹/잼류
(1, NOW(), '[러브앤피넛] 100% 국내산 땅콩버터 스무스 (210g)', 17, 14800, '', 'loveandpeanut_smooth_210g_detail.jpg', 'loveandpeanut_smooth_210g_thumb.jpg', 5, 9, 0),
(1, NOW(), '슈퍼너츠 100% 피넛버터 스무스(460g)', 10, 14400, '', 'supernuts_smooth_460g_detail.jpg', 'supernuts_smooth_460g_thumb.jpg', 5, 9, 0),
(1, NOW(), '모센즈스위트 카이막 (84g)', 38, 10500, '', 'mosensweet_kaymak_84g_detail.jpg', 'mosensweet_kaymak_84g_thumb.jpg', 5, 9, 0),
(1, NOW(), '하인즈 당을 줄인 토마토 케찹(369g)', 0, 5480, '', 'heinz_tomato_ketchup_369g_detail.jpg', 'heinz_tomato_ketchup_369g_thumb.jpg', 5, 9, 0),
(1, NOW(), '슈퍼너츠 100% 피넛버터 크런치(460g)', 10, 14400, '', 'supernuts_crunch_460g_detail.jpg', 'supernuts_crunch_460g_thumb.jpg', 5, 9, 0),
(1, NOW(), '베리해피넛 100% 땅콩버터 크런치(275g)', 33, 9900, '', 'berryhappynut_crunch_275g_detail.jpg', 'berryhappynut_crunch_275g_thumb.jpg', 5, 9, 0),
(1, NOW(), '베리해피넛 100% 땅콩버터 크리미(275g)', 33, 9900, '', 'berryhappynut_creamy_275g_detail.jpg', 'berryhappynut_creamy_275g_thumb.jpg', 5, 9, 0),
(1, NOW(), '[러브앤피넛] 100% 국내산 땅콩버터 크런치 (210g)', 17, 14800, '', 'loveandpeanut_crunch_210g_detail.jpg', 'loveandpeanut_crunch_210g_thumb.jpg', 5, 9, 0),

-- 소금/설탕/향신료
(1, NOW(), '섬들채 한우 한알육수(4g x 15개입)', 25, 4100, '', 'seomdulchae_beef_stock_4gx15_detail.jpg', 'seomdulchae_beef_stock_4gx15_thumb.jpg', 4, 106, 0),
(1, NOW(), '고맙당 저당 불닭소스 (180g)', 28, 9200, '', 'gomapdang_buldak_sauce_180g_detail.jpg', 'gomapdang_buldak_sauce_180g_thumb.jpg', 4, 104, 0),
(1, NOW(), '육수시간 국내산 치킨스톡 분말 (100g)', 24, 7900, '', 'yuksu_chicken_stock_100g_detail.jpg', 'yuksu_chicken_stock_100g_thumb.jpg', 4, 106, 0),
(1, NOW(), '섬들채 천일염 (1.5kg)', 51, 5900, '', 'seomdulchae_salt_1_5kg_detail.jpg', 'seomdulchae_salt_1_5kg_thumb.jpg', 3, 94, 0),
(1, NOW(), '구운 소금 (500g)', 12, 3500, '', 'roasted_salt_500g_detail.jpg', 'roasted_salt_500g_thumb.jpg', 3, 94, 0),
(1, NOW(), '프리미엄 참치액 (500ml)', 22, 14300, '', 'premium_tuna_sauce_500ml_detail.jpg', 'premium_tuna_sauce_500ml_thumb.jpg', 3, 71, 0),
(1, NOW(), '함초 자연 가는 소금 (450g)', 9, 13800, '', 'hamcho_fine_salt_450g_detail.jpg', 'hamcho_fine_salt_450g_thumb.jpg', 3, 94, 0),
(1, NOW(), '섬들채 천일염 (3kg)', 31, 11150, '', 'seomdulchae_salt_3kg_detail.jpg', 'seomdulchae_salt_3kg_thumb.jpg', 3, 94, 0),

-- 된장/장류
(1, NOW(), '고맙당 저당 고추장 (250g)', 20, 11900, '', 'gomapdang_ggochujang_250g_detail.jpg', 'gomapdang_ggochujang_250g_thumb.jpg', 4, 98, 0),
(1, NOW(), '순창 우리콩 전통고추장 (500g)', 10, 11100, '', 'sunchang_beankochujang_500g_detail.jpg', 'sunchang_beankochujang_500g_thumb.jpg', 4, 98, 0),
(1, NOW(), '고맙당 저당 비법고추장 (250g)', 16, 12500, '', 'gomapdang_secretggochujang_250g_detail.jpg', 'gomapdang_secretggochujang_250g_thumb.jpg', 4, 98, 0),
(1, NOW(), '명품 매실 회초장 (520g)', 25, 11100, '', 'maesil_hoechojang_520g_detail.jpg', 'maesil_hoechojang_520g_thumb.jpg', 4, 98, 0),
(1, NOW(), '고맙당 저당 초고추장 (270g)', 18, 10500, '', 'gomapdang_chogochujang_270g_detail.jpg', 'gomapdang_chogochujang_270g_thumb.jpg', 4, 98, 0),
(1, NOW(), '오색담은 소고기볶음고추장(250g)', 19, 8900, '', 'osaek_soybeefggochujang_250g_detail.jpg', 'osaek_soybeefggochujang_250g_thumb.jpg', 4, 98, 0),
(1, NOW(), '명품 매실 회초장 (310g)', 25, 7400, '', 'maesil_hoechojang_310g_detail.jpg', 'maesil_hoechojang_310g_thumb.jpg', 4, 98, 0),

-- 참깨/고춧가루
(1, NOW(), '오아시스 우리땅 고춧가루 (500g)', 32, 18900, '', 'oasis_redpepperpowder_500g_detail.jpg', 'oasis_redpepperpowder_500g_thumb.jpg', 1, 100, 0),
(1, NOW(), '청결 햇살 고춧가루 (300g)', 20, 13500, '', 'cheonggyeol_redpepperpowder_300g_detail.jpg', 'cheonggyeol_redpepperpowder_300g_thumb.jpg', 1, 100, 0),
(1, NOW(), '껍질벗긴 국산 들깨가루 (190g)', 20, 12000, '', 'peeled_perilla_powder_190g_detail.jpg', 'peeled_perilla_powder_190g_thumb.jpg', 4, 90, 0),
(1, NOW(), '[특가]국산 들깨가루 (200g)', 33, 9900, '', 'special_korean_perilla_powder_200g_detail.jpg', 'special_korean_perilla_powder_200g_thumb.jpg', 4, 90, 0),
(1, NOW(), '청결 청양고춧가루 (2종)', 19, 13300, '', 'cheonggyeol_cheongyang_redpepper_2_detail.jpg', 'cheonggyeol_cheongyang_redpepper_2_thumb.jpg', 1, 100, 0),
(1, NOW(), '국산 안심 들깨가루 (200g)', 34, 9900, '', 'safe_korean_perilla_powder_200g_detail.jpg', 'safe_korean_perilla_powder_200g_thumb.jpg', 4, 90, 0),
(1, NOW(), '국산 볶음참깨(220g)', 24, 13600, '', 'korean_roasted_sesame_220g_detail.jpg', 'korean_roasted_sesame_220g_thumb.jpg', 4, 99, 0),
(1, NOW(), '[특가]자연햇살 국물용 청양 고춧가루 (고운) (100g)', 29, 6700, '', 'special_nature_soup_cheongyangpepper_100g_detail.jpg', 'special_nature_soup_cheongyangpepper_100g_thumb.jpg', 1, 100, 0),

-- 식초/조청/꿀
(1, NOW(), '프티봉 유기농 애플 사이다 비네거 스틱(15입)', 32, 12900, '', 'petitbon_apple_vinegar_stick_15_detail.jpg', 'petitbon_apple_vinegar_stick_15_thumb.jpg', 4, 101, 0),
(1, NOW(), '[식품명인] 명인 쌀조청 (1.3kg)', 28, 10800, '', 'master_rice_syrup_1_3kg_detail.jpg', 'master_rice_syrup_1_3kg_thumb.jpg', 4, 102, 0),
(1, NOW(), '마이노멀 알룰로스 (액상형/분말형)', 9, 8900, '', 'mynormal_allulose_detail.jpg', 'mynormal_allulose_thumb.jpg', 4, 102, 0),
(1, NOW(), '클로비스 유기농 애플 사이다 비네거 (500ml)', 28, 7900, '', 'clovis_apple_vinegar_500ml_detail.jpg', 'clovis_apple_vinegar_500ml_thumb.jpg', 4, 101, 0),
(1, NOW(), '하인즈 화이트 식초(473mL)', 0, 4380, '', 'heinz_white_vinegar_473ml_detail.jpg', 'heinz_white_vinegar_473ml_thumb.jpg', 4, 101, 0),
(1, NOW(), '국내산 현미식초(900ml)', 17, 3980, '', 'korean_brownrice_vinegar_900ml_detail.jpg', 'korean_brownrice_vinegar_900ml_thumb.jpg', 4, 101, 0),
(1, NOW(), '[추천!]떠먹는 배도라지고(230g)', 20, 16800, '', 'recommended_eatpear_balloonflower_230g_detail.jpg', 'recommended_eatpear_balloonflower_230g_thumb.jpg', 4, 102, 0),
(1, NOW(), '구천동 야생화꿀 (500g)', 20, 17200, '', 'gucheondong_wildhoney_500g_detail.jpg', 'gucheondong_wildhoney_500g_thumb.jpg', 4, 103, 0),

-- 소스/드레싱/육수
(1, NOW(), '양념시간 골드키위 돈까스소스 200g', 28, 4300, '', 'yangnyumtime_goldkiwi_porkcutlet_sauce_200g_detail.jpg', 'yangnyumtime_goldkiwi_porkcutlet_sauce_200g_thumb.jpg', 4, 104, 0),
(1, NOW(), '100% 땅콩 스프레드 스틱(20g x 14포)', 20, 15800, '', 'peanut_spread_stick_20g_14_detail.jpg', 'peanut_spread_stick_20g_14_thumb.jpg', 4, 104, 0),
(1, NOW(), '만토바 오가닉 엑스트라 버진 바질 올리브오일 (250ml)', 33, 14670, '', 'mantova_organic_basil_oliveoil_250ml_detail.jpg', 'mantova_organic_basil_oliveoil_250ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '슈퍼너츠 100% 피넛버터 스무스(460g)', 10, 14400, '', 'supernuts_smooth_460g_detail.jpg', 'supernuts_smooth_460g_thumb.jpg', 4, 104, 0),
(1, NOW(), '만토바 트러플향 엑스트라 버진 올리브오일 스프레이 (200ml)', 34, 13790, '', 'mantova_truffle_oliveoil_spray_200ml_detail.jpg', 'mantova_truffle_oliveoil_spray_200ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '만토바 레몬향 엑스트라 버진 올리브오일 스프레이 (200ml)', 30, 13230, '', 'mantova_lemon_oliveoil_spray_200ml_detail.jpg', 'mantova_lemon_oliveoil_spray_200ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '만토바 기오일 스프레이 - (버터/147ml)', 32, 10810, '', 'mantova_ghee_oil_spray_147ml_detail.jpg', 'mantova_ghee_oil_spray_147ml_thumb.jpg', 4, 91, 0),
(1, NOW(), '만토바 230도 오일 스프레이 (200ml)', 36, 9140, '', 'mantova_230_oil_spray_200ml_detail.jpg', 'mantova_230_oil_spray_200ml_thumb.jpg', 4, 91, 0)
;

SELECT * FROM category;
SELECT * FROM sub_category;
