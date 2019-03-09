# Update packages
sudo apt-get update
sudo apt-get upgrade

# Insall basic packages
sudo apt-get install git emacs compizconfig-settings-manager compiz-plugins-extra ubuntu-desktop gnome-session-flashback 
sudo apt-get install network-manager-vpnc network-manager-vpnc-gnome texstudio ipe

# Install spotify 
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
sudo echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# Make some useful directories
mkdir ~/software
mkdir -p ~/smt/software

# Install CUDA
sudo wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb 
sudo dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda

# Open cudnn in Firefox
firefox https://developer.nvidia.com/rdp/cudnn-download &

# Install Anaconda
cd ~/software
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh;
bash miniconda.sh -b -p ~/software/miniconda
export PATH="$HOME/software/miniconda/bin:$PATH"
conda config --set always_yes yes --set changeps1 no
conda update -q conda
conda install --file ~/conda_packages.txt
pip install cloud
conda install -c mila-udem pygpu
conda install -c mila-udem theano
cp .theanorc ~/.theanorc
# Install PyCharm
cd ~/software 
wget https://download.jetbrains.com/python/pycharm-professional-2017.3.2.tar.gz
tar -xzvf pycharm-professional-2017.3.2.tar.gz
