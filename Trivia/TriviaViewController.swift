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
        answerButton1.isUserInteractionEnabled = false
        answerButton2.isUserInteractionEnabled = false
        answerButton3.isUserInteractionEnabled = false
        answerButton4.isUserInteractionEnabled = false
        
        let selectedAnswer = sender.titleLabel?.text
        let currentQuestion = questions[index]
        let correctAnswer = currentQuestion.correct_answer.decodeHTML()
        
        if selectedAnswer == correctAnswer {
            // If the selected answer is correct, turn the button green
            sender.backgroundColor = UIColor.green
            correctAnswerCount += 1
        } else {
            // If the selected answer is incorrect, turn the button red
            sender.backgroundColor = UIColor.red
        }
        
        // Wait for a short duration (e.g., 1 second) to show the feedback
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Enable interaction with buttons and reset their background color
            self.answerButton1.isUserInteractionEnabled = true
            self.answerButton2.isUserInteractionEnabled = true
            self.answerButton3.isUserInteractionEnabled = true
            self.answerButton4.isUserInteractionEnabled = true
            
            sender.backgroundColor = UIColor.lightText
            
            self.index += 1
            if self.index < self.questions.count {
                self.displayQuestion()
            } else {
                // The game is over, show an alert with the score
                self.showScoreAlert()
            }
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
            
            // Check if the question is true or false
            if currentQuestion.type == "boolean" {
                // For true or false questions, display only the first two answer choices
                var answerChoices = ["True", "False"]
                answerChoices.shuffle()
                answerButton1.setTitle(answerChoices[0], for: .normal)
                answerButton2.setTitle(answerChoices[1], for: .normal)
                answerButton3.isHidden = true
                answerButton4.isHidden = true
            } else {
                // For other types of questions, display all four answer choices
                var answerChoices = currentQuestion.incorrect_answers + [currentQuestion.correct_answer]
                answerChoices.shuffle()
                answerButton1.setTitle(answerChoices[0].decodeHTML(), for: .normal)
                answerButton2.setTitle(answerChoices[1].decodeHTML(), for: .normal)
                answerButton3.setTitle(answerChoices[2].decodeHTML(), for: .normal)
                answerButton4.setTitle(answerChoices[3].decodeHTML(), for: .normal)
                answerButton3.isHidden = false
                answerButton4.isHidden = false
            }
        } else {
            // The game is over, show an alert with the score
            showScoreAlert()
        }
    }

    

}
