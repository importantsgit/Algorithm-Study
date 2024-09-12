/*
 경주로 건설
 
 건설회사의 설계사인 죠르디는 고객사로부터 자동차 경주로 건설에 필요한 견적을 의뢰받았습니다.
 제공된 경주로 설계 도면에 따르면 경주로 부지는 N x N 크기의 정사각형 격자 형태이며 각 격자는 1 x 1 크기입니다.
 설계 도면에는 각 격자의 칸은 0 또는 1 로 채워져 있으며, 0은 칸이 비어 있음을 1은 해당 칸이 벽으로 채워져 있음을 나타냅니다.
 경주로의 출발점은 (0, 0) 칸(좌측 상단)이며, 도착점은 (N-1, N-1) 칸(우측 하단)입니다. 죠르디는 출발점인 (0, 0) 칸에서 출발한 자동차가 도착점인 (N-1, N-1) 칸까지 무사히 도달할 수 있게 중간에 끊기지 않도록 경주로를 건설해야 합니다.
 경주로는 상, 하, 좌, 우로 인접한 두 빈 칸을 연결하여 건설할 수 있으며, 벽이 있는 칸에는 경주로를 건설할 수 없습니다.
 이때, 인접한 두 빈 칸을 상하 또는 좌우로 연결한 경주로를 직선 도로 라고 합니다.
 또한 두 직선 도로가 서로 직각으로 만나는 지점을 코너 라고 부릅니다.
 건설 비용을 계산해 보니 직선 도로 하나를 만들 때는 100원이 소요되며, 코너를 하나 만들 때는 500원이 추가로 듭니다.
 죠르디는 견적서 작성을 위해 경주로를 건설하는 데 필요한 최소 비용을 계산해야 합니다.

 예를 들어, 아래 그림은 직선 도로 6개와 코너 4개로 구성된 임의의 경주로 예시이며, 건설 비용은 6 x 100 + 4 x 500 = 2600원 입니다.

 kakao_road2.png

 또 다른 예로, 아래 그림은 직선 도로 4개와 코너 1개로 구성된 경주로이며, 건설 비용은 4 x 100 + 1 x 500 = 900원 입니다.

 kakao_road3.png

 도면의 상태(0은 비어 있음, 1은 벽)을 나타내는 2차원 배열 board가 매개변수로 주어질 때, 경주로를 건설하는데 필요한 최소 비용을 return 하도록 solution 함수를 완성해주세요.

 [제한사항]
 board는 2차원 정사각 배열로 배열의 크기는 3 이상 25 이하입니다.
 board 배열의 각 원소의 값은 0 또는 1 입니다.
 도면의 가장 왼쪽 상단 좌표는 (0, 0)이며, 가장 우측 하단 좌표는 (N-1, N-1) 입니다.
 원소의 값 0은 칸이 비어 있어 도로 연결이 가능함을 1은 칸이 벽으로 채워져 있어 도로 연결이 불가능함을 나타냅니다.
 board는 항상 출발점에서 도착점까지 경주로를 건설할 수 있는 형태로 주어집니다.
 출발점과 도착점 칸의 원소의 값은 항상 0으로 주어집니다.
 입출력 예
 board    result
 [[0,0,0],[0,0,0],[0,0,0]]    900
 [[0,0,0,0,0,0,0,1],[0,0,0,0,0,0,0,0],[0,0,0,0,0,1,0,0],[0,0,0,0,1,0,0,0],[0,0,0,1,0,0,0,1],[0,0,1,0,0,0,1,0],[0,1,0,0,0,1,0,0],[1,0,0,0,0,0,0,0]]    3800
 [[0,0,1,0],[0,0,0,0],[0,1,0,1],[1,0,0,0]]    2100
 [[0,0,0,0,0,0],[0,1,1,1,1,0],[0,0,1,0,0,0],[1,0,0,1,0,1],[0,1,0,0,0,1],[0,0,0,0,0,0]]    3200
 입출력 예에 대한 설명
 입출력 예 #1

 본문의 예시와 같습니다.

 입출력 예 #2

 kakao_road4.png

 위와 같이 경주로를 건설하면 직선 도로 18개, 코너 4개로 총 3800원이 듭니다.

 입출력 예 #3

 kakao_road5.png

 위와 같이 경주로를 건설하면 직선 도로 6개, 코너 3개로 총 2100원이 듭니다.

 입출력 예 #4

 kakao_road6.png

 붉은색 경로와 같이 경주로를 건설하면 직선 도로 12개, 코너 4개로 총 3200원이 듭니다.
 만약, 파란색 경로와 같이 경주로를 건설한다면 직선 도로 10개, 코너 5개로 총 3500원이 들며, 더 많은 비용이 듭니다.
 */

