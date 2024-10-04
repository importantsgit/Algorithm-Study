/*
 인사고과
 
 완호네 회사는 연말마다 1년 간의 인사고과에 따라 인센티브를 지급합니다. 각 사원마다 근무 태도 점수와 동료 평가 점수가 기록되어 있는데 만약 어떤 사원이 다른 임의의 사원보다 두 점수가 모두 낮은 경우가 한 번이라도 있다면 그 사원은 인센티브를 받지 못합니다. 그렇지 않은 사원들에 대해서는 두 점수의 합이 높은 순으로 석차를 내어 석차에 따라 인센티브가 차등 지급됩니다. 이때, 두 점수의 합이 동일한 사원들은 동석차이며, 동석차의 수만큼 다음 석차는 건너 뜁니다. 예를 들어 점수의 합이 가장 큰 사원이 2명이라면 1등이 2명이고 2등 없이 다음 석차는 3등부터입니다.

 각 사원의 근무 태도 점수와 동료 평가 점수 목록 scores이 주어졌을 때, 완호의 석차를 return 하도록 solution 함수를 완성해주세요.

 제한 사항
 1 ≤ scores의 길이 ≤ 100,000
 scores의 각 행은 한 사원의 근무 태도 점수와 동료 평가 점수를 나타내며 [a, b] 형태입니다.
 scores[0]은 완호의 점수입니다.
 0 ≤ a, b ≤ 100,000
 완호가 인센티브를 받지 못하는 경우 -1을 return 합니다.
 입출력 예
 scores    result
 [[2,2],[1,4],[3,2],[3,2],[2,1]]    4
 입출력 예 설명
 5 번째 사원은 3 번째 또는 4 번째 사원보다 근무 태도 점수와 동료 평가 점수가 모두 낮기 때문에 인센티브를 받을 수 없습니다. 2 번째 사원, 3 번째 사원, 4 번째 사원은 두 점수의 합이 5 점으로 최고점이므로 1 등입니다. 1 등이 세 명이므로 2 등과 3 등은 없고 1 번째 사원인 완호는 두 점수의 합이 4 점으로 4 등입니다.
 */

/*
import Foundation

struct Heap<T: Comparable> {
    private var elements: [T]
    private var orderCriteria: (T, T) -> Bool
    
    var count: Int {
        let count = elements.count - 1
        return count >= 0 ? count : 0
    }
    
    init(elements: [T] = [], orderCriteria: @escaping (T, T) -> Bool) {
        self.elements = elements.isEmpty ? elements : [elements.first!] + elements
        self.orderCriteria = orderCriteria
        
        if self.elements.count > 1 {
            buildHeap()
        }
    }
    
    func getParentIndex(from index: Int) -> Int {
        index / 2
    }
    
    func getLeftChildIndex(from parentIndex: Int) -> Int {
        parentIndex * 2
    }
    
    func getRightChildIndex(from parentIndex: Int) -> Int {
        parentIndex * 2 + 1
    }
    
    mutating func buildHeap() {
        for index in (1...(count/2)).reversed() {
            diveDown(index: index)
        }
    }
    
    mutating func swimUp(index: Int) {
        let parentIndex = getParentIndex(from: index)
        print(index, parentIndex, orderCriteria(elements[index], elements[parentIndex]))
        if parentIndex > 0 && orderCriteria(elements[index], elements[parentIndex]) {
            elements.swapAt(parentIndex, index)
            swimUp(index: parentIndex)
        }
    }
    
    mutating func diveDown(index: Int) {
        var priorityIndex = index
        let leftChildIndex = getLeftChildIndex(from: index)
        let rightChildIndex = getRightChildIndex(from: index)
        
        if leftChildIndex < elements.count && orderCriteria(elements[leftChildIndex], elements[priorityIndex]) {
            priorityIndex = leftChildIndex
        }
        
        if rightChildIndex < elements.count && orderCriteria(elements[rightChildIndex], elements[priorityIndex]) {
            priorityIndex = rightChildIndex
        }
        
        if priorityIndex != index {
            elements.swapAt(index, priorityIndex)
            diveDown(index: priorityIndex)
        }
    }
    
    mutating func push(element: T) {
        
        elements.append(element)
        
        guard elements.count != 1
        else {
            elements.append(element)
            return
        }
        
        swimUp(index: elements.endIndex - 1)
    }
    
    mutating func pop() -> T? {
        if count == 1 {
            return elements.popLast()
        }
        else if count == 0 {
            return nil
        }
        
        
        elements.swapAt(1, elements.endIndex - 1)
        let popElement = elements.popLast()
        diveDown(index: 1)
        
        return popElement
    }
}

struct PriorityQueue<T: Comparable> {
    var heap: Heap<T>
    
    var count: Int {
        heap.count
    }
    
    init(elements: [T] = [], orderCriteria: @escaping (T, T) -> Bool) {
        self.heap = Heap(elements: elements, orderCriteria: orderCriteria)
    }
    
    mutating func push(element: T) {
        heap.push(element: element)
    }
    
    mutating func pop() -> T? {
        heap.pop()
    }
}

struct Score: Comparable {
    var peerScore: Int
    var attitudeScore: Int
    
    init(peerScore: Int, attitudeScore: Int) {
        self.peerScore = peerScore
        self.attitudeScore = attitudeScore
    }

    static func < (lhs: Score, rhs: Score) -> Bool {
        (lhs.attitudeScore + lhs.peerScore) < (rhs.attitudeScore + rhs.peerScore)
    }
}

func solution(_ scores:[[Int]]) -> Int {
    let scores = scores.map { Score(peerScore: $0[0], attitudeScore: $0[1]) }
    var priorityQueue: PriorityQueue<Score> = .init(elements: scores, orderCriteria: >)
    
    var compareScore = priorityQueue.pop()!
    var (minPeerScore, minAttitudeScore) = (compareScore.peerScore, compareScore.attitudeScore)
    var result = 1
    var sameCount = 1
    
    while let popScore = priorityQueue.pop() {
        if minPeerScore <= popScore.peerScore ||
            minAttitudeScore <= popScore.attitudeScore {
            
            if compareScore == popScore {
                sameCount += 1
            }
            else {
                result += sameCount
                sameCount = 1
            }

            if popScore == scores.first {
                return result
            }
            
            if minPeerScore > popScore.peerScore {
                minPeerScore = popScore.peerScore
            }
            
            if minAttitudeScore > popScore.attitudeScore {
                minAttitudeScore = popScore.attitudeScore
            }
            
            compareScore = popScore
        }
        else {
            result = -1
            break
        }

    }
    
    return result
}



 // 이렇게 풀면 안된다...
*/

import Foundation

func solution(_ scores:[[Int]]) -> Int {
    let me = scores.first!
    // Sort는 이렇게 하자
    let scores = scores.sorted(by: { $0[0] > $1[0] || ($0[0] == $1[0] && $0[1] < $1[1]) })
    var insentiveScores = [[Int]]()
    var maxPeerScore = 0
    
    for index in 0..<scores.count {
        let currentScore = scores[index]
        if currentScore[1] < maxPeerScore {
            if me == currentScore {
                return -1
            }
        }
        else {
            insentiveScores.append(currentScore)
            maxPeerScore = max(currentScore[1], maxPeerScore)
        }
    }
    let sortedScores = insentiveScores.map { $0[0] + $0[1] }.sorted(by: >)
    if let index = sortedScores.firstIndex(of: me.reduce(0, +)) {
        return index + 1
    }
    
    return -1
}
print(solution([[2,2],[1,4],[3,2],[3,2],[2,1]]))
print(solution([[1,1],[4,2]]))


