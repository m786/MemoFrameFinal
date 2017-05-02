//
//  Pupup.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit
import PopupDialog

class Popup: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func vis(fromController controller: UIViewController,melding: String){
        //lage costumize popup
        var dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont            = UIFont(name: "Futura", size: 20)!
        dialogAppearance.messageFont          = UIFont(name: "Futura", size: 20)!
        dialogAppearance.messageTextAlignment = .center
        
        // knappen
        let cb = CancelButton.appearance()
        cb.titleFont      = UIFont(name: "Futura", size: 30)!
        cb.titleColor     = UIColor(white: 100.0, alpha: 1)
        cb.buttonColor    = UIColor(red:0.0, green:0.70, blue:0.0, alpha:1.00)
       
        
        //forbereder popup vindu
        let title = "Noe gikk galt!"
        var message = melding
        // oppretter dialog vindu
        let popup = PopupDialog(title: title, message: message)
        
        // opretter knapp
        let buttonOne = CancelButton(title: "OK") {
            print("Feil.")
        }
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne])
        
        // Presenter popup
        controller.present(popup, animated: true, completion: nil)
    
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
