//
//  ReportsViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 9/27/21.
//

import UIKit
import CoreData

class ReportsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var balance = [[Balances]]()
    var balanceFromServer = [Balances]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 133/255, green: 187/255, blue: 101/255, alpha: 1)
        navigationItem.title = "Reports"
        
        searchBar.backgroundColor = .lightGray
        searchBar.layer.cornerRadius = 10
        
        balance.removeAll()
        loadBalances()
        
        tableView.register(UINib(nibName: "BalancesTableViewCell", bundle: nil), forCellReuseIdentifier: "balanceCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        attempToAssembleGroupBalances()
        searchBar.delegate = self
        
    }
    
    func attempToAssembleGroupBalances() {
        let groupBalances = Dictionary(grouping: balanceFromServer) { (element) -> Date in
           
            return element.date ?? Date()
        }
        
        let sortedKeys = groupBalances.keys.sorted()
        sortedKeys.forEach { key in
        var values = groupBalances[key]
            
            balance.append(values ?? [])
           
            }
        }
    
    func saveBalances() {
        do {
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }
    }


    func loadBalances() {
        let balancesRequest: NSFetchRequest<Balances> = Balances.fetchRequest()
//        let sort = NSSortDescriptor(key: #keyPath(Balances.date), ascending: true)
//            balancesRequest.sortDescriptors = [sort]
        do {
            
            balanceFromServer = try context.fetch(balancesRequest)
        } catch {
            print("Error fetching data \(error)")
        }
    }

}

extension ReportsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Balances> = Balances.fetchRequest()
        let predicate = NSPredicate(format: "categoryName CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        let sortDescriptors = NSSortDescriptor(key: "categoryName", ascending: true)
        
        request.sortDescriptors = [sortDescriptors]
        
        
        do {
            balanceFromServer = try context.fetch(request)
            balance.removeAll()
            attempToAssembleGroupBalances()
            tableView.reloadData()
            print(balance)
          
        }catch {
            print("Error fetching data \(error)")
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadBalances()
            balance.removeAll()
            attempToAssembleGroupBalances()
            tableView.reloadData()
            DispatchQueue.main.async {
                self.searchBar.resignFirstResponder()
            }
        }
    }
}

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return balance.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if let firstDate = balance[section].first {
            let label = DateHeaderLabel()
            label.backgroundColor = .black
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"

            let dateString = dateFormatter.string(from: firstDate.date ?? Date())


            label.text = dateString
            label.textColor = .white
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
}
