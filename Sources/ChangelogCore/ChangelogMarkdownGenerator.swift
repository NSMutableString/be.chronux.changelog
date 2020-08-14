//
//  ChangelogEntry.swift
//  Changelog
//
//  Created by Bram Huenaerts on 13/08/2020.
//  Copyright © 2020 chronux bv. All rights reserved.
//

import Foundation

struct ChangelogMarkdownGenerator {

    var buffer: String

    init() {
        buffer = ""
    }

    mutating func writeReleaseName(_ name: String) {
        buffer.append("# \(name)\n")
    }

    mutating func writeCategoryName(_ category: String) {
        buffer.append("## \(category)\n")
    }

    mutating func writeEmptyLine() {
        buffer.append("\n")
    }

    mutating func writeLine(changelogEntry: ChangelogEntry) {
        buffer.append("- \(changelogEntry.text) [\(changelogEntry.changeRequest)]\n")
    }
}
