//
//  PauseOrDeleteAdultBlockingSessionView.swift
//
//
//  Created by Raul Mena on 8/3/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI

struct PauseOrEndAdultBlockingSessionView: View {
    let store: StoreOf<AdultBlockingSession>
    @Environment(\.dismiss) private var dismiss

     var body: some View {
         WithPerceptionTracking {
             VStack {
                 Text(title)
                     .font(.title3)
                     .foregroundStyle(Color.white)
                     .multilineTextAlignment(.center)
                     .padding(.top)

                 Text(description)
                     .font(.system(size: 15))
                     .foregroundStyle(Color.gray)
                     .multilineTextAlignment(.center)
                     .padding(.top)

                 Spacer()

                 VStack(spacing: 15) {
                     if !store.alwaysOn {
                         pauseButton
                     }
                     endButton
                 }
             }
             .padding(20)
             .background(AppTheme.Colors.sectionViewColor)
             .presentationDetents(store.alwaysOn ? [.fraction(1/3)] : [.fraction(3/7)])
             .presentationDragIndicator(.visible)
         }
    }

    var title: String {
        store.alwaysOn ? "End Blocking Session" : "Pause or End Blocking Session"
    }

    var description: String {
        store.alwaysOn ? "Adult content will be unblocked on all browsers. You can always start a ne session." : "Pausing this session will unblock adult content temporarily on all browsers. Ending the session will unblock adult content permanently."
    }

    var pauseButton: some View {
        Button("Pause") {
            dismiss()
            store.send(.view(.pauseBlockingAdultContentButtonTapped))
        }
        .buttonStyle(CapsuleButtonStyle())
    }

    var endButton: some View {
        Button("End") {
            dismiss()
            store.send(.view(.deleteBlockingAdultContentButtonTapped))
        }
        .buttonStyle(CapsuleButtonStyle(textColor: store.alwaysOn ? .black : .white,
                                        backgroundColor: store.alwaysOn ? .white : .red))
    }
}

#Preview {
    PauseOrEndAdultBlockingSessionView(store: Store(initialState: AdultBlockingSession.State()) {
        AdultBlockingSession()
    })
}
