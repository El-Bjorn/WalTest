//
//  WalProdViewController.swift
//  Waltest
//
//  Created by BjornC on 4/5/17.
//  Copyright © 2017 bjorn. All rights reserved.
//

import UIKit

let reloadSignalNotif = "CollViewReloadNotif"

final class WalProdViewController: UICollectionViewController {
    
    let ourProdServer = ProductServer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set delegate for product server
        self.collectionView?.dataSource = ourProdServer
        
        // register for collectionview reloads
        let nc = NotificationCenter.default
        nc.addObserver(forName: NSNotification.Name(rawValue: reloadSignalNotif), object: nil, queue:nil) { (notif) in
            //print("GOT RELOAD NOTIF")
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    func doCollectionViewReload() {
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("got collectionview tap")
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "ProdDetailView") as! ProdDetailViewController
        detailVC.ourProductServer = self.ourProdServer
        detailVC.currProduct = self.ourProdServer.getProductAtIndex(indexPath.row)
        self.navigationController!.pushViewController(detailVC, animated: true)
    }

}
