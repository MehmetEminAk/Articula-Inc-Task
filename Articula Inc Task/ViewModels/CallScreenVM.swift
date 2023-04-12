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
    func presentIncomingCall(sourceUserId : String , channel : String , token : String)
}


class CallScreenVM {
    
    weak var delegate : CallScreenDelegate?
    
    var friends : [Friend] = []
    
    let currentUserId = Auth.auth().currentUser!.uid
    
    let db = DB.shared.firebase
    
    func fetchCurrentUserFriends(){
        
        
        
        db.collection("Users").document(currentUserId).collection("Friends").getDocuments { snapshot, error in
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
    
    func trackIncomingCalls() {
        db.collection("Callings").document(currentUserId).collection("incomingCalls").addSnapshotListener { snapShot, err in
            
            
            
                
                
                print(isFirstControl)
                if !isFirstControl {
                    print(isFirstControl)
                    let doc = snapShot?.documentChanges.last
                    let channel = doc!.document.data()["channel"] as! String
                    let token = doc!.document.data()["token"] as! String
                    
                    let sourcePersonId = doc!.document.data()["sourcePersonId"] as! String
                    print(doc?.document.data()["token"])
                    
                    
                    
                    self.delegate?.presentIncomingCall(sourceUserId: sourcePersonId, channel: channel, token: token)
                }
                
                
            
            
        }
    }
    
    func callTheUser(targetId : String , channel : String , targetUserToken : String){
        
        
        
        db.collection("Callings").document(targetId).collection("incomingCalls").addDocument(data: ["channel" : channel , "sourcePersonId" : currentUserId , "token" : targetUserToken])
        
    }
    
    func getToken(channelName : String , expirationSecond : Int = 3600) async -> (RtcTokenModel?,Error?){
        let request = Network.shared.generateRequest(operationType: .generateRtcToken, parameters: ["channel" : channelName , "expiration" : expirationSecond])
        
        
        
       let (result,error)  = await Network.shared.requestToApi(request: request, expectingType: RtcTokenModel.self)
        
        return (result,error)
        
    }
    
    func numberOfRows() -> Int{
        return friends.count
    }
    
   
    
    
}
