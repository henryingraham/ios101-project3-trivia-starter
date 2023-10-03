//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Henry Ingraham on 10/3/23.
//
import UIKit
import Foundation

struct TriviaQuestion {
    let questionNumber: Int
    let questionCategory: String
    let questionText: String
    let answer1: String
    let answer2: String
    let answer3: String
    let answer4: String
    let correctAnswer: String
}

enum CorrectAnswer: Int {
    case answer1 = 1
    case answer2 = 2
    case answer3 = 3
    case answer4 = 4
}
