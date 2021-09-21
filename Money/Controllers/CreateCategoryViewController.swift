//
//  CreateCategoryViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/8/21.
//

import UIKit

class CreateCategoryViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var iconCategoryCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    
    let topView = UIView()
    
    let dismissBtn: UIButton = {
        let dismissBtn = UIButton(type: .system)
        dismissBtn.frame = CGRect(x: 30, y: 40, width: 30, height: 30)
        dismissBtn.layer.cornerRadius = 8
        dismissBtn.tintColor = UIColor.white
        dismissBtn.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        dismissBtn.setTitle("X", for: .normal)
        dismissBtn.titleLabel?.font = .systemFont(ofSize: 18)
        return dismissBtn
        
    }()
    
    let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.frame = CGRect(x: 110, y: 120, width: 200, height: 100)
        categoryLabel.text = "Category"
        categoryLabel.textColor = UIColor.white
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 22)
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .center
        return categoryLabel
    }()
    var colors: [Colors] = []
    var categories: [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        iconCategoryCollectionView.delegate = self
        iconCategoryCollectionView.dataSource = self
        colors = createColors()
        submitBtn.layer.cornerRadius = 8
        scrollView.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: true)
       
        scrollView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        
        setupImageView()
        
        containerView.layer.cornerRadius = 18
        view.addSubview(dismissBtn)
        topView.addSubview(categoryLabel)
        
        categories = createCategories()
        
        dismissBtn.addTarget(self, action: #selector(dismissBtnPressed), for: .touchUpInside)
        
    }
    
    @objc func dismissBtnPressed() {
        dismiss(animated: true, completion: nil)
    }
    func createColors() -> [Colors] {
        var tempColors: [Colors] = []
        
        tempColors.append(Colors(colorView: UIColor.red))
        tempColors.append(Colors(colorView: UIColor.blue))
        tempColors.append(Colors(colorView: UIColor.green))
        tempColors.append(Colors(colorView: UIColor.systemPink))
        tempColors.append(Colors(colorView: UIColor.red))
        tempColors.append(Colors(colorView: UIColor.blue))
        tempColors.append(Colors(colorView: UIColor.green))
        tempColors.append(Colors(colorView: UIColor.systemPink))
        tempColors.append(Colors(colorView: UIColor.red))
        tempColors.append(Colors(colorView: UIColor.blue))
        tempColors.append(Colors(colorView: UIColor.green))
        tempColors.append(Colors(colorView: UIColor.systemPink))
        
       
        
        return tempColors
        
        
    }
    
    func setupImageView() {
        view.addSubview(topView)
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        topView.frame = rect
        topView.backgroundColor = UIColor.systemPink
        topView.contentMode = .scaleAspectFill
     
     
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 200 - (scrollView.contentOffset.y + 200)
        
        let h = max(120, y)
        let h2 = max(170, y)

        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
        let rect2 = CGRect(x: 0, y: 0, width: view.bounds.width, height: h2)
        
        topView.frame = rect
        categoryLabel.frame = rect2
    }
 
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
    }
}

extension CreateCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorCollectionView {
            return colors.count
        }else {
            return categories.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.colorCollectionView {
            let color = colors[indexPath.row]
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorCell
            let createColor = Colors(colorView: UIColor.black)
            
            
                if indexPath.item == 0 {
                    cellA.setColors(colors: createColor)
                    print("loaded item 0")
                }else {
                    cellA.setColors(colors: color)
                    print("loaded")
                }
                
                
                return cellA
        }else {
            let category = categories[indexPath.row]
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! CategoryCell
            cellB.setCategory(category: category)
            
            return cellB
        }
        
        
   
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            guard let controller3 = storyboard?.instantiateViewController(identifier: "createCategoryVC") else { return  }
            let nav3 = UINavigationController(rootViewController: controller3)
            nav3.modalPresentationStyle = .fullScreen
            present(nav3, animated: true, completion: nil)
        }
    }
    


//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return minimumLineSpacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return minimumInteritemSpacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
//        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
    
    
}



