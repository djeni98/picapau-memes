//
//  QuestionViewController.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 27/07/21.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var rightBarButton: UIBarButtonItem!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var imageLabel: UILabel!

    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var yellowButton: YellowRoundedButton!

    let questionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rightBarButton?.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.rounded(ofSize: 17, weight: .medium)
        ], for: .normal)

        setupStackView()
        imageView?.backgroundColor = nil

        setupQuestionIndex(questionIndex)
    }

    func setupStackView() {
        if let sv = stackView {
            sv.backgroundColor = nil
            let screenRect = UIScreen.main.bounds

            let showLastArrangedSubview = screenRect.size.height > 700
            if showLastArrangedSubview {
                let lastItem = sv.arrangedSubviews.last
                lastItem?.isHidden = false
            }
        }
    }

    func setupQuestionIndex(_ index: Int) {
        if index >= questionsArrayData.count { return }

        let question = questionsArrayData[index]

        imageView?.image = UIImage(named: question.imageName)
        imageLabel.text = "Imagem \(index + 1) / \(questionsArrayData.count)"

        if let sv = stackView {
            let subviews = sv.arrangedSubviews.filter { $0.isHidden == false }
            
            let options = question.getOptionsLimitedByNumber(subviews.count).shuffled()
            for (i, item) in subviews.enumerated() {
                guard let selectItemView = item as? SelectItemView else { continue }

                selectItemView.textLabel.text = options[i]
            }
        }
    }

    func setImageGradientBackground() {
        let colorTop =  UIColor(named: "AppYellow")!.cgColor.copy(alpha: 0.9)!
        let colorBottom = UIColor(named: "AppRed")!.cgColor.copy(alpha: 0.8)!

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = imageBackgroundView.bounds

        imageBackgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }

    @IBAction func giveUpAction(_ sender: Any) {
        let alert = UIAlertController(title: "Você deseja realmente desistir?", message: nil, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        )
        alert.addAction(
            UIAlertAction(title: "Desistir", style: .destructive, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
        )

        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func yellowButtonAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
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
