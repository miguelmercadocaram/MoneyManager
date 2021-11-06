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

    func setBalance(balance: Balances) {
        //let pngImageData  = balance.image?.pngData()
        balanceImageView.image = UIImage(data: balance.categoryImage ?? Data())
        categoryLabel.text = balance.categoryName
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let formattedNumber = numberFormatter.string(from: NSNumber(value:balance.amount))
        amountLabel.text = formattedNumber
        
    }
    
    
}
