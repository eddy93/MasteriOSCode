//
//  AvailableMoviesViewController.swift
//  Cine zApp
//
//  Created by Edi on 6/5/16.
//  Copyright © 2016 Edgard Jammal. All rights reserved.
//

import UIKit

class AvailableMoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyling()

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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
