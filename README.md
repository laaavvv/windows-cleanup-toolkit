<h1 align="center"><code>windows-cleanup-toolkit</code></h1>

<p align="center">
  A collection of scripts to clean, optimize and debloat Windows 10/11 systems.
  Built from real IT support experience.
</p>

---

<div align="center">

<img src="https://img.shields.io/badge/Windows_10-000000?style=for-the-badge&logo=windows10&logoColor=white"/>
<img src="https://img.shields.io/badge/Windows_11-000000?style=for-the-badge&logo=windows11&logoColor=white"/>
<img src="https://img.shields.io/badge/PowerShell-000000?style=for-the-badge&logo=windowsterminal&logoColor=white"/>
<img src="https://img.shields.io/badge/Batch-000000?style=for-the-badge&logo=windowsterminal&logoColor=white"/>

</div>

---

## 📁 Files

| File | Description |
|------|-------------|
| `_Clean_Temp_Files.bat` | Cleans Windows Temp, AppData Temp, Update cache and Recycle Bin |
| `Limpeza.bat` | Deep clean — browser caches (Edge, Chrome, Firefox, Brave, Vivaldi) + system logs |
| `_Clear_EventLogs.ps1` | Clears all Windows Event Viewer logs |
| `_PrivacySexy_Cleanup.bat` | Privacy-focused cleanup — removes tracking data, shadow copies, credentials and more |
| `_remove_registry_shit.reg` | Registry cleaner — removes junk entries |
| `shortcuts/` | Quick-access shortcuts to common temp folders |

---

## ⚠️ Requirements

- **Run as Administrator** — most scripts require elevated privileges
- Windows 10 / 11
- PowerShell execution policy: `Unrestricted` (for `.ps1` scripts)

To allow `.ps1` execution, run this once in PowerShell as admin:
```powershell
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

---

## 🚀 Usage

**1. Temp file cleanup (fast):**
```
Right click _Clean_Temp_Files.bat → Run as administrator
```

**2. Deep browser + system cleanup:**
```
Right click Limpeza.bat → Run as administrator
```

**3. Clear Event Logs:**
```powershell
# Run in PowerShell as admin
.\Clear_EventLogs.ps1
```

**4. Privacy cleanup:**
```
Right click _PrivacySexy_Cleanup.bat → Run as administrator
```

---

## 📌 Notes

- `Limpeza.bat` will kill browser processes before cleaning — save your work first
- `_PrivacySexy_Cleanup.bat` removes shadow copies — this cannot be undone
- The `.reg` file modifies the Windows Registry — create a restore point before running

---

<p align="center">
  <img src="https://komarev.com/ghpvc/?username=laaavvv&color=58a6ff&style=flat-square&label=Profile+Views"/>
</p>
