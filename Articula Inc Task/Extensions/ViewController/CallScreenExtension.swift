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
       
        let result = engine.leaveChannel()
        
        
    }
    func joinChannel() async {
        
        
    }
    
    
    func checkForPermissions() async -> Bool {
       
        
        let hasPermissions = await self.avAuthorization(mediaType: .audio)
        return hasPermissions
    }
    
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
    }
    
   
    func configFriendsTable(){
        friendsTable.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "friendCell")
        friendsTable.delegate = self
        friendsTable.dataSource = self
        view.addSubViews([friendsTable])
        viewModel.fetchCurrentUserFriends()
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = friendsTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendCell
        cell.callButton.addTarget(self, action: #selector(initCallBtnClicked), for: .touchUpInside)
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
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didReceive event: AgoraChannelMediaRelayEvent) {
        
    }
}
    
