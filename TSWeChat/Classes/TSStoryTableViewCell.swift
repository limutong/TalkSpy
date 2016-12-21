//
//  TSStoryTableViewCell.swift
//  TSWeChat
//
//  Created by Li Mutong on 21/12/16.
//  Copyright © 2016年 Hilen. All rights reserved.
//

import UIKit

class TSStoryTableViewCell: UITableViewCell {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    @IBOutlet weak var iconImageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!

    
}
