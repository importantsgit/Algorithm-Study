
/*
기지국 설치
 
문제 설명
N개의 아파트가 일렬로 쭉 늘어서 있습니다. 이 중에서 일부 아파트 옥상에는 4g 기지국이 설치되어 있습니다. 기술이 발전해 5g 수요가 높아져 4g 기지국을 5g 기지국으로 바꾸려 합니다. 그런데 5g 기지국은 4g 기지국보다 전달 범위가 좁아, 4g 기지국을 5g 기지국으로 바꾸면 어떤 아파트에는 전파가 도달하지 않습니다.

예를 들어 11개의 아파트가 쭉 늘어서 있고, [4, 11] 번째 아파트 옥상에는 4g 기지국이 설치되어 있습니다. 만약 이 4g 기지국이 전파 도달 거리가 1인 5g 기지국으로 바뀔 경우 모든 아파트에 전파를 전달할 수 없습니다. (전파의 도달 거리가 W일 땐, 기지국이 설치된 아파트를 기준으로 전파를 양쪽으로 W만큼 전달할 수 있습니다.)

초기에, 1, 2, 6, 7, 8, 9번째 아파트에는 전파가 전달되지 않습니다.

1, 7, 9번째 아파트 옥상에 기지국을 설치할 경우, 모든 아파트에 전파를 전달할 수 있습니다.

더 많은 아파트 옥상에 기지국을 설치하면 모든 아파트에 전파를 전달할 수 있습니다.

이때, 우리는 5g 기지국을 최소로 설치하면서 모든 아파트에 전파를 전달하려고 합니다. 위의 예시에선 최소 3개의 아파트 옥상에 기지국을 설치해야 모든 아파트에 전파를 전달할 수 있습니다.

아파트의 개수 N, 현재 기지국이 설치된 아파트의 번호가 담긴 1차원 배열 stations, 전파의 도달 거리 W가 매개변수로 주어질 때, 모든 아파트에 전파를 전달하기 위해 증설해야 할 기지국 개수의 최솟값을 리턴하는 solution 함수를 완성해주세요

제한사항
N: 200,000,000 이하의 자연수
stations의 크기: 10,000 이하의 자연수
stations는 오름차순으로 정렬되어 있고, 배열에 담긴 수는 N보다 같거나 작은 자연수입니다.
W: 10,000 이하의 자연수
입출력 예
N    stations    W    answer
11    [4, 11]    1    3
16    [9]    2    3
*/

import Foundation

