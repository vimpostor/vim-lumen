#!/usr/bin/env swift

// Based on https://github.com/mnewt/dotemacs/blob/master/bin/dark-mode-notifier.swift (Unlicense license)

import Cocoa
import Darwin

var isAppearanceDark: Bool {
	if #available(macOS 11.0, *) {
		return NSAppearance.currentDrawing().bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
	} else {
		return NSAppearance.current.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
	}
}

func printAppearance() {
	let string = isAppearanceDark ? "LDark" : "Light"
	try! FileHandle.standardOutput.write(contentsOf: Data((string + "\n").utf8))
	// print(string) // doesn't work for some strange reason?!
}

if CommandLine.arguments.dropFirst(1).first == "get" {
	printAppearance()
	exit(0)
}

DistributedNotificationCenter.default.addObserver(
		forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
		object: nil,
		queue: nil) { _ in
	printAppearance()
}

NSApplication.shared.run()
