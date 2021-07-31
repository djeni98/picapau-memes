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

    let animationDuration = 0.3
    let alphaZero = UIColor.systemGray3.cgColor.copy(alpha: 0)
    let alphaOne = UIColor.systemGray3.cgColor
    func toggleSelection() {
        selected.toggle()
        let imageName = selected ? "largecircle.fill.circle" : "circle"
        if selected {
            animateViewBorder(withDelay: animationDuration, fromColor: alphaZero, toColor: alphaOne)

            UIView.animate(
                withDuration: animationDuration,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.circleImageView.alpha = 0
                    self.circleImageView.image = UIImage(systemName: imageName)
                    self.circleImageView.alpha = 1
            })
        } else {
            self.circleImageView.image = UIImage(systemName: imageName)
            self.view.layer.borderColor = alphaZero
        }
    }

    func animateViewBorder(withDelay delay: Double, fromColor: CGColor?, toColor: CGColor?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.view.layer.borderColor = toColor
        }

        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue = fromColor
        colorAnimation.toValue = toColor
        colorAnimation.duration = CFTimeInterval(delay) + 0.1

        colorAnimation.repeatCount = 1
        self.view.layer.add(colorAnimation, forKey: "borderColor")
    }

    override func customizeView() {
        self.view.layer.cornerRadius = 10
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = alphaZero
    }
}
