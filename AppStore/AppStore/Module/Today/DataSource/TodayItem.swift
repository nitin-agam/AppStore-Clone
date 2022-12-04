//
//  TodayItem.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 04/12/22.
//

import UIKit

struct TodayItem {
    
    enum ItemType {
        case single
        case multiple
    }
    
    let category: String
    let title: String
    let imageName: String?
    let description: String?
    let backgroundColor: UIColor
    let result: [FeedResult]?
    let itemType: ItemType
}
