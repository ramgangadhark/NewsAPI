//
//  PlaceHolderTableViewCell.swift
//  KwikMartProject
//
//  Created by Ram on 06/04/21.
//

import UIKit

class PlaceHolderTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view5: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor]
//        gradientLayer.locations = [0,0.5,1]
//        gradientLayer.frame = view1.frame
//        gradientLayer.frame = view2.frame
//        gradientLayer.frame = view3.frame
//        let angle = 45 * CGFloat.pi / 180
//        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
//        view1.layer.mask = gradientLayer
//        view2.layer.mask = gradientLayer
//        view3.layer.mask = gradientLayer
//        let animation = CABasicAnimation(keyPath: "transform.translation.x")
//        animation.duration = 2
//        animation.fromValue = -mainView.frame.width
//        animation.toValue = mainView.frame.width
//        animation.repeatCount = Float.infinity
//        
//        gradientLayer.add(animation, forKey: "doesn'tmatterjustsomekey")
//        
//        mainView.layer.addSublayer(gradientLayer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
