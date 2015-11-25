//
//  RecordSoundsViewController.swift
//  Pich Perfect
//
//  Created by Javier C. Melendrez on 11/9/15.
//  Copyright © 2015 com.javier. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    
    @IBOutlet weak var recordingProgress: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden=true;
        recordingProgress.hidden=false
         recordingProgress.text="Tap to Record"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
               
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func recordAudio(sender: UIButton) {
        recordingProgress.hidden=false;
        recordingProgress.text="recording in progress"
        
        stopButton.hidden=false;
        
       
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        
        
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate=self;
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
        
     
        print("record button")
        
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if(flag){
        //save audio
        recordedAudio=RecordedAudio(titleParam: recorder.url.lastPathComponent!,filePathParam: recorder.url)
      //  recordedAudio.filePathUrl=recorder.url
       // recordedAudio.title=recorder.url.lastPathComponent
        
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio=data
        }
        
    }
    
    
    @IBAction func hiddeRecordAudio(sender: UIButton) {
        recordingProgress.hidden=true;
       
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    

}

