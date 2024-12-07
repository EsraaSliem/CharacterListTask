//
//  NetworkServiceProtocol.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik on 04/12/2024.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ type: T.Type, url: URL) -> AnyPublisher<T, Error>
}
