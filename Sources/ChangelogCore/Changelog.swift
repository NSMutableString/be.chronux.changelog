//
//  Changelog.swift
//  be.chronux.changelog
//
//  Created by Bram Huenaerts on 13/08/2020.
//  Copyright © 2020 chronux bv. All rights reserved.
//

import Foundation

enum ChangelogError: Error {
    case invalidCategory
}

struct Changelog {

    func add(category: String, text: String, changeRequest: String) throws {
        guard let mappedCategory = ChangelogEntry.Category(rawValue: category) else {
            throw ChangelogError.invalidCategory
        }
        let changelogEntry = ChangelogEntry(category: mappedCategory, text: text, changeRequest: changeRequest)
        
    }

    func generate() throws {

    }
}
