//
//  ViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 8/23/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var balancesView: UIView!
    @IBOutlet weak var incomeView: UIView!
    @IBOutlet weak var expensesView: UIView!
    
    //outlets for balances
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expensesLabel: UILabel!
    
    var balance: [Balance] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balancesView.layer.cornerRadius = 8
        incomeView.layer.cornerRadius = 8
        expensesView.layer.cornerRadius = 8
        
        //register cell
        tableView.register(UINib(nibName: "BalancesTableViewCell", bundle: nil), forCellReuseIdentifier: "balanceCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        balance = createBalance()
        
    }
    
    func createBalance() -> [Balance] {
        var tempBalance: [Balance] = []
        
        tempBalance.append(Balance(balanceImage: UIImage(named: "expenses"), categoryName: "klkkk", balanceAmount: "89"))
        tempBalance.append(Balance(balanceImage: UIImage(named: "expenses"), categoryName: "klkkk", balanceAmount: "89"))
        tempBalance.append(Balance(balanceImage: UIImage(named: "expenses"), categoryName: "klkkk", balanceAmount: "89"))
        tempBalance.append(Balance(balanceImage: UIImage(named: "expenses"), categoryName: "klkkk", balanceAmount: "89"))
        tempBalance.append(Balance(balanceImage: UIImage(named: "expenses"), categoryName: "klkkk", balanceAmount: "89"))
      
        return tempBalance
    }


}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return balance.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "balanceCell", for: indexPath) as! BalancesTableViewCell
        let balance = balance[indexPath.row]
        
        cell.setBalance(balance: balance)
            
  
       return cell
    }
    
    
}

