//
//  NewsCell.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/30/21.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        content.backgroundColor = UIColor(red: 133/255, green: 187/255, blue: 101/255, alpha: 1)
        content.layer.cornerRadius = 10
        
    }
    
    
    
    override func layoutSubviews() {
          super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
      }



}
