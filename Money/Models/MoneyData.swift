//
//  MoneyData.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 8/23/21.
//

import Foundation
import UIKit

struct MoneyData {
    let date: Date
    let account: [Account]
    let category: [Category]
    var amount: Double
    let note: String
}

struct Account {
    let name: String
}

struct Category {
    var categoryName: String? = nil
    let image: UIImage!
}

struct Colors {
    let colorView: UIColor
}