import Foundation

func solution(_ board: [[Int]]) -> Int {
    let N = board.count
    var visitedMap = [[Int]](repeating: [Int](repeating: Int.max, count: N), count: N)
    var stack = [(Int, (Int, Int), Int)]()
    var direction = [1: (1, 0), 2: (-1, 0), 3: (0, 1), 4: (0, -1)]
    
    stack.append((1, (1, 0), 100))
    stack.append((3, (0, 1), 100))
    visitedMap[1][0] = 100
    visitedMap[0][1] = 100
    
    while let node = stack.popLast() {
        let currentX = node.1.0, currentY = node.1.1
        
        guard visitedMap[currentY][currentX] >= node.2 && board[currentY][currentX] != 1
        else { continue }
        
        visitedMap[currentY][currentX] = node.2
        
        for dir in 1...4 {
            let (nextX, nextY) = (direction[dir]!.0 + currentX, direction[dir]!.1 + currentY)
            
            if 0..<N ~= nextX && 0..<N ~= nextY {
                let nextValue = (node.0 == dir ? 100 : 600) + node.2
            
                stack.append((dir, (nextX, nextY), nextValue))
            }
        }
    }
    
    return visitedMap[N-1][N-1]
}
// 14, 25 틀림

func solution(_ board: [[Int]]) -> Int {
    let N = board.count
    var costs = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: Int.max, count: 4), count: N), count: N)
    var stack = [(x: Int, y: Int, cost: Int, dir: Int)]()
    var direction = [(0, 1), (1, 0), (-1, 0), (0, -1)]
    
    stack.append((x: 0, y: 0, cost: 0, dir: 0))
    stack.append((x: 0, y: 0, cost: 0, dir: 1))
    
    while let node = stack.popLast() {
        if (0..<N ~= node.x && 0..<N ~= node.y) &&
            board[node.y][node.x] == 0 &&
            costs[node.y][node.x][node.dir] >= node.cost {
            
            costs[node.y][node.x][node.dir] = node.cost
            
            if node.y == N-1 && node.x == N-1 { continue }
            
            for (nextDir, (x, y)) in direction.enumerated() {
                let nextCost = nextDir == node.dir ? 100 : 600
                stack.append((x: node.x + x, y: node.y + y, cost: nextCost, dir: nextDir))
            }
        }
    }
    
    return costs[N-1][N-1].min()!
}
/*
 테스트 1 〉    통과 (0.18ms, 16.2MB)
 테스트 2 〉    통과 (0.13ms, 16.4MB)
 테스트 3 〉    통과 (0.12ms, 16.1MB)
 테스트 4 〉    통과 (0.30ms, 16.3MB)
 테스트 5 〉    통과 (0.35ms, 16.5MB)
 테스트 6 〉    통과 (47.37ms, 16.1MB)
 테스트 7 〉    통과 (41.41ms, 16.3MB)
 테스트 8 〉    통과 (34.77ms, 16.5MB)
 테스트 9 〉    통과 (47.20ms, 16.6MB)
 테스트 10 〉    통과 (150.35ms, 16.1MB)
 테스트 11 〉    통과 (2034.75ms, 16.6MB)
 테스트 12 〉    통과 (9754.21ms, 16.6MB)
 테스트 13 〉    통과 (5.36ms, 16.4MB)
 테스트 14 〉    통과 (13.47ms, 16.3MB)
 테스트 15 〉    통과 (364.67ms, 16.5MB)
 테스트 16 〉    통과 (810.25ms, 16.7MB)
 테스트 17 〉    통과 (1146.53ms, 16.4MB)
 테스트 18 〉    통과 (2583.20ms, 16.7MB)
 테스트 19 〉    통과 (1079.14ms, 16.5MB)
 테스트 20 〉    통과 (61.00ms, 16.7MB)
 테스트 21 〉    통과 (30.39ms, 16.5MB)
 테스트 22 〉    통과 (1.01ms, 16.5MB)
 테스트 23 〉    통과 (0.54ms, 16.6MB)
 테스트 24 〉    통과 (0.64ms, 16.1MB)
 테스트 25 〉    통과 (0.28ms, 16.5MB)
 
 */


