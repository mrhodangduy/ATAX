//
//  MyTaxTableViewCell.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MyTaxTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCreateday: UILabel!
    @IBOutlet weak var lblTaxName: UILabel!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnMakePayment: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func uploadDocAction(_ sender: Any) {
        print("Upload")
    }

    @IBAction func makePaymentAction(_ sender: Any) {
        print("Payment")
    }
}
