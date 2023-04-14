//
//  ViewController.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 10.04.2023.
//

import UIKit
import AgoraRtcKit
import FirebaseAuth
import AgoraChat

class CallScreenVC: UIViewController {

    
    var headerLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: deviceWidth * 0.1, y: deviceHeight * 0.1, width: deviceWidth * 0.8, height: 100))
        label.numberOfLines = 3
        label.attributedText = NSAttributedString(string: "Press the phone button for the calling your friends", attributes: [.foregroundColor : UIColor.systemTeal , .font : UIFont.systemFont(ofSize: 24, weight: .bold)])
        return label
    }()
    
    var friendsTable: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: deviceHeight * 0.3, width: deviceWidth, height: deviceHeight * 0.7))
        
        return table
    }()
    
    var closeTheCalBtn : UIButton = {
        
        let btn = UIButton(frame: CGRect(x: deviceWidth * 0.3, y: deviceHeight * 0.8, width: deviceWidth * 0.4, height: 50))
        btn.backgroundColor = .systemRed
        btn.layer.cornerRadius = 15
        btn.setTitle("Terminate Call", for: .normal)
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        btn.isHidden = true
        return btn
    }()
    
    
    var engine :  AgoraRtcEngineKit!
    
    var viewModel = CallScreenVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        viewModel.delegate = self
        configFriendsTable()
        initializeAgoraEngine()
        viewModel.trackIncomingCalls()
        
        
    }

}

