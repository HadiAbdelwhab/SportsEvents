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
    
    func testFetchUpcomingEventsFromApi() {
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
    
    func testUpcopmingEventsFromApi(){
        
        let expectation = XCTestExpectation(description: "Fetch Team Details From Api")
        
        let sportsApi = SportsApi()
        
        let currentDate = Date()
        let calendar = Calendar.current
        let fromDate = calendar.date(byAdding: .day, value: 0, to: currentDate)!
        let toDate = calendar.date(byAdding: .day, value: 10, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let parameters: [String: Any] = [
            "met": "Fixtures",
            "leagueId": 5,
            "from": dateFormatter.string(from: fromDate),
            "to": dateFormatter.string(from: toDate),
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)football/"
        print(apiUrl)
        sportsApi.makeCallToApi(url: apiUrl, params: parameters){ (response: EventsResponse?, error:
                                                                    Error?) in
            if let error = error {
                XCTFail()
            } else {
                XCTAssertNotNil(response)
            }
            
        }
        wait(for: [expectation], timeout: 10.0)

    }
    
    
    func testLatestResultsFromApi(){
        
        let expectation = XCTestExpectation(description: "Fetch Team Details From Api")
        
        let sportsApi = SportsApi()
        
        let currentDate = Date()
        let calendar = Calendar.current
        let fromDate = calendar.date(byAdding: .day, value: 0, to: currentDate)!
        let toDate = calendar.date(byAdding: .day, value: 10, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let parameters: [String: Any] = [
            "met": "Fixtures",
            "leagueId": 5,
            "from": dateFormatter.string(from: fromDate),
            "to": dateFormatter.string(from: toDate),
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)football/"
        print(apiUrl)
        sportsApi.makeCallToApi(url: apiUrl, params: parameters){ (response: EventsResponse?, error:
                                                                    Error?) in
            if let error = error {
                XCTFail()
            } else {
                XCTAssertNotNil(response)
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
