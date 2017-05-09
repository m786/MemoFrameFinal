//
//  BildeTesterViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 07.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//Klasse for å kunne velge blandt alle tester

import UIKit
import PopupDialog

class BildeTesterViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    //Knapper
    @IBOutlet weak var velgTestKnapp: UIButton!
    @IBOutlet weak var taTestenKnapp: UIButton!
    
    //Tabell
    @IBOutlet weak var tabell: UITableView!
  
    @IBOutlet weak var beskrivelse: UITextView!

    let popupvindu = Popup()
    var testnr : Int = 0
    var testObjekt : [TestInfo] = []
    var array: [String] = []
    var brukerInfo : NSDictionary = [:]
    var dataBrukerTester = testOgbrukerInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Testknapp layout
        velgTestKnapp.backgroundColor = UIColor.white
        velgTestKnapp.layer.cornerRadius = 5
        velgTestKnapp.layer.borderWidth = 1
        velgTestKnapp.layer.borderColor = UIColor.blue.cgColor
        
        //Tabell layout
        tabell.backgroundColor = UIColor.white
        tabell.layer.cornerRadius = 5
        tabell.layer.borderWidth = 1
        tabell.layer.borderColor = UIColor.blue.cgColor
        
        tabell.isHidden = true
        taTestenKnapp.isHidden = true
        alleTester()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Får frem alle tester
    private func alleTester(){
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        if(!token.isEmpty){
            var array = nodeJs.getBildeTester(token: token)
            if(array.count != 0){
               behandleArray(motattArray: array)
            }
            else{
                print("Kunne ikke laste inn tester")
                let alert = UIAlertController(title: "Melding", message: "Kunne ikke laste inn tester, vennligs kontakt admin,eller prøv igjen.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
        //Behandler array motatt fra backend slik at det kan vises i tabellen
        func behandleArray(motattArray:NSArray){
            for i in motattArray
            {
                
                var obj = TestInfo()
                if let data = i as? NSDictionary
                {
                    
                    for (key,value) in data{
                        if(key as! String == "gyldig"){
                            obj.gyldig = value as! Int
                        }
                        else if(key as! String == "oppgavetekst"){
                            obj.oppgavetekst = value as! String
                        }
                        else if(key as! String == "testbeskrivelse"){
                            obj.testbeskrivelse = value as! String
                        }
                        else if(key as! String == "testid"){
                            obj.testid = value as! Int
                        }
                        else if(key as! String == "testnavn"){
                            self.array.append(value as! String)
                            obj.testnavn = value as! String
                        }
                        else if(key as! String == "tidsdelay"){
                            obj.tidsdelay = value as! Int
                        }
                        else if(key as! String == "vanskelighetsgrad"){
                            obj.vanskelighetsgrad = value as! Int
                        }
                    }
                }
                self.testObjekt.append(obj)
            }
        
        }
    
    //for å velge en test fra listen
    func numberOfSections(in tableView : UITableView) -> Int
    {
        return 1
    }
    
    //Retunerer antall felter i listen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    //lager celler
    func tableView(_ tabell: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell!{
        
        let cell = tabell.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = array[indexPath.row] as? String
        return cell
    }
    
    //setter valgt øverst
    func tableView(_ tabell: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let valgtFraListen = array[indexPath.row] as String
        velgTestKnapp.setTitle(valgtFraListen as String, for: .normal)
        testnr = indexPath.row
        tabell.isHidden = true
        taTestenKnapp.isHidden = false
        var b:String = testObjekt[testnr].toString()
        beskrivelse.text = ""
        beskrivelse.insertText(b)
    }
    
    // forbereder data til å bli flyttet fra denne viewen tl en annen via en segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "spillet" {
            
            if let destination = segue.destination as? BildeTestenViewController {
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                
                destination.databrukerTester = sender as? testOgbrukerInfo
               
            }
        }
    }
    
    //lister alle tester
    @IBAction func liste(_ sender: UIButton) {
        
        self.tabell.reloadData()
        if tabell.isHidden == true{
            tabell.isHidden = false
        }
        else{
            tabell.isHidden = true
            self.tabell.reloadData()
            
        }
    }
    //Ta valgt test
    @IBAction func taTesten(_ sender: UIButton) {
        dataBrukerTester.testInfo = testObjekt[testnr]
        dataBrukerTester.brukerInfo = brukerInfo
        
        self.performSegue(withIdentifier: "spillet", sender: dataBrukerTester)
    }
    
    //logg ut
    @IBAction func loggUt(_ sender: UIButton) {
    }
    }
