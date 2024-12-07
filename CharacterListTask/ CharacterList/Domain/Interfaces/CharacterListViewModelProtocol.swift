//
//  CharacterListViewModelProtocol.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import Combine

protocol CharacterListViewModelProtocol: CharacterListViewModelInput,
                                         CharacterListViewModelOutput,
                                         ObservableObject { }

protocol CharacterListViewModelInput {
    func loadCharacters(status: CharacterStatus?)
}

protocol CharacterListViewModelOutput: ObservableObject {
    var characters: [Character] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var selectedStatus: CharacterStatus { get }
    var isEmpty: Bool { get }
}

