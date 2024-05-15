//
//  SportsEventsTests.swift
//  SportsEventsTests
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import XCTest
import Alamofire
@testable import SportsEvents

final class SportsEventsTests: XCTestCase {

    func testFetchLeaguesFromApi() {
        let expectation = XCTestExpectation(description: "Fetch Leagues From Api")
        
        let sportsApi = SportsApi()
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)football/"
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        sportsApi.makeCallToApi(url: apiUrl, params: parameters) { (response: Leagues?, error: Error?) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else {
                XCTAssertNotNil(response, "Response should not be nil")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchTeamDetailsFromApi() {
        let expectation = XCTestExpectation(description: "Fetch Team Details From Api")
        
        let sportsApi = SportsApi()
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)football/"
        let parameters: [String: Any] = [
            "met": "Teams",
            "teamId": 5,
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        sportsApi.makeCallToApi(url: apiUrl, params: parameters) { (response: TeamResponse?, error: Error?) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else {
                XCTAssertNotNil(response, "Response should not be nil")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
