//
//  PreciseRound.swift
//  Recipe List App
//
//  Created by Sazza on 5/2/23.
//

import Foundation

// Specify the decimal place to round to using an enum
public enum RoundingPrecision {
    case ones
    case tenths
    case hundredths
}

// Round to the specific decimal place
public func preciseRound(
    _ value: Double,
    precision: RoundingPrecision = .ones) -> Double
{
    switch precision {
    case .ones:
        return ceil(value)
    case .tenths:
        return ceil(value * 10) / 10.0
    case .hundredths:
        return ceil(value * 100) / 100.0
    }
}
