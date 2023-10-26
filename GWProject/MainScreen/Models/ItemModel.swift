//
//  ItemModel.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 10/18/23.
//

import Foundation
struct UserItems{
    var userId:UUID
    var items : [ItemModel]
}

struct ItemModel{
    var title: String
    var description: String
    var givingType: String
    var itemCategory: String
    var userId: String
    var postedOn: Date
    var expiresOn: Date

}

