# macOSInstallerVersion
Script to search MacOS Installer App for the Version

The script attaches the `SharedSupport.dmg` to look for a build number for the macOS Installer.

```bash
./get_macos_build.sh '/Applications/Install macOS 15 beta.app'
```


## Option 1: Download macOS Beta Full Installer

Download macOS Sequoia Full Installers from the App Store for Intel and Apple Silicon M1, M2, and M3 Mac computers. You can install this on an external hard drive.

1. Download the "macOS Sequoia Full Installer" directly from Apple [macOS 15.0 Beta 1 (24A5264n)](https://swcdn.apple.com/content/downloads/50/33/052-49060-A_SUZPTRSXUG/rshd6um52uzcxnr1u85utqhl124vmsph1c/InstallAssistant.pkg)
    1. You can find more direct builds from Mr. Macintosh, since Apple doesn't publish these direct links on their support site.
    2. Download future [macOS Sequoia builds - linked from Mr. Machintosh](https://mrmacintosh.com/macos-sequoia-full-installer-database-download-directly-from-apple)
2. Verify the version is correct

```bash
./get_macos_build.sh '/Applications/Install macOS 15 beta.app'
```

## Option 2: Download macOS Beta from Command Line


1. Enable Beta Updates for your Mac (Sonoma)

<img width="600" alt="2024-06-11 beta updates software update" src="https://github.com/PaulSolt/macOSInstallerVersion/assets/371902/ce13e7ed-7551-4ed2-9f51-03766050581a">

3. Run the command to list the installers

```bash
softwareupdate --fetch-full-installer --list-full-installers
```

Output:

```bash
➜  SharedSupport softwareupdate --fetch-full-installer --list-full-installers
Finding available software
Software Update found the following full installers:
* Title: macOS Sonoma, Version: 14.5, Size: 13353373KiB, Build: 23F79, Deferred: NO
* Title: macOS Sonoma, Version: 14.4.1, Size: 13298513KiB, Build: 23E224, Deferred: NO
* Title: macOS Sonoma, Version: 14.4, Size: 13297753KiB, Build: 23E214, Deferred: NO
```

4. Run the command to install the version: 

```bash
softwareupdate --fetch-full-installer --full-installer-version 15.0
```

Output:

```bash
➜  SharedSupport softwareupdate --fetch-full-installer --full-installer-version 15.0
Scanning for 15.0 installer
Install finished successfully
```

