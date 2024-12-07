//
//  PaginationInfo.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 07/12/2024.
//

import Foundation
struct PaginationInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
