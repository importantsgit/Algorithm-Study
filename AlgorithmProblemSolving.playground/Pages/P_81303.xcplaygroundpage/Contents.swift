/*
 표 편집
 
 업무용 소프트웨어를 개발하는 니니즈웍스의 인턴인 앙몬드는 명령어 기반으로 표의 행을 선택, 삭제, 복구하는 프로그램을 작성하는 과제를 맡았습니다. 세부 요구 사항은 다음과 같습니다

 table_1.png

 위 그림에서 파란색으로 칠해진 칸은 현재 선택된 행을 나타냅니다. 단, 한 번에 한 행만 선택할 수 있으며, 표의 범위(0행 ~ 마지막 행)를 벗어날 수 없습니다. 이때, 다음과 같은 명령어를 이용하여 표를 편집합니다.

 "U X": 현재 선택된 행에서 X칸 위에 있는 행을 선택합니다.  -X
 "D X": 현재 선택된 행에서 X칸 아래에 있는 행을 선택합니다. +X
 "C" : 현재 선택된 행을 삭제한 후, 바로 아래 행을 선택합니다. 단, 삭제된 행이 가장 마지막 행인 경우 바로 윗 행을 선택합니다.
 "Z" : 가장 최근에 삭제된 행을 원래대로 복구합니다. 단, 현재 선택된 행은 바뀌지 않습니다.
 예를 들어 위 표에서 "D 2"를 수행할 경우 아래 그림의 왼쪽처럼 4행이 선택되며, "C"를 수행하면 선택된 행을 삭제하고, 바로 아래 행이었던 "네오"가 적힌 행을 선택합니다(4행이 삭제되면서 아래 있던 행들이 하나씩 밀려 올라오고, 수정된 표에서 다시 4행을 선택하는 것과 동일합니다).

 table_2.png

 다음으로 "U 3"을 수행한 다음 "C"를 수행한 후의 표 상태는 아래 그림과 같습니다.

 table_3.png

 다음으로 "D 4"를 수행한 다음 "C"를 수행한 후의 표 상태는 아래 그림과 같습니다. 5행이 표의 마지막 행 이므로, 이 경우 바로 윗 행을 선택하는 점에 주의합니다.

 table_4.png

 다음으로 "U 2"를 수행하면 현재 선택된 행은 2행이 됩니다.

 table_5.png

 위 상태에서 "Z"를 수행할 경우 가장 최근에 제거된 "라이언"이 적힌 행이 원래대로 복구됩니다.

 table_6.png

 다시한번 "Z"를 수행하면 그 다음으로 최근에 제거된 "콘"이 적힌 행이 원래대로 복구됩니다. 이때, 현재 선택된 행은 바뀌지 않는 점에 주의하세요.
 table_7.png

 이때, 최종 표의 상태와 처음 주어진 표의 상태를 비교하여 삭제되지 않은 행은 "O", 삭제된 행은 "X"로 표시하면 다음과 같습니다.

 table_8.png

 처음 표의 행 개수를 나타내는 정수 n, 처음에 선택된 행의 위치를 나타내는 정수 k, 수행한 명령어들이 담긴 문자열 배열 cmd가 매개변수로 주어질 때, 모든 명령어를 수행한 후 표의 상태와 처음 주어진 표의 상태를 비교하여 삭제되지 않은 행은 O, 삭제된 행은 X로 표시하여 문자열 형태로 return 하도록 solution 함수를 완성해주세요.

 제한사항
 5 ≤ n ≤ 1,000,000
 0 ≤ k < n
 1 ≤ cmd의 원소 개수 ≤ 200,000
 cmd의 각 원소는 "U X", "D X", "C", "Z" 중 하나입니다.
 X는 1 이상 300,000 이하인 자연수이며 0으로 시작하지 않습니다.
 X가 나타내는 자연수에 ',' 는 주어지지 않습니다. 예를 들어 123,456의 경우 123456으로 주어집니다.
 cmd에 등장하는 모든 X들의 값을 합친 결과가 1,000,000 이하인 경우만 입력으로 주어집니다.
 표의 모든 행을 제거하여, 행이 하나도 남지 않는 경우는 입력으로 주어지지 않습니다.
 본문에서 각 행이 제거되고 복구되는 과정을 보다 자연스럽게 보이기 위해 "이름" 열을 사용하였으나, "이름"열의 내용이 실제 문제를 푸는 과정에 필요하지는 않습니다. "이름"열에는 서로 다른 이름들이 중복없이 채워져 있다고 가정하고 문제를 해결해 주세요.
 표의 범위를 벗어나는 이동은 입력으로 주어지지 않습니다.
 원래대로 복구할 행이 없을 때(즉, 삭제된 행이 없을 때) "Z"가 명령어로 주어지는 경우는 없습니다.
 정답은 표의 0행부터 n - 1행까지에 해당되는 O, X를 순서대로 이어붙인 문자열 형태로 return 해주세요.
 정확성 테스트 케이스 제한 사항
 5 ≤ n ≤ 1,000
 1 ≤ cmd의 원소 개수 ≤ 1,000
 효율성 테스트 케이스 제한 사항
 주어진 조건 외 추가 제한사항 없습니다.
 입출력 예
 n    k    cmd    result
 8    2    ["D 2","C","U 3","C","D 4","C","U 2","Z","Z"]    "OOOOXOOO"
 8    2    ["D 2","C","U 3","C","D 4","C","U 2","Z","Z","U 1","C"]    "OOXOXOOO"
 입출력 예 설명
 입출력 예 #1

 문제의 예시와 같습니다.

 입출력 예 #2

 다음은 9번째 명령어까지 수행한 후의 표 상태이며, 이는 입출력 예 #1과 같습니다.

 table_7.png

 10번째 명령어 "U 1"을 수행하면 "어피치"가 적힌 2행이 선택되며, 마지막 명령어 "C"를 수행하면 선택된 행을 삭제하고, 바로 아래 행이었던 "제이지"가 적힌 행을 선택합니다.

 table_9.png

 따라서 처음 주어진 표의 상태와 최종 표의 상태를 비교하면 다음과 같습니다.

 table_10.png

 제한시간 안내
 정확성 테스트 : 10초
 효율성 테스트 : 언어별로 작성된 정답 코드의 실행 시간의 적정 배수
 */


