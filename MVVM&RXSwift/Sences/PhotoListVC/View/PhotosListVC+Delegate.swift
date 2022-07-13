//
//  PhotosListVC+Delegate.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import UIKit

extension PhotosListVC: UITableViewDelegate,UITableViewDataSource {
  
  //PhotosCell
  
  func initTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "PhotosCell", bundle: nil), forCellReuseIdentifier: "PhotosCell")
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as? PhotosCell else {
      fatalError("Cell Not Exists")
    }
    
    let cellVM = viewModel.getCellViewModel( at: indexPath )
            cell.photoListCellViewModel = cellVM
    
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfCells
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150.0
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    self.viewModel.userPressed(at: indexPath)
    if viewModel.isAllowSugue {
      let vc = PhotoDetailVC(nibName: "PhotoDetailVC", bundle: nil)
      let photo = viewModel.selectedPhoto
      vc.imageUrl = photo?.image_url
      navigationController?.pushViewController(vc, animated: true)
      return indexPath
    }else {
      return nil
    }
  }

  
}
