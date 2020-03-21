//
//  RecordSoundsViewController.swift
//  Pitch_Perfect
//
//  Created by marta on 15/02/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import AVFoundation
import UIKit


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{

    @IBOutlet var recordingLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!

    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stopRecordingButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("viewWillAppear called") - for testing
    }
    func recordConfigureUI(isRecord : Bool)  {
        if isRecord {
            recordingLabel.text = "Recording in progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        }else{
            recordingLabel.text = "Tap to record"
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
        }
    }


    @IBAction func recordAudio(_ sender: AnyObject) {
        //         print("record button was pressed") -  for testing
        //        recordingLabel.text = "Recording in progress" - - to the func recordConfigureUI
        //        stopRecordingButton.isEnabled = true
        //        recordButton.isEnabled = false
        recordConfigureUI(isRecord: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(_ sender: Any) {
        //        recordingLabel.text = "Tap to record" - to the func recordConfigureUI
        //        recordButton.isEnabled = true
        //        stopRecordingButton.isEnabled = false
        recordConfigureUI(isRecord: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not successful")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recorderAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recorderAudioURL
        }
    }
}
