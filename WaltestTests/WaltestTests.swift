//
//  WaltestTests.swift
//  WaltestTests
//
//  Created by BjornC on 4/5/17.
//  Copyright © 2017 bjorn. All rights reserved.
//

import XCTest
@testable import Waltest

class WaltestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProdDownloading() {
        let pd = ProdDownloader()
        let netExpect = expectation(description: "netRequest")
        
        pd.downloadNextPage() { err,prods in
            print(prods)
            print("UNIT TEST")
            netExpect.fulfill()
 
        }
        waitForExpectations(timeout: 15) { (err) in
            print("timeout")
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
