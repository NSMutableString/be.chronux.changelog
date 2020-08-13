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
        subcommands: [Add.self],
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
        try Changelog().add(category: category, text: text, changeRequest: changeRequest)

        print("Done - created changelog entry file")
    }
}

public struct Generate: ParsableCommand {
    @Argument(default: "UPCOMING", help: "the text for the changelog entry")
    public var folder: String

    public init() {}

    public func run() throws {
        try Changelog().generate()

        print("Done - generated changelog based on all changelog entry json file")
    }
}
