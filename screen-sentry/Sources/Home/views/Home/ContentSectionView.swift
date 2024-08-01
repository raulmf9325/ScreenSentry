//
//  ContentSectionView.swift
//
//
//  Created by Raul Mena on 7/26/24.
//

import SwiftUI

struct ContentSectionView: View {
    let imageName: String
    let imageColor: Color
    let imageFont: Font
    let title: String
    let description: String
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: imageName)
                    .font(imageFont)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(imageColor)

                Text(title)
                    .foregroundStyle(.white)
                    .font(.headline)

                Spacer()

                Text("+")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }

            Text(description)
                .foregroundStyle(.gray)
                .font(.headline)
        }
        .padding(.vertical)
        .sectionView()
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    ContentSectionView(imageName: "sun.max.fill",
                       imageColor: .orange,
                       imageFont: .headline,
                       title: "Relaxed Morning",
                       description: "Block content every morning until 10 am.",
                       onTap: {})
}
