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
    
    deinit {
        print("\(self) is being deallocated")
    }
    
    func takeOwnership(of asset: Asset) {
        asset.owner = self
        assets.append(asset)
        accountant.gained(asset)
    }
    
    func netWorthDidChange(to netWorth: Double) {
        print("The net worth of \(self) is now \(netWorth)")
    }
}
