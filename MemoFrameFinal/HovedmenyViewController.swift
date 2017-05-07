//
//  HovedmenyViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class HovedmenyViewController: UIViewController {

    var brukerInfo : NSDictionary = [:]
    var epost: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func brukerID()
    {
        for (k,v) in brukerInfo{
            if(k as! String == "Email"){
                epost = v as! String
            }
        }
    }
    
    @IBAction func taTester(_ sender: UIButton) {
        self.performSegue(withIdentifier: "velgTester", sender: brukerInfo)
    }
    @IBAction func testresultater(_ sender: UIButton) {
        self.performSegue(withIdentifier: "resultater", sender: brukerInfo)
    }
    @IBAction func bruker(_ sender: UIButton) {
        self.performSegue(withIdentifier: "endreBruker", sender: brukerInfo)
    }

    @IBAction func instillinger(_ sender: UIButton) {
        self.performSegue(withIdentifier: "setup", sender: brukerInfo)
    }
    @IBAction func loggUt(_ sender: UIButton) {
       brukerInfo = [:]
        epost = ""
      
    }
  
    // forbereder data til å bli flyttet fra denne viewen tl en annen via en segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "velgTester" {
            
            if let destination = segue.destination as? TesterViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary!)!
            }
        }
        else if segue.identifier == "resultater" {
            
            if let destination = segue.destination as? ResultaterViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary!)!
            }
        }
        else if segue.identifier == "endreBruker" {
            
            if let destination = segue.destination as? OppdaterBrukerViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary!)!
            }
        }
        else if segue.identifier == "setup" {
            
            if let destination = segue.destination as? InstillingerViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary!)!
            }
        }
    }

}
