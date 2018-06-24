//
//  UserReposVC.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class UserReposVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let NotificationsLoadDataReposUser = Notification.Name.init("NotificationsLoadDataReposUser")

    let tableViewRepos = UITableView ()
    var arrayDataTable = NSArray()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(actionRefreshTableViewRepos),for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       addTableViewRepos()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sendRequesGetAllRepos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Load data VC
    func addTableViewRepos() {
        self.view.addSubview(tableViewRepos)
        tableViewRepos.addSubview(refreshControl)

        
        tableViewRepos.delegate = self
        tableViewRepos.dataSource = self
        tableViewRepos.register(UINib(nibName: "CellRepos", bundle: nil), forCellReuseIdentifier: "reuseCellRepos")
        tableViewRepos.tableFooterView = UIView(frame: .zero)
        
        tableViewRepos.translatesAutoresizingMaskIntoConstraints = false
        tableViewRepos.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableViewRepos.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableViewRepos.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableViewRepos.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        
    }
    
    func sendRequesGetAllRepos() {
        RequestManager.accessManager.getReposUser { (success, arrayObjectsRepos) in
            if (success){
                self.arrayDataTable = arrayObjectsRepos as NSArray
                self.tableViewRepos.reloadData()
            }
        }
    }
    
    // MARK: Selectors
    @objc func actionRefreshTableViewRepos(sender: UIButton) {
        self.sendRequesGetAllRepos()
        refreshControl.endRefreshing()
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDataTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reuseCellRepos"
        var cell: CellRepository! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CellRepository
        
        if cell == nil {
            tableView.register(UINib(nibName: "CellRepos", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CellRepository
        }
        
        let repos : ObjectRepos = arrayDataTable.object(at: indexPath.row) as! ObjectRepos
        
        cell.labelCaption.text      = repos.stringName as String
        cell.labelLanguage.text     = repos.stringLanguage as String
        cell.labelDateRepos.text    = repos.dateLastUpdate.dateToString()
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
     
        let repos : ObjectRepos = arrayDataTable.object(at: indexPath.row) as! ObjectRepos
        
        let descRepoVC =  DescriptionRepositoryVC()
        descRepoVC.objectRepository = repos
        
        self.navigationController?.pushViewController(descRepoVC, animated: true)
    }
}
