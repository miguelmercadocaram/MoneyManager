//
//  NewsCell.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/30/21.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var content: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        content.backgroundColor = .orange
        content.layer.cornerRadius = 10
        
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
      }



}
