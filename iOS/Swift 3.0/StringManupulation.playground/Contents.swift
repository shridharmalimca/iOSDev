//: Playground - noun: a place where people can play

import UIKit

// Reverse String 

var aString = "Hello"

var reverse = ""
for ch in aString.characters {
    print(ch)
    reverse = String(ch) + reverse
}

print("reverse string is \(reverse)")
//OR
var r = "Shri"
print(String(r.characters.reversed()))

// Checking is String is palindrom OR Not

var palimdromString = "nitin"
var chkReverse = ""

for ch in palimdromString.characters {
    chkReverse = String(ch) + chkReverse
}

if palimdromString == chkReverse {
    print("\(palimdromString) is palimdrom string")
} else {
    print("String is not palimdrom")
}


// String replace with * char
var str = "Hi Shridhar mali"
var replacedStr = str.replacingOccurrences(of: "h", with: "*")
print(replacedStr)

var arrOfChar = str.components(separatedBy: " ")
print(arrOfChar)
for (_, value) in arrOfChar.enumerated() {
    print(value)
}

// Range of String
// var s = "This is string with set of char"
var string = "www.stackoverflow.com"
var index = string.range(of: ".", options:.backwards)?.lowerBound
var substring = string.substring(to: index!)
print(substring)

