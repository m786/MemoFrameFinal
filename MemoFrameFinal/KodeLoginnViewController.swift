//
//  KodeLoginnViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 09.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class KodeLoginnViewController: UIViewController {

    
    @IBOutlet weak var beskrivelse: UITextView!
    
    @IBOutlet weak var pinKode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func infoKnapp(_ sender: UIButton) {
           beskrivelse.text=""
           beskrivelse.text = "Her kan du utføre tester ved hjelp av kode du har fått av en administrerende bruker. Tast inn koden og trykk på ''start test'', og du vil få muligheten til å ta tilsvarende test."
    }
    
    @IBAction func logginnKnapp(_ sender: UIButton) {
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        if(!token.isEmpty){
            var data:String = nodeJs.loginnMedPin(token: token, pinKode: pinKode)
            if(!data.isEmpty){
             self.performSegue(withIdentifier: "innloggetMedPin", sender: data)
            }
        }
    }
    // forbereder data til å bli flyttet fra denne viewen tl en annen via en segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "innloggetMedPin" {
            
            if let destination = segue.destination as? LoggetInnMedKodeViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.info = (sender as? String)!
            }
        }
        
    }
}
