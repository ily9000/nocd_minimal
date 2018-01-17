//
//  ProfileViewController.swift
//  nOCD_minimal
//
//  Created by Ilyas Patanam on 1/9/18.
//  Copyright © 2018 Ilyas Patanam. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrProfile: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        arrProfile = ["Hierarchies", "Compulsions", "Compulsion Prevention Message", "The YBOCS Test"]
        tableView.register(ProfileCell.self)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.alwaysBounceVertical = false
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileCell = tableView.dequeueReusableCell(for: indexPath)
        cell.refresh(title: arrProfile[indexPath.item], rowNum: indexPath.item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProfile.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
}


class ProfileCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refresh(title: String,
                 rowNum: Int){
        self.textLabel?.text = title
        let image = UIImage(named: "profileCell"+String(rowNum))
        self.imageView?.image = image
//        titleLbl.translatesAutoresizingMaskIntoConstraints = false
//        titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
//        titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        titleLbl.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//        titleLbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
}

//Prettify Cells
//Prettify slider

