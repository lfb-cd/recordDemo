//
//  ViewController.swift
//  recordDemo
//
//  Created by lifubing on 15/10/16.
//  Copyright © 2015年 lifubing. All rights reserved.
//

import UIKit

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
    ////定义音频的编码参数，这部分比较重要，决定录制音频文件的格式、音质、容量大小等，建议采用AAC的编码方式
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),//声音采样率
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),//编码格式
        AVNumberOfChannelsKey : NSNumber(int: 1),//采集音轨
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]//音频质量
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
                settings: recordSettings)//初始化实例
            audioRecorder.prepareToRecord()//准备录音
        } catch {
        }
    }
    
    func directoryURL() -> NSURL? {
        //定义并构建一个url来保存音频，音频文件名为ddMMyyyyHHmmss.caf
        //根据时间来设置存储文件名
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".caf"
        print(recordingName)
        
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent(recordingName)
        return soundURL
    }
    
    @IBAction func startRecord(sender: AnyObject) {
        //开始录音
        if !audioRecorder.recording {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                audioRecorder.record()
                print("record!")
            } catch {
            }
        }
    }
    @IBAction func stopRecord(sender: AnyObject) {
        //停止录音
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(false)
            print("stop!!")
        } catch {
        }
    }
    
    
    @IBAction func startPlaying(sender: AnyObject) {
        //开始播放
        if (!audioRecorder.recording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
                audioPlayer.play()
                print("play!!")
            } catch {
            }
        }
    }
    

    @IBAction func pausePlaying(sender: AnyObject) {
        //暂停播放
        if (!audioRecorder.recording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
                audioPlayer.pause()
                
                print("pause!!")
            } catch {
            }
        }
        
    }
}


