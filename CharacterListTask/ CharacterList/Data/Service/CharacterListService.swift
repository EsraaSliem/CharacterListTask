//
//  CharacterListService.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import Combine

final class CharacterService: CharacterServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCharacters(page: Int, count: Int, status: CharacterStatus) -> AnyPublisher<[Character], NetworkError> {
        guard let url = APIEndpoint.characters(page: page, count: count, status: status.rawValue).url else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        return networkService.request(CharacterResponse.self, url: url)
            .map(\.results)
            .mapError { error in
                error as? NetworkError ?? NetworkError.unknownError
            }
            .eraseToAnyPublisher()
    }
}
