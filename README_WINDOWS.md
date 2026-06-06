# WVB Agent Windows User Manual

This manual provides information on the installation, file structure, and maintenance of the WVB Agent on Windows.

## 1. Installation

The WVB Agent is distributed as a self-signed Windows Installer (`.msi`).

1.  **Run the Installer:** Double-click `wvb-agent-setup.msi`.
2.  **Handle SmartScreen:** Because the installer is self-signed, Windows SmartScreen may display a blue window saying "Windows protected your PC."
    *   Click the **More info** link.
    *   Click the **Run anyway** button that appears.
3.  **EULA:** You will be presented with the End User License Agreement. Review the terms and click **Agree** to continue.
4.  **Permissions:** The installer requires administrative privileges to install into the `Program Files` directory.
5.  **Completion:** Once finished, you will find shortcuts for **WVBAgent** and **WVBConsole** on your Desktop and in the Start Menu.

---

## 2. File Structure

The application separates static system files from dynamic user-specific data.

### Application Files (System-wide)
Located at: `C:\Program Files\WVBAgent\bin\`
*   `wvb-agent\`: Contains the standalone binary and all required libraries (DLLs).
*   `launch_agent.bat`: Command-line launcher for the Agent.
*   `launch_console.bat`: Command-line launcher for the Console.

### User Data (Personal)
Located at: `%LOCALAPPDATA%\WVBAgent\`
*   `config.md`: Your active configuration file.
*   `db\urlcats.db`: Your local classification database.
*   `keys\`: Your unique security public/private keys.
*   `agent.log`: Main application log file.
*   `plugindata\`: Extension communication data.

### Ephemeral Data (Temporary)
Located at: `%TEMP%\WVBAgent\`
*   Chrome profiles and temporary session data used during web analysis.

---

## 3. Launching the Application

### From Start Menu or Desktop
Click the **WVBAgent** or **WVBConsole** shortcuts. Both applications launch as native Windows programs with their own graphical interfaces.

### From Command Line
You can launch the agent with custom flags using the batch files in the installation directory:
```cmd
cd "C:\Program Files\WVBAgent\bin"
launch_agent.bat
```

---

## 4. Verification (Optional)
If a `.sig` file and public key are provided, you can verify the integrity of the installer or database files using native PowerShell (no Python required):

### Verify Installer Package
```powershell
.\winscripts\verify_windows.ps1 -PackageFile wvb-agent-setup.msi -PublicKeyFile package_public_key.pem
```

Alternatively, developers can use the Python script:
`python3 scripts/sign_build.py verify wvb-agent-setup.msi --key package_public_key.pem`

## 5. Security Keys

Your security keys are generated automatically on the first launch.
*   **Location:** `%LOCALAPPDATA%\WVBAgent\keys\`
*   **Public Key:** A copy of `wvb_agent_public.key` is exported to your **Documents** folder for easy configuration of management servers.

---

## 6. Log Encryption

The WVB Agent employs a multi-layered encryption system to protect your browsing history:

*   **AES-128 Encryption:** All logs sent from the browser extension to the Agent are encrypted using a unique AES-128 key that rotates daily.
*   **RSA Key Protection:** The daily AES key is encrypted using the Agent's public key before transmission.
*   **Console Re-encryption:** When logs are viewed, the Agent re-encrypts the AES key using the Console's public key.
*   **End-to-End Privacy:** Browsing history can only be decrypted and viewed within the **WVB Console** using your private key (`wvb_console_private.key`). The Console automatically searches for this key in your standard data and installation directories.

---

## 7. Uninstallation

To remove the WVB Agent from your system:

1.  **Standard Uninstall:**
    *   Go to **Settings > Apps > Apps & Features**.
    *   Search for **WVBAgent**.
    *   Select **Uninstall**.

2.  **Remove User Data (Optional):**
    The uninstaller removes the application files but leaves your configuration and database for future use. To completely wipe all data:
    *   Delete the folder: `%LOCALAPPDATA%\WVBAgent`
    *   Remove the public key from your `Documents` folder.

---

## 8. Troubleshooting

*   **App fails to start:** Ensure you have the latest Chrome browser installed, as it is required for the web analysis tools.
*   **Blank Log Window:** Check that port `8051` is not being blocked by a local firewall, as the Agent uses this port for its internal API.
*   **Logs:** For deep diagnostics, check `%LOCALAPPDATA%\WVBAgent\agent.log`.
