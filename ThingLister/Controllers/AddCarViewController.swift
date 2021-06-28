//
//  AddCarViewController.swift
//  ThingLister
//
//  Created by Brent Jensen on 6/27/21.
//

import Foundation
import UIKit

class AddCarViewController: AddThingViewController {
    @IBOutlet var manufacturerTextField: UITextField!
    
    override var thingName: String { return "car"}
    
    override func validateConcreteThingFields() -> Bool {
        guard let manufacturer = manufacturerTextField.text, manufacturer.count > 0 else {
            showAlert(title: "Please enter a manufacturer for the \(thingName).") {
                [weak self] in
                self?.manufacturerTextField.becomeFirstResponder()
            }
            return false
        }
        
        return true
    }
    
    override func createThing() -> Thing? {
        guard let name = nameTextField.text,
              let image = image,
              let manufacturer = manufacturerTextField.text,
              let notes = noteTextView.text
        else { return nil }
        
        return ModelService.shared.createCar(name: name, image: image, manufacturer: manufacturer, notes: notes)
    }
}
