//
//  TestInfo.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//Klasse som lagrer test info 

import UIKit

class TestInfo {
    
    private var _gyldig: Int = 0
    private var _oppgavetekst: String = ""
    private var _testbeskrivelse: String = ""
    private var _testid: Int = 0
    private var _testnavn: String = ""
    private var _tidsdelay: Int = 0
    private var _vanskelighetsgrad:Int = 0
    private var _runder:Int = 5
    
    var gyldig: Int {
        set { _gyldig = newValue }
        get { return _gyldig }
    }
    
    var oppgavetekst: String{
        set { _oppgavetekst = newValue }
        get { return _oppgavetekst }
    }
    
    var testbeskrivelse: String{
        set { _testbeskrivelse = newValue }
        get { return _testbeskrivelse }
    }
    
    var testid: Int{
        set { _testid = newValue }
        get { return _testid }
    }
    
    var testnavn: String{
        set { _testnavn = newValue }
        get { return _testnavn }
    }
    
    var tidsdelay: Int{
        set { _tidsdelay = newValue }
        get { return _tidsdelay }
    }
    
    var vanskelighetsgrad: Int{
        set { _vanskelighetsgrad = newValue }
        get { return _vanskelighetsgrad }
    }
    
    var runder: Int{
        set { _runder = newValue }
        get { return _runder }
    }
    
    func toString()-> String{
        return "Test: \(_testnavn) \nGyldig: \(String(_gyldig)) \nTestId: \(String(_testid))\nOppgavetekst: \(_oppgavetekst) \nTestbeskrivelse: \(_testbeskrivelse) \nDelaytid: \(_tidsdelay) \nVanskelighetsgrad: \(_vanskelighetsgrad) \nRunder: \(_runder)"
    }
    
}

