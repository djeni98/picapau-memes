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
    let defaultColor = UIColor.systemGray3
    var alphaZero: CGColor? { defaultColor.cgColor.copy(alpha: 0) }
    var alphaOne: CGColor? { defaultColor.cgColor }

    func resetSelection() {
        selected = false
        self.circleImageView.image = UIImage(systemName: "circle")
        self.circleImageView.tintColor = defaultColor
        self.view.layer.borderColor = alphaZero
    }

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

    func customizeStyle(color: UIColor?, imageName: String) {
        UIView.animate(withDuration: 0.3, animations: {
            self.circleImageView.alpha = 0

            self.circleImageView.image = UIImage(systemName: imageName)
            self.circleImageView.tintColor = color

            self.circleImageView.alpha = 1
        })

        self.view.layer.borderColor = alphaZero
        animateViewBorder(withDelay: 0.3, fromColor: alphaZero, toColor: color?.cgColor)
    }

    func customizeToCorrect() {
        customizeStyle(color: UIColor(named: "AppBlue"), imageName: "checkmark.circle.fill")
    }

    func customizeToWrong() {
        customizeStyle(color: UIColor(named: "AppRed"), imageName: "xmark.circle.fill")
    }
}
