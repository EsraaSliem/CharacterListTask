//
//  NetworkError.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik on 04/12/2024.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case serverError
    case decodingError
    case unknownError

    var localizedDescription: String {
        switch self {
        case .badURL:
            return "The URL is malformed."
        case .serverError:
            return "Server returned an error."
        case .decodingError:
            return "Failed to decode the response."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
