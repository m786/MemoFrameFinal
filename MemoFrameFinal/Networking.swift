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
            "x-access-token": token
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
        print(response)
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let err = JSON.object(forKey: "Error") as? Bool
            
            if(!err!){
                status = true
            }
        }

        return status
        
    }
    //Får alle tester i database, er brukt i liste for å kunne velge blandt tester
    func getBildeTester(token:String)->NSArray
    {
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
        
    let response = Alamofire.request(url.BildeTesterUrl,method: .get,headers:headers).responseJSON()
     
        
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let err = JSON.object(forKey: "Error") as? Bool
            let msg = JSON.object(forKey: "Message") as! String
            if(!err!){
               
                 var tester = (JSON.object(forKey: "Tests") as? NSArray)!
                return tester
            }
     }
        var tester :NSArray = []
        return tester
    }
    
    //funksjon for å få bilder inn i demostrasjonen (view)
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
    
    //Når brukeren velger en test og går til view for å ta test kalles det på denne metoden
    func getBilderPåValgtTest(token:String,testid:Int)->NSArray{
        //Header
        let headers : HTTPHeaders = [
            "x-access-token": token
            
        ]
        //parametere
        let parameters: Parameters = [
            "testid": String(testid)
        ]
        //kaller på backend metode for å få bilder på valgt test
 let response = Alamofire.request(url.singleTestIdUrl,method: .get,parameters:parameters,headers:headers).responseJSON()
        
        var array:NSArray = []
        
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            
            let json = JSON.object(forKey: "Testrunder") as? NSArray
            array = json!
        }
        return array
    }
    
    //metode som lagrer resultatet i  databasen over nettet
    func save(token:String,info:String,testid:Int,tid:String,poengBilde:Int,tiden:String)->Bool{
        var ok:Bool = false
        
        //Header
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
        //parametere som blir sendt til backend
        let parameters: Parameters = [
            "email":info,
            "testid":testid,
            "tid_start":tid,
            "poeng":poengBilde,
            "tid_slutt":tiden
        ]
     let response =  Alamofire.request(url.lagreTestUrl,method: .post,parameters:parameters,headers:headers).responseJSON()
        
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let err = JSON.object(forKey: "Error") as! Bool
            let msg = JSON.object(forKey: "Message") as! String
            print(msg)
            if(!err){
            ok = true
            }
        }
        return ok
    }
//pinkode logg inn
    func loginnMedPin(token:String,pinKode:UITextField)->String{
        var info:String = ""
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
        let parameters: Parameters = [
            "kode": pinKode.text!
        ]
        let response =
            Alamofire.request(url.pinkodeLoginnUrl,method: .post,parameters:parameters,headers:headers).responseJSON()
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let err = JSON.object(forKey: "Error") as? Bool
            let msg = JSON.object(forKey: "Message") as! String
            
            if(!err!){
                //her skal man kunne gå til et annet view, kan bruke msg for å gi brukern melding om at bruker er lagt til.og token for å ta med videre.
                let pinkode = JSON.object(forKey: "Pinkode") as? String
                if let bruker = JSON.object(forKey: "User") as? Int{
                info = String(bruker)
                }
            }
        }
      return info
    }
    
    //Glemt passord
    func glemtPassord(token:String,epostFelt:UITextField)->Bool{
        var ok:Bool = false
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
        
        let parameters: Parameters = [
            "email": epostFelt.text!
        ]
let response =   Alamofire.request(url.resetPassord,method: .post,parameters:parameters,headers:headers).validate().responseJSON()
        print(response)
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let err = JSON.object(forKey: "Error") as! Bool
            let msg = JSON.object(forKey: "Message") as! String
            if(err){
                
            ok = true
       
            }
            else{
            
                return false
                
                
            }
        }
        
     return ok
    }
    
    //Kontakt oss
    func kontaktOss(token:String,tilbakemelding:UITextView,epost:UITextField)->Bool{
         var ok = false
        let parameters: Parameters = [
            "email": epost.text!,
            "melding": tilbakemelding.text!
        ]
        
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
         let response = Alamofire.request(url.kontaktOssUrl,method: .post,parameters:parameters,headers:headers).responseJSON()
        
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let err = JSON.object(forKey: "Error") as! Bool
            let msg = JSON.object(forKey: "Message") as! String
            if(!err){
            ok = true
            }
        }
        return ok
    }
    
    //endre passord med email aderesse
    func endrePassord(token:String,nyPassord:UITextField,epost:UITextField){
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
        let parameters: Parameters = [
            "passord": nyPassord.text!,
            "email": epost.text!
        ]
           let response = Alamofire.request(url.addUserUrl,method: .put,parameters:parameters,headers:headers).responseJSON()
        print(response)
    }
    
    //Få bilder returnert av server på valgt pinkode
    func getPinkodeTest(pinkode:String,token:String)->NSDictionary{
        let headers : HTTPHeaders = [
            "x-access-token": token
        ]
        let parameters: Parameters = [
            "pincode": pinkode
        ]
        let response = Alamofire.request(url.pinkodeBilder,method: .get,parameters:parameters,headers:headers).responseJSON()
    
        var array:NSDictionary = [:]
        
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            
            let json = JSON.object(forKey: "Tests") as? NSDictionary
            let err = JSON.object(forKey: "Error") as! Bool
            if(!err){
             array = json!
            }
           
        }
        return array
    
    }
}
