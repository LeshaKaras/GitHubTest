//
//  UserProfileVC.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    static let NotificationsLoadDataUser = Notification.Name.init("NotificationsLoadDataUser")
    
    var objectUser = ObjectUser()
    
    let labelName : UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    let labelMail : UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageViewAvatar : UIImageView = {
        let imegeView = UIImageView(image: UIImage.init(named: "placeholderAvatar"))
        imegeView.clipsToBounds = true
        imegeView.translatesAutoresizingMaskIntoConstraints = false
        return imegeView
    }()
    
    let buttonOpenInGit : UIButton = {
        let button = UIButton()
        button.setTitle("Open in Git", for: UIControlState.normal)
        button.setTitle("...",     for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(actionButtonOpenGit), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.gray
        button.titleLabel?.textColor = UIColor.black
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: view life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UserProfileVC.infoAboutUserIsLoad),
                                               name: UserProfileVC.NotificationsLoadDataUser,
                                               object: nil)
        
        addSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RequestManager.accessManager.getInfoAboutUser { (objUser) in
        self.objectUser = objUser
        NotificationCenter.default.post(name: UserProfileVC.NotificationsLoadDataUser, object: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: add Views
    private func addSubviews(){
        self.view.addSubview(imageViewAvatar)
        self.view.addSubview(labelName)
        self.view.addSubview(labelMail)
        self.view.addSubview(buttonOpenInGit)
        
        setupLayout()
    }
    
    //MARK: LoadLayout
    private func setupLayout(){
        
        imageViewAvatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewAvatar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewAvatar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        let topIndentation : CGFloat = (self.navigationController?.toolbar.isHidden)! ? 80.0 : 30.0
        imageViewAvatar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topIndentation).isActive = true
        
        labelName.topAnchor.constraint(equalTo: imageViewAvatar.topAnchor, constant: 0).isActive = true
        labelName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        labelName.trailingAnchor.constraint(equalTo: imageViewAvatar.leadingAnchor, constant: 0).isActive = true
        
        labelMail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 0).isActive = true
        labelMail.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        labelMail.trailingAnchor.constraint(equalTo: imageViewAvatar.leadingAnchor, constant: 0).isActive = true
        
        buttonOpenInGit.trailingAnchor.constraint(equalTo: imageViewAvatar.trailingAnchor, constant: 0).isActive = true
        buttonOpenInGit.leadingAnchor.constraint(equalTo: imageViewAvatar.leadingAnchor, constant: 0).isActive = true
        buttonOpenInGit.topAnchor.constraint(equalTo: imageViewAvatar.bottomAnchor, constant: 0).isActive = true
        buttonOpenInGit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    // MARK: Selectors
    @objc func actionButtonOpenGit(sender: UIButton) {
        
        if (objectUser.stringUrlGit.length > 0){
            let url = URL(string: objectUser.stringUrlGit as String)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }
        }
    }
    
    @objc func infoAboutUserIsLoad(sender: UIButton) {
        
        self.labelName.text = objectUser.stringName as String
        self.labelMail.text = objectUser.stringMail as String
        
        let url = URL(string: objectUser.stringAvatarUrl as String)
        let data = try? Data(contentsOf: url!)
        if (data != nil){
            self.imageViewAvatar.image = UIImage(data: data!)
        }
    }
}
