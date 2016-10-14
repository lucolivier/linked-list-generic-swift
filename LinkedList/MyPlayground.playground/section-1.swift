// Playground - noun: a place where people can play

import Cocoa

let a = 1


//protocol Linkedable {
//    var description: String { get }
//}
//
//extension Int: Linkedable {
//    var description: String {
//        return "\(self)"
//    }
//}



let b = a.description


let af = 1.0
let afp = af.description


extension String: Printable {
    var description: String {
        return self
    }
}


let s = "1"
let sp = s.description

