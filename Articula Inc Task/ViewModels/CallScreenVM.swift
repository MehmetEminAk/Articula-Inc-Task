//
//  MainScreenVM.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 10.04.2023.
//

import Foundation
import FirebaseAuth

protocol CallScreenDelegate : AnyObject {
    func updateUI()
}


class CallScreenVM {
    
    weak var delegate : CallScreenDelegate?
    
    var friends : [Friend] = []
    
    let db = DB.shared.firebase
    
    func fetchCurrentUserFriends(){
        
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("Users").document(userId!).collection("Friends").getDocuments { snapshot, error in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                
                snapshot?.documents.forEach({ doc in
                    
                    let name = doc.data()["name"] as! String
                    let id = doc.data()["id"] as! String
                    
                    let friendProfileImage = doc.data()["profileImage"] as! String

                    self.friends.append(Friend(friendName: name, friendId: id , friendProfileImage: friendProfileImage))
                })
                
                self.delegate?.updateUI()
            }
        }
    }
    
    func noticeTargetUser(id : String , channel : String) {
        
    }
    
    func getToken(channelName : String , expirationSecond : Int = 3600) async -> (RtcTokenModel?,Error?){
        let request = Network.shared.generateRequest(operationType: .generateRtcToken, parameters: ["channel" : channelName , "expiration" : expirationSecond])
        
        
        
       var (result,error)  = await Network.shared.requestToApi(request: request, expectingType: RtcTokenModel.self)
        
        return (result,error)
        
    }
    
    func numberOfRows() -> Int{
        return friends.count
    }
    
   
    
    
}
