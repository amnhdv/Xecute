//
//  main.swift
//  Xecute
//
//  Created by Amin Hadavi on 3/23/22.
//

import Foundation
import Cocoa

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
