# Moulinette-2.0
An internal audit tool for Prolific Interactive brought to you by the PiOS team.

## Authors
* Jonathan Samudio
* Adam Tecle
* Morgan Collino
* Ruchi Jain

## Requirements
* Xcode 8.3.3 or up

## Instructions
How to build and run Moulinette on a Prolific Interactive project.

### From the command line
1. Open the project in Xcode by double clicking on the `.xcodeproj` file or running `open Moulinette-2.0.xcodeproj`.
2. Build the project using `CMD B`.
3. Copy the executable file titled `Moulinette-2.0` from `/Build/Products/Debug/` to your `your_project_repo/subdirectory`.
4. Run from the command line: `./Moulinette-2.0 --projectName <project-name> --auditSubDirectory <subdirectory>`.

### From Xcode
1. Open the project in Xcode as in step 1 from above.
2. Set the `projectName` and `auditSubDirectory` variables in `ProjectSettings.swift`.
3. Build and run the project using `CMD R`.

## How To Contribute
1. New rules conform to the `SwiftRule` protocol in `SwiftRule.swift`.
