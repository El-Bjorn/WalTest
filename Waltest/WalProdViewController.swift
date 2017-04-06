//
//  WalProdViewController.swift
//  Waltest
//
//  Created by BjornC on 4/5/17.
//  Copyright © 2017 bjorn. All rights reserved.
//

import UIKit

private let reuseId = "WalCell"

final class WalProdViewController: UICollectionViewController {
    
    //fileprivate let reuseIdentifier = "Walcell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let ourProdServer = ProductServer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegates for product server
        //self.collectionView?.delegate = ourProdServer
        self.collectionView?.dataSource = ourProdServer
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    // MARK: UICollectionViewDataSource

   /* override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 30
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! WalViewCell
        //cell.backgroundColor = UIColor.black
        
        if let imagePath = Bundle.main.path(forResource: "testImage", ofType: "jpeg") {
            if let image = UIImage(contentsOfFile: imagePath){
                cell.productImage.image = image
            }

        }
        
        /*if let image = UIImage(named: "temp.png", in: Bundle(for: WalProdViewController.self), compatibleWith: nil){
            cell.productImage.image = image
        } */
        /*if let prodImage = UIImage(named:"testImage.jpeg") {
                    cell.productImage.image = prodImage
        } */

        
        //cell.
        // Configure the cell
    
        return cell
    } */

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "ProdDetailView") as! ProdDetailViewController
        detailVC.ourProductServer = self.ourProdServer
        detailVC.currProduct = self.ourProdServer.getProductAtIndex(indexPath.row)
        self.navigationController!.pushViewController(detailVC, animated: true)
        //self.performSegue(withIdentifier: "ProductDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetVC = segue.destination as! ProdDetailViewController
        targetVC.ourProductServer = self.ourProdServer
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
