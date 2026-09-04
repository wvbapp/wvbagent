# WVB Agent: AI-Powered Parental Control & Web Security

Welcome to Web Visiting Breaker Agent (WVB Agent), a privacy-first web filtering system for parental control, productivity, and web security.

WVB Agent provides **AI-powered website classification, management services, and multi-client connectivity** for Web Visiting Breaker: WiseWeb, the browser extension that enforces web access policies on users' devices. It supports configurable AI providers, including local AI models, so users can choose where website classification takes place.

The system is designed to operate locally and can be used as a standalone web-filtering solution or together with WVB Agent for AI-powered classification and centralized management.

---

## 1. What is WVB Agent?

WVB Agent is the **intelligence and management backend** for the Web Visiting Breaker system. It runs as a background service on your computer and provides:

* **AI-Powered Website Classification:** Analyze and classify new and unknown websites using configurable AI models, including local models.
* **Management Services:** Provide APIs and services for managing connected WiseWeb browser extensions and their configurations.
* **Multi-Client Management:** Manage multiple WiseWeb extension instances, potentially across different devices, from a centralized management console.
* **Local Data & Privacy:** Store and process management data and browsing information locally. WVB Agent does not send browsing history to the developer or use a third-party cloud service for classification unless you explicitly configure a cloud AI provider.

WVB Agent provides the intelligence and management infrastructure, while **WiseWeb remains responsible for browser-side policy enforcement and the final access decision**.

---

## 2. WVB Agent & WiseWeb: How They Work Together

The system consists of two parts that can be either used independently or used together:

1. **WVB Agent (Backend):** A background service that provides AI classification, management APIs, database services, and connectivity for multiple WiseWeb clients.

2. **Web Visiting Breaker: WiseWeb (Browser Extension):** A browser extension for Chrome and Edge, with Safari support under development, which acts as the **Enforcer**. WiseWeb contains the policy engine and makes the final decision about whether a website should be allowed or blocked.

### Independent Operation

WiseWeb can operate independently without WVB Agent. It can enforce policies using its local website/category database and locally configured rules.

### Using WVB Agent

When connected to WVB Agent, WiseWeb can use additional services such as:

* AI-powered classification of new and unknown websites.
* Centralized policy and configuration management.
* Remote policy updates.
* Activity and browsing insights.
* Management of multiple connected browser instances.

The AI classification service provides information to WiseWeb; **the WiseWeb policy engine remains responsible for the final access decision.**

---

## 3. Connecting WiseWeb to WVB Agent

To connect a WiseWeb extension to a WVB Agent, the extension must first obtain and install a valid **license**.

After the license is installed, the WVB Agent address can be configured in the WiseWeb management interface as the **Approval Server**.

The Approval Server is the WVB Agent endpoint used by WiseWeb to communicate with the Agent for services such as AI-powered website classification and management.

WiseWeb does not require an Approval Server to operate independently.

### Connection Overview

```text
                  WVB Agent
        ┌──────────────────────────┐
        │ AI Classification        │
        │ Management Services      │
        │ Multi-Client Management  │
        │ Management APIs          │
        │ Local Data & Services    │
        └────────────┬─────────────┘
                     │
                Approval Server
                     │
          ┌──────────┼──────────┐
          ↓          ↓          ↓
       WiseWeb    WiseWeb    WiseWeb
       Client 1   Client 2   Client 3
          │          │          │
          └──── Policy Engine ──┘
                     │
               Final Decision
               Allow / Block
```

---

## 4. WVB Console: Your Management Station

The **WVB Console** is the centralized management interface for WVB Agent.

It is available in two forms:

* **Desktop Console:** A native application for macOS and Windows.
* **Web Management Console:** A browser-based interface hosted by the Agent and accessible from devices on your local network, including mobile phones.

The Console allows you to:

