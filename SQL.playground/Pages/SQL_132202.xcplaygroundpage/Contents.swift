/*
 진료과별 총 예약 횟수 출력하기
 
 다음은 종합병원의 진료 예약정보를 담은 APPOINTMENT 테이블 입니다.
 APPOINTMENT 테이블은 다음과 같으며 APNT_YMD, APNT_NO, PT_NO, MCDP_CD, MDDR_ID, APNT_CNCL_YN, APNT_CNCL_YMD는 각각 진료예약일시, 진료예약번호, 환자번호, 진료과코드, 의사ID, 예약취소여부, 예약취소날짜를 나타냅니다.

 Column name    Type    Nullable
 APNT_YMD    TIMESTAMP    FALSE
 APNT_NO    NUMBER(5)    FALSE
 PT_NO    VARCHAR(10)    FALSE
 MCDP_CD    VARCHAR(6)    FALSE
 MDDR_ID    VARCHAR(10)    FALSE
 APNT_CNCL_YN    VARCHAR(1)    TRUE
 APNT_CNCL_YMD    DATE    TRUE
 문제
 APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요. 이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.

 예시
 APPOINTMENT 테이블이 다음과 같을 때

 APNT_YMD    APNT_NO    PT_NO    MCDP_CD    MDDR_ID    APNT_CNCL_YN    APNT_CNCL_YMD
 2022-04-14 09:30:00.000000    47    PT22000064    GS    DR20170123    N    NULL
 2022-04-15 10:30:00.000000    48    PT22000065    OB    DR20100231    N    NULL
 2022-05-15 17:30:00.000000    49    PT22000086    OB    DR20100231    N    NULL
 2022-05-18 10:30:00.000000    52    PT22000019    GS    DR20100039    N    NULL
 2022-05-19 12:00:00.000000    53    PT22000020    FM    DR20010112    N    NULL
 2022-05-22 08:30:00.000000    54    PT22000021    GS    DR20100039    N    NULL
 2022-05-04 10:30:00.000000    56    PT22000023    FM    DR20090112    N    NULL
 2022-05-14 15:30:00.000000    57    PT22000074    CS    DR20200012    N    NULL
 2022-05-24 15:30:00.000000    58    PT22000085    CS    DR20200012    N    NULL
 2022-05-28 10:00:00.000000    60    PT22000092    OS    DR20100031    N    NULL
 SQL을 실행하면 다음과 같이 출력되어야 합니다.

 진료과코드    5월예약건수
 OB    1
 OS    1
 CS    2
 FM    2
 GS    2
 */
