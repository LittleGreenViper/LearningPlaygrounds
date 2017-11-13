//
//  main.swift
//  CyclicalAssets
//
//  Created by Chris Marshall on 11/11/17.
//  Copyright © 2017 BNR. All rights reserved.
//

import Foundation

var bob: Person? = Person(name: "Bob")
print("created \(String(describing: bob))")

var laptop: Asset? = Asset(name: "Shiny Laptop", value: 1_500.0)
var hat: Asset? = Asset(name: "Cowboy Hat", value: 175.0)
var backpack: Asset? = Asset(name: "Blue Backpack", value: 45.0)

bob?.takeOwnership(of: laptop!)
bob?.takeOwnership(of: hat!)

print("While Bob is alive, hat's owner is \(hat!.owner)")

bob = nil
print("the bob variable is now \(String(describing: bob))")
print("After Bob is deallocated, hat's owner is \(hat!.owner)")


laptop = nil
hat = nil
backpack = nil