* **Monitor Activity:** View enriched browsing history from connected browser instances.
* **Insights:** View graphical reports of browsing habits, including frequently visited categories and websites.
* **Remote Management:** Configure and push policies to connected WiseWeb extensions.
* **Plugin Management:** View active extension instances, including Plugin ID and Alias.
* **Rule Diagnostic Tester:** Test URLs against current or candidate configurations to see how they will be handled.
* **Database Management:** Manage URL categories and age groups.
* **SSL Configuration:** Manage Caddy-powered HTTPS settings.
* **Password Management:** Update administrator credentials.
* **Secure Privacy:** Manage cryptographic keys used for client-side log decryption.

### Security & Infrastructure

* **HTTPS Enforcement:** Bundled Caddy reverse proxy can provide HTTPS for remote connections.
* **Health Monitoring:** The SSL configuration page provides a real-time proxy status indicator.
* **Secure Authentication:** Console sessions are protected using secure cookie attributes such as `HttpOnly` and `SameSite=Strict`.
* **IP-Based Access Control:** HTTP access is restricted to local addresses, while remote access can be protected through HTTPS.

### Administrator Credentials

The initial administrator credentials are:

* **Username:** `wvbadmin`
* **Password:** `wvbadmin123`

For security, change the administrator password after the initial login.

The administrator password is primarily intended to protect policy and management settings from unauthorized changes by other users of the device.

---

## 5. Understanding Scheduling Modes: Focus vs. Browse

The WiseWeb browser extension provides two scheduling modes for managing web access:

* **Focus Mode:** A restrictive allow-list approach. During the scheduled time window, only the URLs and categories explicitly defined by the policy are accessible. Everything else is blocked.

* **Browse Mode:** A schedule-based allow/block approach. Rules define specific time windows during which URLs or categories are allowed or blocked. Outside these windows, the default policies apply.

Temporary rules can be used to modify the behavior of the active mode for specific situations.

---

## 6. Web Management Console & Mobile Support

WVB Agent hosts a built-in web server for management.

The Console can be accessed from the Agent's local URL, for example:

`http://localhost:8051/wvb/console`

When SSL is enabled, remote access can use:

`https://<service-ip>:8443/wvb/console`

### Accessing from Mobile

To manage the system from an iPhone or Android device, access the WVB Console through the computer's local network address.

For example:

`https://192.168.1.10:8443/wvb/console`

Modern mobile browsers require a **Secure Context** for the Web Crypto API used by local log decryption.

* Decryption works through `localhost` on the host computer.
* Decryption requires HTTPS when accessed through an IP address or domain.
* Over plain HTTP on mobile, configuration management and rule testing remain available, but browser-based log decryption is disabled.

---

## 7. Browser Extension Installation

The **WiseWeb browser extension** is the browser-side Enforcer.

### Chrome & Microsoft Edge

The official extension is available through the Chrome Web Store:

**Web Visiting Breaker: WiseWeb**

