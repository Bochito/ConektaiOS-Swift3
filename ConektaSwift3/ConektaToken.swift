//
//  ConektaToken.swift
//  Bochito
//
//  Created by Manuel Becerra Marrufo on 10/16/16.
//  
//

import Foundation

class ConektaToken {
    var baseURI: String
    var publicKey: String
    var resourceURI: String
    
    var card: ConektaCard?
    var deviceFingerprint: NSString?
    
    init(publicKey: String) {
        self.resourceURI = "/tokens"
        self.baseURI = "https://api.conekta.io"
        self.publicKey = publicKey
    }
    
    convenience init(withCard: ConektaCard, publicKey: String){
        self.init(publicKey: publicKey)
        self.card = withCard
    }
    
    func setCard(card: ConektaCard){
        self.card = card
    }
    
    func setDeviceFingerPrint(deviceFingerprint: NSString){
        self.deviceFingerprint = deviceFingerprint
    }
    
    func create(success: @escaping (_ result: [String: Any])->Void, error: (_ error: [String: Any])->Void)
    {
        if(self.card == nil){
            return
        }
        let urlPath = String.localizedStringWithFormat("%@%@", self.baseURI, self.resourceURI)
    
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue(NSString.localizedStringWithFormat("Basic %@", self.apiKeyBase64(api_key: self.publicKey)) as String, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
        request.addValue("{\"agent\":\"Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
    
        request.httpBody = self.card!.asJSONData()
        
        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print("Transaction result: ")
            print(result!)
            
            if let data = result!.data(using: String.Encoding.utf8.rawValue) {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String:AnyObject]
                    if error != nil {
                        print(error)
                    }
                    
                    // Get data
                    
                    success(json!)
                    
                    print(json)
                    
                    /*if let resultCode = (json!["code"] as? String) {
                        
                        switch resultCode {
                            
                        case "success":
                            break
                        default:
                            break
                        }
                        
                    }*/
                }
                catch{
                    print(error)
                }
            }
            
        })
        
        
        dataTask.resume()
    }
    
    func apiKeyBase64(api_key: String) -> String
    {
        let plainData = api_key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        let apiKeyBase64Data = plainData!.base64EncodedData(options: .lineLength64Characters)
        
        let returnValue = NSString(data: apiKeyBase64Data, encoding: String.Encoding.utf8.rawValue)
        return returnValue! as String
    }
}
