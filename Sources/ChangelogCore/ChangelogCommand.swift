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
        abstract: "Create a JSON changelog entry file in the folder upcoming",
        discussion: """
        Lightweight utility to create a changelog entry file and generate a release CHANGELOG.md
        """,
        version: "1.0.0",
        shouldDisplay: true,
        subcommands: [],
        defaultSubcommand: nil,
        helpNames: .long)

    @Argument(help: "the text for the changelog entry")
    public var text: String

    public init() {}

    public func run() throws {
        try Changelog().add(text: text)

        print("Done - created changelog entry file")
    }
}
