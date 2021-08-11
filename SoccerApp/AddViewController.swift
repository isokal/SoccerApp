import Combine
import CombineCocoa
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

    private var subscriptions = Set<AnyCancellable>()

    private lazy var saveButtonTapPublisher = saveBarButton.tapPublisher.share().eraseToAnyPublisher()

    lazy var soccerPlayerPublisher: AnyPublisher<SoccerPlayer, Never> = saveButtonTapPublisher
        .compactMap { [weak self] in
            return self?.createPlayer()
        }.eraseToAnyPublisher()

    private lazy var failurePublisher: AnyPublisher<String, Never> = saveButtonTapPublisher
        .compactMap { [weak self] in
            return self?.createPlayer() == nil ? "Couldn't create player" : nil
        }.eraseToAnyPublisher()

    override func viewDidLoad() {
        super.viewDidLoad()
        saveBarButton.isEnabled = false
        nameTextField.placeholder = "Name"
        surnameTextField.placeholder = "Surname"
        countryTextField.placeholder = "Country"
        nameTextField.backgroundColor = UIColor.lightGray
        surnameTextField.backgroundColor = UIColor.lightGray
        countryTextField.backgroundColor = UIColor.lightGray
        setupSubscriptions()
    }

    @IBAction func addImageButtonPressed(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }

    private func setupSubscriptions() {
        failurePublisher.sink { [weak self] error in
            print(error)
        }.store(in: &subscriptions)
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

    private func createPlayer() -> SoccerPlayer? {
        if let name = nameTextField.text, !name.isEmpty,
           let surname = surnameTextField.text, !surname.isEmpty,
           let country = countryTextField.text, !country.isEmpty,
           image != nil {
            return SoccerPlayer(name: name, surname: surname, image: image, country: country)
        } else {
            return nil
        }
    }

}
