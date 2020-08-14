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
        generator.writeEmptyLine()

        for file in try FileManager.default.contentsOfDirectory(atPath: upcomingChangelogEntryDirectory.path) {
            let fileUrl = upcomingChangelogEntryDirectory.appendingPathComponent(file)
            let data = try Data(contentsOf: fileUrl)
            let changelogEntry = try JSONDecoder().decode(ChangelogEntry.self, from: data)
            generator.writeLine(changelogEntry: changelogEntry)
        }

        return generator.buffer
    }
}
