//
//  AlarmTableViewCell.swift
//  HealthHack
//
//  Created by sehooon on 2022/11/15.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var mealTimeLabel: UILabel!
    @IBOutlet weak var mealTimer: UILabel!
    @IBOutlet weak var mealTimerBackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
