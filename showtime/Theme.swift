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
        case subtitle
        case base
        case bold
        case small
        case tiny

        var font: UIFont {
            switch self {
            case .title: return UIFont(name: "AvenirNext-Bold", size: 28)!
            case .subtitle: return UIFont(name: "AvenirNext-Medium", size: 20)!
            case .base: return UIFont(name: "AvenirNext-Regular", size: 17)!
            case .bold: return UIFont(name: "AvenirNext-Bold", size: 17)!
            case .small: return UIFont(name: "Avenir-Light", size: 14)!
            case .tiny: return UIFont(name: "Avenir-Light", size: 12)!
            }
        }
    }

    enum Styles {
        case title
        case contrastTitle
        case subtitle
        case tintBold
        case tintSmall
        case bold
        case small
        case tiny

        var style: TextStyle {
            switch self {
            case .title: return TextStyle(font: Fonts.title.font,color: Colors.tint.color)
            case .contrastTitle: return TextStyle(font: Fonts.title.font,color: Colors.background.color)
            case .subtitle: return TextStyle(font: Fonts.subtitle.font, color: Colors.foreground.color)
            case .tintBold: return TextStyle(font: Fonts.bold.font, color: Colors.tint.color)
            case .tintSmall: return TextStyle(font: Fonts.small.font, color: Colors.tint.color)
            case .bold: return TextStyle(font: Fonts.bold.font, color: Colors.foreground.color)
            case .small: return TextStyle(font: Fonts.small.font, color: Colors.foreground.color)
            case .tiny: return TextStyle(font: Fonts.tiny.font, color: Colors.foreground.color)
            }
        }
    }

    enum Constants: Int {
        case estimatedRowHeight = 65
    }

    static func apply() {
        styleBackgrounds()
        styleTabBars()
        styleNavBars()
        styleTableViews()
        styleTableViewCells()
        styleSearchBars()
        styleLabels()
        styleTextViews()
        styleImagePicker()
        styleAlert()
    }

    private static func styleBackgrounds() {
        UIWindow.appearance().backgroundColor = Theme.Colors.background.color
        SetlistView.appearance().backgroundColor = Theme.Colors.background.color
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
        proxy.titleTextAttributes = [NSFontAttributeName: Theme.Fonts.bold.font, NSForegroundColorAttributeName: Theme.Colors.tint.color]
    }

    private static  func styleTableViews() {
        let proxy = UITableView.appearance()
        proxy.backgroundColor = Theme.Colors.background.color
        proxy.tableFooterView = UIView()
        proxy.separatorColor = Theme.Colors.tint.color
        proxy.separatorInset = UIEdgeInsets.zero
        proxy.rowHeight = UITableViewAutomaticDimension
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
        let cbProxy = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        cbProxy.setTitleTextAttributes([NSFontAttributeName: Theme.Fonts.small.font, NSForegroundColorAttributeName: Theme.Colors.tint.color], for: .normal)
    }

    private static func styleLabels() {
        let proxy = UILabel.appearance()
        proxy.textColor = Theme.Colors.foreground.color
        proxy.font = Theme.Fonts.base.font
    }

    private static func styleTextViews() {
        let proxy = UITextView.appearance()
        proxy.backgroundColor = Theme.Colors.background.color
        proxy.font = Fonts.base.font
        proxy.textColor = Theme.Colors.foreground.color
    }

    private static func styleImagePicker() {
        let proxy = UITableViewCell.appearance(whenContainedInInstancesOf: [UIImagePickerController.self])
        proxy.backgroundColor = .white
    }

    private static func styleAlert() {
        let proxy = UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
        proxy.tintColor = Theme.Colors.background.color
    }
}

struct TextStyle {
    let font: UIFont
    let color: UIColor
}

extension UILabel {
    func style(_ style: TextStyle) {
        self.font = style.font
        self.textColor = style.color
    }
}
