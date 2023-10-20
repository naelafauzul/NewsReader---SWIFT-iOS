//
//  NewsListTableViewCell.swift
//  NewsReader
//
//  Created by Naela Fauzul Muna on 18/10/23.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(){
        thumbImageView.layer.cornerRadius = 8
        thumbImageView.layer.masksToBounds = true
    }

}
