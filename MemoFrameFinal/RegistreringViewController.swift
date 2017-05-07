//
//  RegistreringViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 03.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//Klasse for å registrerer bruker

import UIKit

class RegistreringViewController: UIViewController {

    //felter 
    @IBOutlet weak var epostFelt: UITextField!
    @IBOutlet weak var fodselsaarFelt: UITextField!
    @IBOutlet weak var passordFelt: UITextField!
    @IBOutlet weak var landFelt: UITextField!
    @IBOutlet weak var kjonnFelt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registrer(_ sender: UIButton) {
        // verifikasjon med Regex
        let regex = Regex()
        let popupvindu = Popup()
        
        var gyldigEpost: Bool = false
        var gyldigFodselsaar: Bool = false
        var gyldigPassord: Bool = false
        var gyldigland : Bool = false
        var gyldigKjønn: Bool = false
        
        if (regex.verifiserEpost(tekst: epostFelt.text!)) {
            gyldigEpost = true
        } else {
            popupvindu.vis(fromController: self,melding: "Skriv inn riktig epost aderesse.",tittel: "Noe gikk galt!")
            return
        }
        if (regex.verifiserPassord(tekst: passordFelt.text!)) {
            gyldigPassord = true
        } else {
              popupvindu.vis(fromController: self,melding: "Skriv inn riktig passord,minst 8 tegn.",tittel: "Noe gikk galt!")
            return
        }
        if (regex.verifiserFodselsaar(tekst: fodselsaarFelt.text!)) {
            gyldigFodselsaar = true
        } else {
            popupvindu.vis(fromController: self,melding: "Skriv gyldig fødselsår.",tittel: "Noe gikk galt!")
            return
        }
        if (regex.verifiserLand(tekst: landFelt.text!)) {
            gyldigland = true
        } else {
            popupvindu.vis(fromController: self,melding: "Skriv gyldig land.",tittel: "Noe gikk galt!")
            return
        }
        if (regex.verifiserKjonn(tekst: kjonnFelt.text!)) {
            gyldigKjønn = true
        } else {
            popupvindu.vis(fromController: self,melding: "Skriv Mann eller Kvinne.",tittel: "Noe gikk galt!")
            return
        }
        // alt av verifisering godkjent, registrerer brukeren
       var nodeJs = Networking()
       var token = nodeJs.getToken()
       if(!token.isEmpty){
        var array = nodeJs.registrering(token: token, epost: epostFelt.text!, passord: passordFelt.text!, land: landFelt.text!, fodt: fodselsaarFelt.text!, kjonn: kjonnFelt.text!)
        if(array.count == 0){
        popupvindu.vis(fromController: self,melding: "Bruker finnes prøv igjen,eller kontakt admin.",tittel: "Noe gikk galt!")
            return
        }
        else{
        self.performSegue(withIdentifier: "segueRegistreringTilbakemelding", sender: array)
        }
        }
       else{
        popupvindu.vis(fromController: self,melding: "Prøv igjen,eller kontakt administrtor.",tittel: "Noe gikk galt!")

        }
        
    }


    // forbereder data til å bli flyttet fra denne viewen tl en annen via en segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueRegistreringTilbakemelding" {
            
            if let destination = segue.destination as? RegistreringTilbakemeldingViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.sendData = (sender as? [String : String])!
            }
        }
    }
}
