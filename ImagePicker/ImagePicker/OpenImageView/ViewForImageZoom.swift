//
//  ViewForImageZoom.swift
//  ARDWM_Client


import UIKit
import AVFoundation

class ViewForImageZoom: UIView, UIGestureRecognizerDelegate{

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var scrollView: ImageScrollView!
    var imageURL: URL?
    var image: UIImage?
    
    override func draw(_ rect: CGRect) {
    }
    
    @IBAction func btnClose(_ sender: AnyObject) {
        self.removeFromSuperview()
    }
    
    func setupViewForPinch() {
        DispatchQueue.main.async {
            if self.imageURL != nil {
                self.scrollView.displayImage(self.imageURL!)
            }
        }
    }
    
    
    func setupViewForTapOpenImage() {
        DispatchQueue.main.async {
            if self.image != nil {
                self.scrollView.displayImageDefault(self.image!)
            }
        }
    }
}

