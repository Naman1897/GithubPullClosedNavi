//
//  LastSegTableViewCell.swift
//  GithubPullClosedNavi
//
//  Created by Naman Singh on 11/04/22.
//

import UIKit

class LastSegTableViewCell: UITableViewCell {
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var closeDateLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        stateLabel.font = UIFont(name: "System", size: 15.0)
        createDateLabel.font = UIFont(name: "System", size: 15.0)
        closeDateLabel.font = UIFont(name: "System", size: 15.0)
        profileImgView.layer.cornerRadius = profileImgView.bounds.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
