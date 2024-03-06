func lengthOfLongestSubstring(_ s: String) -> Int {
    var result = 0, chars = [Character]()
    for c in s {
        if let i = chars.firstIndex(of: c) {
            chars.removeSubrange(0...i)
        }
        chars.append(c)
        result = max(result, chars.count)
    }
    return result
}

func minWindow(_ s: String, _ t: String) -> String {
    var charCount = [Character: Int]()
    var requiredChars = t.count
    var left = 0
    var minLength = Int.max
    var minWindow = ""
    
    for char in t {
        charCount[char, default: 0] += 1
    }
    
    let sArray = Array(s)
    
    for right in 0..<s.count {
        let char = sArray[right]
        
        if let count = charCount[char] {
            charCount[char] = count - 1
            if count > 0 {
                requiredChars -= 1
            }
        }
        
        while requiredChars == 0 {
            if right - left + 1 < minLength {
                minLength = right - left + 1
                minWindow = String(sArray[left...right])
            }
            
            let leftChar = sArray[left]
            if let count = charCount[leftChar] {
                charCount[leftChar] = count + 1
                if count == 0 {
                    requiredChars += 1
                }
            }
            
            left += 1
        }
    }
    
    return minWindow
}

func wordBreak(_ s: String, _ words: [String]) -> Bool {
    var strings = Set<String>()
    guard !s.isEmpty else { return true }
    
    for word in words where s.hasPrefix(word) {
        if wordBreak(String(s.dropFirst(word.count)), words) {
            return true
        }
    }
    
    strings.insert(s)
    return false
}

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var frequency: [Int:Int] = [:]
    
    for i in nums {
        frequency[i, default: 0] += 1
    }
    
    let sorted = frequency.sorted { $0.1 > $1.1 }
    var result: [Int] = []

    for i in 0 ..< k {
        result.append(sorted[i].key)
    }

    return result
}

func minMeetingRooms(_ intervals: [[Int]]) -> Int {
    let sorted = intervals.sorted { $0[0] < $1[0] }
    var endTimes = [Int]()
    endTimes.append(sorted[0][1])

    for i in 1..<sorted.count {
        let currentMeeting = sorted[i]
        let currentStart = currentMeeting[0]
        let currentEnd = currentMeeting[1]

        if currentStart >= endTimes.first ?? 0 {
            endTimes[0] = currentEnd
        } else {
            endTimes.append(currentEnd)
            endTimes.sort()
        }
    }

    return endTimes.count
}

print(lengthOfLongestSubstring("abcabcbb"))
print(lengthOfLongestSubstring("bbbbb"))

print(minWindow("ADOBECODEBANC", "ABC"))
print(minWindow("a", "aa"))

print(wordBreak("leetcode", ["leet","code"]))
print(wordBreak("applepenapple", ["apple","pen"]))

print(topKFrequent([1,1,1,2,2,3], 2))
print(topKFrequent([1], 1))

print(minMeetingRooms([[0, 30], [5, 10], [15, 20]]))
print(minMeetingRooms([[7, 10], [2, 4]]))