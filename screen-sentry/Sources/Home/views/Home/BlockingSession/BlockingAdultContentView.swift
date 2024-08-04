//
//  BlockingAdultContentView.swift
//
//
//  Created by Raul Mena on 8/1/24.
//

import SwiftUI

struct BlockingAdultContentView: View {
    let onPauseButtonTapped: () -> Void
    let onDeleteButtonTapped: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("🔞")
                        .font(.system(size: 30))

                    Text("Blocking Adult Content")
                        .foregroundStyle(.white)
                }

                Text("All the time")
                    .foregroundStyle(.white)
                    .font(.caption)
                    .italic()
                    .padding(.leading, 10)
            }
            Spacer()
            Text("⏳")
        }
        .padding(.vertical, 10)
        .sectionView()
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .swipeActions {
            Button(action: onPauseButtonTapped) {
                Label("Pause", systemImage: "pause.circle.fill")
            }
            .tint(Color.blue)

            Button(action: onDeleteButtonTapped) {
                Label("Delete", systemImage: "trash.circle.fill")
            }
            .tint(Color.red)
        }
    }
}

#Preview {
    BlockingAdultContentView(onPauseButtonTapped: {},
                             onDeleteButtonTapped: {})
}
