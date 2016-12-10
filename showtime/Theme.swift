//
//  Theme.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 04/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit

struct Theme {

    enum Colors {
        case tint
        case background
        case foreground
        case selected

        var color: UIColor {
            switch self {
            case .tint: return UIColor(red:204/255, green:255/255, blue:102/255, alpha:1)
            case .selected: return .darkGray
            case .background: return UIColor(red:20/255, green:20/255, blue:20/255, alpha:1)
            case .foreground: return .white
            }
        }
    }

    enum Fonts {
        case title
        case bold
        case base
        case base2

        var font: UIFont {
            switch self {
            case .bold: return UIFont(name: "Copperplate-Bold", size: 17)!
            case .title: return UIFont(name: "Copperplate", size: 16)!
            case .base: return UIFont(name: "AvenirNext-Regular", size: 17)!// return UIFont.systemFont(ofSize: 17, weight: FontWeight.regular.weight)
            case .base2: return UIFont(name: "Copperplate", size: 20)!
            }
        }
    }

    enum FontWeight {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black

        var weight: CGFloat {
            switch self {
            case .ultraLight: return UIFontWeightUltraLight
            case .thin: return UIFontWeightThin
            case .light: return UIFontWeightLight
            case .regular: return UIFontWeightRegular
            case .medium: return UIFontWeightMedium
            case .semibold: return UIFontWeightSemibold
            case .bold: return UIFontWeightBold
            case .heavy: return UIFontWeightHeavy
            case .black: return UIFontWeightBlack
            }
        }
    }

    static func apply() {
        UIWindow.appearance().backgroundColor = Theme.Colors.background.color
        SetlistView.appearance().backgroundColor = Theme.Colors.background.color
        styleTabBars()
        styleNavBars()
        styleTableViews()
        styleTableViewCells()
        styleSearchBars()
        styleLabels()
        styleButtons()
        styleTextViews()
        styleDatePicker()
    }

    private static func styleTabBars() {
        let proxy = UITabBar.appearance()
        proxy.barStyle = .black
        proxy.barTintColor = Theme.Colors.background.color
    }

    private static  func styleNavBars() {
        let proxy = UINavigationBar.appearance()
        proxy.barStyle = .black
        proxy.barTintColor = Theme.Colors.background.color
    }

    private static  func styleTableViews() {
        let proxy = UITableView.appearance()
        proxy.backgroundColor = Theme.Colors.background.color
        proxy.tableFooterView = UIView()
        proxy.separatorColor = Theme.Colors.tint.color
        proxy.separatorInset = UIEdgeInsets.zero
    }

    private static  func styleTableViewCells() {
        let proxy = UITableViewCell.appearance()
        proxy.backgroundColor = Theme.Colors.background.color
        let view = UIView()
        view.backgroundColor = Theme.Colors.tint.color
        proxy.selectedBackgroundView = view
    }

    private static  func styleSearchBars() {
        let proxy = UISearchBar.appearance()
        proxy.barStyle = .black
    }

    private static func styleLabels() {
        let proxy = UILabel.appearance()
        proxy.textColor = Theme.Colors.foreground.color
        proxy.font = Theme.Fonts.base.font
    }

    private static func styleButtons() {
        let proxy = UIButton.appearance()
        proxy.titleLabel?.font = Fonts.base2.font
    }

    private static func styleTextViews() {
        let proxy = UITextView.appearance()
        proxy.backgroundColor = Theme.Colors.background.color
        proxy.font = Fonts.base.font
        proxy.textColor = Theme.Colors.foreground.color
    }

    private static func styleDatePicker() {
        let proxy = UIDatePicker.appearance()
        proxy.tintColor = Theme.Colors.tint.color
    }
}

struct TextStyle {
    let color: UIColor
    let weight: CGFloat
    let size: CGFloat
}

let titleStyle = TextStyle(color: Theme.Colors.tint.color, weight: UIFontWeightBold, size: 28.0)

extension UILabel {
    func style(_ style: TextStyle) {
        self.font = UIFont.systemFont(ofSize: style.size, weight: style.weight)
        self.textColor = style.color
    }
}
