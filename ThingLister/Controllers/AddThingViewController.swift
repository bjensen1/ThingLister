//
//  AddThingViewController.swift
//  ThingLister
//
//  Created by Brent Jensen on 6/27/21.
//

import Foundation
import UIKit

class AddThingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var imageButton: UIButton!
    @IBOutlet var noteTextView: UITextView!
    var imagePicker: UIImagePickerController!
    
    var image: UIImage?
    var saveAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    var thingName: String { return "thing" }
    var thing: Thing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.layer.cornerRadius = 8
        imagePicker = UIImagePickerController()
    }
    
    @IBAction func saveButtonPressed() {
        guard validateFields() else { return }
        thing = createThing()
        saveAction?()
    }
    
    @IBAction func cancelButtonPressed() {
        cancelAction?()
    }
    
    @IBAction func pickImagePressed() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
          didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage ?? info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageButton.setImage(image, for: .normal)
        imageButton.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    func createThing() -> Thing? {
        fatalError("This method must be overridden by the subclass.")
    }
    
    func showAlert(title: String, onDismiss: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        
        func handler(action:UIAlertAction) {
            onDismiss?()
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:handler))
        present(alert, animated: true, completion: nil)
    }
    
    func validateFields() -> Bool {
        return validateParentFields() && validateConcreteThingFields()
    }
    
    private func validateParentFields() -> Bool {
        guard let name = nameTextField.text, name.count > 0 else {
            showAlert(title: "Please enter a name for the \(thingName).") {
                [weak self] in
                self?.nameTextField.becomeFirstResponder()
            }
            return false
        }
        
        guard let _ = image else {
            showAlert(title: "Please choose an image for the \(thingName).")
            return false
        }
        
        guard let note = noteTextView.text, note.count > 0 else {
            showAlert(title: "Please enter notes for the \(thingName).") {
                [weak self] in
                self?.noteTextView.becomeFirstResponder()
            }
            return false
        }
        
        return true
    }
    
    func validateConcreteThingFields() -> Bool {
        fatalError("This method must be overridden by the subclass.")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    textV
}
