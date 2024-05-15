//
//  ApiService.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import Foundation


protocol ApiService {
    static func getApi() -> ApiService
    func makeCallToApi<T: Decodable>(url: String, params: [String: Any], completion: @escaping (T?, Error?) -> Void)
}
