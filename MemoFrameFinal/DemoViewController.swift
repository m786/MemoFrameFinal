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
    
    private var runder:Int = 7
    
    var imageCounter: Int = 0
    var delayTid:Int = 2
    var kalkulatorKontroller = Kalkulator()
    
    private var hjelpeArray:[UIImage] = []
    private var tomArray:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.isHidden = true
        neste.isHidden = true
        avslutt.isHidden = true
        bilde.isHidden = true
        bildenr.isHidden = true
        svar.isHidden = true
        poeng.isHidden = true
        poengsum.isHidden = true
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
        label?.font = UIFont(name: "Futura-Medium", size: 50)!
        label?.text = "Hei og velkommen til testen! Du vil bli presentert med et bilde. Trykk på det samme bilde blant alternativene som vises etterpå."
        label?.textAlignment = .center
        label?.lineBreakMode = NSLineBreakMode.byWordWrapping
        label?.numberOfLines = 10
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
    //metode for å ikke velge samme bilde for å vise
    private func sjekk(index:Int)->Int{
        var tall :Int = random(size: index)
       /* var finnes:Bool = false
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
        }*/
        return tall
    }
    //kopierer arrays
    func copyArrays(tomArray: inout [UIImage],originalArray:[UIImage]){
        for i in originalArray{
            tomArray.append(i)
            
        }
    }
    //Hjelpe metode som hjelper med å vise 4 og 4 bilder isteden for alt som kommer fra backend
    func arrayBehandler()
    {
       
        var i  :Int = 0
        if(bilder.count == 0){
         
        copyArrays(tomArray: &bilder, originalArray: tomArray)
        }
        
        if(hjelpeArray.count == 0){
        while i < 4{
            if(i <= bilder.count-1){
     
        hjelpeArray.append(bilder.remove(at:0))
                
                        }
            i += 1
            }
        }
        else{
            hjelpeArray = []
            while i < 4{
             
                if(!bilder.isEmpty){
                hjelpeArray.append(bilder.remove(at:0))
                
                }
            i += 1
            }
        }
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
        copyArrays(tomArray: &tomArray, originalArray: bilder)
        self.neste.sendActions(for: UIControlEvents.touchUpInside)
    }
    
    @IBAction func neste(_ sender: UIButton) {
        poengsum.isHidden = true
        poeng.isHidden = true
        label?.text = ""
        collectionView.isHidden = true
        valgtBilde = bilder.count-1
        påBilde+=1
        bildeRamme.image = nil
        bildenr.text = "\(påBilde) av \(runder)"
        arrayBehandler()
        bildeId = sjekk(index: hjelpeArray.count)
        bildeRamme.image = hjelpeArray[bildeId!]//bilder[bildeId!]
        neste.isHidden = true
       
       // let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
       // DispatchQueue.main.asyncAfter(deadline: when) {
        delayWithSeconds(2){
            self.bildeRamme.image = nil
            self.label?.text = "Vennligs vent..."
        }
       // }
        
        //let when1 = DispatchTime.now() + 4  // change 2 to desired number of seconds
       // DispatchQueue.main.asyncAfter(deadline: when1) {
        delayWithSeconds(Double(delayTid+2)){
            self.label?.text = ""
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            self.neste.isHidden = true
            self.svar.isHidden = true
        }
        //}
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    @IBAction func svar(_ sender: UIButton) {
        var delaytidOkes:Bool = true
        
        if(valgtBilde == nil){
            let alert = UIAlertController(title: "Melding", message: "Vennligst velg et svar", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(påBilde>=runder){
            if(self.bildeId == self.valgtBilde || self.bildeId == 0 && valgtBilde == nil){
                self.poengBilde+=1
                self.poengsum.text = "\(poengBilde)"
            }
            self.svar.isHidden = true
            self.bildeRamme.image = nil
            self.collectionView.isHidden = true
            self.avslutt.isHidden = false
            self.label?.text = "Du fikk totalt \(poengBilde) av antall \(runder) poeng"
        }
        else{
            self.neste.isHidden = false
            self.svar.isHidden = true
            self.collectionView.isHidden = true
            
            if(self.bildeId == self.valgtBilde || self.bildeId == 0 && valgtBilde == nil){
                self.poengBilde+=1
                self.poengsum.text = "\(poengBilde)"
                delayTid = kalkulatorKontroller.kalkulatorKontroller(delayTid: delayTid, poeng: 1)
                delaytidOkes = false
            }
           
            if(delaytidOkes){
            delayTid = kalkulatorKontroller.kalkulatorKontroller(delayTid: delayTid, poeng: 0)
            }
            self.bildeRamme.image = nil
            neste.sendActions(for: UIControlEvents.touchUpInside)
        }
    }
    
    @IBAction func avslutt(_ sender: UIButton) {
        self.label?.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func avsluttDemo(_ sender: UIButton) {
        self.label?.text = ""
        self.dismiss(animated: true, completion: nil)
        
    }
    
    ////////////////////////// Collectionview ///////////////////////////////////////////////////////
    // MARK: - UICollectionViewDataSource protocol
    
    // Funksjonen som forteller hvor mange celler som skal lages
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.bilder.count
        
        return self.hjelpeArray.count
    }
    
    // lager 1 celle for hver celle index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // getmetode for referanse i storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        //cell.celleBilde.image = self.bilder[imageCounter]
        cell.celleBilde.image = self.hjelpeArray[imageCounter]
        // bruk outlet i klassen getmetode for en referanse av UILabel i cellen
       //self.bilder.count
        self.imageCounter += 1
        if self.imageCounter >= self.hjelpeArray.count {
            
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
