#!/usr/bin/env zsh
#SBATCH -J nemo_0
#SBATCH -o nemo_0_%j.out
#SBATCH -c 1
#SBATCH --mem=1G

# Download and extract data
curl -s -O https://dl.fbaipublicfiles.com/glue/data/SST-2.zip\
 && unzip -o SST-2.zip -d ./\
 && sed 1d ./SST-2/train.tsv > ./train_nemo_format.tsv\
 && sed 1d ./SST-2/dev.tsv > ./dev_nemo_format.tsv &

# Clone the NeMo repo
git clone --depth 1 https://github.com/NVIDIA/NeMo.git &

# Wait for the above commands to complete
wait

# Move data
mv *_nemo_format.tsv NeMo/

# Fix path to data
conf=./NeMo/examples/nlp/text_classification/conf/text_classification_config.yaml
sed -i -z 's%    file_path: null%    file_path: ./train_nemo_format.tsv%1' ${conf}
sed -i -z 's%    file_path: null%    file_path: ./dev_nemo_format.tsv%g' ${conf}

