//
//  YellowRoundedButton.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 27/07/21.
//

import UIKit

class YellowRoundedButton: UIButton {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 30
        self.layer.backgroundColor = UIColor(named: "AppYellow")?.cgColor

        self.titleLabel?.font = .rounded(ofSize: 20, weight: .black)
        self.titleLabel?.tintColor = .black

        self.contentEdgeInsets.left = 40
        self.contentEdgeInsets.right = 40
    }
}
