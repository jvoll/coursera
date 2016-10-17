//
//  FeedItem.swift
//  PhotoFeed
//
//  Created by Mike Spears on 2016-01-08.
//  Copyright © 2016 YourOganisation. All rights reserved.
//

import Foundation

class FeedItem: NSObject, NSCoding {
    let title: String
    let imageURL: NSURL

    init(title: String, imageURL: NSURL) {
        self.title = title
        self.imageURL = imageURL
        super.init()
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "itemTitle")
        aCoder.encodeObject(self.imageURL, forKey: "itemURL")
    }

    required convenience init?(coder aCoder: NSCoder) {
        let storedTitle = aCoder.decodeObjectForKey("itemTitle") as? String
        let storedURL = aCoder.decodeObjectForKey("itemURL") as? NSURL


        guard let title = storedTitle,
            let url = storedURL else {
                return nil
        }

        self.init(title: title, imageURL: url)
    }
}