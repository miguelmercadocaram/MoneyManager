//
//  WelcomeViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 10/3/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerBtn.layer.cornerRadius = 10.0
        logInBtn.layer.cornerRadius = 10.0
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "💸 MoneyTracker"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func logInBtnPressed(_ sender: UIButton) {
    }
    

}
