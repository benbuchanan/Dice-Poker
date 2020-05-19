//
//  File.swift
//  Yahtzi
//
//  Created by Ben Buchanan on 5/19/20.
//  Copyright © 2020 Ben Buchanan. All rights reserved.
//

import Foundation

public struct RazeFaceProducts {
  
  public static let SwiftShopping = "SwiftShopping"
  
  private static let productIdentifiers: Set<ProductIdentifier> = [RazeFaceProducts.SwiftShopping]

  public static let store = IAPHelper(productIds: RazeFaceProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
