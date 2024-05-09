//
//  StoryCollectionViewCell.swift
//  Stories
//
//  Created by Mohamed Mostafa on 09/05/2024.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StoryCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "StoryCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak private var image: UIImageView!
    @IBOutlet weak private var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(story: Story) {
        image.image = UIImage(named: story.imageName)
        title.text = story.title
    }

}
