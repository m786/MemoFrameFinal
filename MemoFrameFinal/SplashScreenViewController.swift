//
//  SplashScreenViewController.swift
//  MemoFrameFinal
//
//  Created by Christopher Reyes on 21.04.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
   
    @IBOutlet weak var animationText: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.animationText.alpha = 0
        textAnimation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // animerer introtekst
    func textAnimation() {
        
        UIView.animate(withDuration: 1.0, animations: {
            
            self.animationText.alpha = 1.0
    
            
            
        }, completion: {
            (Completed:Bool) -> Void in
            
            UIView.animate(withDuration: 2.0, delay: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
                
                self.animationText.alpha = 0
                
            }, completion: {
                (Completed : Bool) -> Void in
                
                self.performSegue(withIdentifier: "goToIndex", sender: nil)
                self.textAnimation()
            })
            
        })
    }
    
    /*func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }*/

}
