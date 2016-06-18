//
//  Movie.swift
//  Cine zApp
//
//  Created by Edi on 6/14/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit

class Movie: NSObject {
 
    var poster : UIImage = UIImage(named: "")!
    var title :  String = ""
    var runtime : String = ""
    var genre : String = ""
    var plot: String = ""
    var rated : String = ""
    var director : String = ""
    var actors : [String] = []
    var metascore : String = ""
    var imdbRating : String = ""
    
    override init() {
        
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        poster = (dictionary["poster"] as? UIImage)!
        title = (dictionary["title"] as? String)!
        runtime = (dictionary["runtime"] as? String)!
        genre = (dictionary["genre"] as? String)!
        plot = (dictionary["plot"] as? String)!
        rated = (dictionary["rated"] as? String)!
        director = (dictionary["director"] as? String)!
        actors = (dictionary["actors"] as? [String])!
        metascore = (dictionary["metascore"] as? String)!
        imdbRating = (dictionary["imdbRating"] as? String)!
        
        
    }
    
    func getPoster() -> UIImage{
        return poster;
    }
    
    func getTitle() -> String{
        return title;
    }
    

}
