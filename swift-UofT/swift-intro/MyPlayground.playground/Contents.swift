//: Playground - noun: a place where people can play

import UIKit

// ========== Begin Week 1 ==========
var str = "Hello, playground"

var x = 1
var y = 2
var z = x + y

var mugshot = UIImage(named: "mugshot.JPG")

// ========== Begin Week 2 ==========
// Control Flow
let name = "Johnathan"

if name.characters.count > 10 {
    print("Long Name")
} else if name.characters.count > 5 {
    print("Medium Name")
} else {
    print("short Name")
}

switch name.characters.count {
case 7...10: // inclusive on both ends
    print("Long name")
case 5..<7: // excludes 7
    print("Medium name")
default:
    print("short name")
}

var num = 0
while num < 10 {
    num += 1
}

for n in 0 ..< 10 {
    n
}

for number in [2,1,5,6,8] {
    number
}

// Array and Dictionaries
let animals = ["Cow", "Dog", "Bunny"]

for animal in animals {
    animal
}

var cuteness = ["Cow" : "not", "Dog" : "cute", "Bunny" : "very"]
cuteness["Dog"]
cuteness["Cat"]


for animal in animals {
    cuteness[animal]
}


// Functions
func perform(operation: String, on a:Double, and b: Double) -> Double {
    print("Performing", operation, "on", a, "and", b)
    var result:Double = 0
    switch operation {
        case "+": result = a + b
        case "-": result = a - b
        case "*": result = a * b
        case "/": result = a / b
    default: print("Bad operation:", operation)
    }
    return result
}

let result = perform("*", on: 1.0, and: 2.0)

// 2-D arrays and "Images" (pass by reference)
var image = [
    [8, 3, 5],
    [9, 7, 2],
    [7, 4, 6]
]

func raiseLowerValuesOfImage(inout image:[[Int]]) {
    for row in 0..<image.count {
        for col in 0..<image[row].count {
            if image[row][col] < 5 {
                image[row][col] = 5
            }
        }
    }
}

raiseLowerValuesOfImage(&image)

// ========== Begin Week 3 ==========
// Closures
func performMagig(spell: String) -> String {
    return spell
}

var newMagicFunction = { (spell: String) -> String in
    return spell
}

newMagicFunction("disappear")

// Stored properties
struct Animal {
    var name: String = ""
    var heightInches = 0.0
    var heightCM: Double {
        get {
            return 2.54 * heightInches
        }
        set (newHeightCM) { // Or use newValue -- but it's nice being able to name this!
            heightInches = newHeightCM / 2.54
        }
    }
}

var dog = Animal(name: "dog", heightInches: 50)
dog.heightInches
dog.heightCM

dog.heightCM=254
dog.heightCM
dog.heightInches


// Primatives are value types (copy by value)
// Classes are reference types (copy by reference)
// KEY: ... but structs... are copy by value
class classNumber {
    var n = 0
    init(num: Int) {
        n = num
    }
}

let a = classNumber(num: 3)
let b = a
a.n
b.n
b.n = 5
a.n
b.n

struct structNumber {
    var n = 0
    init(num: Int) {
        n = num
    }
}

// Also note, this must be a var in order to manipulate it because of copy-by-value.
// You can still change the classes when they are constants because you aren't actually changing
// the variable reference (it still points to the same memory). You are just changing what is held
// at that reference.
var c = structNumber(num: 7)
let d = c
c.n
d.n
c.n = 6
c.n
d.n

// Autoclosures -- https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html
// Automatically encloses supplied input as a function that is not evaluated until needed.
// In this case, we don't execute removeAtIndex until we print "now serving..."

var customersInLine = ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
// Must use "escaping" because the supplied variable (that is autoclosed) could be
// called after the collectCustomerProviders function completes. So the autoclosure that
// is created "escapes" the collectCustomerProviders function. If it was consumed inside
// and not stored to an external variable, it would be non-escaping (which is the default).
// This is for memory management purposes.
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.removeAtIndex(0))
collectCustomerProviders(customersInLine.removeAtIndex(0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
print("Still \(customersInLine.count) customers in the customersInLine array")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"



