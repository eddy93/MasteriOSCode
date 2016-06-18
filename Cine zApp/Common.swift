//
//  Common.swift
//  Cine zApp
//
//  Created by Edi on 6/6/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit

class Common: NSObject {
    
    struct Constants {
        static let animationInterval: NSTimeInterval = 5
        static let animationDuration: NSTimeInterval = 1
        //Notification names
        static let csmFetched = "comingSoonMoviesFetched"
        static let imageFetched = "movieImageFetched"
        static let amFetched = "availableMoviesFetched"
        //View with Error's name
        static let mainViewControllerErr = "mainViewControllerError"
        static let availableMoviesViewControllerErr = "availableMoviesViewControllerError"
        //UIColors
        static let lightPinkColor = UIColor ( red: 0.8392, green: 0.749, blue: 0.7647, alpha: 1.0 )
        static let darkPurpleColor = UIColor ( red: 0.2314, green: 0.0667, blue: 0.2824, alpha: 1.0 )
    }

    struct AlertMessages {
        static let connectionErrorMessage = "An error occurred connecting to the Internet. Please check your connection."
        static let fetchingCSMoviesErrorMessage = "An error occurred fetching the Coming Soon movies."
        static let downloadingImagesErrorMessage = "An error occurred downloading one or more images."
        static let fetchingAMoviesErrorMessage = "An error occurred fetching the available movies."
    }
    
    struct ErrorCodes{
        static let connectionErrorCode = 101
        static let fetchingCSMoviesErrorCode = 102
        static let downloadingImagesErrorCode = 103
        static let fetchingAMoviesErrorCode = 104
        
    }
}
