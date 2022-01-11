# Miniconda Installation

Users who need specific versions of _Conda_ or simply want more control over their software environment(s) are encouraged to install _Miniconda_ locally.

## Local _Miniconda_ Installation

### Download _Miniconda_

_Miniconda_ can be downloaded from their [website](https://docs.conda.io/en/latest/miniconda.html). For use on our HPC systems, users should download the 64-bit Linux version. The latest version is available at [https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh](https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh), which we will use for these instructions.

From a terminal, which you can access by logging into the system using SSH or by accessing the shell from Clusters menu at the top of the OnDemand portal at hpc.smu.edu, you can download directly to the system using ```wget```:

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

### Check the hash

It is good practice to verify the hash of downloaded software. This step helps ensure that the software has not been corrupted in some way. In this case, _Miniconda_ provides _SHA256_ hashes of their downloads on the [website](https://docs.conda.io/en/latest/miniconda.html).

At the time of writing this, the hash of the latest version is ```1ea2f885b4dbc3098662845560bc64271eb17085387a70c2ba3f29fff6f8d52f
```, but this will change when they release a newer version.

You can generate the hash of the downloaded file, ```Miniconda3-latest-Linux-x86_64.sh```, by calling

```bash
# verify hash
sha256sum Miniconda3-latest-Linux-x86_64.sh
```

This should produce an output like:

```bash
1ea2f885b4dbc3098662845560bc64271eb17085387a70c2ba3f29fff6f8d52f  Miniconda3-latest-Linux-x86_64.sh
```

We can see that the hash matches the expected value, so the file downloaded without errors.

>[!NOTE]
>You should use the hash from the [_Miniconda_ website](https://docs.conda.io/en/latest/miniconda.html) corresponding to the file you downloaded and not the one above to verify.

### Run Installation Script

To run the installation script call

```bash 
bash ./Miniconda3-latest-Linux-x86_64.sh 
```

The first step requires you to read and agree to the license. Press ```enter``` (possibly multiple times) to display the agreement. After reading the agreement, you will be prompted to type ```yes``` to agree.

After typing yes, the installer will ask you for an installation location. The default location will be ```$HOME/miniconda3```, which is fine, but you can change it to somewhere else if you prefer. Press ```enter``` to accept the default location or enter your preferred install location.

The installation process will take about 5 minutes. After the installation completes, you will be asked if you want to run ```conda init```. The default is no, which means you will have to manually initialize _Conda_. If you choose yes, then the installer will modify your shell profile to automatically start _Conda_.

