Attribute VB_Name = "mdlDeclarations"
Option Explicit

Public Declare Sub InitCommonControls Lib "comctl32" ()

Public Declare Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" (A As Any, b As Any, ByVal C As Long)
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Declare Function IsMenu Lib "User32" (ByVal hMenu As Long) As Long
Public Declare Function DrawMenuBar Lib "User32" (ByVal hwnd As Long) As Long
Public Declare Function GetSystemMenu Lib "User32" (ByVal hwnd As Long, ByVal bRevert As Long) As Long
Public Declare Function GetMenu Lib "User32" (ByVal hwnd As Long) As Long
Public Declare Function GetSubMenu Lib "User32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Public Declare Function GetMenuItemInfo Lib "User32" Alias "GetMenuItemInfoA" (ByVal hMenu As Long, ByVal un As Long, ByVal b As Boolean, lpMenuItemInfo As MENUITEMINFO) As Long
Public Declare Function GetMenuItemCount Lib "User32" (ByVal hMenu As Long) As Long
Public Declare Function GetMenuItemID Lib "User32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Public Declare Function CreatePopupMenu Lib "User32" () As Long
Public Declare Function DestroyMenu Lib "User32" (ByVal hMenu As Long) As Long
Public Declare Function AppendMenu Lib "User32" Alias "AppendMenuA" (ByVal hMenu As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpNewItem As Any) As Long
Public Declare Function ModifyMenu Lib "User32" Alias "ModifyMenuA" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpString As Any) As Long
Public Declare Function DeleteMenu Lib "User32" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long) As Long
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Public Declare Function PostMessage Lib "User32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function GetUserName Lib "advapi32.dll" Alias "GetUserNameA" (ByVal lpBuffer As String, nSize As Long) As Long
Public Declare Function SetWindowPos Lib "User32" (ByVal h&, ByVal hb&, ByVal x&, ByVal y&, ByVal cx&, ByVal cy&, ByVal f&) As Long
Public Declare Function GetSystemMetrics Lib "User32" (ByVal nIndex As Long) As Long
Public Declare Function TrackPopupMenu Lib "User32" (ByVal hMenu As Long, ByVal wFlags As Long, ByVal x As Long, ByVal y As Long, ByVal nReserved As Long, ByVal hwnd As Long, ByVal lprc As Any) As Long
Public Declare Function InsertMenu Lib "User32" Alias "InsertMenuA" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpNewItem As Any) As Long
Public Declare Function SetMenuItemBitmaps Lib "User32" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long, ByVal hBitmapUnchecked As Long, ByVal hBitmapChecked As Long) As Long
Public Declare Function GetCursorPos Lib "User32" (lpPoint As POINTAPI) As Long
Public Declare Function GetWindowLong Lib "User32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Public Declare Function SetWindowLong Lib "User32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Function CallWindowProc Lib "User32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function GetLocaleInfo Lib "kernel32" Alias "GetLocaleInfoA" (ByVal Locale As Long, ByVal LCType As Long, ByVal lpLCData As String, ByVal cchData As Long) As Long
Public Declare Function SetLocaleInfo Lib "kernel32" Alias "SetLocaleInfoA" (ByVal Locale As Long, ByVal LCType As Long, ByVal lpLCData As String) As Long
Public Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Public Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

'Para determinar si un comando de consola termino (sincronizar)
Public Const PROCESS_QUERY_INFORMATION = &H400
Public Const STILL_ACTIVE = &H103
Public Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess&, ByVal bInheritHandle&, ByVal dwProcessId&) As Long
Public Declare Function GetExitCodeProcess Lib "kernel32" (ByVal hProcess As Long, lpExitCode As Long) As Long

Public Const MAX_COMPUTERNAME_LENGTH As Long = 31

Public Const GWL_WNDPROC = (-4)
Public Const GWW_HWNDPARENT = (-8)
Public Const SW_SHOWNORMAL = 1
Public Const SWP_NOMOVE = 2
Public Const SWP_NOSIZE = 1
Public Const Flags = SWP_NOMOVE Or SWP_NOSIZE
Public Const HWND_TOPMOST = -1
Public Const HWND_NOTOPMOST = -2

Public Type MENUITEMINFO
   cbSize As Long
   fMask As Long
   fType As Long
   fState As Long
   wID As Long
   hSubMenu As Long
   hbmpChecked As Long
   hbmpUnchecked As Long
   dwItemData As Long
   dwTypeData As String
   cch As Long
