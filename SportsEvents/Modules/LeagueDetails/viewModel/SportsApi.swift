//
//  SportsApi.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import Foundation
import Alamofire

class SportsApi : ApiService {
    static let api = SportsApi()
    
    func makeCallToApi<T: Decodable>(url: String, params: [String: Any], completion: @escaping (T?, Error?) -> Void) {
        AF.request(url, parameters: params).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodedData):
                completion(decodedData, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
