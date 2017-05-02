//
//  Tid.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//Klasse for tid på test eller klasse som starter tid og stopper samt lagrer det i en variabel


import UIKit

class Tid {
    
    private var startTime = TimeInterval()
    
    private var timer = Timer()
    
    private var tidBrukt:String = ""
    
    func startTiden(){
        let aSelector : Selector = "updateTime"
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate
    }
    
    dynamic func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate
        
        //Finn forskjellen mellom nå tid og start tiden
        
        var elapsedTime: TimeInterval = currentTime - startTime
        
        //Kalkulerer minutter
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //Kalkulerer secunder
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= TimeInterval(seconds)
        
        //Millisekunder
        
        let fraction = UInt8(elapsedTime * 100)
        
        //Legge til minutter ,secunder og ms til string
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        tidBrukt = "\(strMinutes):\(strSeconds):\(strFraction)"
        
    }
    
    func getTid()->String{
        return tidBrukt
    }
    
    func stopTiden(){
        timer.invalidate()
        timer == nil
    }
    
    
}
