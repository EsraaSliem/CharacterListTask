//
//  FetchCharactersUseCaseProtocol.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import Combine
protocol FetchCharactersUseCaseProtocol {
    func execute(page: Int, count: Int, status: CharacterStatus) -> AnyPublisher<[Character], NetworkError>
}
