//
//  DescriptionRepositoryVC.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class DescriptionRepositoryVC: UIViewController {

    public var objectRepository = ObjectRepos()
    
    let activityIndicator   : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = UIColor.black
        return activityIndicator
    }()
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
        }()
    
    let labelName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let labelFullName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let labelDescriptionName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let labelCountStarsForksIssue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let buttonOpenReposSafari : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open in Safari", for: UIControlState.normal)
        button.setTitle("...",     for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(actionButtonOpenReposSafari), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.gray
        button.titleLabel?.textColor = UIColor.black
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let buttonShare : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: UIControlState.normal)
        button.setTitle("...",     for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(actionButtonShare), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.green
        button.titleLabel?.textColor = UIColor.black
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let buttonDelete : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete repository", for: UIControlState.normal)
        button.setTitle("...",     for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(actionButtonDeleteRepo), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.red
        button.titleLabel?.textColor = UIColor.black
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //MARK: life view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        addViewsFromSuperView()
        loadDataLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: load Data VC
    func addViewsFromSuperView() {
        
        
        self.view   .addSubview(scrollView)
        scrollView  .addSubview(contentView)
        contentView .addSubview(labelName)
        contentView .addSubview(labelFullName)
        contentView .addSubview(labelDescriptionName)
        contentView .addSubview(labelCountStarsForksIssue)
        contentView .addSubview(buttonOpenReposSafari)
        contentView .addSubview(buttonShare)
        contentView .addSubview(buttonDelete)
        
        setLayotFromViews()
        
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center

    }
    
    func setLayotFromViews() {
        
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        labelName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        
        labelFullName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        labelFullName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        labelFullName.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10).isActive = true
        
        labelDescriptionName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        labelDescriptionName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        labelDescriptionName.topAnchor.constraint(equalTo: labelFullName.bottomAnchor, constant: 10).isActive = true
        
        labelCountStarsForksIssue.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        labelCountStarsForksIssue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        labelCountStarsForksIssue.topAnchor.constraint(equalTo: labelDescriptionName.bottomAnchor, constant: 10).isActive = true
        
        buttonOpenReposSafari.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        buttonOpenReposSafari.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        buttonOpenReposSafari.topAnchor.constraint(equalTo: labelCountStarsForksIssue.bottomAnchor, constant: 10).isActive = true
        
        buttonShare.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        buttonShare.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        buttonShare.topAnchor.constraint(equalTo: buttonOpenReposSafari.bottomAnchor, constant: 10).isActive = true
        
        buttonDelete.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        buttonDelete.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        buttonDelete.topAnchor.constraint(equalTo: buttonShare.bottomAnchor, constant: 10).isActive = true
        buttonDelete.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func loadDataLabels() {
        labelName.text                  = "Name: " + (objectRepository.stringName as String)
        labelFullName.text              = "Full name: " + (objectRepository.stringFullName as String)
        labelDescriptionName.text       = "Description: " + (objectRepository.stringDescription as String)
        labelCountStarsForksIssue.text  = "Stars: \(objectRepository.stargazersCount)"
                                            + "\nForks: \(objectRepository.forksCount)"
                                            + "\nIssue: \(objectRepository.openIssuesCount)"
    }
    
    // MARK: Selectors
    @objc func actionButtonOpenReposSafari(sender: UIButton) {
        let url = URL(string: objectRepository.stringUrlRepos as String)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    
    @objc func actionButtonShare(sender: UIButton) {
        let textToShare = [objectRepository.stringUrlRepos]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func actionButtonDeleteRepo(sender: UIButton) {
        
        buttonDelete.isEnabled = false
        activityIndicator.startAnimating()

        RequestManager.accessManager.deleteRepository(nameRepos: objectRepository.stringName) { (result) in
            self.buttonDelete.isEnabled = true
            self.activityIndicator.stopAnimating()
            if result == true {
                self.showAlertWithMessage(message: "В течении 1 минуты репозиторий будет удален")
            }
        }
    }
    
    // MARK: Alert
    func showAlertWithMessage(message:String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
