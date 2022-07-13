//
//  BranchesModel.swift
//  MVVM&RXSwift
//
//  Created by macbook on 12/07/2022.
//

import Foundation
 
// MARK: - BranchesModel
struct BranchesModel: Codable {
    var success: Bool?
    var data: [BranchesModelData]?
    var message: String?
}

// MARK: - Datum
struct BranchesModelData: Codable {
    var id: Int?
    var title: String?
    var icon: String?
    var subSections: [BranchesModelData]?
}
