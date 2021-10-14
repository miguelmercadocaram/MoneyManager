//
//  ViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 8/23/21.
//

import UIKit
import CoreData

class DateHeaderLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        textColor = .white
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.boldSystemFont(ofSize: 14)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalContentSize.width + 20, height: height)
    }
}

class HomeViewController: UIViewController {
  
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var balancesView: UIView!
    @IBOutlet weak var incomeView: UIView!
    @IBOutlet weak var expensesView: UIView!
    
    //outlets for balances
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expensesLabel: UILabel!
    

    
    var balanceFromServer = [Balances]()
    var balance = [[Balances]]()
    
   
    
    var totalExpenses = [Expenses]()
    var totalIncome = [Income]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var totalBalance = 0.0
    var expenseNumber = 0.0
    var incomeNumber = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        
        balancesView.layer.cornerRadius = 8
        incomeView.layer.cornerRadius = 8
        expensesView.layer.cornerRadius = 8
        
        //register cell
        tableView.register(UINib(nibName: "BalancesTableViewCell", bundle: nil), forCellReuseIdentifier: "balanceCell")
        tableView.dataSource = self
        tableView.delegate = self
        

        
        for i in 0..<totalExpenses.count {
            expenseNumber = totalExpenses[i].expenses
            expensesLabel.text = "\(totalExpenses[i].expenses)"

        }
        
        for i in 0..<totalIncome.count {
            incomeNumber = totalIncome[i].income
            incomeLabel.text = "\(totalIncome[i].income)"
        }
        
        
    }

    func attempToAssembleGroupBalances() {
        let groupBalances = Dictionary(grouping: balanceFromServer) { (element) -> Date in
           
            return element.date ?? Date()

        }
        
        let sortedKeys = groupBalances.keys.sorted()
        sortedKeys.forEach { key in
            var values = groupBalances[key]
            
            balance.append(values ?? [])
            print(balance.count)
            }
           
            
        }

    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        balance.removeAll()
        loadBalances()
//        deleteAllData("Balances")
//        balance.removeAll()
//        saveBalances()
        
     
        for i in 0..<totalExpenses.count {
            expenseNumber = totalExpenses[i].expenses
            expensesLabel.text = "$\(totalExpenses[i].expenses)"

        }
        for i in 0..<totalIncome.count {
            incomeNumber = totalIncome[i].income
            incomeLabel.text = "$\(totalIncome[i].income)"
        }
      
        totalBalance = incomeNumber - expenseNumber
        balanceLabel.text = "$\(totalBalance)"
       
            attempToAssembleGroupBalances()
            tableView.reloadData()
        
        
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
    
//        let sort = NSSortDescriptor(key: #keyPath(Balances.date), ascending: true)
//            balancesRequest.sortDescriptors = [sort]
        do {
            totalExpenses = try context.fetch(request)
            totalIncome = try context.fetch(incomeRequest)
            balanceFromServer = try context.fetch(balancesRequest)
            
        } catch {
            print("Error fetching data \(error)")
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
  
 
    



}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return balance.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if let firstDate = balance[section].first {
            let label = DateHeaderLabel()
            label.backgroundColor = .lightGray
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"

            let dateString = dateFormatter.string(from: firstDate.date ?? Date())


            label.text = dateString
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false

            let containerView = UIView()

            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

            return containerView
        }
       return nil
        }
    
   
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return balance[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "balanceCell", for: indexPath) as! BalancesTableViewCell
        let balance = balance[indexPath.section][indexPath.row]
        
        cell.setBalance(balance: balance)
        
        
        if balance.isExpense == true {
            cell.amountLabel.textColor = .systemRed
        }else {
            cell.amountLabel.textColor = .systemGreen
        }
       

  
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let balance = balance[indexPath.section][indexPath.row]
        print(balance)
        let dataEntriesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DEViewController") as! DataEntriesViewController
        let nav3 = UINavigationController(rootViewController: dataEntriesVC)
        nav3.view.backgroundColor = .clear
        nav3.modalPresentationStyle = .fullScreen

      
        for i in 0..<balanceFromServer.count {
            
            if balance.id == balanceFromServer[i].id {
               
                print(i)
                dataEntriesVC.count = i
                print(balanceFromServer[i])
            }else {
                print("not matched")
            }
        }
        
        dataEntriesVC.amountTemp = "\(balance.amount)"
        dataEntriesVC.categoryTemp = balance.categoryName ?? ""
        let dataImage = UIImage(data: balance.categoryImage ?? Data())
        dataEntriesVC.imgTemp = dataImage ?? UIImage()
        dataEntriesVC.update = true
        dataEntriesVC.dateTemp = balance.date ?? Date()
        
        present(nav3, animated: true, completion: nil)
        

    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            var count = 0


            for i in 0..<balanceFromServer.count {
                let balance = balance[indexPath.section][indexPath.row]
                if balance.id == balanceFromServer[i].id {


                    count = i

                }else {
                    print("not matched")
                }
            }

            self.context.delete(balanceFromServer[count])
            saveBalances()
            balance.removeAll()
            loadBalances()
            attempToAssembleGroupBalances()
            tableView.reloadData()
         

        }
    }
    
    
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
        
    }
}

