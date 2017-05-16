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
    @IBOutlet weak var passordInstruks: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        passordFelt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        passordInstruks.text = "Trykk her og skriv inn ditt passord"
        
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        
        passordInstruks.text = ""

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
            popupvindu.vis(fromController: self,melding: "Tast inn en gyldig epost adresse.",tittel: "!")
            return
        }
        if (regex.verifiserPassord(tekst: passordFelt.text!)) {
            gyldigPassord = true
        } else {
              popupvindu.vis(fromController: self,melding: "Tast inn et gyldig passord. Minst 8 tegn.",tittel: "!")
            return
        }
        if (regex.verifiserFodselsaar(tekst: fodselsaarFelt.text!)) {
            gyldigFodselsaar = true
        } else {
            popupvindu.vis(fromController: self,melding: "Tast inn et gyldig fødselsår.",tittel: "!")
            return
        }
        if (regex.verifiserLand(tekst: landFelt.text!)) {
            gyldigland = true
        } else {
            popupvindu.vis(fromController: self,melding: "Tast inn et gyldig land.",tittel: "!")
            return
        }
        if (regex.verifiserKjonn(tekst: kjonnFelt.text!)) {
            gyldigKjønn = true
        } else {
            popupvindu.vis(fromController: self,melding: "Tast inn enten Mann eller Kvinne.",tittel: "!")
            return
        }
        // alt av verifisering godkjent, registrerer brukeren
       var nodeJs = Networking()
       var token = nodeJs.getToken()
       if(!token.isEmpty){
        var array = nodeJs.registrering(token: token, epost: epostFelt.text!, passord: passordFelt.text!, land: landFelt.text!, fodt: fodselsaarFelt.text!, kjonn: kjonnFelt.text!)
        if(array.count == 0){
        popupvindu.vis(fromController: self,melding: "Bruker finnes allerede i systemet. Kontakt admin.",tittel: "!")
            return
        }
        else{
        self.performSegue(withIdentifier: "segueRegistreringTilbakemelding", sender: array)
        }
        }
       else{
        popupvindu.vis(fromController: self,melding: "Det oppstod en feil. Prøv igjen, eller kontakt administrator.",tittel: "!")

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
