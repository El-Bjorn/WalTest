//
//  ProductServer.swift
//  Waltest
//
//  Created by BjornC on 4/5/17.
//  Copyright © 2017 bjorn. All rights reserved.
//

import UIKit

// I would have used struct but this needs to be a 
//    reference type so we can fetch in the image in the background
class Product {
    var index:Int? // same as index in product array
    var title:String
    var desc:String
    var image:UIImage?
    var price:String
        
    init(indx:Int?, title:String, desc:String, img:UIImage?, price:String) {
        self.index = indx
        self.title = title
        self.desc = desc.replacingOccurrences(of:"<[^>]+>", with: "", options:.regularExpression, range: nil)
        self.image = img
        self.price = price
    }
    
}

fileprivate let reuseId = "WalCell"
let getMoreThreshold = 10

final class ProductServer : NSObject, UICollectionViewDataSource {
    // not accessed directly so we can manage lazy loading
    var productArray:[Product] = []
    
    var numLoadedProducts: Int {
        get {
            return self.productArray.count
        }
    }
    
    override init() {
        super.init()
        
        DispatchQueue.global(qos: .background).async {
            let pd = ProdDownloader()
            pd.downloadNextPage() { err, prods in
                if err == nil {
                    for (i,prod) in prods.enumerated() {
                        prod.index = i
                    }
                    objc_sync_enter(self.productArray)
                    self.productArray.append(contentsOf: prods)
                    objc_sync_exit(self.productArray)
                    
                }
            }

        }
    }
    
    func redownload() {
        DispatchQueue.global(qos: .background).async {
            let pd = ProdDownloader()
            pd.downloadNextPage() { err, prods in
                if err == nil {
                    for (i,prod) in prods.enumerated() {
                        prod.index = i
                    }
                    //dispatch
                    //objc_sync_enter(self.productArray)
                    self.productArray.append(contentsOf: prods)
                    //objc_sync_exit(self.productArray)
                    
                }
            }
            
        }

    }
    
    
    // MARK: -
    // MARK: Product Data Methods
    
    // all requests come through here so we know when to download more stuff
    func getProductAtIndex(_ index:Int) -> Product? {
        //print("getting \(index)")
        // see if we need to get more
        if (numLoadedProducts-index) < getMoreThreshold {
            DispatchQueue.global(qos: .background).async {
                let pd = ProdDownloader()
                    pd.downloadNextPage() { err, prods in
                        // add the indexes
                        for (i,prod) in prods.enumerated() {
                        prod.index = i+self.numLoadedProducts
                        }
                        if err == nil {
                            objc_sync_enter(self.productArray)
                            self.productArray.append(contentsOf: prods)
                            objc_sync_exit(self.productArray)
                        }
                    }

            }
        }
        
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
        // clear old images
        cell.productImage.image = nil
        
        let ourProd = getProductAtIndex(indexPath.row)
        if ourProd?.image != nil {
            cell.productImage.image = ourProd?.image
        }
        
        
        return cell
    }
    
}
