//
//  main.swift
//  LinkedList
//
//  Created by Luc-Olivier on 19/07/14.
//  Copyright (c) 2014 Asity. All rights reserved.
//

import Foundation

// Create List with Doubles
// > LinkedList<T>()   &   .addItem(value: T)
//
var llDouble = LinkedList<Double>()
llDouble.name = "LLDouble"
llDouble.addItem(1.0)
llDouble.addItem(2.0)
llDouble.addItem(3.0)
llDouble.print()
for i in 0..<llDouble.count { println(llDouble[i]!) }
println("---\n")


// Create List with Ints
// > LinkedList<T>(values: T...)   &   .addItem(values: T...)
//
var llInt = LinkedList<Int>(values: 1,2,3)
llInt.name = "LLInt"
llInt.addItems(4,5,6)
llInt.print()
for i in 0..<llInt.count { println(llInt[i]!) }
println("---\n")


// Create List with String
// > LinkedList<T>(name: "String", array: [T])   &   .addItemsFromArray(array: [T])
// String must conforms to Printable protocol
//
extension String: Printable {
    public var description: String { return self }
}
var llString = LinkedList<String>(name: "LLString", array: ["A","B","C"])
llString.addItemsFromArray(["d","e","f","b"])
llString.addItems("Z","B","O","PAPA","B")
llString.print()
for i in 0..<llString.count { println(llString[i]!) }
println("---\n")


// Create List with struct Points
//
struct Point: Printable, Equatable {
    var x = 0, y = 0
    var description: String { return "\(self.x),\(self.y)" }
}
func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
var llPoint = LinkedList<Point>(name: "LLPoint",array: [
    Point(x: 1, y: 1),
    Point(x: 2, y: 2),
    Point(x: 3, y: 3),
    Point(x: 2, y: 2)
    ])
llPoint.print()
for i in 0..<llPoint.count { println(llPoint[i]!) }
println("---\n")

// Iterate with iterator from Front
// .iterator(.Rewind|.Next)
//
llPoint.iterator(.Rewind)
while true {
    let ref = llPoint.iterator(.Next)
    if !ref { break }
    println(ref!.value.description)
}
println("---\n")

// Iterate with iterator from Backward
// .iterator(.Unwind|.Back)
//
llString.iterator(.Unwind)
while true {
    let ref = llString.iterator(.Back)
    if !ref { break }
    println(ref!.value.description)
}
println("---\n")



// Create List with LinkedList
// LinkedList<T>(name: "String",linkedList: LinkedList<T>)
//
class Person: Printable, Equatable {
    var firstname: String?
    var lastname: String?
    var sexe: Sexe?
    enum Sexe: String {
        case Undefined = "Undefined"
        case Male = "Male"
        case Female = "Female"
        var label: String { return self.toRaw() }
    }
    init(sexe: Sexe?, firstname: String?, lastname: String?) {
        self.sexe = sexe
        self.firstname = firstname
        self.lastname = lastname
    }
    var description: String {
    return "\(sexe?.label) \(firstname) \(lastname)"
    }
}
func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.description == rhs.description
}
var sylvie = Person(sexe: Person.Sexe.Female, firstname: "Sylvie", lastname: "Gouedlaf")
var marion = Person(sexe: Person.Sexe.Female, firstname: "Marion", lastname: "Gouedlaf")
var bétina = Person(sexe: Person.Sexe.Female, firstname: "Bétina", lastname: "Gouedlaf")
var llPersonsFemale = LinkedList<Person>(name: "LLPersonsFemales", values: sylvie, marion, bétina)
var llPersons = LinkedList<Person>(name: "LLPersons",linkedList: llPersonsFemale)
var lucol = Person(sexe: Person.Sexe.Male, firstname: "LucOl", lastname: "Gouedlaf")
var nours = Person(sexe: Person.Sexe.Male, firstname: "Nours", lastname: nil)
var llPersonsMale = LinkedList<Person>(values: lucol, nours)
llPersons.addItemsFromLinkedList(llPersonsMale)
llPersons.print()



