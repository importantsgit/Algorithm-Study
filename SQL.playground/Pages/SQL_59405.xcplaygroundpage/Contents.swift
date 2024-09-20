/*
 상위 n개 레코드
 
 문제 설명
 ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

 NAME    TYPE    NULLABLE
 ANIMAL_ID    VARCHAR(N)    FALSE
 ANIMAL_TYPE    VARCHAR(N)    FALSE
 DATETIME    DATETIME    FALSE
 INTAKE_CONDITION    VARCHAR(N)    FALSE
 NAME    VARCHAR(N)    TRUE
 SEX_UPON_INTAKE    VARCHAR(N)    FALSE
 동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요.

 예시
 예를 들어 ANIMAL_INS 테이블이 다음과 같다면

 ANIMAL_ID      ANIMAL_TYPE    DATETIME               INTAKE_CONDITION    NAME      SEX_UPON_INTAKE
 A399552        Dog            2013-10-14 15:38:00    Normal              Jack      Neutered Male
 A379998        Dog            2013-10-23 11:42:00    Normal              Disciple  Intact Male
 A370852        Dog            2013-11-03 15:04:00    Normal              Katie     Spayed Female
 A403564        Dog            2013-11-18 17:03:00    Normal              Anna      Spayed Female
 이 중 가장 보호소에 먼저 들어온 동물은 Jack입니다. 따라서 SQL문을 실행하면 다음과 같이 나와야 합니다.

 NAME
 Jack
 ※ 보호소에 가장 먼저 들어온 동물은 한 마리인 경우만 테스트 케이스로 주어집니다.
 */

SELECT NAME
FROM ANIMAL_INS
WHERE rownum = 1
ORDER BY DATETIME ASC;

// 이렇게 되면 order by 한 경우라도 insert 순서대로 순위가 붙기 때문에 소용 없음
// 따라서 인라인 뷰(서브쿼리)를 사용하여 문제 해결
// 서브쿼리 => 메인 쿼리 안에 서브 쿼리를 말함 (하나의 테이블에서 검색한 결과를 다른 테이블에 전달하여 새로운 결과를 조회할 때 사용)
SELECT NAME
FROM (
    SELECT NAME
    FROM ANIMAL_INS
    ORDER BY DATETIME ASC
)
WHERE rownum = 1;
