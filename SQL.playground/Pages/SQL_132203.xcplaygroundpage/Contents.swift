/*
 흉부외과 또는 일반외과 의사 목록 출력하기
 
 문제 설명
 다음은 종합병원에 속한 의사 정보를 담은DOCTOR 테이블입니다. DOCTOR 테이블은 다음과 같으며 DR_NAME, DR_ID, LCNS_NO, HIRE_YMD, MCDP_CD, TLNO는 각각 의사이름, 의사ID, 면허번호, 고용일자, 진료과코드, 전화번호를 나타냅니다.

 Column name    Type    Nullable
 DR_NAME    VARCHAR(20)    FALSE
 DR_ID    VARCHAR(10)    FALSE
 LCNS_NO    VARCHAR(30)    FALSE
 HIRE_YMD    DATE    FALSE
 MCDP_CD    VARCHAR(6)    TRUE
 TLNO    VARCHAR(50)    TRUE
 문제
 DOCTOR 테이블에서 진료과가 흉부외과(CS)이거나 일반외과(GS)인 의사의 이름, 의사ID, 진료과, 고용일자를 조회하는 SQL문을 작성해주세요. 이때 결과는 고용일자를 기준으로 내림차순 정렬하고, 고용일자가 같다면 이름을 기준으로 오름차순 정렬해주세요.

 예시
 DOCTOR 테이블이 다음과 같을 때

 DR_NAME    DR_ID    LCNS_NO    HIRE_YMD    MCDP_CD    TLNO
 루피    DR20090029    LC00010001    2009-03-01    CS    01085482011
 패티    DR20090001    LC00010901    2009-07-01    CS    01085220122
 뽀로로    DR20170123    LC00091201    2017-03-01    GS    01034969210
 티거    DR20100011    LC00011201    2010-03-01    NP    01034229818
 품바    DR20090231    LC00011302    2015-11-01    OS    01049840278
 티몬    DR20090112    LC00011162    2010-03-01    FM    01094622190
 니모    DR20200012    LC00911162    2020-03-01    CS    01089483921
 오로라    DR20100031    LC00010327    2010-11-01    OS    01098428957
 자스민    DR20100032    LC00010192    2010-03-01    GS    01023981922
 벨    DR20100039    LC00010562    2010-07-01    GS    01058390758
 SQL을 실행하면 다음과 같이 출력되어야 합니다.

 DR_NAME    DR_ID    MCDP_CD    HIRE_YMD
 니모    DR20200012    CS    2020-03-01
 뽀로로    DR20170123    GS    2017-03-01
 벨    DR20100039    GS    2010-07-01
 자스민    DR20100032    GS    2010-03-01
 패티    DR20090001    CS    2009-07-01
 루피    DR20090029    CS    2009-03-01
 주의사항
 날짜 포맷은 예시와 동일하게 나와야합니다.
 */

SELECT DR_NAME, DR_ID, MCDP_CD, TO_CHAR(HIRE_YMD, 'YYYY-MM-DD') AS HIRE_YMD // TO_CHAR로 DATE 변환하기
FROM DOCTOR
WHERE MCDP_CD IN('CS', 'GS')    // IN('', '')로 포함 여부 확인하기
ORDER BY HIRE_YMD DESC, DR_NAME;
