//
//  ImageTableViewCell.swift
//  ReteiveImageFromUrl
//
//  Created by Atmaja on 29/03/19.
//  Copyright © 2019 Atmaja. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var displayImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        // CELLS STILL FREEZE EVEN WHEN THE FOLLOWING LINE IS COMMENTED OUT?!?!
        displayImageView.image = nil
    }

}
