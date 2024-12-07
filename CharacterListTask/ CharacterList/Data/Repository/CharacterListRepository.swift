//
//  CharacterListRepository.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import Combine
import Foundation

final class CharacterListRepository: CharacterListRepositProtocol {
    private let characterService: CharacterServiceProtocol

    init(characterService: CharacterServiceProtocol = CharacterService()) {
         self.characterService = characterService
     }

     func fetchCharacters(page: Int, count: Int, status: CharacterStatus) -> AnyPublisher<[Character], NetworkError> {
         return characterService.fetchCharacters(page: page, count: count, status: status)
     }
}
