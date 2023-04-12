//
//  MessagesExtension.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 12.04.2023.
//

import Foundation
import AgoraChat
import AVFAudio
import Speech
import AVFoundation


extension MessagesVC : AgoraChatManagerDelegate {
    func initChatSdk() async {
        
        let rtmKitOptions = AgoraChatOptions(appkey: agoraChatAppKey)
        
        AgoraChatClient.shared().initializeSDK(with: rtmKitOptions)
        AgoraChatClient.shared().chatManager?.add(self, delegateQueue: nil)
    }
    
    func configVoiceOperations(){
        audioEngine = AVAudioEngine()
        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        
    }
   
    @objc
    func micButtonClicked(){
        guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
            self.generateAlert(errTitle: "ERROR!", errMsg: "If you want to use this app you must give the permission")
               return
           }
           
     
           do {
               try startRecording()
           } catch {
               print(error)
           }
    }
    
    func configView(){
        
        view.backgroundColor = .white
        viewModel.delegate = self
        view.addSubViews([messageTF,sendMessageButon,micButton,chatLogs,receiverIdTF])
        sendMessageButon.addTarget(self, action: #selector(sendMessageClicked), for: .touchUpInside)
        micButton.addTarget(self, action: #selector(micButtonClicked), for: .touchUpInside)
        

        
    }
    
    
    func printLog(_ log : Any...){
        DispatchQueue.main.async {
            self.chatLogs.text.append(
                DateFormatter.localizedString(from: .now, dateStyle: .none, timeStyle: .medium) + " : " + String(reflecting: log)
            )
        
            self.chatLogs.scrollRangeToVisible(NSRange(location: self.chatLogs.text.count, length: 1))
        }
    }
    
    
    @objc func sendMessageClicked(){
        guard let targetId = self.receiverIdTF.text ,let message = messageTF.text else { return }
        sendMessage(targetUserId: targetId, message: message)
    }
    
    func startRecording() throws {
        // In here we are cancelling any previous recognition task
        recognitionTask?.cancel()
        recognitionTask = nil
        
        
        //  Configuring the  audio session
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement,options: [.duckOthers,.defaultToSpeaker])
        try audioSession.setActive(true,options: .notifyOthersOnDeactivation)
        
        
        // Create recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            print("Error occured while creating recognition request")
            return
        }
        
        // Configure recognition request
        recognitionRequest.shouldReportPartialResults = true
        
        // Create recognition task
        let inputNode = audioEngine.inputNode
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { [weak self] (result, error) in
            guard let self = self else { return }
            if let result = result {
                // Update text field with recognized text
                let recognizedText = result.bestTranscription.formattedString
                self.messageTF.text = recognizedText
            }
            if error != nil || result?.isFinal == true {
                // End recognition task
                print(error?.localizedDescription)
                self.stopRecording()
            }
        })
        
        // Configure audio engine
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, time) in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask = nil
    }
    
    func sendMessage(targetUserId : String, message : String){
        
        let msg = AgoraChatMessage(conversationId: targetUserId, from: agoraCurrentUserId, to: targetUserId, body: .text(content: message), ext: nil)
        
        
        print(msg.swiftBody)
        print(msg.chatType)
        print(msg.to)
        AgoraChatClient.shared().chatManager?.send(msg, progress: nil,completion: { _, err in
            if err != nil {
                self.printLog("error! \(err!.errorDescription) \n")
                
            }else {
                self.printLog("send message success\n")
                
            }
            
        })
        
    }
    
    func messagesDidReceive(_ aMessages: [AgoraChatMessage]) {
        aMessages.forEach { msg in
            switch msg.swiftBody {
            case let .text(content: messageString) :
                self.printLog("receive text message , content : \(messageString)\n")
                speakMessage(messageString)
            default :
                break
            }
        }
    }
    
    func speakMessage(_ message: String) {
        let synthesizer = AVSpeechSynthesizer()
        
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") 
        
        synthesizer.speak(utterance)
    }
    
    func loginAgoraChat() async {
        
        let (result,error) = await viewModel.getCurrentUserToken()
        
        if error != nil {
            print(error!.localizedDescription)
        }else if let _ = result {
            
            let token = result!.token
            let (_,error) = await AgoraChatClient.shared().login(withUsername: "deneme1", agoraToken: token)
            
            if error != nil {
                print(error?.errorDescription)
            }else {
                print("Login success")
            }
            
        }
    }
    
}
