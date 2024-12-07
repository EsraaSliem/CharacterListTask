//
//  CharacterListViewController.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import UIKit
import SwiftUI
import Combine

class CharacterTableViewController: UITableViewController {
    @ObservedObject private var viewModel: CharacterListViewModel
    private var cancellables = Set<AnyCancellable>()
    private var hostingController: UIHostingController<FilterSectionView>?
    
    init(viewModel: CharacterListViewModel = .init()) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        hostingController = UIHostingController(rootView: FilterSectionView(selectedStatus: $viewModel.selectedStatus))
    }
    
    private func setupTableView() {
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func createEmptyStateView() -> UIView {
        let label = UILabel()
        label.text = "No characters found."
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }
    
    private func setupBindings() {
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.updateLoadingIndicator(isLoading)
            }
            .store(in: &cancellables)
        
        viewModel.$isEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEmpty in
                self?.tableView.backgroundView = isEmpty ? self?.createEmptyStateView() : nil
            }
            .store(in: &cancellables)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func updateLoadingIndicator(_ isLoading: Bool) {
        if isLoading {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            tableView.tableFooterView = spinner
        } else {
            tableView.tableFooterView = nil
        }
    }
}

// MARK: - TableView DataSource & Delegate
extension CharacterTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.characters.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == viewModel.characters.count - 1 {
            viewModel.loadCharacters()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Filter section
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") ?? UITableViewCell(style: .default, reuseIdentifier: "FilterCell")
            if hostingController?.view.superview == nil {
                hostingController = UIHostingController(rootView: FilterSectionView(selectedStatus: $viewModel.selectedStatus))
                hostingController?.view.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(hostingController!.view)
                NSLayoutConstraint.activate([
                    hostingController!.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                    hostingController!.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                    hostingController!.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                    hostingController!.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
                ])
            }
            return cell
        } else {
            // Character list
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
                fatalError("Unable to dequeue CharacterTableViewCell")
            }
            cell.configure(with: viewModel.characters[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 120 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedCharacter = viewModel.characters[indexPath.row]
         let detailsView = CharacterDetailsView(character: selectedCharacter)
         let hostingController = UIHostingController(rootView: detailsView)

         navigationController?.pushViewController(hostingController, animated: true)
        
        
     }
}
