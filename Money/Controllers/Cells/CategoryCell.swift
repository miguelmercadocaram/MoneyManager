//
//  CategoryCell.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/3/21.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    func setCategory(category: Category) {
        categoryImage.image = category.image
        categoryName.text = category.categoryName
    }
    
    
}
