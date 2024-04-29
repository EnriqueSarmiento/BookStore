//
//  Books.swift
//  BookStore
//
//  Created by Enrique Sarmiento on 29/4/24.
//

import Foundation
import StoreKit

struct Books: Hashable {
   let id: String
   let title: String
   let description : String
   
   //this value represent a way to unlock/lock some products, services and/or subscriptions
   var lock: Bool
   // price could be optional becase in some cases some product can be free.
   var price : String?
   var locale: Locale?
   
   lazy var formatter: NumberFormatter = {
      let ns = NumberFormatter()
      ns.numberStyle = .currency
      ns.locale = locale
      return ns
   }()
   
   // this init is required in order to initialize varibales variables
   init(product: SKProduct, lock: Bool = true ){
      // this product identifier is the product we create on the configuration file, PRODUCT ID VALUE. the other values are alse the one we established on each product
      self.id = product.productIdentifier
      self.title = product.localizedTitle
      self.description = product.localizedDescription
      self.lock = lock
      self.locale = product.priceLocale
      
      if lock {
         self.price = formatter.string(from: product.price)
      }
   }
}
