<div align="center">

# Windows Cleanup Toolkit

**A lightweight, all-in-one Windows cleanup utility built in Batch.**  
No installs. No third-party tools. Just run and clean.

[![Author](https://img.shields.io/badge/author-laaavvv-blue?style=flat-square)](https://github.com/laaavvv)
[![Platform](https://img.shields.io/badge/platform-Windows-0078D6?style=flat-square&logo=windows)](https://github.com/laaavvv/windows-cleanup)
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)

<p>
  <img src="https://img.shields.io/badge/Batch-000000?style=for-the-badge&logo=windowsterminal&logoColor=white"/>
  <img src="https://img.shields.io/badge/PowerShell-000000?style=for-the-badge&logo=windowsterminal&logoColor=white"/>
  <img src="https://img.shields.io/badge/Registry-000000?style=for-the-badge&logo=windows&logoColor=white"/>
</p>

</div>

---

## 📋 Overview

**Windows Cleanup Toolkit** is a single `.bat` script that lets you clean your Windows system quickly through an interactive menu. It combines temporary file removal, browser cache cleanup, remove registry trash files, Windows Event Log clearing, and the built-in Disk Cleanup tool — all in one place.

> ⚠️ **Must be run as Administrator.** The script checks for elevated privileges automatically and will exit if they are not granted.

---

## 🚀 Features

| Option | Name | Description |
|--------|------|-------------|
| `[1]` | **Temp File Cleanup** | Removes temp folders, system/user caches, Windows Update leftovers, log files, and browser caches (Edge, Chrome, Firefox, Brave, Vivaldi). Also empties the Recycle Bin. |
| `[2]` | **Registry, Event Logs & Disk Cleanup** | Remove unnecessary registry, clears all Windows Event Logs using PowerShell, and launches the native `cleanmgr.exe` Disk Cleanup tool. |
| `[3]` | **Full Cleanup** | Runs Option 1 + Option 2 in sequence — the complete cleanup experience. |
| `[0]` | **Exit** | Exits the toolkit. |

---

## 🖥️ Preview

```
  ====================================================
    Windows Cleanup Toolkit  |  by laaavvv
    github.com/laaavvv
  ====================================================

    [1]  Temp File Cleanup
         Removes temporary files, browser cache, logs and junk from the system.

    [2]  Registry, Event Logs & Disk Cleanup
         Remove registry trash, clears Windows Event Logs and launches
         the built-in Disk Cleanup tool (cleanmgr)

    [3]  Full Cleanup  (Option 1 + Option 2)
         Runs both cleanups in sequence.

    [0]  Exit

  ====================================================
  Select an option [0-3]:
```

---

## 📦 What Gets Cleaned

### Option 1 — Temp File Cleanup
- `C:\Windows\SystemTemp`
- `C:\Users\%USERNAME%\AppData\Local\Temp`
- `C:\Windows\Temp`
- Windows CBS, MoSetup, Panther, inf, SoftwareDistribution and .NET log files
- Windows Update download cache (`SoftwareDistribution\Download`)
- Internet Explorer / INetCache
- Browser caches for: **Edge**, **Chrome**, **Firefox**, **Brave**, **Vivaldi**
  - Covers: Cache, Service Worker (Database, CacheStorage, ScriptCache), GPUCache, ShaderCache, Storage/ext
  - Supports Default profile + Profile 1 + Profile 2
- 🗑️ Recycle Bin

### Option 2 — Registry, Event Logs & Disk Cleanup
- Remove trash files from registry via `.reg` injection
- Clears **all Windows Event Logs** via PowerShell
- Launches `cleanmgr.exe` (Windows built-in Disk Cleanup)

### Option 3 — Full Cleanup
Everything from Option 1 + Option 2 in a single run.

---

## ⚙️ How to Use

1. **Download** `windows-cleanup-toolkit.bat` from this repository.
2. **Right-click** the file and select **"Run as administrator"**.
3. **Select** one of the menu options (`1`, `2`, or `3`).
4. After the cleanup finishes, choose to **return to the menu** or **exit**.

> 💡 Tip: Use Option 3 for a full deep-clean session. Use Option 1 periodically for light maintenance.

---

## ⚠️ Disclaimer

This script makes **irreversible deletions** to temporary files, caches, and logs. It does **not** touch personal files, documents, or installed applications. Use it at your own discretion.

- Tested on **Windows 10** and **Windows 11**
- Some paths may not exist on your system — all errors are suppressed silently (`>NUL 2>&1`)
- Browsers must be **closed** before running for full cache deletion to take effect

---

## 📁 Repository Structure

```
windows-cleanup/
├── windows-cleanup-toolkit.bat   # Main script (all-in-one)
├── README.md                     # Documentation
└── LICENSE                       # MIT License
```

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).  
Free to use, modify, and distribute.

</div>
