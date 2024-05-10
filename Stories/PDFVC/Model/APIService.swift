//
//  APIService.swift
//  Stories
//
//  Created by Mohamed Mostafa on 10/05/2024.
//

import Foundation

class APIService {
    
    static let shared = APIService()

    func downloadPDF(for story: Story, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = URL(string: story.url) else {return}
        let task = URLSession.shared.downloadTask(with: url) { (tempURL, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "Download", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to download PDF"])))
                return
            }

            guard let tempURL = tempURL else {
                completion(.failure(NSError(domain: "Download", code: -1, userInfo: [NSLocalizedDescriptionKey: "No temporary file URL"])))
                return
            }

            do {
                let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let destinationURL = documentsURL.appendingPathComponent("\(story.title).pdf")
                try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                completion(.success(destinationURL))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
}
