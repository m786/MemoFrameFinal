//
//  GlemtPassordViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 09.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class GlemtPassordViewController: UIViewController {

    @IBOutlet weak var beskrivelse: UITextView!
    @IBOutlet weak var epostInput: UITextField!
    var popupVindu = Popup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tekst()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//Teksten som skal vises
  private func tekst()
  {
     beskrivelse.text = "Vennligst skriv inn gyldig e-mail adresse under for å få tilsendt et midlertidig passord på e-mail for å denne brukeren. "
    }
    
    //send info
    @IBAction func glemtPassord(_ sender: UIButton) {
         var regex = Regex()
        if (regex.verifiserEpost(tekst: epostInput.text!) && epostInput != nil) {
            var nodeJs = Networking()
            var token = nodeJs.getToken()
            if(!token.isEmpty){
                if(nodeJs.glemtPassord(token: token, epostFelt: epostInput)){
                
                    popupVindu.vis(fromController: self, melding: "Sjekk din epost du har fått tilsendt nytt passord.", tittel: "Sjekk mailen")
                    
                         self.performSegue(withIdentifier: "hovedM", sender: nil)
                   
                }
                else{
                popupVindu.vis(fromController: self, melding: "Er epostaderesse riktig?prøv igjen", tittel: "Feil")
                }
            }
        }
    }

}
