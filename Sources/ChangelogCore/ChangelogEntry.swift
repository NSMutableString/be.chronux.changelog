//
//  ChangelogEntry.swift
//  ArgumentParser
//
//  Created by Bram Huenaerts on 13/08/2020.
//

import Foundation

enum Category: String, Decodable {
    case added
    case fixed
    case updated
    case deleted
}

struct ChangelogEntry: Decodable {
    let category: Category
    let text: String
    /// The  Merge request or Pull request number related to this changelog entry
    let changeRequest: String
}
