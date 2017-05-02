//
//  LoggInnViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
// Kontroller for logginn view

import UIKit
import PopupDialog

class LoggInnViewController: UIViewController {
    //felter
    @IBOutlet weak var epost: UITextField!
    @IBOutlet weak var passord: UITextField!
    
     let popupvindu = Popup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Loginn knapp
    @IBAction func logginn(_ sender: UIButton) {
        
        // verifikasjon med Regex
        let regex = Regex()
        var gyldigEpost: Bool = false
        var gyldigPassord: Bool = false
       
        
        //sjekker epost
        if (regex.verifiserEpost(tekst: epost.text!)) {
            gyldigEpost = true
        } else {
             popupvindu.vis(fromController: self,melding: "Skriv inn riktig epost aderesse.")
        }
        //sjekker om passord er tatet riktig
        if (regex.verifiserPassord(tekst: passord.text!)) {
            gyldigPassord = true
        } else {
             popupvindu.vis(fromController: self,melding: "Skriv inn passord.")
        }
        //dersom alt er riktig
        if (gyldigEpost && gyldigPassord) {
          
        }
        
      
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
