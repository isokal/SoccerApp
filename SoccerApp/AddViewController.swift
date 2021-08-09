import Foundation
import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var player: SoccerPlayer?
    var image: UIImage?
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var addStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBarButton.isEnabled = false
        nameTextField.placeholder = "Name"
        surnameTextField.placeholder = "Surname"
        countryTextField.placeholder = "Country"
        nameTextField.backgroundColor = UIColor.lightGray
        surnameTextField.backgroundColor = UIColor.lightGray
        countryTextField.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        chosenImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func notEmpty(_ sender: Any) {
        if let name = nameTextField.text, !name.isEmpty,
           let surname = surnameTextField.text, !surname.isEmpty,
           let country = countryTextField.text, !country.isEmpty,
           image != nil {
            saveBarButton.isEnabled = true
        }
        else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        if let name = nameTextField.text,
           let surname = surnameTextField.text,
           let country = countryTextField.text {
            player = SoccerPlayer(name: name, surname: surname, image: image, country: country)
            if let player = self.player {
                let playerDataDict:[String: SoccerPlayer] = ["player": player]
                NotificationCenter.default.post(name: Notification.Name("didAddPlayer"), object: nil, userInfo: playerDataDict)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}
