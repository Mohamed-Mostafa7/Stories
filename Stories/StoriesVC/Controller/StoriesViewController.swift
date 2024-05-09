//
//  StoriesViewController.swift
//  Stories
//
//  Created by Mohamed Mostafa on 09/05/2024.
//

import UIKit

class StoriesViewController: UIViewController {
    
    var stories: [Story]? {
        didSet {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stories"
        loadStories()
    }
    
    func loadStories() {
        print("load Stories began")
        guard let storiesURL = Bundle.main.url(forResource: "StoriesList", withExtension: "json") else { return }
        do {
            print("I'm here")
            let data = try Data(contentsOf: storiesURL)
            let stories = try JSONDecoder().decode([Story].self, from: data)
            self.stories = stories
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
