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
        let imageName = selected ? "checkmark.circle.fill" : "circle"
        circleImageView.image = UIImage(systemName: imageName)
    }

    override func customizeView() {
        self.view.layer.cornerRadius = 10
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = UIColor(named: "AppRed")?.cgColor.copy(alpha: 0.5)
    }
}
