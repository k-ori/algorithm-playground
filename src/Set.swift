//
//  Set.swift
//  
//
//  Created by kori on 8/10/16.
//
//

import Foundation

// Intersection of two sorted arrays

let ar1 = [1, 12, 15, 19, 20, 21]
let ar2 = [2, 15, 17, 19, 19, 21, 25, 27]

func intersection(ar1: [Int], _ ar2: [Int]) -> Set<Int> {
  var i1 = 0
  var i2 = 0
  var intersection = Set<Int>()
  
  while(i1 < ar1.count && i2 < ar2.count) {
    if ar1[i1] < ar2[i2] { i1 += 1 }
    if ar1[i1] > ar2[i2] { i2 += 1 }
    if ar1[i1] == ar2[i2] {
      intersection.insert(ar1[i1])
      i1+=1
      i2+=1
    }
  }
  
  return intersection
}

assert(intersection(ar1, ar2)==Set([15, 19, 21]))

/////////////////////////////////

// http://www.slideshare.net/gayle2/cracking-the-facebook-coding-interview
// https://www.amazon.com/Cracking-Coding-Interview-Programming-Questions/dp/098478280X
// Q 8.3
//
// All subsets
// s = {"a", "b", "c"} -> [{}, {a}, {b}, {c}, {a, b}, ..., {a, b, c}]

// time complexity: n + (n-1) + .. 1 = O(S^2), S = Size of set
// space complexity: nCn + nCn-1 + ... + nC1 = 1 + n + .. n := O(S^2)?
func generateSubset(set: Set<String>) -> [Set<String>] {
  var orgSet = set
  guard let first = orgSet.first else { return [Set()] }
  orgSet.remove(first)
  let subset = generateSubset(orgSet) // Call stack: S
  return subset + subset.flatMap { Set([first]).union($0) }
}

assert(generateSubset(["a", "b", "c"]).count == 8)

/////////////////////////////////

/**
 https://www.amazon.com/Cracking-Coding-Interview-Programming-Questions/dp/098478280X
 Q 8.4

 s = "{a,b,c} -> "abc", "acb", "bac", "bca", "cab", "cba"
 
 [a + p({b,c})], [b + p({a,c})]

 
*/

// time complexity: O(n!)
// space complexity: O(n!)

func generatePermutation(set: Set<String>) -> [String] {
  guard set.count > 0 else { return [""] }
  return set.flatMap { (ch: String) -> [String] in
    var myset = set
    myset.remove(ch)
    return generatePermutation(myset).map { ch + $0 }
  }
}

assert(generatePermutation(Set(["a","b","c"])).count==6)

/**
 https://www.amazon.com/Cracking-Coding-Interview-Programming-Questions/dp/098478280X
 Q 8.5
 
 3 -> [[1,1,1], [1,2], [2,1], [3]] -> "()()()","()(())","(())()","((()))"
 
 */

func generateParenthesesComb(n: Int) -> [String] {
  return generateNumSet(n).map { nums in
    return nums
      .map { String(count: $0, repeatedValue: Character("(")) + String(count: $0, repeatedValue: Character(")")) }
      .joinWithSeparator("")
  }
}

// 3 ->
//  1 -> {1} + {gen(2)}
//  2 -> {2} + {gen(1)}
//  3 -> {3} + {gen(0)}

// 2 ->
//  1 -> {1} + {gen(1)}
//  2 -> {2} + {gen(0)}

func generateNumSet(n: Int) -> [[Int]] {
  guard n > 0 else { return [[]] }
  
  // invariant: n >= 1
  return Array(1...n).flatMap { m in
    return generateNumSet(n-m).map { [m] + $0 }
  }
}

assert(generateParenthesesComb(3).count==4)

/**
 https://www.amazon.com/Cracking-Coding-Interview-Programming-Questions/dp/098478280X
 Q 8.7
 
 31
 -> 25*1 + p(6)
 -> 10*3 + p(1)
 -> 10*2 + p(6)
 -> 10*1 + p(21)
 ->  5*6 + p(1)
 ->  5*5 + p(6)
 
 */

func payNCents(n: Int, coins: [Int] = [25, 10, 5]) -> Int {
  let available = coins.filter { $0 <= n }
  guard let first = available.first else { return 1 }
  
  var res = 0
  for i in 0...n/first {
    res += payNCents(n-(first*i), coins: Array(available[1..<available.count]))
  }
  
  return res
}

assert(payNCents(15)==6)
