//
//  TSStoryTableViewCell.swift
//  TSWeChat
//
//  Created by Li Mutong on 21/12/16.
//  Copyright © 2016 MT. All rights reserved.
//

import UIKit

class TSStoryTableViewCell: UITableViewCell {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var cellTextView: UITextView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var thinkBtn: UIButton!
    
    //initial for each cell
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        
        // Initialization code
        print ("CELL awakeFromNib")

    }
    
    //cell selected or deselected (one click multiple)
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        print("")
        print ("CELL setSelected, ",selected)
        print ("testLabel t, ",testLabel.text!)
        print ("testLabel h, ",testLabel.height)
        print ("cellTextView h, ",cellTextView.height)
        print ("cellView h, ",cellView.height)
        print("")
    }
}
