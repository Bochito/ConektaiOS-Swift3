# ConektaiOS-Swift3

Conekta iOS Swift 3
======================

Conekta in Xcode 8, Swift 3

### Swift 3 ViewController Example

```swift
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        let conekta = Conekta()
        
        conekta.delegate = self
        conekta.publicKey = "conekta_key"
        
        conekta.collectDevice()
        
        let card = ConektaCard()
        
        let name = "John Cena"
        let number = "4242424242424242"
        let monthExp = "10"
        let yearExp = "2020"
        let cvc = "123"
        
        card.setNumber(number: number, name: name, cvc: cvc, expMonth: monthExp, expYear: yearExp)
        
        let token = ConektaToken(publicKey: conekta.publicKey!)
        
        token.card = card
        
        token.create(success: { (data) -> Void in
            
            //print(data)
            print(data)
            self.processPayment(data)
            
            }, error: { (error) -> Void in
                print(error)
        })
        
        super.viewDidLoad()
    }
    
    func processPayment(_ data: [String: Any]!){
        
        let conektaTokenId = data["id"] as! String // Ejemplo
        print("El token es \(conektaTokenId)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
```
