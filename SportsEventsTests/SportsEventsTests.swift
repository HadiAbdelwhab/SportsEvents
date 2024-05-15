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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchDataFromJson() {
            
            let expectation = XCTestExpectation(description: "Fetch data from JSON")
            
            let apiService = RealAPIService()
            
            apiService.fetchEmployees { (employeeResponse, error) in
            
            XCTAssertNotNil(employeeResponse)

            XCTAssertNil(error)
            
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchLeaguesFromApi() {
        let expectation = XCTestExpectation(description: "Fetch data from JSON")
        
        let sportsApi = SportsApi()
        let apiUrl = "\(ApiURLs.BASE_URL.rawValue)football/"
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": ApiURLs.API_KEY.rawValue
        ]
        
        sportsApi.makeCallToApi(url: <#T##String#>, completion: <#T##(Decodable?, (any Error)?) -> Void#>)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