func solutionBFS(_ board: [[Int]]) -> Int {
    let N = board.count
    var costs = Array(repeating: Array(repeating: Array(repeating: Int.max, count: 4), count: N), count: N)
    var queue = [(x: Int, y: Int, dir: Int, cost: Int)]()
    let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]  // 동, 남, 서, 북
    
    // 시작점 초기화
    queue.append((0, 0, -1, 0))
    
    while !queue.isEmpty {
        let (x, y, dir, cost) = queue.removeFirst()
        
        if x == N-1 && y == N-1 {
            continue  // 도착점에 도달했을 때의 처리
        }
        
        for (newDir, (dx, dy)) in directions.enumerated() {
            let newX = x + dx
            let newY = y + dy
            
            guard 0..<N ~= newX && 0..<N ~= newY && board[newY][newX] == 0 else { continue }
            
            let newCost = cost + (dir == -1 || dir == newDir ? 100 : 600)
            
            if newCost < costs[newY][newX][newDir] {
                costs[newY][newX][newDir] = newCost
                queue.append((newX, newY, newDir, newCost))
            }
        }
    }
    
    return costs[N-1][N-1].min()!
}
/*
 테스트 1 〉    통과 (0.15ms, 16.1MB)
 테스트 2 〉    통과 (0.22ms, 16.3MB)
 테스트 3 〉    통과 (0.12ms, 16.3MB)
 테스트 4 〉    통과 (0.28ms, 16.3MB)
 테스트 5 〉    통과 (0.19ms, 16MB)
 테스트 6 〉    통과 (0.93ms, 16.4MB)
 테스트 7 〉    통과 (1.05ms, 16.5MB)
 테스트 8 〉    통과 (0.89ms, 16.3MB)
 테스트 9 〉    통과 (1.97ms, 16MB)
 테스트 10 〉    통과 (1.83ms, 16.7MB)
 테스트 11 〉    통과 (34.44ms, 16.7MB)
 테스트 12 〉    통과 (6.50ms, 16.4MB)
 테스트 13 〉    통과 (0.99ms, 16.5MB)
 테스트 14 〉    통과 (1.37ms, 16.4MB)
 테스트 15 〉    통과 (2.59ms, 16.3MB)
 테스트 16 〉    통과 (3.65ms, 16.7MB)
 테스트 17 〉    통과 (15.31ms, 16.6MB)
 테스트 18 〉    통과 (10.44ms, 16.5MB)
 테스트 19 〉    통과 (37.01ms, 16.3MB)
 테스트 20 〉    통과 (2.90ms, 16.4MB)
 테스트 21 〉    통과 (3.51ms, 16.6MB)
 테스트 22 〉    통과 (0.28ms, 16.4MB)
 테스트 23 〉    통과 (0.35ms, 16.2MB)
 테스트 24 〉    통과 (0.43ms, 16.4MB)
 테스트 25 〉    통과 (0.33ms, 16.6MB)

 */
