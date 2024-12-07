//
//  CharacterListTask.swift
//  CharacterListTaskTests
//
//  Created by Esraa Abdelrazik on 07/12/2024.
//

import Combine
import XCTest
@testable import CharacterListTask

// Mock NetworkService
class MockNetworkService: NetworkServiceProtocol {
    var resultPublisher: AnyPublisher<Data, URLError>!
    
    func request<T>(_ type: T.Type, url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        resultPublisher
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
