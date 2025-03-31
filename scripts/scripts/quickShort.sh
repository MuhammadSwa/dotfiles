#!/bin/bash

# $1 name of shortcut, $2 path of file

cat << EOF > ~/scripts/shorts/"$1"
#!/bin/bash

xpdf -z 250 $2
EOF
chmod 711 /"$HOME"/scripts/shorts/"$1"
echo
echo "your shortcut $1 has been made successfully in ~/scripts/shorts"
exit 0
