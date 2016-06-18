//
//  ViewController.swift
//  Cine zApp
//
//  Created by Edi on 4/17/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController, UIScrollViewDelegate {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var availableMovies: UIButton!
	@IBOutlet weak var soonInTheaters: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var blurryImage: UIImageView!
	// images structure A B C A B
	var images: [UIImage] = [];
	var totalNumberOfImages = 0;


	override func viewDidLoad() {
		super.viewDidLoad()

		// Timer to change the displayed image every 5 seconds by swiping to the right
		_ = NSTimer.scheduledTimerWithTimeInterval(Common.Constants.animationInterval, target: self, selector: #selector(swipeToTheRight), userInfo: nil, repeats: true)
		// Notification Observers
		// COMING SOON MOVIES FETCHED
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.requestImagesBasedOnUrls), name: Common.Constants.csmFetched, object: nil)
		// MOVIE IMAGE FETCHED
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.appendDownloadedImageToImagesArray), name: Common.Constants.imageFetched, object: nil)
        // ERROR HANDLER
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handleError), name: Common.Constants.mainViewControllerErr, object: nil)
        
        availableMovies.addTarget(self, action: #selector(navigateToAvailableMovies), forControlEvents: .TouchUpInside)

		parseServices().getMovies("Y")

		movieDatabaseServices().getActorImage()

		scrollView.delegate = self

	}
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
	/*
	 This function is responsible for detecting when the view layed out the subviews. We wait for this to happen to fill the scrollView and set its Content Offset
	 because at this point the frame of the scrollview becomes fixed.
	 */
	override func viewDidLayoutSubviews() {

	}
	/*
	 This function is responsible for filling csmImagesArray after that the image URLs are fetched
	 */
	func requestImagesBasedOnUrls(notification: NSNotification) {
		// fillTheScrollViewAndSetContentOffset()
		let movies = notification.object as! [PFObject]
		totalNumberOfImages = movies.count
		for movie in movies {
			commonServices().downloadImage(NSURL(string: movie.valueForKey("imageURL") as! String)!)
		}
	}
	/*
	 This function is responsible for adding a newly downloaded image to the images array
	 */
	func appendDownloadedImageToImagesArray(notification: NSNotification) {
		let image = notification.object as! UIImage
		images.append(image)
		if (images.count == totalNumberOfImages) {
			constructImagesArrayReadyForInfiniteLooping()
		}

	}
	/*
	 This function is responsible for structuring the images array in a way that allows infinite looping
	 */
	func constructImagesArrayReadyForInfiniteLooping() {
		images.append(images[0])
		totalNumberOfImages += 1
		images.append(images[1])
		totalNumberOfImages += 1
		fillTheScrollViewAndSetContentOffset()
		hideLoader()
	}
	/*
	 This function is responsible for setting all the images that should show on the main page inside a scrollview and setting the scrollview's content offset
	 */
	func fillTheScrollViewAndSetContentOffset() -> () {
		// Set the content size equal to the image array's size
		let width: CGFloat = self.view.frame.size.width * CGFloat(images.count)
		scrollView.contentSize = CGSizeMake(width, scrollView.frame.size.height)
		// Loop on the images to add them in the scrollview
		for index in 0 ... images.count - 1 {
			let xOrigin: CGFloat = CGFloat(index) * self.view.frame.size.width
			let image = images[index]
			let imageView = UIImageView(image: image)
			imageView.contentMode = .ScaleAspectFill
			scrollView.addSubview(imageView)
			imageView.frame = CGRectMake(xOrigin, 0, self.view.frame.size.width, scrollView.frame.size.height)
			// imageView.bounds=CGRectMake(xOrigin, scrollView.frame.origin.x, self.view.frame.size.width, scrollView.frame.size.height)
			imageView.clipsToBounds = true;
		}

		// Set the content offset on the second image because the first image in index is the last one that should show
		let contentOffset: CGPoint = CGPointMake(scrollView.contentOffset.x + self.view.frame.size.width, 0)
		scrollView.setContentOffset(contentOffset, animated: false)

	}
	/*
	 This function is responsible for switching to the next image
	 */
	func swipeToTheRight() -> () {
		// First always add the frame's size to the content offset. This is how to move to the next image
		var contentOffset: CGPoint = CGPointMake(scrollView.contentOffset.x + scrollView.frame.size.width, 0)
		// The animation takes 1 second
		if (contentOffset.x != scrollView.frame.size.width * CGFloat(self.totalNumberOfImages)) {
			UIView.animateWithDuration(Common.Constants.animationDuration, animations: {
				self.scrollView.contentOffset = contentOffset
				},
				// When the animation is complete (the image is switched) if it is the last image, go to the second
				completion: {
					(value: Bool) in
					if (contentOffset.x == self.view.frame.size.width * CGFloat(self.totalNumberOfImages - 1)) {
						self.scrollView.contentOffset.x = self.view.frame.size.width * 1
					}
					else
					if (contentOffset.x == self.view.frame.size.width * 0) {
						self.scrollView.contentOffset.x = self.view.frame.size.width * CGFloat(self.totalNumberOfImages - 1)
					}
				}
			)
		}

		else {
			contentOffset.x = self.view.frame.width * 1;
			scrollView.setContentOffset(contentOffset, animated: false)

		}

	}
	/*
	 This function is responsible for detecting when the user finished scrolling
	 */
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		var contentOffset: CGPoint = CGPointMake(scrollView.contentOffset.x + self.view.frame.size.width, 0)
		if (contentOffset.x == self.view.frame.size.width * CGFloat(self.totalNumberOfImages)) {
			contentOffset.x = self.view.frame.width * 1;
			scrollView.setContentOffset(contentOffset, animated: false)
		}

		else if (contentOffset.x == self.view.frame.size.width * 1) {
			contentOffset.x = self.view.frame.size.width * CGFloat(self.totalNumberOfImages - 2);
			scrollView.setContentOffset(contentOffset, animated: false)
		}

	}
	/*
	 This function is responsible for hiding the loader when the coming soon movie images are retrieved
	 */
	func hideLoader() {
		blurryImage.hidden = true
		activityIndicator.stopAnimating()
	} /*
	 This function is responsible for navigating to Available Movies view
	 */
	func navigateToAvailableMovies () {
		let availableMoviesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AvailableMoviesViewController") as! AvailableMoviesViewController

		navigationController!.pushViewController(availableMoviesViewController, animated: true)
	}
    /*
     This function is responsible for any error handling.
     Params: NSNotification notification
     */
    func handleError(notification: NSNotification) {
        let error = notification.object as! Int
        if(error == Common.ErrorCodes.fetchingCSMoviesErrorCode){
            presentAlertWithMessage(Common.AlertMessages.fetchingCSMoviesErrorMessage)
        }
        if(error == Common.ErrorCodes.downloadingImagesErrorCode){
            presentAlertWithMessage(Common.AlertMessages.downloadingImagesErrorMessage)
           
        }
        
         activityIndicator.stopAnimating()
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
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    

}

