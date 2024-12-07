//
//  CharacterServiceProtocol.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import Combine
protocol CharacterServiceProtocol {
    func fetchCharacters(page: Int, count: Int, status: CharacterStatus) -> AnyPublisher<[Character], NetworkError>
   }
