//
//  CharacterStatus.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 06/12/2024.
//

import Foundation
enum CharacterStatus: String, CaseIterable {
    case none = ""
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
    var displayerName: String {
        switch self {
        case .none:
            "All"
        default:
            self.rawValue
        }
    }
}
