//
//  commonServices.swift
//  Cine zApp
//
//  Created by Edi on 5/16/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit

class commonServices: NSObject {

    /*
     This function is responsible for using the image downloaded asynchronously from the URL
     */
    func downloadImage(url: NSURL) {
        getDataFromUrl(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                // print(response?.suggestedFilename ?? "")
                
                let image = UIImage(data: data)
                
                 NSNotificationCenter.defaultCenter().postNotificationName(Common.Constants.imageFetched, object: image)
                
            }
        }
    }
    /*
     This function is responsible for downloading data from a given URL
     */
    func getDataFromUrl(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }

}
