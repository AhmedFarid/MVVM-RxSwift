//
//  BranchViewModel.swift
//  MVVM&RXSwift
//
//  Created by macbook on 12/07/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class BranchViewModel {
  
  var loadingBehavior = BehaviorRelay<Bool>(value: false)
  private var isTabelHidden = BehaviorRelay<Bool>(value: false)
  
  private var branchModelSubject = PublishSubject<[BranchesModelData]>()
  var branchModelObservable: Observable<[BranchesModelData]> {
    return branchModelSubject
  }
  
  var isTableHiddenObservable: Observable<Bool> {
    return isTabelHidden.asObservable()
  }
  func getData() {
    loadingBehavior.accept(true)
    let params = [
      "withSubSections": "1"
    ]
    
    let headers: HTTPHeaders = [
      "Api-Locale": "en",
      "Accept": "application/json",
      "Authorization": "Bearer 208|1rrVZ1su2EhNobAcoCZsV322wEnNrnvG5mycE1VV"
    ]
    
    APIServices.instance.getData(url: "http://mokfha.orcav.com/api/section/sections", method: .get, params: params, encoding: URLEncoding.queryString, headers: headers) {[weak self] (branchesModel:BranchesModel?, baseErrorModel: BaseErrorModel?, error) in
      guard let self = self else {return}
      self.loadingBehavior.accept(false)
      if let error = error {
        print(error.localizedDescription)
      }else if let baseErrorModel = baseErrorModel {
        print(baseErrorModel.message ?? "")
      }else {
        guard let branchesModel = branchesModel else {return}
        if branchesModel.data?.count ?? 0 > 0 {
          self.branchModelSubject.onNext(branchesModel.data ?? [])
          self.isTabelHidden.accept(false)
        }else {
          self.isTabelHidden.accept(true)
        }
      }
    }
  }
}
