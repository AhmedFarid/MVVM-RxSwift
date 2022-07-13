//
//  PhotosListVC.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import UIKit
import SDWebImage

class PhotosListVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  lazy var viewModel: PhotosListViewModel = {
    return PhotosListViewModel()
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
    initVM()
    initTableView()
  }
  
  
  func initView() {
    navigationItem.title = "Photos"
    tableView.estimatedRowHeight = 150
    tableView.rowHeight = UITableView.automaticDimension
  }
  
  func initVM() {
    // Naive binding
    viewModel.showAlertClosure = { [weak self] () in
      DispatchQueue.main.async {
        if let message = self?.viewModel.alertMessage {
          self?.showAlert( message )
        }
      }
    }
    
    viewModel.updateLoadingStatus = { [weak self] () in
      guard let self = self else {
        return
      }
      
      DispatchQueue.main.async { [weak self] in
        guard let self = self else {
          return
        }
        switch self.viewModel.state {
        case .empty, .error:
          self.hideIndicator()
          UIView.animate(withDuration: 0.2, animations: {
            self.tableView.alpha = 0.0
          })
        case .loading:
          self.showIndicator(withTitle: "", and: "")
          UIView.animate(withDuration: 0.2, animations: {
            self.tableView.alpha = 0.0
          })
        case .populated:
          self.hideIndicator()
          UIView.animate(withDuration: 0.2, animations: {
            self.tableView.alpha = 1.0
          })
        }
      }
    }
    
    viewModel.reloadTableViewClosure = { [weak self] () in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
    
    viewModel.initFetch()
  }
  
  func showAlert( _ message: String ) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}
