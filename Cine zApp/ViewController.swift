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
	// images structure D A B C A
	var imageNames: [String] = ["deadpool.jpg", "BVS.jpg", "hangover.jpg", "deadpool.jpg", "BVS.jpg"]
	struct Constants {
		static let animationInterval: NSTimeInterval = 5
		static let animationDuration: NSTimeInterval = 1
	}
	struct AlertMessages {
		static let connectionErrorMessage = "An error occured connecting to the Internet. Please check your connection."
		static let fetchingMoviesErrorMessage = "An error occured fetching the Coming Soon movies."
	}
	override func viewDidLoad() {
		super.viewDidLoad()

		// Timer to change the displayed image every 5 seconds by swiping to the right
		_ = NSTimer.scheduledTimerWithTimeInterval(Constants.animationInterval, target: self, selector: #selector(swipeToTheRight), userInfo: nil, repeats: true)
		
        parseServices().getAllComingSoonMovies()

		scrollView.delegate = self

	}
	/*
	 This function is responsible for detecting when the view layed out the subviews. We wait for this to happen to fill the scrollView and set its Content Offset
	 because at this point the frame of the scrollview becomes fixed.
	 */
	override func viewDidLayoutSubviews() {
		fillTheScrollViewAndSetContentOffset()

	}
	/*
	 This function is responsible for setting all the images that should show on the main page inside a scrollview and setting the scrollview's content offset
	 */
	func fillTheScrollViewAndSetContentOffset() -> () {
		// Set the content size equal to the image array's size
		let width: CGFloat = self.view.frame.size.width * CGFloat(imageNames.count)
		scrollView.contentSize = CGSizeMake(width, scrollView.frame.size.height)
		// Loop on the images to add them in the scrollview
		for index in 0 ... imageNames.count - 1 {
			let xOrigin: CGFloat = CGFloat(index) * self.view.frame.size.width
			let imageName = imageNames[index]
			let image = UIImage(named: imageName)
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
		let contentOffset: CGPoint = CGPointMake(scrollView.contentOffset.x + scrollView.frame.size.width, 0)
		// The animation takes 1 second
		UIView.animateWithDuration(Constants.animationDuration, animations: {
			self.scrollView.contentOffset = contentOffset
			},
			// When the animation is complete (the image is switched) if it is the last image, go to the second
			completion: {
				(value: Bool) in
				if (contentOffset.x == self.view.frame.size.width * 4) {
					self.scrollView.contentOffset.x = self.view.frame.size.width * 1
				}
				else
				if (contentOffset.x == self.view.frame.size.width * 0) {
					self.scrollView.contentOffset.x = self.view.frame.size.width * 4
				}
			}
		)

	}
	/*
	 This function is responsible for detecting when the user finished scrolling
	 */
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		var contentOffset: CGPoint = CGPointMake(scrollView.contentOffset.x + self.view.frame.size.width, 0)
		if (contentOffset.x == self.view.frame.size.width * 5) {
			contentOffset.x = self.view.frame.width * 1;
			scrollView.setContentOffset(contentOffset, animated: false)
		}

		else if (contentOffset.x == self.view.frame.size.width * 1) {
			contentOffset.x = self.view.frame.size.width * 3;
			scrollView.setContentOffset(contentOffset, animated: false)
		}

	}

	/*
	 This function is responsible for displaying the alert message.
	 Params: String message
	 */
	func presentAlertWithMessage(message: String) {
		let refreshAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)

		refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))

		presentViewController(refreshAlert, animated: true, completion: nil)

      
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    


    
 
}

