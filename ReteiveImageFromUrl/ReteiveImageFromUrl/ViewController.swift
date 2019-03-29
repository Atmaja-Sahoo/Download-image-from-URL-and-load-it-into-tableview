//
//  ViewController.swift
//  ReteiveImageFromUrl
//
//  Created by Atmaja on 29/03/19.
//  Copyright © 2019 Atmaja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var activityView:UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
         self.addSpinner()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addSpinner() {
       activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView?.color = .black
        activityView?.center = self.view.center
        activityView?.startAnimating()
        
        self.view.addSubview(activityView!)
    }
    func removeSpinner() {
        if activityView != nil {
            activityView?.removeFromSuperview()
        }
    }

    func getNewsImageForCell(urlString: String, cellForRowAtIndexPath indexPath: NSIndexPath,complitionHandler: @escaping (_ image:UIImage)-> Void) {
        var image: UIImage?
        DispatchQueue.main.async {
            do
            {
                let url = URL(string: urlString)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    image = UIImage(data:imageData,scale:1.0)
                     complitionHandler(image!)
                    
                }
              
            }
            
        }
    }
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ImageTableViewCell
        
        let imgURL = "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"
        
        if cell.displayImageView?.image == nil {
            cell.displayImageView?.image = UIImage()
           
            getNewsImageForCell(urlString: imgURL, cellForRowAtIndexPath: indexPath as NSIndexPath, complitionHandler: { image in
                cell.displayImageView?.image = image
                self.removeSpinner()
                self.headerLabel.text = "Images are displayed"
            })
        }
        
        return cell
    }
    
    
}
