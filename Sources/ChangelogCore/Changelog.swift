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

    /// Add all content available from ChangelogEntry to a file with name `<changelogEntry.changeRequest>.json` in the given folder.
    func add(changelogEntry: ChangelogEntry, to upcomingChangelogEntryDirectory: URL) throws {
        let changelogEntryFile = upcomingChangelogEntryDirectory.appendingPathComponent("\(changelogEntry.changeRequest).json")

        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        try jsonEncoder.encode(changelogEntry).write(to: changelogEntryFile)

        print(changelogEntryFile.absoluteString)
    }

    func generate(from upcomingChangelogEntryDirectory: URL, releaseName: String) throws -> String {
        var generator = ChangelogMarkdownGenerator()

        generator.writeReleaseName(releaseName)

        for category in ChangelogEntry.Category.allCases {
            generator.writeEmptyLine()
            generator.writeCategoryName(category.rawValue)
            let entries = try getChangelogEntries(for: category, from: upcomingChangelogEntryDirectory)
            generateLines(for: category, entries: entries, generator: &generator)
        }

        return generator.buffer
    }

    private func getChangelogEntries(for category: ChangelogEntry.Category, from upcomingChangelogEntryDirectory: URL) throws -> [ChangelogEntry] {
        var entries = [ChangelogEntry]()
        for file in try FileManager.default.contentsOfDirectory(atPath: upcomingChangelogEntryDirectory.path) {
            let fileUrl = upcomingChangelogEntryDirectory.appendingPathComponent(file)
            let data = try Data(contentsOf: fileUrl)
            let changelogEntry = try JSONDecoder().decode(ChangelogEntry.self, from: data)
            if changelogEntry.category == category {
                entries.append(changelogEntry)
            }
        }
        return entries
    }

    private func generateLines(for category: ChangelogEntry.Category, entries: [ChangelogEntry], generator: inout ChangelogMarkdownGenerator) {
        for entry in entries {
            generator.writeLine(changelogEntry: entry)
        }
    }
}
