//
//  SelectItemView.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 28/07/21.
//

import UIKit

class SelectItemView: CustomUIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var textLabel: UILabel!

    @IBOutlet weak var circleImageView: UIImageView!
    var selected = false
    func toggleSelection() {
        selected.toggle()
        let imageName = selected ? "largecircle.fill.circle" : "circle"
        if selected {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.circleImageView.alpha = 0
                    self.circleImageView.image = UIImage(systemName: imageName)
                    self.circleImageView.alpha = 1
            })
        } else {
            self.circleImageView.image = UIImage(systemName: imageName)
        }
    }

    override func customizeView() {
        self.view.layer.cornerRadius = 10
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = UIColor(named: "AppRed")?.cgColor.copy(alpha: 0.5)
    }
}
