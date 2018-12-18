//
//  TestTableViewCell.swift
//  T2_P_TableView
//
//  Created by 寺先生 on 2018/12/18.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {
 
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
