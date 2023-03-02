//
//  EventMetaData.swift
//  
//
//  Created by Rihan on 02/12/22.
//

import Foundation

public class EventMetaData : Model {
    
    private var title : String?;
    private var description : String?;
    private var productId : String?;
    private var price : Double?;
    private var url : String?;
    
    public init() {}
    
    public func setTitle(title : String) -> Void { self.title = title }
    public func setDescription(description : String) -> Void { self.description = description }
    public func setProductId(productId : String) -> Void { self.productId = productId }
    public func setPrice(price : Double) -> Void { self.price = price }
    public func setUrl(url : String) -> Void { self.url = url }
    
    public func getTitle() -> String { return self.title! }
    public func getDescription() -> String { return self.description! }
    public func getProductId() -> String { return self.productId! }
    public func getPrice() -> Double { return self.price! }
    public func getUrl() -> String { return self.url! }
    
    func dict() -> Dictionary<String, Any> {
        var eventMetaData : Dictionary<String, Any> = [:];
        if StringUtils.isNotEmpty(self.title!) {
            eventMetaData["title"] = self.title
        }
        if StringUtils.isNotEmpty(self.description!) {
            eventMetaData["description"] = self.description
        }
        if StringUtils.isNotEmpty(self.productId!) {
            eventMetaData["productId"] = self.productId
        }
        if self.price != nil {
            eventMetaData["price"] = self.price
        }
        if StringUtils.isNotEmpty(self.url!) {
            eventMetaData["url"] = self.url
        }
        return eventMetaData;
    }
    
    func isValid() throws -> Bool {
        if StringUtils.allEmpty(self.title!, self.description!, self.productId!, self.url!) && (self.price != nil) {
            throw Validation.EventMetaDataError("Metadata should contain at least: title (String), description (String), productId (String), price (Double), url (String)");
        }
        return false
    }
}
