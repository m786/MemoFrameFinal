//
//  RegistreringTilbakemeldingViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 03.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//Controller for View som viser brukeren sin info etter å ha registrert seg

import UIKit

class RegistreringTilbakemeldingViewController: UIViewController {
//motatt data fra andre view som fører til hit
    var sendData: [String : String] = [:]
    
    //labels som skal endres ved vising i view
    @IBOutlet weak var epostTilbakemelding: UILabel!
    @IBOutlet weak var fodselsaar: UILabel!
    @IBOutlet weak var kjonn: UILabel!
    @IBOutlet weak var land: UILabel!
    @IBOutlet weak var passord: UILabel!
    var epost = ""
    var pass = ""
    
    //knapp
    @IBOutlet weak var sendKnapp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //Her henter vi ut info om brukeren
        for (key, value) in sendData {
            if(key == "email"){
                epostTilbakemelding.text = value
                epost = value
            }
            else if(key == "passord"){
                passord.text = value
                pass = value
            }
            else if(key == "land"){
                land.text = value
            }
            else if(key == "alder"){
                fodselsaar.text = value
            }
            else if(key == "kjonn"){
                kjonn.text = value
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //knapp for å gå til view som skal vises etter å ha logget inn
    @IBAction func loggInn(_ sender: UIButton) {
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        if(!token.isEmpty){
            var array = nodeJs.logginn(token: token, epost: epost, passord: pass)
            self.performSegue(withIdentifier: "hovedmeny", sender: array)
        }
        else{
           self.performSegue(withIdentifier: "tilbake", sender: nil)
        }
    }
//knapp som sender bruker info til brukerens email
    @IBAction func sendInfo(_ sender: UIButton) {
     var nodeJs = Networking()
     let popupvindu = Popup()
     var token = nodeJs.getToken()
        
        if(!token.isEmpty){
            var ok = nodeJs.sendInfo(data: sendData, token: token)
            if(ok){
                
            sendKnapp.isHidden = true
               popupvindu.vis(fromController: self,melding: "Vennligst sjekk din epost for din bruker info.",tittel: "Email sendt!")
            }else{
             popupvindu.vis(fromController: self,melding: "Vennligst sjekk din epost for info du tastet inn.",tittel: "Mail med info kunne ikke sendes")
            }
        }else{
        
            popupvindu.vis(fromController: self,melding: "Det oppstod en feil. Prøv igjen, eller kontakt administrator.",tittel: "!")
        }
    }
    
    // forbereder data til å bli flyttet fra denne viewen tl en annen via en segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "hovedmeny" {
            
            if let destination = segue.destination as? HovedmenyViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary)!
            }
        }
    }
}
