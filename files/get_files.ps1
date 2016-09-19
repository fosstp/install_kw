$location = Split-Path $PSCommandPath -Parent
wget https://download.microsoft.com/download/a/c/2/ac2b4571-9211-44f0-a311-42464d1294dd/MDAC_TYP.EXE -OutFile ${location}\MDAC_TYP.EXE
wget http://163.29.37.107/kw/docnet/service/formbinder/install/down/docNinstall.msi -OutFile ${location}\docNinstall.msi