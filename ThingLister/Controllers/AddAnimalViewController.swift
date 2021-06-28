//
//  AddCarViewController.swift
//  ThingLister
//
//  Created by Brent Jensen on 6/27/21.
//

import Foundation
import UIKit

class AddAnimalViewController: AddThingViewController {
    @IBOutlet var numberOfFeetTextField: UITextField!
    
    override var thingName: String { return "animal"}
    
    override func validateConcreteThingFields() -> Bool {
        guard let numberOfFeet = numberOfFeetTextField.text, numberOfFeet.count > 0, let _ = Int16(numberOfFeet) else {
            showAlert(title: "Please enter how many feet this \(thingName) has.") {
                [weak self] in
                self?.numberOfFeetTextField.becomeFirstResponder()
            }
            return false
        }
        
        return true
    }
    
    override func createThing() -> Thing? {
        guard let name = nameTextField.text,
              let image = image,
              let numberOfFeetText = numberOfFeetTextField.text,
              let numberOfFeet = Int16(numberOfFeetText),
              let notes = noteTextView.text
        else { return nil }
        
        return ModelService.shared.createAnimal(name: name, image: image, numberOfFeet: numberOfFeet, notes: notes)
    }
}
