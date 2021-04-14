//
//  CollectionViewCell.swift
//  KwikMartProject
//
//  Created by Ram on 10/04/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var newsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
