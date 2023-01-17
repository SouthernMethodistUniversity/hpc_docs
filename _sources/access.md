# Access SMU HPC Systems

## HPC OnDemand Web Portal

ManeFrame II can be accessed directly from a browser via the HPC OnDemand Web
Portal.

## Terminal Access via SSH

Secure shell access via SSH is available for SMU HPC systems. There are many
SSH clients available for different operating systems.

````{tab-set}
```{tab-item} OpenSSH
The following instructions are for standard OpenSSH installations such as
those found in Linux, macOS, and Windows (>=10) including WSL.

1. Open a terminal
2. Type `ssh <your_username>@<m2|superpod>.smu.edu` where `<your_username>` is
   your username, which is usually the first part of your SMU email address,
   and `<m2|superpod>` is either `m2` or `superpod`.
3. Type a Duo **passcode** or `1` for a Duo push. The passcode can
   come from the Duo app or from an OIT procured hardware token (faculty and
   staff only).
```
```{tab-item} PuTTY
PuTTY requires the one-time installation of this SSH client and X11.

1.  [PuTTY](http://www.putty.org/) is the most popular (and free) SSH
    client available. Download and install the newest version.
2.  In order to view graphics from ManeFrame, you will also need to
    install an X-server. The most popular, again free,
    X11 implementation on Windows is Xming. To install Xming, download
    and install the newest versions of both the [Xming X
    server](http://sourceforge.net/projects/xming) and the [Xming
    Fonts](http://sourceforge.net/projects/xming/files/Xming-fonts).

Once these two programs are installed, you can then log into SMU HPC systems:

1.  Start the Xming program in the Start Menu. The Xming program runs
    from the System Tray.
2.  Start the PuTTY program in the Start Menu.
3.  In the PuTTY window:
    1.  In the "Category" box:
        1.  Scroll to the bottom and select "+" next to "SSH".
        2.  Select "X11".
    2.  In the "X11 forwarding" section, select "Enable X11 forwarding".
    3.  In the "Category" box, scroll to the top and select "Session".
    4.  In the "Host Name" field, type "<m2|superpod>.smu.edu" where
        `<m2|superpod>` is either `m2` or `superpod`.
    5.  In the "Saved Sessions" field, type "ManeFrame II (M2)" or
        "SuperPOD (MP)", respectively.
    6.  Press "Save".
    7.  Press "Open". Select "Yes" if you presented with a "PuTTY
        Security Alert" window.
    8.  At the command prompt, type your username, which is the first
        part of your SMU email address, followed by *enter*.
    9.  At the command prompt, type your SMU password followed by
        *enter*.
```
````

### Graphical Applications via X11-Forwarding

````{tab-set}
```{tab-item} Linux
No additional softare needed. Add the `-X` flag, *e.g.* `ssh -X ...` when
logging in.
```
```{tab-item} macOS
macOS requires the one-time installation of
[XQuartz](https://www.xquartz.org) to provide X11 for graphical
applications.

1.  Install [XQuartz](https://www.xquartz.org)
2.  Log out and back into the Mac or reboot
3.  Open the Terminal app at `/Applications/Utilities/Terminal.app`
4.  Run the command
    `defaults write org.macosforge.xquartz.X11 enable_iglx -bool true`
    to enable [indirect GLX](https://en.wikipedia.org/wiki/AIGLX), which
    is disabled by default
```
```{tab-item} Windows
Windows SSH via OpenSSH or PuTTY, requires Xming. To install Xming, download
and install the newest versions of both the [Xming X
server](http://sourceforge.net/projects/xming) and the [Xming
Fonts](http://sourceforge.net/projects/xming/files/Xming-fonts).
```
````

#### Setting Up Key-Based Authentication

SSH keys to be used for SSH and SFTP clients, which allows for
password-less access, but still requires Duo authentication.

The SSH steps are generally as follows:

1.  Open the Terminal app at \"/Applications/Utilities/Terminal.app\"
2.  Type `ssh -CX <your_username>@m2.smu.edu` where `<your_username>` is
    your username, which is the first part of your SMU email address.

#### Setting Up Key-Based Authentication

SSH keys to be used for SSH and SFTP clients, which allows for
password-less access, but still requires Duo authentication.

#### Setting Up Key-Based Authentication

## Accessing Files via SFTP

ManeFrame II has two separate file systems. The first, the \"home\" file
system, contains user\'s home directories (\"\~/\", \"/users/\$USER\",
\"\$HOME\") and is what is seen when first logging into the system. The
second, the \"scratch\" file system, is ManeFrame II\'s high performance
parallel file system (\"/scratch/users/\$USER\" or \"\$SCRATCH\"). The
scratch file system is significantly larger and faster than the \"home\"
file system and should be the file system used when running
calculations. Files needed for running calculations or building software
must be copied from your local computer to ManeFrame II. This is
generally done using an SFTP client or the \"scp\" command where
available.

### SFTP Clients

There are several popular SFTP clients available and any file transfer
client that supports SFTP will work with ManeFrame II. Several popular
SFTP clients include [WinSCP](https://winscp.net/) (Windows)
and [CyberDuck](https://cyberduck.io) (Windows, macOS). These clients
generally display two panes with the left side being your local files
and the right side being your ManeFrame II files. When setting up access
in these clients, SFTP must be chosen and your credentials will be your
ManeFrame II credentials.

Users using SFTP clients such as Transmit and Cyberduck on macOS or
Cyberduck and WinSCP on Windows will be prompted by the application for
their password, if not saved, followed by a request for a Duo
**passcode** or `1` for a Duo push. The passcode can come from the Duo
app or from an OIT procured hardware token (faculty and staff only).

## Reducing the Number of Duo Authentications

An initial SSH/SFTP connection to M2 can be reused for subsequent
connections, which allows for multiple connections without being
prompted by Duo repeatedly.

### SSH

For those using OpenSSH (macOS, Linux, and Windows WSL), add the
following to your *local computer\'s* SSH `~/.ssh/config` file:

    Host *
      ControlMaster auto
      ControlPath ~/.ssh/sockets/ssh_mux_%h_%p_%r
      ControlPersist 600

Then make the sockets directory via `mkdir -p ~/.ssh/sockets`.

### PuTTY

For those using PuTTY on Windows, check the box \"Share SSH connection
if possible\" under \"Category\"; \"Connection\"; \"SSH\"; \"Sharing an
SSH connection between PuTTY tools.

### Cyberduck

Cyberduck does not use SSH configurations, therefore the following
setting can be used to enable connection persistence. Within Cyberduck:

1.  Select Edit, Preferences, Transfers, and then General.
2.  Under \"Transfers\", use the \"Transfer Files\" drop-down to select
    \"Use browser connection\".
