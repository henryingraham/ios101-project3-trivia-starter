//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Henry Ingraham on 10/3/23.
//

import UIKit
extension String {
    func decodeHTML() -> String? {
        if let data = self.data(using: .utf8) {
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                return attributedString.string
            }
        }
        return nil
    }
}

class TriviaViewController: UIViewController {

    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionCategory: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBAction func didTapButton(_ sender: UIButton) {
        let selectedAnswer = sender.titleLabel?.text
        let currentQuestion = questions[index]
        if selectedAnswer == currentQuestion.correct_answer {
            correctAnswerCount += 1
        }
        index += 1
        if index < questions.count {
            displayQuestion()
        } else {
            // The game is over, show an alert with the score
            showScoreAlert()
        
        }
    }
    private func resetGame() {
        index = 0
        correctAnswerCount = 0
        fetchTriviaQuestions()
    }
    func showScoreAlert() {
        let scoreMessage = "Your Score: \(correctAnswerCount) out of \(questions.count)"
        let alert = UIAlertController(title: "Game Over", message: scoreMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            // Handle any post-game logic here, if needed
            self.resetGame()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    private var index = 0
    private var questions = [CurrentTriviaQuestion]()
    private var correctAnswerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchTriviaQuestions()
    }
    private func fetchTriviaQuestions() {
            TriviaQuestionService.fetchQuestions { [weak self] (questions) in
                self?.questions = questions.results
                self?.index = 0
                self?.correctAnswerCount = 0
                self?.displayQuestion()
            }
        }
    private func displayQuestion() {
        if index < questions.count {
            let currentQuestion = questions[index]
            questionNumber.text = "Question: \(index + 1)/\(questions.count)"
            questionText.text = currentQuestion.question.decodeHTML()
            questionCategory.text = "Category: \(currentQuestion.category)"
            answerButton1.setTitle(currentQuestion.incorrect_answers[0].decodeHTML(), for: .normal)
            answerButton2.setTitle(currentQuestion.incorrect_answers[1].decodeHTML(), for: .normal)
            answerButton3.setTitle(currentQuestion.incorrect_answers[2].decodeHTML(), for: .normal)
            answerButton4.setTitle(currentQuestion.correct_answer.decodeHTML(), for: .normal)
        } else {
            // The game is over, show an alert with the score
            showScoreAlert()
        }
    }
    

}
