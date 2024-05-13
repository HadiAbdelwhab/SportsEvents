//
//  SportsApi.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import Foundation


class SportsApi : ApiService {
    private static let instance = SportsApi()

    static func getApi() -> ApiService {
        return instance
    }
    
    func makeCallToApi<T: Decodable>(url: String, completion: @escaping (T?, Error?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }

            do {
                print("data\(data)")
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
