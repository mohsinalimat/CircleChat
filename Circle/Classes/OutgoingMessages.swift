//
//  OutgoingMessages.swift
//  Circle
//
//  Created by Kumar Rounak on 01/07/18.
//  Copyright © 2018 Kumar Rounak. All rights reserved.
//

import Foundation


class OutgoingMessages {
    
    let messageDictionary: NSMutableDictionary
    
    //MARK: Initializer
    
    //text message
    
    init(message: String, senderId: String, senderName: String, date: Date, status: String, type: String){
        
        messageDictionary = NSMutableDictionary(objects: [message,senderId,senderName,dateFormatter().string(from: date),status,type], forKeys: [kMESSAGE as NSCopying, kSENDERID as NSCopying, kSENDERNAME as NSCopying, kDATE as NSCopying, kSTATUS as NSCopying, kTYPE as NSCopying])
    }
    
    //picture messages
    
    init(message: String, pictureLink: String, senderId: String, senderName: String, date: Date, status: String, type: String){
        
        messageDictionary = NSMutableDictionary(objects: [message,pictureLink,senderId,senderName,dateFormatter().string(from: date),status,type], forKeys: [kMESSAGE as NSCopying, kPICTURE as NSCopying , kSENDERID as NSCopying, kSENDERNAME as NSCopying, kDATE as NSCopying, kSTATUS as NSCopying, kTYPE as NSCopying])
    }
    
    
    //Video Messages
    
    init(message: String, video: String, thumbNail: NSData, senderId: String, senderName: String, date: Date, status: String, type: String){
        
        let picThumbNail = thumbNail.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        messageDictionary = NSMutableDictionary(objects: [message,video,picThumbNail,senderId,senderName,dateFormatter().string(from: date),status,type], forKeys: [kMESSAGE as NSCopying, kVIDEO as NSCopying, kPICTURE as NSCopying , kSENDERID as NSCopying, kSENDERNAME as NSCopying, kDATE as NSCopying, kSTATUS as NSCopying, kTYPE as NSCopying])
    }
    
    //MARK: Send Message
    
    func sendMessage(chatRoomId: String, messageDictionary: NSMutableDictionary, memberIds: [String], membersToPush: [String]){
        
        let messageId = UUID().uuidString
        messageDictionary[kMESSAGEID] = messageId
        
        for memberId in memberIds {
            reference(.Message).document(memberId).collection(chatRoomId).document(messageId).setData(messageDictionary as! [String: Any])
        }
        
        
        //update recent
        
        //send push notification
        
        
        
    }
}
