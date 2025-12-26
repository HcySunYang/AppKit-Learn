# MyApp - Project Overview

This is a macOS AppKit application created with Xcode using Storyboard and Swift. Below is an explanation of how each part works.

---

## 📁 Project Structure

```
MyApp/
├── AppDelegate.swift          # Application lifecycle management
├── ViewController.swift       # Main view controller
├── Assets.xcassets/           # Asset catalog for images and colors
│   ├── Contents.json
│   ├── AccentColor.colorset/  # App accent color
│   └── AppIcon.appiconset/    # App icon in various sizes
└── Base.lproj/
    └── Main.storyboard        # UI layout and menu bar definition
```

---

## 🔧 Core Components

### 1. AppDelegate.swift

The `AppDelegate` is the **entry point** and **lifecycle manager** of your macOS application.

```swift
@main
class AppDelegate: NSObject, NSApplicationDelegate
```

| Component | Description |
|-----------|-------------|
| `@main` | Marks this class as the application entry point. When the app launches, the system looks for this attribute. |
| `NSApplicationDelegate` | Protocol that defines methods to respond to app lifecycle events. |

#### Key Methods:

| Method | When Called | Purpose |
|--------|-------------|---------|
| `applicationDidFinishLaunching(_:)` | After the app has launched and is ready | Initialize app resources, set up initial state, configure services |
| `applicationWillTerminate(_:)` | Just before the app terminates | Clean up resources, save state, close connections |
| `applicationSupportsSecureRestorableState(_:)` | When restoring app state | Returns `true` to enable secure state restoration (recommended for security) |

---

### 2. ViewController.swift

The `ViewController` manages a **single view** and its content in the window.

```swift
class ViewController: NSViewController
```

#### Key Methods:

| Method | When Called | Purpose |
|--------|-------------|---------|
| `viewDidLoad()` | After the view is loaded into memory | One-time setup: configure UI elements, load data, add subviews |
| `representedObject` | When the represented object changes | Used for binding data to the view; update UI when the model changes |

#### View Controller Lifecycle:

```
viewDidLoad() → viewWillAppear() → viewDidAppear() → viewWillDisappear() → viewDidDisappear()
```

---

### 3. Main.storyboard

The **Storyboard** is an XML-based file that defines:

- **Application Menu Bar** - The menu items (File, Edit, View, Window, Help, etc.)
- **Window Controller** - Manages the window
- **View Controller** - Contains the main content view

#### Key Elements:

| Element | Description |
|---------|-------------|
| `<application>` | The NSApplication instance with the main menu |
| `<windowController>` | Controls the window's behavior and appearance |
| `<viewController>` | The ViewController class that manages the content |
| `initialViewController` | Specifies which scene loads first (referenced by ID `B8D-0N-5wS`) |

#### Menu Structure:
- **MyApp Menu**: About, Preferences, Services, Hide/Show, Quit
- **File Menu**: New, Open, Save, Close, Print
- **Edit Menu**: Undo/Redo, Cut/Copy/Paste, Find
- **View Menu**: Toggle Full Screen
- **Window Menu**: Minimize, Zoom, Bring All to Front
- **Help Menu**: App Help

---

### 4. Assets.xcassets (Asset Catalog)

The asset catalog organizes your app's **images, colors, and other resources**.

#### Contents:

| Asset | Purpose |
|-------|---------|
| `AccentColor.colorset` | Defines the app's accent color used for buttons, links, and highlights. Currently empty (uses system default). |
| `AppIcon.appiconset` | Contains app icons for various sizes (16x16 to 512x512 at 1x and 2x scales for Retina displays). |

#### Icon Size Requirements for macOS:

| Size | Scale | Actual Pixels | Usage |
|------|-------|---------------|-------|
| 16x16 | 1x, 2x | 16, 32 | Finder, Spotlight |
| 32x32 | 1x, 2x | 32, 64 | Finder |
| 128x128 | 1x, 2x | 128, 256 | Finder |
| 256x256 | 1x, 2x | 256, 512 | Finder |
| 512x512 | 1x, 2x | 512, 1024 | Finder, App Store |

---

## 🔄 How the App Launches

1. **System calls `@main`** → Finds `AppDelegate`
2. **NSApplication initializes** → Loads `Main.storyboard`
3. **Storyboard loads** → Creates window, menu bar, and initial view controller
4. **`applicationDidFinishLaunching(_:)`** → Your initialization code runs
5. **Window appears** → `ViewController.viewDidLoad()` is called
6. **App is ready** → User can interact with the UI

---

## 📚 Key Concepts

| Term | Definition |
|------|------------|
| **AppKit** | Apple's framework for building macOS apps (equivalent to UIKit for iOS) |
| **NSApplication** | The singleton object that manages the app's main event loop |
| **NSViewController** | Manages a view hierarchy for your content |
| **NSWindow** | Represents a window on screen |
| **Storyboard** | Visual representation of the app's UI and navigation flow |
| **Asset Catalog** | Organized container for images, colors, and data assets |

---

*Generated on December 26, 2025*
