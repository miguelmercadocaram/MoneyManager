//
//  NewsViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/29/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsManager = NewsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self
        newsManager.fetchNews(topic: "tesla")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newsManager.fetchNews(topic: "tesla")
    }


}

extension NewsViewController: UITextFieldDelegate {

}

extension NewsViewController: NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager, news: NewsModel) {
        DispatchQueue.main.async {
            print(news.description)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
