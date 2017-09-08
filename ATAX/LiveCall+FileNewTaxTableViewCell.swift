//
//  LiveCall+FileNewTaxTableViewCell.swift
//  ATAX
//
//  Created by Paul on 9/8/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

protocol LiveCall_FileNewTaxDelegate {
    func didLiveCalltap(cell: LiveCall_FileNewTaxTableViewCell)
    func didFileNewTaxtap(cell: LiveCall_FileNewTaxTableViewCell)
}

class LiveCall_FileNewTaxTableViewCell: UITableViewCell {

    @IBOutlet weak var btn_FileNewTax: RoundButton!
    @IBOutlet weak var btnLiveCall: RoundButton!
    var delegateCell: LiveCall_FileNewTaxDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func LiveCallAction(_ sender: RoundButton) {
        
        self.delegateCell.didLiveCalltap(cell: self)
        
    }

    @IBAction func FIleNewTaxAction(_ sender: RoundButton) {
        
        self.delegateCell.didFileNewTaxtap(cell: self)
    }
}
