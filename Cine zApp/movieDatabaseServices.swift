//
//  movieDatabaseServices.swift
//  Cine zApp
//
//  Created by Edi on 5/28/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit

class movieDatabaseServices: NSObject {

	func getActorImage () {
		let url = NSURL(string: "https://api.themoviedb.org/3/person/287/images")!
		let request = NSMutableURLRequest(URL: url)
		request.addValue("application/json", forHTTPHeaderField: "Accept")

		let session = NSURLSession.sharedSession()
		let task = session.dataTaskWithRequest(request) { data, response, error in
			if let response = response, data = data {
				print(response)
				print(String(data: data, encoding: NSUTF8StringEncoding))
			} else {
				print(error)
			}
		}

		task.resume()

	}

}
