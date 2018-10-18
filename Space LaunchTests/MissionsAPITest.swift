//
//  MissionsAPITest.swift
//  Space LaunchTests
//
//  Created by Alcides Junior on 17/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import XCTest
@testable import Space_Launch

class MissionsAPITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetMission(){
        let missions = MissionsAPI.sharedInstance.getMissions { (missions) in
            print(missions,"aqui")
            XCTAssertTrue(missions==nil ? true : false)
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
