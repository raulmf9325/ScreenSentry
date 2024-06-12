//
//  BlockContentView.swift
//
//
//  Created by Raul Mena on 6/10/24.
//

import AppUI
import SwiftUI

struct BlockContentView: View {
    let onStartBlockingSessionButtonTapped: () -> Void
    let onWorkModeButtonTapped: () -> Void
    let onRelaxedMorningButtonTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            StartSession(onTapGesture: onStartBlockingSessionButtonTapped)
            WorkMode()
            RelaxedMorning()
        }
    }
}

#Preview {
    BlockContentView(onStartBlockingSessionButtonTapped: {},
                     onWorkModeButtonTapped: {},
                     onRelaxedMorningButtonTapped: {})
}

private struct StartSession: View {
    let onTapGesture: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "lock.app.dashed")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.blue)
                
                Text("Start Blocking Session")
                    .foregroundStyle(.white)
                    .font(.headline)
                
                Spacer()
                
                Text("+")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            
            Text("Start blocking apps and websites for a selected amount of time.")
                .foregroundStyle(.gray)
                .font(.headline)
        }
        .sectionView()
        .onTapGesture(perform: onTapGesture)
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
                Image(systemName: "clock.fill")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.pink)
                
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
