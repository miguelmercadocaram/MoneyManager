//
//  AccountSection.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 10/5/21.
//

enum AccountSection: Int, CaseIterable, CustomStringConvertible {
    case Personal
    case Settings
    
    var description: String {
        switch self {
        case .Personal:
            return "Personal"
        case .Settings:
            return "Settings"
        }
    }
}
