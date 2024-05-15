//
//  TestLeaguesMocking.swift
//  SportsEventsTests
//
//  Created by JETSMobileLabMini14 on 15/05/2024.
//

import XCTest

final class TestLeaguesMocking: XCTestCase {

    var mockNetwork: MockNetworkService!
    
    override func setUpWithError() throws {
        mockNetwork = MockNetworkService(shouldReturnError: false)
    }

    func testFetchMockLeagues() {
        mockNetwork.fetchLeagues { (employeeResponse, error) in
            if error != nil {
                XCTFail()
            } else {
                XCTAssertNotNil(employeeResponse)
            }
        }
    }
    
    func testFetchMockTeams() {
        mockNetwork.fetchTeams { (response, error) in
            if error != nil {
                XCTFail()
            } else {
                XCTAssertNotNil(response)
            }
        }
    }
}