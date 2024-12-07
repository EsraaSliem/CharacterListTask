//
//  NetworkService.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik on 04/12/2024.
//

import Combine
import Foundation

final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(_ type: T.Type, url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> Error in
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet, .networkConnectionLost:
                        return NetworkError.serverError
                    default:
                        return NetworkError.unknownError
                    }
                } else if error is DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknownError
                }
            }
            .eraseToAnyPublisher()
    }
}
