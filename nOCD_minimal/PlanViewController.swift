//
//  PlanViewController.swift
//  nOCD_minimal
//
//  Created by Ilyas Patanam on 1/9/18.
//  Copyright © 2018 Ilyas Patanam. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CircleSliderDelegate {

    var selectedRow = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Plan"
        planTable.dataSource = self
        planTable.delegate = self
        //background Image Bob Furniture
        self.setupViews()
        self.view.backgroundColor = UIColor.white
        
    }
    
    func scrolling(allowed: Bool) {
        planTable.isScrollEnabled = allowed
    }
    
    func setupViews() {
        //setup the bottom background
        view.addSubview(bobFunritureImgView)
        bobFunritureImgView.heightAnchor.constraint(equalToConstant: 212).isActive = true
        bobFunritureImgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bobFunritureImgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //add table view
        view.addSubview(self.planTable)
        planTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        planTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        planTable.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        planTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlanCell = tableView.dequeueReusableCell(for: indexPath)
        cell.refresh()
        if indexPath.item == selectedRow {
            cell.addSlidingTimer()
            cell.timer.delegate = self
        }
        else{
            cell.addFilledCircle()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let bobFunritureImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bobFurniture")
        imageView.alpha = 0.2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
        return imageView
    }()
    
    let planTable: UITableView = {
        let tableView = UITableView()
        tableView.register(PlanCell.self)
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

}

class PlanCell: UITableViewCell {
    
    var timer: CircleSlider!
    static let screenWidth = UIScreen.main.bounds.size.width
    static let deviceScale = screenWidth / 320.0
    static let centerX: CGFloat = 81.5 * PlanCell.deviceScale
    let cellHt: CGFloat = 125 * PlanCell.deviceScale
    
    func refresh(){
        if timer != nil {
            timer?.clear(bounds: self.bounds)
            timer = nil
        }
    }
    
    func addSlidingTimer() {
        timer = CircleSlider()
        let height: CGFloat = self.cellHt - 9 * PlanCell.deviceScale
        let width: CGFloat = height
        let margin: CGFloat = 6
        let linewidth: CGFloat = 12
        timer.makeSlider(frameHeight: height, margin: margin, linewidth: linewidth,
                         handlePadding: 9)
        timer.addLabel()
        
        let offsetX: CGFloat = PlanCell.centerX - width/2
        self.addSubview(timer)
        timer.translatesAutoresizingMaskIntoConstraints = false
        timer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offsetX).isActive = true
        timer.widthAnchor.constraint(equalToConstant: width).isActive = true
        timer.heightAnchor.constraint(equalToConstant: height).isActive = true
        timer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func addFilledCircle(){
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100),
                                      radius: CGFloat(20), startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        //change the fill color
        shapeLayer.fillColor = ColorsManager.salmon.cgColor
        self.layer.addSublayer(shapeLayer)
    }
}
