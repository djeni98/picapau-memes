//
//  QuestionViewController.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 27/07/21.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rightBarButton?.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.rounded(ofSize: 17, weight: .medium)
        ], for: .normal)

        if let sv = stackView {
            let screenRect = UIScreen.main.bounds

            let showLastArrangedSubview = screenRect.size.height > 700
            if showLastArrangedSubview {
                let lastItem = sv.arrangedSubviews.last
                lastItem?.isHidden = false
            }
        }
    }

    @IBAction func giveUpAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
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
