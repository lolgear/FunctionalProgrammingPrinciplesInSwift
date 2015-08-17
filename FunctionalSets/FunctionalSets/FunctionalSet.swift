//
//  FunctionalSets.swift
//  FunctionalSets
//
//  Created by Lobanov Dmitry on 17.08.15.
//  Copyright (c) 2015 TestExample. All rights reserved.
//

import Foundation

typealias FuncSet = (Int) -> (Bool)

class FunctionalSet : NSObject {
    /**
    * We represent a set by its characteristic function, i.e.
    * its `contains` predicate.
    */
    
    /**
    * Indicates whether a set contains a given element.
    */
    func contains(s: FuncSet, elem: Int) -> Bool {
        return s(elem)
    }
    
    /**
    * Returns the set of the one given element.
    */
    func singletonSet(elem: Int) -> FuncSet {
        return { $0 == elem }
    }
    
    /**
    * Returns the union of the two given sets,
    * the sets of all elements that are in either `s` or `t`.
    */
    func union(s: FuncSet, t: FuncSet) -> FuncSet {
        return { s($0) || t($0) }
    }

    /**
    * Returns the intersection of the two given sets,
    * the set of all elements that are both in `s` and `t`.
    */
    func intersect(s: FuncSet, t: FuncSet) -> FuncSet  {
        return { s($0) && t($0) }
    }
    
    /**
    * Returns the difference of the two given sets,
    * the set of all elements of `s` that are not in `t`.
    */
    func diff(s: FuncSet, t: FuncSet) -> FuncSet {
        return { s($0) && !t($0) }
    }
    
    /**
    * Returns the subset of `s` for which `p` holds.
    */
    func filter(s: FuncSet, p: (Int) -> (Bool)) -> FuncSet{
        return { self.contains(s, elem: $0) && p($0) }
    }

    /**
    * The bounds for `forall` and `exists` are +/- 1000.
    */
    let bound = 1000
    
    /**
    * Returns whether all bounded integers within `s` satisfy `p`.
    */
    
    func forall(s: FuncSet, p: (Int) -> (Bool)) -> Bool {
        var iter: (Int) -> (Bool) = { _ in false }
        iter = {
            a in
            if (abs(a) > self.bound) {
                return true
            }
            else if (self.contains(s,elem: a) && !self.filter(s, p: p)(a)) {
                return false
            }
            else {
                return iter(a + 1)
            }
        }
        return iter((-1)*bound)
//        func iter(a: Int) -> Bool {
//            if (abs(a) > self.bound) {
//                return true
//            }
//            else if (self.contains(s,elem: a) && !self.filter(s, p: p)(a)) {
//                return false
//            }
//            else {
////                return iter(a + 1)
//                return false
//            }
//        }
//        iter((-1)*bound)
    }
    
    /**
    * Returns whether there exists a bounded integer within `s`
    * that satisfies `p`.
    */
    func exists(s: FuncSet, p: (Int) -> (Bool)) -> Bool {
        return !self.forall(s, p: { !p($0) })
    }
    
    /**
    * Returns a set transformed by applying `f` to each element of `s`.
    */
    func map(s: FuncSet, f: (Int) -> (Int)) -> FuncSet {
        return { y in self.exists(s, p: { f($0) == y })}
    }
    
    /**
    * Displays the contents of a set
    */
    func toString(s: FuncSet) -> String {
        
        let array = Array(-self.bound ... self.bound).filter { self.contains(s, elem: $0) }
        let string =
        array.reduce("", combine: { result, item in
            result + ", \(item)"
        })
        return string
    }
    
    /**
    * Prints the contents of a set on the console.
    */
    func printSet(s: FuncSet) {
        println(self.toString(s))
    }
}