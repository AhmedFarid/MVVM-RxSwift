//
//  BranchesCell.swift
//  MVVM&RXSwift
//
//  Created by macbook on 12/07/2022.
//

import UIKit

class BranchesCell: UITableViewCell {

  @IBOutlet weak var titleLB: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(data: BranchesModelData) {
    titleLB.text = data.title 
  }
    
}
