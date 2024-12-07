//
//  Untitled.swift
//  CharacterListTask
//
//  Created by Esraa Abdelrazik  on 06/12/2024.
//

import SwiftUI

struct FilterSectionView: View {
    @Binding var selectedStatus: CharacterStatus
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Characters")
                .font(.system(size: 32)) 
                .fontWeight(.bold)
            
            HStack(alignment: .firstTextBaseline) {
                ForEach(CharacterStatus.allCases, id: \.self) { status in
                    FilterButtonView(selectedStatus: $selectedStatus, status: status)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
