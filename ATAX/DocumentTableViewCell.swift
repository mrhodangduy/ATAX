//
//  DocumentTableViewCell.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTaxdocument: UILabel!
    @IBOutlet weak var lbluploadDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func deleteDocAction(_ sender: Any) {
        print("Deleted")
    }
    @IBAction func downloadDocAction(_ sender: Any) {
        print("Downloaded")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
