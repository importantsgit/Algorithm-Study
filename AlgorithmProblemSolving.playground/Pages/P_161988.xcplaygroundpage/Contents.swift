/*
 연속 펄스 부분 수열의 합
 
 문제 설명
 어떤 수열의 연속 부분 수열에 같은 길이의 펄스 수열을 각 원소끼리 곱하여 연속 펄스 부분 수열을 만들려 합니다. 펄스 수열이란 [1, -1, 1, -1 …] 또는 [-1, 1, -1, 1 …] 과 같이 1 또는 -1로 시작하면서 1과 -1이 번갈아 나오는 수열입니다.
 예를 들어 수열 [2, 3, -6, 1, 3, -1, 2, 4]의 연속 부분 수열 [3, -6, 1]에 펄스 수열 [1, -1, 1]을 곱하면 연속 펄스 부분수열은 [3, 6, 1]이 됩니다. 또 다른 예시로 연속 부분 수열 [3, -1, 2, 4]에 펄스 수열 [-1, 1, -1, 1]을 곱하면 연속 펄스 부분수열은 [-3, -1, -2, 4]이 됩니다.
 정수 수열 sequence가 매개변수로 주어질 때, 연속 펄스 부분 수열의 합 중 가장 큰 것을 return 하도록 solution 함수를 완성해주세요.

 제한 사항
 1 ≤ sequence의 길이 ≤ 500,000
 -100,000 ≤ sequence의 원소 ≤ 100,000
 sequence의 원소는 정수입니다.
 입출력 예
 sequence    result
 [2, 3, -6, 1, 3, -1, 2, 4]    10
 입출력 예 설명
 주어진 수열의 연속 부분 수열 [3, -6, 1]에 펄스 수열 [1, -1, 1]을 곱하여 연속 펄스 부분 수열 [3, 6, 1]을 얻을 수 있고 그 합은 10으로서 가장 큽니다.
 */

import Foundation

func solution(_ sequence:[Int]) -> Int64 {
    if sequence.count == 1 {
        return Int64(abs(sequence.first!)) // 절대값
    }
    
    var maxNum: Int64 = 0
    var dp = [-sequence[0],sequence[0]]
    
    for index in 1..<sequence.count {
        let a = max(sequence[index], (dp[0] + sequence[index]))
        let b = max(-sequence[index], (dp[1] - sequence[index]))
        dp = [b, a]
        maxNum = max(Int64(dp.max()!), maxNum)
    }
    
    return maxNum
}

/*
 테스트 1 〉    통과 (0.04ms, 16.3MB)
 테스트 2 〉    통과 (0.02ms, 16.2MB)
 테스트 3 〉    통과 (0.03ms, 16.4MB)
 테스트 4 〉    통과 (0.04ms, 16.4MB)
 테스트 5 〉    통과 (0.04ms, 16.2MB)
 테스트 6 〉    통과 (0.05ms, 16.1MB)
 테스트 7 〉    통과 (0.08ms, 16.4MB)
 테스트 8 〉    통과 (0.27ms, 16.3MB)
 테스트 9 〉    통과 (0.62ms, 16.5MB)
 테스트 10 〉    통과 (2.83ms, 16.7MB)
 테스트 11 〉    통과 (4.52ms, 17.2MB)
 테스트 12 〉    통과 (44.71ms, 21.1MB)
 테스트 13 〉    통과 (44.70ms, 21.2MB)
 테스트 14 〉    통과 (45.69ms, 21MB)
 테스트 15 〉    통과 (58.78ms, 21.1MB)
 테스트 16 〉    통과 (47.81ms, 20.8MB)
 테스트 17 〉    통과 (222.37ms, 37.7MB)
 테스트 18 〉    통과 (223.45ms, 37.7MB)
 테스트 19 〉    통과 (231.18ms, 38MB)
 테스트 20 〉    통과 (235.10ms, 38.2MB)
 */

func solution1(_ sequence:[Int]) -> Int64 {

    let totalCount = sequence.count
    var dp:[Int64] = Array(repeating: 0, count: totalCount + 1)

    for i in 1...totalCount {
        dp[i] = i % 2 == 0 ? dp[i - 1] - Int64(sequence[i - 1]) : dp[i - 1] + Int64(sequence[i - 1])
    }


    return dp.max()! - dp.min()!
}

/*
 테스트 1 〉    통과 (0.04ms, 16.3MB)
 테스트 2 〉    통과 (0.05ms, 16.5MB)
 테스트 3 〉    통과 (0.05ms, 16.3MB)
 테스트 4 〉    통과 (0.04ms, 16.5MB)
 테스트 5 〉    통과 (0.04ms, 16.5MB)
 테스트 6 〉    통과 (0.05ms, 16.1MB)
 테스트 7 〉    통과 (0.05ms, 16.4MB)
 테스트 8 〉    통과 (0.21ms, 16.7MB)
 테스트 9 〉    통과 (0.29ms, 16.6MB)
 테스트 10 〉    통과 (2.62ms, 16.8MB)
 테스트 11 〉    통과 (2.68ms, 16.8MB)
 테스트 12 〉    통과 (27.81ms, 21MB)
 테스트 13 〉    통과 (26.01ms, 21MB)
 테스트 14 〉    통과 (49.72ms, 20.9MB)
 테스트 15 〉    통과 (27.65ms, 21.2MB)
 테스트 16 〉    통과 (25.95ms, 21.1MB)
 테스트 17 〉    통과 (131.93ms, 37.9MB)
 테스트 18 〉    통과 (146.79ms, 38.2MB)
 테스트 19 〉    통과 (130.82ms, 38MB)
 테스트 20 〉    통과 (131.05ms, 38MB)
 */

solution([1,2,3,-1])
