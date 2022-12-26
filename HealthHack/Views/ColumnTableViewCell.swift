//
//  ColumnTableViewCell.swift
//  SearchBar
//
//  Created by sehooon on 2022/11/13.
//

import UIKit

class ColumnTableViewCell: UITableViewCell {

    
    @IBOutlet weak var columnTitle: UILabel!
    @IBOutlet weak var columnBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
