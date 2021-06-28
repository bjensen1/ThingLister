//
//  Thing+Extensions.swift
//  ThingLister
//
//  Created by Brent Jensen on 6/24/21.
//

import Foundation
import UIKit

extension Thing {
    var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
}
