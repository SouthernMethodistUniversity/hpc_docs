# Docker container -> Singularity 

Requested by Rachel Wright for a course:

name | purpose | link | notes
-----|---------|------|-------
dDocent | RAD pipeline | http://www.ddocent.com/downloads/ | has a lot of dependencies and some of them are also on this list
Trimmomatic | trim reads | http://www.usadellab.org/cms/?page=trimmomatic | dDocent dep
SAMtools | manipulate SAM files | http://samtools.sourceforge.net | dDocent dep
VCFtools | manipulate VCF files | http://vcftools.sourceforge.net/index.html | dDocent dep
CD-HIT | clustering | http://weizhong-lab.ucsd.edu/cd-hit/ | dDocent dep
bedtools | suite of genomics tools | http://bedtools.readthedocs.io/en/latest/ | dDocent dep
bamtools | manipulate BAM files | https://github.com/pezmaster31/bamtools | dDocent dep
fastqc | fastqc file QC | https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ | 
FASTX-Toolkit | suite of fastq file tools | http://hannonlab.cshl.edu/fastx_toolkit/ | 
cutadapt | trimming and filtering | https://cutadapt.readthedocs.io/en/stable/installation.html | 
bowtie-2 | alignment | https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml | 
HTSeq | sequence analysis | https://htseq.readthedocs.io/en/release_0.11.1/install.html#installation-on-linux | 
BWA | alignment | https://icb.med.cornell.edu/wiki/index.php/Elementolab/BWA_tutorial | 
STAR | alignment | https://github.com/alexdobin/STAR | 

## build 

```
sudo docker build -t jlagrone/genomics_base .

sudo docker run -v /var/run/docker.sock:/var/run/docker.sock -v /home/gjfh119/docker/genomics_wright:/output quay.io/singularity/docker2singularity -n genomics_wright.simg jlagrone/genomics_base:latest
```