func solution(_ n:Int, _ stations:[Int], _ w:Int) -> Int{
    var result = 0
    
    var startEmptyNumber = 1
    var coverRange = 2 * w + 1
    
    for station in stations {
        let endEmptyNumber = (station - w - 1)
        
        if startEmptyNumber <= endEmptyNumber {
            let emptyRange = endEmptyNumber - startEmptyNumber + 1
            result += Int(ceil(Double(emptyRange) / Double(coverRange)))
        }
        
        startEmptyNumber = (station + w + 1)
    }
    
    if startEmptyNumber <= n {
        let emptyRange = n - startEmptyNumber + 1
        result += Int(ceil(Double(emptyRange) / Double(coverRange)))
    }
    
    return result
}
/*
접근 방법
 - 먼저 커버가 되지 않은 구역의 길이를 계산
 - 해당 길이 내 들어갈 수 있는 기지국을 계산
 
 1. 핵심 아이디어

 커버되지 않은 구간을 찾아 효율적으로 새 기지국을 설치합니다.
 각 구간마다 필요한 최소 기지국 수를 계산합니다.

 2. 단계별 접근
 2.1 초기화

 result: 설치해야 할 새 기지국의 총 개수
 startEmptyNumber: 현재 커버되지 않은 구간의 시작점
 coverRange: 하나의 기지국이 커버할 수 있는 범위 (2w + 1)

 2.2 기존 기지국 처리
 각 기존 기지국에 대해:

 커버되지 않은 구간의 끝점 계산 (endEmptyNumber)
 커버되지 않은 구간의 길이 계산
 필요한 새 기지국 수 계산 및 result에 추가
 다음 커버되지 않은 구간의 시작점 업데이트

 2.3 마지막 구간 처리

 마지막 기지국 이후부터 N까지의 구간 확인
 필요한 경우 추가 기지국 설치

 3. 수학적 접근

 구간 길이를 기지국 커버 범위로 나누어 필요한 기지국 수 계산
 올림 함수 사용: ceil(구간 길이 / 커버 범위)

 4. 최적화 포인트

 불필요한 반복 최소화
 정수 나눗셈과 올림 연산 활용
 큰 입력값 (N ≤ 200,000,000) 고려

 5. 시간 복잡도

 O(stations.count): 기존 기지국 수에 비례
 
 테스트 1 〉    통과 (0.02ms, 16.3MB)
 테스트 2 〉    통과 (0.04ms, 16.2MB)
 테스트 3 〉    통과 (0.02ms, 16.4MB)
 테스트 4 〉    통과 (0.02ms, 16.2MB)
 테스트 5 〉    통과 (0.04ms, 16.3MB)
 테스트 6 〉    통과 (0.02ms, 16.3MB)
 테스트 7 〉    통과 (0.02ms, 16.2MB)
 테스트 8 〉    통과 (0.03ms, 16.3MB)
 테스트 9 〉    통과 (0.02ms, 16.3MB)
 테스트 10 〉    통과 (0.02ms, 16.4MB)
 테스트 11 〉    통과 (0.03ms, 16.4MB)
 테스트 12 〉    통과 (0.02ms, 16.3MB)
 테스트 13 〉    통과 (0.03ms, 16.4MB)
 테스트 14 〉    통과 (0.02ms, 16.3MB)
 테스트 15 〉    통과 (0.04ms, 16.5MB)
 테스트 16 〉    통과 (0.04ms, 16.4MB)
 테스트 17 〉    통과 (0.02ms, 16.2MB)
 테스트 18 〉    통과 (0.03ms, 16.1MB)
 테스트 19 〉    통과 (0.04ms, 16.1MB)
 테스트 20 〉    통과 (0.02ms, 16.5MB)
 테스트 21 〉    통과 (0.02ms, 16.4MB)
 효율성  테스트
 테스트 1 〉    통과 (1.10ms, 16.7MB)
 테스트 2 〉    통과 (1.06ms, 16.8MB)
 테스트 3 〉    통과 (1.05ms, 16.7MB)
 테스트 4 〉    통과 (1.06ms, 16.8MB)
 */


import Foundation

func solution(_ n: Int, _ stations: [Int], _ w: Int) -> Int {
    var answer = 0
    let coverage = 2 * w + 1
    var position = 1
    var stationIndex = 0

    while position <= n {
        if stationIndex < stations.count && stations[stationIndex] - w <= position {
            position = stations[stationIndex] + w + 1
            stationIndex += 1
        } else {
            answer += 1
            position += coverage
        }
    }

    return answer
}

/*
 정확성  테스트
 테스트 1 〉    통과 (0.01ms, 16.4MB)
 테스트 2 〉    통과 (0.01ms, 16.2MB)
 테스트 3 〉    통과 (0.01ms, 16.5MB)
 테스트 4 〉    통과 (0.01ms, 16.4MB)
 테스트 5 〉    통과 (0.02ms, 16.4MB)
 테스트 6 〉    통과 (0.01ms, 16.3MB)
 테스트 7 〉    통과 (0.01ms, 16.5MB)
 테스트 8 〉    통과 (0.01ms, 16.1MB)
 테스트 9 〉    통과 (0.01ms, 16.2MB)
 테스트 10 〉    통과 (0.01ms, 16.3MB)
 테스트 11 〉    통과 (0.01ms, 16.4MB)
 테스트 12 〉    통과 (0.01ms, 16.4MB)
 테스트 13 〉    통과 (0.01ms, 16.3MB)
 테스트 14 〉    통과 (0.02ms, 16.5MB)
 테스트 15 〉    통과 (0.02ms, 16.2MB)
 테스트 16 〉    통과 (0.02ms, 16.3MB)
 테스트 17 〉    통과 (0.01ms, 16.4MB)
 테스트 18 〉    통과 (0.01ms, 16.3MB)
 테스트 19 〉    통과 (0.01ms, 16.6MB)
 테스트 20 〉    통과 (0.01ms, 16.1MB)
 테스트 21 〉    통과 (0.01ms, 16.4MB)
 효율성  테스트
 테스트 1 〉    통과 (0.40ms, 17MB)
 테스트 2 〉    통과 (0.62ms, 16.8MB)
 테스트 3 〉    통과 (0.47ms, 17MB)
 테스트 4 〉    통과 (0.49ms, 17MB)
 */

solution(11, [4,11], 1)
solution(16, [9], 2)
