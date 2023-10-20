//
//  NewsItemViewController.swift
//  NewsReader
//
//  Created by Naela Fauzul Muna on 18/10/23.
//

import UIKit

class NewsItemViewController: UIViewController {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var thumbImage: UIImageView!
    var selectedNews: News? // Menambahkan properti untuk menyimpan data News

        override func viewDidLoad() {
            super.viewDidLoad()
            setup()
        }

        func setup() {
            if let news = selectedNews {
                // Mengatur teks authorLabel dengan data dari selectedNews
                authorLabel.text = news.author
                titleLabel.text = news.title
                descriptionLabel.text = news.description
                dateLabel.text = news.isoDate
                
                //download image
                if let url = news.image.last?.large {
                    thumbImage.sd_setImage(with: URL(string: url))

                } else {
                    thumbImage.image = nil
                }

                if !news.categories.isEmpty {
                    let categoriesText = news.categories.joined(separator: ", ")
                    categoryLabel.text = categoriesText
                } else {
                    categoryLabel.text = "Tidak ada kategori"
                }
            }
        }
    }
