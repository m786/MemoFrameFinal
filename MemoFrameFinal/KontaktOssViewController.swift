//
//  KontaktOssViewController.swift
//  MemoFrameFinal
//
//  Created by Christopher Reyes on 01.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class KontaktOssViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tekstFelt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        tekstFelt.delegate = self
        tekstFelt.font = UIFont(name: "Futura", size: 35.0)
        tekstFelt.text = "Trykk her for å skrive din kommentar"
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        tekstFelt.text = ""
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
