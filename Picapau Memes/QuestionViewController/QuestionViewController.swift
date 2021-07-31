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

    enum YellowButtonState {
        case answer
        case next
    }
    var yellowButtonState: YellowButtonState = .answer

    var selectedItem: SelectItemView? = nil
    var correctItem: SelectItemView? = nil

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

    func changeYellowButtonTitle(to title: String) {
        UIView.animate(withDuration: 0.3, animations: {
            self.yellowButton.alpha = 0
            self.yellowButton.setTitle(title, for: .normal)
            self.yellowButton.alpha = 1
        })
    }

    func resetPreviousSelection() {
        correctItem?.resetSelection()
        selectedItem?.resetSelection()

        selectedItem = nil
        correctItem = nil
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
            if options[i] == question.correctAnswer { correctItem = selectItemView }
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

        enableYellowButton(false)
        yellowButtonState = .answer
        changeYellowButtonTitle(to: "Responder")
    }

    func navigateToResultView() {
        let decimalPercent = Double(correctAnswersCount) / Double(questionsArray.count)
        let integerPercent = Int(decimalPercent * 100)

        let resultViewController = ResultViewController()
        resultViewController.resultPercent = integerPercent
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }

    func checkAnswer(with si: SelectItemView) {
        correctItem?.customizeToCorrect()

        if isSelectedItemCorrect(si) {
            correctAnswersCount += 1
            si.customizeToCorrect()
        } else {
            si.customizeToWrong()
        }

        changeYellowButtonTitle(to: isLastQuestion() ? "Terminar" : "Próximo")
        yellowButtonState = .next
    }

    func setupNextPage() {
        if isLastQuestion() {
            navigateToResultView()
        } else {
            setupNextQuestion()
        }
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
        switch yellowButtonState {
        case .answer:
            guard let si = selectedItem else { return }
            checkAnswer(with: si)
        case .next:
            setupNextPage()
        }
    }

    @IBAction func selectItemTapGestureAction(_ sender: Any) {
        if yellowButtonState == .next { return }

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
