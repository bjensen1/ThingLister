//
//  AddCarViewController.swift
//  ThingLister
//
//  Created by Brent Jensen on 6/27/21.
//

import Foundation
import UIKit

class AddBookViewController: AddThingViewController {
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var numberOfPagesField: UITextField!
    
    override var thingName: String { return "book"}
    
    override func validateConcreteThingFields() -> Bool {
        guard let author = authorTextField.text, author.count > 0 else {
            showAlert(title: "Please enter an author for the \(thingName).") {
                [weak self] in
                self?.authorTextField.becomeFirstResponder()
            }
            return false
        }
        guard let numberOfPagesText = numberOfPagesField.text, let _ = Int(numberOfPagesText) else {
            showAlert(title: "Please enter a number of pages for the \(thingName).") {
                [weak self] in
                self?.authorTextField.becomeFirstResponder()
            }
            return false
        }
        
        return true
    }
    
    override func createThing() -> Thing? {
        guard let name = nameTextField.text,
              let image = image,
              let author = authorTextField.text,
              let numberOfPagesText = numberOfPagesField.text,
              let pageCount = Int(numberOfPagesText),
              let notes = noteTextView.text
        else { return nil }
        
        return ModelService.shared.createBook(name: name, image: image, author: author, pageCount:pageCount, notes: notes)
    }
}
