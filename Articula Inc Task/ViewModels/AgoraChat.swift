//
//  AgoraChatManager.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 13.04.2023.
//

import Foundation
import AgoraChat

class AgoraChat {
    
    static let shared = AgoraChat()
    
    let menager = AgoraChatClient.shared().chatManager
    
    let client = AgoraChatClient.shared()
    
    private init() {
        
        let options = AgoraChatOptions(appkey: agoraChatAppKey)
       
        let agoraChatEngine = AgoraChatClient.shared().initializeSDK(with: options)
    }
    
    
    
    
}
