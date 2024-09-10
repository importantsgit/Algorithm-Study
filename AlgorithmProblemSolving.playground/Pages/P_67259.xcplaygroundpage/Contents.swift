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
    var stack = [(Int, (Int, Int))]()
    var direction = [1: (0, 1), 2: (0, -1), 3: (1, 0), 4: (-1, 0)]
    stack.append((0, (0, 0)))
    visitedMap[0][0] = 0
    

    
    while let node = stack.popLast() {
        print(node.1)
        let currentValue = visitedMap[node.1.1][node.1.0]
        
        for dir in 1...4 {
            let dirPosition = direction[dir]!
            print("dirPosition: \(dirPosition)")
            let moveX = dirPosition.0 + node.1.0, moveY = dirPosition.1 + node.1.1
            
            if 0..<N ~= moveX && 0..<N ~= moveY && board[moveY][moveY] != 1 {
                print("move: \(moveX), \(moveY), \(visitedMap.count)")
                let nextValue = visitedMap[moveY][moveX]
                
                let addValue = (node.0 == 0 || node.0 == dir) ? 100 : 600
                
                if nextValue >= currentValue + addValue {
                    if moveX == N - 1 && moveY == N - 1 {
                        continue
                    }
                    print(currentValue, addValue)
                    visitedMap[moveY][moveX] = currentValue + addValue
                    stack.append((dir, (moveX, moveY)))
                }
            }
        }
    }
    
    return visitedMap[N][N]
}

func solution3(_ board:[[Int]]) -> Int {
    
    var visitedMap = [[Int]](repeating: [Int](repeating: Int.max, count: board.count), count: board.count)
    var visitingStack = [(MoveDirection, [Int])]()
    
    enum MoveDirection: CaseIterable {
        case top
        case bottom
        case left
        case right
        case normal
    }
    
    var moveDirection: [MoveDirection: (Int, Int)] = [
        .right: (1,0),
        .left: (-1,0),
        .top: (0,-1),
        .bottom: (0,1)
    ]
    
    visitingStack.append((.normal, [0, 0]))
    visitedMap[0][0] = 0

    while let node = visitingStack.popLast() {
        let currentValue = visitedMap[node.1.last!][node.1.first!]
        
        for direction in MoveDirection.allCases {
            if direction == .normal { continue }
            
            
            let position = moveDirection[direction]!
            let x = position.0 + node.1.first!
            let y = position.1 + node.1.last!

            if (0..<board.count ~= x && 0..<board.count ~= y) && board[y][x] != 1 {
                let nextValue = currentValue + ( node.0 == .normal || node.0 == direction ? 100 : 600)
                
                if visitedMap[y][x] >= nextValue {
                    visitedMap[y][x] = nextValue
                    visitingStack.append((direction, [x, y]))
                }
            }
        }
    }
    
    return visitedMap[board.count-1][board.count-1]
}


//var a = solution([[0,0,0],
//          [0,0,0],
//          [0,0,0]])
//
//print("900 \(a)")

//a = solution( [[0,0,0,0,0,0,0,1],
//           [0,0,0,0,0,0,0,0],
//           [0,0,0,0,0,1,0,0],
//           [0,0,0,0,1,0,0,0],
//           [0,0,0,1,0,0,0,1],
//           [0,0,1,0,0,0,1,0],
//           [0,1,0,0,0,1,0,0],
//           [1,0,0,0,0,0,0,0]])
//
//print("3800 \(a)")

let a = solution(
    [[0,0,1,0],
     [0,0,0,0],
     [0,1,0,1],
     [1,0,0,0]])

print("2100 \(a)")
        
//a = solution([[0,0,0,0,0,0],
//          [0,1,1,1,1,0],
//          [0,0,1,0,0,0],
//          [1,0,0,1,0,1],
//          [0,1,0,0,0,1],
//          [0,0,0,0,0,0]])
//
//print("3200 \(a)")

func solution1(_ board:[[Int]]) -> Int {
    let N = board.count
    let dir = [[-1,0,1,0],[0,1,0,-1]]
    
    // 좌표까지 경주로를 건설할 때 사용되는 최소 cost 저장, Int.max값으로 초기화
    var costBoard = [[Int]](repeating: [Int](repeating: Int.max, count: N), count: N)
    
    func isInside(_ r: Int, _ c: Int) -> Bool {
        if r < 0 || r >= N || c < 0 || c >= N {
            return false
        }
        return true
    }
    
    // dir: 현재 위치로 오게된 방향 인덱스
    func dfs(_ cur: (r: Int, c: Int, cost: Int, dir: Int)) {
        
        // 이동한 곳이 벽이거나 배열에 저장된 최솟값 보다 큰 경우 바로 리턴
        if board[cur.r][cur.c] == 1 || cur.cost > costBoard[cur.r][cur.c] {
            return
        }
        
        // 최솟값으로 갱신
        costBoard[cur.r][cur.c] = cur.cost
    
        // 상하좌우로 탐색
        for idx in 0..<4 {
            let nr = cur.r + dir[0][idx]
            let nc = cur.c + dir[1][idx]
            
            if isInside(nr, nc) {
                // 직전 방향과 같을 경우, cost + 100
                if cur.dir == idx {
                    dfs((r: nr, c: nc, cost: cur.cost + 100, idx))
                } else {
                // 방향을 꺾을 경우 코너 + 직선도로가 생기므로 cost + (100 + 500)
                    dfs((r: nr, c: nc, cost: cur.cost + 600, idx))
                }
            }
        }
    }
    
    // 출발점 cost 0으로 갱신
    
    costBoard[0][0] = 0
    
    // 출발점에선 상하좌우 중 하, 우방향만 가능하므로 두 방향으로 dfs 함수 호출
    
    dfs((r: 0, c: 1, cost: 100, dir: 1))
    dfs((r: 1, c: 0, cost: 100, dir: 2))
    
    // 도착점 최솟값 리턴
    return costBoard[N - 1][N - 1]
}

let b = solution(
    [[0,0,1,0],
     [0,0,0,0],
     [0,1,0,1],
     [1,0,0,0]])

print("2100 \(b)")
