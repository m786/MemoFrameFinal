//
//  Networking.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Alamofire_Synchronous


class Networking{
  
    var url = Url()
    
    //token for å kunne akksesere backend
    func getToken()->String{
        
        var token = ""
        
        let headers : HTTPHeaders = [
            "newUser":"newuser"
        ]
        
        let response = Alamofire.request(url.hovedlink,method: .post,headers:headers).responseJSON()
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
    
    let response = Alamofire.request(url.loginnUrl,method: .post,parameters:parameters,headers:headers).responseJSON()
    
    
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
    
    //Registrer bruker
    func registrering(token:String,epost :String,passord:String,land:String,fodt:String,kjonn:String)->NSDictionary{
    var array : NSDictionary = [:]
       
    let parameters: Parameters = [
            "email": epost,
            "passord": passord,
            "land": land,
            "alder": Int(fodt),
            "kjonn": kjonn
        ]
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
       
        let response = Alamofire.request(url.addUserUrl,method: .post,parameters:parameters,headers:headers).responseJSON()
        
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                let err = JSON.object(forKey: "Error") as! Bool
                let msg = JSON.object(forKey: "Message") as! String
                
                //velykket registrering
                if(!err){
                    
                array = [
                        "email": epost,
                        "passord": passord,
                        "land": land,
                        "alder" : fodt,
                        "kjonn": kjonn]
                    
                }
            }
        return array
    }
    //retunerer boolean verdi som forteller om infoen ble sendt eller ikke
    func sendInfo(data : [String:String],token : String)->Bool{
        
        var status :Bool = false
        var parameters: Parameters = [
            "email":"",
            "passord": "",
            "land":"",
            "alder" :"" ,
            "kjonn": ""
        ]
        
        let headers : HTTPHeaders = [
            "newUser":token
        ]
        
        for (key, value) in data {
            if(key == "email"){
                parameters.updateValue(value, forKey: key)
            }
            else if(key == "passord"){
                parameters.updateValue(value, forKey: key)
            }
            else if(key == "land"){
                parameters.updateValue(value, forKey: key)
            }
            else if(key == "alder"){
                parameters.updateValue(value, forKey: key)
            }
            else if(key == "kjonn"){
                parameters.updateValue(value, forKey: key)
            }
        }
       
        let response = Alamofire.request(url.sendInfoUrl,method: .post,parameters:parameters,headers:headers).responseJSON()
     
        
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let err = JSON.object(forKey: "Error") as? Bool
            
            if(!err!){
                status = true
            }
        }

        return status
        
    }
    
    func getBildeTester(token:String)->NSArray
    {
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
        
    let response = Alamofire.request(url.BildeTesterUrl,method: .get,headers:headers).responseJSON()
      print(response)
        
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let err = JSON.object(forKey: "Error") as? Bool
            let msg = JSON.object(forKey: "Message") as! String
            
         
            print(msg)
            if(!err!){
                 var tester = (JSON.object(forKey: "Tests") as? NSArray)!
                return tester
            }
     }
        var tester :NSArray = []
        return tester
    }
    
    func demo(token:String)->NSArray{
       
        var bilder:[NSArray] = []
        
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
     let response = Alamofire.request(url.demoUrl,method: .get,headers:headers).responseJSON()
      
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let images = JSON.object(forKey: "images") as? NSArray
            return images!
         
          }
        return bilder as NSArray
    }
    

}
