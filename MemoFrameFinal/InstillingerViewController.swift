//
//  InstillingerViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 02.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class InstillingerViewController: UIViewController {

    var brukerInfo : NSDictionary = [:]
    

    @IBOutlet weak var av: UIButton!
    @IBOutlet weak var lav: UIButton!
    @IBOutlet weak var middels: UIButton!
    @IBOutlet weak var hoy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        middels.backgroundColor = UIColor(red: 100.0/255.0, green: 204.0/255.0, blue: 20.0/255.0, alpha: 1)

        lav.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
        hoy.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
        av.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
    }
    
    
    @IBAction func hoy(_ sender: Any) {
        middels.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
        lav.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
        hoy.backgroundColor = UIColor(red: 100.0/255.0, green: 204.0/255.0, blue: 20.0/255.0, alpha: 1)
        
        av.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
    }
        
    

    @IBAction func middels(_ sender: Any) {
        
        middels.backgroundColor = UIColor(red: 100.0/255.0, green: 204.0/255.0, blue: 20.0/255.0, alpha: 1)
        
        lav.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
        hoy.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
        av.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
    }
    
    @IBAction func lav(_ sender: Any) {
        
        middels.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
        lav.backgroundColor = UIColor(red: 100.0/255.0, green: 204.0/255.0, blue: 20.0/255.0, alpha: 1)
        
        hoy.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
        
        av.backgroundColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 0.5)
    }
    
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
