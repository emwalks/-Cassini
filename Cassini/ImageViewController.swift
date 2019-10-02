//
//  ImageViewController.swift
//  Cassini
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 01/10/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{
    //this is my model
    var imageURL: URL? {
        didSet {
            //if a new model has been set - e.g. new image URL AND we are on screen (if view.window != nil)  then the image is cleared and the fetch image func is run
              //if we didn't have the computed proprty we would need the size to fit and content size here too
            image = nil
            
            //if a view is on screen it will have a window var, thus a quick was to check we are on screen
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    //by creating this computed property we don't have to call code repeatedly
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    //if we are not already on screen we need to fetch the image when we DO get onscreen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
        
    }
    
    //here is where the scrollview is set up in code
    //if we didn't have the computed proprty we would need the size to fit and content size here too
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 2.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    //this is the objc func to allow zooming when your class is a UIViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //this is my view
    var imageView = UIImageView()
    
    //we are making this a func as it could be fetching an image over the network
    private func fetchImage() {
        if let url = imageURL {
            //make the Data (contentsOf: <#T##URL#>) throws optional so it will return nil if an error rather than implementing error catch
            //if there's an image in my Data use the image for the image view
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.stanford
        }
    }
    
}
