//
//  Card.swift
//  Bochito
//
//  Created by Manuel Becerra Marrufo on 10/14/16.
//  
//

import Foundation

class ConektaCard : NSObject {
    
    var baseURI: String
    //var publicKey: String
    var resourceURI: String
    
    var number: String?
    var name: String?
    var cvc: String?
    var expMonth: String?
    var expYear: String?
    var deviceFingerprint: String
    
    override init(){
        self.baseURI = "https://api.conekta.io"
        self.resourceURI = "/cards"
        self.deviceFingerprint = Conekta().deviceFingerprint()
        super.init()
    }
    
    init(number: String, name: String, cvc: String, expMonth: String, expYear: String)
    {
        
        // api data
        self.baseURI = "https://api.conekta.io"
        self.resourceURI = "/cards"
        self.deviceFingerprint = Conekta().deviceFingerprint()
        
        // card data
        self.number = number
        self.name = name
        self.cvc = cvc
        self.expMonth = expMonth
        self.expYear = expYear
        super.init()
        
    }
    
    func setNumber(number: String, name: String, cvc: String, expMonth: String, expYear: String)
    {
        self.number = number
        self.name = name
        self.cvc = cvc
        self.expMonth = expMonth
        self.expYear = expYear
    }
    
    
    func asJSONData() -> Data
    {
        let jsonString = "{\"card\":{\"name\": \"%@\", \"number\":  \"%@\", \"cvc\": \"%@\", \"exp_month\":  \"%@\", \"exp_year\": \"%@\", \"device_fingerprint\": \"%@\" } }"
        let json = String.localizedStringWithFormat(jsonString as String, self.name!, self.number!, self.cvc!, self.expMonth!, self.expYear!, self.deviceFingerprint)
        return json.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        
    }
    
}
