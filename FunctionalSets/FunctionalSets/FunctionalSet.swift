//
//  FunctionalSets.swift
//  FunctionalSets
//
//  Created by Lobanov Dmitry on 17.08.15.
//  Copyright (c) 2015 TestExample. All rights reserved.
//

import Foundation

class FunctionalSet<T> : NSObject {
    internal typealias FuncSet = (T) -> (Bool)
    typealias FuncSetIndication = (T) -> (Bool)
    typealias FuncSetTransform = (T) -> (T)
    /**
    * We represent a set by its characteristic function, i.e.
    * its `contains` predicate.
    */
    
    /**
    * Indicates whether a set contains a given element.
    */
    func contains(_ s: FuncSet, elem: T) -> Bool {
        return s(elem)
    }
    
    /**
    * Returns the set of the one given element.
    */
    func singletonSet(_ elem: T) -> FuncSet {
        return { _ in false }
    }
    
    /**
    * Returns the union of the two given sets,
    * the sets of all elements that are in either `s` or `t`.
    */
    func union(_ s: @escaping FuncSet, t: @escaping FuncSet) -> FuncSet {
        return { e in s(e) || t(e) }
    }

    /**
    * Returns the intersection of the two given sets,
    * the set of all elements that are both in `s` and `t`.
    */
    func intersect(_ s: @escaping FuncSet, t: @escaping FuncSet) -> FuncSet  {
        return { e in s(e) && t(e) }
    }
    
    /**
    * Returns the difference of the two given sets,
    * the set of all elements of `s` that are not in `t`.
    */
    func diff(_ s: @escaping FuncSet, t: @escaping FuncSet) -> FuncSet {
        return { e in s(e) && !t(e) }
    }
    
    /**
    * Returns the subset of `s` for which `p` holds.
    */
    func filter(_ s: @escaping FuncSet, p: @escaping FuncSetIndication) -> FuncSet {
        return { e in self.contains(s, elem: e) && p(e) }
    }
    
    /**
     * Returns whether all bounded integers within `s` satisfy `p`.
     */
    func forall(_ s: @escaping FuncSet, p: @escaping FuncSetIndication) -> Bool {
        let min = -10
        let max = 10
        let ar = [Int](min...max).map{e in s(e as! T)}.map{e in "\(e)"}
        print("super s has elements: s: \(ar)")
        return false
    }
}

class EquatableFunctionalSet<T: Equatable> : FunctionalSet<T> {
    override func singletonSet(_ elem: T) -> FuncSet {
        return { e in e == elem }
    }
    
    func printSet(_ s: FuncSet) {}
}

class IntegerFunctionalSet : EquatableFunctionalSet<Int> {
    typealias T = Int
    /**
    * The bounds for `forall` and `exists` are +/- 1000.
    */
    
    let bound = 6
    
    /**
    * Returns whether all bounded integers within `s` satisfy `p`.
    */
    
    override func forall(_ s: @escaping FuncSet, p: @escaping FuncSetIndication) -> Bool {
//        super.forall(s, p: p)
        print("s has elements: \(self.toString(s))")
//        var iter: (Int) -> (Bool) = { _ in false }
//        iter = {
//            a in
//            if (abs(a) > self.bound) {
//                return true
//            }
//            else if (self.contains(s,elem: a) && !self.filter(s, p: p)(a)) {
//                return false
//            }
//            else {
//                return iter(a + 1)
//            }
//        }
//        return iter((-1)*bound)
        func iter(_ a: T) -> Bool {
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
    }
    
    /**
    * Returns whether there exists a bounded integer within `s`
    * that satisfies `p`.
    */
    func exists(_ s: @escaping FuncSet, p: @escaping FuncSetIndication) -> Bool {
        return !self.forall(s, p: { t in !p(t)})
    }
    
    /**
    * Returns a set transformed by applying `f` to each element of `s`.
    */
    func map(_ s: @escaping FuncSet, f: @escaping FuncSetTransform) -> FuncSet {
        return { y in self.exists(s, p: { f($0) == y })}
    }
    
    /**
    * Displays the contents of a set
    */
    func toString(_ s: FuncSet) -> String {
        let array = Array(-self.bound ... self.bound).filter { self.contains(s, elem: $0) }
        let string = array.map { (g) in return "\(g)" }.joined(separator: ", ")
        return "set: \(string)"
    }
    
    /**
    * Prints the contents of a set on the console.
    */
    override
    func printSet(_ s: FuncSet) {
        print(self.toString(s))
    }
}

class A {
    typealias Q = (Int) -> (Bool)
    func condition(_ t: Int) -> Q {
        return { e in e < t }
    }
    
    func addCondition(_ q: @escaping Q, p: @escaping Q) -> Q {
        return { e in p(e) && q(e) }
    }
    
    func addCondition(_ p: @escaping Q) -> Q {
        return { e in p(e) }
    }
    
    func testMe(_ me: Q) -> Bool {
        return [Int](1...10).filter(me).count > 0
    }
}

class B:A {
    override func testMe(_ me: Q) -> Bool {
        print("me is: \(me(-5))")
        return [Int](1...10).filter(me).count > 0
    }
}
