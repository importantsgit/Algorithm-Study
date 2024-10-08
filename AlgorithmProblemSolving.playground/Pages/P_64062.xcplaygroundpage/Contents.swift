/*
 징검다리 건너기
 
문제 설명
[본 문제는 정확성과 효율성 테스트 각각 점수가 있는 문제입니다.]

카카오 초등학교의 "니니즈 친구들"이 "라이언" 선생님과 함께 가을 소풍을 가는 중에 징검다리가 있는 개울을 만나서 건너편으로 건너려고 합니다. "라이언" 선생님은 "니니즈 친구들"이 무사히 징검다리를 건널 수 있도록 다음과 같이 규칙을 만들었습니다.

징검다리는 일렬로 놓여 있고 각 징검다리의 디딤돌에는 모두 숫자가 적혀 있으며 디딤돌의 숫자는 한 번 밟을 때마다 1씩 줄어듭니다.
디딤돌의 숫자가 0이 되면 더 이상 밟을 수 없으며 이때는 그 다음 디딤돌로 한번에 여러 칸을 건너 뛸 수 있습니다.
단, 다음으로 밟을 수 있는 디딤돌이 여러 개인 경우 무조건 가장 가까운 디딤돌로만 건너뛸 수 있습니다.
"니니즈 친구들"은 개울의 왼쪽에 있으며, 개울의 오른쪽 건너편에 도착해야 징검다리를 건넌 것으로 인정합니다.
"니니즈 친구들"은 한 번에 한 명씩 징검다리를 건너야 하며, 한 친구가 징검다리를 모두 건넌 후에 그 다음 친구가 건너기 시작합니다.

디딤돌에 적힌 숫자가 순서대로 담긴 배열 stones와 한 번에 건너뛸 수 있는 디딤돌의 최대 칸수 k가 매개변수로 주어질 때, 최대 몇 명까지 징검다리를 건널 수 있는지 return 하도록 solution 함수를 완성해주세요.

[제한사항]
징검다리를 건너야 하는 니니즈 친구들의 수는 무제한 이라고 간주합니다.
stones 배열의 크기는 1 이상 200,000 이하입니다.
stones 배열 각 원소들의 값은 1 이상 200,000,000 이하인 자연수입니다.
k는 1 이상 stones의 길이 이하인 자연수입니다.
[입출력 예]
stones                            k    result
[2, 4, 5, 3, 2, 1, 4, 2, 5, 1]    3      3
입출력 예에 대한 설명
입출력 예 #1

첫 번째 친구는 다음과 같이 징검다리를 건널 수 있습니다.
step_stones_104.png

첫 번째 친구가 징검다리를 건넌 후 디딤돌에 적힌 숫자는 아래 그림과 같습니다.
두 번째 친구도 아래 그림과 같이 징검다리를 건널 수 있습니다.
step_stones_101.png

두 번째 친구가 징검다리를 건넌 후 디딤돌에 적힌 숫자는 아래 그림과 같습니다.
세 번째 친구도 아래 그림과 같이 징검다리를 건널 수 있습니다.
step_stones_102.png

세 번째 친구가 징검다리를 건넌 후 디딤돌에 적힌 숫자는 아래 그림과 같습니다.
네 번째 친구가 징검다리를 건너려면, 세 번째 디딤돌에서 일곱 번째 디딤돌로 네 칸을 건너뛰어야 합니다. 하지만 k = 3 이므로 건너뛸 수 없습니다.
step_stones_103.png

따라서 최대 3명이 디딤돌을 모두 건널 수 있습니다.
*/

import Foundation

func solution(_ stones:[Int], _ k:Int) -> Int {
    var min = 1, max = 200000000
    
    while min < max {
        let mid = (min + max) / 2
        var count = 0
        
        for index in 0..<stones.count {
            // MARK: - 이제부터 인덱스로 접근하기 (이게 더 빠름) > 이게 시간초과 난 이유였다니요?
            if stones[index] <= mid {
                count += 1
                
                if count >= k { break }
            }
            else {
                count = 0
            }
            
            // MARK: - 이 부분에 if count >= k { break }을 배치했었는데 else일 경우도 해당 로직이 실행되었기 때문에
        }
        
        if count >= k {
            max = mid
        }
        else {
            min = mid + 1
        }
    }

    return max
}

// 이 문제는 슬라이딩 윈도우 + 우선순위 큐 조합으로도 풀 수 있다
func solution2(_ stones:[Int], _ k:Int) -> Int {
    if k == stones.count - 1 { return stones.count }
    
    var window = Array(stones[0..<k])
    var result = window.max()!
    
    for appendIndex in k..<stones.count {
        let removeStone = window.removeFirst()
        window.append(stones[appendIndex])
        
        result = min(result, window.max()!)
    
    }
    
    return result
}

solution([2, 4, 5, 3, 2, 1, 4, 2, 5, 1], 3)

solution([0,0,0,0,0], 3)

solution([3,3,3,3,3], 3)
solution([2,2,2], 3)

solution2([2, 4, 5, 3, 2, 1, 4, 2, 5, 1], 3)

solution2([0,0,0,0,0], 3)

solution2([3,3,3,3,3], 3)
solution2([2,2,2], 3)
