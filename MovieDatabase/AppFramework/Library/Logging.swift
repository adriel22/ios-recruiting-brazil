import os.log

private class ClassForBundle {}
let generalLog = OSLog(subsystem: Bundle(for: ClassForBundle.self).bundleIdentifier ?? "com.alephao.AppFramework", category: "AppFramework")