import Foundation

func solution(_ n:Int, _ k:Int, _ cmd:[String]) -> String {
    var linkedList = LinkedList(count: n, current: k)

    for c in cmd {
        switch c.first! {
        case "D": // index + 1
            let downCount = Int(c.split(separator: " ").last!)!
            linkedList.down(count: downCount)
        case "U": // index - 1
            let upCount = Int(c.split(separator: " ").last!)!
            linkedList.up(count: upCount)
        case "C": // 삭제
            linkedList.remove()
        case "Z":
            linkedList.reconnect()
        default: break
        }
    }
 
    return linkedList.getValue()
}

class Node {
    var value: Int
    var next: Node?
    var prev: Node?
    
    init(value: Int) {
        self.value = value
    }
}

struct LinkedList {
    var head: Node?
    var tail: Node?
    var currentNode: Node!
    var stack = [Node]()
    var deleteSet = Set<Int>()
    
    var count: Int = 0
    
    var isEmpty: Bool {
        head == nil
    }
    
    init(count: Int, current: Int) {
        self.count = count
        
        let node = Node(value: 0)
        head = node
        tail = node
        currentNode = node
        
        for index in 1..<count {
            let node = Node(value: index)
            node.prev = tail
            tail?.next = node
            tail = node
            
            if current == index {
                currentNode = node
            }
        }
    }
    
    mutating func getNextNode(from node: Node, count: Int = 1) -> Node? {
        var node = node, count = count
        while let nextNode = node.next {
            if count == 1 {
                return nextNode
            }
            count -= 1
            node = nextNode
        }
        return nil
    }
    
    mutating func getPrevNode(from node: Node, count: Int = 1) -> Node? {
        var node = node, count = count
        while let prevNode = node.prev {
            if count == 1 {
                return prevNode
            }
            count -= 1
            node = prevNode
        }
        return nil
    }
    
    // MARK: - 이 부분을 수정했다
    // 원인 분석
    /*
     
     currentNode.next = currentNode?.prev?.next
     currentNode.prev = currentNode?.next?.prev
     */
    mutating func remove() {
        currentNode.next?.prev = currentNode?.prev
        currentNode.prev?.next = currentNode?.next
        deleteSet.insert(currentNode.value)
        stack.append(currentNode!)
        
        if let next = currentNode.next {
            currentNode = next
        }
        else if let prev = currentNode.prev {
            currentNode = prev
        }
    }

    mutating func reconnect() {
        if let node = stack.popLast() {
            deleteSet.remove(node.value)
            node.next?.prev = node
            node.prev?.next = node
        }
    }
    
    mutating func down(count: Int) {
        if let downNode = getNextNode(from: currentNode!, count: count) {
            currentNode = downNode
        }
    }
    
    mutating func up(count: Int) {
        if let upNode = getPrevNode(from: currentNode!, count: count) {
            currentNode = upNode
        }
    }
    
    mutating func getValue() -> String {
        var result = [String](repeating: "O", count: count)
        for index in deleteSet {
            result[index] = "X"
        }
        
        return result.joined()
    }
}


//solution(8, 2, ["D 2","C","U 3","C","D 4","C","U 2","Z","Z"])           // "OOOOXOOO"
//solution(8, 2, ["D 2","C","U 3","C","D 4","C","U 2","Z","Z","U 1","C"]) // "OOXOXOOO"
//solution(8, 7, ["C"])
//solution(8, 6, ["C", "U 3"])
//solution(3, 2, ["C", "C"])
solution(3, 0, ["C", "C"])
solution(3, 1, ["C", "Z", "C"])
solution(3, 1, ["C"])
