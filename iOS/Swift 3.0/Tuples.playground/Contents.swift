//: Playground - noun: a place where people can play

import UIKit

let person = ("Shridhar", "Mali")

let firstName = person.0
let lastName = person.1

print("First Name : \(firstName) \nLast Name : \(lastName)")

// Parametrised tuple

let personTuple = (firstName: "Shri", lastName: "Mali")
print(personTuple.firstName)
print(personTuple.lastName)