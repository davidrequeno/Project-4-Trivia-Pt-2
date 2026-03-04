//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by user253906 on 3/4/26.
//

import Foundation

final class TriviaQuestionService {

    static let shared = TriviaQuestionService()
    private init() {}

    private let baseURL = "https://opentdb.com/api.php"

    func fetchQuestions(amount: Int = 10, completion: @escaping (Result<[TriviaQuestion], Error>) -> Void) {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "amount", value: "10"),
            URLQueryItem(name: "category", value: "28")
        ]

        guard let url = components.url else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "NoData", code: -1)))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TriviaResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(response.results)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
}
