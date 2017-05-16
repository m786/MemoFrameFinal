//
//  GlemtPassordViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 09.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class GlemtPassordViewController: UIViewController {


    @IBOutlet weak var epostInput: UITextField!
    var popupVindu = Popup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //send info
    @IBAction func glemtPassord(_ sender: UIButton) {
        var regex = Regex()
        if (regex.verifiserEpost(tekst: epostInput.text!) && epostInput != nil) {
            var nodeJs = Networking()
            var token = nodeJs.getToken()
            if(!token.isEmpty){
                if(nodeJs.glemtPassord(token: token, epostFelt: epostInput)){
                    
                    popupVindu.vis(fromController: self, melding: "Passord sendt. Vennligst sjekk din e-post.", tittel: "")
                    
                    self.performSegue(withIdentifier: "hovedM", sender: nil)
                    
                }
                else{
                    popupVindu.vis(fromController: self, melding: "Det oppstod en feil. Har du skrevet inn riktid e-post adresse?", tittel: "!")
                }
            }
        }
    }

}
