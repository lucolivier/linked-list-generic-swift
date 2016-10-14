//
//  LinkedListClass.swift
//  LinkedList
//
//  Created by Luc-Olivier on 19/07/14.
//  Copyright (c) 2014 Asity. All rights reserved.
//

import Foundation

//### To Do
//###
//###
//### - liskedlist with key
//###
//###
//###

class LinkedList<T: protocol<Printable, Equatable>> {
    var name: String?
    var list: LinkedListItem<T>?
    var count: Int = 0
    
    //--------------------------------------------------------------------------
    init() {}
    init(name: String) { self.name = name }
    init(values: T...) {
        self.addItemsFromArray(values)
    }
    convenience init(name: String?, values: T...) {
        self.init(array: values)
        if name { self.name = name }
    }
    init(array: [T]) {
        self.addItemsFromArray(array)
    }
    convenience init(name: String?, array: [T]) {
        self.init(array: array)
        if name { self.name = name }
    }
    init(linkedList: LinkedList) {
        self.addItemsFromLinkedList(linkedList)
    }
    convenience init(name: String?, linkedList: LinkedList) {
        self.init(linkedList: linkedList)
        if name { self.name = name }
    }
    
    //--------------------------------------------------------------------------
    subscript (index: Int) -> T? {
        if let result = self.refOfItemAtIndex(index) {
            return result.value
            }
            return nil
    }
    var firstValue: T?                      { return list?.value }
    var lastValue: T?                       { return list?.prev?.value }
    
    var arrayOfAllValues: [T]? {
        if count == 0 { return nil }
        var array = [T]()
        var ref = self.list!
        while true {
            array.append(ref.value)
            if !ref.next { break }
            ref = ref.next!
        }
        return array
    }
    
    var refOfFirstItem: LinkedListItem<T>?  {
        if list {
            unowned var ref = list! ; return ref
        } else { return nil }
    }
    var refOfLastItem: LinkedListItem<T>?   {
        if list?.prev? {
            unowned var ref = list!.prev! ; return ref
        } else { return nil }
    }
    
    var arrayOfAllRefsOfItems: [LinkedListItem<T>]? {
    if count == 0 { return nil }
        var array = [LinkedListItem<T>]()
        unowned var ref = self.list!
        while true {
            array.append(ref)
            if !ref.next { break }
            ref = ref.next!
        }
        return array
    }

    //--------------------------------------------------------------------------
    func refOfItemAtIndex (index: Int, type: LinkedListItemReferenceType = .Unowned ) -> LinkedListItem<T>? {
        if index < 0 || index > self.count-1 || count == 0 { return nil }
        if index < (count-1)/2 {
            var counter = 0
            var ref = self.list!
            while true {
                if counter == index {
                    if type == .Unowned { unowned let uref = ref ; return uref }
                    else { return ref }
                }
                if !ref.next { return nil }
                ref = ref.next!
                counter++
            }
        } else {
            var counter = count-1
            var ref = self.list!.prev
            while true {
                if counter == index {
                    if type == .Unowned { unowned var uref = ref! ; return uref }
                    else { return ref }
                }
                if !ref!.prev { return nil }
                ref = ref!.prev
                counter--
            }
        }
    }

    //--------------------------------------------------------------------------
    func indexOfItemWithValue(value: T, occurence: Int = 1) -> Int? {
        var res = self.indexAndRefOfItemWithValue(value, occurence: occurence)
        return res?.result
    }
    func refOfItemWithValue(value: T, occurence: Int = 1) -> LinkedListItem<T>? {
        var res = self.indexAndRefOfItemWithValue(value, occurence: occurence)
        return res?.ref
    }
    func indexAndRefOfItemWithValue(value: T, occurence: Int = 1) -> LinkedListResult<T>? {
        if !list { return LinkedListResult<T>(result: nil, ref: nil) }
        var counter = 0
        var found = 0
        unowned var ref = self.list!
        while true {
            if ref.value == value {
                found++
                if found == occurence {
                    return LinkedListResult<T>(result: counter, ref: ref)
                }
            }
            if !ref.next { break }
            counter++
            ref=ref.next!
        }
        return LinkedListResult<T>(result: -1, ref: nil)
    }
    func indexAndRefOfItemPassingTest(predicate: (LinkedListItem<T>!, Int)->Bool ) -> LinkedListResult<T>? {
        if !list { return LinkedListResult<T>(result: nil, ref: nil) }
        var counter = 0
        unowned var ref = self.list!
        while true {
            if predicate(ref, counter) {
                return LinkedListResult<T>(result: counter, ref: ref)
            }
            if !ref.next { break }
            counter++
            ref=ref.next!
        }
        return LinkedListResult<T>(result: -1, ref: nil)
    }
    
