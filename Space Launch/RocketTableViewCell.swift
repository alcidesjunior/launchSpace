//
//  RocketTableViewCell.swift
//  Space Launch
//
//  Created by Alcides Junior on 19/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

class RocketTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
