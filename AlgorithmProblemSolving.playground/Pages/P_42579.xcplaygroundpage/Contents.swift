/*
베스트 앨범
 
문제 설명
스트리밍 사이트에서 장르 별로 가장 많이 재생된 노래를 두 개씩 모아 베스트 앨범을 출시하려 합니다. 노래는 고유 번호로 구분하며, 노래를 수록하는 기준은 다음과 같습니다.

속한 노래가 많이 재생된 장르를 먼저 수록합니다.
장르 내에서 많이 재생된 노래를 먼저 수록합니다.
장르 내에서 재생 횟수가 같은 노래 중에서는 고유 번호가 낮은 노래를 먼저 수록합니다.
노래의 장르를 나타내는 문자열 배열 genres와 노래별 재생 횟수를 나타내는 정수 배열 plays가 주어질 때, 베스트 앨범에 들어갈 노래의 고유 번호를 순서대로 return 하도록 solution 함수를 완성하세요.

제한사항
genres[i]는 고유번호가 i인 노래의 장르입니다.
plays[i]는 고유번호가 i인 노래가 재생된 횟수입니다.
genres와 plays의 길이는 같으며, 이는 1 이상 10,000 이하입니다.
장르 종류는 100개 미만입니다.
장르에 속한 곡이 하나라면, 하나의 곡만 선택합니다.
모든 장르는 재생된 횟수가 다릅니다.
입출력 예
genres    plays    return
["classic", "pop", "classic", "classic", "pop"]    [500, 600, 150, 800, 2500]    [4, 1, 3, 0]
입출력 예 설명
classic 장르는 1,450회 재생되었으며, classic 노래는 다음과 같습니다.

고유 번호 3: 800회 재생
고유 번호 0: 500회 재생
고유 번호 2: 150회 재생
pop 장르는 3,100회 재생되었으며, pop 노래는 다음과 같습니다.

고유 번호 4: 2,500회 재생
고유 번호 1: 600회 재생
따라서 pop 장르의 [4, 1]번 노래를 먼저, classic 장르의 [3, 0]번 노래를 그다음에 수록합니다.

장르 별로 가장 많이 재생된 노래를 최대 두 개까지 모아 베스트 앨범을 출시하므로 2번 노래는 수록되지 않습니다.
*/

import Foundation

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    
    let plays = plays.enumerated().sorted(by: { $0.1 > $1.1 })
    var genresInfos = [String: (Int, [Int])]()
    
    for play in plays {
        let genres = genres[play.offset]
        
        var genresInfo = genresInfos[genres, default: (0, [])]
        
        genresInfo.0 += play.element
        if genresInfo.1.count < 2 {
            genresInfo.1.append(play.offset)
        }
        
        genresInfos.updateValue(genresInfo, forKey: genres)
    }
    
    let arr = genresInfos.values.sorted(by: {
        $0.0 > $1.0
    }).flatMap { $0.1 }
    
    return arr
}

/*
 정확성  테스트
 테스트 1 〉    통과 (0.23ms, 16.5MB)
 테스트 2 〉    통과 (0.25ms, 16.4MB)
 테스트 3 〉    통과 (0.19ms, 16.3MB)
 테스트 4 〉    통과 (0.21ms, 16.5MB)
 테스트 5 〉    통과 (0.46ms, 16.6MB)
 테스트 6 〉    통과 (0.37ms, 16.2MB)
 테스트 7 〉    통과 (0.31ms, 16.4MB)
 테스트 8 〉    통과 (0.27ms, 16.6MB)
 테스트 9 〉    통과 (0.23ms, 16.7MB)
 테스트 10 〉    통과 (0.49ms, 16.5MB)
 테스트 11 〉    통과 (0.23ms, 16.5MB)
 테스트 12 〉    통과 (0.57ms, 16.4MB)
 테스트 13 〉    통과 (0.44ms, 16.6MB)
 테스트 14 〉    통과 (0.51ms, 16.2MB)
 테스트 15 〉    통과 (0.37ms, 16.4MB)
 */


import Foundation

func solution2(_ genres: [String], _ plays: [Int]) -> [Int] {
    var genreMap = [String: [(index: Int, plays: Int)]]()
    var genrePlayCount = [String: Int]()
    
    // 데이터 구조화
    for (index, (genre, play)) in zip(genres, plays).enumerated() {
        genreMap[genre, default: []].append((index, play))
        genrePlayCount[genre, default: 0] += play
    }
    
    // 장르별 정렬 및 결과 생성
    return genrePlayCount.sorted { $0.value > $1.value }
        .flatMap { genre -> [Int] in
            return genreMap[genre.key]!
                .sorted {
                    if $0.plays == $1.plays {
                        return $0.index < $1.index
                    }
                    return $0.plays > $1.plays
                }
                .prefix(2)
                .map { $0.index }
        }
}

solution(["classic", "pop", "classic", "classic", "pop"], [500, 600, 150, 800, 2500])
