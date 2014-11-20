//
//  ParseQueries.swift
//  SocialJournal
//
//  Created by Gabe on 11/19/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import Foundation

class ParseQueries {
    
    func getFollowing(currentUser:PFUser!) -> [PFObject] {
        var query = PFQuery(className: "Followers")
        query.whereKey("user", equalTo: PFUser.currentUser())
        return query.findObjects() as [PFObject]
    }
    
    func getFollowers(currentUser:PFUser!) -> [PFObject] {
        var query = PFQuery(className: "Followers")
        query.whereKey("follower", equalTo: PFUser.currentUser())
        return query.findObjects() as [PFObject]
    }
    
    func getEntriesFromFollowed(user:PFObject) -> [PFObject] {
        var query = PFQuery(className: "Entries")
        query.whereKey("username", equalTo: user)
        return query.findObjects() as [PFObject]
    }
    
    func getAllEntriesForCurrentUser(currentUser:PFUser!) -> [PFObject] {
        var following:[PFObject] = getFollowing(currentUser)
        return following.map({ followed -> [PFObject] in return self.getEntriesFromFollowed(followed)}).reduce([],+)
    }
    
    func getTagsForEntry(entry:PFObject) -> [String] {
        var queryForTags = PFQuery(className: "TagMap")
        queryForTags.whereKey("entry", equalTo: entry)
        return (queryForTags.findObjects() as [PFObject]).map({ (tag:PFObject) -> String in return tag["tag"] as String })
    }
    
    func getHeartCountForEntry(entry:PFObject) -> Int {
        var queryForHeartCount = PFQuery(className: "Entries")
        queryForHeartCount.whereKey("entry", equalTo: entry)
        return queryForHeartCount.countObjects()
    }
    
}