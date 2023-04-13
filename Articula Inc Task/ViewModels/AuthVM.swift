//
//  AuthVM.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import Foundation
import FirebaseAuth
import AgoraChat

protocol AuthDelegate : AnyObject{
    
}

class AuthVM  {
    
    var db = DB.shared.firebase
    
    
    
    func signIn(email : String , password : String , completionHandler : @escaping(_ result : Bool?,_ error : Error?) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if error != nil {
                completionHandler(false,error)
            }else {
                
                AgoraChatClient.shared().login(withUsername: email, password: password) { _, err in
                    if err != nil {
                        completionHandler(false,error)
                    }else {
                        completionHandler(true,nil)
                    }
                }
            }
        }
    }
    func signUp(email : String , password : String ,completionHandler :  @escaping(_ result : Bool?,_ error : Error?) -> Void ) {
        
        Auth.auth().createUser(withEmail: email, password: password) { _, err in
            
            
            
            if err != nil {
                completionHandler(false,err)
            }else {
                
                completionHandler(true,nil)
                
            }
        }
    }
    
    
    
    
    
    
}



