//
//  FunctionalSetsTests.swift
//  FunctionalSetsTests
//
//  Created by Lobanov Dmitry on 17.08.15.
//  Copyright (c) 2015 TestExample. All rights reserved.
//

import UIKit
import XCTest
import FunctionalSets

class FunctionalSetsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func dataSets() -> [IntegerFunctionalSet.FuncSet] {
        return [
            IntegerFunctionalSet().singletonSet(1),
            IntegerFunctionalSet().singletonSet(2),
            IntegerFunctionalSet().singletonSet(3)
        ]
    }
    
    func testContains() {
        assert(IntegerFunctionalSet().contains( { _ in true }, elem: 100), "contains is implemented")
    }
    
    func d() {
        
    }
    
    func s(_ g:() = ()) {
        
    }
    
    func c(_ g:Any = ()) {
        let a:Int = 10, b:Int = 20, c : Int = 30
        print(a, b, c)
    }
    
    func testContainsAgain() {
        let a: Void = ()
        let b: (((Void))) = ()
        self.s(b)
        self.d(b)
        self.s(a)
        self.d(a)
        
        _ = IntegerFunctionalSet(b).bound
        let set1 = self.dataSets().first!
        let set2 = self.dataSets()[1]
        let set3 = self.dataSets()[2]
        let s = IntegerFunctionalSet().union(set1, t: set2)
        let ss = IntegerFunctionalSet().union(s, t: set3)
        IntegerFunctionalSet().printSet(ss)
        assert(IntegerFunctionalSet().contains(ss, elem: 1))
    }
    
    func testSingleton() {
        let set = self.dataSets().first
        assert(IntegerFunctionalSet().contains(set!, elem: 1), "singleton contains what it should")
    }
    
    func testUnion() {
        let set = self.dataSets().first!
        let set2 = self.dataSets()[1]
        let union = IntegerFunctionalSet().union(set, t: set2)
        assert(IntegerFunctionalSet().contains(union, elem: 1), "contains first set")
        assert(IntegerFunctionalSet().contains(union, elem: 2), "contains second set")
        assert(!IntegerFunctionalSet().contains(union, elem: 3), "does not contain first set")
    }
    
    func testForAll() {
        let set1 = self.dataSets().first!
        let set2 = self.dataSets()[1]
        let set3 = self.dataSets()[2]
        let s = IntegerFunctionalSet().union(set1, t: set2)
        let ss = IntegerFunctionalSet().union(s, t: set3)
        let sss = IntegerFunctionalSet().singletonSet(-IntegerFunctionalSet().bound)
        assert(IntegerFunctionalSet().forall(sss, p: { e in e < 5 } ), "All below 5")
        assert(IntegerFunctionalSet().exists(ss, p: { e in e < 2 }), "Any below 2")
    }
    
    func testNotForAll() {
        let set1 = self.dataSets().first!
        let set2 = self.dataSets()[1]
        let set3 = self.dataSets()[2]
        let s = IntegerFunctionalSet().union(set1, t: set2)
        let ss = IntegerFunctionalSet().union(s, t: set3)
        assert(!IntegerFunctionalSet().forall(ss, p: { e in e < 2 }), "Not all below 2")
    }
    
    func testAny() {
        
        let q = B().condition(10)
        let b = B().addCondition({ $0 < -4 }, p: q)
        let s = B().addCondition(b, p: { $0 < -1 })
        assert(!B().testMe(s))
    }
    
    func testMap() {
        let set1 = self.dataSets().first!
        let set2 = self.dataSets()[1]
        let s = IntegerFunctionalSet().union(set1, t: set2)
        let newS = IntegerFunctionalSet().map(s, f: { $0 * 10 })
        assert(IntegerFunctionalSet().contains(newS, elem: 10), "Union 1")
        assert(IntegerFunctionalSet().contains(newS, elem: 20), "Union 2")
        assert(!IntegerFunctionalSet().contains(newS, elem: 1), "Union 1")
        assert(!IntegerFunctionalSet().contains(newS, elem: 2), "Union 2")
    }
}
