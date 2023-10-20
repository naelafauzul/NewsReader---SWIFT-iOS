//
//  ApiService.swift
//  NewsReader
//
//  Created by Naela Fauzul Muna on 17/10/23.
//

import Foundation
import Alamofire
import UIKit

class ApiService {
    static let shared: ApiService = ApiService()
    private init() {}
    
    private let BASE_URL = "https://berita-indo-api-next.vercel.app/api/kumparan-news/"
    
    func LoadLatestNews(completion: @escaping (Result<[News], Error>) -> Void) {
        AF.request(BASE_URL)
            .validate()
            .responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let newsResponse):
                completion(.success(newsResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
            switch response.result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    
    
    
//    func loadNews(completion: @escaping (Result<[News], Error>) -> Void) {
//        if let url = URL(string: BASE_URL) {
//            let request = URLRequest(url: url)
//            
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                
//                DispatchQueue.main.async {
//                    if let err = error {
//                        completion(.failure(err))
//                    } else {
//                        if let data = data {
//                            do {
//                                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
//                                completion(.success(newsResponse.data))
//                            } catch {
//                                completion(.failure(error))
//                            }
//                        } else {
//                            completion(.success([]))
//                        }
//                    }
//                }
//                
//            }
//            task.resume()
//            
//        } else {
//            completion(.success([]))
//        }
//        
//        
//    }
}

