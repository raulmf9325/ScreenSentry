//
//  AdultDurationPicker.swift
//
//
//  Created by Raul Mena on 8/8/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI

struct AdultDurationPicker: View {
    @Perception.Bindable var store: StoreOf<StartAdultBlockingSession>

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("Duration")
                    .font(.title2)
                    .foregroundStyle(Color.white)

                HStack {
                    numberPicker
                    timeUnitPicker
                }

                Spacer()

                VStack(spacing: 15) {
                    Button("Confirm") {
                        store.send(.view(.durationPickerConfirmButtonTapped))
                        dismiss()
                    }
                    .buttonStyle(CapsuleButtonStyle())
                }
            }
            .padding(20)
            .background(AppTheme.Colors.sectionViewColor)
        }
    }

    var numberPicker: some View {
        WithPerceptionTracking {
            Picker("", selection: $store.selectedNumber) {
                ForEach(Array(1...100), id: \.self) {
                    Text("\($0)")
                        .foregroundStyle(Color.white)
                }
            }
            .pickerStyle(.wheel)
        }
    }

    var timeUnitPicker: some View {
        WithPerceptionTracking {
            Picker("", selection: $store.selectedTimeUnit) {
                ForEach(TimeUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                        .foregroundStyle(Color.white)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

#Preview {
    AdultDurationPicker(store: Store(initialState: StartAdultBlockingSession.State()) {
        StartAdultBlockingSession()
    })
}
