//
//  CharacterCellView.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 06/12/2024.
//

import SwiftUI

struct CharacterCellView: View {
    let character: Character?
    
    var body: some View {
        HStack(spacing: 16) {
            characterImage
            VStack(alignment: .leading, spacing: 8) {
                Text(character?.name ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(character?.species ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            character?.status == CharacterStatus.alive.rawValue ? Color.blue.opacity(0.2) :
                character?.status == CharacterStatus.dead.rawValue ? Color.red.opacity(0.2) :
                Color.clear
        )
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray.opacity(0.5), 
                    lineWidth: (character?.status != CharacterStatus.alive.rawValue &&
                               character?.status != CharacterStatus.dead.rawValue)
                    ?  1 : 0 ))
        
    }
    
    private var characterImage: some View {
        AsyncImage(url: URL(string: character?.image ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    // Optional border
                )
        } placeholder: {
            ProgressView()
                .frame(width: 80, height: 80)
                .cornerRadius(12)
        }
    }
}
