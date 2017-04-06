//
//  ProductServer.swift
//  Waltest
//
//  Created by BjornC on 4/5/17.
//  Copyright © 2017 bjorn. All rights reserved.
//

import UIKit

struct Product {
    var index:Int // same as index in product array
    var description:String
    var image:UIImage?
    var price:String
    
    init(indx:Int, desc:String, img:UIImage?, price:String) {
        self.index = indx
        self.description = desc
        self.image = img
        self.price = price
    }
}

fileprivate let reuseId = "WalCell"

class ProductServer : NSObject, UICollectionViewDataSource {
    // hidden so we can manage lazy loading
    private var productArray:[Product] = []
    
    var numLoadedProducts: Int {
        get {
            return self.productArray.count
        }
    }
    let pageSize = 30
    let apiKey = "d6e4b0f5-70f3-4baf-9137-c235eff0962d"
    
    override init() {
        super.init()
        
        // test data
        for i in 0..<50 {
            var newProd = Product(indx:i,desc:"some product",img:nil, price:"9.99")
            
            if let imagePath = Bundle.main.path(forResource: "testImage", ofType: "jpeg") {
                if let image = UIImage(contentsOfFile: imagePath){
                    newProd.image = image
                }
                
            }
            self.productArray.append(newProd)
        }
        
    }
    // MARK: -
    // MARK: Product detail methods
    func getProductAtIndex(_ index:Int) -> Product? {
        if index <= numLoadedProducts {
            return self.productArray[index]
        } else {
            return nil
        }
    }
    
    // MARK: -
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numLoadedProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! WalViewCell
        //cell.backgroundColor = UIColor.black
        
        let ourProd = productArray[indexPath.row]
        if ourProd.image != nil {
            cell.productImage.image = ourProd.image
        }
        
        /*if let imagePath = Bundle.main.path(forResource: "testImage", ofType: "jpeg") {
            if let image = UIImage(contentsOfFile: imagePath){
                cell.productImage.image = image
            }
            
        } */
        
        /*if let image = UIImage(named: "temp.png", in: Bundle(for: WalProdViewController.self), compatibleWith: nil){
         cell.productImage.image = image
         } */
        /*if let prodImage = UIImage(named:"testImage.jpeg") {
         cell.productImage.image = prodImage
         } */
        
        
        //cell.
        // Configure the cell
        
        return cell
    }
    
}
