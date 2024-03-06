import Foundation


//TASK 1

func lengthOfLongestSubstring(_ s: String) -> Int {
    var maxLength = 0
    var start = 0
    var charIndexMap = [Character: Int]()
    
    for (index, char) in s.enumerated() {
        if let prevIndex = charIndexMap[char], prevIndex >= start {
            start = prevIndex + 1
        }
        maxLength = max(maxLength, index - start + 1)
        charIndexMap[char] = index
    }
    return maxLength
}
print("max length of substring is: \(lengthOfLongestSubstring("abcabcbb"))")

//TASK 2

func minWindow(_ s: String, _ t: String) -> String {
    var targetCharacterCounts = [Character: Int]()
    for char in t {
        targetCharacterCounts[char, default: 0] += 1
    }
    
    var windowCharacterCounts = [Character: Int]()
    var leftIndex = 0
    var minLength = Int.max
    var resultStartIndex = 0
    var requiredCharacters = t.count
    
    let inputArray = Array(s)
    for rightIndex in 0..<s.count {
        let currentChar = inputArray[rightIndex]
        if let targetCharCount = targetCharacterCounts[currentChar] {
            windowCharacterCounts[currentChar, default: 0] += 1
            if windowCharacterCounts[currentChar]! <= targetCharCount {
                requiredCharacters -= 1
            }
        }
        
        while requiredCharacters == 0 {
            if rightIndex - leftIndex + 1 < minLength {
                minLength = rightIndex - leftIndex + 1
                resultStartIndex = leftIndex
            }
            
            let leftChar = inputArray[leftIndex]
            if let targetCharCount = targetCharacterCounts[leftChar], let windowCharCount = windowCharacterCounts[leftChar] {
                if windowCharCount == targetCharCount {
                    requiredCharacters += 1
                }
                windowCharacterCounts[leftChar]! -= 1
            }
            leftIndex += 1
        }
    }
    
    return minLength == Int.max ? "" : String(inputArray[resultStartIndex..<resultStartIndex + minLength])
    
}

print(minWindow("ADOBECODEBANC", "ABC"))

//TASK 3

func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    let wordSet = Set(wordDict)
    var canFormWords = [Bool](repeating: false, count: s.count + 1)
    canFormWords[0] = true
    
    for i in 1...s.count {
        for j in 0..<i {
            let startIndex = s.index(s.startIndex, offsetBy: j)
            let endIndex = s.index(s.startIndex, offsetBy: i)
            if canFormWords[j] && wordSet.contains(String(s[startIndex..<endIndex])) {
                canFormWords[i] = true
                break
            }
        }
    }
    
    return canFormWords[s.count]
}

print(wordBreak("leetcode", ["leet", "code"]))

//TASK 4

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var frequencyMap = [Int: Int]()
    for num in nums {
        frequencyMap[num, default: 0] += 1
    }
    
    let sortedByFrequency = frequencyMap.sorted { $0.value > $1.value }.map { $0.key }
    
    let firstTwoElements = Array(sortedByFrequency.prefix(k))
    
    return firstTwoElements
    
}

print(topKFrequent([1, 1, 1, 2, 2, 3], 1))


//TASK: 5
func minMeetingRooms(_ intervals: [[Int]]) -> Int {
    var times = [(Int, Bool)]()
    
    for interval in intervals {
        times.append((interval[0], true))
        times.append((interval[1], false))
    }
    
    times.sort { (a, b) in
        if a.0 != b.0 {
            return a.0 < b.0
        } else {
            return a.1 == false
        }
    }
    
    var rooms = 0
    var maxRooms = 0
    
    for time in times {
        if time.1 {
            rooms += 1
            maxRooms = max(maxRooms, rooms)
        } else {
            rooms -= 1
        }
    }
    
    return maxRooms
}

print(minMeetingRooms([[0, 30],[5, 15],[15, 20]]))
