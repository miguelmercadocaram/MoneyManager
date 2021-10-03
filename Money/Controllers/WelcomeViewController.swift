//
//  WelcomeViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 10/3/21.
//

import UIKit
import Firebase
import GoogleSignIn


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    
    @IBOutlet weak var signInView: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleBtn.layer.cornerRadius = 10.0
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
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let e = error {
                    print(e)
                }else {
                    guard let controller3 = storyboard?.instantiateViewController(identifier: "tabController") else { return  }
                    let nav3 = UINavigationController(rootViewController: controller3)
                    nav3.view.backgroundColor = .clear
                    nav3.modalPresentationStyle = .fullScreen
                    present(nav3, animated: true, completion: nil)
                }
            }
            

          // ...
        }
    }
    
    @IBAction func logInBtnPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Login with email", message: "Please enter your email and password", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }
        alert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        let loginAction = UIAlertAction(title: "Login", style: .default) { _ in
            guard let emailField = alert.textFields![0].text else { return }
            guard let passwordField = alert.textFields![1].text else { return }
            
            Auth.auth().signIn(withEmail: emailField, password: passwordField) { authResult, error in
                if let e = error {
                    print(e)
                }else {
                    guard let controller3 = self.storyboard?.instantiateViewController(identifier: "tabController") else { return  }
                    let nav3 = UINavigationController(rootViewController: controller3)
                    nav3.view.backgroundColor = .clear
                    nav3.modalPresentationStyle = .fullScreen
                    self.present(nav3, animated: true, completion: nil)
                }
            }
        }
        
        let signUpAction = UIAlertAction(title: "SignUp", style: .default) { _ in
            guard let emailField = alert.textFields![0].text else { return }
            guard let passwordField = alert.textFields![1].text else { return }
            
            Auth.auth().createUser(withEmail: emailField, password: passwordField) { authResult, error in
                if let e = error {
                    print(e)
                }else {
                    guard let controller3 = self.storyboard?.instantiateViewController(identifier: "tabController") else { return  }
                    let nav3 = UINavigationController(rootViewController: controller3)
                    nav3.view.backgroundColor = .clear
                    nav3.modalPresentationStyle = .fullScreen
                    self.present(nav3, animated: true, completion: nil)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          alert.addAction(loginAction)
          alert.addAction(signUpAction)
          alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
