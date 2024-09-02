/*
단어 변환
 
문제 설명
두 개의 단어 begin, target과 단어의 집합 words가 있습니다. 아래와 같은 규칙을 이용하여 begin에서 target으로 변환하는 가장 짧은 변환 과정을 찾으려고 합니다.

1. 한 번에 한 개의 알파벳만 바꿀 수 있습니다.
2. words에 있는 단어로만 변환할 수 있습니다.
예를 들어 begin이 "hit", target가 "cog", words가 ["hot","dot","dog","lot","log","cog"]라면 "hit" -> "hot" -> "dot" -> "dog" -> "cog"와 같이 4단계를 거쳐 변환할 수 있습니다.

두 개의 단어 begin, target과 단어의 집합 words가 매개변수로 주어질 때, 최소 몇 단계의 과정을 거쳐 begin을 target으로 변환할 수 있는지 return 하도록 solution 함수를 작성해주세요.

제한사항
각 단어는 알파벳 소문자로만 이루어져 있습니다.
각 단어의 길이는 3 이상 10 이하이며 모든 단어의 길이는 같습니다.
words에는 3개 이상 50개 이하의 단어가 있으며 중복되는 단어는 없습니다.
begin과 target은 같지 않습니다.
변환할 수 없는 경우에는 0를 return 합니다.
입출력 예
begin    target    words    return
"hit"    "cog"    ["hot", "dot", "dog", "lot", "log", "cog"]    4
"hit"    "cog"    ["hot", "dot", "dog", "lot", "log"]    0

*/

import Foundation

struct Queue<T> {
    private var elements: [T] = []
    private var index: Int = 0
    
    mutating func enqueue(_ element: T) {
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

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    guard words.contains(target)
    else { return 0 }
    
    var visitingQueue = Queue<(String, Int)>()
    var visited = [Bool](repeating: false, count: words.count)
    
    visitingQueue.enqueue((begin, 0))
    
    while let popElement = visitingQueue.dequeue() {
        for (index, word) in words.enumerated() {
            if visited[index] == false && popElement.0.canChange(word) {
                if word == target {
                    return popElement.1 + 1
                }
                
                visitingQueue.enqueue((word, popElement.1 + 1))
                visited[index] = true
            }
        }
    }
    
    return 0
}

extension String {
    func canChange(_ word: String) -> Bool {
        var wrongWord = 0
        
        for (offset, char) in self.enumerated() {
            if char != word[word.index(word.startIndex, offsetBy: offset)] {
                wrongWord += 1
            }
            
            if wrongWord == 2 {
                return false
            }
        }
        return wrongWord == 1 ? true : false
        
    }
}

/*
 1. 알고리즘 선택
 a) 탐색 알고리즘 비교

 DFS(깊이 우선 탐색)와 BFS(너비 우선 탐색)를 고려함
 최단 경로 문제이므로 BFS를 선택

 b) BFS 선택 이유

 레벨 단위로 탐색하여 최단 경로 보장
 불필요한 깊은 탐색 방지
 효율적인 메모리 사용 (스택 오버플로우 위험 없음)

 2. 단어 비교 로직
 a) 문제 요구사항 분석

 한 번에 한 글자만 변경 가능
 변경된 단어는 주어진 단어 목록에 존재해야 함

 b) 비교 로직 설계

 두 단어를 순차적으로 비교
 다른 글자 수를 카운트
 정확히 한 글자만 다른 경우 true 반환

 c) 구현 방법

 String extension을 사용하여 canChange 메서드 구현
 시간 복잡도 O(n), 여기서 n은 단어의 길이

 3. BFS 구현 전략
 a) 자료 구조

 Queue를 사용하여 BFS 구현
 방문한 단어를 추적하기 위한 배열 사용

 b) 탐색 과정

 시작 단어부터 BFS 시작
 각 단계에서 한 글자만 다른 모든 단어를 큐에 추가
 목표 단어에 도달하면 즉시 탐색 종료

 c) 최적화

 이미 방문한 단어는 다시 방문하지 않음
 목표 단어가 주어진 단어 목록에 없는 경우 즉시 0 반환

 4. 시간 및 공간 복잡도

 시간 복잡도: O(N * M), N은 단어의 수, M은 단어의 길이
 공간 복잡도: O(N), 큐와 방문 배열을 위한 공간
 */

solution("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"])
solution("hit", "cog", ["hot", "dot", "dog", "lot", "log"])
