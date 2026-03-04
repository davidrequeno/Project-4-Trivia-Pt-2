//
//  ViewController.swift
//  Trivia
//
//  Created by user253906 on 3/2/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!

    private var questions: [TriviaQuestion] = []
    private var currentIndex = 0
    private var score = 0
    private var currentAnswers: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
        buttons.forEach { button in
            button?.titleLabel?.numberOfLines = 0
            button?.titleLabel?.textAlignment = .center
            button?.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        fetchNewGame()
    }

    private func fetchNewGame() {
        score = 0
        currentIndex = 0

        TriviaQuestionService.shared.fetchQuestions(amount: 10) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let questions):
                    self?.questions = questions
                    self?.showCurrentQuestion()
                case .failure(let error):
                    print("Error fetching questions: \(error)")
                }
            }
        }
    }

    private func showCurrentQuestion() {
        guard currentIndex < questions.count else {
            showFinalScore()
            return
        }

        let q = questions[currentIndex]
        questionLabel.text = "Question \(currentIndex + 1)/\(questions.count)\n\n\(htmlDecoded(q.question))"

        currentAnswers = q.allAnswersShuffled
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]

        for (i, button) in buttons.enumerated() {
            if i < currentAnswers.count {
                button?.isHidden = false
                button?.setTitle(htmlDecoded(currentAnswers[i]), for: .normal)
                button?.setTitleColor(.black, for: .normal)
                button?.backgroundColor = .systemGray5
                button?.isEnabled = true
                button?.tag = i
            } else {
                button?.isHidden = true
            }
        }
    }

    @IBAction func answerTapped(_ sender: UIButton) {
        if sender.tag == 99 {
            fetchNewGame()
            return
        }

        let selected = currentAnswers[sender.tag]
        let correct = questions[currentIndex].correctAnswer

        if selected == correct {
            score += 1
            sender.backgroundColor = .systemGreen
        } else {
            sender.backgroundColor = .systemRed
            if let correctIndex = currentAnswers.firstIndex(of: correct) {
                let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
                buttons[correctIndex]?.backgroundColor = .systemGreen
            }
        }

        [answerButton1, answerButton2, answerButton3, answerButton4].forEach { $0?.isEnabled = false }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.currentIndex += 1
            self.showCurrentQuestion()
        }
    }

    private func showFinalScore() {
        questionLabel.text = "Final Score: \(score)/\(questions.count)"

        answerButton1.isHidden = true
        answerButton2.isHidden = true
        answerButton3.isHidden = true

        answerButton4.setTitle("Restart Game", for: .normal)
        answerButton4.tag = 99
        answerButton4.isHidden = false
        answerButton4.backgroundColor = .systemGray5
        answerButton4.setTitleColor(.black, for: .normal)
    }

    private func htmlDecoded(_ string: String) -> String {
        guard let data = string.data(using: .utf8) else { return string }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributed.string
        }
        return string
    }
}
