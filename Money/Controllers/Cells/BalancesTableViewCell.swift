//
//  BalancesTableViewCell.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 8/26/21.
//

import UIKit

class BalancesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var balanceImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func setBalance(balance: Balance) {
        balanceImageView.image = balance.balanceImage
        categoryLabel.text = balance.categoryName
        amountLabel.text = balance.balanceAmount
    }
    
}
