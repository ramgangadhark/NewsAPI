//
//  NewsTableViewCell.swift
//  KwikMartProject
//
//  Created by Ram on 05/04/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