End Type

Public Type POINTAPI
    x As Long
    y As Long
End Type

Public Const TPM_BOTTOMALIGN = &H20&
Public Const TPM_CENTERALIGN = &H4&
Public Const TPM_HORIZONTAL = &H0&
Public Const TPM_HORNEGANIMATION = &H800&
Public Const TPM_HORPOSANIMATION = &H400&
Public Const TPM_LEFTALIGN = &H0&
Public Const TPM_LEFTBUTTON = &H0&
Public Const TPM_NOANIMATION = &H4000&
Public Const TPM_NONOTIFY = &H80&
Public Const TPM_RECURSE = &H1&
Public Const TPM_RETURNCMD = &H100&

Public Const MF_BYCommand = &H0&
Public Const MF_CHECKED = &H8&
Public Const MF_APPEND = &H100&
Public Const MF_DISABLED = &H2&
Public Const MF_GRAYED = &H1&
Public Const MF_SEPARATOR = &H800&
Public Const MF_POPUP = &H10&
Public Const MF_MENUBARBREAK = &H20& ' columns with a separator line
Public Const MF_MENUBREAK = &H40&    ' columns w/o a separator line
Public Const MF_STRING = &H0&
Public Const MF_HELP = &H4000&
Public Const MFS_DEFAULT = &H1000&
Public Const MF_BYPOSITION As Long = &H400&    '<--** tells modifymenu to act on the menu at the specified position

Public Const SM_CYFULLSCREEN As Long = 17&     '<--** height of client area of a maximized window
Public Const SM_CYMENU   As Long = 15&         '<--** height of menu

Public Const MIIM_ID = &H2
Public Const MIIM_SUBMENU = &H4
Public Const MIIM_TYPE = &H10
Public Const MIIM_DATA = &H20

Public Const VK_TAB = &H9
Public Const VK_SHIFT = &H10

'Este es el mensaje enviado por Windows cuando se selecciona un menú
Public Const WM_MENUSELECT = &H11F
Public Const WM_LBUTTONDOWN = &H201
Public Const WM_LBUTTONUP = &H202
Public Const WM_NCLBUTTONDOWN = &HA1
Public Const WM_KEYDOWN = &H100
Public Const WM_SYSCommand = &H112
Public Const WM_Command = &H111
Public Const WM_CLOSE = &H10
Public Const WM_EXITMENULOOP = &H212

'Constantes para el manejo del regional setting
Public Const LOCALE_USER_DEFAULT = 1024 'local Machine User
Public Const LOCALE_SCURRENCY = 20 ' local monetary symbol
Public Const LOCALE_SINTLSYMBOL = 21 ' intl monetary symbol
Public Const LOCALE_SMONDECIMALSEP = 22 ' monetary decimal separator
Public Const LOCALE_SMONTHOUSANDSEP = 23 ' monetary thousand separator
Public Const LOCALE_SMONGROUPING = 24 ' monetary grouping
Public Const LOCALE_ICURRDIGITS = 25 ' # local monetary digits
Public Const LOCALE_SDECIMAL = &HE ' decimal separator
Public Const LOCALE_STHOUSAND = &HF ' thousand separator

'Esto es para ampliar el ancho de los datacombo cuando se despliegan
Private Type RECT
Left As Long
Top As Long
Right As Long
Bottom As Long
End Type

Private Declare Function FindWindow Lib "user32.dll" Alias "FindWindowA" ( _
ByVal lpClassName As String, _
ByVal lpWindowName As String) As Long

Private Declare Function GetWindowRect Lib "user32.dll" ( _
ByVal hwnd As Long, _
ByRef lpRect As RECT) As Long

Private Declare Function MoveWindow Lib "user32.dll" ( _
ByVal hwnd As Long, _
ByVal x As Long, _
ByVal y As Long, _
ByVal nWidth As Long, _
ByVal nHeight As Long, _
ByVal bRepaint As Long) As Long

Public Function SetDataComboDropdownListWidth(ByVal ListWidth As Long) As Boolean
Dim Rc As RECT
Dim hListado As Long

hListado = FindWindow("DataComboListWndClass", vbNullString)
If hListado <> 0 Then
If GetWindowRect(hListado, Rc) <> 0 Then
SetDataComboDropdownListWidth = 0 <> MoveWindow(hListado, Rc.Left, Rc.Top, ListWidth, Rc.Bottom - Rc.Top, 1&)
End If
End If
End Function
'***********************


