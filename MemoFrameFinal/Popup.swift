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
    
    
    func vis(fromController controller: UIViewController,melding: String,tittel:String){

        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont            = UIFont(name: "Futura-CondensedExtraBold", size: 40)!
        dialogAppearance.titleColor           = UIColor(red:252, green:0, blue:0, alpha: 100)
        dialogAppearance.messageFont          = UIFont(name: "Futura-Medium", size: 30)!
        dialogAppearance.messageColor         = UIColor(red:0, green:0, blue:0, alpha: 80)
        dialogAppearance.messageTextAlignment = .center
        
        // knappen
        let cb = CancelButton.appearance()
        cb.titleFont      = UIFont(name: "Futura", size: 30)!
        cb.titleColor     = UIColor(white: 100.0, alpha: 1)
        cb.buttonColor    = UIColor(red:0.0, green:0.70, blue:0.0, alpha:1.00)
       
        
        //forbereder popup vindu
        let title = tittel
        var message = melding
        // oppretter dialog vindu

        
        var popup = PopupDialog(title: title, message: message)
        //lage costumize popup

        
        // opretter knapp
        let buttonOne = CancelButton(title: "OK") {
            print("Ok knapp trykket i poupvindu.")
        }
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne])
        
        // Presenter popup
        controller.present(popup, animated: true, completion: nil)
    
    }
 


}
