//
//  OppdaterBrukerViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class OppdaterBrukerViewController: UIViewController {

    var brukerInfo : NSDictionary = [:]
    var info: String = ""
    var token:String = ""
    
    @IBOutlet weak var epostFelten: UITextField!
    @IBOutlet weak var epostFeltto: UITextField!
    @IBOutlet weak var gammelPassord: UITextField!
    @IBOutlet weak var nyPassord: UITextField!
    
    let popupvindu = Popup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    separereTokenOgEmail(data: brukerInfo)
       epostFelten.text = info
        
    }
    //Token og email for bruker
    func separereTokenOgEmail(data:NSDictionary){
        if let d = data as? NSDictionary{
            for(key,v) in d as! NSDictionary{
                if(key as! String == "Email"){
                    info = v as! String
                }
                else if(key as! String == "Token"){
                    token = v as! String
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endre(_ sender: UIButton) {
        
        let regex = Regex()
        var epost :Bool = false
        var veriepost:Bool = false
        var likeEmail :Bool = false
        var pass: Bool = false
        
        if(regex.verifiserEpost(tekst: epostFelten.text!)){
            epost = true
        }
        if(regex.verifiserEpost(tekst: epostFeltto.text!)){
            veriepost = true
        }
        if(epostFelten.text == epostFeltto.text){
            likeEmail = true
        }
        if(gammelPassord.text! != nil && nyPassord.text! != nil){
            pass = true
        }
        if(!epost){
            popupvindu.vis(fromController: self,melding: "Skriv riktig epostformat i felt 1",tittel: "Feil")
        }
        if(!veriepost){
            popupvindu.vis(fromController: self,melding: "Skriv riktig epost format i felt to",tittel: "Feil")
        }
        if(!likeEmail){
            popupvindu.vis(fromController: self,melding: "Begge email må være like",tittel: "Feil")
        }
        if(!pass){
            popupvindu.vis(fromController: self,melding: "Passordfeltet kan ikke være tom",tittel: "Feil")
        }
        else if(epost && veriepost && likeEmail && pass && regex.verifiserPassord(tekst: nyPassord.text!)) {
            var nodeJs = Networking()
            var token = nodeJs.getToken()
            if(!token.isEmpty){
                nodeJs.endrePassord(token: token, nyPassord: nyPassord, epost: epostFeltto)
                popupvindu.vis(fromController: self,melding: "Passordet er endret",tittel: "Velykket!")
                epostFelten.text = ""
                epostFeltto.text = ""
                gammelPassord.text = ""
                nyPassord.text = ""
                
            }
         
            
        }
        else{
         popupvindu.vis(fromController: self,melding: "Passord må bestå av minst 8 tegn,prøv igjen eller kontakt admin.",tittel: "Feil")
        }
    }

    @IBAction func loggUt(_ sender: UIButton) {
    }
 

}
