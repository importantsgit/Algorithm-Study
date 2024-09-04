/*
 스티커 모으기
 
 문제 설명
 N개의 스티커가 원형으로 연결되어 있습니다. 다음 그림은 N = 8인 경우의 예시입니다.

 원형으로 연결된 스티커에서 몇 장의 스티커를 뜯어내어 뜯어낸 스티커에 적힌 숫자의 합이 최대가 되도록 하고 싶습니다. 단 스티커 한 장을 뜯어내면 양쪽으로 인접해있는 스티커는 찢어져서 사용할 수 없게 됩니다.

 예를 들어 위 그림에서 14가 적힌 스티커를 뜯으면 인접해있는 10, 6이 적힌 스티커는 사용할 수 없습니다. 스티커에 적힌 숫자가 배열 형태로 주어질 때, 스티커를 뜯어내어 얻을 수 있는 숫자의 합의 최댓값을 return 하는 solution 함수를 완성해 주세요. 원형의 스티커 모양을 위해 배열의 첫 번째 원소와 마지막 원소가 서로 연결되어 있다고 간주합니다.

 제한 사항
 sticker는 원형으로 연결된 스티커의 각 칸에 적힌 숫자가 순서대로 들어있는 배열로, 길이(N)는 1 이상 100,000 이하입니다.
 sticker의 각 원소는 스티커의 각 칸에 적힌 숫자이며, 각 칸에 적힌 숫자는 1 이상 100 이하의 자연수입니다.
 원형의 스티커 모양을 위해 sticker 배열의 첫 번째 원소와 마지막 원소가 서로 연결되어있다고 간주합니다.
 입출력 예
 sticker    answer
 [14, 6, 5, 11, 3, 9, 2, 10]    36
 [1, 3, 2, 5, 4]    8
 입출력 예 설명
 입출력 예 #1
 6, 11, 9, 10이 적힌 스티커를 떼어 냈을 때 36으로 최대가 됩니다.

 입출력 예 #2
 3, 5가 적힌 스티커를 떼어 냈을 때 8로 최대가 됩니다.
 
 */

import Foundation

func solution(_ sticker:[Int]) -> Int{
    var answer = 0
    
    if sticker.count == 1 {
        return sticker.first!
    }
    else if 2...3 ~= sticker.count {
        return sticker.max()!
    }
    
    for startIndex in sticker.indices {
        var index = startIndex
        var dp = [Int](repeating: 0, count: sticker.count)
        dp[0] = sticker[index] - sticker[index-1 >= 0 ? index-1 : sticker.endIndex-1]
        dp[1] = sticker[(index + 1) % sticker.count]
        
        var dpIndex = 2
        index = (index + 2) % sticker.count
        
        while startIndex != index {
            dp[dpIndex] = max(dp[dpIndex-2] + sticker[index], dp[dpIndex-1])
            index = (index + 1) % sticker.count
            dpIndex += 1
        }
        
        answer = max(answer, dp.last!)
    }
    
    return answer
}
/*
 처음 문제를 접근할 때 모든 스티커 위치에서부터 시작하려 했으나 시간 초과로 실패
 */

func solution2(_ sticker: [Int]) -> Int {
    let stickerCount = sticker.count
    
    if stickerCount == 1 {
        return sticker.first!
    }
    else if 2...3 ~= stickerCount {
        return sticker.max()!
    }
    
    // Case 1: 첫번째 스티커 선택
    var dp = [Int](repeating: 0, count: sticker.count)
    dp[0] = sticker.first!
    dp[1] = sticker.first!
    
    for index in 2..<stickerCount-1 { // 배열 마지막 스티커는 첫번째 스티커를 뗐음으로 카운트에서 제거
        dp[index] = max(dp[index-2] + sticker[index], dp[index-1])
    }
    
    let result1 = dp[stickerCount-2]
    
    dp[0] = 0
    dp[1] = sticker[1]
    
    for index in 2..<stickerCount {
        dp[index] = max(dp[index-2] + sticker[index], dp[index-1])
    }
    
    let result2 = dp[stickerCount-1]
    
    return max(result1, result2)
}

/*
 문제 분석:

 원형으로 배치된 스티커에서 최대 합을 구해야 함
 인접한 스티커는 선택할 수 없음
 첫 번째와 마지막 스티커도 인접한 것으로 간주


 접근 방법 결정:

 동적 프로그래밍(DP) 사용
 원형 구조를 두 가지 선형 케이스로 분리


 두 가지 케이스 고려:

 Case 1: 첫 번째 스티커를 선택하는 경우
 Case 2: 첫 번째 스티커를 선택하지 않는 경우


 DP 배열 정의:

 dp[i]: i번째 스티커까지 고려했을 때의 최대 합


 점화식 설정:

 dp[i] = max(dp[i-1], dp[i-2] + sticker[i])
 현재 스티커를 선택하지 않거나, 선택하고 이전 이전의 최대값을 더함


 초기값 설정:

 Case 1: dp1[0] = sticker[0], dp1[1] = sticker[0]
 Case 2: dp2[0] = 0, dp2[1] = sticker[1], dp2[2] = max(sticker[1], sticker[2])


 DP 배열 채우기:

 각 케이스에 대해 점화식을 사용하여 배열 채움
 Case 1은 마지막 스티커를 제외 (n-2까지)
 Case 2는 마지막 스티커까지 포함 (n-1까지)


 결과 도출:

 두 케이스의 최대값 중 큰 값을 선택
 return max(dp1[n-2], dp2[n-1])


 예외 처리:

 스티커가 1개 또는 2개인 경우 별도 처리


 시간 복잡도:

 O(n), 여기서 n은 스티커의 개수
 */

print(solution([14, 6, 5, 11, 3, 9, 2, 10]))
print(solution([1, 3, 2, 5, 4]))

print(solution([1,2,3]))

print(solution([1,2]))

print(solution([1]))

print(solution([1,2,1,2]))
