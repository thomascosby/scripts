#!
read -p "Are you sure? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "User confirmed"
else
    echo "User cancelled"

fi

