import UIKit

import Foundation

struct AstronautResponse: Codable {
    let message: String
    let number: Int
    let people: [Astronaut]
}

struct Astronaut: Codable {
    let craft: String
    let name: String
}

func getAstronauts(completion: @escaping (Result<AstronautResponse, Error>) -> Void) {
    let urlString = "http://api.open-notify.org/astros.json"
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let data = data else {
            completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
            return
        }
        guard let astronautResponse = try? JSONDecoder().decode(AstronautResponse.self, from: data) else {
            completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode JSON data"])))
            return
        }
        completion(.success(astronautResponse))
    }
    task.resume()
}

// Beispiel-Aufruf
getAstronauts { result in
    switch result {
    case .success(let astronautResponse):
        print(astronautResponse.people)
    case .failure(let error):
        print(error.localizedDescription)
    }
}

