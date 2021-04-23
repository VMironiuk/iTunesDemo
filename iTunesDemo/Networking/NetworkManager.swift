import Foundation
import Alamofire

class NetworkManager {

    // MARK: - Types

    typealias Destination = DownloadRequest.Destination

    // MARK: - Public

    func request<Parameters: Encodable, T: Decodable>(_ urlConvertible: URLConvertible,
                                                      of type: T.Type,
                                                      parameters: Parameters,
                                                      completion: @escaping (DataResponse<T, AFError>) -> Void) {
        AF.request(urlConvertible, parameters: parameters).responseDecodable(of: T.self) { response in
            completion(response)
        }
    }

    func request(_ urlConvertible: URLConvertible,
                 completion: @escaping (AFDataResponse<Data>) -> Void) {
        AF.request(urlConvertible).responseData { response in
            completion(response)
        }
    }

    func download(_ urlConvertible: URLConvertible,
                  to destination: @escaping Destination,
                  completion: @escaping (AFDownloadResponse<URL>) -> Void) {
        AF.download(urlConvertible, to: destination).responseURL { response in
            completion(response)
        }
    }
}
