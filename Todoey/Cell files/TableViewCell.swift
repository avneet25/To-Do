//
//  TableViewCell.swift
//  Todoey
//
//  Created by Avneet Kaur on 2022-04-04.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var todoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
