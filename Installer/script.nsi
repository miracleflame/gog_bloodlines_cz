!include FontRegAdv.nsh
!include FontName.nsh
!include WinMessages.nsh
!include "MUI2.nsh"

; MUI Settings / Icons
!define MUI_ICON "Czech Republic.ico"
 
; MUI Settings / Header
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "header.bmp"
 
; MUI Settings / Wizard
!define MUI_WELCOMEFINISHPAGE_BITMAP "wizard.bmp"

; The name of the installer
Name "Čeština pro hru Vampire the Masquerade: Bloodlines Unofficial Patch 11.1"

; The file to write
OutFile "Cestina_VTMBup11.1beta.exe"

; The default installation directory
InstallDir "(instalace hry nenalezena, cestu zvolte ručně)"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "SOFTWARE\WOW6432Node\Activision\Vampire - Bloodlines" InstallPath
InstallDirRegKey HKLM "SOFTWARE\Activision\Vampire - Bloodlines" InstallPath

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------

; Pages
   !define MUI_WELCOMEPAGE_TITLE_3LINES
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "licence.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
   !define MUI_FINISHPAGE_TITLE_3LINES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "Czech"


; The stuff to install
Section "VTMB UP 11.1 BASIC" basic

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath "$INSTDIR"
  
  ; Put file there
  File /r "..\temp\basic\bin"
  File /r "..\temp\basic\Unofficial_patch"

 StrCpy $FONT_DIR $FONTS
 
 !insertmacro RemoveTTF 'VTMB_Copperplate_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Dementation2_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_DomesticManners_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Domination_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Dominican_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Intimidation_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Malkavian_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Persuasion_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Precolator_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Seduction_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Tahoma_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_TimesNewRoman_IS.TTF'
 !insertmacro RemoveTTF 'VTMB_Trebuchet_IS.TTF'
 
 SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0 /TIMEOUT=5000

  !insertmacro InstallTTF '.\czfonts\VTMB_Copperplate_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Dementation2_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_DomesticManners_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Domination_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Dominican_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Intimidation_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Malkavian_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Persuasion_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Precolator_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Seduction_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Tahoma_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_TimesNewRoman_IS.TTF'
  !insertmacro InstallTTF '.\czfonts\VTMB_Trebuchet_IS.TTF'
 
  SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0 /TIMEOUT=5000
 
 
SectionEnd


; Optional section (can be disabled by the user)
Section "Rozšíření UP 11.1 PLUS " plus

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File /r "..\temp\plus\Unofficial_patch"
  
SectionEnd

;--------------------------------
;Descriptions

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${basic} "Překlad je určen pro verzi hry s Neoficiálním Patchem 11.1 BASIC, která je dostupná na GOG.com. Počeštěné jsou i s diakritikou všechny textury, dialogy, ovládací prvky a popisky."
	!insertmacro MUI_DESCRIPTION_TEXT ${plus} "Rozšíření PLUS pro Neof. Patch 11.1 v češtine. Obsahuje např. historie pro vytváření postav nebo titulky pro vysílání rádia a hlasy v hlavě. Nevyžaduje samostatnou instalaci anglické verze UP Plus!"
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
