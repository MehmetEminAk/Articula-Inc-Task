//
//  General.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 10.04.2023.
//

import Foundation
import UIKit


extension UIView {
    func addSubViews(_ views : [UIView]){
        views.forEach { view in
            self.addSubview(view)
        }
    }
}

extension UIViewController {
    func generateAlert(errTitle : String,errMsg : String , style : UIAlertController.Style = .alert , actions : [UIAlertAction] = []){
        let alert = UIAlertController(title: errTitle, message: errMsg, preferredStyle: style)
        
        actions.forEach { act in
            alert.addAction(act)
        }

        self.present(alert, animated: true)
        
    }
}
