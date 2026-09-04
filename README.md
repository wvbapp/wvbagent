# WVB Agent: AI-Powered Parental Control & Web Security

Welcome to Web Visiting Breaker Agent (**WVB Agent**), a modern, privacy-first web filtering and parental control system. Unlike traditional filters that rely on static, outdated lists, WVB Agent uses a local **Artificial Intelligence (AI)** engine to understand and classify websites in real-time.

## 1. What is the WVB Agent?

The WVB Agent is a "Smart Brain" and back-end service that runs on your computer. Its primary purpose is to:
*   **Analyze Content:** Automatically classify unknown or new websites using local AI models.
*   **Power Policy Management:** Provide the secure APIs and database services that enable the **Browser Extension** and **WVB Console** to manage and enforce security settings, block lists, and schedules.
*   **Protect Privacy:** All analysis and logging happen locally on your machine. Your data is not sold or sent to a cloud-based classification service.

## 2. Agent & Browser Extension: How They Work Together

The system consists of two parts that can be either used independently or used together:
1.  **The Web Visiting Breaker (WVB) Agent (Backend):** A background service that performs AI analysis, manages the local database, and provides the management APIs.
2. **The "Web Visiting Breaker: WiseWeb" Extension (Frontend):** A browser plugin for Chrome, Edge, or Safari that acts as the "Enforcer." It checks every website you visit against the local database and applies your chosen security rules instantly.


## 3. WVB Console: Your Management Station

The **WVB Console** is the centralized management hub for the system. It is available in two forms:
*   **Desktop Console:** A native application for macOS and Windows.
*   **Web Management Console:** A modern, browser-based interface hosted by the Agent, accessible from any device on your local network (including mobile phones).

### Security & Infrastructure (August 2026 Updates)
*   **HTTPS Enforcement**: Bundled Caddy reverse proxy forces HTTPS for all remote connections.
*   **Health Monitoring**: The SSL configuration page now includes a real-time **Proxy Status** indicator (green for running, grey for stopped).
*   **Secure Authentication**:
    *   **Credentials**: Default `wvbadmin` / `password: wvbadmin123`.
    *   **Sessions**: Protected via `HttpOnly`, `SameSite=Strict` cookies.
*   **IP-Based Access Control**: HTTP access restricted to 127.0.0.1 or localhost; any remote access attempt is forced through HTTPS.

The Console allows you to:
*   **Monitor Activity:** View enriched browsing history from all your connected browser instances in one place.
*   **Insights:** View graphical reports of browsing habits, including top visited categories and websites.
*   **Remote Management:** Configure and "push" security policies to your browser extensions remotely.
*   **Plugin Management**: View active extension instances (filtered by last 30 days) with both **Plugin ID and Alias** for easier identification.
*   **Rule Diagnostic Tester:** Test URLs against your current or "candidate" (unsaved) configurations to see exactly how they will be handled.
*   **Database Management:** Manually update URL categories and age groups.
*   **SSL Configuration:** Manage the Caddy-powered HTTPS settings.
*   **Password Management:** Update console credentials directly.
*   **Secure Privacy:** Manage the cryptographic keys required for client-side log decryption, ensuring only you can read the browsing data.

## 4. Understanding Scheduling Modes: Focus vs. Browse

The WVB browser extension offers two distinct scheduling modes to manage your browsing:

*   **Focus Mode:** A restrictive "Allow-list" approach. During the scheduled time window, <b>only</b> the URLs and categories you explicitly define are accessible. Everything else is blocked. Temporary rules in this mode act as "disablers" to temporarily turn off the focus restriction.
*   **Browse Mode:** A schedule-based "Allow/Block" approach. Rules define specific time windows during which specific URLs or categories are allowed. Outside these windows, default policies apply. Temporary rules in this mode act as "blockers" to deny access during specified times.

---
## 5. Web Management Console & Mobile Support

The Agent hosts a built-in web server for management. You can access it by opening the Agent's URL (e.g., `http://localhost:8051/wvb/console` or https://<service ip>:8443/wvb/console when SSL is enabled) in your browser.

### Accessing from Mobile (iPhone/Android)
To manage your system from a mobile phone, visit the IP address of your computer on your local network (e.g., `https://192.168.1.10:8443/wvb/console`).

**Important Security Note for Mobile Decryption:**
Modern mobile browsers require a **Secure Context** to enable the Web Crypto API used for local log decryption. 
*   **Decryption will work** if accessed via `localhost` (on the host computer).
*   **Decryption requires HTTPS** if accessed via an IP address or domain on mobile. 
*   If accessed over plain HTTP on mobile, you can still manage configurations and run rule tests, but log decryption will be disabled by the browser for security.

