//
//  Conekta.swift
//  Bochito
//
//  Created by Manuel Becerra Marrufo on 10/16/16.
//  
//

import Foundation

class Conekta: NSObject{
    
    var baseURI: String
    var publicKey: String?
    var delegate: UIViewController?
    
    override init(){
        self.baseURI = "https://api.conekta.io"
    }
    
    func deviceFingerprint() -> String
    {
        let uuid: String = (UIDevice.current.identifierForVendor?.uuidString)!
        
        return uuid.replacingOccurrences(of: "-", with: "")
    }
    
    func collectDevice() {
        
        let html: String = NSString.localizedStringWithFormat("<html style=\"background: blue;\"><head></head><body><script type=\"text/javascript\" src=\"https://conektaapi.s3.amazonaws.com/v0.5.0/js/conekta.js\" data-conekta-public-key=\"%@\" data-conekta-session-id=\"%@\"></script></body></html>", self.publicKey!, self.deviceFingerprint()) as String
        
        
        let web: UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        web.loadHTMLString(html, baseURL: nil)
        web.scalesPageToFit = true
        
        self.delegate?.view.addSubview(web)
        
    }

}
