//
//  TextViewTableViewCell.swift
//  WTesteApp
//
//  Created by mac on 14/03/19.
//  Copyright © 2019 Wesley S. Favarin. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var Nome: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   func prepare(with nome: String){
          Nome.text = nome
    }
}
