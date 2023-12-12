# Access

SMU HPC systems are directly accessible on campus via Ethernet, excluding
dorms, and PerunaNet. All other networks require using the SMU VPN.
Instructions for setting up and using the VPN can be found
[here](https://www.smu.edu/OIT/Services/VPN).

## HPC OnDemand Web Portal

SMU HPC clusters can be accessed directly from a browser via the HPC OnDemand
Web Portal, which provides access to files, remote desktops, JupyterLab, and
RStudio.

## Terminal Access via SSH

Secure shell access via SSH is available for SMU HPC systems. There are many
SSH clients available for different operating systems.

````{tab-set}
```{tab-item} OpenSSH
The following instructions are for standard OpenSSH installations such as
those found in Linux, macOS, and Windows (>=10) including WSL.

1. Open a terminal
2. Type `ssh <your_username>@<m3|superpod>.smu.edu` where `<your_username>` is
   your username, which is usually the first part of your SMU email address,
   and `<m3|superpod>` is either `m3` or `superpod`.
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
    4.  In the "Host Name" field, type "<m3|superpod>.smu.edu" where
        `<m3|superpod>` is either `m3` or `superpod`.
    5.  In the "Saved Sessions" field, type "M3" or
        "SuperPOD", respectively.
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

After XQuartz is installed add the `-X` flag, *e.g.* `ssh -X ...` when
logging in.

```
```{tab-item} Windows
Windows SSH via OpenSSH or PuTTY, requires Xming. To install Xming, download
and install the newest versions of both the [Xming X
server](http://sourceforge.net/projects/xming) and the [Xming
Fonts](http://sourceforge.net/projects/xming/files/Xming-fonts).
```
````

### Setting Up Key-Based Authentication

Key-based authentication can be used to log into SMU HPC clusters without
needing to input a password, but you still will need to go through Duo.

```{warning}
The commands given below are to be run from **your** computer and not on the
clusters themselves.
```

````{tab-set}
```{tab-item} Linux
Run the following commands from a terminal on the **local computer** that
you want to have key-based access to SMU HPC resources:

1. `u=<your SMU HPC username>` `<your SMU HPC username>` is set to
   your SMU HPC username to be used for the subsequent commands.
2. `c=<SMU HPC cluster>`, where `<SMU HPC cluster>` is either `m3` or `superpod` 
2. `ssh-keygen -q -t ecdsa -f ~/.ssh/id_ecdsa_${c}` You will need to
   press *enter* twice.
3. `cat ~/.ssh/id_ecdsa_${c}.pub | ssh ${u}@${c}.smu.edu "mkdir -p ~/.ssh && chmod 0700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 0700 ~/.ssh/authorized_keys && cat >> ~/.ssh/authorized_keys && chmod 0400 ~/.ssh/authorized_keys"`
   Press *enter* and you will be prompted for your SMU password.
4. `printf "Host *${c}.smu.edu\n   User %s\n   IdentityFile ~/.ssh/id_ecdsa_${c}\n" "${u}" >> ~/.ssh/config`
5. `ssh-add -k ~/.ssh/id_ecdsa_${c}`
```
```{tab-item} macOS
Run the following commands from a terminal on the **local computer** that
you want to have key-based access to SMU HPC resources:

1. `u=<your SMU HPC username>` `<your SMU HPC username>` is set to
   your SMU HPC username to be used for the subsequent commands.
2. `c=<SMU HPC cluster>`, where `<SMU HPC cluster>` is either `m3` or `superpod` 
2. `ssh-keygen -q -t ecdsa -f ~/.ssh/id_ecdsa_${c}` You will need to
   press *enter* twice.
3. `cat ~/.ssh/id_ecdsa_${c}.pub | ssh ${u}@${c}.smu.edu "mkdir -p ~/.ssh && chmod 0700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 0700 ~/.ssh/authorized_keys && cat >> ~/.ssh/authorized_keys && chmod 0400 ~/.ssh/authorized_keys"`
   Press *enter* and you will be prompted for your SMU password.
4. `printf "Host *${c}.smu.edu\n   User %s\n   IdentityFile ~/.ssh/id_ecdsa_${c}\n" "${u}" >> ~/.ssh/config`
5. `ssh-add --apple-use-keychain ~/.ssh/id_ecdsa_${c}` You will be asked for
   the key's password, if present.
```
```{tab-item} Windows
1.  Open PuTTYgen.
2.  Press \"Generate\".
3.  Move mouse around blank area in window as instructed until key has
    been generated.
4.  Select the \"Conversions\" menu and then \"Export OpenSSH key\".
5.  Press \"Yes\" at the warning prompt.
7.  Type \"\<cluster\>_ssh_key_private\" for the file name, where "\<cluster\>"
    is either "m3" or "superpod"
8.  Press \"Save\".
9.  Leaving the \"PuTTY Key Generator\" window open, open the PuTTY
    application.
10. Type \"\<cluster\>.smu.edu\" into the \"Host Name\" field, where
    "\<cluster\>" is either "m3" or "superpod"
11. Press \"Open\".
12. Enter your SMU username (first part of your SMU email address).
13. Enter your SMU password.
14. At the command prompt type `echo "` (note the single double quote at
    the end).
