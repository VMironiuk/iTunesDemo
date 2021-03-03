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
    
    func request<T: Decodable>(_ ulrConvertible: URLConvertible,
                               of type: T.Type,
                               completion: @escaping (DataResponse<T, AFError>) -> Void) {
        AF.request(ulrConvertible).responseDecodable(of: T.self) { response in
            completion(response)
        }
    }
}
