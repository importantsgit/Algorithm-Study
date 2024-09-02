/*
 네트워크
 
 문제 설명
 네트워크란 컴퓨터 상호 간에 정보를 교환할 수 있도록 연결된 형태를 의미합니다. 예를 들어, 컴퓨터 A와 컴퓨터 B가 직접적으로 연결되어있고, 컴퓨터 B와 컴퓨터 C가 직접적으로 연결되어 있을 때 컴퓨터 A와 컴퓨터 C도 간접적으로 연결되어 정보를 교환할 수 있습니다. 따라서 컴퓨터 A, B, C는 모두 같은 네트워크 상에 있다고 할 수 있습니다.

 컴퓨터의 개수 n, 연결에 대한 정보가 담긴 2차원 배열 computers가 매개변수로 주어질 때, 네트워크의 개수를 return 하도록 solution 함수를 작성하시오.

 제한사항
 컴퓨터의 개수 n은 1 이상 200 이하인 자연수입니다.
 각 컴퓨터는 0부터 n-1인 정수로 표현합니다.
 i번 컴퓨터와 j번 컴퓨터가 연결되어 있으면 computers[i][j]를 1로 표현합니다.
 computer[i][i]는 항상 1입니다.
 입출력 예
 n    computers    return
 3    [[1, 1, 0], [1, 1, 0], [0, 0, 1]]    2
 3    [[1, 1, 0], [1, 1, 1], [0, 1, 1]]    1
 
 */

func solution(_ n: Int, _ computers: [[Int]]) -> Int {
    var visitedMap = [Bool](repeating: false, count: n)
    var stack = [Int]()
    var result = 0
    
    for index in 0..<n {
        if visitedMap[index] { continue }
        result += 1
        stack.append(index)
        visitedMap[index] = true
        
        while let popIndex = stack.popLast() {
            
            for (targetIndex, value) in computers[popIndex].enumerated() where index != targetIndex {
                if visitedMap[targetIndex] == false && value == 1 {
                    stack.append(targetIndex)
                    visitedMap[targetIndex] = true
                }
            }
        }
    }
    
    return result
}

/*
 접근 방법
 - 네트워크 상으로 연결되어 있다. (BFS나 DFS로 풀면 될 것 같다는 생각이 듦)
 - 네트워크의 수는 연결되어 있는 컴퓨터들의 그룹의 수 다. (Visited 한 것을 제외한 나머지를 BFS를 돌려 카운팅하는 것을 반복)

 문제 분석:

 주어진 문제는 연결된 컴퓨터 그룹(네트워크)의 수를 찾는 것입니다.
 각 컴퓨터는 노드로, 연결은 엣지로 표현할 수 있는 그래프 구조입니다.


 알고리즘 선택:

 그래프 탐색 알고리즘인 DFS(깊이 우선 탐색) 또는 BFS(너비 우선 탐색)를 사용합니다.
 이 경우 DFS를 선택하여 구현합니다. (스택 사용)


 접근 전략:

 모든 컴퓨터(노드)에 대해 순차적으로 검사합니다.
 아직 방문하지 않은 컴퓨터를 발견하면, 새로운 네트워크의 시작점으로 간주합니다.
 해당 컴퓨터부터 DFS를 시작하여 연결된 모든 컴퓨터를 탐색하고 방문 표시를 합니다.
 DFS가 완료되면 하나의 네트워크가 식별된 것으로 카운트합니다.
 이 과정을 모든 컴퓨터에 대해 반복합니다.


 구현 세부사항:

 방문 여부를 추적하기 위한 boolean 배열을 사용합니다.
 DFS 구현을 위해 스택을 사용합니다. (재귀 대신 반복적 방법 선택)
 네트워크 수를 카운트하기 위한 변수를 사용합니다.


 시간 복잡도 고려:

 각 컴퓨터와 그 연결을 한 번씩 확인하므로, O(n^2) 시간 복잡도를 가집니다.
 n은 컴퓨터의 수입니다.


 공간 복잡도 고려:

 방문 배열과 스택으로 인해 O(n)의 추가 공간이 필요합니다.


 예외 처리:

 입력값의 유효성 검사 (n의 범위, computers 배열의 형식 등)
 자기 자신과의 연결 (computers[i][i])은 항상 1임을 고려합니다.



 이 접근 방법을 통해 효율적으로 분리된 네트워크의 수를 정확하게 계산할 수 있습니다.
 
 solution(3, [[1, 1, 0], [1, 1, 0], [0, 0, 1]])
 solution(3, [[1, 1, 0], [1, 1, 1], [0, 1, 1]])
 */


