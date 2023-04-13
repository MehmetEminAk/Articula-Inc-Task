//
//  SignInVC.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import UIKit
import JGProgressHUD

class SignInVC: UIViewController {
    
    var viewModel = AuthVM()

    var isSignInPage : Bool = true
    
    var hud : JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.frame = CGRect(x: deviceWidth / 2 - 50, y: deviceHeight / 2 - 50, width: 100, height: 100)
        hud.textLabel.text = "Loading..."
        return hud
    }()
    
    var headerLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: deviceWidth * 0.1, y: deviceHeight * 0.15, width: deviceWidth * 0.9, height: 80))
        label.numberOfLines = 3
        
        label.attributedText = NSAttributedString(string: "Welcome to the calling app! \nPlease sign in",attributes: [.foregroundColor : UIColor.systemTeal , .font : UIFont.systemFont(ofSize: 25, weight: .bold)])
        return label
    }()
    
    var emailTF : UITextField = {
        let textField = UITextField(frame: CGRect(x: deviceWidth * 0.2, y: deviceHeight * 0.3, width: deviceWidth * 0.6, height: 50))
        textField.placeholder = "Please type your email"
        textField.layer.borderColor = UIColor.systemTeal.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    var passwordTF : UITextField = {
        let textField = UITextField(frame: CGRect(x: deviceWidth * 0.2, y: deviceHeight * 0.3 + 80, width: deviceWidth * 0.6, height: 50))
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        textField.placeholder = "Please type your password"
        textField.layer.borderColor = UIColor.systemTeal.cgColor
        return textField
    }()
    
    var signUp_InBtn : UIButton = {
        let button = UIButton(frame:  CGRect(x: deviceWidth * 0.2, y: deviceHeight * 0.3 + 160, width: deviceWidth * 0.6, height: deviceHeight * 0.05))
        button.backgroundColor = .systemTeal
        button.setTitle("Sign In", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    var toogleSingInBtn : UIButton = {
        let button = UIButton(frame:  CGRect(x: deviceWidth * 0.15 ,y: deviceHeight * 0.4 + 160, width: deviceWidth * 0.8, height: 60))
        button.tintColor = .systemTeal
        button.setTitle("Don't have an account? Sign up", for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubViews([headerLabel,emailTF,passwordTF,signUp_InBtn,toogleSingInBtn])
        configObjects()
        
        toogleSingInBtn.setTitle("Don't have an account? Sign up", for: .normal)
        
    }
    
    


}
