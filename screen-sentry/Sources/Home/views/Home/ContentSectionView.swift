//
//  ContentSectionView.swift
//
//
//  Created by Raul Mena on 7/26/24.
//

import SwiftUI

struct ContentSectionView: View {
    let emoji: String
    let imageColor: Color
    let imageFont: Font
    let title: String
    let description: String
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Text(emoji)
                    .font(.title)

                Text(title)
                    .foregroundStyle(.white)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.gray)
            }

            Text(description)
                .foregroundStyle(.gray)
                .font(.callout)
        }
        .padding(.vertical, 10)
        .sectionView()
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    ContentSectionView(emoji: "🌞",
                       imageColor: .orange,
                       imageFont: .headline,
                       title: "Relaxed Morning",
                       description: "Block content every morning until 10 am.",
                       onTap: {})
}
