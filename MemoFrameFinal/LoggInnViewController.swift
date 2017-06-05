//
//  LoggInnViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
// Kontroller for logginn view

import UIKit
import PopupDialog
import FBSDKCoreKit
import FBSDKLoginKit

class LoggInnViewController: UIViewController {
    //felter
    @IBOutlet weak var epost: UITextField!
    @IBOutlet weak var passord: UITextField!
    @IBOutlet weak var passordLabel: UILabel!
    
    
    //FaceBook
    var fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    var fbresult: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        passord.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        passordLabel.text = "Trykk her og skriv inn ditt passord"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        
        passordLabel.text = ""
        
    }
    
    //Loginn knapp
    @IBAction func logginn(_ sender: UIButton) {
         let popupvindu = Popup()
        // verifikasjon med Regex
        let regex = Regex()
        var gyldigEpost: Bool = false
        var gyldigPassord: Bool = false
       
        
        //sjekker epost
        if (regex.verifiserEpost(tekst: epost.text!)) {
            gyldigEpost = true
        } else {
            popupvindu.vis(fromController: self,melding: "Tast inn en gyldig epost adresse.",tittel: "!")
            return
        }
        //sjekker om passord er tastet riktig
        if (regex.verifiserPassord(tekst: passord.text!)) {
            gyldigPassord = true
        } else {
            popupvindu.vis(fromController: self,melding: "Tast inn et gyldig passord.",tittel:"!")
            return
        }
        //dersom alt er tastet riktig
        if (gyldigEpost && gyldigPassord) {
          var nodeJs = Networking()
          var token = nodeJs.getToken()
            if(!token.isEmpty){
                var array = nodeJs.logginn(token: token, epost: epost.text!, passord: passord.text!)
                self.performSegue(withIdentifier: "Innlogget", sender: array)
            }
            else{
             popupvindu.vis(fromController: self,melding: "Fant ikke bruker i systemet, prøv igjen eller kontakt admin.",tittel:"!")
            }
            
        
        }
        
      
    }
     //Logge inn med facebook
    @IBAction func fbLoggInn(_ sender: AnyObject) {
        fbLoginManager .logIn(withReadPermissions: ["email"], handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    var array = ["Token":FBSDKAccessToken.current().tokenString,"Result":self.fbresult]
                    print(array)
                    self.performSegue(withIdentifier: "Innlogget", sender: array)
                    // fbLoginManager.logOut()
                }
            }
        })
        
    }
    //Hjelpemetode for facebook for å få info bruker
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.fbresult = result
                }
            })
        }
    }
    // forbereder data til å bli flyttet fra denne viewen tl en annen via en segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Innlogget" {
            
            if let destination = segue.destination as? HovedmenyViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary!)!
                
            }
        }
        
    }

}
