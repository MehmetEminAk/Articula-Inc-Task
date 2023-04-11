//
//  SendMessageVC.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 10.04.2023.
//

import UIKit
import AgoraRtcKit
import AgoraChat
import Speech

class MessagesVC: UIViewController, SFSpeechRecognizerDelegate {
    override func viewDidLoad() {
        
    }
} /*
/*
    @IBOutlet weak var speechTextView: UITextView!
    @IBOutlet weak var recordButton: UIButton!

    var audioEngine = AVAudioEngine()
    var speechRecognizer: SFSpeechRecognizer?
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var audioSession = AVAudioSession.sharedInstance()
    var agoraKit: AgoraRtcEngineKit?
    var agoraRtm: AgoraChat?
    var channel: AgoraRtmChannel?

    override func viewDidLoad() {
        super.viewDidLoad()

        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        speechRecognizer?.delegate = self

        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "YOUR_APP_ID", delegate: self)
        agoraRtm = AgoraRtmKit.init(appId: "YOUR_APP_ID", delegate: self)
    }

    @IBAction func recordButtonTapped(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setTitle("Stopping", for: .disabled)
        } else {
            startRecording()
            recordButton.setTitle("Stop Recording", for: [])
        }
    }

    func startRecording() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }

        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false

            if result != nil {
                self.speechTextView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.recordButton.isEnabled = true
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }

        speechTextView.text = "Say something, I'm listening!"
    }

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
       */*/
