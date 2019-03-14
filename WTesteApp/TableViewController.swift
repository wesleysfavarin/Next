//
//  TableViewController.swift
//  WTesteApp
//
//  Created by mac on 14/03/19.
//  Copyright © 2019 Wesley S. Favarin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var Data = [["Name":"Wesley S. Favarin Developer iOS Swift 4.2 Xcode 10","Date":"09/03.","TutorialImageName":"El Capitan"],
                ["Name":"Wesley S. Favarin Developer iOS Swift 4.2 Xcode 10","Date":"2 Days.","TutorialImageName":"El Capitan"]]
    
    var Headerview : UIView!
    var NewHeaderLayer : CAShapeLayer!
    
    private let Headerheight : CGFloat = 420
    private let Headercut : CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UpdateView()
    }
    func UpdateView() {
        tableView.backgroundColor = UIColor.white
        Headerview = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(Headerview)
        
        NewHeaderLayer = CAShapeLayer()
        NewHeaderLayer.fillColor = UIColor.black.cgColor
        Headerview.layer.mask = NewHeaderLayer
        
        let newheight = Headerheight - Headercut / 2
        tableView.contentInset = UIEdgeInsets(top: newheight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newheight)
        
        self.Setupnewview()
    }
    func Setupnewview() {
        let newheight = Headerheight - Headercut / 2
        var getheaderframe = CGRect(x: 0, y: -newheight, width: tableView.bounds.width, height: Headerheight)
        if tableView.contentOffset.y < newheight
        {
            getheaderframe.origin.y = tableView.contentOffset.y
            getheaderframe.size.height = -tableView.contentOffset.y + Headercut / 2
        }
        
        Headerview.frame = getheaderframe
        let cutdirection = UIBezierPath()
        cutdirection.move(to: CGPoint(x: 0, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: getheaderframe.height))
        cutdirection.addLine(to: CGPoint(x: 0, y: getheaderframe.height - Headercut))
        NewHeaderLayer.path = cutdirection.cgPath
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.Setupnewview()
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Tableview Methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let IndexPath = Data[indexPath.row]
        cell.DateLabel.text = IndexPath["Date"]
        cell.TutorialName.text = IndexPath["Name"]
        cell.Profileimage.image = UIImage(named: IndexPath["TutorialImageName"]!)
        return cell
    }
}
