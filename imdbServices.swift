//
//  imdbServices.swift
//  Cine zApp
//
//  Created by Edi on 5/16/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit

class imdbServices: NSObject {
    /*
     This function is responsible for downloading any image
     */
	func getImdbMovie(urlString: String) {
		let url = NSURL(string: urlString)
		let request = NSURLRequest(URL: url!)
		let config = NSURLSessionConfiguration.defaultSessionConfiguration()
		let session = NSURLSession(configuration: config)

		let task = session.dataTaskWithRequest(request, completionHandler: { (jsonData, response, error) in
			do {

				let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments) as! NSDictionary

				if let movie = json["Poster"] {
					let nonsecure = movie as! String
					let secureImageURL = nonsecure.stringByReplacingOccurrencesOfString("http", withString: "https", options: NSStringCompareOptions.LiteralSearch, range: nil)
					commonServices().downloadImage(NSURL(string: secureImageURL)!)
				}
			} catch {
				print(error)
			}

		});

		task.resume();
	}
 
    func getOMDBMovie(title: String){
        
        
    }
}
