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
    @IBOutlet weak var yellowButton: YellowRoundedButton!

    @IBOutlet weak var imageBackgroundView: UIImageView!

    var resultPercent: Int? = nil
    var music: Music? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupImageAndLabels()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.7) {
            self.hideImageAndLabels(false)
            self.hideAndDisableYellowButton(false)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SFXPlayer.shared.playMusic(music: music)
    }

    func hideImageAndLabels(_ hide: Bool) {
        let alpha: CGFloat = hide ? 0 : 1
        percentLabel?.alpha = alpha
        imageView?.alpha = alpha
        descriptonLabel?.alpha = alpha
    }

    func hideAndDisableYellowButton(_ hide: Bool) {
        yellowButton?.alpha = hide ? 0.1 : 1
        yellowButton?.isEnabled = !hide
    }

    func setupImageAndLabels() {
        guard let percent = resultPercent else { return }

        percentLabel?.text = "\(percent) %"
        percentLabel?.font = .rounded(ofSize: 48, weight: .black)

        let decimalPercent = Double(percent) / 100

        let resultArrayIndex = Int((decimalPercent * Double(resultsArrayData.count - 1)).rounded())

        let result = resultsArrayData[resultArrayIndex]
        music = result.music

        imageView?.image = UIImage(named: result.imageName)
        descriptonLabel?.text = result.description
        descriptonLabel?.font = .rounded(ofSize: 27, weight: .bold)

        hideImageAndLabels(true)
        hideAndDisableYellowButton(true)
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
