//
//  TableViewCell.swift
//  EastHighschoolLibrary
//
//  Created by Kevin Wang on 3/1/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
