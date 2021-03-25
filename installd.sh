#!/bin/bash
TEMP=/tmp/answer$$
whiptail --title "Innova [INN]"  --menu  "Ubuntu 16.04/18.04 Daemon Node :" 20 0 0 1 "Compile innovad Ubuntu 16.04" 2 "Update innovad 16.04 to latest" 3 "Compile innovad Ubuntu 18.04" 4 "Update innovad 18.04 to latest" 2>$TEMP
choice=`cat $TEMP`
case $choice in
1) echo 1 "Compiling innovad Ubuntu 16.04"

echo "Updating linux packages"
sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt-get --assume-yes install git unzip build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev libminiupnpc-dev libevent-dev obfs4proxy

echo "Installing Innova Wallet"
git clone https://github.com/MichaelHDesigns/innova.git
cd innova || exit
git checkout master
git pull

cd src
make -f makefile.unix

sudo yes | cp -rf innovad /usr/bin/

echo "Copied to /usr/bin for ease of use"

#echo "Get Chaindata"
#cd ~/.innova || exit
#rm -rf database txleveldb smsgDB
#wget https://github.com/innova-foundation/innova/releases/download/v3.3.7/chaindata1701122.zip
#unzip chaindata1701122.zip
#rm -rf chaindata1701122.zip
echo "Back to Compiled innovad Binary Folder"
cd ~/innova/src
                ;;
2) echo 2 "Update innovad"
echo "Updating Innova Wallet"
cd ~/innova || exit
git checkout master
git pull

cd src
make -f makefile.unix

sudo yes | cp -rf innovad /usr/bin/

echo "Copied to /usr/bin for ease of use"

echo "Back to Compiled innovad Binary Folder"
cd ~/innova/src
                ;;
3) echo 3 "Compile innovad Ubuntu 18.04"
echo "Updating linux packages"
sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt-get --assume-yes install git unzip build-essential libdb++-dev libboost-all-dev libqrencode-dev libminiupnpc-dev libevent-dev obfs4proxy libssl-dev

echo "Downgrade libssl-dev"
sudo apt-get install make
wget https://www.openssl.org/source/openssl-1.0.1j.tar.gz
tar -xzvf openssl-1.0.1j.tar.gz
cd openssl-1.0.1j
./config
make depend
sudo make install
sudo ln -sf /usr/local/ssl/bin/openssl `which openssl`
cd ~
openssl version -v

echo "Installing Innova Wallet"
git clone https://github.com/MichaelHDesigns/innova.git
cd innova
git checkout master
git pull

cd src
make OPENSSL_INCLUDE_PATH=/usr/local/ssl/include OPENSSL_LIB_PATH=/usr/local/ssl/lib -f makefile.unix

sudo yes | cp -rf innovad /usr/bin/

echo "Copied to /usr/bin for ease of use"

#echo "Get Chaindata"
#cd ~/.innova
#rm -rf database txleveldb smsgDB
#wget https://github.com/innova-foundation/innova/releases/download/v3.3.7/chaindata1701122.zip
#unzip chaindata1701122.zip
#rm -rf chaindata1701122.zip
echo "Back to Compiled innovad Binary Folder"
cd ~/innova/src
                ;;
4) echo 4 "Update innovad 18.04"
echo "Updating Innova Wallet"
cd ~/innova || exit
git checkout master
git pull

cd src
make OPENSSL_INCLUDE_PATH=/usr/local/ssl/include OPENSSL_LIB_PATH=/usr/local/ssl/lib -f makefile.unix

sudo yes | cp -rf innovad /usr/bin/

echo "Copied to /usr/bin for ease of use"

echo "Back to Compiled innovad Binary Folder"
cd ~/innova/src
                ;;
esac
echo Selected $choice
