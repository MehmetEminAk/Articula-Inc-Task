//
//  ViewController.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 10.04.2023.
//

import Foundation
import UIKit
import AgoraRtcKit
import AVFoundation
import Kingfisher

extension CallScreenVC : AgoraRtcEngineDelegate , UITableViewDelegate , UITableViewDataSource ,CallScreenDelegate{
    
    
    
    func leaveChannel() {
       
        engine.leaveChannel()
        
        
    }
   
    
    
    @available(iOS 13.0.0, *)
    func checkForPermissions() async -> Bool {
       
        
        let hasPermissions = await self.avAuthorization(mediaType: .audio)
        return hasPermissions
    }
    
    @available(iOS 13.0.0, *)
    func avAuthorization(mediaType: AVMediaType) async -> Bool {
        let mediaAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        switch mediaAuthorizationStatus {
        case .denied, .restricted: return false
        case .authorized: return true
        case .notDetermined:
            return await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: mediaType) { granted in
                
                    continuation.resume(returning: granted)
                }
            }
        @unknown default: return false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return deviceHeight * 0.07
    }
    func initializeAgoraEngine(){
        let config = AgoraRtcEngineConfig()
        
        config.appId = agoraAppId
        engine = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
        engine.setChannelProfile(.communication)
        engine.enableAudio()
        engine.disableVideo()
        engine.adjustAudioMixingVolume(12)
    }
    
   
    func configFriendsTable(){
        friendsTable.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "friendCell")
        friendsTable.delegate = self
        friendsTable.dataSource = self
        view.addSubViews([friendsTable,headerLabel,closeTheCalBtn])
        viewModel.fetchCurrentUserFriends()
        closeTheCalBtn.addTarget(self, action: #selector(terminateTheCall), for: .touchUpInside)
        
    }
   
    @objc
    func terminateTheCall(){
        leaveChannel()
        self.closeTheCalBtn.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = friendsTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendCell
        cell.callButton.addTarget(self, action: #selector(initCallBtnClicked(_:)), for: .touchUpInside)
        cell.callButton.tag = indexPath.row
        
        let profileImageUrl = URL(string: viewModel.friends[indexPath.row].friendProfileImage)
        
        cell.profileImage.kf.setImage(with: profileImageUrl)
        cell.nameLabel.text = viewModel.friends[indexPath.row].friendName
        
        return cell
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.friendsTable.reloadData()
        }
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        print("Other user joined")
        
    }
    
 
    
    
    
    func presentIncomingCall(sourceUserId: String, channel: String, token: String) async {
        
        await checkForPermissions()
        
        self.generateAlert(errTitle: "Ringing", errMsg: "\(sourceUserId) is calling you. Do you want to answer?" , actions: [UIAlertAction(title: "YES", style: .default , handler: { act in
            
           
            
            
            self.engine.joinChannel(byToken: token, channelId: channel, info: nil, uid: 0) { _, _, _ in
                self.engine.setEnableSpeakerphone(true)
                print("Other user is on the line")
            }
        }),UIAlertAction(title: "NO", style: .cancel)])
        
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        print("Local user is in the channel")
        
    }
    
    
    
    
    
    
}
    