// Get value by subscript index
// [n]?
println(llPersons[0]?.description)
println(llPersonsFemale[2]?.description)


// Get last or first value
// .lastValue?   ||    .firstValue?
println(llPersonsMale.lastValue?.description)
println(llPersonsMale.firstValue?.description)


// Get ref of Item by index
// .refOfItemAtIndex(n)?
println(llPersonsMale.refOfItemAtIndex(1)?.value.description)


// Get reOfToFirstItem?  ||   .refOfLastItem?
println(llPersonsFemale.refOfFirstItem?.value.description)
println(llPersonsFemale.refOfLastItem?.value.description)

println("------\n")



// Get array of values
// .allValues?
for value in llString.arrayOfAllValues! {
    println(value.description)
}
println("------\n")


// Get array of refsOfItems
// .allRefsOfItems?
for refs in llString.arrayOfAllRefsOfItems! {
    println(refs.value.description)
}
println("------\n")



// Get index and ref of item with value
// .indexAndRefOfItemWithValue(value: T, occurence: Int = 1)
//
let llPRes = llPersons.indexAndRefOfItemWithValue(
    Person(sexe: Person.Sexe.Female, firstname: "Marion", lastname: "Gouedlaf")
)
println("\(llPRes!.result), \(llPRes!.ref?.value.description)")

let llPointRes = llPoint.indexAndRefOfItemWithValue(
    Point(x: 2, y: 2),
    occurence: 2)
println("\(llPointRes!.result) > \(llPointRes!.ref?.value.description)")



// Get indexes and refs of items with value (all occurences)
// .indexesAndRefsOfItemsWithValue(value: T)
//
let llStringRes = llString.indexesAndRefsOfItemsWithValue("B")
llStringRes?.print()



// Get ref of item with value
// .refOfItemWithValue(value: T, occurence: Int = 1)
//
let llStringB = llString.refOfItemWithValue("B")
println(llStringB?.value.description)



// Get index of item with value
// .indexOfItemWithValue(value: T, occurence: Int = 1)
//
let llStringBIdx = llString.indexOfItemWithValue("B")
println(llStringBIdx)



// Get indexes of items with value
// .indexesOfItemsWithValue(value: T)
//
let llStringResInt = llString.indexesOfItemsWithValue("B")
llStringResInt?.print()



// Get refs of items with value
// .refsOfItemsWithValue(value: T)
//
let llStringResRef = llString.refsOfItemsWithValue("B")
llStringResRef?.print()



// Get index and ref by closure
// .indexAndRefOfItemPassingTest(predicate: (LinkedListItem<T>!, Int)->Bool )
//
var llStringResClosure = llString.indexAndRefOfItemPassingTest({
    (ref: LinkedListItem<String>!, index: Int) -> Bool in
    if ref.value == "B" || ref.value == "b" { return true }
    return false
    })
println(llStringResClosure!.description)

var counter = 0
llStringResClosure = llString.indexAndRefOfItemPassingTest({
    (ref: LinkedListItem<String>!, index: Int) -> Bool in
    if ref.value == "B" || ref.value == "b" {
        if (++counter == 2) { return true }
    }
    return false
    })
println(llStringResClosure!.description)



// Get indexes and refs by closure
// .indexesAndRefsOfItemPassingTest(predicate: (LinkedListItem<T>!, Int)->Bool )
//
var llStringRessClosure = llString.indexesAndRefsOfItemPassingTest() {
    (ref: LinkedListItem<String>!, index: Int) -> Bool in
    if  ref.value.uppercaseString == "B" { return true }
    return false
}
llStringRessClosure!.print()



// Insert item at index
// .insertItemAtIndex (value: T, atIndex index: Int)
//
var lklString = LinkedList<String>()
println(lklString.count)
lklString.insertItemAtIndex(atIndex: 0, value: "Bébé")
lklString.insertItemAtIndex(atIndex: 0, value: "Maman")
lklString.insertItemAtIndex(atIndex: 1, value: "Papa")
lklString.insertItemAtIndex(atIndex: 0, value: "Fils")
lklString.print()
println(lklString.list?.prev?.value)
println(">\(lklString[4])")
println("------\n")



