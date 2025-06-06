//
//  NetworkManager .swift
//  CountriesAPIUIKit
//
//  Created by Julian Burton on 6/6/25
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case cannotDecode
    case defaultError
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .cannotDecode:
            return "Decoding error"
        case .defaultError:
            return "Other error occurred"
        }
    }
}

class NetworkManager {
    static func downloadDataFromURLString<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(NetworkError.defaultError))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(NetworkError.defaultError))
                return
            }
            if let data {
                do {
                     let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(NetworkError.cannotDecode))
                    return
                }
            }
        }
        task.resume()
    }
}
