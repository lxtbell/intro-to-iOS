//
//  ViewController.swift
//  intro-to-ios
//
//  Created by Abhishek Modi on 9/21/15.
//  Copyright (c) 2015 CS 196 Illinois. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var just_do_it_button: UIButton!
    var isActive = false
    var myRootRef = Firebase()

    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        myRootRef = Firebase(url:"https://cs196-ios-intro.firebaseio.com/")
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            self.colorswap()
        })

        var alertSound = NSURL(fileURLWithPath: "/Users/akmodi/Documents/ios-intro/intro-to-ios/intro-to-ios/do_it.mp3")
        println("Printing alert sound")
        println(alertSound)

        // Removed deprecated use of AVAudioSessionDelegate protocol
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)

        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shia(sender: AnyObject) {
        colorswap()
    }

    func colorswap(){
        println(self.just_do_it_button.backgroundColor)
        println(audioPlayer.currentTime)
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        isActive = (!isActive)
        if (isActive)
        {
            self.just_do_it_button.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 1)
            var date = NSDate()
            myRootRef.childByAppendingPath("username").setValue(hour+minutes)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        else
        {
            self.just_do_it_button.backgroundColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
            audioPlayer.pause()
            audioPlayer.currentTime = 0
        }
    }

}

