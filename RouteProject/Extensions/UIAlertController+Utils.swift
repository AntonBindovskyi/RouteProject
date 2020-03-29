//
//  UIAlertController+Utils.swift
//  RouteProject
//
//  Created by Anton Bindovskyi on 29.03.2020.
//  Copyright © 2020 Anton Bindovskyi. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func infoAlert(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert.addAction(title: "ok".localized)
    }
    
    func addAction(title: String?,
                   style: UIAlertAction.Style = .default,
                   handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(.init(title: title, style: style, handler: handler))
        return self
    }
}
