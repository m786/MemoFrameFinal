//
//  CollectionViewController.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 07.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit
//Klasse som håndterer visning av svar alternativer
class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //navn på celler som inneholder bilder
    let reuseIdentifier = "cell"
    //motar array med bilder som skal vises
    var alternativer:[UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(alternativer.count)
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // Funksjonen som forteller hvor mange celler som skal lages
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.alternativer.count
    }
    
    // lager 1 celle for hver celle index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // getmetode for referanse i storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        // bruk outlet i klassen getmetode for en referanse av UILabel i cellen
        
        // cell.celleBilde = self.alternativer[indexPath.item]
        
        // cell.backgroundColor = UIColor.cyan // gjør cellene synlig
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // behandling av touch på skjermen
        print("Du trakk på cellen #\(indexPath.item)!")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