    func indexesOfItemsWithValue(value: T) -> LinkedList<Int>? {
        if !list { return nil }
        var res = LinkedList<Int>()
        var counter = 0
        unowned var ref = self.list!
        while true {
            if ref.value == value { res.addItem(counter) }
            if !ref.next { break }
            counter++
            ref=ref.next!
        }
        if res.count > 0 { return res }
        return nil
    }
    func refsOfItemsWithValue(value: T) -> LinkedList<LinkedListItem<T>>? {
        if !list { return nil }
        var res = LinkedList<LinkedListItem<T>>()
        var counter = 0
        unowned var ref = self.list!
        while true {
            if ref.value == value { res.addItem(ref) }
            if !ref.next { break }
            counter++
            ref=ref.next!
        }
        if res.count > 0 { return res }
        return nil
    }
    func indexesAndRefsOfItemsWithValue(value: T) -> LinkedList<LinkedListResult<T>>? {
        if !list { return nil }
        var res = LinkedList<LinkedListResult<T>>()
        var counter = 0
        unowned var ref = self.list!
        while true {
            if ref.value == value { res.addItem(LinkedListResult<T>(result: counter, ref: ref)) }
            if !ref.next { break }
            counter++
            ref=ref.next!
        }
        if res.count > 0 { return res }
        return nil
    }
    func indexesAndRefsOfItemPassingTest(predicate: (LinkedListItem<T>!, Int)->Bool ) -> LinkedList<LinkedListResult<T>>? {
        if !list { return nil }
        var res = LinkedList<LinkedListResult<T>>()
        var counter = 0
        unowned var ref = self.list!
        while true {
            if predicate(ref, counter) {
                res.addItem(LinkedListResult<T>(result: counter, ref: ref))
            }
            if !ref.next { break }
            counter++
            ref=ref.next!
        }
        if res.count > 0 { return res }
        return nil
    }
    
    //--------------------------------------------------------------------------
    func sortedLinkedListUsingComparator(comparator: (LinkedListItem<T>!, LinkedListItem<T>!)->Bool) -> LinkedList<T>? {
        if !list { return nil }
        if count == 1 { return LinkedList<T>(values: list!.value) }
        let linkedList = LinkedList<T>(linkedList: self)
        var refI = linkedList.list!
        var refJ = refI.next!
        while true {
            if comparator(refI, refJ) {
                let refI_value = refI.value
                refI.value = refJ.value
                refJ.value = refI_value
            }
            if refJ.next {
                refJ = refJ.next!
            } else {
                if refI.next {
                    refI = refI.next!
                    if refI.next {
                        refJ = refI.next!
                    } else {
                        break
                    }
                } else {
                    break
                }
            }
        }
        return linkedList
    }
    
    //--------------------------------------------------------------------------
    var iteratorState: LinkedListIterator = .Undefined
    var iteratorItem: LinkedListItem<T>?
    func iterator(action: LinkedListIterator) -> LinkedListItem<T>? {
        if !list { return nil }
        switch action {
        case .Rewind, .Unwind :
            iteratorState = action
            iteratorItem = nil
            return nil
        case .Next :
            if iteratorState == .Rewind {
                iteratorItem = list
                iteratorState = .Next
                return iteratorItem
            } else if iteratorState == .Next || iteratorState == .Back {
                if iteratorItem?.next {
                    iteratorItem = iteratorItem?.next
                    return iteratorItem
                }
                return nil
            } else {
                return nil
            }
        case .Back :
            if iteratorState == .Unwind {
                if list?.prev {
                    iteratorItem = list?.prev
                } else {
                    iteratorItem = list
                }
                iteratorState = .Back
                return iteratorItem
            } else if iteratorState == .Back || iteratorState == .Next {
                if iteratorItem !== list && iteratorItem?.prev {
                    iteratorItem = iteratorItem?.prev
                    return iteratorItem
                }
                return nil
            } else {
                return nil
            }
        default : return nil
        }
    }
    
