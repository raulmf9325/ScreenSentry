import SwiftUI

public struct AppTheme {
    public struct Colors {
        public static let accentUIColor = UIColor(#colorLiteral(red: 0.07450980392, green: 0.0862745098, blue: 0.1215686275, alpha: 1))
        public static let primaryTextUIColor = UIColor(#colorLiteral(red: 0.1333333333, green: 0.0431372549, blue: 0.3568627451, alpha: 1))
        public static let alertUIColor = UIColor(#colorLiteral(red: 0.937254902, green: 0.3019607843, blue: 0.3843137255, alpha: 1))
        public static let primaryButtonUIColor = UIColor(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        public static let sectionViewUIColor = UIColor(#colorLiteral(red: 0.1098039216, green: 0.1215686275, blue: 0.1529411765, alpha: 1))
    }
}

public struct Images {
    public static let home = Image("home", bundle: .module)
}

public extension AppTheme.Colors {
    static var accentColor: Color { Color(uiColor: accentUIColor) }
    static var primaryTextColor: Color { Color(uiColor: primaryTextUIColor) }
    static var alertColor: Color { Color(uiColor: alertUIColor) }
    static var primaryButtonColor: Color { Color(uiColor: primaryButtonUIColor) }
    static var sectionViewColor: Color { Color(uiColor: sectionViewUIColor) }
}
