#!/usr/bin/env bash

if [[ -z "$(which esearch)" ]]; then
    sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"
    export PATH=${HOME}/edirect:${PATH}
fi

if [[ -z "$(which zenity)" ]]; then
    brew install zenity || sudo apt-get update && sudo apt-get install zenity
fi

if [[ -z "$(which xmlstarlet)" ]]; then
    brew install xmlstarlet || sudo apt-get update && sudo apt-get install xmlstarlet

fi

gene_list=$(zenity --entry --text="Input a list of space separated genes:")
#read -a gene_list -p "Provide a gene list: "
file_name=$(echo gene_summary_$(date '+%b%d')_$RANDOM.txt)
#touch $file_name
for gene in ${gene_list[@]}; do
    if [[ -n "$gene" ]]; then
        tmp_file=$(echo $RANDOM.xml)
        esearch -db gene -query "$gene [gene] AND Mus Musculus [ORGN]" | esummary > $tmp_file
        gene_name=$(xmlstarlet sel -t -m '//Name' -v . -n < $tmp_file)
        description=$(xmlstarlet sel -t -m '//Description' -v . -n < $tmp_file)
        summary=$(xmlstarlet sel -t -m '//Summary' -v . -n < $tmp_file)
        echo -e "Gene name:\n$gene_name\nDescription:\n$description\nSummary:\n$summary\n" >> $HOME/Desktop/$file_name
    fi
done
zenity --info --text="Check $HOME/Desktop/"$file_name" for output" --no-wrap
