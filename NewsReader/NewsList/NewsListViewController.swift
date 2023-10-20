//
//  NewsListViewController.swift
//  NewsReader
//
//  Created by Naela Fauzul Muna on 18/10/23.
//

import UIKit
import SDWebImage

class NewsListViewController: UIViewController {
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var latestNewsList: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup(){
        title = "Berita Indo"
        loadLatestNews()
    }
    
    func loadLatestNews(){
        ApiService.shared.LoadLatestNews{ data in
            switch data {
            case.success(let newsList):
                self.latestNewsList = newsList
                self.tableView.reloadData()
                self.configureCategoryButton()
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
    }
    
    func configureCategoryButton() {
        // Ambil semua kategori yang ada di berita
        let allCategories = Set(latestNewsList.flatMap { $0.categories })

        // Hapus tampilan tombol yang sudah ada
        for subview in categoryButton.subviews {
            subview.removeFromSuperview()
        }

        // Buat tombol untuk setiap kategori
        for category in allCategories {
            let button = UIButton()
            button.setTitle(category, for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blue.cgColor
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            categoryButton.addSubview(button)
        }
    }

    @objc func categoryButtonTapped(_ sender: UIButton) {
        // Handle aksi ketika salah satu tombol kategori ditekan di sini
        if let category = sender.titleLabel?.text {
            // Implementasikan logika untuk menampilkan berita sesuai kategori yang dipilih
            // Anda dapat menggunakan category untuk melakukan filter pada latestNewsList
        }
    }


}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestNewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListTableViewCell

        let news = latestNewsList[indexPath.row]
        cell.titleLabel.text = news.title
        cell.authorLabel.text = news.author
        
        //download image
        if let url = news.image.last?.large {
//            ApiService.shared.downloadImage(from: imageUrl) { result in
//                switch result{
//                case .success(let image):
//                    cell.thumbImageView.image = image
//                case .failure:
//                    cell.thumbImageView.image = nil
//                }
//            }
            
            cell.thumbImageView.sd_setImage(with: URL(string: url))

        } else {
            cell.thumbImageView.image = nil
        }
        

        // formatter untuk tanggal ISO8601
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let isoDate = isoDateFormatter.date(from: news.isoDate) {
            // Buat formatter untuk tanggal akhir
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, MMM d, yyyy HH:mm"
            dateFormatter.locale = Locale(identifier: "id_ID")
            let formattedDate = dateFormatter.string(from: isoDate)
            cell.dateLabel.text = formattedDate
        } else {
            cell.dateLabel.text = "Tanggal Tidak Valid"
        }

        return cell
    }

}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = latestNewsList[indexPath.row]
        
        // Memanggil product list controller
        let storyboard = UIStoryboard(name: "NewsItem", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsItemViewController") as! NewsItemViewController

        // Mengirim data News yang sesuai ke NewsItemViewController
        viewController.selectedNews = news

        navigationController?.pushViewController(viewController, animated: true)
    }
}



