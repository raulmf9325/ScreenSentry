//
//  ConfirmStartBlockingAdultContentView.swift
//
//
//  Created by Raul Mena on 8/4/24.
//

import AppUI
import SwiftUI

struct ConfirmStartBlockingAdultContentView: View {
    let onStartButtonTapped: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("Adult websites will be blocked on all browsers")
                .font(.title3)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top)

            VStack(alignment: .leading) {
                Text("Take your first step towards success by desexualizing your brain.")
                    .font(.callout)
                    .foregroundStyle(Color.gray)
                    .padding(.top)

                duration
                    .padding(.top)

                Spacer()

                VStack(spacing: 15) {
                    Button("Start") {
                        onStartButtonTapped()
                        dismiss()
                    }
                    .buttonStyle(CapsuleButtonStyle())
                }
            }
        }
        .padding(20)
        .background(AppTheme.Colors.sectionViewColor)
    }

    var duration: some View {
        HStack {
            Text("Duration")
            Spacer()
            Text("7d")
            Image(systemName: "chevron.right")
                .font(.caption)
                .bold()
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1)
            .background(AppTheme.Colors.accentColor)
        )
    }
}

#Preview {
    ConfirmStartBlockingAdultContentView(onStartButtonTapped: {})
}
