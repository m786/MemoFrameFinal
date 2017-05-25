//
//  Kalkulator.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 17.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//Klasse som kalkulerer om brukeren skal opp et nivå,være på den samme eller gå ned ett nivå

import UIKit

class Kalkulator{
    //Max dilaytid bruker har
    let maxDilay:Int = 20
    
    //finksjon som kalkulerer
    func kalkuler (dilayTid: Int,runder:Int,poeng:Int)->Int{
        //tar imot variabler fra funksjonen for å kunne bruke dette videre
        var r = runder
        var p = poeng
        var d = dilayTid
        
        //poeng delt på antall runder
        var resultat = p/r
        //1 poeng pr runde f,eks dersom en bruker får 20 poeng ut av 40 bilder er det 50%
        var prosent = resultat * 100
        
        //Dersom brukeren fikk mellom 100% - 80% og har dilaytid under 20 sec, bruker går opp et nivå
        if(prosent >= 80 && prosent <= 100 && dilayTid < maxDilay){
            d + 1
            return d
        }
            //er brukeren mellom 50% - 80% vil de være på samme nivå
        else if(prosent < 80 && prosent >= 50 ){
            return d
        }
        else if(dilayTid > 1 && poeng < 50){
            d-1
            return d
        }
        return d
    }
    
    func kalkulerController(dilayTid: Int,poeng:Int)->Int{
        
        var d = dilayTid
        var p = poeng
        
        
        if(dilayTid == 20 && poeng == 1 ){
            return 20
            
        }
        else if(dilayTid == 2 && poeng == 0){
            return 2
        }
        else if(poeng == 1){
            return dilayTid+1
        }
        
        return dilayTid-1
    }
    
}
