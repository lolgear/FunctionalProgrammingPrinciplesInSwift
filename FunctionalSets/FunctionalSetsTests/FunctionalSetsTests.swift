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
    
    func dataSets() -> Array<FuncSet> {
        return [
            FunctionalSet().singletonSet(1),
            FunctionalSet().singletonSet(2),
            FunctionalSet().singletonSet(3)
        ]
    }
    
    func testContains() {
        let set = FunctionalSet().singletonSet(1)
        assert(FunctionalSet().contains( { _ in true }, elem: 100), "contains is implemented")
    }
    
    func testSingleton() {
        let set = self.dataSets().first
        assert(FunctionalSet().contains(set!, elem: 1), "singleton contains what it should")
    }
    
    func testUnion() {
        let set = self.dataSets().first!
        let set2 = self.dataSets()[1]
        let union = FunctionalSet().union(set, t: set2)
        assert(FunctionalSet().contains(union, elem: 1), "contains first set")
        assert(FunctionalSet().contains(union, elem: 2), "contains second set")
        assert(!FunctionalSet().contains(union, elem: 3), "does not contain first set")
    }
    
    func testForAll() {
        let set1 = self.dataSets().first!
        let set2 = self.dataSets()[1]
        let set3 = self.dataSets()[2]
        let s = FunctionalSet().union(set1, t: set2)
        let ss = FunctionalSet().union(s, t: set3)
        let sss = FunctionalSet().singletonSet(-1000)
        assert(FunctionalSet().forall(sss, p: { $0 < 5 } ), "All below 5")

        assert(!FunctionalSet().forall(ss, p: { $0 < 2 }), "Not all below 2")
        assert(FunctionalSet().exists(ss, p: { $0 < 2 }), "Any below 2")
    }
    
    func testMap() {
        let set1 = self.dataSets().first!
        let set2 = self.dataSets()[1]
        let s = FunctionalSet().union(set1, t: set2)
        let newS = FunctionalSet().map(s, f: { $0 * 10 })
        assert(FunctionalSet().contains(newS, elem: 10), "Union 1")
        assert(FunctionalSet().contains(newS, elem: 20), "Union 2")
        assert(!FunctionalSet().contains(newS, elem: 1), "Union 1")
        assert(!FunctionalSet().contains(newS, elem: 2), "Union 2")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
