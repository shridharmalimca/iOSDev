//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop(item: T) {
        items.removeLast()
    }
}

var tos = stack<String>()
tos.push(item: "Shri")
print(tos.items)
tos.push(item: "krish")
print(tos.items)
tos.push(item: "Pranav")
print(tos.items)

tos.pop(item: "Shri")
print(tos.items)

var intObj = stack<Int>()
intObj.push(item: 10)
print(intObj.items)

class A {
    var a: Int = 0
    var b: String = ""
    init(a: Int, b: String) {
        self.a = a
        self.b = b
    }
    
    convenience init(a: Int) {
        self.init(a:a, b:"Shri")
    }
    convenience init() {
        self.init(a:10)
    }
}
var objA = A()
var objB = A(a: 10)
var objC = A(a: 20, b: "Anni")

print(objA.a)
print(objA.b)

print(objB.a)
print(objB.b)

print(objC.a)
print(objC.b)
