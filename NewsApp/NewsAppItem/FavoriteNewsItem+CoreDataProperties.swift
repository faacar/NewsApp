//
//  FavoriteNewsItem+CoreDataProperties.swift
//  NewsApp
//
//  Created by Ahmet Acar on 13.05.2021.
//
//

import Foundation
import CoreData


extension FavoriteNewsItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteNewsItem> {
        return NSFetchRequest<FavoriteNewsItem>(entityName: "FavoriteNewsItem")
    }

    @NSManaged public var urlLink: String?
    @NSManaged public var title: String?
    @NSManaged public var publishDate: String?
    @NSManaged public var newsDescription: String?
    @NSManaged public var image: String?
    @NSManaged public var content: String?
    @NSManaged public var author: String?

}

extension FavoriteNewsItem : Identifiable {

}
