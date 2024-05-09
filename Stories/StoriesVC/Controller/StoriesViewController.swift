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
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stories"
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        storiesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        storiesCollectionView.register(StoryCollectionViewCell.nib(), forCellWithReuseIdentifier: StoryCollectionViewCell.identifier)
        loadStories()
    }
    
    func loadStories() {
        guard let storiesURL = Bundle.main.url(forResource: "StoriesList", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: storiesURL)
            let stories = try JSONDecoder().decode([Story].self, from: data)
            self.stories = stories
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}

extension StoriesViewController: UICollectionViewDelegate {
    
}

extension StoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else {return UICollectionViewCell()}
        guard let stories = stories else {fatalError()}
        cell.setup(story: stories[indexPath.row])
        return cell
    }
}

extension StoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = storiesCollectionView.bounds.width
        let itemWidth = collectionViewWidth/2 - 20
        return CGSize(width: itemWidth, height: itemWidth*1.5)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        10
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        storiesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
}
