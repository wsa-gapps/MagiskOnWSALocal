# Magisk on WSA (with Google Apps)

## Support for generating from these systems

- Linux (x86_64 or arm64)

  The following dependencies are required:

  | Distros             |                                                         |            |              |                    |               |              |              |
  |:-------------------:|---------------------------------------------------------|------------|--------------|--------------------|---------------|--------------|--------------|
  | Debian              | `lzip patchelf e2fsprogs python3 aria2 attr unzip sudo` | `whiptail` | `qemu-utils` | `python3-venv`     | `python3-pip` | `p7zip-full` | `jq` |
  | openSUSE Tumbleweed | Same as above                                           | `dialog`   | `qemu-tools` | `python3-venvctrl` | Same as above |              | Same as above |
  | Arch                | Same as Debian                                          | `libnewt`  | `qemu-img`   |  Same as Debian    | `python-pip`  | `p7zip`      | Same as Debian |

  The python3 library `requests` is used.

  Python version ≥ **3.7.2**.

  - Recommended use

    - Ubuntu (You can use [WSL2](https://apps.microsoft.com/store/search?publisher=Canonical%20Group%20Limited))

      Ready to use right out of the box.

<br/>

## Usage     

```shell
cd ~/
sudo git clone https://github.com/WSABuilds/MagiskOnWSALocal.git
cd MagiskOnWSALocal
cd scripts
sudo ./run.sh
```

<br/>

## Options:

- #### ***--arch***
    - ``x64`` - Use for x64 systems
    - ``arm64`` - Use for arm64 systems
-  #### ***--release-type***
    - ``latest`` - Use for x64 systems
    - ``WIF`` - Windows Insider Fast (Fast) Channel
    - ``WIS`` - Windows Insider Slow (Slow) Channel
    - ``RP`` - Retail Preview Channel
    - ``Retail`` - Retail Channel (Microsoft Store)
-  #### ***--magisk-ver***
    - ``stable`` - Stable Magisk Build
    - ``beta`` - Beta Magisk Build
    - ``canary`` - Canary Magisk Build
    - ``debug`` - Debug Magisk Build
    - ``delta`` - [Magisk Delta Build](https://github.com/HuskyDG/magisk-files)
    - ``alpha`` - [Magisk Alpha Build](https://github.com/vvb2060/magisk_files)
-  #### ***--gapps-brand***
    - ``MindTheGapps`` - Includes MindTheGapps Packages which allows you to run Google Play Store and Service on WSA
    - ``none`` - No Google Apps (Google Play Store and Play Services)
-  #### ***--custom-model***
    - ``none``
    - ``sunfish`` - Google Pixel 4a 
    - ``bramble`` - Google Pixel 4a (5G)
    - ``barbet`` - Google Pixel 5a
    - ``redfin`` - Google Pixel 5
    - ``bluejay`` - Google Pixel 6a
    - ``oriole`` - Google Pixel 6
    - ``raven`` - Google Pixel 6 Pro
    - ``lynx`` - Google Pixel 7a
    - ``panther`` - Google Pixel 7
    - ``cheetah`` - Google Pixel 7 Pro
    - ``tangorpro`` - Google Pixel Tablet
-  #### ***--root-sol***
    - ``magisk`` - Root using Magisk
    - ``kernelsu`` - Root using KernelSU
    - ``none`` - No Root
-  #### ***--compress-format***
    - ``7z`` - Compress to a .7z archive
    - ``zip`` - Compress to a .zip archive
-  #### ***--remove-amazon***
    - Removes the Amazon Appstore 
        
<br/>
<br/>

## Credits
- [StoreLib](https://github.com/StoreDev/StoreLib): API for downloading WSA
- [Magisk](https://github.com/topjohnwu/Magisk): The most famous root solution on Android
- [The Open GApps Project](https://opengapps.org): One of the most famous Google Apps packages solution
- [WSA-Kernel-SU](https://github.com/LSPosed/WSA-Kernel-SU) and [kernel-assisted-superuser](https://git.zx2c4.com/kernel-assisted-superuser/): The kernel `su` for debugging Magisk Integration
- [WSAGAScript](https://github.com/ADeltaX/WSAGAScript): The first GApps integration script for WSA
- [erofs-utils](https://github.com/sekaiacg/erofs-utils): Pre-build `erofs-utils` with erofsfuse enabled
- [WSA-Script](https://github.com/YT-Advanced/WSA-Script): Regularly updated MagiskOnWSALocal Script (used in this repo)

_The repository is provided as a utility._

_Android is a trademark of Google LLC. Windows is a trademark of Microsoft Corporation._
