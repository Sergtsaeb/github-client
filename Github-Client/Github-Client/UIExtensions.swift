//
//  UIExtensions.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/4/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

extension UIResponder {
    static var identifier: String {
        return String(describing: self)
    }
}
