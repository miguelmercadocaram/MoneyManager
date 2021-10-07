//
//  AccountViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 10/4/21.
//

import UIKit
import Firebase
import GoogleSignIn
import MessageUI
import CoreData

class AccountViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var tableView: UITableView!
    
    var personalOptions: [String] = ["Update Profile", "Delete Balance", "Touch ID / Face ID"]
    var settingsOptions: [String] = ["Contact Us", "Sign Out", "Delete Account"]
    
    let user = Auth.auth().currentUser
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 133/255, green: 187/255, blue: 101/255, alpha: 1)
        navigationItem.title = "Account"
        
       configureTableView()
        
        
    }
    
    func profileView() -> UIView {
        let profileView = UIView()
        
        let profileImageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.load(url: user?.photoURL ?? URL(fileURLWithPath: ""))
            return iv
        }()
        
        let userNameLabel: UILabel = {
            let userName = UILabel()
            userName.text = user?.displayName
            userName.font = UIFont.systemFont(ofSize: 16)
            userName.translatesAutoresizingMaskIntoConstraints = false
            return userName
        }()
        
        let emailLabel: UILabel = {
            let email = UILabel()
            email.text = user?.email
            email.font = UIFont.systemFont(ofSize: 14)
            email.textColor = .lightGray
            email.translatesAutoresizingMaskIntoConstraints = false
            return email
        }()
        
        //profile
        
        let profileImageDimension: CGFloat = 60
        
        profileView.frame = CGRect(x: 0, y: 90, width: view.frame.width, height: 100)
        
        profileView.addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        
        profileView.addSubview(userNameLabel)
        userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        profileView.addSubview(emailLabel)
        emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        return profileView
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(AccountCell.self, forCellReuseIdentifier: "accountCell")
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.tableHeaderView = profileView()
        tableView.tableFooterView = UIView()
        
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["example@ula.com"])
           
            

            present(mail, animated: true)
        } else {
            // show failure alert
            print("failed")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func saveBalances() {
        do {
            try context.save()
        }catch {
            print("Error saving context \(error)")
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

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AccountSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 133/255, green: 187/255, blue: 101/255, alpha: 1)
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = AccountSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = AccountSection(rawValue: section) else {return 0}
        
    
        switch section {
        case .Personal:
            return personalOptions.count
        case .Settings:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personalOps = personalOptions[indexPath.row]
        let settingsOps = settingsOptions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! AccountCell
        guard let section = AccountSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .Personal:
            cell.textLabel?.text = personalOps
        case .Settings:
            cell.textLabel?.text = settingsOps
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                print(indexPath.row)
            case 1:
                let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
                    self.deleteAllData("Balances")
                    self.saveBalances()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert, animated: true, completion: nil)
            case 2:
                print(indexPath.row)
            default:
                break
            }
        }else {
            switch indexPath.row {
            case 0:
                sendEmail()
            
            case 1:    let firebaseAuth = Auth.auth()
                dismiss(animated: true, completion: nil)
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
               
            case 2:
                let user = Auth.auth().currentUser

                user?.delete { error in
                  if let error = error {
                    print(error)
                  } else {
                    print("account is deleted")
                    self.dismiss(animated: true, completion: nil)
                  }
                }
            default:
                break
            }
        }
        
        
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
