//
//  NewsViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/29/21.
//

import UIKit

class NewsViewController: UIViewController, NewsManagerDelegate {
  
    
    
    @IBOutlet weak var tableView: UITableView!
   
    var newsManager = NewsManager()
    var newsArray = [NewsModel]()

    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self

        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchTextField.delegate = self
        
       
        
    }
    
    
    func didUpdateNews(_ newsManager: NewsManager, news: [NewsModel]) {
        DispatchQueue.main.async {
            self.newsArray = news
            self.tableView.reloadData()
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
  

    @IBAction func searchPressed(_ sender: UITextField) {
        searchTextField.endEditing(true)
    }
    
}

extension NewsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "Type your topic of interest"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let topic = searchTextField.text {
            newsManager.fetchNews(topic: topic)
            tableView.reloadData()
        }
        searchTextField.text = ""
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        let news = newsArray[indexPath.row]
        cell.title.text = news.title
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsArray[indexPath.row]
        let dataEntriesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailVC") as! DetailNewsViewController
        let nav3 = UINavigationController(rootViewController: dataEntriesVC)
        nav3.view.backgroundColor = .clear
        nav3.modalPresentationStyle = .fullScreen
        
        dataEntriesVC.content = news.content
        
        
        present(nav3, animated: true, completion: nil)
        
    }
}
