/*
 
 가장 먼 노드
 
 문제 설명
 n개의 노드가 있는 그래프가 있습니다. 각 노드는 1부터 n까지 번호가 적혀있습니다. 1번 노드에서 가장 멀리 떨어진 노드의 갯수를 구하려고 합니다. 가장 멀리 떨어진 노드란 최단경로로 이동했을 때 간선의 개수가 가장 많은 노드들을 의미합니다.

 노드의 개수 n, 간선에 대한 정보가 담긴 2차원 배열 vertex가 매개변수로 주어질 때, 1번 노드로부터 가장 멀리 떨어진 노드가 몇 개인지를 return 하도록 solution 함수를 작성해주세요.

 제한사항
 노드의 개수 n은 2 이상 20,000 이하입니다.
 간선은 양방향이며 총 1개 이상 50,000개 이하의 간선이 있습니다.
 vertex 배열 각 행 [a, b]는 a번 노드와 b번 노드 사이에 간선이 있다는 의미입니다.
 입출력 예
 n    vertex                                                      return
 6    [[3, 6], [4, 3], [3, 2], [1, 3], [1, 2], [2, 4], [5, 2]]    3
 
 */

import Foundation

struct Queue<T> {
    private var elements = [T]()
    private var index = 0
    
    mutating func enqueue(element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard index < elements.count
        else { return nil }
        
        let popElement = elements[index]
        
        index += 1
        
        if index > 2 {
            elements.removeFirst(3)
            
            index = 0
        }
        
        return popElement
    }
}

func solution(_ n:Int, _ edge:[[Int]]) -> Int {

    var map = [[Int]](repeating: [], count: n+1)
    
    // MARK: 최대한 Array로 만들자
    for vertexs in edge {
        map[vertexs[0]].append(vertexs[1])
        map[vertexs[1]].append(vertexs[0])
    }
    
    var visitedVertexs = [Int](repeating: 500001, count: n+1)
    
    var visitingVertexs = Queue<(Int, Int)>()
    visitingVertexs.enqueue(element: (1, 0))
    
    while let popVertex = visitingVertexs.dequeue() {
        
        for visitingVertex in map[popVertex.0] {
            if visitedVertexs[visitingVertex] > popVertex.1 + 1 {
                visitedVertexs[visitingVertex] = popVertex.1 + 1
                visitingVertexs.enqueue(element: (visitingVertex, popVertex.1 + 1))
            }
        }
    }
    
    visitedVertexs[0] = 0
    visitedVertexs[1] = 0
    
    let max = visitedVertexs.max()!
    // MARK: max()를 filter에다 집어넣지 말자
    return visitedVertexs.filter{ $0 == max }.count
}

/*
 다익스트라 문제
 처음 접근 시, Dict을 이용하여 문제를 풀려 했으나 시간초과로 인해 배열로 바꿔서 통과

 
 */
print(solution(6, [[3, 6], [4, 3], [3, 2], [1, 3], [1, 2], [2, 4], [5, 2]]))

/*
 테스트 1 〉    통과 (0.12ms, 16.2MB)
 테스트 2 〉    통과 (0.54ms, 16.1MB)
 테스트 3 〉    통과 (0.16ms, 16.3MB)
 테스트 4 〉    통과 (0.41ms, 16.2MB)
 테스트 5 〉    통과 (1.29ms, 17.1MB)
 테스트 6 〉    통과 (2.83ms, 17.7MB)
 테스트 7 〉    통과 (29.40ms, 25.7MB)
 테스트 8 〉    통과 (50.88ms, 29.3MB)
 테스트 9 〉    통과 (49.52ms, 29.5MB)
 
 테스트 1 〉    통과 (0.20ms, 16.5MB)
 테스트 2 〉    통과 (0.14ms, 16.4MB)
 테스트 3 〉    통과 (0.25ms, 16.3MB)
 테스트 4 〉    통과 (0.59ms, 16.4MB)
 테스트 5 〉    통과 (2.15ms, 17MB)
 테스트 6 〉    통과 (4.98ms, 17.8MB)
 테스트 7 〉    통과 (45.65ms, 25.6MB)
 테스트 8 〉    통과 (61.85ms, 29.8MB)
 테스트 9 〉    통과 (87.55ms, 29.9MB)
 
 테스트 1 〉    통과 (0.10ms, 16.2MB)
 테스트 2 〉    통과 (0.11ms, 16.5MB)
 테스트 3 〉    통과 (0.13ms, 16.3MB)
 테스트 4 〉    통과 (0.42ms, 16.5MB)
 테스트 5 〉    통과 (1.43ms, 17MB)
 테스트 6 〉    통과 (3.18ms, 17.6MB)
 테스트 7 〉    통과 (35.07ms, 25.7MB)
 테스트 8 〉    통과 (40.98ms, 29.8MB)
 테스트 9 〉    통과 (69.02ms, 29.8MB)
 */
