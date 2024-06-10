//
//  PermissionDeniedView.swift
//
//
//  Created by Raul Mena on 6/10/24.
//

import AppUI
import SwiftUI

struct PermissionDeniedView: View {
    let onButtonTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.headline)
                    .foregroundStyle(AppTheme.Colors.alertColor)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Permission denied")
                        .foregroundStyle(AppTheme.Colors.alertColor)
                    
                    Text("Screen Sentry needs access to Screen Time in order to work.")
                        .foregroundStyle(.white)
                }
                .font(.headline)
            }
            
            Button(action: onButtonTapped) {
                Text("Grant access")
                    .bold()
            }
            .buttonStyle(PrimaryButton())
        }
        .sectionView()
    }
}

#Preview {
    PermissionDeniedView(onButtonTapped: {})
}
