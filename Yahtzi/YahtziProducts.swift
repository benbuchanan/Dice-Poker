//
//  YahtziProducts.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 5/19/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import Foundation

public struct YahtziProducts {
  
  public static let SwiftShopping = "yahtzi.remove.ads"
  
  private static let productIdentifiers: Set<ProductIdentifier> = [YahtziProducts.SwiftShopping]

  public static let store = IAPHelper(productIds: YahtziProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
