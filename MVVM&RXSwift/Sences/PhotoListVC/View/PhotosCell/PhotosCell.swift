//
//  PhotosCell.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import UIKit
import SDWebImage

class PhotosCell: UITableViewCell {
  
  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descContainerHeightConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  var photoListCellViewModel: PhotoListCellViewModel? {
    didSet {
      nameLabel.text = photoListCellViewModel?.titleText
      descriptionLabel.text = photoListCellViewModel?.descText
      mainImageView?.sd_setImage(with: URL( string: photoListCellViewModel?.imageUrl ?? "" ), completed: nil)
      dateLabel.text = photoListCellViewModel?.dateText
    }
  }
}