15. From the \"PuTTY Key Generator\" window, copy all the text in the
    \"Public key for pasting into OpenSSH authorized_keys file:\"
    section (select all the text, right-click, and select \"Copy\").
16. Select PuTTY window and right-click at the prompt to paste the
    copied text.
17. At the command prompt type `" >> ~/.ssh/authorized_keys` (note the
    single double quote at the beginning).
18. Press the \"Enter (return)\" key.
19. At the command prompt type `exit` to log out of the cluster.
20. Close the \"PuTTY Key Generator\" window.
```
````

## Accessing Files via SFTP

### SFTP Clients

There are several popular SFTP clients available and any file transfer
client that supports SFTP will work with SMU HPC clusters. Several popular
SFTP clients include [WinSCP](https://winscp.net/) (Windows)
and [CyberDuck](https://cyberduck.io) (Windows, macOS). These clients
generally display two panes with the left side being your local files
and the right side being your files on the cluster. When setting up access
in these clients, SFTP must be chosen and your credentials will be your
normal SMU HPC credentials.

Users using SFTP clients such as Transmit and Cyberduck on macOS or
Cyberduck and WinSCP on Windows will be prompted by the application for
their password, if not saved, followed by a request for a Duo
**passcode** or `1` for a Duo push. The passcode can come from the Duo
app or from an OIT procured hardware token (faculty and staff only).

## Reducing the Number of Duo Authentications

An initial SSH/SFTP connection can be reused for subsequent
connections, which allows for multiple connections without being
prompted by Duo repeatedly.

### SSH

For those using OpenSSH (macOS, Linux, and Windows WSL), add the
following to your **local computer's** SSH `~/.ssh/config` file:

```none
Host *
  ControlMaster auto
  ControlPath ~/.ssh/sockets/ssh_mux_%C
  ControlPersist 600
```

Then make the sockets directory via `mkdir -p ~/.ssh/sockets`.

### PuTTY

For those using PuTTY on Windows, check the box "Share SSH connection
if possible" under "Category"; "Connection"; "SSH"; "Sharing an
SSH connection between PuTTY tools".

### Cyberduck

Cyberduck does not use SSH configurations, therefore the following
setting can be used to enable connection persistence. Within Cyberduck:

1. Select Edit, Preferences, Transfers, and then General.
2. Under "Transfers", use the "Transfer Files" drop-down to select
   "Use browser connection".

## Port Forwarding

:::{note}
These instructions assume you are using an OpenSSH client.
This is the default on Mac and Linux terminals. On Windows systems, WSL is OpenSSH based.
:::

You can use forwarding to utilize some HPC resources from your own computer
(typically over a web browser.)

You should not run programs on the login nodes, so it is necessary to use a
login node as a "jump" between your computer and the compute node(s) you are
using.

The basic procedure is:

1. Log in to a HPC machine
2. Request compute resuorces using `srun`, `sbatch`, `salloc`, or similar
3. Start your program and get port information
4. ssh into the compute node you got using a login node as a jump host and forward the appropriate port

For example, you might want to port forward JupyterLab:

1. login, e.g. `ssh username@m3.smu.edu`
2. Request resources, in this case, an interactive shell session using 1 core and 4GB of memory for 1 hour: 

```bash
srun -p dev -c 1 --mem=4GB -t 60 --pty $SHELL
```

3. Start JupyterLab (note you will need to setup JupyterLab in a Python or Conda environment see: [conda example](examples/conda/README.md)

```bash
jupyter lab --ip 0.0.0.0 --no-browser
```

Once Jupyter Lab starts, you should see something like

```bash
[C 2023-06-08 12:06:31.942 ServerApp] 
    
    To access the server, open this file in a browser:
        file:///users/username/.local/share/jupyter/runtime/jpserver-952278-open.html
    Or copy and paste one of these URLs:
        http://c002:8888/lab?token=b93c756f0f3026f816bf9bcee417b77fd4dcc75b3a38ebdc
     or http://127.0.0.1:8888/lab?token=b93c756f0f3026f816bf9bcee417b77fd4dcc75b3a38ebdc
```

We need two pieces of information: the compute node and the port. These can be read off
the link `http://c002:8888/lab?token=b93c756f0f3026f816bf9bcee417b77fd4dcc75b3a38ebdc`.
The format is `http:://node:port/lab...` so in this case, the node is `c002` and the port
is `8888`. Note that these may be different each time you run.

4. Keeping your original terminal open and running, open a new terminal (or new terminal tab)
and run `ssh username@node -J username@m3.smu.edu -L port:node:port`. So in this case,
we should run `ssh username@c002 -J username@m3.smu.edu -L 8888:c002:8888`. After this connects
and you login (twice, once for the login node and once for the compute node) you should be
able to use the link `http://127.0.0.1:8888/...` from your prefered web browser.

## SSH Host Key Changes

Occationally the SSH host keys will change SMU HPC systems. When this happens
you may get a message such as the one below:

```{code-block}
:emphasize-lines: 12
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                              
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @                              
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                              
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!                                    
Someone could be eavesdropping on you right now (man-in-the-middle attack)!              
It is also possible that a host key has just been changed.                               
The fingerprint for the ED25519 key sent by the remote host is                           
SHA256:4242424242424242424242424242424242424242424.                                      
Please contact your system administrator.                                                
Add correct host key in /Users/adent/.ssh/known_hosts to get rid of this message.    
Offending ED25519 key in /Users/adent/.ssh/known_hosts:42                            
Host key for superpod.smu.edu has changed and you have requested strict checking.
Host key verification failed.                                                            
```

To resolve the issue the offending key needs to be removed on your local
machine.

### OpenSSH

On macOS, Linux, and Windows using the Command Prompt, PowerShell, WSL, or
MobaXterm, the offending key can be removed via:

```bash
ssh-keygen -R superpod.smu.edu
```

Please note that the specific host, e.g. `superpod.smu.edu`, may be different.
See the specific host in the second to last line of the error message
(highlighted above).

### PuTTY on Windows

1. Open the "Registry Editor".
2. Browse to "HKEY_CURRENT_USER\SOFTWARE\<Your Windows User Name>\PuTTY\SshHostKeys".
3. Right-click on the offending key and select delete.

