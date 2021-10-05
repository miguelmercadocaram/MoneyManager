//
//  AccountViewController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 10/4/21.
//

import UIKit


class AccountViewController: UIViewController {
    
    var tableView: UITableView!
    
    var personalOptions: [String] = ["Information", "Details", "Changes"]
    var settingsOptions: [String] = ["Contact Us", "Sign Out", "Delete Account"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
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
            iv.image = UIImage(named: "beauty")
            return iv
        }()
        
        let userNameLabel: UILabel = {
            let userName = UILabel()
            userName.text = "Miguel"
            userName.font = UIFont.systemFont(ofSize: 16)
            userName.translatesAutoresizingMaskIntoConstraints = false
            return userName
        }()
        
        let emailLabel: UILabel = {
            let email = UILabel()
            email.text = "Miguel"
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
    
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AccountSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        
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
}
