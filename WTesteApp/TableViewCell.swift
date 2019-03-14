//
//  TableViewCell.swift
//  WTesteApp
//
//  Created by mac on 14/03/19.
//  Copyright © 2019 Wesley S. Favarin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var Profileimage: UIImageView!
    @IBOutlet weak var TutorialName: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
