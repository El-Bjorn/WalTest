//
//  ProdDetailViewController.swift
//  Waltest
//
//  Created by BjornC on 4/5/17.
//  Copyright © 2017 bjorn. All rights reserved.
//

import UIKit

class ProdDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var prductDesc: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    weak var ourProductServer:ProductServer?
    var currProduct:Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "\(self.currProduct!.index)"
        
        let rightSwipeRecog = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight(recognizer:)))
        rightSwipeRecog.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipeRecog)
        
        let leftSwipeRecog = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft(recognizer:)))
        leftSwipeRecog.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipeRecog)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSwipeRight(recognizer: UISwipeGestureRecognizer){
        print("did swipe right")
        self.navigationController!.popViewController(animated: true)
    }
    
    func didSwipeLeft(recognizer: UISwipeGestureRecognizer){
        print("did swipe left")
        if (self.currProduct?.index)! < (self.ourProductServer?.numLoadedProducts)! {
            let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "ProdDetailView") as! ProdDetailViewController
            detailVC.ourProductServer = self.ourProductServer
            detailVC.currProduct = self.ourProductServer?.getProductAtIndex((self.currProduct?.index)!+1)
            self.navigationController!.pushViewController(detailVC, animated: true)
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
