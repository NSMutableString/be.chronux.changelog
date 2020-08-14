//
//  ChangelogEntry.swift
//  be.chronux.changelog
//
//  Created by Bram Huenaerts on 13/08/2020.
//  Copyright © 2020 chronux bv. All rights reserved.
//

import Foundation

/// Used for conversion from and to our JSON file to construct a CHANGELOG.md file
struct ChangelogEntry: Codable {

    enum Category: String, Codable, RawRepresentable, CaseIterable {
        case added
        case fixed
        case updated
        case deleted
    }

    /// Choose from one of the four categories to put the text under
    let category: Category
    /// Keep it short please and use imperative, describe what and or why, not how.
    let text: String
    /// The  Merge request or Pull request number related to this changelog entry
    let changeRequest: String
}
