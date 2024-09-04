/*
 불량 사용자
 
문제 설명
개발팀 내에서 이벤트 개발을 담당하고 있는 "무지"는 최근 진행된 카카오이모티콘 이벤트에 비정상적인 방법으로 당첨을 시도한 응모자들을 발견하였습니다. 이런 응모자들을 따로 모아 불량 사용자라는 이름으로 목록을 만들어서 당첨 처리 시 제외하도록 이벤트 당첨자 담당자인 "프로도" 에게 전달하려고 합니다. 이 때 개인정보 보호을 위해 사용자 아이디 중 일부 문자를 '*' 문자로 가려서 전달했습니다. 가리고자 하는 문자 하나에 '*' 문자 하나를 사용하였고 아이디 당 최소 하나 이상의 '*' 문자를 사용하였습니다.
"무지"와 "프로도"는 불량 사용자 목록에 매핑된 응모자 아이디를 제재 아이디 라고 부르기로 하였습니다.

예를 들어, 이벤트에 응모한 전체 사용자 아이디 목록이 다음과 같다면

응모자 아이디
frodo
fradi
crodo
abc123
frodoc
다음과 같이 불량 사용자 아이디 목록이 전달된 경우,

불량 사용자
fr*d*
abc1**
불량 사용자에 매핑되어 당첨에서 제외되어야 야 할 제재 아이디 목록은 다음과 같이 두 가지 경우가 있을 수 있습니다.

제재 아이디
frodo
abc123
제재 아이디
fradi
abc123
이벤트 응모자 아이디 목록이 담긴 배열 user_id와 불량 사용자 아이디 목록이 담긴 배열 banned_id가 매개변수로 주어질 때, 당첨에서 제외되어야 할 제재 아이디 목록은 몇가지 경우의 수가 가능한 지 return 하도록 solution 함수를 완성해주세요.

[제한사항]
user_id 배열의 크기는 1 이상 8 이하입니다.
user_id 배열 각 원소들의 값은 길이가 1 이상 8 이하인 문자열입니다.
응모한 사용자 아이디들은 서로 중복되지 않습니다.
응모한 사용자 아이디는 알파벳 소문자와 숫자로만으로 구성되어 있습니다.
banned_id 배열의 크기는 1 이상 user_id 배열의 크기 이하입니다.
banned_id 배열 각 원소들의 값은 길이가 1 이상 8 이하인 문자열입니다.
불량 사용자 아이디는 알파벳 소문자와 숫자, 가리기 위한 문자 '*' 로만 이루어져 있습니다.
불량 사용자 아이디는 '*' 문자를 하나 이상 포함하고 있습니다.
불량 사용자 아이디 하나는 응모자 아이디 중 하나에 해당하고 같은 응모자 아이디가 중복해서 제재 아이디 목록에 들어가는 경우는 없습니다.
제재 아이디 목록들을 구했을 때 아이디들이 나열된 순서와 관계없이 아이디 목록의 내용이 동일하다면 같은 것으로 처리하여 하나로 세면 됩니다.
[입출력 예]
user_id    banned_id    result
["frodo", "fradi", "crodo", "abc123", "frodoc"]    ["fr*d*", "abc1**"]    2
["frodo", "fradi", "crodo", "abc123", "frodoc"]    ["*rodo", "*rodo", "******"]    2
["frodo", "fradi", "crodo", "abc123", "frodoc"]    ["fr*d*", "*rodo", "******", "******"]    3

*/


import Foundation

func solution(_ user_id:[String], _ banned_id:[String]) -> Int {
    var bannedIDs = [Int: [String]]()
    var index = 0
    
    var set = Set<[String]>()
    
    func getValue(index: Int, contains: Set<String>) {
        var contains = contains
        
        if index == bannedIDs.count{
            set.insert(contains.sorted(by: <))
            return
        }
        
        for ids in bannedIDs[index, default: []] {
            if contains.contains(ids) == false {
                
                // MARK: - remove해야지 백트래킹이 됩니다!
                contains.insert(ids)
                getValue(index: index + 1, contains: contains)
                contains.remove(ids)
            }
        }
    }
    
    for banned in banned_id {
        for user in user_id {
            if banned.isMatching(to: user) {
                bannedIDs[index, default: []].append(user)
            }
        }
        index += 1
    }
    
    getValue(index: 0, contains: [])

    return set.count
}

extension String {
    func isMatching(to target: String) -> Bool {
        
        // Case 1: 카운트가 같은 경우만
        guard self.count == target.count
        else { return false }
        
        // Case 2: 필터링
        for (targetWord, word) in zip(target, self) {
            if word == "*" { continue }
            if targetWord != word { return false }
        }
        
        return true
    }
}

/*
   백트래킹 문제
 */

solution(["frodo"], ["fr*d*"])
solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "abc1**"])
solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["*rodo", "*rodo", "******"])
solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "*rodo", "******", "******"]) // 4
