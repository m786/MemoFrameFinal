//
//  TesterViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class TesterViewController: UIViewController {

    var brukerInfo : NSDictionary = [:]
    
    //Knapper
    @IBOutlet weak var bildeTestKnapp: UIButton!
    @IBOutlet weak var lydTestKnapp: UIButton!
    @IBOutlet weak var bildeOgLydKnapp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bildeTester(_ sender: UIButton) {
        self.performSegue(withIdentifier: "bildeTestUtvalg", sender: brukerInfo)
    }
    
    @IBAction func lydTest(_ sender: UIButton) {
       // self.performSegue(withIdentifier: "lydtester", sender: brukerInfo)
    }
    
    @IBAction func bildeLydTest(_ sender: UIButton) {
       // self.performSegue(withIdentifier: "lydogbildetester", sender: brukerInfo)
    }

    @IBAction func loggUt(_ sender: UIButton) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "bildeTestUtvalg" {
            
            if let destination = segue.destination as? BildeTesterViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary)!
            }
        }
        else    if segue.identifier == "lydtester" {
            
            if let destination = segue.destination as? BildeTesterViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary)!
            }
        }
        else if segue.identifier == "lydogbildetester" {
            
            if let destination = segue.destination as? BildeTesterViewController {
                
                // må være samme type som det variabelen som skal ta imot i det andre viewet
                destination.brukerInfo = (sender as? NSDictionary)!
            }
        }
    }

}
