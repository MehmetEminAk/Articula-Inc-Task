//
//  SignInVCExtension.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import Foundation
import UIKit

extension SignInVC {
    func configObjects(){
        toogleSingInBtn.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        signUp_InBtn.addTarget(self, action: #selector(authOperation), for: .touchUpInside)
    }
    
    @objc func changeState(){
        self.isSignInPage.toggle()
        
        if isSignInPage == true {
            signUp_InBtn.setTitle("SIGN IN  ", for: .normal)
            toogleSingInBtn.setTitle("Don't have an account? Sign Up", for: .normal)
            headerLabel.attributedText = NSAttributedString(string: "Welcome to the calling app! \n Please sign in",attributes: [.foregroundColor : UIColor.systemTeal , .font : UIFont.systemFont(ofSize: 18, weight: .bold)])
            
        }else {
            signUp_InBtn.setTitle("SIGN UP", for: .normal)
            toogleSingInBtn.setTitle("Do you have an account? Sign In", for: .normal)
            headerLabel.attributedText = NSAttributedString(string: "Welcome to the calling app! \n Please sign up",attributes: [.foregroundColor : UIColor.systemTeal , .font : UIFont.systemFont(ofSize: 18, weight: .bold)])
        }
    }
    
    @objc
    func authOperation(){
        
        hud.show(in: view)
        
        if isSignInPage {
            viewModel.signIn(email: emailTF.text!, password: passwordTF.text!) { result, error in
                
                self.hud.dismiss(animated: true)
                if error != nil {
                    
                    self.generateAlert(errTitle: "ERROR!", errMsg: error!.localizedDescription,actions: [UIAlertAction(title: "OK", style: .cancel)])
                }else {
                    let tabBarVC = TabBar()
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true)
                }
                
            }
        }else {
            viewModel.signUp(email: emailTF.text!, password: passwordTF.text!) { result, error in
                
                self.hud.dismiss(animated: true)
                
                if error != nil {
                    self.generateAlert(errTitle: "ERROR!", errMsg: error!.localizedDescription,actions: [UIAlertAction(title: "OK", style: .cancel)])
                }else {
                    let tabBarVC = TabBar()
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true)
                }
                
            }
        }
    }
}
