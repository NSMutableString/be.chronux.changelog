//
//  ChangelogEntry.swift
//  ArgumentParser
//
//  Created by Bram Huenaerts on 13/08/2020.
//

import Foundation

struct ChangelogEntry: Decodable {

    enum Category: String, Decodable, RawRepresentable {
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
