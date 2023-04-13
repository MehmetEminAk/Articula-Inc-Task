//
//  SendMessageVC.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 10.04.2023.
//

import UIKit
import Speech
import AgoraChat

class MessagesVC: UIViewController , MessagesDelegate{
    
    
    var viewModel = MessagesVM()
    
    var synthesizer = AVSpeechSynthesizer()
    
    
    var speechRecognizer : SFSpeechRecognizer!
    
    var audioEngine : AVAudioEngine!
    
    var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    
    var recognitionTask : SFSpeechRecognitionTask?
    
    
    var receiverIdTF : UITextField = {
        let tf = UITextField(frame: CGRect(x: deviceWidth * 0.08, y: 100, width: deviceWidth * 0.7, height: 40))
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 5
        tf.layer.borderColor = UIColor.systemTeal.cgColor
        tf.bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 3, right: 0))
        tf.placeholder = "Type the receiver id"
        
        return tf
    }()
    
    var messageTF : UITextField = {
        let tf = UITextField(frame: CGRect(x: deviceWidth * 0.08, y: 200, width: deviceWidth * 0.7, height: 40))
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 5
        tf.layer.borderColor = UIColor.systemTeal.cgColor
        tf.bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 3, right: 0))
        tf.placeholder = "Type your message here"
        
        return tf
    }()
    
    var sendMessageButon : UIButton = {
        let button = UIButton(frame: CGRect(x: deviceWidth * 0.8, y: 200, width: deviceWidth * 0.05, height: 40))
        
        button.setImage(UIImage(systemName: "paperplane.circle.fill")?.withTintColor(.systemTeal), for: .normal)
        return button
    }()
    
    var micButton : UIButton = {
        let button = UIButton(frame: CGRect(x: deviceWidth * 0.87, y: 200, width: deviceWidth * 0.05, height: 40))
        button.setImage(UIImage(systemName: "mic.circle.fill")?.withTintColor(.systemTeal), for: .normal)
        
        return button
    }()
    
    var chatLogs : UITextView = {
        let label = UITextView(frame: CGRect(x: 0, y: 300, width: deviceWidth, height: deviceHeight - 220))
        label.textContainerInset = UIEdgeInsets(top: deviceHeight * 0.05, left: deviceWidth * 0.1, bottom: 40, right: deviceHeight * 0.05)
        return label
        
    }()
    
    
    override func viewDidLoad() {
        configView()
        
        configVoiceOperations()
        
        Task {
            await initChatSdk()
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Task {
            if !AgoraChatClient.shared().isLoggedIn {
                await loginAgoraChat()
            }
                
                
            }
            
        }
    
    
    
    
    
}
