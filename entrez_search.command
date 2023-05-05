#!/usr/bin/env bash

input=$(zenity --forms --title="Gene list" --text="Input a space sep list of genes and an organism" --add-entry="Genes:" \
	--add-combo="Organism" --combo-values="Homo Sapiens | Homo neanderthalensis| Mus musculus | Rattus rattus")

file_name=$(echo gene_summary_$(date '+%b%d')_$RANDOM.txt)
proces_genes=0

if [[ ! -d $HOME/entrez_found ]]; then
        mkdir $HOME/entrez_found
fi

gene_list=$(echo $input | awk -F"|" '{print $1}')
org=$(echo $input | awk -F"|" '{print $2}')
total_genes=$(echo $gene_list | wc -w)

(for gene in ${gene_list[@]}; do
    if [[ -n "$gene" ]]; then
	let "proces_genes+=1"
	echo "$proces_genes/$total_genes*100" | bc -l 
        tmp_file=$(echo $RANDOM.xml)
        esearch -db gene -query "$gene [gene] AND $org [ORGN]" | esummary > $tmp_file
        if [[ -s $tmp_file ]]; then
          gene_name=$(xmlstarlet sel -t -m '//Name' -v . -n < $tmp_file)
          description=$(xmlstarlet sel -t -m '//Description' -v . -n < $tmp_file)
          summary=$(xmlstarlet sel -t -m '//Summary' -v . -n < $tmp_file)
          echo -e "query: $gene\nGene name:\n$gene_name\nDescription:\n$description\nSummary:\n$summary\n" >> $HOME/entrez_found/$file_name;
          fi
          rm $tmp_file

    fi
done) | zenity --progress --title="Fetching gene data..." --title="Searching..." --percentage=0 --auto-close

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Search canceled."
fi

if [[ -f $HOME/entrez_found/$file_name ]]
then
	zenity --info --text="$(grep -c query $HOME/entrez_found/"$file_name") out of $total_genes genes found. Check $HOME/entrez_found/"$file_name" for output" --no-wrap
else
	zenity --info --text="Gene search had no results, check gene names and try again"
fi
exit
