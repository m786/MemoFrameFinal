//
//  KodeLoginnViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 09.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class KodeLoginnViewController: UIViewController {
    
 
    @IBOutlet weak var pinKode: UITextField!
    let popupvindu = Popup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logginnKnapp(_ sender: UIButton) {
        
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        
        if(!token.isEmpty){
            var bruker:String = nodeJs.loginnMedPin(token: token, pinKode: pinKode)
            if(!bruker.isEmpty){
                
                var data :NSDictionary = ["bruker":bruker,"pinkode":pinKode.text!]
                self.performSegue(withIdentifier: "innloggetMedPin", sender: data)
            }
            else{
            popupvindu.vis(fromController: self,melding: "Er pinkoden riktig tastet inn?,prøv igjen eller kontakt admin.",tittel: "!")
            }
        }
        else{
        popupvindu.vis(fromController: self,melding: "Feil på server, kontakt admin eller prøv igjen.",tittel: "!")
        }
    }
    
    // forbereder data til å bli flyttet fra denne viewen tl en annen via en segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "innloggetMedPin" {
            
            if let destination = segue.destination as? LoggetInnMedKodeViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerOgToken = (sender as? NSDictionary)!
            }
        }
        
    }
    
    
}
