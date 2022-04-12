//
//  Letter.swift
//  GreekDictionary
//
//  Created by Grigorii Metelev on 12.04.2022.
//

import Foundation

final class Letter {

    enum Letters: String, CaseIterable {
        case alpha
        case beta
        case gamma
        case delta
        case epsilon
        case zeta
        case eta
        case theta
        case iota
        case kappa
        case lambda
        case mu
        case nu
        case xi
        case omicron
        case pi
        case rho
        case sigma
        case tau
        case ypsilon
        case phi
        case chi
        case psi
        case omega

        var greekValue: String {
            switch self {
            case .alpha: return "α"
            case .beta: return "β"
            case .gamma: return "γ"
            case .delta: return "δ"
            case .epsilon: return "ε"
            case .zeta: return "ζ"
            case .eta: return "η"
            case .theta: return "θ"
            case .iota: return "ι"
            case .kappa: return "κ"
            case .lambda: return "λ"
            case .mu: return "μ"
            case .nu: return "ν"
            case .xi: return "ξ"
            case .omicron: return "ο"
            case .pi: return "π"
            case .rho: return "ρ"
            case .sigma: return "ς"
            case .tau: return "τ"
            case .ypsilon: return "υ"
            case .phi: return "φ"
            case .chi: return "χ"
            case .psi: return "ψ"
            case .omega: return "ω"
            }
        }
    }

    let value: Letters
    let startHash: Int
    let endHash: Int
    var words: [Word] = []

    init(value: Letters, startHash: Int, endHash: Int) {
        self.value = value
        self.startHash = startHash
        self.endHash = endHash
    }
}
