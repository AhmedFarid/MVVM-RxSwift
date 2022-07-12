//
//  HomeVC.swift
//  MVVM&RXSwift
//
//  Created by macbook on 11/07/2022.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVC: UIViewController {
  
  @IBOutlet weak var branchesTableView: UITableView!
  
  let branchesCell = "BranchesCell"
  let branchViewModel = BranchViewModel()
  let disposeBag = DisposeBag()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    getBranches()
    subscribeToResponse()
    subscribeToBranchSelection()
    bindToHiddenTable()
    subscribeToLoading()
  }
  
  func setupTableView() {
    branchesTableView.register(UINib(nibName: branchesCell, bundle: nil), forCellReuseIdentifier: branchesCell)
  }
  
  func subscribeToResponse() {
    
    branchViewModel.branchModelObservable.bind(to: branchesTableView.rx.items(cellIdentifier: branchesCell, cellType: BranchesCell.self)) { row, branch, cell in
      cell.configureCell(data: branch)
    }.disposed(by: disposeBag)
  }
  
  func subscribeToBranchSelection() {
    Observable.zip(branchesTableView.rx.itemSelected, branchesTableView.rx.modelSelected(BranchesModelData.self)).bind {selectedIndex, branch in
      print(selectedIndex.row)
      print(branch.title ?? "")
    }.disposed(by: disposeBag)
  }
  
  func bindToHiddenTable() {
    branchViewModel.isTableHiddenObservable.bind(to: branchesTableView.rx.isHidden).disposed(by: disposeBag)
  }
  
  func subscribeToLoading() {
    branchViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
      if isLoading {
        self.showIndicator(withTitle: "", and: "")
      }else {
        self.hideIndicator()
      }
    }).disposed(by: disposeBag)
  }
  
  func getBranches() {
    branchViewModel.getData()
  }
}
