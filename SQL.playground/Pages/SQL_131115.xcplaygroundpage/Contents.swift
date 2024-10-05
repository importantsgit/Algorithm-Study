/*
 가격이 제일 비싼 식품의 정보 출력하기
 
 문제 설명
 다음은 식품의 정보를 담은 FOOD_PRODUCT 테이블입니다. FOOD_PRODUCT 테이블은 다음과 같으며 PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE는 식품 ID, 식품 이름, 식품 코드, 식품분류, 식품 가격을 의미합니다.

 Column name    Type    Nullable
 PRODUCT_ID    VARCHAR(10)    FALSE
 PRODUCT_NAME    VARCHAR(50)    FALSE
 PRODUCT_CD    VARCHAR(10)    TRUE
 CATEGORY    VARCHAR(10)    TRUE
 PRICE    NUMBER    TRUE
 문제
 FOOD_PRODUCT 테이블에서 가격이 제일 비싼 식품의 식품 ID, 식품 이름, 식품 코드, 식품분류, 식품 가격을 조회하는 SQL문을 작성해주세요.

 예시
 FOOD_PRODUCT 테이블이 다음과 같을 때

 PRODUCT_ID    PRODUCT_NAME    PRODUCT_CD    CATEGORY    PRICE
 P0018    맛있는고추기름    CD_OL00008    식용유    6100
 P0019    맛있는카놀라유    CD_OL00009    식용유    5100
 P0020    맛있는산초유    CD_OL00010    식용유    6500
 P0021    맛있는케첩    CD_OL00001    소스    4500
 P0022    맛있는마요네즈    CD_OL00002    소스    4700
 SQL을 실행하면 다음과 같이 출력되어야 합니다.

 PRODUCT_ID    PRODUCT_NAME    PRODUCT_CD    CATEGORY    PRICE
 P0020    맛있는산초유    CD_OL00010    식용유
 */

SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE
FROM (
    SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE
    FROM FOOD_PRODUCT
    ORDER BY PRICE DESC
)
WHERE ROWNUM = 1;


// 이 방식으로 쓸 수 있다!!
// FETCH FIRST 1 ROWS ONLY; OR FETCH FIRST ROW ONLY;
SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE
FROM FOOD_PRODUCT
ORDER BY PRICE DESC
FETCH FIRST ROW ONLY;
