//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Henry Ingraham on 10/3/23.
//
import UIKit
import Foundation

struct CurrentTriviaQuestion: Codable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