    //--------------------------------------------------------------------------
    func addItem (value: T) {
        if count == 0 {
            self.list = LinkedListItem<T>(value: value, prev: nil, next: nil)
            count = 1
        } else {
            var ref = self.list!
            while true {
                if !ref.next {
                    ref.next = LinkedListItem<T>(value: value, prev: ref, next: nil)
                    self.count++
                    self.list!.prev = ref.next
                    break
                }
                ref = ref.next!
            }
        }
    }
    func addItems (values: T...) {
        for value in values {
            self.addItem(value)
        }
    }
    func addItemsFromArray (array: [T]) {
        for value in array {
            self.addItem(value)
        }
    }
    func addItemsFromLinkedList (linkedList: LinkedList) {
        if linkedList.count > 0 {
            linkedList.iterator(.Rewind)
            while true {
                if let ref = linkedList.iterator(.Next) {
                    self.addItem(ref.value)
                } else {
                    break
                }
            }
        }
    }
    func insertItemAtIndex (atIndex index: Int, value: T) {
        if (count == 0 && index == 0) || (index >= 0 && index < count) {
            if count == 0 {
                self.addItem(value)
            } else if count == 1 {
                var next = list!
                list = LinkedListItem<T>(value: value, prev: next, next: next)
                next.prev = list
                next.next = nil
                count++
            } else {
                var next = self.refOfItemAtIndex(index, type: .Strong)
                var prev = next?.prev
                var newItem = LinkedListItem<T>(value: value, prev: prev, next: next)
                if index == 0 {
                    list = newItem
                    next!.prev = list
                } else {
                    next!.prev = newItem
                    prev!.next = newItem
                }
                count++
            }
        }
    }
    func insertItemsAtIndex (atIndex index: Int, values: T...) {
        self.insertItemsAtIndexFromArray(atIndex: index, array: values)
    }
    func insertItemsAtIndexFromArray (var atIndex index: Int, array: [T]) {
        if (count == 0 && index == 0) || (index >= 0 && index < count) {
            for (var i=array.count-1 ; i >= 0 ; i--) {
                self.insertItemAtIndex(atIndex: index, value: array[i])
            }
        }
    }
    func insertItemsAtIndexFromLinkedList (atIndex index: Int, linkedList: LinkedList) {
        if (count == 0 && index == 0) || (index >= 0 && index < count) {
            if linkedList.count > 0 {
                linkedList.iterator(.Rewind)
                while true {
                    if let ref = linkedList.iterator(.Next) {
                        self.insertItemAtIndex(atIndex: index, value: ref.value)
                    } else {
                        break
                    }
                }
            }
        }
    }
    func removeItemAtIndex (index: Int) {
        var ref = self.refOfItemAtIndex(index, type: .Unowned)
        if ref {
            if index == 0 && count == 1 {
                self.list = nil
                self.count = 0
            } else if index == 0 && count > 1 {
                let next = list!.next
                let prev = list!.prev
                list = next
                list!.prev = prev
                count--
            } else if index == count-1 {
                let prev = ref!.prev
                prev!.next = nil
                list!.prev = prev
                count--
            } else {
                let next = ref!.next
                let prev = ref!.prev
                prev!.next = next
                next!.prev = prev
                count--
            }
        }
    }
    func removeItemsAtIndex (index: Int, amount: Int) {
        if amount > 0 {
            for (var i=1; i<=amount; i++) {
                //println("--\(i)")
                self.removeItemAtIndex(index)
                //self.print()
            }
        }
    }
    func removeItemsFromIndex (index: Int) {
        if count-index > 0 {
            self.removeItemsAtIndex(index, amount: count-index)
        }
    }
    func removeItemsUpToIndex (index: Int) {
        if index<count-1 {
            self.removeItemsAtIndex(0, amount: index+1)
        }
    }
    func removeAllItems () {
        self.count = 0
        list = nil
    }
    
    //--------------------------------------------------------------------------
    func print() {
        println("==============")
        if name {
            println("name:  \(name!)")
        }
        if list {
            println("count: \(count)")
            println("--------------")
            var counter = 0
            var ref = list!
            while true {
                println("\(counter)> \(ref.value.description)")
                if !ref.next { break }
                ref = ref.next!
                counter++
            }
        } else {
            println("count: 0")
        }
        println("--------------\n")
    }

    
}

class LinkedListItem<V: protocol<Printable, Equatable>>: Printable, Equatable {
    var value: V
    var prev: LinkedListItem?
    var next: LinkedListItem?
    init(value: V, prev: LinkedListItem?, next: LinkedListItem?) {
        self.value = value
        self.prev = prev
        self.next = next
    }
    var description : String { return "\(value)" }
}
func == <V>(lhs: LinkedListItem<V>, rhs: LinkedListItem<V>) -> Bool {
    return lhs.value == rhs.value
}

enum LinkedListIterator {
    case Undefined, Rewind, Unwind, Next, Back
}

class LinkedListResult<R: protocol<Printable, Equatable>>: Printable, Equatable {
    let result: Int?
    let ref: LinkedListItem<R>?
    init(result: Int?, ref: LinkedListItem<R>?) {
        self.result = result
        self.ref = ref
    }
    var description: String { return "\(result): \(ref?.value)" }
}
func == <R>(lhs: LinkedListResult<R>, rhs: LinkedListResult<R>) -> Bool {
    return lhs.result == rhs.result && lhs.ref?.value == rhs.ref?.value
}

enum LinkedListItemReferenceType {
    case Strong, Unowned
}

