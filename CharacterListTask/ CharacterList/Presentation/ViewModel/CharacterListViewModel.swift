//
//  CharacterListViewModel.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import Combine
import Foundation

class CharacterListViewModel: CharacterListViewModelProtocol {
    
    @Published private(set) var characters: [Character] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published var selectedStatus: CharacterStatus = .none
    @Published var isEmpty: Bool = false
    
    private let fetchCharactersUseCase: FetchCharactersUseCaseProtocol
    private var currentPage: Int = 1
    private var hasMorePages = true
    private var cancellables = Set<AnyCancellable>()

    init(fetchCharactersUseCase: FetchCharactersUseCaseProtocol = FetchCharactersUseCase()) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
        loadCharacters()
        
        $selectedStatus.sink { [weak self] newValue in
            guard let self else { return }
            if newValue != selectedStatus  {
                self.currentPage = 1
                self.hasMorePages = true
                characters = []
                loadCharacters(status: newValue)
            }
        }.store(in: &cancellables)
    }
    


    private func handleEmptyState(newCharacters: [Character]) {
        isEmpty = characters.isEmpty && newCharacters.isEmpty
    }
    

    func loadCharacters(status: CharacterStatus? = nil) {
        guard !isLoading, hasMorePages else { return }

        isLoading = true
        fetchCharactersUseCase.execute(page: currentPage, count: 20, status: status ?? selectedStatus)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] newCharacters in
                guard let self = self else { return }
                self.characters.append(contentsOf: newCharacters)
                self.handleEmptyState(newCharacters: newCharacters)
                self.currentPage += 1
                self.hasMorePages = !newCharacters.isEmpty
            }
            .store(in: &cancellables)
    }

}
