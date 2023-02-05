//
//  Extensions.swift
//  Recipe List App
//
//  Created by Sazza on 7/11/22.
//

import Foundation
import UIKit
import SwiftUI

/// Extension for finding devices screen size
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

/// Extension for embedding view in Navigation View 
extension View {
    func embedInNavigationView () -> some View {
        NavigationView {self}
    }
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
