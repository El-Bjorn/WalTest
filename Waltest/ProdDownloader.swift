//
//  ProdDownloader.swift
//  Waltest
//
//  Created by BjornC on 4/8/17.
//  Copyright © 2017 bjorn. All rights reserved.
//

import UIKit

let pageSize = 30
fileprivate let apiKey = "d6e4b0f5-70f3-4baf-9137-c235eff0962d"
fileprivate let baseURL = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1"

class ProdDownloader {
    private var lastPageDownloaded:Int = 0
    
    func downloadNextPage(compHandler: @escaping (Error?,[Product]) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        lastPageDownloaded += 1
        
        let urlStr = "\(baseURL)/walmartproducts/\(apiKey)/\(lastPageDownloaded)/\(pageSize)"
        print("url=\(urlStr)")
        let reqUrl = URL(string: urlStr)
        // urlSession
        let defSession = URLSession(configuration:URLSessionConfiguration.default)
        let dataTask = defSession.dataTask(with: reqUrl!) { data, resp, err in
            if err != nil {
                // network error
                compHandler(err,[])
                return
            }
            var jsonDict:[String:Any]
            do {
                jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            } catch {
                // json parse error
                compHandler(error,[])
                return
                
            }
            // data looks good
            let prodArray = self.productsFromJsonDict(jsonDict)
            compHandler(nil,prodArray)
            //print("resp= \(resp)")
        }
        dataTask.resume()
    }
    
    func productsFromJsonDict(_ inDict:[String:Any]) -> [Product] {
        let jsonProds:[[String:Any]] = inDict["products"] as! [[String : Any]]
        var newProducts:[Product] = []
        for jp in jsonProds {
            let p = Product(indx:nil, title: jp["productName"] as! String,
                            desc: (jp["shortDescription"] ?? "") as! String,
                            img: nil,
                            price: jp["price"] as! String)
            newProducts.append(p)
            // grab the image
            let url = URL(string: jp["productImage"] as! String)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) 
                p.image = UIImage(data: data!)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: reloadSignalNotif), object: nil)
            }
        }
        return newProducts
    }
    
}
