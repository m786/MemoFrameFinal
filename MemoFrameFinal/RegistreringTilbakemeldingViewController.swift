//
//  RegistreringTilbakemeldingViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 03.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class RegistreringTilbakemeldingViewController: UIViewController {

    var sendData: [String : String] = [:]
    
    @IBOutlet weak var epostTilbakemelding: UILabel!
    @IBOutlet weak var fodselsaar: UILabel!
    @IBOutlet weak var kjonn: UILabel!
    @IBOutlet weak var land: UILabel!
    @IBOutlet weak var passord: UILabel!
    var epost = ""
    var pass = ""
    
    
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

    @IBAction func sendInfo(_ sender: UIButton) {
     var nodeJs = Networking()
     let popupvindu = Popup()
     var token = nodeJs.getToken()
        
        if(!token.isEmpty){
        nodeJs.sendInfo(data: sendData, token: token)
            popupvindu.vis(fromController: self,melding: "Sjekk din epost for info du tastet inn.",tittel: "Grattlerer du er nå registrert!")
            
        }else{
        
            popupvindu.vis(fromController: self,melding: "Prøv igjen,eller kontakt administrtor.",tittel: "Noe gikk galt!")
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
