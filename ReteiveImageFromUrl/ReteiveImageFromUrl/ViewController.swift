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
    var imageURLS:[String]!
    var activityView:UIActivityIndicatorView?
    var myQueue = DispatchQueue.global(qos: .userInteractive)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURLS = ["https://homepages.cae.wisc.edu/~ece533/images/airplane.png","https://dummyimage.com/250/ffffff/000000","https://dummyimage.com/qvga","https://dummyimage.com/300/09f/fff.png","https://dummyimage.com/200x300&text=dummyimage.com+rocks!","https://dummyimage.com/skyscraper/f0f/f"]
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
            do
            {
                let url = URL(string: urlString)
                myQueue.async {
                    let data = try? Data(contentsOf: url!)
                    if let imageData = data {
                        image = UIImage(data:imageData,scale:1.0)
                        complitionHandler(image!)
                        
                    }
                }
               
              
            }
    }
}

extension ViewController:UITableViewDataSource,UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        addSpinner()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        removeSpinner()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ImageTableViewCell
        
        let imgURL = imageURLS[indexPath.row]
        
        if cell.displayImageView?.image == nil {
            cell.displayImageView?.image = UIImage()
           
            getNewsImageForCell(urlString: imgURL, cellForRowAtIndexPath: indexPath as NSIndexPath, complitionHandler: { image in
                DispatchQueue.main.async {
                    cell.displayImageView?.image = image
                    self.headerLabel.text = "Images are displayed"
                    self.removeSpinner()
                }
            })
        }
        return cell
    }
    
    
}
