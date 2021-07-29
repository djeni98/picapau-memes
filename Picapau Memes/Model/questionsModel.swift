//
//  questionsModel.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 29/07/21.
//

import Foundation

struct Question {
    var imageName: String
    var options: [String]
    var correctIndex: Int = 0
    var correctAnswer: String { options[correctIndex] }

    func getOptionsLimitedByNumber(_ n: Int) -> [String] {
        if options.count > n {
            let wrongAnswers = options.filter { $0 != correctAnswer }
            return [correctAnswer] + wrongAnswers[0..<n-1]
        } else {
            return options
        }
    }
}

let questionsArrayData = [
    Question(
        imageName: "cada-coisa",
        options: [
            "Essa gente inventa cada coisa",
            "É cada coisa que aparece",
            "Um cafezinho vai bem agora"
        ]
    ),
    Question(
        imageName: "pipoca",
        options: [
            "Você falou em pipoca?",
            "Você disse pipoca amanteigada?",
            "Falou coberta de açucar?"
        ]),
]
