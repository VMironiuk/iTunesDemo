//
//  NetworkManager.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 03.03.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    // MARK: - Public
    
    func request<Parameters: Encodable, T: Decodable>(_ urlConvertible: URLConvertible,
                                                      of type: T.Type,
                                                      parameters: Parameters,
                                                      completion: @escaping (DataResponse<T, AFError>) -> Void) {
        AF.request(urlConvertible, parameters: parameters).responseDecodable(of: T.self) { response in
            completion(response)
        }
    }
}
