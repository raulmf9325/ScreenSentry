//
//  PauseOrDeleteAdultBlockingSessionView.swift
//
//
//  Created by Raul Mena on 8/3/24.
//

import AppUI
import SwiftUI

struct PauseOrDeleteAdultBlockingSessionView: View {
    let onPauseButtonTapped: () -> Void
    let onDelteButtonTapped: () -> Void

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Momentarily pause or permanently delete this session.")
                .font(.title3)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top)

            Spacer()

            VStack(spacing: 15) {
                pauseButton
                deleteButton
            }
        }
        .padding(20)
        .background(AppTheme.Colors.sectionViewColor)
    }

    var pauseButton: some View {
        Button(action: {
            onPauseButtonTapped()
            dismiss()
        },
               label: {
            Text("Pause")
                .font(.headline)
                .foregroundStyle(AppTheme.Colors.sectionViewColor)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(Capsule())
        })
    }

    var deleteButton: some View {
        Button(action: onDelteButtonTapped) {
            Text("Delete")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    PauseOrDeleteAdultBlockingSessionView(onPauseButtonTapped: {},
                                          onDelteButtonTapped: {})
}
