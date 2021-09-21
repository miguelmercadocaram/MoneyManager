//
//  CategoryViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/6/21.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: [Category] = []
    
    
    
        let inset: CGFloat = 10
       let minimumLineSpacing: CGFloat = 10
       let minimumInteritemSpacing: CGFloat = 10
       let cellsPerRow = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        categories = createCategories()
    }
    
    func createCategories() -> [Category] {
        var tempCategory: [Category] = []
        
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        
        return tempCategory
        
        
    }

 

    @IBAction func dismissBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func editBtn(_ sender: UIButton) {
    }
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        let createCategory = Category(categoryName: "Create New", image: UIImage(systemName: "plus.circle.fill"))
        if indexPath.item == 0 {
            cell.setCategory(category: createCategory)
        }else {
            cell.setCategory(category: category)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            guard let controller3 = storyboard?.instantiateViewController(identifier: "createCategoryVC") else { return  }
            let nav3 = UINavigationController(rootViewController: controller3)
            nav3.modalPresentationStyle = .fullScreen
            present(nav3, animated: true, completion: nil)
        }
    }
    


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    
}

