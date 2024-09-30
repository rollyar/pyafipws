\
; base.nsi

; WARNING: This script has been created by py2exe. Changes to this script
; will be overwritten the next time py2exe is run!

XPStyle on

Page license
Page directory
;Page components
Page instfiles

RequestExecutionLevel admin

LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Spanish.nlf"

# set license page
LicenseText ""
LicenseData "licencia.txt"
LicenseForceSelection checkbox

; use the default string for the directory page.
DirText ""

Name "PyAfipWs version 3.10.3046"
OutFile "PyAfipWs-3.10.3046.exe"
;SetCompress off ; disable compression (testing)
SetCompressor /SOLID lzma
;InstallDir PyAfipWs
InstallDir $PROGRAMFILES\PyAfipWs

InstallDirRegKey HKLM "Software\PyAfipWs" "Install_Dir"

VIProductVersion "3.10.3046.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "PyAfipWs"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "PyAfipWs version 3.10.3046"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "http://www.sistemasagiles.com.ar"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "3.10.3046.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "Mariano Reingart"
;VIAddVersionKey /LANG=${LANG_ENGLISH} "InternalName" "FileSetup.exe"

Section PyAfipWs
    SectionIn RO
    SetOutPath $INSTDIR
    File /r dist\*.*
    IfFileExists $INSTDIR\\conf\\rece.ini 0 +3
        IfFileExists $INSTDIR\\rece.ini +2 0
        CopyFiles $INSTDIR\\conf\\rece.ini $INSTDIR\\rece.ini
    IfFileExists $INSTDIR\\conf\\reingart.crt 0 +3
        IfFileExists $INSTDIR\\reingart.crt +2 0
        CopyFiles $INSTDIR\\conf\\reingart.crt $INSTDIR\\reingart.crt
    IfFileExists $INSTDIR\\conf\\reingart.key 0 +3
        IfFileExists $INSTDIR\\reingart.key +2 0
        CopyFiles $INSTDIR\\conf\\reingart.key $INSTDIR\\reingart.key
    WriteRegStr HKLM SOFTWARE\PyAfipWs "Install_Dir" "$INSTDIR"
    ; Write the uninstall keys for Windows
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PyAfipWs" "DisplayName" "PyAfipWs version 3.10.3046 (solo eliminar)"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PyAfipWs" "UninstallString" "$INSTDIR\Uninst.exe"
    WriteUninstaller "Uninst.exe"
    
    ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{FF66E9F6-83E7-3A3E-AF14-8DE9A809A6A4}" "DisplayName"
    StrCmp $0 "Microsoft Visual C++ 2008 Redistributable - x86 9.0.21022"  vcredist_ok vcredist_install
 
    vcredist_install:
    File "vcredist.exe"
    DetailPrint "Installing Microsoft Visual C++ 2008 Redistributable"
    ExecWait '"$INSTDIR\vcredist.exe" /q' $0
    Delete $INSTDIR\vcredist.exe
    vcredist_ok:
    

    ;To Register a DLL
    
        ExecWait 'wsaa_com.exe --register'
    ExecWait 'wsfev1_com.exe --register'

    
    ;create start-menu items
    IfFileExists $INSTDIR\\pyrece.exe 0 +4
        CreateDirectory "$SMPROGRAMS\PyAfipWs"
        CreateShortCut "$SMPROGRAMS\PyAfipWs\PyRece.lnk" "$INSTDIR\pyrece.exe" "" "$INSTDIR\pyrece.exe" 0
        CreateShortCut "$SMPROGRAMS\PyAfipWs\Designer.lnk" "$INSTDIR\designer.exe" "" "$INSTDIR\designer.exe" 0
        ;CreateShortCut "$SMPROGRAMS\PyAfipWs\Uninstall.lnk" "$INSTDIR\Uninst.exe" "" "$INSTDIR\Uninst.exe" 0
    IfFileExists $INSTDIR\\factura.exe 0 +3
        CreateDirectory "$SMPROGRAMS\PyAfipWs"
        CreateShortCut "$SMPROGRAMS\PyAfipWs\PyFactura.lnk" "$INSTDIR\factura.exe" "" "$INSTDIR\factura.exe" 0
  
SectionEnd

Section "Uninstall"
    ;To Unregister a DLL
    
    
    ;Delete Files

    ;Delete Uninstaller And Unistall Registry Entries
    Delete "$INSTDIR\Uninst.exe"
    DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\PyAfipWs"
    DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\PyAfipWs"

SectionEnd

;--------------------------------

Function .onInit

    IfSilent nolangdialog

    ;Language selection dialog

    Push ""
    Push ${LANG_ENGLISH}
    Push English
    Push ${LANG_SPANISH}
    Push Spanish
    Push A ; A means auto count languages
           ; for the auto count to work the first empty push (Push "") must remain
    LangDLL::LangDialog "Installer Language" "Please select the language of the installer"

    Pop $LANGUAGE
    StrCmp $LANGUAGE "cancel" 0 +2
        Abort
        
nolangdialog:
        
FunctionEnd

