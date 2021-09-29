//
//  NewsData.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/28/21.
//

import Foundation

struct NewsData: Codable {

    let articles: [Articles]
    
}

struct Articles: Codable {
    let source: Source
    let title: String
    let description: String
    let content: String


}



struct Source: Codable {
    let name: String
}
