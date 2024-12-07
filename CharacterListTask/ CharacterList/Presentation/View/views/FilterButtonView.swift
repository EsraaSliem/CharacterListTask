//
//  FilterButtonView.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 06/12/2024.
//
import SwiftUI
import Combine
struct FilterButtonView: View {
    @Binding var selectedStatus: CharacterStatus
    var status: CharacterStatus

    var body: some View {
        Button(action: {
            selectedStatus = status
        }) {
            Text(status.displayerName)
                .font(.system(size: 16))
                .padding(8)
                .background(Color.clear)
                .foregroundColor(Color.black)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.gray, lineWidth: 1) 
                )
        }.padding(.bottom, 16)
    }
}

