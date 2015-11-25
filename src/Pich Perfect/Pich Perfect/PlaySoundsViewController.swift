//
//  PlaySoundsViewController.swift
//  Pich Perfect
//
//  Created by Javier C. Melendrez on 11/19/15.
//  Copyright © 2015 com.javier. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox


class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let filePathUrl=receivedAudio.filePathUrl
            do {
            
            audioPlayer = try AVAudioPlayer(contentsOfURL: filePathUrl)
            audioPlayer.enableRate=true;
            audioPlayer?.volume=1.0;
                
            audioEngine = AVAudioEngine()
            audioFile = try  AVAudioFile(forReading: receivedAudio.filePathUrl)
                
            } catch {
                print(error)
            }
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func actionRabbit(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()

        audioPlayer.stop();
        audioPlayer.rate=1.5;
         audioPlayer.currentTime=0.0;
        audioPlayer.volume=1.0
        audioPlayer.play();
    
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
        
    }
    
    
    
    
    @IBAction func playAudioChimpunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
        
    }
    
    func playAudioWithVariablePitch(pitch:Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.volume=1
        
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        
        
        
        try! audioEngine.start()
        
        
       audioPlayerNode.volume=1.0
        
        audioPlayerNode.play()
    }
    
    
    
    @IBAction func actionStop(sender: UIButton) {
        audioPlayer.stop();
        
    
    }
    
    
    @IBAction func eventSoundSlow(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()

        audioPlayer.stop();
        audioPlayer.rate=0.5;
        audioPlayer.currentTime=0.0;
        audioPlayer.play();
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
