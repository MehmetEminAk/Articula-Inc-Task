//
//  SignInVCExtension.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import Foundation
import UIKit
import AgoraChat


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
    func authOperation()  {
        
        hud.show(in: view)
        
        guard let email = emailTF.text, let password = passwordTF.text else {
            return
        }
        
        if isSignInPage {
            viewModel.signIn(email: email, password: password) { result, error in
                
                self.hud.dismiss(animated: true)
                if error != nil {
                    
                    
                    
                    
                    self.generateAlert(errTitle: "ERROR!", errMsg: error!.localizedDescription,actions: [UIAlertAction(title: "OK", style: .cancel)])
                }else {
                    
                    let email = email.split(separator: "@")
                    var agoraChatUserId = email[0] + email[1]
                    UserDefaults.standard.set(agoraChatUserId, forKey: "agoraCurrentUserId")
                    print(UserDefaults.standard.string(forKey: "agoraCurrentUserId"))
                    
                    
                    let tabBarVC = TabBar()
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true)
                }
                
            }
        }
        
        //If the user is signing up this else block will be execute
        else {
            
            guard let email = emailTF.text, let password = passwordTF.text else {
                return
            }
            
            viewModel.signUp(email: email, password: password) { result, error in
                
                self.hud.dismiss(animated: true)
                if error != nil {
                    
                    self.generateAlert(errTitle: "ERROR!", errMsg: error!.localizedDescription,actions: [UIAlertAction(title: "OK", style: .cancel)])
                }else {
                    let email = email.split(separator: "@")
                    
                    var agoraChatUserId = email[0] + email[1]
                    UserDefaults.standard.set(agoraChatUserId, forKey: "agoraCurrentUserId")
                    
                    print(UserDefaults.standard.string(forKey: "agoraCurrentUserId"))
                    let agoraChatUserIdd = String(agoraChatUserId)
                    print(agoraChatUserId)
                    
                    AgoraChat.shared.client.register(withUsername: String(agoraChatUserId), password: password) { _, err in
                        if err != nil {
                            self.generateAlert(errTitle: "ERROR!\(err!.code.rawValue)", errMsg: err!.errorDescription , actions: [UIAlertAction(title: "OK", style: .cancel)])
                        }else {
                            let tabBarVC = TabBar()
                            tabBarVC.modalPresentationStyle = .fullScreen
                            self.present(tabBarVC, animated: true)
                        }
                    }
                    
                    
                }
                
            }
            
           
        }
    }
}
