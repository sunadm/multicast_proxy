; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "udptopoint"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "network"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\send_reload_point_cfg.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
;!insertmacro MUI_PAGE_LICENSE "..\..\..\path\to\licence\YourSoftwareLicence.txt"
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\send_reload_point_cfg.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}-${PRODUCT_VERSION}.exe"
InstallDir "c:\udptopoint"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "udptopoint-installpacket\send_reload_point_cfg.exe"
  CreateDirectory "$SMPROGRAMS\udptopoint"
  CreateShortCut "$SMPROGRAMS\udptopoint\udptopoint.lnk" "$INSTDIR\send_reload_point_cfg.exe"
  CreateShortCut "$DESKTOP\udptopoint.lnk" "$INSTDIR\send_reload_point_cfg.exe"
  File "udptopoint-installpacket\udptopoint.exe"
  File "udptopoint-installpacket\server_cfg.json.txt"
  File "udptopoint-installpacket\Sc.Exe"
  File "udptopoint-installpacket\cygwin1.dll"
  File "udptopoint-installpacket\udptopoint_start.bat"
  File "udptopoint-installpacket\udptopoint_stop.bat"
  File "udptopoint-installpacket\WinPcap.exe"
SectionEnd

Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\udptopoint\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\send_reload_point_cfg.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\send_reload_point_cfg.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  SetOutPath '$INSTDIR'
  ExecWait "$INSTDIR\udptopoint_start.bat"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "udptopoint 已成功地从你的计算机移除。"
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "你确实要完全移除 udptopoint，其及所有的组件？" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  SetOutPath '$INSTDIR'
  ExecWait "$INSTDIR\udptopoint_stop.bat"

  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\cygwin1.dll"
  Delete "$INSTDIR\Sc.Exe"
  Delete "$INSTDIR\server_cfg.json.txt"
  Delete "$INSTDIR\udptopoint.exe"
  Delete "$INSTDIR\send_reload_point_cfg.exe"
  Delete "$INSTDIR\udptopoint_start.bat"
  Delete "$INSTDIR\udptopoint_stop.bat"
  Delete "$INSTDIR\server_log.txt"
  Delete "$INSTDIR\udptopoint_status.txt"
  Delete "$INSTDIR\WinPcap.exe"

  Delete "$SMPROGRAMS\udptopoint\Uninstall.lnk"
  Delete "$DESKTOP\udptopoint.lnk"
  Delete "$SMPROGRAMS\udptopoint\udptopoint.lnk"

  RMDir "$SMPROGRAMS\udptopoint"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
