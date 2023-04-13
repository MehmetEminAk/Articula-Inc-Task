//
//  SettingsVC.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 12.04.2023.
//

import UIKit
import FirebaseAuth
import AgoraChat


class SettingsVC: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "door.left.hand.open")?.withTintColor(.systemTeal), style: .plain, target: self, action: #selector(signOutClicked))
    }
    
    
    @objc
    func signOutClicked(){
        self.generateAlert(errTitle: "LOG OUT", errMsg: "Are you sure to logout? If you logout you must login again", actions: [
            UIAlertAction(title: "YES", style: .default,handler: { _ in
            try! Auth.auth().signOut()
            
                Task {
                    await AgoraChatClient.shared().logout(false)
                    UserDefaults.standard.set(nil, forKey: "agoraCurrentUserId")
                }
            let authVC = SignInVC()
                authVC.modalPresentationStyle = .fullScreen
                self.present(authVC, animated: true)
                
                
        }),
            UIAlertAction(title: "NO", style: .cancel)
        ]
        )
    }
   

}
