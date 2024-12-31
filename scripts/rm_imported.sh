rm -r src/
rm -r pyOpenDRIVE/include/
find pyOpenDRIVE/ -name \*.h -exec rm {} \; -o -name \*.hpp -exec rm {} \;
