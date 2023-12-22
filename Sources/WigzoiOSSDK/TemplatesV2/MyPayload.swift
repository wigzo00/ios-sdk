//cretaed by Shivam Ratnam

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
    let description: String?
    let notificationID: Int?
    let imageUrl: [String]?
    let secondSound: Int?
    let intentData, uuid: String?
    let organizationID: Int?
    let layoutID: String?
    let isWigzoNotification: Bool?
    let button: [ButtonClass]?
    let notificationDetails: NotificationDetails?
    
    enum CodingKeys : String, CodingKey {
        case type
        case id
        case title
        case description
        case notificationID
        case imageUrl
        case secondSound
        case intentData
        case uuid
        case organizationID
        case layoutID
        case isWigzoNotification
        case button
        case notificationDetails = "notification_details"
    }
}

// MARK: - NotificationDetails
public struct NotificationDetails: Codable {
    let buttonOrientation, templateOrientation, templateBackground, titleColor: String?
    let titleFontSize, descriptionFontSize, descriptionFontColor, isclose: String?
    let imageOrientation, textAllignment: String?
    
    enum CodingKeys: String, CodingKey {

        case buttonOrientation = "buttonOrientation"
        case imageOrientation = "imageOrientation"
        case titleColor = "titleColor"
        case templateOrientation = "templateOrientation"
        case titleFontSize = "titleFontSize"
        case textAllignment = "textAllignment"
        case descriptionFontSize = "descriptionFontSize"
        case templateBackground = "templateBackground"
        case descriptionFontColor = "descriptionFontColor"
        case isclose = "isclose"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        buttonOrientation = try values.decodeIfPresent(String.self, forKey: .buttonOrientation)
        imageOrientation = try values.decodeIfPresent(String.self, forKey: .imageOrientation)
        titleColor = try values.decodeIfPresent(String.self, forKey: .titleColor)
        templateOrientation = try values.decodeIfPresent(String.self, forKey: .templateOrientation)
        titleFontSize = try values.decodeIfPresent(String.self, forKey: .titleFontSize)
        textAllignment = try values.decodeIfPresent(String.self, forKey: .textAllignment)
        descriptionFontSize = try values.decodeIfPresent(String.self, forKey: .descriptionFontSize)
        templateBackground = try values.decodeIfPresent(String.self, forKey: .templateBackground)
        descriptionFontColor = try values.decodeIfPresent(String.self, forKey: .descriptionFontColor)
        isclose = try values.decodeIfPresent(String.self, forKey: .isclose)
    }
}

public struct TypeClass: Codable {
    let type, pushType: String?
}

public struct ButtonClass: Codable {
    let buttonURL, buttonName, buttonAction, buttonFontColor: String?
    let buttonFontSize, buttonColor: String?
}


public struct WigzoNotification1: Codable {
    var imageURL: [String]?
    var notificationID, organizationID: String?
    var layoutID: String?
    var id: String?
    var uuid, title, intentData, description: String?
    var googleCSenderID, googleCAE: String?
    var notificationDetails: NotificationDetails?
    var secondSound: String?
    var aps: Aps?
    var isWigzoNotification: String?
    var gcmNotificationMutableContent, gcmMessageID: String?
    var button: [WigzoButton]?
    var googleCFid: String?
    var type: TypeClass?

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case notificationID = "notificationId"
        case organizationID = "organizationId"
        case layoutID = "layoutId"
        case id, uuid, title, intentData, description
        case googleCSenderID = "google.c.sender.id"
        case googleCAE = "google.c.a.e"
        case notificationDetails = "notification_details"
        case secondSound, aps, isWigzoNotification
        case gcmNotificationMutableContent = "gcm.notification.mutable-content "
        case gcmMessageID = "gcm.message_id"
        case button
        case googleCFid = "google.c.fid"
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let imageURLString = try values.decodeIfPresent(String.self, forKey: .imageURL),
           let imageData = imageURLString.data(using: .utf8),
           let imageURLArray = try? JSONDecoder().decode([String].self, from: imageData) {
            imageURL = imageURLArray
        } else {
            imageURL = nil
        }
        
        if let notificationDetailsString = try values.decodeIfPresent(String.self, forKey: .notificationDetails),
           let notificationData = notificationDetailsString.data(using: .utf8),
           let notiObj = try? JSONDecoder().decode(NotificationDetails.self, from: notificationData) {
            notificationDetails = notiObj
        } else {
            notificationDetails = nil
        }
        
        if let buttonString = try values.decodeIfPresent(String.self, forKey: .button),
           let buttonData = buttonString.data(using: .utf8),
           let buttonObj = try? JSONDecoder().decode([WigzoButton].self, from: buttonData) {
            button = buttonObj
        } else {
            button = nil
        }
        
        if let typeString = try values.decodeIfPresent(String.self, forKey: .button),
           let typeData = typeString.data(using: .utf8),
           let typeObj = try? JSONDecoder().decode(TypeClass.self, from: typeData) {
            type = typeObj
        } else {
            type = nil
        }
        
        notificationID = try values.decodeIfPresent(String.self, forKey: .notificationID)
        organizationID = try values.decodeIfPresent(String.self, forKey: .organizationID)
        layoutID = try values.decodeIfPresent(String.self, forKey: .layoutID)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        intentData = try values.decodeIfPresent(String.self, forKey: .intentData)
        googleCSenderID = try values.decodeIfPresent(String.self, forKey: .googleCSenderID)
        googleCAE = try values.decodeIfPresent(String.self, forKey: .googleCAE)
        secondSound = try values.decodeIfPresent(String.self, forKey: .secondSound)
        aps = try values.decodeIfPresent(Aps.self, forKey: .aps)
        isWigzoNotification = try values.decodeIfPresent(String.self, forKey: .isWigzoNotification)
        gcmNotificationMutableContent  = try values.decodeIfPresent(String.self, forKey: .gcmNotificationMutableContent )
        gcmMessageID = try values.decodeIfPresent(String.self, forKey: .gcmMessageID)
        googleCFid = try values.decodeIfPresent(String.self, forKey: .googleCFid)
    }
}


// MARK: - Alert
struct Alert: Codable {
    var title: String?
}

// MARK: - Button
struct WigzoButton: Codable {
    var buttonURL, buttonName, buttonAction, buttonFontColor: String?
    var buttonFontSize, buttonColor: String?

    enum CodingKeys: String, CodingKey {
        case buttonURL = "buttonUrl"
        case buttonName, buttonAction, buttonFontColor, buttonFontSize, buttonColor
    }
}
