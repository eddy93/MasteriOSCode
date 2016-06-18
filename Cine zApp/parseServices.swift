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
     This function is responsible for getting the movies
     Param: String isComingSoon
     */
    func getMovies(isComingSoon: String) {
        let query = PFQuery(className: "Movies")
        query.whereKey("isComingSoon", equalTo: isComingSoon)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if (error != nil) {
                var errorCode : Int
                var view : String
                if(isComingSoon=="Y"){
                    errorCode = Common.ErrorCodes.fetchingCSMoviesErrorCode
                    view = Common.Constants.mainViewControllerErr
                }
                else{
                    errorCode = Common.ErrorCodes.fetchingAMoviesErrorCode
                    view = Common.Constants.availableMoviesViewControllerErr
                }
                NSNotificationCenter.defaultCenter().postNotificationName(view, object: errorCode)
            }
            else{
                var fetchedMovies : String
                if(isComingSoon=="Y"){
                    fetchedMovies = Common.Constants.csmFetched
                }
                else{
                    fetchedMovies = Common.Constants.amFetched
                }
                 NSNotificationCenter.defaultCenter().postNotificationName(fetchedMovies, object: objects)
            }
            
        }
        
    }

}
