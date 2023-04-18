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
Pop up windown will ask for a space separated list of files. Output will be saved in the Desktop as a summary \
containing gene name, gene description, and a short summary of gene function.
```
./entrez_search.command 
```
## Search using file
Pop up windown will ask to select a file. The file must contain 1 gene per line. Output will be saved in the Desktop as a summary \
containing gene name, gene description, and a short summary of gene function.
```
./entrez_searchfile.command 
```
