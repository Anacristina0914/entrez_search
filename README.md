# Requirements
- MacOS/Linux
  - Git
  - eutils
  - zenity
  - xmlstarlet
- MacOS
  - Homebrew
### Install Homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
#### Homebrew without root priviledges
```
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
```
Export folder to $PATH, note /homebrew/folder/bin must be replaced by the path to the homebrew bin in your system. e.g. cd homebrew/bin && pwd will output the folder where bin is located in your system.
```
export PATH=$PATH:/homebrew/folder/bin/
```
### Install eutils (MacOS/Linux)
```
sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"
```
export to $PATH
```
export PATH=${HOME}/edirect:${PATH}
```
### install zenity
```
brew install zenity 
```
Zenity is installed by default zenity in linux ubuntu. 

### Install xmlstarlet
```
brew install xmlstarlet
```
XMLStarlet is installed by default on CentOS, Fedora and many other Linux distributions. 

# Install and run entrez_search
Clone the whole repository
```
git clone git@github.com:Anacristina0914/entrez_search.git
```
Copy individual files
```
wget https://raw.githubusercontent.com/Anacristina0914/entrez_search/main/entrez_search.command
```
```
wget https://raw.githubusercontent.com/Anacristina0914/entrez_search/main/entrez_searchfile.command
```
or
```
curl -O https://raw.githubusercontent.com/Anacristina0914/entrez_search/main/entrez_search.command
```
```
curl -O https://raw.githubusercontent.com/Anacristina0914/entrez_search/main/entrez_searchfile.command
```
Make files executable
```
chmod +x entrez_search*.command
```
## Search space separated gene input
Pop up windown will ask for a space separated list of files and organism. Output will be saved in $HOME/entrez_found directory as a summary \
containing gene name, gene description, and a short summary of gene function.
```
./entrez_search.command 
```
## Search using file
Pop up windown will ask to select a file. A second window will ask to specify an organism. The file must contain 1 gene per line. Output will be saved in $HOME/entrez_found directory as a summary \
containing gene name, gene description, and a short summary of gene function.
```
./entrez_searchfile.command 
```

* Alternatively, the user can double click the file icon to launch it. 
