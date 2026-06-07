# WVB Agent: AI-Powered Parental Control & Web Security

Welcome to Web Visiting Breaker Agent (**WVB Agent**), a modern, privacy-first web filtering and parental control system. Unlike traditional filters that rely on static, outdated lists, WVB Agent uses a local **Artificial Intelligence (AI)** engine to understand and classify websites in real-time.

## 1. What is the WVB Agent?

The WVB Agent is a "Smart Brain" and back-end service that runs on your computer. Its primary purpose is to:
*   **Analyze Content:** Automatically classify unknown or new websites using local AI models.
*   **Power Policy Management:** Provide the secure APIs and database services that enable the **Browser Extension** and **WVB Console** to manage and enforce security settings, block lists, and schedules.
*   **Protect Privacy:** All analysis and logging happen locally on your machine. Your data is not sold or sent to a cloud-based classification service.

## 2. Agent & Browser Extension: How They Work Together

The system consists of two parts that MUST be used together:
1.  **The Agent (Backend):** A background service that performs AI analysis, manages the local database, and provides a management API.
2.  **The "Web Visiting Breaker" Extension (Frontend):** A browser plugin for Chrome or Edge that acts as the "Enforcer." It checks every website you visit against the Agent's database and applies your chosen security rules instantly.

## 3. WVB Console: Your Command Center

The **WVB Console** is a desktop application included with the Agent that serves as your centralized management station. It allows you to:
*   **Monitor Activity:** View enriched browsing history from all your connected browser instances in one place.
*   **Insights:** View graphical reports of browsing habits, including top visited categories and websites.
*   **Deploy Policies:** Create and "push" security configurations (by saving a modified configuration) to your devices instantly.
*   **Rule Diagnostics:** Use the built-in Rule Tester to see how the rules are applied to a specific URL.
*   **Update URL Category:** Update a specific URL's category and age group information in the URL database.
*   **Secure Orchestration:** Manage the cryptographic keys that ensure all communication between your devices is authentic and secure.

## 4. Getting Started: Platform Guides

The software package for macOS (.pkg) and Windows (.msi) can be found in the Releases.
**Note on Installation Security:** Because the WVB Agent installers (`.pkg` and `.msi`) are self-signed, your operating system may display a security warning (e.g., "Unidentified Developer" or "SmartScreen") during installation. Please refer to the platform guides below for instructions on how to allow the installation as an exception.

*   **macOS Users:** [README_MACOS.md](./README_MACOS.md)
*   **Windows Users:** [README_WINDOWS.md](./README_WINDOWS.md)

## 5. First-Time Installation Note

**Important:** Upon installation, the plugin is **enabled by default** and configured to **block unknown websites**. As a result, you may notice that all currently open browser pages are blocked immediately after installation.

If you need internet access to finish your initial setup and policy configurations:
1. Open the **Management Console**.
2. Set the "Enable" status to **False** (Off).
3. Configure your rules (Allow/Deny lists, Categories, etc.).
4. Re-enable the plugin once your configuration is complete.

## 6. Hardware Recommendations

To ensure smooth performance of the local AI classification engine, we recommend the following hardware or better:

*   **macOS:** Apple Silicon M4 (or newer), 16GB Memory (or higher), macOS 16 (or newer).
*   **Windows:** Intel Core i5 (or newer), 16GB Memory (or higher), Windows 11 (or newer).

## 7. System Dependencies

To provide AI classification, WVB Agent requires the following software:

1.  **Google Chrome:** Required by the tools of the web analysis engine.
2.  **Ollama:** A local server for running AI models.
3.  **AI Model (Qwen 3.5 9B):** The specialized model used for content classification.

## 8. Installing AI Components (Ollama & Qwen)

The Agent requires **Ollama** to be installed and the **Qwen** model to be downloaded.

### Step 1: Install Ollama
*   **Download:** Visit [ollama.com](https://ollama.com/) and download the installer for your OS.
*   **Install:** Run the installer and ensure Ollama is running (you should see the icon in your system tray/menu bar).

### Step 2: Download the AI Model
Open your Terminal (macOS) or Command Prompt (Windows) and run the following command:
```bash
ollama pull qwen3.5:9b
```
*Note: This model is approximately 5-6 GB. Ensure you have a stable internet connection.*

## 9. End User License Agreement (EULA)

By installing or using this software, you agree to be bound by the **End User License Agreement**. 
Please read [EULA.txt](./EULA.txt) carefully before proceeding. 

**Key Points:**
*   Intended for personal and family use only.
*   Commercial use is strictly prohibited without a separate license.
*   The software is provided "AS IS" without warranty.

## 10. Quick Start Basics
...
4.  **Manage:** Use the **WVB Console** to view logs and adjust your filtering categories.

## 11. Database Verification (Security)

A database file (`urldb-1k.db`) containing data for 1,000 pre-classified URLs and category definitions is provided. To ensure the integrity and authenticity of this database, you can verify its digital signature using the included tools and the **package_public_key.pem**.

**macOS Example:**
```bash
./scripts/verify_macos.sh urldb-1k.db package_public_key.pem
```

**Windows Example:**
```powershell
.\winscripts\verify_windows.ps1 -PackageFile urldb-1k.db -PublicKeyFile package_public_key.pem
```

---
**Privacy Notice:** WVB Agent is designed for local operation. It does not transmit your browsing history to the developer or any third party.
