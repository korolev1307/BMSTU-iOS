//
//  main.swift
//  HW1
//
//  Created by Александр Королев on 16.09.2018.
//  Copyright © 2018 Korolev. All rights reserved.
//

import Foundation
protocol Printable {
   func PrintData()
}

enum currentValue: String {
    case RUR
    case USD
    case EUR
}

class MainData {
    let id: Int
    var balance: Double
    let currency: currentValue
    
    init(id: Int, balance: Double, currency: String ) {
        self.id = id
        self.balance = balance
        self.currency = currentValue(rawValue: currency)! //Why I need to use ! in the end? (I used it because swift had errors)
    }
    
    func PrintMain() {
        print("MainData: \n id: \(id), balance: \(balance), currency: \(currency)\n")
    }
}

class Account: MainData, Printable {
    let Description: String
    var Offer: String?
    
    init(id: Int, balance: Double, currency: String, Description: String, Offer: String? = nil) {
        self.Description = Description
        if let Offer = Offer {
            self.Offer = Offer
        }
        super.init(id: id, balance: balance, currency: currency) //Why it's not working before Description and Offer init?
    }
    
    func PrintData() {
        super.PrintMain()
        print("Account:\n Description:\(Description) Offer:\(Offer ?? "Not Stated")\n\n")
    }
}

class ReissueInfo: Printable {
    let Date: Date
    let Info: String
    let Address: String
    
    init(Date: Date, Info: String, Address: String = "Main Office")
    {
        self.Date = Date
        self.Info = Info
        self.Address = Address
    }
    
    func PrintData() {
        let GoodDate = DateFormatter()
        GoodDate.dateFormat = "dd --- MM --- YYYY"
        print("ReissueInfo:\n Date: \(GoodDate.string(from: Date)) Info: \(Info) Address: \(Address)\n\n")
    }
}

class Card: MainData, Printable {
    var ReissueInfo: ReissueInfo?
    
    init(id: Int, balance: Double, currency: String, ReissueInfo: ReissueInfo? = nil) {
        if let ReissueInfo = ReissueInfo {
            self.ReissueInfo = ReissueInfo
        }
        super.init(id: id, balance: balance, currency: currency)
    }
    
    func PrintData() {
        super.PrintMain()
        if let ReissueInfo = ReissueInfo {
            ReissueInfo.PrintData()
        }
    }
}

class ServerResponce: Printable {
    var Cards: [Card]
    var Accounts: [Account]
    
    init(Cards: [Card], Accounts: [Account]) {
        self.Cards = Cards
        self.Accounts = Accounts
    }
    
    func PrintData() {
        for Card in Cards {
            Card.PrintData()
        }
        for Account in Accounts {
            Account.PrintData()
        }
    }
}

let ac1 = Account(id: 1, balance: 1000, currency: "RUR", Description: "lol kek cheburek") // Offer = nil
let ac2 = Account(id: 2, balance: 3228, currency: "USD", Description: "kek lol cheburek", Offer: "coupon PAPAZ" ) // Offer != nil
let accs = [ac1, ac2]
let currentDate = "19 --- 09 --- 2018"
var DateFormat = DateFormatter()
DateFormat.dateFormat = "dd --- MM --- YYYY"
var Date = DateFormat.date(from: currentDate)
let reissueInfo = ReissueInfo(Date: Date!, Info: "i'm so tired", Address: "PushkinoGalushkino") // I'm used it againg
let card1 = Card(id: 3, balance: 322, currency: "EUR", ReissueInfo: reissueInfo) //reissueInfo != nil
let card2 = Card(id: 4, balance: 228, currency: "RUR") //reissueInfo = nil
let cards = [card1, card2]
let response = ServerResponce(Cards: cards, Accounts: accs)

var array: [Printable] = []

array.append(contentsOf: cards)

array.append(contentsOf: accs)

array.append(response)

for item in array {
    item.PrintData()
}
