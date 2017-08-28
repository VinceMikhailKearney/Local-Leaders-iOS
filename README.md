# ThunderEchoSabre #

Thunder Echo Sabre is a tool that allows people to connect to their local MLAs to voice any concerns they may have. By combining open soure data we hope to build a go-to app that will save people the bother of finding out their constituency, working out who their MLAs are and figuring out how to contact them. We hope we can do it all for you.

This app uses a Django/Python server to get the MLA and Parties information, linked here: https://github.com/VinceMikhailKearney/DevelopmentServer

## Additional Notes ##

- Python scripts are used to download and place the images for each of the MLAs in the Drawable folder, same goes for the party images.
- Server: Django/Python (originally Firebase)
- Database: Realm
- Dependency Management: Carthage

## Makefile ##

The Makefile inclues:
- Dependency visualiser (https://github.com/PaulTaykalo/objc-dependency-visualizer)
    - Command: make dotty
    - Notes: This command cleans the build for the project and then builds it in order for the dependency visualiser to target the right project.
- Static Analyser & Linting tool (Tailor - https://github.com/sleekbyte/tailor)
    - Command: make tailor
    - Notes: This command puts the json format of the Tailor output into a Javascript file, which then using something I have written takes the data and creates a bar chart :) Opens the html file instantly. Much easier way to view the output.
- Formatting tool (Swiftformat - https://github.com/nicklockwood/SwiftFormat)
    - Command: make format
    - Notes: Formats all swift files in given directory ignoring the brace style rule.
- Script to download all MLA images
    - Command: make images
- Script to download all Party images
    - Command: make partyImages
- Tail output of SwiftyBeaver log file if using Simulator
    - Command: make tail
### License ###

This project is licensed under the MIT License - see the LICENSE.md file for details
