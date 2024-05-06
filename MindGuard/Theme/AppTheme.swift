//
//  AppTheme.swift
//  MindGuard
//
//  Created by Raul Mena on 5/5/24.
//

import SwiftUI

struct AppTheme {
    struct Colors {
        static let accentUIColor = UIColor(#colorLiteral(red: 0.10080906, green: 0.125739485, blue: 0.1727902889, alpha: 1))
    }
    
    struct Images {
        static let home = Image("home")
    }
}

extension AppTheme.Colors {
    static var accentColor: Color { Color(uiColor: accentUIColor) }
}
