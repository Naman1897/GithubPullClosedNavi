//
//  SecondSegTableViewCell.swift
//  GithubPullClosedNavi
//
//  Created by Naman Singh on 11/04/22.
//

import UIKit

class SecondSegTableViewCell: UITableViewCell {
    
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        projectLabel.text = "Project Name :"
//        projectLabel.font = UIFont(name: "System" , size: 15.0)
        projectNameLabel.font = UIFont(name: "System" , size: 15.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
