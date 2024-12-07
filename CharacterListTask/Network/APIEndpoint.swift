//
//  APIEndpoint.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik on 04/12/2024.
//

import Foundation

public enum APIEndpoint {
    case characters(page: Int,count: Int, status: String)

    private static let baseURL = "https://rickandmortyapi.com/api"

    public var url: URL? {
        switch self {
        case .characters(let page, let count, let status):
            return URL(string: "\(Self.baseURL)/character?page=\(page)&count=\(count),&status=\(status)")
        }
    }
}


