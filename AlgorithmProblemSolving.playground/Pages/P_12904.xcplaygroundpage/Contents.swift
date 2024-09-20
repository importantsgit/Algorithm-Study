/*
 가장 긴 팰린드롬
 
문제 설명
앞뒤를 뒤집어도 똑같은 문자열을 팰린드롬(palindrome)이라고 합니다.
문자열 s가 주어질 때, s의 부분문자열(Substring)중 가장 긴 팰린드롬의 길이를 return 하는 solution 함수를 완성해 주세요.

예를들면, 문자열 s가 "abcdcba"이면 7을 return하고 "abacde"이면 3을 return합니다.

제한사항
문자열 s의 길이 : 2,500 이하의 자연수
문자열 s는 알파벳 소문자로만 구성
입출력 예
s    answer
"abcdcba"    7
"abacde"    3
입출력 예 설명
입출력 예 #1
4번째자리 'd'를 기준으로 문자열 s 전체가 팰린드롬이 되므로 7을 return합니다.

입출력 예 #2
2번째자리 'b'를 기준으로 "aba"가 팰린드롬이 되므로 3을 return합니다.
*/

import Foundation

func solution1(_ s:String) -> Int {
    var result = 0
    var cache = [[Int]](repeating: [Int](repeating: -1, count: s.count), count: s.count)
    
    func split(_ s: String) -> String {
        if s.count == 1 {
            return s
        }
        
        let start = 0, end = s.count - 1
        
        if cache[start][end] != -1 {
            return s
        }
        
        let mid = (end + start) / 2
        
        let leftString: String, rightString: String
        
        if s.count.isMultiple(of: 2) {
            leftString = split(s[start, mid]!)
            rightString = split(s[mid + 1, end]!)
        } else {
            leftString = split(s[start, mid - 1]!)
            rightString = split(s[mid + 1, end]!)
        }
        
        if leftString == String(rightString.reversed()) {
            result = max(result, s.count)
            cache[start][end] = result
        }
        
        return s
    }
    
    split(s)

    return result
}

extension String {
    subscript(start: Int, end: Int) -> String? {
        guard 0 <= start && end < self.count && start <= end
        else { return nil }
        
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        
        return String(self[startIndex...endIndex])
    }
}

// 이럴 경우 abbacde나 abbbde와 같은 경우를 감지하지 못함

import Foundation

func solution(_ s:String) -> Int {
    var result = 0
    var stringArray = Array(s)
    
    func expand(left: Int, right: Int) -> Int { // 팰린드롬 값 반환
        var left = left, right = right
        
        while left >= 0 && right < stringArray.count && stringArray[left] == stringArray[right] {
            left -= 1
            right += 1
        }

        return right - left - 1
    }
    
    for index in stringArray.indices {
        let even = expand(left: index, right: index + 1)
        let odd = expand(left: index, right: index)
        
        result = max(result, max(even, odd))
    }

    return result
}
// 단순하게 중간값을 정하여 기준을 중심으로 양쪽 비교


print(solution("abcdcba"))
print(solution("abacde"))
print(solution("abbacde"))
print(solution("abbbde"))
