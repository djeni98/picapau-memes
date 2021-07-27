//
//  QuestionViewController.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 27/07/21.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true);

        let rightButton = UIBarButtonItem(title: "Desistir", style: .plain, target: self, action: #selector(giveUpAction))
        rightButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.rounded(ofSize: 17, weight: .medium)
        ], for: .normal)

        self.navigationItem.rightBarButtonItem = rightButton
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc
    func giveUpAction() {
        print("Desistir")
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
