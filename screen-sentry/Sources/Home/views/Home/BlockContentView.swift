//
//  BlockContentView.swift
//
//
//  Created by Raul Mena on 6/10/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI

struct BlockContentView: View {
    let store: StoreOf<Home>

    init(_ store: StoreOf<Home>) {
        self.store = store
    }

    var body: some View {
        VStack(spacing: 20) {
            StartSession(store)
            WorkMode()
            RelaxedMorning()
        }
    }
}

private struct StartSession: View {
    let store: StoreOf<Home>

    init(_ store: StoreOf<Home>) {
        self.store = store
    }

    var body: some View {
        ContentSectionView(imageName: "lock.app.dashed",
                           imageColor: .blue,
                           imageFont: .title,
                           title: "Start Blocking Session",
                           description: "Start blocking apps and websites for a selected amount of time.",
                           onTap: { store.send(.onStartBlockingSessionButtonTapped) })
    }
}

private struct WorkMode: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "desktopcomputer")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.green)
                
                Text("Work Mode")
                    .foregroundStyle(.white)
                    .font(.headline)
                
                Spacer()
                
                Text("+")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            
            Text("Block distracting apps and websites so that you can focus on deep work.")
                .foregroundStyle(.gray)
                .font(.headline)
        }
        .sectionView()
    }
}

private struct RelaxedMorning: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "sun.max.fill")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.orange)

                Text("Relaxed Morning")
                    .foregroundStyle(.white)
                    .font(.headline)
                
                Spacer()
                
                Text("+")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            
            Text("Block content every morning until 10 am.")
                .foregroundStyle(.gray)
                .font(.headline)
        }
        .sectionView()
    }
}

#Preview {
    BlockContentView(
        Store(initialState: Home.State()) {
            Home()
        } withDependencies: {
            $0.screenTimeApi.requestAccess = { @Sendable in
                return .approved
            }
        } )
}
