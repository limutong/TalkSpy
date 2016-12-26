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
    
    @IBAction func think(_ sender: UIButton) {

        //highlight self.cellTextView
        let searchString = "sit" as String
        let baseString = self.cellTextView.text

        let range = (baseString! as NSString).range(of: searchString)

        let attributed = NSMutableAttributedString(string: baseString!)
        
        attributed.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellow, range: range)
        
        self.cellTextView.attributedText = attributed
 
    }


    
    //initial for each cell
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        self.thinkBtn.isHidden = true
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
