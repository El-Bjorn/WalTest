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
    let spinner = UIActivityIndicatorView()
    
    func startSpinner() {
        if !self.spinner.isAnimating {
            self.spinner.startAnimating()
        }
    }
    func stopSpinner() {
        self.spinner.stopAnimating()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        ourProdServer.wpc = self
        
        // activity indicator
        self.spinner.hidesWhenStopped = true
        self.spinner.activityIndicatorViewStyle = .gray //.whiteLarge
        //self.spinner.center = (self.collectionView?.center)!
        self.spinner.center = self.view.center
        self.view?.addSubview(self.spinner)

        
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
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.spinner.center = self.view.center
    }
    
    func doCollectionViewReload() {
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        startSpinner()
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "ProdDetailView") as! ProdDetailViewController
        detailVC.ourProductServer = self.ourProdServer
        detailVC.currProduct = self.ourProdServer.getProductAtIndex(indexPath.row)
        self.navigationController!.pushViewController(detailVC, animated: true)
        stopSpinner()
    }

}
