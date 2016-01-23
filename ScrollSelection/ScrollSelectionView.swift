//
//  PlayerSelectionView.swift
//  ScrollSelection
//
//  Created by Taylor Mott on 1/21/16.
//  Copyright © 2016 MottApplications. All rights reserved.
//

import UIKit

private let kImageSize = CGFloat(50)     //Must match the constrained height of the PlayerSelectionView
private let kSpacingWidth = CGFloat(15)
private let kBufferWidth = kSpacingWidth / 2.0


protocol ScrollSelectionViewDelegate: class {
    func scrollSelectionView(playerSelectionView: ScrollSelectionView, didChangeTo selectedIndex: Int)
}

class ScrollSelectionView: UIView, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    weak var delegate: ScrollSelectionViewDelegate?
    var currentPage: Int {
        let width = scrollView.frame.size.width;
        let page = (scrollView.contentOffset.x + (0.5 * width)) / width
        let pageInt = Int(page)
        
        return pageInt
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.pagingEnabled = true
        self.scrollView.clipsToBounds = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.addSubview(self.scrollView)
        
        
        var constraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: scrollView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: kImageSize  + kBufferWidth * 2)
        addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: scrollView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        addConstraint(constraint)
    }
    

    func setUpScrollViewWithImageViews(imageViews: [UIImageView]) {
        
        let count = imageViews.count
        
        for index in 0 ..< count {
            let imageView = imageViews[index]
            let x = kBufferWidth + (kSpacingWidth + kImageSize) * CGFloat(index)
            let y = CGFloat(0)
            let width = kImageSize
            let height = kImageSize
            
            imageView.frame = CGRectMake(x, y, width, height)
            scrollView.addSubview(imageView)
        }
        let spacingWidth = kSpacingWidth * CGFloat(count - 1)
        let imagesWidth = kImageSize * CGFloat(count)
        let bufferWidth = kBufferWidth * 2
        
        let width = spacingWidth + imagesWidth + bufferWidth
        let height = kImageSize
        
        scrollView.contentSize = CGSize(width: width, height: height)
    }

    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        return pointInside(point, withEvent: event) ? scrollView : nil
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        delegate?.scrollSelectionView(self, didChangeTo: currentPage)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
