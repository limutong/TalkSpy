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
    
    //TS-007 Click think btn [action in cell]
    @IBAction func think(_ sender: UIButton) {

        //highlight self.cellTextView
        let searchString = "sit" as String
        let baseString = self.cellTextView.text

        let range = (baseString! as NSString).range(of: searchString)

        let attributed = NSMutableAttributedString(string: baseString!)
        
        attributed.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellow, range: range)
        
        self.cellTextView.attributedText = attributed
        
        //add cover button
            //the position
        let begin = self.cellTextView.beginningOfDocument
        let start = self.cellTextView.position(from: begin, offset: range.location)
        let end = self.cellTextView.position(from: start!, offset: range.length)
        let uiTextRange = self.cellTextView.textRange(from: start!, to: end!)
        let rect = self.cellTextView.firstRect(for: uiTextRange!)
        print("GGGGGGet the rect ",rect)
            //the position
        let coverBtn = UIButton(type: .custom)
        coverBtn.setTitle("sit", for: .normal)
        coverBtn.setTitleColor(.purple, for: .normal)
        coverBtn.ts_setBackgroundColor(.yellow, forState: .normal)
        coverBtn.ts_setBackgroundColor(.darkGray, forState: .highlighted)
        coverBtn.layer.cornerRadius = 3.0
        
        coverBtn.layer.borderWidth = 2.0
        coverBtn.layer.borderColor = UIColor.clear.cgColor
        
        coverBtn.layer.shadowColor = UIColor.darkGray.cgColor
        coverBtn.layer.shadowOpacity = 1.0
        coverBtn.layer.shadowRadius = 1.0
        coverBtn.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        coverBtn.frame = CGRect(x: rect.minX, y: rect.minY, width: 20, height: 15)

        
        coverBtn.alpha = 0
        self.cellTextView.addSubview(coverBtn)
        
        UIView.animate(withDuration: 2, delay: 0.7, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            coverBtn.alpha = 1
        }, completion: nil)
        self.cellTextView.addSubview(coverBtn)
 
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
