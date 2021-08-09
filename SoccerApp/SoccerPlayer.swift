//
//  SoccerPlayer.swift
//  MyFirstApp
//
//  Created by Iwo Sokal on 07/07/2021.
//
//change to closures, 2nd 1st, notificationcenter
import Foundation
import UIKit

struct SoccerPlayer {
    var name: String
    var surname: String
    var imageName: String?
    var image: UIImage?
    var country: String

    var fullName: String {
        return name + " " + surname
    }
}