[Chrome Web Store](https://chromewebstore.google.com/detail/njcdfejenjdfenjhakieaagmeobbdime)

---

## 8. Getting Started: Platform Guides

WVB Agent installers for macOS (`.pkg`) and Windows (`.msi`) are available in Releases.

### Installation Security

Because the WVB Agent installers are currently self-signed, your operating system may display a security warning during installation, such as "Unidentified Developer" or a Windows SmartScreen warning.

Please refer to the platform guides for instructions:

* **macOS:** [README_MACOS.md](./README_MACOS.md)
* **Windows:** [README_WINDOWS.md](./README_WINDOWS.md)

---

## 9. First-Time Installation

After installation, the WiseWeb extension is **enabled by default**, and its default action is **Allow**.

As a result, installing WiseWeb does not prevent normal browsing.

If you need unrestricted internet access while completing your initial configuration:

1. Open the **Management Console**.
2. Set the **Enable** status to **False**.
3. Configure your policies and rules.
4. Re-enable the extension when your configuration is ready.

If you want to use WVB Agent with WiseWeb:

1. Install WVB Agent.
2. Install WiseWeb.
3. Obtain and install a valid WiseWeb license.
4. Configure the WVB Agent address as the **Approval Server** in the WiseWeb management interface.
5. Configure your AI provider if AI classification is desired.
6. Configure your policies.

---

## 10. Hardware Recommendations

Hardware requirements depend on the selected AI provider.

### Local AI with Ollama

Recommended:

* **macOS:** Apple Silicon M4 or newer, 16 GB memory or higher.
* **Windows:** Intel Core i5 or newer, 16 GB memory or higher.

Actual performance depends on the selected model.

### Cloud AI

When using Gemini, OpenAI, or Anthropic, the Agent itself has relatively modest hardware requirements. 8 GB of memory is generally sufficient for the Agent service.

---

## 11. System Dependencies

WVB Agent supports multiple configurable AI providers.

### Browser Analysis Engine

**Google Chrome** is required by the web analysis engine.

### AI Providers

AI classification is optional and configurable:

* **Local AI — Ollama:** Recommended for users who want maximum privacy and local processing.
* **Cloud AI — Gemini, OpenAI, Anthropic:** Available for users who prefer cloud-hosted AI services.

When using a cloud AI provider, website classification information may be sent to that provider according to the provider's API and privacy policies.

---

## 12. Configuring the AI Engine

The WVB Agent AI engine can be configured through the Management Console.

### Default Configuration

* **Provider:** Ollama
* **Model:** `qwen3.5:9b`

### Option A: Local AI — Ollama

1. Install Ollama for your operating system.
2. Pull the recommended model:

```bash
ollama pull qwen3.5:9b
```

3. In the WVB Console, set:

   * Provider: **Ollama**
   * Model: **qwen3.5:9b**

Local AI is recommended when maximum privacy is desired.

### Option B: Cloud AI

WVB Agent can also use cloud AI providers such as Gemini, OpenAI, or Anthropic.

1. Obtain an API key from your selected provider.
2. In the WVB Console:

   * Select the AI provider.
   * Select the desired model.
   * Enter the API key.
3. The API key is encrypted and stored locally in the Agent configuration.

No API key is required when using local Ollama models.

---

## 13. Quick Start Basics

Once WiseWeb is installed and configured, use the WVB Console to manage policies and filtering behavior.

### Default Actions

* **Allow:** Websites are permitted unless specifically blocked by policy.

* **Block:** Websites are blocked unless specifically allowed by policy.

* **Allow & Follow:** Unknown websites are allowed immediately. The URL is sent asynchronously to the WVB Agent configured as the Approval Server for classification. Once classification is available, WiseWeb evaluates the policy again and applies the resulting decision.

This allows website classification to occur without putting AI processing directly in the critical path of page loading.

The **WiseWeb policy engine always makes the final access decision**.

---

## 14. Database Verification

A database file (`urldb-1k.db`) containing 1,000 pre-classified URLs and category definitions is provided with the system.

The database includes a digital signature that can be verified using the included tools and `package_public_key.pem`.

### macOS

```bash
./scripts/verify_macos.sh urldb-1k.db package_public_key.pem
```

### Windows

```powershell
.\winscripts\verify_windows.ps1 -PackageFile urldb-1k.db -PublicKeyFile package_public_key.pem
```

---

## 15. End User License Agreement

By installing or using this software, you agree to be bound by the **End User License Agreement**.

Please read [EULA.txt](./EULA.txt) before proceeding.

### Key Points

* Intended for personal and family use.
* Commercial use is prohibited without a separate license.
* The software is provided "AS IS" without warranty.

---

## Privacy

WVB Agent is designed with a **local-first privacy model**.

Browsing information and management data are processed and stored locally by default. WVB Agent does not transmit your browsing history to the developer.

If you configure a cloud AI provider, information required for website classification may be sent to that provider. The choice of AI provider is controlled by the user.

**Your browsing data remains under your control.**
