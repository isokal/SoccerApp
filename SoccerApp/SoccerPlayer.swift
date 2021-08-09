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
