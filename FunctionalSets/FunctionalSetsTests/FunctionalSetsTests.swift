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
        let sss = IntegerFunctionalSet().singletonSet(-1000)
        assert(IntegerFunctionalSet().forall(sss, p: { $0 < 5 } ), "All below 5")
        assert(!IntegerFunctionalSet().forall(ss, p: { $0 < 2 }), "Not all below 2")
        assert(IntegerFunctionalSet().exists(ss, p: { $0 < 2 }), "Any below 2")
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
