//
//  Networking.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_Synchronous


class Networking{
  
    //token for å kunne akksesere backend
    func getToken(epost:String,passord:String)->String{
        
        var token = ""
        
        let headers : HTTPHeaders = [
            "newUser":"newuser"
        ]
        
        let parameters: Parameters = [
            "email": epost,
            "passord": passord,
            ]
        
        
        let response = Alamofire.request("http://www.gruppe18.tk:8080",method: .post,headers:headers).responseJSON()
        if let json = response.result.value {
           
            let JSON = json as! NSDictionary
            let err = JSON.object(forKey: "Error") as! Bool
            if(!err){
                
               token = JSON.object(forKey: "Token") as! String
            
            }
        }
        
     return token
    }
    //logge inn bruker
    func logginn(token: String,epost:String,passord:String)->NSDictionary{
    
        var array : NSDictionary = [:]
    
    let parameters: Parameters = [
    "email": epost,
    "passord": passord,
    ]
    
    let headers : HTTPHeaders = [
    "x-access-token": token
    ]
    
    let response = Alamofire.request("http://www.gruppe18.tk:8080/api/authenticate",method: .post,parameters:parameters,headers:headers).responseJSON()
    
    
    if let result = response.result.value {
    let JSON = result as! NSDictionary
    let err = JSON.object(forKey: "Error") as? Bool
    let msg = JSON.object(forKey: "Message") as! String
    
    //velykket registrering
       if(!err!){
       var token = JSON.object(forKey: "Token") as! String
       //her skal man kunne gå til et annet view, kan bruke msg for å gi brukern melding om at bruker er lagt til.og token for å ta med videre.
        array = ["Token":token,"Email":epost]
       }
    
      }
     return array
    }

}
