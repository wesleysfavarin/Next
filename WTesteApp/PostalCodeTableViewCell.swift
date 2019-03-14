//
//  PostalCodeTableViewCell.swift
//  WTesteApp
//
//  Created by mac on 13/03/19.
//  Copyright © 2019 Wesley S. Favarin. All rights reserved.
//

import UIKit

class PostalCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var Nome: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with postalCode: PostalCode)
    {
        local.text = postalCode.cod_localidade
        Nome.text = postalCode.nome_localidade
    }

}
