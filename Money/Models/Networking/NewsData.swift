//
//  NewsData.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/28/21.
//

import Foundation

struct NewsData: Codable {
    let source: [Source]
    let articles: [Article]
    
}

struct Source: Codable {
    let name: String
}

struct Article: Codable {
    let author: String
    let title: String
    let description: String
    let content: String
    
}
