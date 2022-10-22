#!/bin/bash

flag1=0 # Flag number 1 to be used in validation user input
declare -a zerovowelsarray  # Array created to show words that contain 0 vowels
declare -a onevowelsarray   # Array created to show words that contain 1 vowels
declare -a twovowelsarray   # Array created to show words that contain 2 vowels
declare -a threevowelsarray # Array created to show words that contain 3 vowels
declare -a fourvowelsarray  # Array created to show words that contain 4 vowels
declare -a fivevowelsarray  # Array created to show words that contain 5 vowels

parseVowels() { # Definition of parseVowels function
    # Using grep command to search for patterns that only match for string words and interpret pattern as 
    # extended regular expression with alphabetical characters in the input file from the user.
    grep -o -E "([[:alpha:]]|')+" $1 |
    # Then move the information to a sed command, using the instruction to replace all the puntuation characters, 
    # excepted "'" contractions in the text file, and finally creating a text file named 
    # tidywords to generate a line per word for next step to do an iteration 
    # looking for vowels and lenght of word
    sed "s/'[[:punct:]]//" > tidywords.txt
        
    while read text_line; do # Cycle to validate read each line in tidywords txt file
            total_ch=${#text_line}  # Setting total of characters variable with lenght of each word
            if [ "$total_ch" -ge 4 ]; then # Checking if lenght of word in characters is greater or equal to four (4)
                # Parce vowels using grep commmand to Searching for pattern that only matches with vowels on each 
                # word, then count and setting total_v variable with total number of vowels
                total_v=$(grep -o '[aeiouAEIOU]' <<< $text_line | wc -l) 
                if [ "$total_v" -eq 0 ]; then # Checking if total of vowels in the word is equal to zero (0)
                    zerovowelsarray+=("[$text_line]") # Adding word to array with zero vowels
                elif [ "$total_v" -eq 1 ]; then # Checking if total of vowels in the word is equal to one (1)
                    onevowelsarray+=("[$text_line]") # Adding word to array with one vowels
                elif [ "$total_v" -eq 2 ]; then # Checking if total of vowels in the word is equal to two (2)
                    twovowelsarray+=("[$text_line]") # Adding word to array with two vowels
                elif [ "$total_v" -eq 3 ]; then # Checking if total of vowels in the word is equal to three (3)
                    threevowelsarray+=("[$text_line]") # Adding word to array with three vowels
                elif [ "$total_v" -eq 4 ]; then # Checking if total of vowels in the word is equal to four (4)
                    fourvowelsarray+=("[$text_line]") # Adding word to array with four vowels
                elif [ "$total_v" -eq 5 ]; then # Checking if total of vowels in the word is equal to five (5)
                    fivevowelsarray+=("[$text_line]") # Adding word to array with five vowels
                fi # End of if instruction with total vowels
            fi # End of if instruction with total number of characters
    done < "tidywords.txt" # End of while cycle depending on tidywords text file

    if ((${#zerovowelsarray[@]})); then # Checking if the array with zero vowels has words
        printf "\n${#zerovowelsarray[@]} contain 0 vowels, these being:" # Pint message with quantity of words with 0 vowels
        printf "\n${zerovowelsarray[*]}\n" # Print message with words including zero vowel
    else # In case there are no words in the array
        printf "\nThere are no words that contain 0 vowels.\n" # Print message with no words with zero vowels
    fi # End of if statement to check array

    if ((${#onevowelsarray[@]})); then # Checking if the array with one vowels has words
        printf "\n${#onevowelsarray[@]} contain 1 vowels, these being:"
        printf "\n${onevowelsarray[*]}\n" # Print message with words including one vowel
    else # In case there are no words in the array
        printf "\nThere are no words that contain 1 vowels.\n" # Print message with no words with one vowels
    fi # End of if statement to check array

    if ((${#twovowelsarray[@]})); then # Checking if the array with two vowels has words
        printf "\n${#twovowelsarray[@]} contain 2 vowels, these being:"
    printf "\n${twovowelsarray[*]}\n" # Print message with words including two vowel
    else # In case there are no words in the array
        printf "\nThere are no words that contain 2 vowels.\n" # Print message with no words with two vowels
    fi # End of if statement to check array

    if ((${#threevowelsarray[@]})); then # Checking if the array with three vowels has words
        printf "\n${#threevowelsarray[@]} contain 3 vowels, these being:"
    printf "\n${threevowelsarray[*]}\n" # Print message with words including three vowel
    else # In case there are no words in the array
        printf "\nThere are no words that contain 3 vowels.\n" # Print message with no words with three vowels
    fi # End of if statement to check array

    if ((${#fourvowelsarray[@]})); then # Checking if the array with four vowels has words
        printf "\n${#fourvowelsarray[@]} contain 4 vowels, these being:"
    printf "\n${fourvowelsarray[*]}\n" # Print message with words including four vowel
    else # In case there are no words in the array
        printf "\nThere are no words that contain 4 vowels.\n" # Print message with no words with four vowels
    fi # End of if statement to check array

    if ((${#fivevowelsarray[@]})); then # Checking if the array with five vowels has words
        printf "\n${#fivevowelsarray[@]} contain 5 vowels, these being:"
        printf "\n${fivevowelsarray[*]}\n" # Print message with words including five vowel
    else # In case there are no words in the array
        printf "\nThere are no words that contain 5 vowels.\n" # Print message with no words with five vowels
    fi # End of if statement to check array

    rm tidywords.txt # Removing 
}

while [ $flag1 -eq  0 ]; do # Cycle to validate integer numbers in lower value
    read -p 'Please enter a file name to parse: ' inputtextfile # Reading user input for text file
    if ! [[ -f $inputtextfile ]]; then # Checking if input file exist
        # Print red error message where text file does not exist
        echo "$(tput setaf 1)A file of this name does not exist in this location. Please try again.$(tput setaf 7)"
    else # In case text file exist
        parseVowels $inputtextfile # Calling parVowels function with input text file name
        flag1=1 # Setting flag1 equal 1 to end while cycle after validate the words
    fi # End of if statement to check file name
done # End of main while cycle

exit 0 # Ending Shell Script