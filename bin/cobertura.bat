CodeCoverage.exe -e "VigilanteTeste.exe" -m "VigilanteTeste.map" -uf dcov_units.lst -spf dcov_paths.lst -od "emma" -lt -emma -meta -xml -html -lt logCoverage.txt
cd emma
CodeCoverage_summary.html
cd ..