//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Henry Ingraham on 10/10/23.
//

import Foundation

class TriviaQuestionService {
    static func fetchQuestions(completion: ((CurrentTriviaQuestions) -> Void)? = nil) {
        let parameters = "amount=10&difficulty=easy"
        let url = URL(string: "https://opentdb.com/api.php?\(parameters)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            let questions = parse(data: data)
            // This response will be used to change the UI, so it must happen on the main thread
            DispatchQueue.main.async {
                completion?(questions) // Call the completion closure and pass in the questions data model
            }
        }
        task.resume()
    }
    
    private static func parse(data: Data) -> CurrentTriviaQuestions {
        do {
            let decoder = JSONDecoder()
            let questions = try decoder.decode(CurrentTriviaQuestions.self, from: data)
            return questions
        } catch {
            assertionFailure("Error decoding JSON: \(error)")
            return CurrentTriviaQuestions(results: [])
        }
    }
}
