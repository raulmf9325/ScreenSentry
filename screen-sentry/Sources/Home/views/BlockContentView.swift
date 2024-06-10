//
//  BlockContentView.swift
//
//
//  Created by Raul Mena on 6/10/24.
//

import AppUI
import SwiftUI

struct BlockContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            WorkMode()
            RelaxedMorning()
        }
        .background(AppTheme.Colors.accentColor)
    }
}

#Preview {
    BlockContentView()
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
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.pink)
                
                Text("Relaxed Morning")
                    .foregroundStyle(.white)
                    .font(.headline)
                
                Spacer()
            }
            
            Text("Block content every morning until 10 am.")
                .foregroundStyle(.gray)
                .font(.headline)
        }
        .sectionView()
    }
}
