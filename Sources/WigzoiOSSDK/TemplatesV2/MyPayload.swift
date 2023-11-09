//
//  File.swift
//  
//
//  Created by Shivam Ratnam on 30/10/23.
//

import Foundation


// MARK: - NotifcationDataModel
public struct NotificationDataModel:Codable{
    let notification: NotificationData?
    let data: DataClass?
    let apns: Apns?
    let registrationIDS: [String]?
    
   
}

// MARK: - Apns
public struct Apns:Codable {
    let fcmOptions: FcmOptions?
    let payload: Payload?
}

// MARK: - FcmOptions
public struct FcmOptions: Codable {
    let image: String?
}

// MARK: - Payload
public struct Payload: Codable {
    let aps: Aps?
}

// MARK: - Aps
public struct Aps: Codable {
    let alert: NotificationData?
    let mutableContent: Bool?
}

// MARK: - Notification
public struct NotificationData:Codable {
    let mutableContent: Int?
    let title: String?
}

// MARK: - DataClass
public struct DataClass: Codable {
//    let type: [String: Any]?
    let type: TypeClass?
    let id: Int?
    let title: String?
    let notificationID: Int?
    let imageUrl: [String]?
    let secondSound: Int?
    let intentData, uuid: String?
    let organizationID: Int?
    let layoutID: String?
    let isWigzoNotification: Bool?
    let button: [ButtonClass]?
    let notificationDetails: NotificationDetails?
}

// MARK: - NotificationDetails
public struct NotificationDetails: Codable {
    let buttonOrientation, templateOrientation, templateBackground, titleColor: String?
    let titleFontSize, descriptionFontSize, descriptionFontColor, isclose: String?
    let imageOrientation, textAllignment: String?
}

public struct TypeClass: Codable {
    let type, pushType: String?
}

public struct ButtonClass: Codable {
    let buttonURL, buttonName, buttonAction, buttonFontColor: String?
    let buttonFontSize, buttonColor: String?
}
