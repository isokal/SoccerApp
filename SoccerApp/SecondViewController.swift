//
//  SecondViewController.swift
//  MyFirstApp
//
//  Created by Iwo Sokal on 07/07/2021.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    var player: SoccerPlayer?
    @IBOutlet weak var soccerImageView: UIImageView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerLabel.textAlignment = .center
        countryLabel.textAlignment = .center
        playerLabel.text = player?.fullName
        playerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        soccerImageView.image = player?.image
        countryLabel.text = player?.country
    }
    
}
