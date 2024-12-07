//
//  Untitled.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import Foundation

import Foundation

public struct Character: Codable, Equatable {
    public let id: Int
    public let name: String
    public let species: String
    public let status: String
    public let gender: String
    public let image: String
    public let location: Location

    public init(id: Int, name: String, species: String, status: String, gender: String, image: String, location: Location) {
        self.id = id
        self.name = name
        self.species = species
        self.status = status
        self.gender = gender
        self.image = image
        self.location = location
    }
}





