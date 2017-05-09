//
//  BildeTestenViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 07.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//View for valgt test

import UIKit
import Alamofire
import AlamofireImage

class BildeTestenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    //objekter motatt fra view
    var brukerInfo : NSDictionary = [:]
    var testObjekt : TestInfo?
    var databrukerTester: testOgbrukerInfo?
    
    var info: String = ""
    var token:String = ""
    
    //CollectionView her vises alternativer
    @IBOutlet weak var collectionView: UICollectionView!
    //Knapper
    @IBOutlet weak var nesteKnapp: UIButton!
    @IBOutlet weak var avsluttKnapp: UIButton!
    @IBOutlet weak var startKnapp: UIButton!
    @IBOutlet weak var svarKnapp: UIButton!
    
    //image view som viser singel bilde
    @IBOutlet weak var bildeRamme: UIImageView!
    //labels
    @IBOutlet weak var poeng: UILabel!
    @IBOutlet weak var poengLabel: UILabel!
    @IBOutlet weak var bildenr: UILabel!
    @IBOutlet weak var opgaveLabel: UILabel!
    //Variabler
    private var label: UILabel? = nil
    private var bildeArray: [UIImage] = []
    private var bilder:[UIImage] = []
    private var imageIndex: NSInteger = 0
    private var bildeId : Int? = nil
    private var valgtBilde :Int? = nil
    private var poengBilde :Int = 0
    private var påBilde:Int = 0
    private var valgteBilder : [Int] = []
    let reuseIdentifier = "cell"
    var imageCounter: Int = 0
    private var testRunder: [Testen] = []
    var tiden = Tid()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = true
        nesteKnapp.isHidden = true
        avsluttKnapp.isHidden = true
        poengLabel.isHidden = true
        poeng.isHidden = true
        opgaveLabel.isHidden = true
        bildenr.isHidden = true
        svarKnapp.isHidden = true
        behandleMotattData()
        separereTokenOgEmail(data: brukerInfo)
        tekst()
        startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //metode som viser intro test
    private func tekst(){
        bildeRamme.backgroundColor = UIColor.white
        label = UILabel(frame: bildeRamme.bounds)
        label?.text = "Her komer intro tekst"
        bildeRamme.addSubview(label!)
    }

    //behandle motatt data fra view
    private func behandleMotattData(){
    testObjekt = databrukerTester?.testInfo
    brukerInfo = (databrukerTester?.brukerInfo)!
    }
    
//metode som starter spillet
    private func startGame(){
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        if(!token.isEmpty){
            var obj = self.testObjekt?.testid
        var json = nodeJs.getBilderPåValgtTest(token: token, testid: obj!)
            if(json.count != 0){
                lageTesten(json:json)
                print("Testen ble laget")
            }
            else{
                print("json bilder feilet")
            }
        }
    }
    //metode som legger tilrette testen som skal vises
    private func lageTesten(json:NSArray)
    {
        for i in json
        {
            print("json tester")
            var test = Testen()
            if let data = i as? NSDictionary{
                
                for (key,v) in i as! NSDictionary{
                    if(key as! String == "tekst"){
                        test.tekst = v as! String
                    }
                    else if(key as! String == "testrundeid"){
                        test.testrundeid = v as! Int
                    }
                    else if(key as! String == "bilder"){
                        test.bilder = v as! [String]
                    }
                    else if(key as! String == "testid"){
                        test.testid = v as! Int
                    }
                    else if(key as! String == "rundenr"){
                        test.rundenr = v as! Int
                    }
                }
                
            }
            self.testRunder.append(test)
        }
    }
    
    //Token og email for bruker
    func separereTokenOgEmail(data:NSDictionary){
        if let d = data as? NSDictionary{
            for(key,v) in d as! NSDictionary{
                if(key as! String == "Email"){
                info = v as! String
                }
                else if(key as! String == "Token"){
                token = v as! String
                }
            }
        }
    
    }
    //metideo som lagrer resultatet i databasen
    private func lagreResultat()
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy H:mm"
        var tid = formatter.string(from: date)
        
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        if(!token.isEmpty){
            if(nodeJs.save(token:token, info: self.info, testid: (self.testObjekt?.testid)!, tid: tid, poengBilde: self.poengBilde, tiden: self.tiden.getTid())){
                print("Resultat lagret")
            }
            else{
            print("Resultat ikke lagret")
            }
        }

    }
    //Metode som retunerer random Int
    private func random(size:Int)->Int{
        let randomNum:UInt32 = arc4random_uniform(UInt32(size))
        let someInt:Int = Int(randomNum)
        return someInt
    }
    //Metode som sjekker om samme bilde ikke vises,deaktiverer metoden kan aktiveres ved å komentere ut koden
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
    
   //Initialiserer bilder array
    private func initBilder(){
        
        for i in testRunder{
            print(i)
            //if(i.rundenr == 1){
                for j in i.bilder{
                    print(j)
                    Alamofire.request(j).responseImage { response in
                        print(response)
                        if let image = response.result.value {
                            self.bilder.append(image)
                            print("bilder lagt til i rundenr")
                            print(i)
                        }
                    }
                }
            //}
        }
     }
