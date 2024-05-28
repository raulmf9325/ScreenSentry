import SwiftUI

public struct AppTheme {
    public struct Colors {
        public static let accentUIColor = UIColor(#colorLiteral(red: 0.10080906, green: 0.125739485, blue: 0.1727902889, alpha: 1))
    }
}

public struct Images {
    public static let home = Image("home", bundle: .module)
}

public extension AppTheme.Colors {
    static var accentColor: Color { Color(uiColor: accentUIColor) }
}
