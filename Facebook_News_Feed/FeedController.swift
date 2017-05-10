//
//  ViewController.swift
//  Facebook_News_Feed
//
//  Created by Xiaoheng Pan on 4/29/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

let cellId = "cellId"

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)

        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.location = Location()
        postMark.location?.city = "San Francisco"
        postMark.location?.state = "CA"
        postMark.profileImageName = "zuckprofile"
        postMark.statusText = "By giving people the power to share, we're making the world more transparent."
        postMark.statusImageName = "zuckdog"
        postMark.numLikes = 400
        postMark.numComments = 123

        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.location = Location()
        postSteve.location?.city = "Cupertino"
        postSteve.location?.state = "CA"
        postSteve.profileImageName = "steve_profile"
        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\n" +
            "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" +
        "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 1000
        postSteve.numComments = 55

        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
        postGandhi.location = Location()
        postGandhi.location?.city = "Porbandar"
        postGandhi.location?.state = "India"
        postGandhi.profileImageName = "gandhi_profile"
        postGandhi.statusText = "Live as if you were to die tomorrow; learn as if you were to live forever.\n" +
            "The weak can never forgive. Forgiveness is the attribute of the strong.\n" +
        "Happiness is when what you think, what you say, and what you do are in harmony."
        postGandhi.statusImageName = "gandhi_status"
        postGandhi.numLikes = 333
        postGandhi.numComments = 22

        
        posts = [postMark, postSteve, postGandhi]
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        cell.post = posts[indexPath.row]
        cell.feedController = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.row].statusText {
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            // This only returns the text height, so you need to add the height of all the buttons and images to get the full height. (The number at the end is added to give it a tiny bit more room)
            let totalHeight = rect.height + 8 + 44 + 4 + 4 + 200 + 4 + 24 + 4 + 0.5 + 44 + 24
            return CGSize(width: view.frame.width, height: totalHeight)
        }
    
        return CGSize.zero

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    var zoomedImageView = UIImageView()
    let blackBackgroundView = UIView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    var statusImageView: UIImageView?
    
    func animateImageView(statusImageView: UIImageView) {
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            self.statusImageView = statusImageView
            statusImageView.alpha = 0
        
            if let keyWindow = UIApplication.shared.keyWindow {
                navBarCoverView.frame = CGRect(x: 0, y: 0, width: view.frame.height, height: 20 + 44)
                navBarCoverView.backgroundColor = .black
                navBarCoverView.alpha = 0
                keyWindow.addSubview(navBarCoverView)
                
                blackBackgroundView.frame = view.frame
                blackBackgroundView.backgroundColor = .black
                blackBackgroundView.alpha = 0
                view.addSubview(blackBackgroundView)
                
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: view.frame.width, height: 49)
                tabBarCoverView.backgroundColor = .black
                tabBarCoverView.alpha = 0
                keyWindow.addSubview(tabBarCoverView)
            }
            
            
            
            
            
            zoomedImageView.frame = startingFrame
            zoomedImageView.image = statusImageView.image
            zoomedImageView.contentMode = .scaleAspectFill
            zoomedImageView.clipsToBounds = true
            zoomedImageView.isUserInteractionEnabled = true
            view.addSubview(zoomedImageView)
            
            zoomedImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animate(withDuration: 0.75) { () -> Void in
                
                let height = self.view.frame.width / startingFrame.width * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomedImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
            }
        }
    }
    
    func zoomOut() {
        if let startingFrame = statusImageView?.superview?.convert((statusImageView?.frame)!, to: nil) {
            UIView.animate(withDuration: 0.75, animations: { () -> Void in
                self.blackBackgroundView.alpha = 0
                self.zoomedImageView.frame = startingFrame
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }, completion: { finished in
                self.zoomedImageView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            })
        }
    }
}


