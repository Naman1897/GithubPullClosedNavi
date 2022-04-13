//
//  HeadSegTableViewCell.swift
//  GithubPullClosedNavi
//
//  Created by Naman Singh on 11/04/22.
//

import UIKit

class HeadSegTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userNameLabel.font = UIFont(name: "System", size: 15.0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
