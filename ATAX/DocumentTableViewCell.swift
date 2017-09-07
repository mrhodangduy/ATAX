//
//  DocumentTableViewCell.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

protocol DocumentCellDelegate {
    func didDeleteTap(cell: DocumentTableViewCell, indexPath: IndexPath)
    func didDownloadTap(cell: DocumentTableViewCell, indexPath: IndexPath)

}

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTaxdocument: UILabel!
    @IBOutlet weak var lbluploadDay: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    
    var delegateCell:DocumentCellDelegate!
    var indexPath:IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        self.delegateCell.didDeleteTap(cell: self, indexPath: indexPath)
        
    }
    @IBAction func downloadAction(_ sender: UIButton) {
        self.delegateCell.didDownloadTap(cell: self, indexPath: indexPath)
    }
    
    

}
