//
//  UserTableViewCell.swift
//  UsingTabBarAPIFetching_15__2_2023
//
//  Created by Mac on 15/02/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var idlbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var usernamelbl: UILabel!
    @IBOutlet weak var emaillbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
