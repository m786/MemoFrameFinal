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
    
     let popupvindu = Popup()
    //FaceBook
    var fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    var fbresult: Any?
    
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
            popupvindu.vis(fromController: self,melding: "Skriv inn riktig epost aderesse.",tittel: "Noe gikk galt!")
            return
        }
        //sjekker om passord er tatet riktig
        if (regex.verifiserPassord(tekst: passord.text!)) {
            gyldigPassord = true
        } else {
            popupvindu.vis(fromController: self,melding: "Skriv inn passord.",tittel:"Noe gikk galt!")
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
             popupvindu.vis(fromController: self,melding: "Fant ikke bruker,prøv igjen eller kontakt admin.",tittel:"Noe gikk galt!")
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
                    print(result)
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
