//
//  KontaktOssViewController.swift
//  MemoFrameFinal
//
//  Created by Christopher Reyes on 01.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class KontaktOssViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tekstFelt: UITextView!
    @IBOutlet weak var epostFelt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        tekstFelt.delegate = self
        tekstFelt.font = UIFont(name: "Futura", size: 35.0)
        tekstFelt.text = "Trykk her for å skrive din kommentar"
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        tekstFelt.text = ""
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //metode som sender melding til admin fra en bruker
    @IBAction func sendTilbakemelding(_ sender: UIButton) {
        var regex = Regex()
        let popupvindu = Popup()
        
        if (regex.verifiserEpost(tekst: epostFelt.text!) && epostFelt != nil) {
            var nodeJs = Networking()
            var token = nodeJs.getToken()
            if(!token.isEmpty){
                if(nodeJs.kontaktOss(token: token, tilbakemelding: tekstFelt, epost: epostFelt)){
                     popupvindu.vis(fromController: self,melding: "Takk,vi har motatt din melding.",tittel: "Takk")
                    tekstFelt.text = ""
                    epostFelt.text = ""
                }
                else{
                     popupvindu.vis(fromController: self,melding: "Melding kunne ikke sendes,prøv igjen",tittel: "Feil")
                }
                
            }else{
               popupvindu.vis(fromController: self,melding: "Prøv igjen,eller kontakt admin.",tittel: "Token Feil")
            }
     }
        else{
        //regex feilet
            popupvindu.vis(fromController: self,melding: "Skriv inn riktig epost aderesse.",tittel: "Feil format på epost")
        }
    
   }
}
