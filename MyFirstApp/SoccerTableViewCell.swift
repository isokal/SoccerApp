//
//  SoccerTableViewCell.swift
//  MyFirstApp
//
//  Created by Iwo Sokal on 08/07/2021.
//

import UIKit

class SoccerTableViewCell: UITableViewCell {
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerNameLabel.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
