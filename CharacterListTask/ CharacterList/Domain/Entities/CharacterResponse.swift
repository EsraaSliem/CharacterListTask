//
//  CharacterResponse.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 07/12/2024.
//

import Foundation
struct CharacterResponse: Codable {
    let results: [Character]
    let info: PaginationInfo
}
