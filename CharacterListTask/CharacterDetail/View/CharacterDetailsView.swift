//
//  CharacterDetailsView.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 07/12/2024.
//

import Foundation
import SwiftUI

struct CharacterDetailsView: View {
    let character: Character 
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            // Header with Image and back button
            ZStack(alignment: .topLeading) {
                characterImage
                backButton
            }.padding(.top, 8)
            
            // Character Info
            VStack(alignment: .leading, spacing: 8) {
                nameView
                statusView
                locationView
                
            }.padding()
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
    }
    
    private var characterImage: some View {
        AsyncImage(url: URL(string: character.image)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.3) // Placeholder color
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height * 0.4 )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding()
                .background(Circle().fill(Color.white))
                .padding(.top, 70)
                .padding(.leading, 16)
        }
    }
    private var nameView: some View {
        HStack {
            Text(character.name)
                .font(.title)
                .bold()
                .foregroundColor(.primary)
            Spacer()
            Text(character.status)
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(statusColor(character.status))
                .clipShape(Capsule())
                .foregroundColor(.white)
        }
    }
    
    private var statusView: some View {
        Text("\(character.species) • \(character.gender)")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    
    private var locationView: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text("Location:")
                .font(.headline)
                .foregroundColor(.primary)
            Text(character.location.name)
                .font(.body)
                .foregroundColor(.secondary)
        }.padding(.top, 8)
    }
    
    private func statusColor(_ status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return .blue
        case "dead":
            return .red
        default:
            return .gray
        }
    }
}



