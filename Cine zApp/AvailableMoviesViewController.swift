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

class AvailableMoviesViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    var moviesArray: [Movie] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyling()
        
        parseServices().getMovies("N")
        
        // Notification Observers
        // COMING SOON MOVIES FETCHED
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AvailableMoviesViewController.requestInfoBasedOnMovieName), name: Common.Constants.amFetched, object: nil)
        // ERROR HANDLER
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AvailableMoviesViewController.handleError), name: Common.Constants.availableMoviesViewControllerErr, object: nil)
        

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
        imdbServices.getImdbMovie(<#T##imdbServices#>)
        for movie in movies{
            var movieDictionary = [String:String] = ["poster":movie.objectForKey("poster")]
            let movieObject = Movie(
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
        return UITableViewCell()
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
