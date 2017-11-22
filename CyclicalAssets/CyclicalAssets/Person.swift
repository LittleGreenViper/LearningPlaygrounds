//
//  Person.swift
//  CyclicalAssets
//
//  Created by Chris Marshall on 11/11/17.
//  Copyright © 2017 BNR. All rights reserved.
//

import Foundation

class Person: CustomStringConvertible {
    let name: String
    let accountant = Accountant()
    var assets = [Asset]()

    var description: String {
        return "Person(\(name))"
    }
    
    init(name: String) {
        self.name = name
        accountant.netWorthChangedHandler = {
            [weak self] netWorth in
            self?.netWorthDidChange(to: netWorth)
            return
        }
    }
    
    func useNetWorthChangedHandler(handler: @escaping (Double) -> Void) {
        accountant.netWorthChangedHandler = handler
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
    
    func takeOwnership(of asset: Asset) {
        accountant.gained(asset) {
            asset.owner = self
            assets.append(asset)
        }
    }
    
    func netWorthDidChange(to netWorth: Double) {
        print("The net worth of \(self) is now \(netWorth)")
    }
}