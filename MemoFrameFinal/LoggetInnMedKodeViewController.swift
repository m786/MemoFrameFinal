//
//  LoggetInnMedKodeViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 09.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import AlamofireImage
import Alamofire_Synchronous

class LoggetInnMedKodeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    //Her blir bruker og pinkode lagret
    var brukerOgToken : NSDictionary = [:]
    
    var bruker: String = ""
    var pinkode:String = ""
    var runder :Int = 0
    var testid = ""
    var testInfo : NSDictionary = [:]
    var obj = TestInfo()
    
    //CollectionView her vises alternativer
    @IBOutlet weak var collectionView: UICollectionView!
    //Knapper
    @IBOutlet weak var nesteKnapp: UIButton!
    @IBOutlet weak var startKnapp: UIButton!
    @IBOutlet weak var svarKnapp: UIButton!
    
    //image view som viser singel bilde
    @IBOutlet weak var bildeRamme: UIImageView!
    //lable so viser bilde nr
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
    private var hjelpeArray:[UIImage] = []
    private var tomArray:[UIImage] = []
    private var testRunder: [Testen] = []
    var tiden = Tid()
    var delayTid:Int = 2
    var kalkulatorKontroller = Kalkulator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        separerepinOgbruker(data: brukerOgToken)
        if(getTestInfo()){
        
            
            startKnapp.isHidden = true
            collectionView.isHidden = true
            nesteKnapp.isHidden = true
           // avsluttKnapp.isHidden = true
           // poengLabel.isHidden = true
           // poeng.isHidden = true
            opgaveLabel.isHidden = true
            bildenr.isHidden = true
            svarKnapp.isHidden = true
            behandleArray(motattArray: testInfo)
            tekst()
            startGame()
            initBilder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Token og pinkode for bruker
    func separerepinOgbruker(data:NSDictionary){
        if let d = data as? NSDictionary{
            for(key,v) in d as! NSDictionary{
                if(key as! String == "bruker"){
                    bruker = v as! String
                }
                else if(key as! String == "pinkode"){
                    pinkode = v as! String
                }
            }
        }
    }
    func getTestInfo()->Bool{
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        if(!token.isEmpty){
            testInfo = nodeJs.getPinkodeTest(pinkode: pinkode, token: token)
            if(testInfo.count != 0){
            return true
            }
            else{
            return false
            }
        }
        return false
    }
    
    //Behandler array motatt fra backend slik at det kan vises i tabellen
    func behandleArray(motattArray:NSDictionary){
            
            if let data = motattArray as? NSDictionary
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
    }
    
    //metode som viser intro test
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

    //metode som starter spillet
    private func startGame(){
        var nodeJs = Networking()
        var token = nodeJs.getToken()
        if(!token.isEmpty){
            var testid = obj.testid
            var json = nodeJs.getBilderPåValgtTest(token: token, testid: testid)
            if(json.count != 0){
                lageTesten(json:json)
                print("Testen ble laget")
            }
            else{
                print("json bilder feilet")
                return
            }
        }
    }
    
    //metode som legger tilrette testen som skal vises
    private func lageTesten(json:NSArray)
    {
        for i in json
        {
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
            runder += 1
            self.testRunder.append(test)
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
            if(nodeJs.save(token:token, info: self.bruker, testid: (self.obj.testid), tid: tid, poengBilde: self.poengBilde, tiden: self.tiden.getTid())){
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
            //if(i.rundenr == 1){
            for j in i.bilder{
                let res =  Alamofire.request(j).responseImage { response in
                    print(j)
                    print(response)
                    if let image = response.result.value {
                        self.bilder.append(image)
                        print("bilder lagt til i rundenr")
                        print(i)
                    }
                }
                res.downloadProgress(queue: DispatchQueue.global(qos: .default)) { progress in
                    // Codes at here will not be delayed
                    print("Download Progress: \(progress.fractionCompleted)")
                    
                    DispatchQueue.main.async {
                        // code at here will be delayed before the synchronous finished.
                        self.startKnapp.isHidden = false
                    }
                    
                    }.response()
                
                if let error = res.responseData().error {
                    print("Failed with error: \(error)")
                }else{
                    print("Downloaded file successfully")
                }
            }
            //}
        }
    }
    
    //Koperer original array for bruk av den senere
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
    ////////////////////////////////////////////// Knapper ///////////////////////////////////////////////
    @IBAction func avsluttTesten(_ sender: UIButton) {
        lagreResultat()
        self.label?.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func start(_ sender: UIButton) {
        
        label?.text = "Trykk på neste for å starte testen!"
      //  poengLabel.isHidden = true
       // poeng.isHidden = true
        opgaveLabel.isHidden = false
        bildenr.isHidden = false
        startKnapp.isHidden = true
        // startKnapp = true
        //initBilder()
        nesteKnapp.isHidden = false
        tiden.startTiden()
        copyArrays(tomArray: &tomArray, originalArray: bilder)
        self.nesteKnapp.sendActions(for: UIControlEvents.touchUpInside)
        
    }
    
    @IBAction func neste(_ sender: UIButton) {
        label?.text = ""
        collectionView.isHidden = true
        valgtBilde = bilder.count-1
        påBilde+=1
        bildeRamme.image = nil
        bildenr.text = "\(påBilde) av \(runder)"
        arrayBehandler()
        bildeId = sjekk(index: hjelpeArray.count)
        
        bildeRamme.image = hjelpeArray[bildeId!]
        nesteKnapp.isHidden = true
        
      //  let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
       // DispatchQueue.main.asyncAfter(deadline: when) {
            delayWithSeconds(2){
            self.bildeRamme.image = nil
            self.label?.text = "Vennligst vent..."
            }
       // }
        //let when1 = DispatchTime.now() + 4 //etter at det har gått 4 sec fra den metoden over
        //DispatchQueue.main.asyncAfter(deadline: when1) {
            delayWithSeconds(Double(delayTid)){
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            self.nesteKnapp.isHidden = true
            //self.svarKnapp.isHidden = false
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
            /* Metoden kan aktiveres dersom det ønskes at brukren skal velge en bilde
             let alert = UIAlertController(title: "Melding", message: "Vennligst velg et svar", preferredStyle: UIAlertControllerStyle.alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
             */
            self.bildeRamme.image = nil
            nesteKnapp.sendActions(for: UIControlEvents.touchUpInside)
        }
        else if(påBilde>=runder){
            if(self.bildeId == self.valgtBilde || self.bildeId == 0 && valgtBilde == nil){
                self.poengBilde+=1
         //       self.poeng.text = "\(poengBilde)"
            }
            self.svarKnapp.isHidden = true
            self.bildeRamme.image = nil
       //     self.avsluttKnapp.isHidden = false
            self.collectionView.isHidden = true
            self.label?.text = "Du fikk totalt \(poengBilde) riktige av \(runder) runder."
            tiden.stopTiden()
        }
        else{
            self.nesteKnapp.isHidden = false
            self.svarKnapp.isHidden = true
            self.collectionView.isHidden = true
            
            if(self.bildeId == self.valgtBilde || self.bildeId == 0 && valgtBilde == nil){
                self.poengBilde+=1
    //            self.poeng.text = "\(poengBilde)"
                delayTid = kalkulatorKontroller.kalkulatorKontroller(delayTid: delayTid, poeng: 1)
                delaytidOkes = false
            }
            
            if(delaytidOkes){
                delayTid = kalkulatorKontroller.kalkulatorKontroller(delayTid: delayTid, poeng: 0)
            }
            self.bildeRamme.image = nil
            nesteKnapp.sendActions(for: UIControlEvents.touchUpInside)
        }
    }
    
    @IBAction func avslutt(_ sender: UIButton) {
        lagreResultat()
        self.label?.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    ////////////////////////// Collectionview ///////////////////////////////////////////////////////
    // MARK: - UICollectionViewDataSource protocol
    
    // Funksjonen som forteller hvor mange celler som skal lages
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hjelpeArray.count
    }
    
    // lager 1 celle for hver celle index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // getmetode for referanse i storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        cell.celleBilde.image = self.hjelpeArray[imageCounter]
        // bruk outlet i klassen getmetode for en referanse av UILabel i cellen
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