////////////////////////////////////////////// Knapper ///////////////////////////////////////////////
    
    @IBAction func start(_ sender: UIButton) {
        label?.text = "Trykk på neste for å starte testen!"
        poengLabel.isHidden = false
        poeng.isHidden = false
        opgaveLabel.isHidden = false
        bildenr.isHidden = false
        startKnapp.isHidden = true
        // startKnapp = true
        initBilder()
        nesteKnapp.isHidden = false
        tiden.startTiden()

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
        nesteKnapp.isHidden = true
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.bildeRamme.image = nil
            
        }
        let when1 = DispatchTime.now() + 4 //etter at det har gått 4 sec fra den metoden over
        DispatchQueue.main.asyncAfter(deadline: when1) {
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            self.nesteKnapp.isHidden = true
            self.svarKnapp.isHidden = false
            
        }
    }
    
    @IBAction func svar(_ sender: UIButton) {
        if(valgtBilde == nil){
            /* Metoden kan aktiveres dersom det ønskes at brukren skal velge en bilde
             let alert = UIAlertController(title: "Melding", message: "Vennligst velg et svar", preferredStyle: UIAlertControllerStyle.alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
             */
            self.bildeRamme.image = nil
            nesteKnapp.sendActions(for: UIControlEvents.touchUpInside)
        }
        else if(påBilde>bilder.count-1){
            if(self.bildeId == self.valgtBilde || self.bildeId == 0 && valgtBilde == nil){
                self.poengBilde+=1
                self.poeng.text = "\(poengBilde)"
            }
            self.svarKnapp.isHidden = true
            self.bildeRamme.image = nil
            self.avsluttKnapp.isHidden = false
            self.collectionView.isHidden = true
            self.label?.text = "Du fikk totalt \(poengBilde) av antall \(bilder.count) poeng"
            tiden.stopTiden()
        }
        else{
            self.nesteKnapp.isHidden = false
            self.svarKnapp.isHidden = true
            self.collectionView.isHidden = true
            
            if(self.bildeId == self.valgtBilde || self.bildeId == 0 && valgtBilde == nil){
                self.poengBilde+=1
                self.poeng.text = "\(poengBilde)"
            }
            
            self.bildeRamme.image = nil
            nesteKnapp.sendActions(for: UIControlEvents.touchUpInside)
        }
    }
    
    @IBAction func avslutt(_ sender: UIButton) {
        lagreResultat()
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
        svarKnapp.sendActions(for: UIControlEvents.touchUpInside)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
        cell?.layer.borderColor = UIColor.white.cgColor
        print("Ikke valgt")
        
    }
    /////////////////////// Slutt på collectionView /////////////////////////////////////////////////
}
