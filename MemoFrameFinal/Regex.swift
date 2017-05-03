//
//  Regex.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
// Klasse som sjekker om input er riktig

import Foundation
import UIKit

class Regex{
    
    //sjekker om epostformatet er riktig
    func verifiserEpost(tekst: String) -> Bool {
        
        // "\\." betyr at første "\" escaper neste "\" slik at  "." betyr "match any character"
        let monster = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        if tekst.range(of: monster, options: .regularExpression) != nil {
            
            return true
            
        } else {
            
            return false
        }
        
    }
    
    //sjekker gyldig intervall mellom 1850 og nåværende dato
    func verifiserFodselsaar(tekst: String) -> Bool {
        
        // formaterer og finner nåværende dato
        let dato = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let perDagsDato = Int(formatter.string(from: dato))
        let datoFraTekst = Int(tekst)
        
        if(datoFraTekst != nil){
            if (datoFraTekst! < 1850 || datoFraTekst! > perDagsDato!) {
                
                return false
                
            } else {
                
                return true
            }
        }
        return false
    }
    
    //Store og små bokstaver samt tall er kun det som er gyldig
    func verifiserPassord(tekst: String) -> Bool {
        
        //implementere funksjonalitet for minst en stor bokstav?
        let monster = "[A-Za-z0-9]{8,}"
        
        if tekst.range(of: monster, options: .regularExpression) != nil {
            
            return true
            
        } else {
            
            return false
        }
    }
    //Sjekker om land felt ikke er tom
    func verifiserLand(tekst: String) -> Bool {
        
        if(!tekst.isEmpty){
            
            return true
            
        } else {
            
            return false
        }
    }
    //Verifiser kjønn
    func verifiserKjonn(tekst: String) -> Bool {
        
        if(tekst == "Mann" || tekst == "Kvinne" || tekst == "mann" || tekst == "kvinne"){
            
            return true
            
        } else {
            
            return false
        }
    }
}
