//
//  Movie.swift
//  Cine zApp
//
//  Created by Edi on 6/14/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit

class Movie: NSObject {
 
    var poster : String = ""
    var title :  String = ""
    var runtime : String = ""
    var genre : String = ""
    var plot: String = ""
    var rated : String = ""
    var director : String = ""
    var actors : String = ""
    var metascore : String = ""
    var imdbRating : String = ""
    
    override init() {
        
    }
    
    convenience init(_ dictionary: NSDictionary) {
        self.init()
        poster = dictionary["Poster"] as! String
        title = dictionary["Title"] as! String
        runtime = dictionary["Runtime"] as! String
        genre = dictionary["Genre"] as! String
        plot = dictionary["Plot"] as! String
        rated = dictionary["Rated"] as! String
        director = dictionary["Director"] as! String
        actors = dictionary["Actors"] as! String
        metascore = dictionary["Metascore"] as! String
        imdbRating = dictionary["imdbRating"] as! String
        
        
    }
    /* 
     Getters
     */
    func getPoster() -> String{
        return poster;
    }
    func getTitle() -> String{
        return title;
    }
    func getRuntime() -> String{
        return runtime;
    }
    func getGenre() -> String{
        return genre;
    }
    func getPlot() -> String{
        return plot;
    }
    func getRated() -> String{
        return rated;
    }
    func getDirector() -> String{
        return director;
    }
    func getActors() -> String{
        return actors;
    }
    func getMetascore() -> String{
        return metascore;
    }
    func getImdbRating() -> String{
        return imdbRating;
    }

}
