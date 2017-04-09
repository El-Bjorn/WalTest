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
    
    //fileprivate let reuseIdentifier = "Walcell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let ourProdServer = ProductServer()
    let spinner = UIActivityIndicatorView()
    
    func startSpinner() {
        self.spinner.startAnimating()
    }
    func stopSpinner() {
        self.spinner.stopAnimating()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinner.hidesWhenStopped = true
        self.spinner.activityIndicatorViewStyle = .gray
        self.spinner.center = (self.collectionView?.center)!
        self.collectionView?.addSubview(self.spinner)

        
        // set delegate for product server
        self.collectionView?.dataSource = ourProdServer
        
        // register for collectionview reloads
        let nc = NotificationCenter.default
        nc.addObserver(forName: NSNotification.Name(rawValue: reloadSignalNotif), object: nil, queue:nil) { (notif) in
            print("GOT RELOAD NOTIF")
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
}
