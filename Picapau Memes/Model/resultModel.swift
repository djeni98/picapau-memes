//
//  resultModel.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 29/07/21.
//

import Foundation
import UIKit

struct Background {
    var colorName: String
    var alpha: CGFloat = 1
}

struct Result {
    var imageName: String
    var description: String
    var background: [Background]? = nil

    func getGradientLayer(frame: CGRect) -> CAGradientLayer? {
        guard let bg = background else { return nil }
        if bg.count != 2 { return nil }

        let colorTop = UIColor(named: bg[0].colorName)!.cgColor.copy(alpha: bg[0].alpha)!
        let colorBottom = UIColor(named: bg[1].colorName)!.cgColor.copy(alpha: bg[1].alpha)!

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame

        return gradientLayer
    }
}

let resultsArrayData = [
    Result(
        imageName: "triste-nao",
        description: "Triste, não?",
        background: [Background(colorName: "AppBlue", alpha: 0.5)]
    ),
    Result(
        imageName: "aeee",
        description: "Aeeeeeeeee",
        background: [
            Background(colorName: "AppYellow", alpha: 0.9),
            Background(colorName: "AppRed", alpha: 0.8),
        ]
    ),
]
