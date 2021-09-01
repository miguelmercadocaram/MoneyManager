//
//  DataEntriesViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 8/30/21.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        entryBalanceView.layer.cornerRadius = 18
        
    }


   

    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func accountTypeBtnPressed(_ sender: UIButton) {
    }
    @IBAction func segmentControllerPressed(_ sender: UISegmentedControl) {
    }
    @IBAction func seeAllBtnPressed(_ sender: UIButton) {
    }
    @IBAction func submitBtn(_ sender: UIButton) {
    }
}


