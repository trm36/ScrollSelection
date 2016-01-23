//
//  ViewController.swift
//  ScrollSelection
//
//  Created by Taylor Mott on 1/21/16.
//  Copyright © 2016 MottApplications. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ScrollSelectionViewDelegate {
    
    @IBOutlet weak var playerSelectionView: ScrollSelectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playerSelectionView.delegate = self
        
        let imageView1 = UIImageView()
        imageView1.image = UIImage(named: "D")
        
        let imageView2 = UIImageView()
        imageView2.image = UIImage(named: "F")
        
        let imageView3 = UIImageView()
        imageView3.image = UIImage(named: "P")
        
        let imageView4 = UIImageView()
        imageView4.image = UIImage(named: "S")
        
        let imageViews = [imageView1, imageView2, imageView3, imageView4]
        
        playerSelectionView.setUpScrollViewWithImageViews(imageViews)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollSelectionView(playerSelectionView: ScrollSelectionView, didChangeTo selectedIndex: Int) {
        pageControl.currentPage = selectedIndex
    }
}

