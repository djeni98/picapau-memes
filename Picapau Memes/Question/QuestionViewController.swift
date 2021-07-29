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

    var selectedItem: SelectItemView? = nil
    var questionIndex = 0
    var questionsArray = questionsArrayData.shuffled()

    var correctAnswersCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rightBarButton?.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.rounded(ofSize: 17, weight: .medium)
        ], for: .normal)

        setupStackView()
        hideBackgroundsFromXIB()

        enableYellowButton(false)
        setupQuestion(ofIndex: questionIndex)
    }

    func setupStackView() {
        if let sv = stackView {
            let screenRect = UIScreen.main.bounds

            let showLastArrangedSubview = screenRect.size.height > 700
            if showLastArrangedSubview {
                let lastItem = sv.arrangedSubviews.last
                lastItem?.isHidden = false
            }
        }
    }

    func hideBackgroundsFromXIB() {
        imageView?.backgroundColor = nil
        if let sv = stackView { sv.backgroundColor = nil }
    }

    func enableYellowButton(_ enabled: Bool) {
        yellowButton.isEnabled = enabled
        yellowButton.alpha = enabled ? 1 : 0.7
    }

    func resetPreviousSelection() {
        enableYellowButton(false)
        selectedItem?.toggleSelection()
        selectedItem = nil
    }

    func setupQuestion(ofIndex index: Int) {
        if index >= questionsArray.count { return }
        let question = questionsArray[index]

        imageView?.image = UIImage(named: question.imageName)
        imageLabel.text = "Imagem \(index + 1) / \(questionsArray.count)"

        guard let sv = stackView else { return }
        let subviews = sv.arrangedSubviews.filter { $0.isHidden == false }

        let options = question.getOptionsLimitedByNumber(subviews.count).shuffled()
        for (i, item) in subviews.enumerated() {
            guard let selectItemView = item as? SelectItemView else { continue }

            selectItemView.textLabel.text = options[i]
        }
    }

    func isSelectedItemCorrect(_ selected: SelectItemView) -> Bool {
        let answer = selected.textLabel.text
        let correctAnswer = questionsArray[questionIndex].correctAnswer

        return answer == correctAnswer
    }

    func isLastQuestion() -> Bool {
        return questionIndex == questionsArray.count - 1
    }

    func setupNextQuestion() {
        questionIndex += 1
        resetPreviousSelection()
        setupQuestion(ofIndex: questionIndex)
        if isLastQuestion() {
            yellowButton.setTitle("Terminar", for: .normal)
        }
    }

    func navigateToResultView() {
        let decimalPercent = Double(correctAnswersCount) / Double(questionsArray.count)
        let integerPercent = Int(decimalPercent * 100)

        let resultViewController = ResultViewController()
        resultViewController.resultPercent = integerPercent
        self.navigationController?.pushViewController(resultViewController, animated: true)
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
        // let _ = self.navigationController?.popViewController(animated: true)
        guard let si = selectedItem else { return }

        if isSelectedItemCorrect(si) {
            correctAnswersCount += 1
            print("Correto")
        } else {
            print("Errado")
        }

        if isLastQuestion() {
            navigateToResultView()
        } else {
            setupNextQuestion()
        }
    }

    @IBAction func selectItemTapGestureAction(_ sender: Any) {
        if let si = selectedItem {
            si.toggleSelection()
        }

        guard let gestureSender = sender as? UITapGestureRecognizer else { return }
        if let si = gestureSender.view as? SelectItemView {
            si.toggleSelection()
            selectedItem = si

            enableYellowButton(true)
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
