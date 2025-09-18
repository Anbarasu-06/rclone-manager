# Rclone Manager

**Rclone Manager** is a simple and user-friendly batch script tool for managing your Rclone remotes on Windows and Linux (under development). It allows you to `mount`, `reconnect`, and `unmount` drives with optional Web GUI access, providing an interactive menu to simplify repetitive Rclone commands.

Note: This program assumes that all upstream remotes are already configured in Rclone and that any merge mounts are set up. If you are not sure how to do this, please watch the demonstration video on my YouTube channel [Windows](https://www.youtube.com/watch?v=gBg5Tuf1fwY).

## Features
- Mount a remote drive with Rclone and Web GUI.  
- Reconnect a remote easily without manually typing full commands.  
- Unmount a drive gracefully.  
- Interactive menu with guided prompts.  
- Optional display of Rclone logs in the command window.  
- Configurable settings via `settings.conf` file.  
---

## Requirements
### Windows
- [Rclone](https://rclone.org/downloads/) installed and added to your system PATH.
- [Windows File System Proxy](https://winfsp.dev/rel/) to mount a remote to a drive letter using Rclone
- Windows OS.  
- Optional: Web browser to access Rclone Web GUI.  

### Linux (coming soon)
- [Rclone](https://rclone.org/downloads/) installed via package manager or binary.  
- Linux OS (Ubuntu, Debian, Fedora, etc.).  
- Bash shell for running the Linux version of Rclone Manager.  
- Optional: Web browser to access Rclone Web GUI.  

---

## Installation
### Windows
1. Clone the repository or download the ZIP:
```bash
git clone https://github.com/shrestha-bishal/rclone-manager.git
```
2. Ensure rclone.exe is installed and available in your system PATH.
3. Configure settings.conf in the same folder as app.bat.

### Linux (coming soon)
1. Clone the repository or download the ZIP:
```bash
git clone https://github.com/shrestha-bishal/rclone-manager.git
```
2. Ensure rclone is installed and available in your PATH.
3. Configure settings.conf in the same folder as the Linux script (app.sh).

## Configuration (settings.conf)
| Setting          | Description                          | Example          |
| ---------------- | ------------------------------------ | ---------------- |
| `remote`         | The name of your Rclone remote       | `cloud`          |
| `drive`          | The local drive letter to mount to   | `X`              |
| `rc_user`        | Rclone Web GUI username              | `admin`          |
| `rc_pass`        | Rclone Web GUI password              | `secret`         |
| `rc_addr`        | Address and port for Rclone Web GUI  | `localhost:5572` |
| `bwlimit`        | Optional bandwidth limit             | `10M`            |
| `transfers`      | Number of concurrent transfers       | `4`              |
| `vfs_cache_mode` | Rclone VFS cache mode                | `writes`         |
| `dir_cache_time` | Duration to cache directory listings | `72h`            |
| `poll_interval`  | Time between polling for changes     | `15s`            |
| `buffer_size`    | Memory buffer size for transfers     | `64M`            |

## Usage
Run the `app.bat` file and follow the interactive menu:
- **Mount** – Mount your remote drive with Web GUI.  
- **Reconnect** – Reconnect a remote if connection fails.  
- **Unmount** – Safely unmount the drive.  
- **Exit** – Close the application.  

**Example of mounting with logs hidden:**
```
Enter command: mount
Show logs in CMD? (y/N): N
```

**Open your browser to access Web GUI:**
```
http://localhost:5572
```

## Planned Linux Support
A Linux-compatible version of Rclone Manager is in development and will allow similar interactive control via Bash scripts.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for improvements, bug fixes, or feature requests.

## License
This project is licensed under the [MIT License](./LICENSE).

## Author
Bishal Shrestha 
[![GitHub](https://img.shields.io/badge/GitHub-Profile-black?logo=github)](https://github.com/shrestha-bishal)
[![Repo](https://img.shields.io/badge/Repository-GitHub-black?logo=github)](https://github.com/shrestha-bishal/rclone-manager)

© 2025 Bishal Shrestha, All rights reserved

<img width="1061" height="567" alt="image" src="https://github.com/user-attachments/assets/cedf51a2-516c-45e6-b145-97125e1ff4a0" />
