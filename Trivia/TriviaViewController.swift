//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Henry Ingraham on 10/3/23.
//

import UIKit

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
        if selectedAnswer == currentQuestion.correctAnswer {
            correctAnswerCount += 1
        }
        index += 1
        
        if index < questions.count {
            displayQuestion(with: questions[index])
        } else {
            // The game is over, show an alert with the score
            showScoreAlert()
            index = 0
            correctAnswerCount = 0
            displayQuestion(with: questions[index])
        }
    }
    func showScoreAlert() {
        let scoreMessage = "Your Score: \(correctAnswerCount) out of \(questions.count)"
        let alert = UIAlertController(title: "Game Over", message: scoreMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            // Handle any post-game logic here, if needed
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    private var index = 0
    private var questions = [TriviaQuestion]()
    private var correctAnswerCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questions = createMockData()
        displayQuestion(with: questions[index])
        
    }
    private func createMockData() -> [TriviaQuestion] {
        let mockData1 = TriviaQuestion(
            questionNumber: 1,
            questionCategory: "Geography",
            questionText: "What is the capital of France?",
            answer1: "Berlin",
            answer2: "London",
            answer3: "Paris",
            answer4: "Rome",
            correctAnswer: "Paris"
        )

        let mockData2 = TriviaQuestion(
            questionNumber: 2,
            questionCategory: "Astrology",
            questionText: "Which planet is known as the 'Red Planet'?",
            answer1: "Earth",
            answer2: "Mars",
            answer3: "Venus",
            answer4: "Jupiter",
            correctAnswer: "Mars"
        )

        let mockData3 = TriviaQuestion(
            questionNumber: 3,
            questionCategory: "Geography",
            questionText: "What is the largest mammal in the world?",
            answer1: "Elephant",
            answer2: "Giraffe",
            answer3: "Blue Whale",
            answer4: "Cheetah",
            correctAnswer: "Blue Whale"
        )

        let mockData4 = TriviaQuestion(
            questionNumber: 4,
            questionCategory: "Science",
            questionText: "What is the chemical symbol for gold?",
            answer1: "Au",
            answer2: "Ag",
            answer3: "Fe",
            answer4: "Hg",
            correctAnswer: "Au"
        )

        let mockData5 = TriviaQuestion(
            questionNumber: 5,
            questionCategory: "History",
            questionText: "Who was the first President of the United States?",
            answer1: "Thomas Jefferson",
            answer2: "John Adams",
            answer3: "George Washington",
            answer4: "Benjamin Franklin",
            correctAnswer: "George Washington"
        )

        let mockData6 = TriviaQuestion(
            questionNumber: 6,
            questionCategory: "Movies",
            questionText: "Which movie won the Academy Award for Best Picture in 1994?",
            answer1: "Forrest Gump",
            answer2: "Pulp Fiction",
            answer3: "Schindler's List",
            answer4: "The Shawshank Redemption",
            correctAnswer: "Forrest Gump"
        )

        let mockData7 = TriviaQuestion(
            questionNumber: 7,
            questionCategory: "Sports",
            questionText: "Which sport is played at Wimbledon?",
            answer1: "Tennis",
            answer2: "Golf",
            answer3: "Soccer",
            answer4: "Cricket",
            correctAnswer: "Tennis"
        )

        let mockData8 = TriviaQuestion(
            questionNumber: 8,
            questionCategory: "Music",
            questionText: "Who is known as the 'King of Pop'?",
            answer1: "Elvis Presley",
            answer2: "Prince",
            answer3: "Michael Jackson",
            answer4: "David Bowie",
            correctAnswer: "Michael Jackson"
        )

        let mockData9 = TriviaQuestion(
            questionNumber: 9,
            questionCategory: "Science",
            questionText: "What is the chemical symbol for oxygen?",
            answer1: "O",
            answer2: "O2",
            answer3: "O3",
            answer4: "OX",
            correctAnswer: "O"
        )

        let mockData10 = TriviaQuestion(
            questionNumber: 10,
            questionCategory: "History",
            questionText: "Which U.S. state is known as the 'Sunshine State'?",
            answer1: "California",
            answer2: "Florida",
            answer3: "Hawaii",
            answer4: "Arizona",
            correctAnswer: "Florida"
        )

        return [mockData1, mockData2, mockData3, mockData4, mockData5, mockData6, mockData7, mockData8, mockData9, mockData10]


    }
    private func displayQuestion(with question: TriviaQuestion) {
        questionNumber.text = "Question: " + String(question.questionNumber) + "/" + String(questions.count)
        questionText.text = question.questionText
        questionCategory.text = "Category: " + question.questionCategory
        answerButton1.setTitle(question.answer1, for: .normal)
        answerButton2.setTitle(question.answer2, for: .normal)
        answerButton3.setTitle(question.answer3, for: .normal)
        answerButton4.setTitle(question.answer4, for: .normal)
        
        }
    

}
