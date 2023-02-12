#!/bin/bash

echo "Generating a new SSH key for GitHub..."

#create the ssh folder if it doesn't exist
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

cd ~/.ssh

echo

# Generate a new SSH key
echo "Please enter your email address:"
read email
ssh-keygen -t rsa -b 4096 -C "$email"

echo


echo "What is the name of the ssh file without extension?"
read filename

echo

# Start the ssh-agent
echo "Starting the ssh-agent..."
eval "$(ssh-agent -s)"

# Add the key to the ssh-agent
echo
ssh-add ~/.ssh/$filename

# Add the key to GitHub
echo
echo "Copy the ssh: "
cat ~/.ssh/$filename.pub
