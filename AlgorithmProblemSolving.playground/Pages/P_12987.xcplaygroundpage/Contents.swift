/*
숫자 게임
 
문제 설명
xx 회사의 2xN명의 사원들은 N명씩 두 팀으로 나눠 숫자 게임을 하려고 합니다. 두 개의 팀을 각각 A팀과 B팀이라고 하겠습니다. 숫자 게임의 규칙은 다음과 같습니다.

먼저 모든 사원이 무작위로 자연수를 하나씩 부여받습니다.
각 사원은 딱 한 번씩 경기를 합니다.
각 경기당 A팀에서 한 사원이, B팀에서 한 사원이 나와 서로의 수를 공개합니다. 그때 숫자가 큰 쪽이 승리하게 되고, 승리한 사원이 속한 팀은 승점을 1점 얻게 됩니다.
만약 숫자가 같다면 누구도 승점을 얻지 않습니다.
전체 사원들은 우선 무작위로 자연수를 하나씩 부여받았습니다. 그다음 A팀은 빠르게 출전순서를 정했고 자신들의 출전 순서를 B팀에게 공개해버렸습니다. B팀은 그것을 보고 자신들의 최종 승점을 가장 높이는 방법으로 팀원들의 출전 순서를 정했습니다. 이때의 B팀이 얻는 승점을 구해주세요.
A 팀원들이 부여받은 수가 출전 순서대로 나열되어있는 배열 A와 i번째 원소가 B팀의 i번 팀원이 부여받은 수를 의미하는 배열 B가 주어질 때, B 팀원들이 얻을 수 있는 최대 승점을 return 하도록 solution 함수를 완성해주세요.

제한사항
A와 B의 길이는 같습니다.
A와 B의 길이는 1 이상 100,000 이하입니다.
A와 B의 각 원소는 1 이상 1,000,000,000 이하의 자연수입니다.
입출력 예
A    B    result
[5,1,3,7]    [2,2,6,8]    3
[2,2,2,2]    [1,1,1,1]    0
*/

import Foundation

func solution(_ a:[Int], _ b:[Int]) -> Int {
    let a = a.sorted()
    var b = b.sorted()
    var index = -1
    var result = 0
    
    for targetNum in a {
        while index < b.count - 1 {
            index += 1
            
            if b[index] > targetNum {
                result += 1
                break
            }
        }
        
        if index >= b.count {
            break
        }
    }
    
    return result
}

/*
- 처음 그리디로 접근 제일 큰 수로 상대의 제일 작은 수와 대결
- 1,3,5,7 <-> 2,2,5,8 일 경우 실패
- 최대한 A의 카드와 근접하게 큰 수를 배치
*/

import Foundation

func solution2(_ a:[Int], _ b:[Int]) -> Int {
    let a = a.sorted()
    var b = b.sorted()
    var index = -1
    var result = 0
    
    for targetNum in a { // a.count
        
        let targetIndex = b[(index+1)...].firstIndex { num in
            targetNum < num
        }
        
        if let targetIndex = targetIndex {
            index = targetIndex
            result += 1
        }
        else {
            return result
        }
    }
    
    return result
}

/*
- 시간 초과로 더 빨리 찾는 방법 선택
 정확성: 85.7
 효율성: 14.3
 합계: 100.0 / 100.0
 
 테스트 1 〉    통과 (0.11ms, 16.4MB)
 테스트 2 〉    통과 (0.11ms, 16.2MB)
 테스트 3 〉    통과 (0.13ms, 16.7MB)
 테스트 4 〉    통과 (0.11ms, 16.4MB)
 테스트 5 〉    통과 (0.37ms, 16.5MB)
 테스트 6 〉    통과 (0.59ms, 16.4MB)
 테스트 7 〉    통과 (0.74ms, 16.6MB)
 테스트 8 〉    통과 (0.69ms, 16.4MB)
 테스트 9 〉    통과 (3.75ms, 16.5MB)
 테스트 10 〉    통과 (2.51ms, 16.5MB)
 테스트 11 〉    통과 (7.49ms, 16.3MB)
 테스트 12 〉    통과 (3.03ms, 16.2MB)
 테스트 13 〉    통과 (26.45ms, 16.8MB)
 테스트 14 〉    통과 (26.85ms, 17MB)
 테스트 15 〉    통과 (39.82ms, 16.7MB)
 테스트 16 〉    통과 (42.69ms, 16.9MB)
 테스트 17 〉    통과 (1.34ms, 16.6MB)
 테스트 18 〉    통과 (1.99ms, 16.8MB)
 효율성  테스트
 테스트 1 〉    통과 (412.18ms, 24.6MB)
 테스트 2 〉    통과 (414.48ms, 24.5MB)
 테스트 3 〉    통과 (427.79ms, 24.7MB)
*/

func solution3(_ a:[Int], _ b:[Int]) -> Int {
    let a = a.sorted(by: >), b = b.sorted(by: >)
    var index = 0
    var result = 0
    
    for targetNum in a {
        if targetNum < b[index] {
            index += 1
            result += 1
        }
    }
    
    return result
}
/*
 정확성  테스트
 테스트 1 〉    통과 (0.10ms, 16.3MB)
 테스트 2 〉    통과 (0.11ms, 16.3MB)
 테스트 3 〉    통과 (0.11ms, 16.5MB)
 테스트 4 〉    통과 (0.10ms, 16.4MB)
 테스트 5 〉    통과 (0.25ms, 16.6MB)
 테스트 6 〉    통과 (0.38ms, 16.4MB)
 테스트 7 〉    통과 (0.39ms, 16.4MB)
 테스트 8 〉    통과 (0.38ms, 16.5MB)
 테스트 9 〉    통과 (4.30ms, 16.2MB)
 테스트 10 〉    통과 (1.80ms, 16.4MB)
 테스트 11 〉    통과 (3.91ms, 16.6MB)
 테스트 12 〉    통과 (1.99ms, 16.6MB)
 테스트 13 〉    통과 (18.95ms, 16.9MB)
 테스트 14 〉    통과 (26.02ms, 17MB)
 테스트 15 〉    통과 (32.56ms, 17MB)
 테스트 16 〉    통과 (45.13ms, 17MB)
 테스트 17 〉    통과 (1.15ms, 16.6MB)
 테스트 18 〉    통과 (1.59ms, 17MB)
 효율성  테스트
 테스트 1 〉    통과 (424.30ms, 25MB)
 테스트 2 〉    통과 (381.89ms, 24.5MB)
 테스트 3 〉    통과 (415.29ms, 24.8MB)
 */

solution([5,1,3,7], [2,2,6,8])
solution([2,2,2,2], [1,1,1,1])
