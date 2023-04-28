#!/usr/bin/env bash

gene_list=$(zenity --file-selection)
file_name=$(echo gene_summary_$(date '+%b%d')_$RANDOM.txt)
found=0

if [[ ! -d $HOME/entrez_found ]]; then
        mkdir $HOME/entrez_found
fi

for gene in $(cat "$gene_list"); do
    if [[ -n "$gene" ]]; then
        tmp_file=$(echo $RANDOM.xml)
        esearch -db gene -query "$gene [gene] AND Mus Musculus [ORGN]" | esummary > $tmp_file
        if [[ -s $tmp_file ]]; then
          let "found+=1"
          gene_name=$(xmlstarlet sel -t -m '//Name' -v . -n < $tmp_file)
          description=$(xmlstarlet sel -t -m '//Description' -v . -n < $tmp_file)
          summary=$(xmlstarlet sel -t -m '//Summary' -v . -n < $tmp_file)
          echo -e "query: $gene\nGene name:\n$gene_name\nDescription:\n$description\nSummary:\n$summary\n" >> $HOME/entrez_found/$file_name
        fi
	      rm $tmp_file 
    fi
done

if [[ -f $HOME/entrez_found/$file_name ]]
  then
    zenity --info --text="$found genes found. Check $HOME/entrez_found/"$file_name" for output" --no-wrap
  else
    zenity --info --text="Gene search had no results, check gene names and try again"
fi
exit
