//
//  ViewController.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 10.04.2023.
//

import UIKit
import AgoraRtcKit
import FirebaseAuth

class CallScreenVC: UIViewController {

    
    
    
    var friendsTable: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: deviceHeight * 0.3, width: deviceWidth, height: deviceHeight * 0.7))
        
        return table
    }()
    
    
    
    
    var engine :  AgoraRtcEngineKit!
    
    var viewModel = CallScreenVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        configFriendsTable()
        initializeAgoraEngine()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        leaveChannel()
        DispatchQueue.global(qos: .userInitiated).async {
            AgoraRtcEngineKit.destroy()
        }
    }
    
    @objc
    func initCallBtnClicked(_ sender : UIButton){
        
        
        Task {
            await joinChannel(button : sender)
        }
          
       
    }
    
    func joinChannel(button : UIButton) async {
        
        if await !self.checkForPermissions() {
            generateAlert(errTitle: "ERROR!", errMsg: "If you want to use this app you must give the permissions" , actions: [UIAlertAction(title: "OK", style: .cancel)])
            return
        }
        
        else {
            let currentUserId = Auth.auth().currentUser!.uid
            let targetUserId = viewModel.friends[button.tag].friendId
            var channelName = currentUserId + targetUserId
            
            let (result,error) = await viewModel.getToken(channelName: channelName)
            
            if error != nil {
                self.generateAlert(errTitle: "ERROR!", errMsg: error!.localizedDescription)
            }else if result != nil {
                
                engine.joinChannel(byToken: result!.token, channelId: result!.channel, info: nil, uid: 0) { _, _, _ in
                    print(result?.channel)
                    print("Operation is success")
                    self.engine.setEnableSpeakerphone(true)
                    
                }
            }
            
            
        }
        
     }
     
  

}

