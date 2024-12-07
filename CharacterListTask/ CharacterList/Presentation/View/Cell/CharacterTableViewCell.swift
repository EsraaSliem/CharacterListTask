//
//  CharacterTableViewCell.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 05/12/2024.
//

import UIKit
import SwiftUI

class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterTableViewCell"

    private let hostingController: UIHostingController<CharacterCellView>

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        hostingController = UIHostingController(rootView: CharacterCellView(character: nil))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHostingController()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 8, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with character: Character) {
        hostingController.rootView = CharacterCellView(character: character)
    }

    private func setupHostingController() {
        guard let hostingView = hostingController.view else { return }
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hostingView)
        
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }
}



