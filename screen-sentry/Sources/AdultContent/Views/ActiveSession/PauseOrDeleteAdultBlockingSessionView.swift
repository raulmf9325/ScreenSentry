//
//  PauseOrDeleteAdultBlockingSessionView.swift
//
//
//  Created by Raul Mena on 8/3/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI

struct PauseOrDeleteAdultBlockingSessionView: View {
    let store: StoreOf<AdultBlockingSession>
    @Environment(\.dismiss) private var dismiss

     var body: some View {
        VStack {
            Text("Momentarily Pause Or Permanently Delete This Session.")
                .font(.title3)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top)

            Text("Pausing the session will unblock adult content temporarily. Deleting the session will unblock it permanently.")
                .font(.system(size: 14))
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
            dismiss()
            store.send(.view(.pauseBlockingAdultContentButtonTapped))
        }
        .buttonStyle(CapsuleButtonStyle())
    }

    var deleteButton: some View {
        Button("Delete") {
            dismiss()
            store.send(.view(.deleteBlockingAdultContentButtonTapped))
        }
        .buttonStyle(CapsuleButtonStyle(textColor: .white, backgroundColor: .red))
    }
}

#Preview {
    PauseOrDeleteAdultBlockingSessionView(store: Store(initialState: AdultBlockingSession.State()) {
        AdultBlockingSession()
    })
}
