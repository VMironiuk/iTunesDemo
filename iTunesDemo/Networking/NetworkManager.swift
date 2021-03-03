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
    
    func request(_ ulrConvertible: URLConvertible,
                 completion: @escaping (DataResponse<ItunesResponse, AFError>) -> Void) {
        AF.request(ulrConvertible).responseDecodable(of: ItunesResponse.self) { response in
            completion(response)
        }
    }
}