// Insert items at index
// .insertItemsAtIndex (atIndex index: Int, values: T...)
//
var lklString2 = LinkedList<String>()
println(">\(lklString2[1])")
lklString2.insertItemsAtIndex(atIndex: 0, values: "Zero","One","Two")
lklString2.print()
lklString2.addItems("'3'","'4'","'5'")
lklString2.print()

lklString2.iterator(.Unwind)
while true {
    if let ref = lklString2.iterator(.Back) {
        println(ref.value.description)
    } else { break }
}
println("---\n")



// Insert items at index from array
// .insertItemsAtIndexFromArray (atIndex index: Int, array: [T])
//
lklString2.insertItemsAtIndexFromArray(atIndex: 3, array: ["Ah","Bee","Ceh"])
lklString2.insertItemsAtIndexFromArray(atIndex: 3, array: ["---","---"])
lklString2.print()

lklString2.iterator(.Rewind)
while true {
    if let ref = lklString2.iterator(.Next) {
        println(ref.value.description)
    } else { break }
}
println("---\n")



// Insert items at index from array
// .insertItemsAtIndexFromLinkedList (atIndex index: Int, linkedList: LinkedList)
//
lklString2.insertItemsAtIndexFromLinkedList(atIndex: 4, linkedList: llString)
lklString2.print()



// Remove item at index
// .removeItemAtIndex (index: Int)
//
let llInts2 = LinkedList<Int>(name: "LLInt2", values: 0,1,2,3,4,5,6,7,8,9)
llInts2.print()
llInts2.removeItemAtIndex(2)
llInts2.removeItemAtIndex(2)
llInts2.print()



// Remove items at index
// .removeItemsAtIndex (index: Int, amount: Int)
//
llInts2.removeItemsAtIndex(2, amount: 3)
llInts2.print()



// Remove items from index
// .removeItemsFromIndex (index: Int)
//
extension Character: Printable {
    public var description: String { return "\(self)" }
}
let llCharacters = LinkedList<Character>(name:"Chars", values: "A","B","C","D","E","F","G","H","I")
llCharacters.print()
llCharacters.removeItemsFromIndex(4)
llCharacters.print()



// Remove items up to index
// .removeItemsUpToIndex (index: Int)
//
let llCharacters2 = LinkedList<Character>(name:"Chars", values: "A","B","C","D","E","F","G","H","I")
llCharacters2.removeItemsUpToIndex(4)
llCharacters2.print()



// Remove all items
// .removeAllItems
//
llCharacters2.removeAllItems()
llCharacters2.print()



// Get a sorted list using comparator
// sortedLinkedListUsingComparator(comparator: (LinkedListItem<T>!, LinkedListItem<T>!)->Bool)
//
let llNames = LinkedList<String>(name: "Names", array: [
    "Sylvie", "Marion", "Bétina", "Julie", "Clémentine", "Nours", "Monia", "Mini", "Pistache",
    "LucOl"
    ])
llNames.print()

let llSortedNames = llNames.sortedLinkedListUsingComparator({
    (item1: LinkedListItem<String>!, item2: LinkedListItem<String>!) -> Bool in
    return item1.value > item2.value
    })
llSortedNames?.print()



llPoint.addItems(
    Point(x: -1, y: -2), Point(x: -5, y: 2)
)
llPoint.print()
let llSortedXPoints = llPoint.sortedLinkedListUsingComparator({
    item1, item2 in item1.value.x > item2.value.x               // shorted syntax
    })
llSortedXPoints?.print()
let llSortedYPoints = llPoint.sortedLinkedListUsingComparator({
    $0.value.y > $1.value.y                                     // Shorthand arg names
    })
llSortedYPoints?.print()



