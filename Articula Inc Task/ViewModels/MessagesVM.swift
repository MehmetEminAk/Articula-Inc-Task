//
//  MessagesVM.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 12.04.2023.
//

import Foundation


protocol MessagesDelegate : AnyObject {
    
}


class MessagesVM {
    
    weak var delegate : MessagesDelegate?
    
    
    func getCurrentUserToken() async -> (RtmTokenModel?,Error?){
        
        print(agoraCurrentUserId)
        let request =  Network.shared.generateRequest(operationType: .generateRtmToken, parameters: ["user" : agoraCurrentUserId , "expiration" : 3600])
        
        
        let (result,error) = await Network.shared.requestToApi(request: request, expectingType: RtmTokenModel.self)
        
        
        return (result,error)
        
    }
    
    
}
