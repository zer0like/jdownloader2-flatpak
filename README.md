# JDownloader 2 Flatpak Wrapper

This repository provides a Flatpak manifest and a custom launcher script to run **JDownloader 2** seamlessly on modern Linux distributions, specifically targeting **Fedora (Wayland)** environments.

## The Problem (Pains)

Running JDownloader 2 on modern Linux systems (like Fedora 40+) often comes with several headaches:

1.  **Wayland Compatibility:** As a Java Swing/AWT application, JDownloader struggles with native Wayland sessions. It often fails to initialize the GUI or runs in a "headless" mode because it cannot find an X11 display.
2.  **Java Environment Mess:** JDownloader requires a specific Java Runtime Environment (JRE). Managing multiple Java versions on a host system can lead to conflicts and broken dependencies.
3.  **Permissions & Updates:** JDownloader's self-update mechanism often conflicts with system-wide read-only paths (like `/app` in Flatpak or `/usr/bin` in traditional packages).
4.  **Network Issues:** Some network configurations require forcing the IPv4 stack (`-Djava.net.preferIPv4Stack=true`) to avoid connectivity issues.

## The Solution

This Flatpak wrapper addresses these issues by:

*   **XWayland Integration:** Configures Flatpak with the necessary sockets and permissions (`socket=x11`, `device=dri`) to ensure the GUI appears correctly on Wayland sessions.
*   **Bundled Runtime:** Uses the **Freedesktop SDK OpenJDK 17 extension**, providing a consistent and isolated Java environment.
*   **Self-Updating Storage:** Implements a launcher script that copies the `JDownloader.jar` to a writable user data directory (`~/.var/app/.../data`). This allows JDownloader to update itself and maintain configurations without permission errors.
*   **Headless Prevention:** Explicitly disables headless mode (`-Djava.awt.headless=false`) to force the GUI to render.

## How to Build and Install

1.  **Install flatpak-builder:**
    ```bash
    sudo dnf install flatpak-builder
    ```

2.  **Build and Install:**
    ```bash
    flatpak-builder --user --install --force-clean build-dir org.jdownloader.JDownloader.yml
    ```

3.  **Run:**
    ```bash
    flatpak run org.jdownloader.JDownloader
    ```

## Project Structure

*   `org.jdownloader.JDownloader.yml`: The Flatpak manifest.
*   `jdownloader.sh`: A wrapper script that handles the initial setup and launch.
*   `icon.png`: A high-quality custom app icon.
*   `org.jdownloader.JDownloader.desktop`: Desktop entry for application menu integration.
