//
//  Cell-ID.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 31.07.2023.
//

import Foundation

protocol HasCellID {
    static var reusableIdentifier: String { get }
}

extension HasCellID {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}
