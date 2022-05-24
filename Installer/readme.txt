Beta verze instalátoru, naskriptované v NSIS:

Požadavky:
- před kompilací instalátoru je zapotřebí mít připraven skonvertovaný překlad použitím Python 3 skriptu "converter.py" (využíva externí knihovnu unidecode)
- musíte mít nainstalován NSIS ( http://nsis.sourceforge.net/Download ) a jeho přídavný plug-in ( http://nsis.sourceforge.net/FontName_plug-in )
- POZOR FontName plug-in se nainstaluje chybně, je potřeba presunout "NSIS\Plugins\FontName.dll" do "NSIS\Plugins\x86-unicode\"
- instalátor se zkompiluje spuštěním Installer/compile.cmd

Instalátor obsahuje:
1. licenční ujednání (license.txt)
2. výběr komponent "Čeština (povinná) a "Rozšíření UP PLUS" (volitelná)
3. autodetekce cesty instalace z registrů s možností procházení
4. automatická instalace českých fontů do systému
