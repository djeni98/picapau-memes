//
//  UIFontExtension.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 27/07/21.
//

import Foundation
import UIKit

// Code from https://stackoverflow.com/questions/59981497/how-to-use-sf-rounded-in-uikit/65217577#65217577

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)

        guard #available(iOS 13.0, *), let descriptor = systemFont.fontDescriptor.withDesign(.rounded) else { return systemFont }
        return UIFont(descriptor: descriptor, size: size)
    }
}
