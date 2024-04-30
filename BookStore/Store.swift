//
//  Store.swift
//  BookStore
//
//  Created by Enrique Sarmiento on 29/4/24.
//

import Foundation
import StoreKit

//here with typealias we create like a custom type as typescript and we can use it everywhere we want.
typealias FetchCompleteHandler = (([SKProduct]) -> Void)?
typealias PurchasesCompleteHandler = ((SKPaymentTransaction) -> Void)?


class Store: NSObject, ObservableObject {
   
   // here we initialize our product as Books type empty array
   @Published var allBooks = [Books]()
   
   //this are the identifiaer we have on the configuration file and then on aple connect, and needs to be the same in order to work. 
   private let allidentifiers = Set([
      "com.enriquesarmiento.BookStore.codigoDavinci",
      "com.enriquesarmiento.BookStore.harryPotter",
      "com.enriquesarmiento.BookStore.fullAccess",
   ])
   
   // here we update the lock boolena value in case has been purchesed.
   private var completedPurchases = [String](){
      didSet{
         DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            
            for index in self.allBooks.indices {
               self.allBooks[index].lock = !self.completedPurchases.contains(self.allBooks[index].id)
            }
         }
      }
   }
   
   private var productsRequest: SKProductsRequest?
   private var fetchedProducts =  [SKProduct]()
   private var fetchCompleteHandler: FetchCompleteHandler?
   private var purchasesCompleteHandler: PurchasesCompleteHandler?
   
   override init() {
      super.init()
      startObservingPayment()
      fetchProducts { products in
         self.allBooks = products.map{
            Books(product: $0)
         }
      }
   }
   
   // to this function to work, we need to add the extension for paymentQueu
   private func startObservingPayment(){
      SKPaymentQueue.default().add(self)
   }
   
   private func fetchProducts(_ completion: FetchCompleteHandler){
      guard self.productsRequest == nil else {return}
      fetchCompleteHandler = completion
      productsRequest = SKProductsRequest(productIdentifiers: allidentifiers)
      productsRequest?.delegate = self
      productsRequest?.start()
   }
   
   private func buy(_ product: SKProduct, _ completion: PurchasesCompleteHandler){
      purchasesCompleteHandler = completion
      let payment = SKPayment(product: product)
      SKPaymentQueue.default().add(payment)
   }
   
   
}

extension Store: SKProductsRequestDelegate {
   
   func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
      let loadedProducts = response.products
      let invalidProducts = response.invalidProductIdentifiers
      
      guard !loadedProducts.isEmpty else {
         print("DEBUG: no se pueden cargar los productos")
         if !invalidProducts.isEmpty {
            print("DEBUG: productos invalidos encontrados: \(invalidProducts)")
         }
         productsRequest = nil
         return
      }
      
      fetchedProducts = loadedProducts
      DispatchQueue.main.async {
         self.fetchCompleteHandler?!(loadedProducts)
         self.fetchCompleteHandler = nil
         self.productsRequest = nil
      }
   }
}

extension Store: SKPaymentTransactionObserver {
   func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
      
      for transaction in transactions {
         var finishTransaction = false
         switch transaction.transactionState {
            
         case .purchased, .restored:
            completedPurchases.append(transaction.payment.productIdentifier)
            finishTransaction = true
         case .failed:
            finishTransaction = true
         case .deferred, .purchasing:
            break
         @unknown default:
            break
         }
         
         if finishTransaction {
            SKPaymentQueue.default().finishTransaction(transaction)
            DispatchQueue.main.async {
               self.purchasesCompleteHandler?!(transaction)
               self.purchasesCompleteHandler = nil
            }
         }
      }
   }
}

extension Store {
   func product(for identifier: String) -> SKProduct? {
      return fetchedProducts.first(where: { $0.productIdentifier == identifier})
   }
   
   func purchaseProduct(product: SKProduct){
      startObservingPayment()
      buy(product){ _ in }
   }
   
   func restorePurchase(){
      SKPaymentQueue.default().restoreCompletedTransactions()
   }
}
