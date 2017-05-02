//
//  Testen.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//Klasse lagrer info om testen hentet i form av jason

import UIKit

class Testen{
    
    private var _tekst: String = ""
    private var _testrundeid: Int = 0
    private var _bilder: [String] = []
    private var _testid: Int = 0
    private var _rundenr: Int = 0
    
    var tekst: String {
        set { _tekst = newValue }
        get { return _tekst }
    }
    
    var testrundeid: Int{
        set { _testrundeid = newValue }
        get { return _testrundeid }
    }
    
    var bilder: [String]{
        set { _bilder = newValue }
        get { return _bilder }
    }
    
    var testid: Int{
        set { _testid = newValue }
        get { return _testid }
    }
    
    var rundenr: Int{
        set { _rundenr = newValue }
        get { return _rundenr }
    }
    
    
    func toString()-> String{
        return "Tekst: \(_tekst) \nTestrundeId: \(String(_testrundeid)) \nBilder: \(String(_bilder.count))\nTestid: \(_testid) \nRundenr: \(String(_rundenr))"
    }
}
