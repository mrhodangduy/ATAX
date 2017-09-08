//
//  MyTaxTableViewCell.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

protocol MyTaxDelegate {
    
    func makePayment(cell: MyTaxTableViewCell, indexPath: IndexPath)
    func uploadDocument(cell: MyTaxTableViewCell)

}

class MyTaxTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCreateday: UILabel!
    @IBOutlet weak var lblTaxName: UILabel!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnMakePayment: UIButton!
    @IBOutlet weak var lblActive: UILabel!
    
    var delegateCell: MyTaxDelegate!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func uploadDocAction(_ sender: Any) {
        self.delegateCell.uploadDocument(cell: self)
    }

    @IBAction func makePaymentAction(_ sender: Any) {
        
        self.delegateCell.makePayment(cell: self, indexPath: indexPath)
    }
}
