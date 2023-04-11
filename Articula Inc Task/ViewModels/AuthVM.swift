//
//  AuthVM.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import Foundation
import FirebaseAuth

protocol AuthDelegate : AnyObject{
    
}

class AuthVM  {
    
    var db = DB.shared.firebase
    
    func signIn(email : String , password : String , completionHandler : @escaping(_ result : Bool?,_ error : Error?) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if error != nil {
                completionHandler(false,error)
            }else {
                
                let userId = Auth.auth().currentUser
                
                
            
                completionHandler(true,nil)
                
                
            }
        }
    }
    func signUp(email : String , password : String , completionHandler : @escaping(_ result : Bool?,_ error : Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                
                completionHandler(false,error)
            }else {
                
                let userId = Auth.auth().currentUser
                
                
            
                completionHandler(true,nil)
            }
        }
    }
    
}



