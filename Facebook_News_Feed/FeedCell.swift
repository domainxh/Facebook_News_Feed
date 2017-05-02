//
//  FeedCell.swift
//  Facebook_News_Feed
//
//  Created by Xiaoheng Pan on 4/29/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "Soja Tan", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        
        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.rgb(155, 161, 171)]
        attributedText.append(NSAttributedString(string: "\nDecember 8 San Franscisco", attributes: attributes))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_small")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
        return label
    }()
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "profile")
        return image
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "This is just a placeholder textview blahblah ..."
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "zuckdog")
        return image
    }()
    
    let imageLikeStatistics: UILabel = {
        let label = UILabel()
        label.text = "488 Likes   10.7k Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(155, 161, 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, 228, 232)
        return view
    }()
    
    let likeButton = FeedCell.createButton(title: "Like", image: "like")
    let commentButton = FeedCell.createButton(title: "Comment", image: "comment")
    let shareButton = FeedCell.createButton(title: "Share", image: "share")
    
    
    func setupViews() {
        backgroundColor = .white
        let buttons = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        buttons.distribution = .fillEqually
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(imageLikeStatistics)
        addSubview(dividerLineView)
        addSubview(buttons)
        
        addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat("V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-4-[v3(24)]-4-[v4(0.5)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, imageLikeStatistics, dividerLineView, buttons)
        addConstraintsWithFormat("H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat("H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: imageLikeStatistics)
        addConstraintsWithFormat("H:|-12-[v0]-12-|", views: dividerLineView)
        addConstraintsWithFormat("H:|[v0]|", views: buttons)
        
    }
   
    static func createButton(title: String, image: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(143, 150, 263), for: .normal)
        button.setImage(UIImage(named: image), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        return button
    }
    
}

extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    // UIView... stands for variable length of view
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}






