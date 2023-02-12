//
//  ArticleTableViewCell.swift
//  NewsApp UIKit
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var publishedAtLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
