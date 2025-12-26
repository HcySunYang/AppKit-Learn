# MyApp - Project Overview

This is a macOS AppKit application created with Xcode using **programmatic UI** (no Storyboard) and Swift. Below is an explanation of how each part works.

---

## 📁 Project Structure

```
MyApp/
├── main.swift                 # Application entry point (bootstraps NSApplication)
├── AppDelegate.swift          # Application lifecycle + window/menu creation
├── ViewController.swift       # Main view controller
└── Assets.xcassets/           # Asset catalog for images and colors
    ├── Contents.json
    ├── AccentColor.colorset/  # App accent color
    └── AppIcon.appiconset/    # App icon in various sizes
```

---

## 🔧 Core Components

### 1. main.swift

The `main.swift` file is the **true entry point** of the application. It manually bootstraps the app since there's no storyboard.

```swift
import Cocoa

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
```

| Line | Purpose |
|------|---------|
| `NSApplication.shared` | Gets the singleton application instance |
| `AppDelegate()` | Creates the app delegate instance |
| `app.delegate = delegate` | Assigns the delegate to handle app lifecycle events |
| `app.run()` | Starts the main event loop (never returns) |

> **Note:** When using a storyboard, the `@main` attribute handles this automatically. Without a storyboard, we need `main.swift` to bootstrap manually.

---

### 2. AppDelegate.swift

The `AppDelegate` is the **lifecycle manager** and **UI creator** of your macOS application.

```swift
class AppDelegate: NSObject, NSApplicationDelegate
```

| Component | Description |
|-----------|-------------|
| `NSObject` | Base class providing Objective-C runtime compatibility |
| `NSApplicationDelegate` | Protocol that defines methods to respond to app lifecycle events |

#### Key Properties:

| Property | Purpose |
|----------|---------|
| `window: NSWindow!` | Reference to the main NSWindow instance created programmatically |

#### Key Methods:

| Method | When Called | Purpose |
|--------|-------------|---------|
| `applicationDidFinishLaunching(_:)` | After the app has launched | Creates the menu bar, window, and view controller programmatically |
| `applicationWillTerminate(_:)` | Just before the app terminates | Clean up resources, save state, close connections |
| `applicationSupportsSecureRestorableState(_:)` | When restoring app state | Returns `true` to enable secure state restoration |
| `applicationShouldTerminateAfterLastWindowClosed(_:)` | When last window closes | Returns `true` to quit app when window is closed |
| `setupMainMenu()` | Called during launch | Creates the entire menu bar programmatically |

#### Programmatic Window Creation:

```swift
window = NSWindow(
    contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
    styleMask: [.titled, .closable, .miniaturizable, .resizable],
    backing: .buffered,
    defer: false
)
window.title = "MyApp"
window.center()
window.contentViewController = ViewController()
window.makeKeyAndOrderFront(nil)
NSApp.activate(ignoringOtherApps: true)
```

| Parameter | Value | Description |
|-----------|-------|-------------|
| `contentRect` | 480×270 | Initial window size |
| `styleMask` | titled, closable, miniaturizable, resizable | Window chrome options |
| `backing` | .buffered | Drawing buffer type |
| `defer` | false | Create window server resources immediately |

#### Programmatic Menu Structure:

| Menu | Items | Keyboard Shortcuts |
|------|-------|-------------------|
| **App Menu** | About, Preferences, Services, Hide, Hide Others, Show All, Quit | ⌘, ⌘H ⌥⌘H ⌘Q |
| **File Menu** | New, Open, Close, Save | ⌘N ⌘O ⌘W ⌘S |
| **Edit Menu** | Undo, Redo, Cut, Copy, Paste, Select All | ⌘Z ⇧⌘Z ⌘X ⌘C ⌘V ⌘A |
| **View Menu** | Enter Full Screen | ⌃⌘F |
| **Window Menu** | Minimize, Zoom, Bring All to Front | ⌘M |
| **Help Menu** | MyApp Help | ⌘? |

---

### 3. ViewController.swift

The `ViewController` manages a **single view** and its content in the window.

```swift
class ViewController: NSViewController
```

#### Key Methods:

| Method | When Called | Purpose |
|--------|-------------|---------|
| `loadView()` | When view needs to be loaded | Creates the root NSView programmatically (required when not using storyboard/nib) |
| `viewDidLoad()` | After the view is loaded into memory | One-time setup: configure UI elements, load data, add subviews |
| `representedObject` | When the represented object changes | Used for binding data to the view; update UI when the model changes |

#### Programmatic View Creation:

```swift
override func loadView() {
    self.view = NSView(frame: NSRect(x: 0, y: 0, width: 480, height: 270))
}
```

> **Important:** When not using a storyboard or nib, you **must** override `loadView()` to create your view hierarchy programmatically. Without this, the app will crash with "view is not set".

#### View Controller Lifecycle:

```
loadView() → viewDidLoad() → viewWillAppear() → viewDidAppear() → viewWillDisappear() → viewDidDisappear()
```

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

## 🔄 How the App Launches (Programmatic UI)

```
┌─────────────────────────────────────────────────────────────────┐
│  1. main.swift executes                                         │
│     └─► NSApplication.shared creates app instance               │
│     └─► AppDelegate() instantiated                              │
│     └─► app.delegate = delegate assigned                        │
│     └─► app.run() starts event loop                             │
│                                                                 │
│  2. applicationDidFinishLaunching(_:) called                    │
│     └─► setupMainMenu() creates menu bar                        │
│     └─► NSWindow created and configured                         │
│     └─► ViewController() instantiated                           │
│     └─► window.contentViewController = viewController           │
│     └─► window.makeKeyAndOrderFront(nil)                        │
│     └─► NSApp.activate(ignoringOtherApps: true)                 │
│                                                                 │
│  3. ViewController loads                                        │
│     └─► loadView() creates NSView                               │
│     └─► viewDidLoad() called for setup                          │
│                                                                 │
│  4. App is ready                                                │
│     └─► Window visible, user can interact                       │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🆚 Storyboard vs Programmatic UI

| Aspect | Storyboard | Programmatic (Current) |
|--------|------------|------------------------|
| **Entry Point** | `@main` on AppDelegate | `main.swift` with manual bootstrap |
| **UI Definition** | XML-based visual editor | Swift code |
| **Menu Bar** | Defined in storyboard | Created in `setupMainMenu()` |
| **Window Creation** | Automatic from storyboard | Manual in `applicationDidFinishLaunching` |
| **View Loading** | Automatic from nib | Override `loadView()` |
| **App Activation** | Automatic | `NSApp.activate(ignoringOtherApps: true)` |
| **Merge Conflicts** | Common with XML | Easier to resolve in code |
| **Reusability** | Harder to share | Easy to modularize |
| **Dynamic UI** | Limited | Full flexibility |

---

## 📚 Key Concepts

| Term | Definition |
|------|------------|
| **AppKit** | Apple's framework for building macOS apps (equivalent to UIKit for iOS) |
| **NSApplication** | The singleton object that manages the app's main event loop |
| **NSApplicationDelegate** | Protocol for responding to app lifecycle events |
| **NSViewController** | Manages a view hierarchy for your content |
| **NSWindow** | Represents a window on screen |
| **NSMenu** | Represents a menu (menu bar or contextual menu) |
| **NSView** | Base class for all visual elements |
| **Asset Catalog** | Organized container for images, colors, and data assets |
| **main.swift** | Entry point file that bootstraps the application manually |

---
