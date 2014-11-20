//
//  ParseQueries.swift
//  SocialJournal
//
//  Created by Gabe on 11/19/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import Foundation

class ParseQueries {
    
    class func getFollowing(currentUser:PFUser) -> [PFObject] {
        var query = PFQuery(className: "Followers")
        query.whereKey("user", equalTo: PFUser.currentUser())
        return query.findObjects() as [PFObject]
    }
    
    class func getFollowers(currentUser:PFUser) -> [PFObject] {
        var query = PFQuery(className: "Followers")
        query.whereKey("following", equalTo: PFUser.currentUser())
        return query.findObjects() as [PFObject]
    }
    
    class func getEntriesFromUser(user:PFUser) -> [PFObject] {
        var query = PFQuery(className: "Entry")
        query.whereKey("user", equalTo: user) 
        return query.findObjects() as [PFObject]
    }
    
    class func getAllEntriesForCurrentUser(currentUser:PFUser!) -> [PFObject] {
        var following:[PFObject] = getFollowing(currentUser)
        return following.map({ followed -> [PFObject] in return self.getEntriesFromUser(followed["following"] as PFUser )}).reduce([],+)
    }
    
    class func getTagsForEntry(entry:PFObject) -> [String] {
        var queryForTags = PFQuery(className: "TagMap")
        queryForTags.whereKey("entry", equalTo: entry)
        return (queryForTags.findObjects() as [PFObject]).map({ (tag:PFObject) -> String in return tag["tag"] as String })
    }
    
    class func getHeartCountForEntry(entry:PFObject) -> Int {
        var queryForHeartCount = PFQuery(className: "Entry")
        queryForHeartCount.whereKey("entry", equalTo: entry)
        return queryForHeartCount.countObjects()
    }
    
    class func followUser(currentUser: PFUser, userToFollow: PFUser) {
        var newFollows = PFObject(className: "Following")
        newFollows["user"] = currentUser
        newFollows["following"] = userToFollow
        newFollows.saveEventually()
    }
    
//    class func unFollowUser(currentUser: PFUser, userToFollow: PFUser) {
//        var userQuery = PFQuery(className: "Followers")
//        userQuery.whereKey("user", equalTo: currentUser)
//        var users
//    }
    
}