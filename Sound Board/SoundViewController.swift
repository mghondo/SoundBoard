//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Morgan Hondros on 1/4/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        playButton.isEnabled = false
        
    }
    
    //Creating a function that will set up this audio recorder.
    
    func setupRecorder() {
        do {
            // Create an audio session
            
            let session = AVAudioSession.sharedInstance()
            //try session.setCategory(AVAudioSession.Category.playAndRecord)
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL for the audio file.
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!

            print(audioURL)
            
            // Create Setting for the audio recorder.
            
            var settings : [String:Any] = [:]
            
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            // Create AudioRecorder Object
            
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {}
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if audioRecorder!.isRecording {
            // Stop Recording
            audioRecorder?.stop()
            
            //Change Button Title to Record
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            
            
        } else {
            // Start recording
            audioRecorder?.record()
            
            // Change Button Title to Stop
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    @IBAction func playTapped(_ sender: Any) {
        do {
        try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch {}
    }
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
}
