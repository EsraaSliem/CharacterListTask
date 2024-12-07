//
//  CharacterServiceTests.swift
//  CharacterListTaskTests
//
//  Created by Esraa Abdelrazik on 07/12/2024.
//

import Foundation
import Combine
import XCTest
@testable import CharacterListTask

class CharacterServiceTests: XCTestCase {
    
    var characterService: CharacterService!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockNetworkService = MockNetworkService()
        characterService = CharacterService(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        cancellables = []
        characterService = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchCharacters_Success() {
        let expectedCharacters = [Character(id: 1, name: "Character 1",
                                            species: "species 1", status: "alive",
                                            gender: "", image: "",
                                            location: Location(name: "name 1", url: "")),
                                  Character(id: 2, name: "Character 1",
                                            species: "species 1", status: "alive",
                                            gender: "", image: "",
                                            location: Location(name: "name 1", url: ""))]
        let mockData = try! JSONEncoder().encode(CharacterResponse(results: expectedCharacters, info: PaginationInfo(count: 3, pages: 3, next: nil, prev: nil)))
        mockNetworkService.resultPublisher = Just(mockData)
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
        
        
        let expectation = self.expectation(description: "Fetching characters")
        var receivedCharacters: [Character]?
        var receivedError: NetworkError?
        
        characterService.fetchCharacters(page: 1, count: 20, status: .alive)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error as? NetworkError
                }
                expectation.fulfill()
            }, receiveValue: { characters in
                receivedCharacters = characters
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 1)
        
        // Assert
        XCTAssertNil(receivedError)
        XCTAssertEqual(receivedCharacters, expectedCharacters)
    }
    
    func testFetchCharacters_Failure() {
        mockNetworkService.resultPublisher = Fail(error: URLError(.notConnectedToInternet))
            .eraseToAnyPublisher()
        
        let expectation = self.expectation(description: "Fetching characters")
        var receivedCharacters: [Character]?
        var receivedError: NetworkError?
        
        characterService.fetchCharacters(page: 1, count: 20, status: .alive)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error as? NetworkError
                }
                expectation.fulfill()
            }, receiveValue: { characters in
                receivedCharacters = characters
            })
            .store(in: &cancellables)
        
        
        waitForExpectations(timeout: 1)
        
        // Assert
        XCTAssertNotNil(receivedError)
        XCTAssertEqual(receivedError, .serverError)
        XCTAssertNil(receivedCharacters)
    }
    
}
