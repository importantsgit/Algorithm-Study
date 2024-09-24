/*
 나이 정보가 없는 회원 수 구하기
 
 다음은 어느 의류 쇼핑몰에 가입한 회원 정보를 담은 USER_INFO 테이블입니다. USER_INFO 테이블은 아래와 같은 구조로 되어있으며, USER_ID, GENDER, AGE, JOINED는 각각 회원 ID, 성별, 나이, 가입일을 나타냅니다.

 Column name    Type        Nullable
 USER_ID        INTEGER     FALSE
 GENDER         TINYINT(1)  TRUE
 AGE            INTEGER     TRUE
 JOINED         DATE        FALSE
 GENDER 컬럼은 비어있거나 0 또는 1의 값을 가지며 0인 경우 남자를, 1인 경우는 여자를 나타냅니다.

 문제
 USER_INFO 테이블에서 나이 정보가 없는 회원이 몇 명인지 출력하는 SQL문을 작성해주세요. 이때 컬럼명은 USERS로 지정해주세요.

 예시
 예를 들어 USER_INFO 테이블이 다음과 같다면

 USER_ID    GENDER    AGE    JOINED
 1          1         26     2021-06-01
 2          NULL      NULL   2021-07-25
 3          1         NULL   2021-07-30
 4          0         31     2021-08-03
 나이 정보가 없는 회원은 2명 이므로, 다음과 같은 결과가 나와야 합니다.

 USERS
 2
 */

SELECT SUM(AGE) AS USERS // 이거는 AGE의 합계를 구하는거고 ;;
FROM USER_INFO
WHERE AGE IS NULL;

SELECT COUNT(*) AS USERS
FROM USER_INFO
WHERE AGE IS NULL;

