//
//  CountyCell.swift
//  Books
//
//  Created by Dang Duy Cuong on 9/30/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

class CountyCell: UITableViewCell {
    @IBOutlet weak var flagImageView: UIImageView!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: CountyCell.identifier(), bundle: nil)
    }
    
    static func identifier() -> String {
        return "CountyCell"
    }
    
}
