//
//  CommandsViewController.swift
//  Xecute
//
//  Created by Amin Hadavi on 3/23/22.
//

import Cocoa
import Foundation

class CommandsViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var command: NSTextFieldCell!
    @IBAction func commandSent(_ sender: Any) {
        command.stringValue = try! safeShell(command.stringValue)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension CommandsViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> CommandsViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier(_: "CommandsViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? CommandsViewController else {
          fatalError("error")
        }
        return viewcontroller
    }
}

func safeShell(_ command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.executableURL = URL(fileURLWithPath: "/bin/zsh") // or any shell

    try task.run() //<--updated
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}
