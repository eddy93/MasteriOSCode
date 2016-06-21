//
//  AvailableMoviesViewController.swift
//  Cine zApp
//
//  Created by Edi on 6/5/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit
import Parse
import Bolts

class AvailableMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var moviesArray: [Movie] = [];
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate=self
        self.tableView.dataSource=self
        
        applyStyling()
        
        parseServices().getMovies("N")
        
        // Notification Observers
        // AVAILABLE MOVIES TITLES FETCHED
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AvailableMoviesViewController.requestInfoBasedOnMovieName), name: Common.Constants.amFetched, object: nil)
        // AVAILABLE MOVIE DETAILS FETCHED
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AvailableMoviesViewController.addFetchedMovieToArray), name: Common.Constants.amDetailsFetched, object: nil)
        // ERROR HANDLER
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AvailableMoviesViewController.handleError), name: Common.Constants.availableMoviesViewControllerErr, object: nil)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    func applyStyling(){
        navigationController!.navigationBar.barTintColor = Common.Constants.lightPinkColor
        navigationController!.navigationBar.tintColor = Common.Constants.darkPurpleColor
        navigationItem.title = "Available Movies"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: Common.Constants.darkPurpleColor]
        navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
    }
    /*
     This function is responsible for getting more info based on the movie names fetched
     */
    func requestInfoBasedOnMovieName(notification: NSNotification){
        let movies = notification.object as! [PFObject]
        for movie in movies{
            let movieTitle : String = movie.valueForKey("title") as! String
            let movieYear : String = (movie.valueForKey("year") as? String)!
            let url : String = buildDownloadURLWithMovieTitle(movieTitle, movieYear: movieYear)
            imdbServices().getImdbMovie(url)
        }
        
    }
    func buildDownloadURLWithMovieTitle (movieTitle: String, movieYear: String) -> String{
       let plusSeparatedMovieTitle=movieTitle.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
       
        if(movieYear != ""){
            return "https://www.omdbapi.com/?t="+plusSeparatedMovieTitle+"&y="+movieYear+"&plot=full&r=json"
        }
        else{
            return "https://www.omdbapi.com/?t="+plusSeparatedMovieTitle+"&plot=full&r=json"
        }
    }
    func addFetchedMovieToArray(notification: NSNotification){
       let movieDictionary = notification.object as! NSDictionary
        let availableMovie = Movie(movieDictionary as! Dictionary<String, String>)
        moviesArray.append(availableMovie)
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
        
    }
    /*
     This function is responsible for any error handling.
     Params: NSNotification notification
     */
    func handleError(notification: NSNotification) {
        let error = notification.object as! Int
        if(error == Common.ErrorCodes.fetchingAMoviesErrorCode){
            presentAlertWithMessage(Common.AlertMessages.fetchingAMoviesErrorMessage)
        }
   
    }
    /*
     This function is responsible for displaying the alert message.
     Params: String message
     */
    func presentAlertWithMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        alert.view.tintColor = Common.Constants.darkPurpleColor
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                                   reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.moviesArray[indexPath.row].title
        cell.detailTextLabel?.text = self.moviesArray[indexPath.row].genre
        let label = UILabel(frame: CGRectMake((cell.layer.frame.width-50),5,40,20))
        label.text = self.moviesArray[indexPath.row].imdbRating
        cell.addSubview(label)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
