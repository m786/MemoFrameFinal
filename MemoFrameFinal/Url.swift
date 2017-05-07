//
//  Url.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
// Dersom url endres på backend brukes denne klassen


import UIKit
//Klasse som innholder backend url for login,registrering,glemt passord osv ..


class Url{
    
    //Hoved aderesse der appen er trenger kun å endre den dersom nodejs ligger et annet sted
    private let baseUrl: String = "http://www.gruppe18.tk:8080"
    //Loginn bruker med epost/passord
    private let loginUrl: String = "/api/authenticate"
    //Legg til bruker
    private let userAdd : String = "/api/users"
    //sende email via kontakt oss
    private let sendEpost: String = "/api/contact"
    //lagre resultat url
    private let save : String = "/api/resultat"
    //pinkode login url
    private let pinkode : String = "/api/pincode/login"
    //single test id url-husk å legge til id som parameter
    private let singleId : String = "/api/test/runde/"
    //send info på mail ved registrerng av bruker
    private let sendInfo: String = "/api/users/sendInfo"
    //Bilde tester url
    private let bildeTester: String = "/api/test"
    
    var hovedlink: String{
        get{return baseUrl}
    }
    //getmetode for login url
    var loginnUrl :String {
        get{return "\(baseUrl)\(loginUrl)"}
    }
    
    //get metode for registrere en bruker url
    var addUserUrl :String {
        get{return "\(baseUrl)\(userAdd)"}
    }
    
    //getmetode for kontaktoss url
    var kontaktOssUrl: String{
        get{return "\(baseUrl)\(sendEpost)"}
    }
    
    //getmetode for url for å lagre test
    var lagreTestUrl :String {
        get{return "\(baseUrl)\(save)"}
    }
    
    //getmetode for pinkodelogin - url
    var pinkodeLoginnUrl : String{
        get{return "\(baseUrl)\(pinkode)"}
    }
    //Metode for en test husk id som parameter
    var singleTestIdUrl : String {
        get{return "\(baseUrl)\(singleId)"}
    }
    //metode for å sende info på mail etter registrering
    var sendInfoUrl : String {
        get{return "\(baseUrl)\(sendInfo)"}
    }
    //Url for å få taki alle bildetester
    var BildeTesterUrl : String {
        get{return "\(baseUrl)\(bildeTester)"}
    }
}


