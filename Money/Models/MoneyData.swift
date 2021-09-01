//
//  MoneyData.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 8/23/21.
//

import Foundation

struct MoneyData {
    let date: Date
    let account: [Account]
    let category: [Category]
    let amount: Double
    let note: String
}

struct Account {
    let name: String
}

struct Category {
    let category: String
}
