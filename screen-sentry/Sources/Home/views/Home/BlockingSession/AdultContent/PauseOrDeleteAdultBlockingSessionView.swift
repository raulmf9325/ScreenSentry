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

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("Momentarily pause or permanently delete this session.")
                .font(.title3)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top)

            Text("Pausing the session will unblock adult content temporarily. Deleting the session will unblock it permanently.")
                .font(.callout)
                .foregroundStyle(Color.gray)
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
        Button("Pause") {
            onPauseButtonTapped()
            dismiss()
        }
        .buttonStyle(CapsuleButtonStyle())
    }

    var deleteButton: some View {
        Button("Delete") {
            onDelteButtonTapped()
            dismiss()
        }
        .buttonStyle(CapsuleButtonStyle(textColor: .white, backgroundColor: .red))
    }
}

#Preview {
    PauseOrDeleteAdultBlockingSessionView(onPauseButtonTapped: {},
                                          onDelteButtonTapped: {})
}
