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

