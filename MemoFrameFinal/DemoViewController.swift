//
//  DemoViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 07.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DemoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    //CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    //Knapp kalt neste   
    @IBOutlet weak var neste: UIButton!
    //Knapp avslutt dukker etter siste oppgave
    @IBOutlet weak var avslutt: UIButton!
    //start knapp som starter "spillet"
    @IBOutlet weak var start: UIButton!
    //Svar knapp
    @IBOutlet weak var svar: UIButton!
    //variabel som viser oppgave bildet
    @IBOutlet weak var bildeRamme: UIImageView!
    
    @IBOutlet weak var poeng: UILabel!
    @IBOutlet weak var poengsum: UILabel!
    @IBOutlet weak var bildenr: UILabel!
    @IBOutlet weak var bilde: UILabel!
    
    
    private var bildeArray: [UIImage] = []
    
    private var label: UILabel? = nil
    
    private var startKnapp: Bool = false
    
    private var bilder:[UIImage] = []
    
    private var imageIndex: NSInteger = 0
    
    private var bildeId : Int? = nil
    
    private var valgtBilde :Int? = nil
    
    private var poengBilde :Int = 0
    
    private var påBilde:Int = 0
    
    private var valgteBilder : [Int] = []
    
    let reuseIdentifier = "cell"
    
    var imageCounter: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.isHidden = true
        neste.isHidden = true
        avslutt.isHidden = true
        poeng.isHidden = true
        poengsum.isHidden = true
        bilde.isHidden = true
        bildenr.isHidden = true
        svar.isHidden = true
        tekst()
        startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func tekst(){
        bildeRamme.backgroundColor = UIColor.white
        label = UILabel(frame: bildeRamme.bounds)
        label?.text = "Hei og velkommen til demoen, her vil du først se et bilde "
        bildeRamme.addSubview(label!)
    }
    
    private func startGame(){
        
        
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        if(!token.isEmpty){
        
        var image = nodeJs.demo(token: token) as? NSArray
        if(image?.count != 0){
            var objCArray = NSMutableArray(array: image!)
            if let swiftArray = objCArray as NSArray as? [String] {
                if(swiftArray.count>0){
                    
                    for i in swiftArray{
                        Alamofire.request(i).responseImage { response in
                            if let image = response.result.value {
                                self.bilder.append(image)
                            }
                        }
                    }
                }
            }
            }
            
        }
    }
    
    private func random(size:Int)->Int{
        let randomNum:UInt32 = arc4random_uniform(UInt32(size))
        let someInt:Int = Int(randomNum)
        return someInt
    }
    
    private func sjekk(index:Int)->Int{
        var tall :Int = random(size: index)
        var finnes:Bool = false
        var ok:Bool = true
        
        if(valgteBilder.isEmpty){
            valgteBilder.append(tall)
            return tall
        }
        while(ok){
            for i in valgteBilder{
                if(i == tall){
                    finnes = true
                }
            }
            if(!finnes){
                valgteBilder.append(tall)
                return tall
            }
            tall = random(size: index)
            finnes = false
        }
        return tall
    }
    
    
    @IBAction func start(_ sender: UIButton) {
        
        label?.text = "Trykk på neste for å starte testen!"
        poeng.isHidden = false
        poengsum.isHidden = false
        bilde.isHidden = false
        bildenr.isHidden = false
        start.isHidden = true
        startKnapp = true
        neste.isHidden = false
        self.neste.sendActions(for: UIControlEvents.touchUpInside)
    }
    
    @IBAction func neste(_ sender: UIButton) {
        label?.text = ""
        collectionView.isHidden = true
        valgtBilde = bilder.count-1
        påBilde+=1
        bildeRamme.image = nil
        bildenr.text = "\(påBilde) av \(bilder.count)"
        bildeId = sjekk(index: bilder.count)
        bildeRamme.image = bilder[bildeId!]
        neste.isHidden = true
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.bildeRamme.image = nil
            self.label?.text = "Vennligs vent"
        }
        let when1 = DispatchTime.now() + 4 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when1) {
            self.label?.text = ""
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            self.neste.isHidden = true
            self.svar.isHidden = true
            
        }
    }
    
    @IBAction func svar(_ sender: UIButton) {
        
        if(valgtBilde == nil){
            let alert = UIAlertController(title: "Melding", message: "Vennligst velg et svar", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(påBilde>bilder.count-1){
            if(self.bildeId == self.valgtBilde || self.bildeId == 0 && valgtBilde == nil){
                self.poengBilde+=1
                self.poengsum.text = "\(poengBilde)"
            }
            self.svar.isHidden = true
            self.bildeRamme.image = nil
            self.collectionView.isHidden = true
            self.avslutt.isHidden = false
            self.label?.text = "Du fikk totalt \(poengBilde) av antall \(bilder.count) poeng"
        }
        else{
            self.neste.isHidden = false
            self.svar.isHidden = true
            self.collectionView.isHidden = true
            
            if(self.bildeId == self.valgtBilde || self.bildeId == 0 && valgtBilde == nil){
                self.poengBilde+=1
                self.poengsum.text = "\(poengBilde)"
                
            }
            self.bildeRamme.image = nil
            neste.sendActions(for: UIControlEvents.touchUpInside)
        }
    }
    
    @IBAction func avslutt(_ sender: UIButton) {
        self.label?.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    ////////////////////////// Collectionview ///////////////////////////////////////////////////////
    // MARK: - UICollectionViewDataSource protocol
    
    // Funksjonen som forteller hvor mange celler som skal lages
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bilder.count
    }
    
    // lager 1 celle for hver celle index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // getmetode for referanse i storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        cell.celleBilde.image = self.bilder[imageCounter]
        // bruk outlet i klassen getmetode for en referanse av UILabel i cellen
        self.imageCounter += 1
        if self.imageCounter >= self.bilder.count {
            
            self.imageCounter = 0
            
        }
        
        // cell.backgroundColor = UIColor.cyan // gjør cellene synlig
        cell.layer.borderWidth = 0
        cell.layer.backgroundColor = UIColor.white.cgColor
        valgtBilde = nil
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // behandling av touch på skjermen
        valgtBilde = indexPath.item
        
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 10.0
        cell?.layer.borderColor = UIColor.green.cgColor
        
        print("Du trakk på cellen #\(indexPath.item)!")
        svar.sendActions(for: UIControlEvents.touchUpInside)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
        cell?.layer.borderColor = UIColor.white.cgColor
        print("Ikke valgt")
    }
    ///////////////////////// Slutt på collectionView /////////////////////////////////////////////////
    

}
