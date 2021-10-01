//
//  DetailNewsViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 10/1/21.
//

import UIKit

class DetailNewsViewController: UIViewController {

 
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var dismissBtn: UIButton!
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.text = content
        
        
    }
    
    @IBAction func dismissBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
 

}
