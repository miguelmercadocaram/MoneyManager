//
//  NewsManager.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/28/21.
//

import Foundation

//https://newsapi.org/v2/from=2021-08-29&sortBy=publishedAt&apiKey=5d33f65acad6453d92760e7c0fa0a89d&everything?q=tesla

// apikey = 5d33f65acad6453d92760e7c0fa0a89d
//tesla&from=2021-08-29&sortBy=publishedAt&apiKey=5d33f65acad6453d92760e7c0fa0a89d
protocol NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager, news: [NewsModel])
    func didFailWithError(error: Error)
}
struct NewsManager {
    let newsURL = "https://newsapi.org/v2/everything?from=2021-09-03&sortBy=publishedAt&apiKey=5d33f65acad6453d92760e7c0fa0a89d"
    var delegate: NewsManagerDelegate?
    func fetchNews(topic: String) {
        let urlString = "\(newsURL)&q=\(topic)"
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let news = self.parseJSON(safeData) {
                        self.delegate?.didUpdateNews(self, news: news)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ newsData: Data) -> [NewsModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsData.self, from: newsData)
            var news = [NewsModel]()
            
            for i in 0..<decodedData.articles.count {
                let title = decodedData.articles[i].title
                let description = decodedData.articles[i].description
                let content = decodedData.articles[i].content
              
                news.append(NewsModel(title: title, description: description, content: content))
                
                
            }
            
           return news
            
           
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        return nil
    }
    
}
