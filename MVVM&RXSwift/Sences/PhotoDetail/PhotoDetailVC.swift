//
//  PhotoDetailVC.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import UIKit
import SDWebImage

class PhotoDetailVC: UIViewController {

  var imageUrl: String?
      
      @IBOutlet weak var imageView: UIImageView!
      
    override func viewDidLoad() {
        super.viewDidLoad()

      if let imageUrl = imageUrl {
                  imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
              }    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
