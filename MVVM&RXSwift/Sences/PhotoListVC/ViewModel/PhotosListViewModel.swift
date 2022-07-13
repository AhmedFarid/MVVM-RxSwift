//
//  PhotosListViewModel.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import Foundation

class PhotosListViewModel {
  let apiService: APIServiceProtocol
  private var photos: [Photo] = [Photo]()
  
  private var cellViewModel: [PhotoListCellViewModel] = [PhotoListCellViewModel](){
    didSet {
      self.reloadTableViewClosure?()
    }
  }
  
  var state: State = .empty {
    didSet {
      self.updateLoadingStatus?()
    }
  }
  
  var alertMessage: String? {
    didSet {
      self.showAlertClosure?()
    }
  }
  
  var numberOfCells: Int {
    return cellViewModel.count
  }
  
  var isAllowSugue: Bool = false
  
  var selectedPhoto: Photo?
  
  var reloadTableViewClosure: (()->())?
  var showAlertClosure: (()->())?
  var updateLoadingStatus: (()->())?
  
  
  init (apiService: APIServiceProtocol = APIServiceV2()) {
    self.apiService = apiService
  }
  
  func initFetch() {
    state = .loading
    apiService.fetchPopularPhoto { [weak self] (success, photos, error) in
      guard let self = self else {return}
      
      guard error == nil else {
        self.state = .error
        self.alertMessage = error?.rawValue
        return
      }

      
      self.processFetchedPhoto(photos: photos)
      self.state = .populated
    }
  }
  
  func getCellViewModel(at indexPath: IndexPath)-> PhotoListCellViewModel {
    return cellViewModel[indexPath.row]
  }
  
  func createCellViewModel(photo: Photo) -> PhotoListCellViewModel {
    var descTextContainer: [String] = [String]()
    if let camera = photo.camera {
      descTextContainer.append(camera)
    }
    if let description = photo.description {
      descTextContainer.append(description)
    }
    
    let desc = descTextContainer.joined(separator: " - ")
    
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "yyyy-MM-dd"
    
    return PhotoListCellViewModel(titleText: photo.name, descText: desc, imageUrl: photo.image_url, dateText: dateFormate.string(from: photo.created_at))
  }
  
  private func processFetchedPhoto(photos: [Photo]) {
    self.photos = photos //Cache
    var vms = [PhotoListCellViewModel]()
    for photo in photos {
      vms.append(createCellViewModel(photo: photo))
    }
    self.cellViewModel = vms
  }
}


extension PhotosListViewModel {
    func userPressed( at indexPath: IndexPath ){
        let photo = self.photos[indexPath.row]
        if photo.for_sale {
            self.isAllowSugue = true
            self.selectedPhoto = photo
        }else {
            self.isAllowSugue = false
            self.selectedPhoto = nil
            self.alertMessage = "This item is not for sale"
        }
        
    }
}
