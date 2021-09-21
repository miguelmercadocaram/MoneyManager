//
//  ColorCell.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/10/21.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
////        colorView.layer.cornerRadius = colorView.frame.size.width / 2
////        colorView.layer.cornerRadius = colorView.frame.size.height / 2
//
//        colorView.layer.cornerRadius = min(colorView.frame.size.height, colorView.frame.size.width) / 2.0
//
//        colorView.layer.masksToBounds = true
//        colorView.clipsToBounds = true
//
//        colorView.layer.borderColor = UIColor.white.cgColor
//        colorView.layer.borderWidth = 2
//
//        print(colorView.frame.size.height)
//        print(colorView.frame.size.width)
//
//    }
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
          self.layer.cornerRadius = self.frame.size.width / 2
      }
    
    func setColors(colors: Colors) {
       
        colorView.backgroundColor = colors.colorView
    }
    
}
