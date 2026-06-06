# WVB Agent macOS User Manual

This manual provides information on the installation, file structure, and maintenance of the WVB Agent on macOS.

## 1. Installation

The WVB Agent is distributed as a self-signed macOS Package (`.pkg`).

1.  **Run the Installer:** Double-click `wvb-agent-macos.pkg`.
2.  **Handle Security Warning:** Because the installer is self-signed, macOS may show a warning saying it "cannot be opened because it is from an unidentified developer."
    *   Click **OK** to dismiss the dialog.
    *   Go to **System Settings > Privacy & Security**.
    *   Scroll down to the **Security** section and click the **Open Anyway** button next to the WVB Agent message.
    *   Enter your password when prompted to allow the installation.
3.  **EULA:** You will be presented with the End User License Agreement. Review the terms and click **Agree** to continue.
4.  **Permissions:** The installer requires administrative privileges to install into the `/Applications` folder.
5.  **Completion:** Once finished, you will find **WVB Agent** and **WVB Console** in your **Applications** folder and **Launchpad**.

---

## 2. File Structure

The application is fully self-contained within the native app bundles.

### Application Bundles
Located at: `/Applications/`
*   `WVB Agent.app`: The primary classification Agent and log viewer.
*   `WVB Console.app`: The Management Console.

### User Data (Personal)
Located at: `~/Library/Application Support/WVBAgent/`
*   `config.md`: Your active configuration file.
*   `db/urlcats.db`: Your active classification database.
*   `keys/`: Your unique security public/private keys.
*   `agent.log`: Main application log file.
*   `plugindata/`: Extension communication data.

---

## 3. Launching the Application

### From Launchpad or Applications
Simply click the **WVB Agent** or **WVB Console** icons. The applications launch instantly as native macOS apps with a single, stable dock icon.

### From Command Line
For advanced users, you can launch the Agent directly with custom flags:
```bash
"/Applications/WVB Agent.app/Contents/MacOS/wvb-agent"
```

---

## 4. Verification (Optional)
If a `.sig` file and public key are provided, you can verify the integrity of the installer or database files using the built-in macOS tools (no Python required):

### Verify Installer Package
```bash
# 1. Make the script executable
chmod +x scripts/verify_macos.sh

# 2. Run verification
./scripts/verify_macos.sh wvb-agent-macos.pkg package_public_key.pem
```

Alternatively, developers can use the Python script:
`python3 scripts/sign_build.py verify wvb-agent-macos.pkg --key package_public_key.pem`

## 5. Security Keys

Your security keys are generated automatically on the first launch.
*   **Location:** `~/Library/Application Support/WVBAgent/keys/`
*   **Exported Public Key:** A copy of `wvb_agent_public.key` is exported to your **Documents** folder for easy configuration of management servers.

---

## 6. Log Encryption

The WVB Agent employs a multi-layered encryption system to protect your browsing history:

*   **AES-128 Encryption:** All logs sent from the browser extension to the Agent are encrypted using a unique AES-128 key that rotates daily.
*   **RSA Key Protection:** The daily AES key is encrypted using the Agent's public key before transmission.
*   **Console Re-encryption:** When logs are viewed, the Agent re-encrypts the AES key using the Console's public key.
*   **End-to-End Privacy:** Browsing history can only be decrypted and viewed within the **WVB Console** using your private key (`wvb_console_private.key`). The Console automatically searches for this key in your standard data and installation directories.

---

## 7. Uninstallation

To completely remove the WVB Agent and all associated data, run the following commands in Terminal:

```bash
# 1. Stop any running processes
pkill -f "wvb-agent"

# 2. Remove application bundles
sudo rm -rf "/Applications/WVB Agent.app"
sudo rm -rf "/Applications/WVB Console.app"

# 3. Remove user data and public key
rm -rf ~/Library/Application\ Support/WVBAgent
rm -f ~/Documents/wvb_agent_public.key

# 4. Forget the package receipt
sudo pkgutil --forget com.webvisitingbreaker.agent
```

---

## 8. Troubleshooting

*   **App fails to start:** Ensure you have the latest Chrome browser installed, as it is required for the web analysis tools.
*   **Logs:** For deep diagnostics, check `~/Library/Application Support/WVBAgent/agent.log`.
