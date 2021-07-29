//
//  ResultViewController.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 29/07/21.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptonLabel: UILabel!

    @IBOutlet weak var coloredBackgroundView: UIView!

    var resultPercent: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        coloredBackgroundView.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupImageAndLabels()
        UIView.animate(withDuration: 0.2, animations: {
            self.coloredBackgroundView.alpha = 1
        })
    }

    func setupImageAndLabels() {
        guard let percent = resultPercent else { return }

        percentLabel?.text = "\(percent) %"
        percentLabel?.font = .rounded(ofSize: 48, weight: .black)

        let decimalPercent = Double(percent) / 100
        let resultArrayIndex = Int(decimalPercent * Double(resultsArrayData.count)) - 1
        let result = resultsArrayData[resultArrayIndex]

        imageView?.image = UIImage(named: result.imageName)
        descriptonLabel?.text = result.description
        descriptonLabel?.font = .rounded(ofSize: 27, weight: .bold)

        if let gradientLayer = result.getGradientLayer(frame: coloredBackgroundView.bounds) {
            coloredBackgroundView.backgroundColor = nil
            coloredBackgroundView.layer.insertSublayer(gradientLayer, at: 0)
        } else if let background = result.background?.first {
            let color = UIColor(named: background.colorName)?.withAlphaComponent(background.alpha)
            coloredBackgroundView.backgroundColor = color
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
