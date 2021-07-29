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
    Question(
        imageName: "policia",
        options: [
            "Se o pica pau tivesse comunicado a polícia",
            "Seria melhor comunicar a polícia",
            "Se o ele tivesse avisado a polícia"
        ]
    ),
    Question(
        imageName: "vamos-nos",
        options: [
            "E lá vamos nós",
            "Asas batendo, marcha de decolagem",
            "Esta também não é"
        ]
    ),
    Question(
        imageName: "conozco",
        options: [
            "Yo no lo conozco, señor",
            "Eu não o conheço, senhor",
            "Yo no se, senõr"
        ]
    ),
    Question(
        imageName: "vigarice",
        options: [
            "Essa vai ser minha melhor vigarice",
            "Essa vai ser minha melhor trapaça",
            "A maior vigarice de todas"
        ]
    ),
    Question(
        imageName: "inferno",
        options: [
            "Vá pro inferno",
            "Vá pra raio que o parta",
            "Vai se lascar"
        ]
    ),
]
