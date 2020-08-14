//
//  ChangelogCommand.swift
//  be.chronux.changelog
//
//  Created by Bram Huenaerts on 13/08/2020.
//  Copyright © 2020 chronux bv. All rights reserved.
//

import ArgumentParser
import Foundation

public struct ChangelogCommand: ParsableCommand {
    public static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "Changelog",
        abstract: "Create a JSON changelog entry file in the folder upcoming and construct CHANGELOG.md file from it when creating a release",
        discussion: """
        Lightweight utility to solve changelog conflict merge hell
        """,
        version: "1.0.0",
        shouldDisplay: true,
        subcommands: [Add.self, Generate.self],
        defaultSubcommand: nil,
        helpNames: .long)

    public init() {}
}

public struct Add: ParsableCommand {

    @Argument(help: "the category for the changelog entry")
    public var category: String

    @Argument(help: "the text for the changelog entry")
    public var text: String

    @Argument(help: "the changerequest number")
    public var changeRequest: String

    public init() {}

    public func run() throws {

        // Validate input
        guard let mappedCategory = ChangelogEntry.Category(rawValue: category) else {
            throw ChangelogError.invalidCategory
        }

        // Bundle all information
        let changelogEntry = ChangelogEntry(category: mappedCategory, text: text, changeRequest: changeRequest)

        // Construct the path where we the file needs to be added
        let currentDirectoryPath = FileManager.default.currentDirectoryPath
        let directoryForChangelogEntryFile = URL(fileURLWithPath: currentDirectoryPath).appendingPathComponent("upcoming", isDirectory: true)
        try FileManager.default.createDirectory(atPath: directoryForChangelogEntryFile.path, withIntermediateDirectories: true, attributes: nil)

        try Changelog().add(changelogEntry: changelogEntry, to: directoryForChangelogEntryFile)

        print("Done - created changelog entry file")
    }
}

public struct Generate: ParsableCommand {
    @Argument(help: "the release name under which all upcoming change log entries will be bundled.")
    public var releaseName: String

    public init() {}

    public func run() throws {
        let currentDirectoryPath = FileManager.default.currentDirectoryPath
        let directoryForUpcomingChangelogEntries = URL(fileURLWithPath: currentDirectoryPath).appendingPathComponent("upcoming", isDirectory: true)

        let markdownText = try Changelog().generate(from: directoryForUpcomingChangelogEntries, releaseName: releaseName)

        print(markdownText)
        print("Done - generated changelog based on all changelog entry json file")
    }
}
