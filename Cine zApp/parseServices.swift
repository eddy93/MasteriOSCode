//
//  parseServices.swift
//  Cine zApp
//
//  Created by Edi on 5/16/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit
import Parse
import Bolts

class parseServices: NSObject {
    
    /*
     This function is responsible for getting the coming soon movies
     */
    func getAllComingSoonMovies() {
        let query = PFQuery(className: "Movies")
        query.whereKey("isComingSoon", equalTo: "Y")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if (error != nil) {
                
                //self.presentAlertWithMessage(AlertMessages.fetchingMoviesErrorMessage)
            }
            else{
                NSNotificationCenter.defaultCenter().postNotificationName(Common.Constants.csmFetched, object: objects)
            }
            
        }
        
    }

}
