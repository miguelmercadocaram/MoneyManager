//
//  NewsViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/29/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var newsManager = NewsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self
        newsManager.fetchNews(topic: "tesla")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
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

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
