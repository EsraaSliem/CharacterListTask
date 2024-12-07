//
//  FetchCharactersUseCase.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import Combine

public final class FetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    private let repository: CharacterListRepositProtocol
    
     init(repository: CharacterListRepositProtocol = CharacterListRepository()) {
        self.repository = repository
    }
    
    func execute(page: Int, count: Int, status: CharacterStatus) -> AnyPublisher<[Character], NetworkError> {
        return repository.fetchCharacters(page: page, count: count, status: status)
    }
}