## 5. Browser Extension Installation

The extension is the "Enforcer" that must be installed in your browser. 

### Chrome & Microsoft Edge
The official extension is available on the Chrome Web Store:
**[Download for Chrome & Edge](https://chromewebstore.google.com/detail/njcdfejenjdfenjhakieaagmeobbdime?utm_source=item-share-cb)**

### Safari
Safari users can load the extension from the `safari/` folder in this repository. Please refer to the [macOS Platform Guide](./README_MACOS.md) for detailed instructions on enabling unsigned extensions in Safari.

## 5. Getting Started: Platform Guides

The software package for macOS (.pkg) and Windows (.msi) can be found in the Releases.
**Note on Installation Security:** Because the WVB Agent installers (`.pkg` and `.msi`) are self-signed, your operating system may display a security warning (e.g., "Unidentified Developer" or "SmartScreen") during installation. Please refer to the platform guides below for instructions on how to allow the installation as an exception.

*   **macOS Users:** [README_MACOS.md](./README_MACOS.md)
*   **Windows Users:** [README_WINDOWS.md](./README_WINDOWS.md)

## 6. First-Time Installation Note

Upon installation, the plugin is **enabled by default** and the default action is configured to **Allow**. As a result, websites are allowed by default after initial installation.

If you need internet access to finish your initial setup and policy configurations:
1. Open the **Management Console**.
2. Set the "Enable" status to **False** (Off).
3. Configure your rules (Allow/Deny lists, Categories, etc.).
4. Re-enable the plugin once your configuration is complete.

## 7. Hardware Recommendations

To ensure smooth performance of the AI classification engine, we recommend the following:

*   **If using Local AI (Ollama):**
    *   **macOS:** Apple Silicon M4 (or newer), 16GB Memory (or higher).
    *   **Windows:** Intel Core i5 (or newer), 16GB Memory (or higher).
*   **If using Cloud AI (Gemini, OpenAI, Anthropic):**
    *   Minimal hardware requirements (8GB Memory is sufficient for the Agent service itself).

## 8. System Dependencies

To provide AI classification, WVB Agent supports several AI model providers.

1.  **Google Chrome:** Required by the tools of the web analysis engine.
2.  **AI Models (Optional/Configurable):**
    *   **Local (Ollama):** Recommended for maximum privacy. Requires [Ollama](https://ollama.com/) to be installed and sufficient hardware to run models locally.
    *   **Cloud (Gemini, OpenAI, Anthropic):** Supported for users who prefer cloud-hosted AI APIs. Does not require Ollama or high-end local hardware.


## 9. Configuring the AI Engine

The WVB Agent can be configured via the Management Console to use different AI model providers.

**Default Configuration:**
*   **Provider:** Ollama
*   **Model:** `qwen3.5:9b`

### Option A: Local AI (Ollama - Recommended for Privacy)
1.  **Download Ollama:** Visit [ollama.com](https://ollama.com/) and download the installer for your OS.
2.  **Pull the Model:** Open your terminal and run:
    ```bash
    ollama pull qwen3.5:9b
    ```
3.  **Console Config:** Set Provider to **Ollama** and Model to **qwen3.5:9b** in the console.

### Option B: Cloud AI (Gemini, OpenAI, Anthropic)
1.  **Obtain API Key:** Get an API key from your chosen provider (Google, OpenAI, or Anthropic).
2.  **Console Config:**
    *   Set Provider to your chosen cloud AI.
    *   Set Model to the desired model (e.g., `gemini-3.1-flash-lite` [default for Gemini], `gpt-4o-mini`, etc.).
    *   Enter your API Key in the "API Key" field in the console.
    *   *Note:* The API Key is securely encrypted and stored locally in your configuration file. No API Key is needed for local Ollama usage.


## 10. End User License Agreement (EULA)

By installing or using this software, you agree to be bound by the **End User License Agreement**. 
Please read [EULA.txt](./EULA.txt) carefully before proceeding. 

**Key Points:**
*   Intended for personal and family use only.
*   Commercial use is strictly prohibited without a separate license.
*   The software is provided "AS IS" without warranty.

## 11. Quick Start Basics
...
4.  **Manage:** Use the **WVB Console** to view logs, adjust your filtering categories, and set your **Default Action**:
    *   **Allow**: All websites are permitted unless specifically blocked.
    *   **Block**: All websites are denied unless specifically allowed.
    *   **Allow & Follow**: Unknown websites are permitted, and they will be automatically sent to the WVB agent (Approval Server) for classification. Once classified, the site will be governed by your category rules.
...
## 12. Database Verification (Security)

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
