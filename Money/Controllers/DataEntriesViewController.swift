//
//  DataEntriesViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 8/30/21.
//

import UIKit
import CoreData


class DataEntriesViewController: UIViewController {
    
    @IBOutlet weak var entryBalanceView: UIView!
    @IBOutlet weak var accountTypeBtn: UIButton!
    @IBOutlet weak var currencySingLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryLogo: UIImageView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var expensesCategories: [Category] = []
    var incomeCategories: [Category] = []
    
    private let sectionInsets = UIEdgeInsets(
      top: 0,
      left: 2,
      bottom: 0,
      right: 2)
    private let itemsPerRow: CGFloat = 3
    
    var totalBalances = [Balances]()
    var totalExpenses = [Expenses]()
    var totalIncome = [Income]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        entryBalanceView.layer.cornerRadius = 18
        categoryLogo.layer.cornerRadius = categoryLogo.frame.size.width / 2
   
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        expensesCategories = createCategories()
        incomeCategories = createIncomeCategories()
 
        loadBalances()
        
//        deleteAllData("Balances")
//        entityIsEmpty(entity: "Balances")
    
    }
    
  

   
    
    func createCategories() -> [Category] {
        var tempCategory: [Category] = []
        
        tempCategory.append(Category(categoryName: "Food", image: UIImage(named: "food")))
        tempCategory.append(Category(categoryName: "Social Life", image: UIImage(named: "social")))
        tempCategory.append(Category(categoryName: "Transportation", image: UIImage(named: "transportation")))
        tempCategory.append(Category(categoryName: "Self-development", image: UIImage(named: "selfdevelopment")))
        tempCategory.append(Category(categoryName: "Culture", image: UIImage(named: "culture")))
        tempCategory.append(Category(categoryName: "Pet", image: UIImage(named: "pet")))
        tempCategory.append(Category(categoryName: "House", image: UIImage(named: "house")))
        tempCategory.append(Category(categoryName: "Health", image: UIImage(named: "health")))
        tempCategory.append(Category(categoryName: "Beauty", image: UIImage(named: "beauty")))
        tempCategory.append(Category(categoryName: "Education", image: UIImage(named: "education")))
        tempCategory.append(Category(categoryName: "Gift", image: UIImage(named: "gift")))
        tempCategory.append(Category(categoryName: "Other", image: UIImage(named: "other")))
        tempCategory.append(Category(categoryName: "Shopping", image: UIImage(named: "shopping")))
        tempCategory.append(Category(categoryName: "Subscriptions", image: UIImage(named: "subscription")))
      
        
        return tempCategory
        
        
    }
    
    func createIncomeCategories() -> [Category] {
        var tempCategory: [Category] = []
        
        tempCategory.append(Category(categoryName: "Salary", image: UIImage(named: "salary")))
        tempCategory.append(Category(categoryName: "Private", image: UIImage(named: "private")))
        tempCategory.append(Category(categoryName: "Investments", image: UIImage(named: "investments")))
        tempCategory.append(Category(categoryName: "Gift", image: UIImage(named: "gift")))
        tempCategory.append(Category(categoryName: "Other", image: UIImage(named: "other")))
       
        return tempCategory
    }

   

    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func accountTypeBtnPressed(_ sender: UIButton) {
    }
    @IBAction func segmentControllerPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print(sender.selectedSegmentIndex)
            
            entryBalanceView.backgroundColor = .systemRed
            

        }else if sender.selectedSegmentIndex == 1 {
            
            entryBalanceView.backgroundColor = .systemGreen
            print(sender.selectedSegmentIndex)
            

        }
        collectionView.reloadData()
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
    }
    @IBAction func seeAllBtnPressed(_ sender: UIButton) {
    }
    @IBAction func submitBtn(_ sender: UIButton) {
        
        if segmentController.selectedSegmentIndex == 0  {
            let expenses = Double(amountTextField.text!)
            let newExpense = Expenses(context: self.context)
            newExpense.expenses = expenses ?? 20.0
            
            
            self.totalExpenses.append(newExpense)
            
            let newCategoryData = Balances(context: self.context)
            newCategoryData.amount = expenses ?? 0.0
            newCategoryData.categoryName = categoryLabel.text
            let pngImageData  = categoryLogo.image?.pngData()
            newCategoryData.categoryImage = pngImageData
            newCategoryData.date = datePicker.date
            
            self.totalBalances.append(newCategoryData)
            

            
            
            for i in 0..<totalExpenses.count - 1{
                //print(totalExpenses[i].expenseAmount)
                let sumValues = totalExpenses[i].expenses + expenses!
                newExpense.expenses = sumValues
                self.totalExpenses.append(newExpense)
                //print(sumValues)
                
            }
            
          
            
          
            
        }else if segmentController.selectedSegmentIndex == 1 {
           let  income = Double(amountTextField.text!)
            let newIncome = Income(context: self.context)
            newIncome.income = income ?? 10.0
            
            self.totalIncome.append(newIncome)
            
            let newCategoryData = Balances(context: self.context)
            newCategoryData.amount = income ?? 0.0
            newCategoryData.categoryName = categoryLabel.text
            let pngImageData  = categoryLogo.image?.pngData()
            newCategoryData.categoryImage = pngImageData
            newCategoryData.date = datePicker.date
            
            self.totalBalances.append(newCategoryData)
            
       
            
            for i in 0..<totalIncome.count - 1{
                //print(totalExpenses[i].expenseAmount)
                let sumValues = totalIncome[i].income + income!
                newIncome.income = sumValues
                self.totalIncome.append(newIncome)
                //print(sumValues)
            }
            
        }

        self.saveBalances()
        dismiss(animated: true, completion: nil)

        
    }
    
  
    
  
    func saveBalances() {
        do {
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadBalances() {
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        let incomeRequest: NSFetchRequest<Income> = Income.fetchRequest()
        let balancesRequest: NSFetchRequest<Balances> = Balances.fetchRequest()
        do {
            totalExpenses = try context.fetch(request)
            totalIncome = try context.fetch(incomeRequest)
            totalBalances = try context.fetch(balancesRequest)
        } catch {
            print("Error fetching data \(error)")
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func entityIsEmpty(entity: String) -> Bool
    {

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var results : NSArray?

        do {
            results = try context.fetch(request) as! [NSManagedObject] as NSArray
            print(results)
            return results?.count == 0

        } catch let error as NSError {
            // failure
            print("Error: \(error.debugDescription)")
            return true
        }
    }
    
    
    @IBAction func datePickerPressed(_ sender: UIDatePicker) {
      

        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
        let somedateString = dateFormatter.string(from: sender.date)

          
        
    }
    
}

extension DataEntriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentController.selectedSegmentIndex == 0 {
            return expensesCategories.count
        }else {
        
            return incomeCategories.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let expensesCategory = expensesCategories[indexPath.row]
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        if segmentController.selectedSegmentIndex == 0 {
            cell.setCategory(category: expensesCategory)
        }else {
            let incomeCategory = incomeCategories[indexPath.row]
            cell.setCategory(category: incomeCategory)
           
            
        }
        
       
        
        return cell
    }
    


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height/2, height: collectionView.frame.height/2)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentController.selectedSegmentIndex == 0 {
            let category = expensesCategories[indexPath.row]
            categoryLogo.image = category.image
            categoryLabel.text = category.categoryName
        }else {
            let category = incomeCategories[indexPath.row]
            categoryLogo.image = category.image
            categoryLabel.text = category.categoryName
        }
    
    }
    
    
}


