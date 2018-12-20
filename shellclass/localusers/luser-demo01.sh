#!/bin/bash
# Hello from main os
# Display 'hello'
echo 'Hello'

# assing a value to a variable no space
WORD='script'
echo "$WORD" 

# Demonstarte single script cannot be expandes
echo '$WORD'

# combine variable with hard code test
echo "This is a shell $WORD"
echo "This is a shell ${WORD}"
# append test to variable
echo "${WORD}ing is fun"

#create a new variable
ENDING='ed'

# combine these two 
echo "This is ${WORD}${ENDING}"
ENDING='ing'
echo "${WORD}${ENDING} is fun"
ENDING='s'
echo "you ganna write many scirpt${ENDING}"