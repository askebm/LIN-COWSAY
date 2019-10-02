#!/bin/bash
freq_scram=$(cat $1 | grep -Eo "[A-Za-z]"  | tr '[a-z]' '[A-Z]' | sort | uniq -c | sort -nr)
freq_scram_n=$(echo $freq_scram | grep -Eo "[0-9]+")
freq_scram_l=$(echo $freq_scram | grep -Eo '[A-Z]' | tr '\n' ' ' | sed 's/\ //g')
#freq_eng="ETAOINSRHDLUCMFYWGPBVKXQJZ"
freq_eng="ETAONIHSRDLUMWCFGYPBVKXJQZ"
freq_eng_lower=$(echo $freq_eng | tr 'A-Z' 'a-z' )
freq_scram_l_lower=$(echo $freq_scram_l | tr 'A-Z' 'a-z' )
total_letter_count=0
for i in $freq_scram_n; do
	total_letter_count=$(( $total_letter_count + $i ))
done

freq_scram_p=""
for i in $freq_scram_n; do
	freq_scram_p="$freq_scram_p "$( echo "scale=2; 100*$i/$total_letter_count" | bc -l )
done
#echo "$(echo $freq_scram_l | sed -E 's/([A-Z])/\1\n/g')$(echo -e '\c')$freq_scram_n$(echo -e '\c')$( echo $freq_scram_p | sed 's/\s/\n/g')"
paste <(echo "$freq_eng" | sed -E 's/([A-Z])/\1\n/g') <(echo "$freq_scram_l" | sed -E 's/([A-Z])/\1\n/g')  <(echo "$freq_scram_n"|head -n26) <(echo "$freq_scram_p" | sed 's/\s/\n/g' | grep -E "\S+" | head -n26) --delimiters '\t'

cat $1 | tr "${freq_scram_l}${freq_scram_l_lower}" "${freq_eng}${freq_eng_lower}"


