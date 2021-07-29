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
    @IBOutlet weak var imageBackgroundView: UIImageView!

    var resultPercent: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupImageAndLabels()
    }

    func setupImageAndLabels() {
        guard let percent = resultPercent else { return }

        percentLabel?.text = "\(percent) %"
        percentLabel?.font = .rounded(ofSize: 48, weight: .black)

        let decimalPercent = Double(percent) / 100

        var resultArrayIndex = Int(decimalPercent * Double(resultsArrayData.count)) - 1
        if resultArrayIndex < 0 { resultArrayIndex = 0 }

        let result = resultsArrayData[resultArrayIndex]

        imageView?.image = UIImage(named: result.imageName)
        descriptonLabel?.text = result.description
        descriptonLabel?.font = .rounded(ofSize: 27, weight: .bold)
    }

    @IBAction func backToHomeAction(_ sender: Any) {
        let _ = self.navigationController?.popToRootViewController(animated: true)
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
