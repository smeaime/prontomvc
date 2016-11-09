VERSION 5.00
Begin VB.UserControl vbalGrid 
   ClientHeight    =   3600
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   3600
   ScaleWidth      =   4800
   ToolboxBitmap   =   "vbalGrid.ctx":0000
   Begin VB.PictureBox picImage 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   1920
      Left            =   1980
      ScaleHeight     =   1920
      ScaleWidth      =   1920
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   900
      Visible         =   0   'False
      Width           =   1920
   End
End
Attribute VB_Name = "vbalGrid"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Description = "vbAccelerator Grid Control"
Option Explicit

' ======================================================================================
' Name:     vbAccelerator S-Grid Control
' Author:   Steve McMahon (steve@vbaccelerator.com)
' Date:     22 December 1998
'
' Requires: SSUBTMR.DLL
'           cScrollBars.cls
'           cShellSort.cls
'           mGDI.bas
'           HeaderControl.ctl
'
' Copyright � 1998-2003 Steve McMahon for vbAccelerator
' --------------------------------------------------------------------------------------
' Visit vbAccelerator - advanced free source code for VB programmers
' http://vbaccelerator.com
' -------------------------------------------------------------7------------------------
'
' A serious VB grid control.  Can be used to replace the ListView and MSFlexGrid, and
' can emulate the Outlook message list view.
'
' Features:
'
'  * Drag-drop columns
'  * Visible or invisible columns
'  * Row height can be set independently for each row
'  * MS Common Controls or vbAccelerator ImageList support
'  * Up to two icons per cell (e.g. a check box and a standard icon)
'  * Indent text within any cell
'  * Many cell text formatting options including multi-line text
'  * Independently set BackColor,ForeColor and Font for each cell
'  * Show/Hide rows to allow filtering options
'  * Show/Hide columns
'  * Scroll bars implemented using true API scroll bars, and support flat/encarta style
'  * Up to 2 billion rows and columns (although practically about 20,000 is the limit)
'  * Full row sorting by up to three columns at once, allows sorting by icon, text,
'    date/time or number.
'  * Tile bitmaps into the grid's background
'  * Autosize columns
'
' Updated 19/10/99
'   * 1) Added hWnd() property (Igor Tur)
'   * 2) Flat Headers (SPM)
'   * 3) Header icons now works when no text set (Igor Tur)
'   * 4) ClearSelection method
'   * 5) EnsureVisible method
'   * 6) Prevented scroll bar edges from being visible in a new grid (see UserControl_Show)
'   * 7) Clear RowTextColumn when columns are removed (Rhys Nicholls)
'   * 8) HighlightForeColor and HighlightBackColor Properties (Michael Karathanasis, Igor Tur)
'   * 9) Make sure all header items are persisted (Ricardo Taborda dos Reis)
'   * 10) Allow setting of HeaderHeight (Andreas Claesson)
'   * 11) First column didn't resize correctly when dbl click header (Cuong Nguyen)
'   * 12) GPF when add column with rows present in grid (Marc Scherwinski)
'   * 13) ColumnWidthChanged event (Brian Beatty)
'   * 14) Ensure cells ungray themselves when enable is set back to true, don't draw
'         focus rect when disabled (Ricardo Taborda dos Reis)
'
' Updated 2003-12-08
'   * 1) Added MouseWheel support
'   * 2) CancelEdit now done using a WH_MOUSEHOOK - much more reliable
'   * 3) PreCancelEdit event now offered.
'   * 4) VB6 ImageList support (although not for the header)
'   * 5) Option of separate ImageList for headers
'   * 6) No Horizontal or No Vertical Grid line options
'   * 7) Out of focus highlight colour can be set
'   * 8) Control now draws correctly when it is wider than a single screen
'   * 9) When using left and right keys in row mode, control no longer tries
'        to scroll when the scroll bars are hidden.
'   * 10) Corrected the gap between the borders and selection box, and also
'         the positioning of the focus rectangle.  Borders are more accurately
'         positioned.
'   * 11) Grid fits exactly into the space, rather than having a border
'   * 12) Auto-fill grid lines option
'   * 13) Alternate row back colour option
'   * 14) Outlook-style grouping option with drag-drop grouping of cells
'   * 15) Sorting is now 2 - 10x faster
'   * 16) Inserting and removing rows is 10x faster.
'   * 17) Responds to system colour or display change events
'   * 18) SplitRow property allows a set of rows to be fixed
'         within the grid so they always display
'
'
' Ongoing work:
'
'   * *) Assign auto-edit controls to columns in the grid.  Any control that
'        supports the "Text" property can be used.
'   * *) New virtual mode which works
'   * *) Image processing of background bitmap for selections and highlighting
'   * *) Owner-draw cells
'   * *) Marquee multi-select when not in row-mode
'   * *) Show a checkbox in a cell
'
' FREE SOURCE CODE - ENJOY!
' ======================================================================================
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
    lpvDest As Any, lpvSource As Any, ByVal cbCopy As Long)

Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" ( _
    ByVal lpLibFileName As String) As Long
Private Declare Function FreeLibrary Lib "kernel32" ( _
   ByVal hLibModule As Long) As Long
Private Declare Sub InitCommonControls Lib "comctl32.dll" ()

Private Declare Function GetAsyncKeyState Lib "USER32" (ByVal vKey As Long) As Integer
Private Declare Function GetCursorPos Lib "USER32" (lpPoint As POINTAPI) As Long

Private Declare Function ClientToScreen Lib "USER32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Private Declare Function ScreenToClient Lib "USER32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Private Declare Function IsWindowVisible Lib "USER32" (ByVal hwnd As Long) As Long
Private Declare Function GetParent Lib "USER32" (ByVal hwnd As Long) As Long
Private Declare Function WindowFromPoint Lib "USER32" (ByVal xPoint As Long, ByVal yPoint As Long) As Long
Private Declare Function ChildWindowFromPoint Lib "USER32" (ByVal hWndParent As Long, ByVal xPoint As Long, ByVal yPoint As Long) As Long
Private Declare Function GetDesktopWindow Lib "USER32" () As Long
Private Declare Function GetProp Lib "USER32" Alias "GetPropA" (ByVal hwnd As Long, ByVal lpString As String) As Long
Private Declare Function EnableWindow Lib "USER32" (ByVal hwnd As Long, ByVal fEnable As Long) As Long
Private Declare Function PostMessage Lib "USER32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function ReleaseCapture Lib "USER32" () As Long
Private Declare Function GetSystemMetrics Lib "USER32" (ByVal nIndex As Long) As Long
Private Const SM_CXVSCROLL = 2
Private Const SM_CYHSCROLL = 3

Private Const WM_ACTIVATEAPP = &H1C
Private Const WM_SETTINGCHANGE = &H1A&
Private Const WM_DISPLAYCHANGE = &H7E&
Private Const WM_LBUTTONDOWN = &H201
Private Const WM_MBUTTONDOWN = &H207
Private Const WM_RBUTTONDOWN = &H204
Private Const WM_NCLBUTTONDOWN = &HA1
Private Const WM_NCMBUTTONDOWN = &HA7
Private Const WM_NCRBUTTONDOWN = &HA4
Private Const WM_LBUTTONUP = &H202

Private Declare Function GetWindowLong Lib "USER32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "USER32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Const GWL_EXSTYLE = (-20)
Private Const GWL_STYLE = (-16)
Private Const WS_EX_WINDOWEDGE = &H100
Private Const WS_EX_CLIENTEDGE = &H200
Private Const WS_EX_STATICEDGE = &H20000
Private Const WS_HSCROLL = &H100000
Private Const WS_VSCROLL = &H200000

Private Declare Function SetWindowPos Lib "USER32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Enum ESetWindowPosStyles
    SWP_SHOWWINDOW = &H40
    SWP_HIDEWINDOW = &H80
    SWP_FRAMECHANGED = &H20 ' The frame changed: send WM_NCCALCSIZE
    SWP_NOACTIVATE = &H10
    SWP_NOCOPYBITS = &H100
    SWP_NOMOVE = &H2
    SWP_NOOWNERZORDER = &H200 ' Don't do owner Z ordering
    SWP_NOREDRAW = &H8
    SWP_NOREPOSITION = SWP_NOOWNERZORDER
    SWP_NOSIZE = &H1
    SWP_NOZORDER = &H4
    SWP_DRAWFRAME = SWP_FRAMECHANGED
    HWND_NOTOPMOST = -2
End Enum

Private Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
Private Const BITSPIXEL = 12         '  Number of bits per pixel
Private Declare Function ScrollDC Lib "USER32" (ByVal hdc As Long, ByVal dx As Long, ByVal dy As Long, lprcScroll As RECT, lprcClip As RECT, ByVal hrgnUpdate As Long, lprcUpdate As RECT) As Long
Private Declare Function DrawFocusRect Lib "USER32" (ByVal hdc As Long, lpRect As RECT) As Long
Private Declare Function FrameRect Lib "USER32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long
Private Declare Function DrawTextA Lib "USER32" (ByVal hdc As Long, ByVal lpStr As String, ByVal nCount As Long, lpRect As RECT, ByVal wFormat As Long) As Long
Private Declare Function DrawTextW Lib "USER32" (ByVal hdc As Long, ByVal lpStr As Long, ByVal nCount As Long, lpRect As RECT, ByVal wFormat As Long) As Long
Private Const DT_NOFULLWIDTHCHARBREAK = &H80000
Private Const DT_HIDEPREFIX = &H100000
Private Const DT_PREFIXONLY = &H200000
Private Declare Function GetSysColorBrush Lib "USER32" (ByVal nIndex As Long) As Long
Private Const COLOR_HIGHLIGHT = 13
Private Const COLOR_HIGHLIGHTTEXT = 14
Private Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Private Declare Function FillRect Lib "USER32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long
Private Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Private Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Private Declare Function SetBkMode Lib "gdi32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long
Private Const OPAQUE = 2
Private Const TRANSPARENT = 1
Private Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Private Declare Function InflateRect Lib "USER32" (lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function OffsetRect Lib "USER32" (lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function GetWindowRect Lib "USER32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Declare Function PtInRect Lib "USER32" (lpRect As RECT, ByVal ptX As Long, ByVal ptY As Long) As Long
Private Declare Function GetClientRect Lib "USER32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function CreateFontIndirect Lib "gdi32" Alias "CreateFontIndirectA" (lpLogFont As LOGFONT) As Long

Private Declare Function ImageList_GetIconSize Lib "COMCTL32" (ByVal hImagelist As Long, cx As Long, cy As Long) As Long
Private Declare Function ImageList_GetImageCount Lib "COMCTL32" (ByVal hImagelist As Long) As Long

Private Type POINTAPI
   x As Long
   y As Long
End Type

Private Declare Sub mouse_event Lib "USER32" ( _
   ByVal dwFlags As Long, _
   ByVal dx As Long, ByVal dy As Long, _
   ByVal cButtons As Long, _
   ByVal dwExtraInfo As Long)
Private Const MOUSEEVENTF_ABSOLUTE = &H8000 '  absolute move
Private Const MOUSEEVENTF_LEFTDOWN = &H2 '  left button down
Private Const MOUSEEVENTF_LEFTUP = &H4 '  left button up
Private Const MOUSEEVENTF_MIDDLEDOWN = &H20 '  middle button down
Private Const MOUSEEVENTF_MIDDLEUP = &H40 '  middle button up
Private Const MOUSEEVENTF_MOVE = &H1 '  mouse move
Private Const MOUSEEVENTF_RIGHTDOWN = &H8 '  right button down
Private Const MOUSEEVENTF_RIGHTUP = &H10 '  right button up


Public Enum ECGScrollBarStyles
    ecgSbrRegular = EFSStyleConstants.efsRegular
    ecgSbrEncarta = EFSStyleConstants.efsEncarta
    ecgSbrFlat = EFSStyleConstants.efsFlat
End Enum

Public Enum ECGHdrTextAlignFlags
   ecgHdrTextALignLeft = EHdrTextAlign.HdrTextALignLeft
   ecgHdrTextALignCentre = EHdrTextAlign.HdrTextALignCentre
   ecgHdrTextALignRight = EHdrTextAlign.HdrTextALignRight
End Enum

Public Enum ECGTextAlignFlags
   DT_TOP = &H0&
   DT_LEFT = &H0&
   DT_CENTER = &H1&
   DT_RIGHT = &H2&
   DT_VCENTER = &H4&
   DT_BOTTOM = &H8&
   DT_WORDBREAK = &H10&
   DT_SINGLELINE = &H20&
   DT_EXPANDTABS = &H40&
   DT_TABSTOP = &H80&
   DT_NOCLIP = &H100&
   DT_EXTERNALLEADING = &H200&
   DT_CALCRECT = &H400&
   DT_NOPREFIX = &H800&
   DT_INTERNAL = &H1000&
'#if(WINVER >= =&H0400)
   DT_EDITCONTROL = &H2000&
   DT_PATH_ELLIPSIS = &H4000&
   DT_END_ELLIPSIS = &H8000&
   DT_MODIFYSTRING = &H10000
   DT_RTLREADING = &H20000
   DT_WORD_ELLIPSIS = &H40000
End Enum

Public Enum ECGGridLineMode
   ecgGridStandard = 0
   ecgGridFillControl = 1
End Enum

Public Enum ECGGroupRowState
   ecgCollapsed = 0
   ecgExpanded = 1
End Enum

Public Enum ECGDrawStage
   ecgBeforeAll = 0
   ecgBeforeIconAndText = 10
   ecgAfter = 20
End Enum

' The grid:
Private m_tCells() As tGridCell
Private m_iTotalCellRows As Long
Private m_colGarbageRows As New Collection
Private m_tDefaultCell As tGridCell

' Row and columns and associated info:
Private m_iCols As Long
Private m_iRows As Long
Private m_tRows() As tRowPosition

Private Type tColPosition
   
   lWidth As Long
   lCorrectWidth As Long
   bFixedWidth As Long
   lStartX As Long
   lCellColIndex As Long
   bVisible As Boolean
   bRowTextCol As Boolean
   sKey As String
   sTag As String
   bIncludeInSelect As Boolean
   lHeaderColIndex As Long
   sHeader As String
   iIconIndex As Long
   eTextAlign As ECGHdrTextAlignFlags
   sFmtString As String
   bImageOnRight As Boolean
   eSortType As ECGSortTypeConstants
   eSortOrder As ECGSortOrderConstants
   
   ' 2003-11-26 additions
   bIsGrouped As Boolean
   iGroupOrder As Long
   
   ' 2004-01-10 for future expansion
   bOwnerDraw As Boolean
   
End Type

Private m_tCols() As tColPosition

' Grouping of cells:
Private Type tGroupCells
   iGroupNum As Long
   iRow As Long
   iCol As Long
End Type
Private m_tGroupCells() As tGroupCells

' Sorting:
Private m_cSort As New cGridSortObject

' Selection optimisations for not multi-select:
Private m_iSelRow As Long
Private m_iSelCol As Long
Private m_iLastSelRow As Long
Private m_iLastSelCol As Long

' Defaults:
Private m_lDefaultRowHeight As Long
Private m_lDefaultColumnWidth As Long

' Display fonts:
Private m_Fnt() As StdFont
Private m_hFnt() As Long
Private m_iFontCount As Long

' Drawing area:
Private m_lAvailWidth As Long
Private m_lAvailheight As Long
Private m_lGridWidth As Long
Private m_lGridHeight As Long
Private m_lStartX As Long
Private m_lStartY As Long

' Memory DC for flicker-free (1 row only) - also implements clipping
Private m_hDC As Long
Private m_hBmp As Long
Private m_hBmpOld As Long
Private m_lHeight As Long
Private m_lMaxRowHeight As Long
Private m_lMaxMemDCWidth As Long
Private m_hFntDC As Long
Private m_hFntOldDC As Long

' Background:
Private m_bBitmap As Boolean
Private m_hDCSrc As Long
Private m_lBitmapW As Long
Private m_lBitmapH As Long
Private m_bTrueColor As Boolean

' Icons:
Private m_hIml As Long
' VB6 ImageList support 2003-11-10 (5)
Private m_ptrVb6ImageList As Long
Private m_lIconSizeX As Long
Private m_lIconSizeY As Long
' Separate Header ImageList 2003-11-24
Private m_bHeaderImageListSet As Boolean

' Gridlines:
Private m_bGridLines As Boolean
' 2003-11-26: Switch off horizontal or vertical grid lines
Private m_bNoHorizontalGridLines As Boolean
Private m_bNoVerticalGridLines As Boolean
' 2003-11-26: Grid lines extend to fill control
Private m_eGridLineMode As ECGGridLineMode
Private m_oGridLineColor As OLE_COLOR
Private m_oGridFillLineColor As OLE_COLOR

' Active Colour 19/10/1999 (8)
Private m_oHighlightForeColor As OLE_COLOR
Private m_oHighlightBackColor As OLE_COLOR
' 2003-11-24: NoFocus Colours
Private m_oNoFocusHighlightForeColor As OLE_COLOR
Private m_oNoFocusHighlightBackColor As OLE_COLOR
' 2003-11-27: GroupRow Colours
Private m_oGroupRowBackColor As OLE_COLOR
Private m_oGroupRowForeColor As OLE_COLOR
Private m_oGroupAreaBackColor As OLE_COLOR
' 2003-12-07: Alternate Row BackColor
Private m_oAlternateRowBackColor As OLE_COLOR
' 2003-12-13: Gutter Colour for grouped rows
Private m_oGutterBackColor As OLE_COLOR

Private m_bAlphaBlendSelection As Boolean
Private m_bOutlineSelection As Boolean

' Behaviour:
Private m_bMultiSelect As Boolean
Private m_bMarquee As Boolean
Private WithEvents m_tmrMarquee As CTimer
Attribute m_tmrMarquee.VB_VarHelpID = -1
Private m_lMarqueeStartRow As Long
Private m_lMarqueeStartCol As Long
Private m_lMarqueeEndRow As Long
Private m_lMarqueeEndCol As Long
Private m_bRowMode As Boolean
Private m_bRedraw As Boolean
Private m_bHeader As Boolean
Private m_lSplitRow As Long
Private m_lSplitSeparatorSize As Long
Private m_bStretchLastColumnToFit As Boolean
Private m_lStretchedColumn As Long
Private m_lPtrOwnerDraw As Long

Private WithEvents m_tmrHotTrack As CTimer
Attribute m_tmrHotTrack.VB_VarHelpID = -1
Private m_bHotTrack As Boolean
Private m_lHotTrackRow As Long
Private m_lHotTrackCol As Long

' Control flags
Private m_bInFocus As Boolean
Private m_bDirty As Boolean
Private m_bUserMode As Boolean
Private m_bMouseDown As Boolean

' Edit flags
Private m_bInEdit As Boolean
Private m_bInEndEditInterlock As Boolean
' Store edit row and column 2003-11-10
Private m_iEditRow As Long
Private m_iEditCol As Long
' When window is disabled and control is used as an EXE
' we need to repost the cancel edit event
Private m_bRunningInVBIDE As Boolean
Private m_iRepostMsg As Long
Private m_tRepostPos As POINTAPI
Private m_lRepostShiftState As Long

' Check for WM_SETTINGSCHANGE 2003-12-10
Private m_hWnd As Long
' Check for WM_ACTIVATEAPP 2003-11-10
Private m_hWndParentForm As Long
Private m_bEditable As Boolean
Private m_bSingleClickEdit As Boolean
Private m_bSelChange As Boolean
Private m_bEnabled As Boolean
Private m_bDisableIcons As Boolean
Private m_bHighlightSelectedIcons As Boolean
Private m_bDrawFocusRectangle As Boolean
Private m_bNoOptimiseScroll As Boolean
Private m_bTryToFitGroupRows As Boolean

' "Row Text" Column:
Private m_iRowTextCol As Long
Private m_lRowTextStartCol As Long
Private m_bHasRowText As Boolean
' Search Column:
Private m_iSearchCol As Long
Private m_sSearchString As String

' Scroll bars:
Private WithEvents m_cScroll As cScrollBars
Attribute m_cScroll.VB_VarHelpID = -1
Private m_eScrollStyle As EFSStyleConstants
Private m_bAllowVert As Boolean
Private m_bAllowHorz As Boolean

' Header:
Private WithEvents m_cHeader As cHeaderControl
Attribute m_cHeader.VB_VarHelpID = -1
Private m_cFlatHeader As cFlatHeader
Private m_bHeaderFlat As Boolean

' Add rows on demand
Private m_bAddRowsOnDemand As Boolean
Private m_bInAddRowRequest As Boolean

' Hack for XP Crash with VB6 controls:
Private m_hMod As Long

Public Enum ECGBorderStyle
   ecgBorderStyleNone = 0
   ecgBorderStyle3d = 1
   ecgBorderStyle3dThin = 2
End Enum
Private m_eBorderStyle As ECGBorderStyle

Public Enum ECGSerialiseTypes
   ecgSerialiseSGRID = 0
   ecgSerialiseSGRIDLayout = 1
   ecgSerialiseTextTabNewLine = 2
   ecgSerialiseCSV = 3
End Enum

Public Enum ECGScrollBarTypes
   ecgScrollBarHorizontal
   ecgScrollBarVertical
End Enum

' Events

''' <summary>
''' Raised when a column header is clicked
''' </summary>
''' <param name="lCol">Column index</param>
Public Event ColumnClick(ByVal lCol As Long)
Attribute ColumnClick.VB_Description = "Raised when the user clicks a column."

''' <summary>
''' Raised when a column header's width is about to be changed
''' </summary>
''' <param name="lCol">Column index</param>
''' <param name="lWidth">New width (can be modified)</param>
''' <param name="bCancel">Set to <c>true</c> to cancel the size change.</param>
Public Event ColumnWidthStartChange(ByVal lCol As Long, ByRef lWidth As Long, ByRef bCancel As Boolean)
Attribute ColumnWidthStartChange.VB_Description = "Raised before a column's width is about to be changed."

''' <summary>
''' Raised whilst a column header's width is changing
''' </summary>
''' <param name="lCol">Column index</param>
''' <param name="lWidth">New width (can be modified)</param>
''' <param name="bCancel">Set to <c>true</c> to cancel the size change.</param>
Public Event ColumnWidthChanging(ByVal lCol As Long, ByRef lWidth As Long, ByRef bCancel As Boolean)
Attribute ColumnWidthChanging.VB_Description = "Raised as a column's width is being changed."

''' <summary>
''' Raised when a column header's width has been changed
''' </summary>
''' <param name="lCol">Column index</param>
''' <param name="lWidth">New width (can be modified)</param>
''' <param name="bCancel">Set to <c>true</c> to cancel the size change.</param>
Public Event ColumnWidthChanged(ByVal lCol As Long, ByRef lWidth As Long, ByRef bCancel As Boolean)
Attribute ColumnWidthChanged.VB_Description = "Raised when a column's width has been changed."

''' <summary>
''' Raised when a column header's divider is double clicked
''' </summary>
''' <param name="lCol">Column index</param>
''' <param name="bCancel">Set to <c>true</c> to cancel the size change.</param>
Public Event ColumnDividerDblClick(ByVal lCol As Long, ByRef bCancel As Boolean)
Attribute ColumnDividerDblClick.VB_Description = "Raised when the divider between two columns is double clicked."

''' <summary>
''' Raised when the order of columns has been changed in the control.
''' </summary>
Public Event ColumnOrderChanged()
Attribute ColumnOrderChanged.VB_Description = "Raised when the order of the columns is changed following a drag-drop operation."

''' <summary>
''' Raised when the user right clicks in the header.
''' </summary>
''' <param name="x">x Position of right click</param>
''' <param name="y">y Position of right click</param>
Public Event HeaderRightClick(ByVal x As Single, ByVal y As Single)
Attribute HeaderRightClick.VB_Description = "Raised when the user right clicks on the grid's header."

''' <summary>
''' Raised when the selected cell(s) in the grid change.
''' </summary>
''' <param name="lRow">Most recently selected row</param>
''' <param name="lCol">Most recently selected column</param>
Public Event SelectionChange(ByVal lRow As Long, ByVal lCol As Long)
Attribute SelectionChange.VB_Description = "Raised when the user changes the selected cell."

''' <summary>
''' Raised when the hot item in the grid changes.
''' </summary>
''' <param name="lRow">Most recently hot row, may be zero</param>
''' <param name="lCol">Most recently hot column, may be zero</param>
Public Event HotItemChange(ByVal lRow As Long, ByVal lCol As Long)
Attribute HotItemChange.VB_Description = "Raised when the hot cell or row changes.  Only raised when HotTrack is True."


''' <summary>
''' Raised when the grid identifies that edit mode should
''' be started.  The application should show the edit control
''' over the specified cell if <c>bCancel</c> is not set to
''' <c>true</c>.
''' </summary>
''' <param name="lRow">Row to edit</param>
''' <param name="lCol">Column to edit</param>
''' <param name="iKeyAscii">ASCII code of key that was pressed, or 0 if
''' edit mode was started using the mouse.</param>
''' <param name="bCancel">Set to <c>true</c> to not enter edit mode.</param>
Public Event RequestEdit(ByVal lRow As Long, ByVal lCol As Long, ByVal iKeyAscii As Integer, ByRef bCancel As Boolean)
Attribute RequestEdit.VB_Description = "Raised when the grid has the Editable property set to True and the user's actions request editing of the current cell."


''' <summary>
''' Raised when the grid identifies that edit should be ended. Provides opportunity
''' to validate the data in the cell prior to ending edit mode.
''' </summary>
''' <param name="lRow">Row to edit</param>
''' <param name="lCol">Column to edit</param>
''' <param name="newValue">For future expansion.</param>
''' <param name="bStayInEditMode">Set to <c>true</c> to not stay in edit mode.</param>
Public Event PreCancelEdit(ByVal lRow As Long, ByVal lCol As Long, ByRef newValue As Variant, ByRef bStayInEditMode As Boolean)
Attribute PreCancelEdit.VB_Description = "Raised when the user has taken an action that will cancel an edit operation.  Allows the edit contents to be validated prior to exiting edit mode."

''' <summary>
''' Raised when the edit mode is exited.  The application should hide any edit
''' control in response to this event.  Note: do not attempt to perform validation
''' in response to this event, use <c>PreCancelEdit</c> instead.
''' </summary>
Public Event CancelEdit()

''' <summary>
''' Raised when the user depresses a key in the control.
''' </summary>
''' <param name="KeyCode">Key code that was depressed</param>
''' <param name="Shift">Current shift mask state</param>
''' <param name="bDoDefault">Set to <c>false</c> to prevent the control performing
''' default processing on the key</span>
Public Event KeyDown(KeyCode As Integer, Shift As Integer, bDoDefault As Boolean)
Attribute KeyDown.VB_Description = "Raised when a key is pressed in the control."

''' <summary>
''' Raised when the control converts a KeyDown in the control
''' into a character.
''' </summary>
''' <param name="KeyAscii">Ascii code of the key that was depressed</param>
Public Event KeyPress(KeyAscii As Integer)
Attribute KeyPress.VB_Description = "Raised after the KeyDown event when the key press has been converted to an ASCII code."

''' <summary>
''' Raised when the user releases a key in the control.
''' </summary>
''' <param name="KeyCode">Key code that was released</param>
''' <param name="Shift">Current shift mask state</param>
Public Event KeyUp(KeyCode As Integer, Shift As Integer)
Attribute KeyUp.VB_Description = "Raised when a key is released on the grid."

''' <summary>
''' Raised when the user depresses a mouse button in the control.
''' </summary>
''' <param name="Button">Mouse button that was depressed</param>
''' <param name="Shift">Current shift mask state</param>
''' <param name="X">X position of mouse</param>
''' <param name="Y">Y position of mouse</param>
''' <param name="bDoDefault">Set to <c>false</c> to prevent the control performing
''' default processing on the key</span>
Public Event MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single, bDoDefault As Boolean)
Attribute MouseDown.VB_Description = "Raised when the a mouse button is pressed over the control."

''' <summary>
''' Raised when the user moves the mouse button in the control.
''' </summary>
''' <param name="Button">Mouse button that was depressed</param>
''' <param name="Shift">Current shift mask state</param>
''' <param name="X">X position of mouse</param>
''' <param name="Y">Y position of mouse</param>
Public Event MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Attribute MouseMove.VB_Description = "Raised when the mouse moves over the control, or when the mouse moves anywhere and a mouse button has been pressed over the control."

''' <summary>
''' Raised when the user releases a mouse button in the control.
''' </summary>
''' <param name="Button">Mouse button that was released</param>
''' <param name="Shift">Current shift mask state</param>
''' <param name="X">X position of mouse</param>
''' <param name="Y">Y position of mouse</param>
Public Event MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
Attribute MouseUp.VB_Description = "Raised when a mouse button is released after having been pressed over the control."

''' <summary>
''' Raised when the user double clicks in the control.
''' </summary>
''' <param name="lRow">Row user double clicked in, or 0 if no row.</param>
''' <param name="lCol">Column user double clicked in, or 0 if no row.</param>
Public Event DblClick(ByVal lRow As Long, ByVal lCol As Long)
Attribute DblClick.VB_Description = "Raised when the user double clicks on the grid."

''' <summary>
''' Raised when one of the scroll bars is changed
''' </summary>
''' <param name="eBar">The scroll bar that has been changed</param>
Public Event ScrollChange(ByVal eBar As ECGScrollBarTypes)
Attribute ScrollChange.VB_Description = "Raised when the grid is scrolled."

''' <summary>
''' Raised when a row's grouping state is about to be changed.
''' </summary>
''' <param name="lRow">The group row who's state will be changed.</param>
''' <param name="eNewState">The new state for the row.</param>
''' <param name="bCancel">Set to <c>true</c> to cancel the event.</param>
Public Event RowGroupingStateChange(ByVal lRow As Long, ByVal eNewState As ECGGroupRowState, ByRef bCancel As Boolean)
Attribute RowGroupingStateChange.VB_Description = "Raised when the state of a grouping row changes (between collapsed and expanded)."

Public Event RequestRow(ByVal lRow As Long, ByRef lItemData As Long, ByRef bVisible As Boolean, ByRef lHeight As Long, ByRef bNoMoreRows As Boolean)
Attribute RequestRow.VB_Description = "Raised when a new row is needed and the AddRowsOnDemand property is set to True."
Public Event RequestRowData(ByVal lRow As Long)
Attribute RequestRowData.VB_Description = "Raised after a new row has been added in response to RequestRow when AddRowsOnDemand is set True. Respond by filling in the cells for that row."

Implements ISubclass

Public Sub SaveGridData(ByVal sFile As String)
Attribute SaveGridData.VB_Description = "Saves the grid's data using an internal format.  The data can be reloaded into a grid with the same columns using LoadGridData."
Dim lLenPos As Long
Dim lNowPos As Long
Dim lLen As Long
Dim iFile As Integer

On Error GoTo ErrorHandler

   iFile = FreeFile
   Open sFile For Binary Access Write Lock Read As #iFile

   ' Remove any group rows
   AllowGrouping = False

   ' Write out info that allows us to detect the data
   ' version for future updates
   Put #iFile, , "SGrid002.000.000" ' 16 chars

   ' Space for the length of the data
   lLenPos = Seek(iFile)
   Put #iFile, , lLen

   ' Write the number of rows
   Put #iFile, , m_iRows
   ' And the internal number of allocated cells
   Put #iFile, , m_iTotalCellRows
   ' Garbage row count
   Put #iFile, , m_colGarbageRows.Count

   ' Write the data
   Put #iFile, , m_tRows
   Put #iFile, , m_tCells
   ' Write out the garbage row list
   If (m_colGarbageRows.Count > 0) Then
      Dim v As Variant
      Dim i As Long
      Dim lGarbage() As Long
      ReDim lGarbage(1 To m_colGarbageRows.Count) As Long
      For Each v In m_colGarbageRows
         i = i + 1
         lGarbage(i) = v
      Next
      Put #iFile, , lGarbage
   End If

   ' Write the length
   lNowPos = Seek(iFile)
   lLen = lNowPos - lLenPos - 4
   Seek #iFile, lLenPos
   Put #iFile, , lLen
   Seek #iFile, lNowPos

   Close #iFile
   Exit Sub

ErrorHandler:
Dim sErr As String
Dim lErr As Long
   sErr = Err.Description
   lErr = Err.Number
   On Error Resume Next
   Close #iFile
   Kill sFile
   On Error GoTo 0
   gErr lErr, sErr
   Exit Sub
End Sub

Public Sub LoadGridData(ByVal sFile As String)
Attribute LoadGridData.VB_Description = "Loads data from a grid that was previously saved using SaveGridData."
Dim sSaveVer As String
Dim iFile As Integer

On Error GoTo ErrorHandler

   iFile = FreeFile
   Open sFile For Binary Access Read Lock Write As #iFile

   sSaveVer = Space(16)
   Get #iFile, , sSaveVer

   Clear

   Select Case sSaveVer
   Case "SGrid002.000.000"
      loadGridData_2_0_0 iFile
   Case Else
      Close #iFile
      On Error GoTo 0
      gErr 502, "Unsupported data version"
   End Select

   Close #iFile

   UserControl_Resize

   Exit Sub

ErrorHandler:
Dim sErr As String
Dim lErr As Long
   sErr = Err.Description
   lErr = Err.Number
   On Error Resume Next
   Close #iFile
   On Error GoTo 0
   gErr lErr, sErr
   Exit Sub
End Sub

Private Sub loadGridData_2_0_0(ByVal iFile As Integer)
Dim lLen As Long
Dim iGarbageRows As Long
Dim i As Long

   Get #iFile, , lLen ' Not used by this routine, but could be used for a sanity check

   Get #iFile, , m_iRows ' Number of rows
   If (m_iRows > 0) Then
      Get #iFile, , m_iTotalCellRows ' Number of cells allocated
      Get #iFile, , iGarbageRows ' Number of garbage rows
      ' Prepare the arrays
      ReDim m_tRows(0 To m_iRows) As tRowPosition
      ReDim m_tCells(1 To m_iCols, 1 To m_iTotalCellRows) As tGridCell
      If (iGarbageRows > 0) Then
         ReDim lGarbage(1 To iGarbageRows) As Long
      End If

      ' Read the data
      Get #iFile, , m_tRows
      Get #iFile, , m_tCells

      ' Read the garbage rows
      If (iGarbageRows > 0) Then
         Get #iFile, , lGarbage
         For i = 1 To iGarbageRows
            m_colGarbageRows.Add lGarbage(i)
         Next i
      End If
      
      ' Set max row height:
      m_lMaxRowHeight = m_lDefaultRowHeight
      For i = 1 To m_iRows
         If (m_tRows(i).lHeight > m_lMaxRowHeight) Then
            m_lMaxRowHeight = m_tRows(i).lHeight
         End If
      Next i
      BuildMemDC m_lMaxRowHeight
      
   End If

End Sub

Public Property Get OwnerDrawImpl() As IGridCellOwnerDraw
Attribute OwnerDrawImpl.VB_Description = "Gets/sets the object which implements the IGridCellOwnerDraw interface for this grid, or Nothing if there is no owner draw implementation."
   If Not (m_lPtrOwnerDraw = 0) Then
      Set OwnerDrawImpl = ObjectFromPtr(m_lPtrOwnerDraw)
   End If
End Property
Public Property Let OwnerDrawImpl(impl As IGridCellOwnerDraw)
   pSetOwnerDrawImpl impl
End Property
Public Property Set OwnerDrawImpl(impl As IGridCellOwnerDraw)
   pSetOwnerDrawImpl impl
End Property

Private Sub pSetOwnerDrawImpl(impl As IGridCellOwnerDraw)
   If (impl Is Nothing) Then
      m_lPtrOwnerDraw = 0
   Else
      m_lPtrOwnerDraw = ObjPtr(impl)
   End If
End Sub


' SPM 2003-11-10: use Mouse Hook to identify edit cancellation
Friend Function MouseEvent( _
      ByVal iMsg As Long, _
      ByVal hwnd As Long, _
      ByVal x As Long, _
      ByVal y As Long, _
      ByVal hitTest As Long _
   ) As Boolean
   
   If (iMsg = WM_NCLBUTTONDOWN Or iMsg = WM_NCRBUTTONDOWN Or iMsg = WM_NCMBUTTONDOWN) Then
            
      EndEdit
      If (m_bInEdit) Then
         ' We have requested to cancel the edit.
         MouseEvent = True
      End If
      
   ElseIf (iMsg = WM_RBUTTONDOWN Or iMsg = WM_LBUTTONDOWN Or iMsg = WM_MBUTTONDOWN) Then
      
      ' Check which type of class we are over:
      Dim className As String
      Dim hWndOver As Long
      Dim hWndParent As Long
      Dim hWndDesktop As Long
      Dim hWndChild As Long
      
      hWndDesktop = GetDesktopWindow()
      
      hWndOver = WindowFromPoint(x, y)
      hWndParent = GetParent(hWndOver)
      
      ' The owner of a combo is the desktop
      If Not (hWndOver = hWndDesktop) Then
            
         If (GetProp(hWndOver, MAGIC_END_EDIT_IGNORE_WINDOW_PROP) = 0) Then
            className = WindowClassName(hWndOver)
            
            ' Extra check for ComboLBox probably isn't needed, but menus have a parent 0
            If (InStr(className, "ComboLBox") = 0) And (InStr(className, "#32768") = 0) Then ' second check!
            
               ' Check if the mouse event is within the boundaries of
               ' the cell that is being edited:
               
               Dim pt As POINTAPI
               Dim cursorPos As POINTAPI
               GetCursorPos cursorPos
               LSet pt = cursorPos
               ScreenToClient UserControl.hwnd, pt
               
               Dim tR As RECT
               Dim lWidth As Long
               Dim lHeight As Long
               Dim clickedInCell As Boolean
               Dim lOffsetX As Long
               
               CellBoundary m_iEditRow, m_iEditCol, tR.Left, tR.TOp, lWidth, lHeight
               lOffsetX = m_tCells(m_iEditCol, m_tRows(m_iEditRow).lGridCellArrayRow).lIndent + _
                  (Abs(m_tCells(m_iEditCol, m_tRows(m_iEditRow).lGridCellArrayRow).iIconIndex <> -1) * m_lIconSizeX) + _
                  (Abs(m_tCells(m_iEditCol, m_tRows(m_iEditRow).lGridCellArrayRow).lExtraIconIndex <> -1) * m_lIconSizeX)
               tR.Left = tR.Left \ Screen.TwipsPerPixelX - lOffsetX
               tR.TOp = tR.TOp \ Screen.TwipsPerPixelY
               tR.Right = tR.Left + lWidth \ Screen.TwipsPerPixelX + lOffsetX
               tR.Bottom = tR.TOp + lHeight \ Screen.TwipsPerPixelY
               If (pt.x >= tR.Left And pt.x <= tR.Right) Then
                  If (pt.y >= tR.TOp And pt.y <= tR.Bottom) Then
                     clickedInCell = True
                  End If
               End If
               
               If Not (clickedInCell) Then
                  EndEdit
                  If (m_bInEdit) Then
                     ' We have requested to cancel cancelling the edit.
                     MouseEvent = True
                  Else
                     GetWindowRect m_hWnd, tR
                     If Not (PtInRect(tR, cursorPos.x, cursorPos.y) = 0) Then
                        
                        m_iRepostMsg = iMsg
                        LSet m_tRepostPos = cursorPos
                        
                        Dim bShift As Boolean
                        Dim bAlt As Boolean
                        Dim bCtrl As Boolean
                        
                        bShift = (GetAsyncKeyState(vbKeyShift) <> 0)
                        bAlt = (GetAsyncKeyState(vbKeyMenu) <> 0)
                        bCtrl = (GetAsyncKeyState(vbKeyControl) <> 0)
                        m_lRepostShiftState = Abs(bShift * vbShiftMask) Or Abs(bCtrl * vbCtrlMask) Or Abs(bAlt * vbAltMask)
                        
                     End If
                  End If
               End If
            
            End If
         End If
         
      End If
      
   End If
   
End Function

Public Property Get HideGroupingBox() As Boolean
Attribute HideGroupingBox.VB_Description = "When AllowGrouping is True, Gets/sets whether the drag-drop area for grouping rows is hidden."
   HideGroupingBox = m_cHeader.HideGroupingBox
End Property
Public Property Let HideGroupingBox(ByVal Value As Boolean)
   If Not (m_cHeader.HideGroupingBox = Value) Then
      m_cHeader.HideGroupingBox = Value
      UserControl_Resize
      PropertyChanged "HideGroupingBox"
   End If
End Property

Public Property Get AllowGrouping() As Boolean
Attribute AllowGrouping.VB_Description = "Gets/sets whether the header shows a grouping box to drag header items into."
   AllowGrouping = m_cHeader.AllowGrouping
End Property
Public Property Let AllowGrouping(ByVal Value As Boolean)
Dim bRedraw As Boolean
   If Not (m_cHeader.AllowGrouping = Value) Then
      m_cHeader.AllowGrouping = Value
      If Not (Value) Then
         If (m_bRedraw) Then
            bRedraw = True
            Redraw = False
         End If
         pRemoveGroupingRows
         pSyncHeaderOrder
         pRowVisibility m_lSplitRow + 1
         If (bRedraw) Then
            Redraw = True
         End If
      End If
      UserControl_Resize
      PropertyChanged "AllowGrouping"
   End If
End Property

Public Property Get GroupBoxHintText() As String
Attribute GroupBoxHintText.VB_Description = "Gets/sets the text shown in the column header grouping box when no column headers are grouped."
   GroupBoxHintText = m_cHeader.GroupBoxHintText
End Property
Public Property Let GroupBoxHintText(ByVal sText As String)
   m_cHeader.GroupBoxHintText = sText
   If (m_cHeader.AllowGrouping) Then
      UserControl.Refresh
   End If
   PropertyChanged "GroupBoxHintText"
End Property

Private Function GetParentFormhWNd() As Long
Dim lHWnd As Long
Dim lhWndParent As Long
   lHWnd = UserControl.hwnd
   lhWndParent = GetParent(lHWnd)
   Do While Not (lhWndParent = 0) And Not (IsWindowVisible(lhWndParent) = 0)
      lHWnd = lhWndParent
      lhWndParent = GetParent(lHWnd)
   Loop
   GetParentFormhWNd = lHWnd
   
   ' Detect if we're running in the VB IDE - the Message Loop
   ' works in a different way in the IDE compared to as an EXE.
   ' In an EXE, we need to repost end edit mouse events over the
   ' control once it is re-enabled.  In the EXE, we don't.
   ' Bitch!
Dim sClass As String
   sClass = WindowClassName(lHWnd)
   ' In the IDE, the form's name starts with 'ThunderForm' or 'ThunderMDIForm'.
   ' In EXE, it starts with 'ThunderRT'.  We assume that this message loop
   ' hacking does not occur in other apps, but it may be that it also occurs
   ' in MS Office...
   If InStr(sClass, "ThunderForm") = 1 Or InStr(sClass, "ThunderMDIForm") = 1 Then
      m_bRunningInVBIDE = True
   End If
   
End Function

Public Property Get HighlightSelectedIcons() As Boolean
Attribute HighlightSelectedIcons.VB_Description = "Gets/sets whether icons in selected cells will be highlighted using the selection colour."
   HighlightSelectedIcons = m_bHighlightSelectedIcons
End Property
Public Property Let HighlightSelectedIcons(ByVal bHighlight As Boolean)
   m_bHighlightSelectedIcons = bHighlight
   PropertyChanged "HighlightSelectedIcons"
End Property
Public Property Get DrawFocusRectangle() As Boolean
Attribute DrawFocusRectangle.VB_Description = "Gets/sets whether a focus rectangle (dotted line around the selection) will be shown."
   DrawFocusRectangle = m_bDrawFocusRectangle
End Property
Public Property Let DrawFocusRectangle(ByVal bDraw As Boolean)
   m_bDrawFocusRectangle = bDraw
   PropertyChanged "DrawFocusRectangle"
End Property

Public Property Get Enabled() As Boolean
Attribute Enabled.VB_Description = "Gets/sets whether the grid is enabled or not.  Note the grid can still be read when it is disabled, but cannot be selected or edited."
   Enabled = m_bEnabled
End Property

Public Property Let Enabled(ByVal bState As Boolean)
Dim iRow As Long, iCol As Long
   m_bEnabled = bState
   m_cHeader.Enabled = bState
   If UserControl.Ambient.UserMode Then
      m_bDirty = True
      For iRow = 1 To m_iRows
         For iCol = 1 To m_iCols
            m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
         Next iCol
      Next iRow
      ' 19/10/1999 (14):
      Draw
      UserControl_Paint
   End If
   PropertyChanged "Enabled"
End Property

Public Property Get DisableIcons() As Boolean
Attribute DisableIcons.VB_Description = "Gets/sets whether icons are drawn disabled when the control is disabled."
   DisableIcons = m_bDisableIcons
End Property
Public Property Let DisableIcons(ByVal bState As Boolean)
   m_bDisableIcons = bState
   If Not (m_bEnabled) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "DisableIcons"
End Property

Public Property Get Editable() As Boolean
Attribute Editable.VB_Description = "Gets/sets whether the grid will be editable (i.e. raise RequestEdit events)."
   Editable = m_bEditable
End Property
Public Property Let Editable(ByVal bState As Boolean)
   If Not (m_bEditable = bState) Then
      m_bEditable = bState
      PropertyChanged "Editable"
   End If
End Property
Public Property Get SingleClickEdit() As Boolean
Attribute SingleClickEdit.VB_Description = "Gets/sets whether the control immediately goes into edit mode on selection of a cell when in EditMode.  The default is two-click edit."
   SingleClickEdit = m_bSingleClickEdit
End Property
Public Property Let SingleClickEdit(ByVal bState As Boolean)
   If Not (m_bSingleClickEdit = bState) Then
      m_bSingleClickEdit = bState
      PropertyChanged "SingleClickEdit"
   End If
End Property

Public Property Get SortObject() As cGridSortObject
Attribute SortObject.VB_Description = "Returns a reference to the sort object where grid sorting options can be specified."
   Set SortObject = m_cSort
End Property

Public Sub Sort()
Attribute Sort.VB_Description = "Sorts the grid data according to the options set up in the SortObject."
Dim sKey As String
Dim i As Long
Dim j As Long
Dim bS As Boolean
Dim bResetRedraw As Boolean
Dim iSortRowBefore As Long
   
   If m_iRows > 0 And m_iCols > 0 Then
   
      bResetRedraw = m_bRedraw
      If (bResetRedraw) Then
         m_bRedraw = False
      End If
      
      If (m_iSelRow > 0) And (m_iSelRow <= m_iRows) Then
         If (m_iSelCol > 0) And (m_iSelCol <= m_iCols) Then
            iSortRowBefore = m_tRows(m_iSelRow).lGridCellArrayRow
         End If
      End If
      
      If Not (m_cSort.GridMatch) Then
         '
         pSyncHeaderWithSort
         
         If (m_cHeader.ColumnGroupCount > 0) Then
            pRemoveGroupingRows
         End If
         '
      End If
                  
      m_cSort.SortItems m_tCells(), m_tRows(), m_lSplitRow + 1, m_iRows
      
      m_tRows(m_lSplitRow + 1).lStartY = 0
                  
      If Not (m_cSort.GridMatch) Then
         If (m_cHeader.ColumnGroupCount > 0) Then
            ' put the grouping rows back in
            pAddGroupingRows
         End If
         m_cSort.SetGridMatch
      End If
      
      pRowVisibility m_lSplitRow + 1
      bS = m_bNoOptimiseScroll
      m_bNoOptimiseScroll = True
      m_bDirty = True
            
      If (iSortRowBefore > 0) Then
         m_iSelRow = 0
         For i = 1 To m_iRows
            If (m_tRows(i).lGridCellArrayRow = iSortRowBefore) Then
               m_iSelRow = i
               Exit For
            End If
         Next i
         If (m_iSelRow > 0) Then
            If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
            End If
         End If
      End If
      
      If (bResetRedraw) Then
         m_bRedraw = True
         Draw
      End If
      
      m_bNoOptimiseScroll = bS
   
   Else
      ' That makes the sort somewhat quicker :)
      
   End If
   
End Sub

Private Sub pSyncHeaderWithSort()
Dim iCol As Long
Dim lHeaderCol As Long
Dim iSortCol As Long
Dim iSortOrder As Long

   ' First make sure that there are no orphan group
   ' items, if there are then shuffle
   m_cSort.RemoveGroupBubbles

   ' Now check if the header's grouped items match
   ' up with what's in the sort:
   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lHeaderColIndex > 0) Then
         
         iSortOrder = -1
         lHeaderCol = m_tCols(iCol).lHeaderColIndex - 1
         For iSortCol = 1 To m_cSort.Count
            If (m_cSort.GridColumnArrayIndex(iSortCol) = iCol) Then
               If (m_cSort.GroupBy(iSortCol)) Then
                  iSortOrder = iSortCol - 1
                  Exit For
               End If
            End If
         Next iSortCol
         
         If (m_cHeader.ColumnIsGrouped(lHeaderCol)) Then
            If (m_cHeader.ColumnGroupOrder(lHeaderCol) = iSortOrder) Then
               ' No change for this column
            Else
               If (iSortOrder = -1) Then
                  ' has been removed
                  m_cHeader.ColumnIsGrouped(lHeaderCol) = False
               Else
                  ' has had its order changed
                  m_cHeader.ColumnGroupOrder(lHeaderCol) = iSortOrder
               End If
            End If
         Else
            If (iSortOrder = -1) Then
               ' No change for this column
            Else
               ' has been added as a new group at this order:
               m_cHeader.ColumnIsGrouped(lHeaderCol) = True
               m_cHeader.ColumnGroupOrder(lHeaderCol) = iSortOrder
            End If
         End If
         
      End If
   Next iCol
   
   
End Sub

Public Property Get EvaluateTextHeight( _
      ByVal lRow As Long, _
      ByVal lCol As Long _
   ) As Long
Attribute EvaluateTextHeight.VB_Description = "Determines the ideal height required to display all the cell's text in a cell.  This property is only of any use if the Cell's CellTextAlign property allows multiple lines."
Dim hFntOld As Long
Dim tR As RECT
Dim sCopy As String
Dim iCol As Long, lCCol As Long

   ' Ensure correct font:
   If (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex <> 0) Then
      hFntOld = SelectObject(m_hDC, m_hFnt(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex))
   End If
   
   ' Draw the text, calculating rect:
   If Not IsMissing(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText) Then
      sCopy = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText
      For iCol = 1 To m_iCols
         If (m_tCols(iCol).lCellColIndex = lCol) Then
            lCCol = iCol
            Exit For
         End If
      Next iCol
      If Len(m_tCols(lCCol).sFmtString) > 0 Then
         sCopy = Format$(sCopy, m_tCols(lCCol).sFmtString)
      End If
      tR.Right = m_tCols(lCCol).lWidth - 4 - 2 * Abs(m_bGridLines And Not (m_bNoVerticalGridLines))
      tR.Right = tR.Right - m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lIndent
      If (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iIconIndex >= 0) Then
         tR.Right = tR.Right - m_lIconSizeX - 2
      End If
      If (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lExtraIconIndex >= 0) Then
         tR.Right = tR.Right - m_lIconSizeX - 2
      End If
      DrawText m_hDC, sCopy & vbNullChar, -1, tR, m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).eTextFlags Or DT_CALCRECT
      EvaluateTextHeight = tR.Bottom - tR.TOp
   Else
      ' don't need to do anything:
   End If
   
   If (hFntOld <> 0) Then
      SelectObject m_hDC, hFntOld
      hFntOld = 0
   End If
      
End Property
Public Property Get EvaluateTextWidth( _
      ByVal lRow As Long, _
      ByVal lCol As Long, _
      Optional ByVal bForceNoModify As Boolean = True _
   ) As Long
Attribute EvaluateTextWidth.VB_Description = "Determines the ideal width required to fully display text in a cell."
   EvaluateTextWidth = plEvaluateTextWidth(lRow, lCol, bForceNoModify, 0)
End Property
Private Property Get plEvaluateTextWidth( _
      ByVal lRow As Long, _
      ByVal lCol As Long, _
      ByVal bForceNoModify As Boolean, _
      ByVal lMaxWidth As Long _
   ) As Long
Dim hFntOld As Long
Dim tR As RECT
Dim sCopy As String
Dim sOrig As String
Dim iCol As Long
Dim lCCol As Long
Dim eFlags As ECGTextAlignFlags
Dim lLastRight As Long

   ' Ensure correct font:
   If (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex <> 0) Then
      hFntOld = SelectObject(m_hDC, m_hFnt(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex))
   End If
   
   ' Find the index of lCol in the columns array:
   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lCellColIndex = lCol) Then
         lCCol = iCol
         Exit For
      End If
   Next iCol
   
   ' Evaluate the text in the cell:
   If Not (IsMissing(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText)) And Not IsNull(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText) Then
      sCopy = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText
   End If
   If Len(m_tCols(lCCol).sFmtString) > 0 Then
      sCopy = Format$(sCopy, m_tCols(lCCol).sFmtString)
   End If
   eFlags = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).eTextFlags Or DT_CALCRECT
   
   ' For multi line we specify the right so we get a height:
   If (eFlags And DT_WORDBREAK) = DT_WORDBREAK Then
      tR.Right = m_tCols(lCCol).lWidth
      If (lMaxWidth > tR.Right) Then
         tR.Right = lMaxWidth
      End If
   End If
   If (bForceNoModify) Then
      eFlags = eFlags And Not (DT_WORD_ELLIPSIS Or DT_PATH_ELLIPSIS Or DT_MODIFYSTRING Or DT_END_ELLIPSIS)
   End If
   
   sOrig = sCopy
   DrawText m_hDC, sCopy & vbNullChar, -1, tR, eFlags
   If (eFlags And DT_WORDBREAK) = DT_WORDBREAK Then
      Do While (tR.Bottom > m_tRows(lRow).lHeight)
         sCopy = sOrig
         ' Extend in blocks of 16 until we fit...
         tR.Right = tR.Right + 16
         lLastRight = tR.Right
         DrawText m_hDC, sCopy & vbNullChar, -1, tR, eFlags
         tR.Right = lLastRight
      Loop
   End If
   
   plEvaluateTextWidth = tR.Right - tR.Left
   
   If (hFntOld <> 0) Then
      SelectObject m_hDC, hFntOld
      hFntOld = 0
   End If
   
End Property

Public Property Get RowTextStartColumn() As Long
Attribute RowTextStartColumn.VB_Description = "Gets/sets the column that text in the RowText column will start drawing at."
Attribute RowTextStartColumn.VB_MemberFlags = "400"
   RowTextStartColumn = m_lRowTextStartCol
End Property
Public Property Let RowTextStartColumn(ByVal lColumn As Long)
   m_lRowTextStartCol = lColumn
End Property
Public Property Let DefaultRowHeight(ByVal lHeight As Long)
Attribute DefaultRowHeight.VB_Description = "Gets/sets the height which will be used as a default for rows in the grid."
   m_lDefaultRowHeight = lHeight
   PropertyChanged "DefaultRowHeight"
End Property
Public Property Get DefaultRowHeight() As Long
   DefaultRowHeight = m_lDefaultRowHeight
End Property
Public Property Get Redraw() As Boolean
Attribute Redraw.VB_Description = "Gets/sets whether the grid is redrawn in response to changes.  Set to False whilst setting many properties to increase speed.  Setting to True after it has been False forces a re-draw of the control."
Attribute Redraw.VB_ProcData.VB_Invoke_Property = ";Behavior"
   Redraw = m_bRedraw
End Property
Public Property Let Redraw(ByVal bState As Boolean)
   m_bRedraw = bState
   If (UserControl.Ambient.UserMode) And (bState) Then
      m_bDirty = True
      If (m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox)) Then
         UserControl_Paint
      Else
         Draw
         pResizeHeader
      End If
   End If
   PropertyChanged "Redraw"
End Property
Public Property Get EditRow() As Long
Attribute EditRow.VB_Description = "Returns the index of the row currently being edited, if any."
   EditRow = m_iEditRow
End Property
Public Property Get EditCol() As Long
Attribute EditCol.VB_Description = "Returns the index of the column currently being edited, if any."
   EditCol = m_iEditCol
End Property
Public Property Get SelectionCount() As Long
Attribute SelectionCount.VB_Description = "In row mode; gets the number of selected rows in the grid, otherwise gets the number of selected cells in the grid."
Dim iRow As Long
Dim iCol As Long
Dim iSelCount As Long
   If (m_bMultiSelect) Then
      For iRow = 1 To m_iRows
         For iCol = 1 To m_iCols
            If (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected) Then
               iSelCount = iSelCount + 1
               If (m_bRowMode) Then
                  Exit For
               End If
            End If
         Next iCol
      Next iRow
      SelectionCount = iSelCount
   Else
      SelectionCount = Abs(m_iSelRow > 0 And m_iSelCol > 0)
   End If
End Property
Public Property Get SelectedRowByIndex(ByVal lIndex As Long) As Long
Attribute SelectedRowByIndex.VB_Description = "Gets the row of the selected cell or row with the specified 1-based index.  See also SelectionCount."
Dim iRow As Long
Dim iCol As Long
Dim lSelIndex As Long

   For iRow = 1 To m_iRows
      For iCol = 1 To m_iCols
         If (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected) Then
            lSelIndex = lSelIndex + 1
            If (lIndex = lSelIndex) Then
               SelectedRowByIndex = iRow
               Exit Property
            End If
            If (m_bRowMode) Then
               Exit For
            End If
         End If
      Next iCol
   Next iRow
   
End Property
Public Property Get SelectedColByIndex(ByVal lIndex As Long)
Attribute SelectedColByIndex.VB_Description = "Gets the column of the selected cell with the specified 1-based index.  See also SelectionCount."
Dim iRow As Long
Dim iCol As Long
Dim lSelIndex As Long

   For iRow = 1 To m_iRows
      For iCol = 1 To m_iCols
         If (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected) Then
            lSelIndex = lSelIndex + 1
            If (lIndex = lSelIndex) Then
               SelectedColByIndex = iCol
               Exit Property
            End If
            If (m_bRowMode) Then
               Exit For
            End If
         End If
      Next iCol
   Next iRow

End Property

Public Property Get SelectedRow() As Long
Attribute SelectedRow.VB_Description = "Gets the selected row.  In multi-select mode, this is the most recently selected row."
Attribute SelectedRow.VB_MemberFlags = "400"
   SelectedRow = m_iSelRow
End Property
Public Property Let SelectedRow(ByVal lRow As Long)
Dim iCol As Long
Dim iRow As Long
   If (m_iSelCol = 0) Then
      'm_iSelCol = plGetFirstVisibleColumn()
   End If
   If (lRow > 0) And (lRow <= m_iRows) Then
      m_iSelRow = lRow
      If (m_bMultiSelect) Then
         For iRow = 1 To m_iRows
            For iCol = 1 To m_iCols
               If (m_bRowMode) Then
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> (iRow = m_iSelRow))
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow)
               Else
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected) <> ((iCol = m_iSelCol) And (iRow = m_iSelRow))
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iCol = m_iSelCol) And (iRow = m_iSelRow))
               End If
            Next iCol
         Next iRow
      Else
         pSingleModeSelect
      End If
      If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
         Draw
      End If
   Else
      gErr 9, "Row subscript out of range"
   End If
End Property
Public Property Get HotCol() As Long
Attribute HotCol.VB_Description = "Gets the current Hot column (or 0 if no hot column) when HotTrack is True."
   If (m_bHotTrack) Then
      HotCol = m_lHotTrackCol
   End If
End Property
Public Property Get HotRow() As Long
Attribute HotRow.VB_Description = "Gets the current hot row (or 0 if no hot row) when HotTrack is True."
   If (m_bHotTrack) Then
      HotRow = m_lHotTrackRow
   End If
End Property

Public Property Get SelectedCol() As Long
Attribute SelectedCol.VB_Description = "Gets the selected column.  In multi-select mode, this is the most recently selected column."
Attribute SelectedCol.VB_MemberFlags = "400"
   SelectedCol = m_iSelCol
End Property
Public Property Let SelectedCol(ByVal lCol As Long)
Dim iRow As Long
Dim iCol As Long

   If (lCol > 0) And (lCol <= m_iCols) Then
      m_iSelCol = lCol
      If (m_bMultiSelect) Then
         For iRow = 1 To m_iRows
            For iCol = 1 To m_iCols
               If (m_bRowMode) Then
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> (iRow = m_iSelRow))
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow)
               Else
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected) <> ((iCol = m_iSelCol) And (iRow = m_iSelRow))
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iCol = m_iSelCol) And (iRow = m_iSelRow))
               End If
            Next iCol
         Next iRow
      Else
         pSingleModeSelect
      End If
      If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
         Draw
      End If
   Else
      gErr 9, "Column subscript out of range"
   End If
End Property
Public Property Let ScrollBarStyle(ByVal eStyle As ECGScrollBarStyles)
Attribute ScrollBarStyle.VB_Description = "Gets/sets the style in which scroll bars are drawn.  Flat or Encarta style scroll bars are only supported in systems with COMCTL32.DLL version 4.72 or higher."
   m_eScrollStyle = eStyle
   If Not (m_cScroll Is Nothing) Then
      m_cScroll.Style = eStyle
   End If
   PropertyChanged "ScrollBarStyle"
End Property
Public Property Get ScrollBarStyle() As ECGScrollBarStyles
   ScrollBarStyle = m_eScrollStyle
End Property
Public Property Get CellFormattedText(ByVal lRow As Long, ByVal lCol As Long) As String
Attribute CellFormattedText.VB_Description = "Gets the text of a cell with any formatting string applicable to the cell's column applied."
Dim iCCol As Long
Dim iCol As Long
   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lCellColIndex = lCol) Then
         iCCol = iCol
         Exit For
      End If
   Next iCol
   If Len(m_tCols(iCCol).sFmtString) > 0 Then
      CellFormattedText = Format$(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText, m_tCols(iCCol).sFmtString)
   Else
      CellFormattedText = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText
   End If
End Property
Public Property Get CellText(ByVal lRow As Long, ByVal lCol As Long) As Variant
Attribute CellText.VB_Description = "Gets/sets the text associated with a cell.  This property is a variant allowing you to store Numbers and Dates as well.  In columns which are not visible, it could also be used to store objects. "
   If pbValid(lRow, lCol) Then
      CellText = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText
   End If
End Property
Public Property Let CellText(ByVal lRow As Long, ByVal lCol As Long, ByVal sText As Variant)
Dim bMissing As Boolean
Dim bMissingNew As Boolean
Dim bChanged As Boolean
   If pbValid(lRow, lCol) Then
      bMissing = IsMissing(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText)
      bMissingNew = IsMissing(sText)
      If (bMissing Or bMissingNew) Then
         If Not (bMissing = bMissingNew) Then
            bChanged = True
         End If
      Else
         If Not (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText = sText) Then
            bChanged = True
         End If
      End If
      If (bChanged) Then
         m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).sText = sText
         m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
         Draw
      End If
   End If
End Property
Public Property Get CellTextAlign(ByVal lRow As Long, ByVal lCol As Long) As ECGTextAlignFlags
Attribute CellTextAlign.VB_Description = "Gets/sets the alignment and formatting properties used to draw cell text."
   If pbValid(lRow, lCol) Then
      CellTextAlign = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).eTextFlags
   End If
End Property
Public Property Let CellTextAlign(ByVal lRow As Long, ByVal lCol As Long, ByVal eAlign As ECGTextAlignFlags)
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).eTextFlags = eAlign Or DT_NOPREFIX And Not DT_CALCRECT
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Property

Public Property Get CellIndent(ByVal lRow As Long, ByVal lCol As Long) As Long
Attribute CellIndent.VB_Description = "Gets/sets the horizontal indentation of a cell from the cell's border."
   If pbValid(lRow, lCol) Then
      CellIndent = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lIndent
   End If
End Property
Public Property Let CellIndent(ByVal lRow As Long, ByVal lCol As Long, ByVal lIndent As Long)
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lIndent = lIndent
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Property
Public Property Get CellExtraIcon(ByVal lRow As Long, ByVal lCol As Long) As Long
Attribute CellExtraIcon.VB_Description = "Gets/sets the extra icon for a cell.  This icon will always appear in the leftmost position for the cell.  Set CellExtraIcon to -1 to remove an icon.  CellExtraIcons represent ImageList icon indexes and run from 0 to Count-1."
   If pbValid(lRow, lCol) Then
      CellExtraIcon = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lExtraIconIndex
   End If
End Property
Public Property Let CellExtraIcon(ByVal lRow As Long, ByVal lCol As Long, ByVal lIconIndex As Long)
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lExtraIconIndex = lIconIndex
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Property
Public Property Get CellItemData(ByVal lRow As Long, ByVal lCol As Long) As Long
Attribute CellItemData.VB_Description = "Gets/sets a long value associated with the cell."
   If pbValid(lRow, lCol) Then
      CellItemData = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lItemData
   End If
End Property
Public Property Let CellItemData(ByVal lRow As Long, ByVal lCol As Long, ByVal lItemData As Long)
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lItemData = lItemData
   End If
End Property
Public Property Get CellSelected(ByVal lRow As Long, ByVal lCol As Long) As Boolean
Attribute CellSelected.VB_Description = "Gets/sets whether a cell is selected or not."
   If pbValid(lRow, lCol) Then
      CellSelected = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bSelected
   End If
End Property
Public Property Let CellSelected(ByVal lRow As Long, ByVal lCol As Long, ByVal bState As Boolean)
Dim iInitSelCol As Long
Dim iInitSelRow As Long
Dim iCol As Long
   If pbValid(lRow, lCol) Then
      ' for single select mode, bstate is ignored.
      If (m_bMultiSelect) Then
         iInitSelCol = m_iSelCol
         iInitSelRow = m_iSelRow
         m_iSelRow = lRow
         m_iSelCol = lCol
         If (m_bRowMode) Then
            For iCol = 1 To m_iCols
               m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected <> bState)
               m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = bState
            Next iCol
         Else
            m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected <> bState)
            m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = bState
         End If
         Draw
      Else
         iInitSelCol = m_iSelCol
         iInitSelRow = m_iSelRow
         m_iSelRow = lRow
         m_iSelCol = lCol
         pSingleModeSelect
         If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
            Draw
         End If
         If (iInitSelCol <> m_iSelCol) Or (iInitSelRow <> m_iSelRow) Then
            RaiseEvent SelectionChange(m_iSelRow, m_iSelCol)
         End If
      End If
   End If
End Property

Public Property Get CellIcon(ByVal lRow As Long, ByVal lCol As Long) As Long
Attribute CellIcon.VB_Description = "Gets/sets the icon for a cell.  If the cell has an icon set via the CellExtraIcon property, this icon will appear after it.  Set CellIcon to -1 to remove an icon.  CellIcons represent ImageList icon indexes and run from 0 to Count-1."
   If pbValid(lRow, lCol) Then
      CellIcon = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iIconIndex
   End If
End Property
Public Property Let CellIcon(ByVal lRow As Long, ByVal lCol As Long, ByVal lIconIndex As Long)
   If pbValid(lRow, lCol) Then
      If Not (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iIconIndex = lIconIndex) Then
         m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iIconIndex = lIconIndex
         m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
         Draw
      End If
   End If
End Property
Public Property Get CellBackColor(ByVal lRow As Long, ByVal lCol As Long) As OLE_COLOR
Attribute CellBackColor.VB_Description = "Gets/sets the background colour for a cell.  Set to -1 to make the cell transparent."
   If pbValid(lRow, lCol) Then
      CellBackColor = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).oBackColor
   End If
End Property
Public Property Let CellBackColor(ByVal lRow As Long, ByVal lCol As Long, ByVal oColor As OLE_COLOR)
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).oBackColor = oColor
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Property
Public Property Get CellForeColor(ByVal lRow As Long, ByVal lCol As Long) As OLE_COLOR
Attribute CellForeColor.VB_Description = "Gets/sets the foreground colour to draw a cell in.  Set to -1 to use the default foreground colour."
   If pbValid(lRow, lCol) Then
      CellForeColor = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).oForeColor
   End If
End Property
Public Property Let CellForeColor(ByVal lRow As Long, ByVal lCol As Long, ByVal oColor As OLE_COLOR)
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).oForeColor = oColor
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Property
Public Sub CellDefaultForeColor(ByVal lRow As Long, ByVal lCol As Long)
Attribute CellDefaultForeColor.VB_Description = "Sets a cell to use the default foreground colour (the fore colour of the control)."
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).oForeColor = CLR_NONE
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Sub
Public Sub CellDefaultBackColor(ByVal lRow As Long, ByVal lCol As Long)
Attribute CellDefaultBackColor.VB_Description = "Sets a cell to use the default background colour (transparent)."
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).oBackColor = CLR_NONE
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Sub

Public Property Get CellFont(ByVal lRow As Long, ByVal lCol As Long) As StdFont
Attribute CellFont.VB_Description = "Gets/sets the font to use to draw a cell."
   If pbValid(lRow, lCol) Then
      If (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex = 0) Then
         Set CellFont = UserControl.Font
      Else
         Set CellFont = m_Fnt(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex)
      End If
   End If
End Property
Public Property Let CellFont(ByVal lRow As Long, ByVal lCol As Long, ByVal sFnt As StdFont)
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex = plAddFontIfRequired(sFnt)
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Property
Public Sub CellDefaultFont(ByVal lRow As Long, ByVal lCol As Long)
Attribute CellDefaultFont.VB_Description = "Sets a cell to use the default font."
   If pbValid(lRow, lCol) Then
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex = 0
      m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
      Draw
   End If
End Sub
Public Property Get MultiSelect() As Boolean
Attribute MultiSelect.VB_Description = "Gets/sets whether multiple grid cells or rows can be selected or not."
Attribute MultiSelect.VB_ProcData.VB_Invoke_Property = ";Behavior"
   MultiSelect = m_bMultiSelect
End Property
Public Property Let MultiSelect(ByVal bState As Boolean)
Dim iCol As Long
Dim iRow As Long
   If (bState <> m_bMultiSelect) Then
      If Not (bState) Then
         For iRow = 1 To m_iRows
            For iCol = 1 To m_iCols
               If (m_bRowMode) Then
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> (iRow = m_iSelRow))
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow)
               Else
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> ((iRow = m_iSelRow) And (iCol = m_iSelCol)))
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol))
               End If
            Next iCol
         Next iRow
      End If
   End If
   m_bMultiSelect = bState
   m_bMarquee = bState
   Draw
   PropertyChanged "MultiSelect"
End Property

Public Property Get SplitRow() As Long
Attribute SplitRow.VB_Description = "Gets/sets the index of the row to split the grid at.  Set to 0 for no split."
   SplitRow = m_lSplitRow
End Property
Public Property Let SplitRow(ByVal lRow As Long)
   If Not (m_lSplitRow = lRow) Then
      m_lSplitRow = lRow
      pResizeHeader
      If (m_iRows > m_lSplitRow) Then
         m_tRows(m_lSplitRow + 1).lStartY = 0
         pRowVisibility m_lSplitRow + 1
      End If
      UserControl_Paint
   End If
End Property
Public Property Get SplitSeparatorSize() As Long
Attribute SplitSeparatorSize.VB_Description = "Gets/sets the height of the separator between rows before SplitRow and rows after."
   SplitSeparatorSize = m_lSplitSeparatorSize
End Property
Public Property Let SplitSeparatorSize(ByVal lSize As Long)
   If Not (m_lSplitSeparatorSize = lSize) Then
      m_lSplitSeparatorSize = lSize
      pResizeHeader
      Draw
      PropertyChanged "SplitSeparatorSize"
   End If
End Property

Private Function plSplitSize() As Long
   If (m_lSplitRow > 0) Then
      Dim lSplitSize As Long
      Dim iRow As Long
      For iRow = 1 To m_lSplitRow
         If (iRow < m_iRows) Then
            lSplitSize = lSplitSize + m_tRows(iRow).lHeight
         Else
            lSplitSize = lSplitSize + m_lDefaultRowHeight
         End If
      Next iRow
      plSplitSize = lSplitSize + m_lSplitSeparatorSize
   End If
End Function

Public Property Get RowMode() As Boolean
Attribute RowMode.VB_Description = "Gets/sets whether cells can be selected in the grid (False) or rows (True)."
Attribute RowMode.VB_ProcData.VB_Invoke_Property = ";Behavior"
   RowMode = m_bRowMode
End Property
Public Property Let RowMode(ByVal bState As Boolean)
Dim iCol As Long
Dim iRow As Long
Dim bSelRow As Boolean
   m_bRowMode = bState
   If Not (m_bMultiSelect) Then
      If (m_iSelRow > 0) And (m_iSelCol > 0) Then
         For iCol = 1 To m_iCols
            m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
            If (bState) Then
               m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = True
            Else
               m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = (iCol = m_iSelCol)
            End If
         Next iCol
      End If
   Else
      If (bState) Then
         For iRow = 1 To m_iRows
            For iCol = 1 To m_iCols
               If (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected) Then
                  bSelRow = True
                  Exit For
               End If
            Next iCol
            If (bSelRow) Then
               For iCol = 1 To m_iCols
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = True
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
               Next iCol
            End If
         Next iRow
      End If
   End If
   m_bDirty = True
   Draw
   PropertyChanged "RowMode"
End Property
Public Property Get RowIsGroup(ByVal lRow As Long) As Boolean
Attribute RowIsGroup.VB_Description = "Gets/sets whether a row should be regarded as a group row."
   If (lRow > 0) And (lRow <= m_iRows) Then
      RowIsGroup = m_tRows(lRow).bGroupRow
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Get RowGroupingState(ByVal lRow As Long) As ECGGroupRowState
Attribute RowGroupingState.VB_Description = "Gets/sets the state (expanded or collapsed) for a grouping row."
   If (lRow > 0) And (lRow <= m_iRows) Then
      If (m_tRows(lRow).bGroupRow) Then
         If (lRow < m_iRows) Then
            If (m_tRows(lRow + 1).bCollapsed) Then
               RowGroupingState = ecgCollapsed
            Else
               RowGroupingState = ecgExpanded
            End If
         End If
      Else
         gErr 501, "The selected row is not a grouping row."
      End If
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Let RowGroupingState(ByVal lRow As Long, ByVal eState As ECGGroupRowState)
Dim eCurrentState As ECGGroupRowState
   If (lRow > 0) And (lRow <= m_iRows) Then
      If (m_tRows(lRow).bGroupRow) Then
         If (lRow < m_iRows) Then
            If (m_tRows(lRow + 1).bCollapsed) Then
               eCurrentState = ecgCollapsed
            Else
               eCurrentState = ecgExpanded
            End If
            If Not (eCurrentState = eState) Then
               pExpandCollapseGroupingRow lRow
            End If
         End If
      Else
         gErr 501, "The selected row is not a grouping row."
      End If
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Get RowGroupingLevel(ByVal lRow As Long) As Long
Attribute RowGroupingLevel.VB_Description = "Gets the grouping level of the specified row if the row is a group row.  The grouping level specifies how far this group row is indented, with level 1 being the first group, 2 being the second and so on."
Dim lMax As Long
   If (lRow > 0) And (lRow < m_iRows) Then
      lMax = m_cHeader.ColumnGroupCount
      If (lMax = 0) Then
         RowGroupingLevel = 0
      Else
         If (m_tRows(lRow).lGroupIndentLevel > 0) Then
            RowGroupingLevel = m_tRows(lRow).lGroupIndentLevel
         Else
            RowGroupingLevel = lMax
         End If
      End If
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Get RowGroupStartColumn(ByVal lRow As Long) As Long
Attribute RowGroupStartColumn.VB_Description = "Gets/sets the row at which the grouped column's cells start drawing."
   If (lRow > 0) And (lRow <= m_iRows) Then
      RowGroupStartColumn = m_tRows(lRow).lGroupStartColIndex
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Let RowGroupStartColumn(ByVal lRow As Long, ByVal lColumn As Long)
Dim iCol As Long
   If (lRow > 0) And (lRow <= m_iRows) Then
      If m_tRows(lRow).lGroupStartColIndex <> lColumn Then
         m_tRows(lRow).lGroupStartColIndex = lColumn
         For iCol = 1 To m_iCols
            m_tCells(iCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
         Next iCol
         Draw
      End If
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Get GridLines() As Boolean
Attribute GridLines.VB_Description = "Gets/sets whether grid-lines are drawn or not."
Attribute GridLines.VB_ProcData.VB_Invoke_Property = ";Appearance"
   GridLines = m_bGridLines
End Property
Public Property Let GridLines(ByVal bState As Boolean)
   m_bDirty = Not (bState = m_bGridLines)
   m_bGridLines = bState
   If (m_bDirty) Then
      Draw
   End If
   PropertyChanged "GridLines"
End Property
Public Property Get NoVerticalGridLines() As Boolean
Attribute NoVerticalGridLines.VB_Description = "Gets/sets whether vertical grid lines should be supressed when grid lines are on."
   ' 2003-11-26
   NoVerticalGridLines = m_bNoVerticalGridLines
End Property
Public Property Let NoVerticalGridLines(ByVal bState As Boolean)
   ' 2003-11-26
   m_bDirty = (m_bGridLines And (bState <> m_bNoVerticalGridLines))
   m_bNoVerticalGridLines = bState
   If (m_bDirty) Then
      Draw
   End If
   PropertyChanged "NoVerticalGridLines"
End Property
Public Property Get NoHorizontalGridLines() As Boolean
Attribute NoHorizontalGridLines.VB_Description = "Gets/sets whether horizontal grid lines should be supressed when grid lines are on."
   ' 2003-11-26
   NoHorizontalGridLines = m_bNoHorizontalGridLines
End Property
Public Property Let NoHorizontalGridLines(ByVal bState As Boolean)
   ' 2003-11-26
   m_bDirty = (m_bGridLines And (bState <> m_bNoHorizontalGridLines))
   m_bNoHorizontalGridLines = bState
   If (m_bDirty) Then
      Draw
   End If
   PropertyChanged "NoHorizontalGridLines"
End Property
Public Property Get GridLineMode() As ECGGridLineMode
Attribute GridLineMode.VB_Description = "Gets/sets the grid line mode.  The mode can either be standard, in which grid lines are only drawn around cells, or fill, in which case the grid lines fill the control."
   ' 2003-11-26
   GridLineMode = m_eGridLineMode
End Property
Public Property Let GridLineMode(ByVal eMode As ECGGridLineMode)
   ' 2003-11-26
   If Not (m_eGridLineMode = eMode) Then
      m_eGridLineMode = eMode
      If (m_bGridLines) Then
         m_bDirty = True
         Draw
      End If
      PropertyChanged "GridLineMode"
   End If
End Property

Public Property Let HeaderImageList(vThis As Variant)
Attribute HeaderImageList.VB_Description = "Gets/sets an ImageList to associate with the Header control.  By default, the ImageList associated with the control is used."
Dim hImlHeader As Long

   ' Set the ImageList handle property either from a VB
   ' image list or directly:
   If VarType(vThis) = vbObject Then
       ' Assume VB ImageList control.  Note that unless
       ' some call has been made to an object within a
       ' VB ImageList the image list itself is not
       ' created.  Therefore hImageList returns error. So
       ' ensure that the ImageList has been initialised by
       ' drawing into nowhere:
       On Error Resume Next
       ' Get the image list initialised..
       vThis.ListImages(1).Draw 0, 0, 0, 1
       hImlHeader = vThis.hImagelist
       If (Err.Number <> 0) Then
           hImlHeader = 0
       Else
            ' Check for VB6 image list:
            If (TypeName(vThis) = "ImageList") Then
                If (vThis.ListImages.Count <> ImageList_GetImageCount(hImlHeader)) Then
                  ' VB6 Image List is no good
                  gErr 1049, _
                     "Cannot use MSCOMCTL.OCX ImageList for the HeaderImageList."
                  hImlHeader = 0
                End If
            End If
       End If
       On Error GoTo 0
   ElseIf IsNumeric(vThis) Then
      On Error Resume Next
       ' Assume ImageList handle:
       hImlHeader = CLng(vThis)
       If Not (Err.Number = 0) Then
          gErr 1049, "ImageList property expects ImageList object or long hImageList handle."
       End If
   Else
       gErr 1049, "ImageList property expects ImageList object or long hImageList handle."
   End If
    
   ' Set or remove the header image list:
   m_cHeader.SetImageList UserControl.hdc, hImlHeader
   m_bHeaderImageListSet = True

End Property

Public Property Let ImageList(vThis As Variant)
Attribute ImageList.VB_Description = "Sets an ImageList as the source of icons for the control.  The ImageList can be either a VB ImageList, a vbAccelerator ImageList or an API hIml handle.  If it is a VB Image List, the Image List must have had at least one icon in it before using this prop"
Attribute ImageList.VB_ProcData.VB_Invoke_PropertyPut = ";Behavior"
Dim hIml As Long
   
   m_hIml = 0
   m_ptrVb6ImageList = 0

   ' Set the ImageList handle property either from a VB
   ' image list or directly:
   If VarType(vThis) = vbObject Then
       ' Assume VB ImageList control.  Note that unless
       ' some call has been made to an object within a
       ' VB ImageList the image list itself is not
       ' created.  Therefore hImageList returns error. So
       ' ensure that the ImageList has been initialised by
       ' drawing into nowhere:
       On Error Resume Next
       ' Get the image list initialised..
       vThis.ListImages(1).Draw 0, 0, 0, 1
       hIml = vThis.hImagelist
       If (Err.Number <> 0) Then
           hIml = 0
       Else
            ' Check for VB6 image list:
            If (TypeName(vThis) = "ImageList") Then
                If (vThis.ListImages.Count <> ImageList_GetImageCount(hIml)) Then
                    Dim o As Object
                    Set o = vThis
                    m_ptrVb6ImageList = ObjPtr(o)
                End If
            End If
       End If
       On Error GoTo 0
   ElseIf IsNumeric(vThis) Then
      On Error Resume Next
       ' Assume ImageList handle:
       hIml = CLng(vThis)
       If Not (Err.Number = 0) Then
          gErr 1049, "ImageList property expects ImageList object or long hImageList handle."
       End If
   Else
       gErr 1049, "ImageList property expects ImageList object or long hImageList handle."
   End If
    
   ' If we have a valid image list, then associate it with the control:
   If Not (hIml = 0) Or Not (m_ptrVb6ImageList = 0) Then
      m_hIml = hIml
      If Not (m_hIml = 0) Then
         If Not (m_bHeaderImageListSet) Then
            m_cHeader.SetImageList UserControl.hdc, hIml
         End If
      End If
      If (m_ptrVb6ImageList = 0) Then
         ImageList_GetIconSize m_hIml, m_lIconSizeX, m_lIconSizeY
      Else
         m_lIconSizeX = vThis.ImageWidth
         m_lIconSizeY = vThis.ImageHeight
      End If
   End If
   
End Property

Public Property Set BackgroundPicture(sPic As StdPicture)
Attribute BackgroundPicture.VB_Description = "Gets/sets a picture to be used as the grid's background."
Attribute BackgroundPicture.VB_ProcData.VB_Invoke_PropertyPutRef = ";Appearance"
On Error Resume Next
   
   Set picImage.Picture = sPic
   picImage.Refresh
   If (Err.Number <> 0) Or (picImage.ScaleWidth = 0) Or (sPic Is Nothing) Then
      m_hDCSrc = 0
      m_bBitmap = False
   Else
      m_bBitmap = True
      m_hDCSrc = picImage.hdc
      m_lBitmapW = picImage.ScaleWidth \ Screen.TwipsPerPixelX
      m_lBitmapH = picImage.ScaleHeight \ Screen.TwipsPerPixelY
   End If
   m_bDirty = True
   Draw
   
   PropertyChanged "BackgroundPicture"
   
End Property
Public Property Get BackgroundPictureHeight() As Long
Attribute BackgroundPictureHeight.VB_Description = "Gets/sets the height of the background picture."
Attribute BackgroundPictureHeight.VB_ProcData.VB_Invoke_Property = ";Appearance"
Attribute BackgroundPictureHeight.VB_MemberFlags = "400"
   BackgroundPictureHeight = m_lBitmapH
End Property
Public Property Let BackgroundPictureHeight(ByVal lHeight As Long)
   m_lBitmapH = lHeight
   PropertyChanged "BackgroundPictureHeight"
End Property
Public Property Get BackgroundPictureWidth() As Long
Attribute BackgroundPictureWidth.VB_Description = "Gets/sets the width of the background picture."
Attribute BackgroundPictureWidth.VB_ProcData.VB_Invoke_Property = ";Appearance"
Attribute BackgroundPictureWidth.VB_MemberFlags = "400"
   BackgroundPictureWidth = m_lBitmapW
End Property
Public Property Let BackgroundPictureWidth(ByVal lWidth As Long)
   m_lBitmapW = lWidth
   PropertyChanged "BackgroundPictureWidth"
End Property

Public Property Get BackgroundPicture() As StdPicture
   Set BackgroundPicture = picImage.Picture
End Property

Public Property Get AlternateRowBackColor() As OLE_COLOR
Attribute AlternateRowBackColor.VB_Description = "Gets/sets the background colour to use when rendering alternate rows.  Set to -1 to use the standard back colour."
   AlternateRowBackColor = m_oAlternateRowBackColor
End Property
Public Property Let AlternateRowBackColor(ByVal oColor As OLE_COLOR)
   If Not (m_oAlternateRowBackColor = oColor) Then
      m_oAlternateRowBackColor = oColor
      If (m_bRedraw) Then
         m_bDirty = True
         Draw
      End If
      PropertyChanged "AlternateRowBackColor"
   End If
End Property

Public Property Get BackColor() As OLE_COLOR
Attribute BackColor.VB_Description = "Gets/sets the background color of the grid."
Attribute BackColor.VB_ProcData.VB_Invoke_Property = ";Appearance"
Attribute BackColor.VB_UserMemId = -501
   BackColor = UserControl.BackColor
End Property
Public Property Let BackColor(ByVal oColor As OLE_COLOR)
   UserControl.BackColor = oColor
   If (m_hDC <> 0) Then
      SetBkColor m_hDC, TranslateColor(UserControl.BackColor)
   End If
   If (m_bRedraw) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "BackColor"
End Property
Public Property Get HighlightBackColor() As OLE_COLOR
Attribute HighlightBackColor.VB_Description = "Gets/sets the background colour of highlighted cells.  Set to -1 to use the default."
' 19/10/1999 (8)
   HighlightBackColor = m_oHighlightBackColor
End Property
Public Property Let HighlightBackColor(oColor As OLE_COLOR)
' 19/10/1999 (8)
   m_oHighlightBackColor = oColor
   If (m_bRedraw) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "HighlightBackColor"
End Property
Public Property Get HighlightForeColor() As OLE_COLOR
Attribute HighlightForeColor.VB_Description = "Gets/sets the foreground colour of highlighted cells.  Set to -1 to use the default."
' 19/10/1999 (8)
   HighlightForeColor = m_oHighlightForeColor
End Property
Public Property Let HighlightForeColor(oColor As OLE_COLOR)
' 19/10/1999 (8)
   m_oHighlightForeColor = oColor
   If (m_bRedraw) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "HighlightForeColor"
End Property

Public Property Get NoFocusHighlightBackColor() As OLE_COLOR
Attribute NoFocusHighlightBackColor.VB_Description = "Gets/sets the highlight background colour for cells when the grid is out of focus.  Use -1 for the default colour."
' 2003-11-26
   NoFocusHighlightBackColor = m_oNoFocusHighlightBackColor
End Property
Public Property Let NoFocusHighlightBackColor(ByVal oColor As OLE_COLOR)
' 2003-11-26
   m_oNoFocusHighlightBackColor = oColor
   If (m_bRedraw) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "NoFocusHighlightBackColor"
End Property
Public Property Get NoFocusHighlightForeColor() As OLE_COLOR
Attribute NoFocusHighlightForeColor.VB_Description = "Gets/sets the highlight foreground colour for cells when the grid is out of focus.  Use -1 for the default colour."
' 2003-11-26
   NoFocusHighlightForeColor = m_oNoFocusHighlightForeColor
End Property
Public Property Let NoFocusHighlightForeColor(ByVal oColor As OLE_COLOR)
' 2003-11-26
   m_oNoFocusHighlightForeColor = oColor
   If (m_bRedraw) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "NoFocusHighlightForeColor"
End Property

Public Property Get GroupingAreaBackColor() As OLE_COLOR
Attribute GroupingAreaBackColor.VB_Description = "Gets/sets the colour of the column grouping area."
   GroupingAreaBackColor = m_oGroupAreaBackColor
End Property
Public Property Let GroupingAreaBackColor(ByVal oColor As OLE_COLOR)
   m_oGroupAreaBackColor = oColor
   If (m_bRedraw And m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox)) Then
      m_bDirty = True
      UserControl_Paint
   End If
   PropertyChanged "GroupingAreaBackColor"
End Property

Public Property Get GroupingGutterBackColor() As OLE_COLOR
Attribute GroupingGutterBackColor.VB_Description = "Gets/sets the colour used to fill the gutter to the near side of a row which is indented in a group."
   GroupingGutterBackColor = m_oGutterBackColor
End Property
Public Property Let GroupingGutterBackColor(ByVal oColor As OLE_COLOR)
   m_oGutterBackColor = oColor
   If (m_bRedraw And m_cHeader.AllowGrouping) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "GutterBackColor"
End Property

Public Property Get GroupRowBackColor() As OLE_COLOR
Attribute GroupRowBackColor.VB_Description = "Gets/sets the background colour for grouping rows."
   GroupRowBackColor = m_oGroupRowBackColor
End Property
Public Property Let GroupRowBackColor(ByVal oColor As OLE_COLOR)
   m_oGroupRowBackColor = oColor
   If (m_bRedraw And m_cHeader.AllowGrouping And m_cHeader.ColumnGroupCount > 0) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "GroupRowBackColor"
End Property
Public Property Get GroupRowForeColor() As OLE_COLOR
Attribute GroupRowForeColor.VB_Description = "Gets/sets the foreground colour of the text in grouping rows."
   GroupRowForeColor = m_oGroupRowForeColor
End Property
Public Property Let GroupRowForeColor(ByVal oColor As OLE_COLOR)
   m_oGroupRowForeColor = oColor
   If (m_bRedraw And m_cHeader.AllowGrouping And m_cHeader.ColumnGroupCount > 0) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "GroupRowForeColor"
End Property

Public Property Get ForeColor() As OLE_COLOR
Attribute ForeColor.VB_Description = "Gets/sets the foreground color used to draw the control."
Attribute ForeColor.VB_ProcData.VB_Invoke_Property = ";Appearance"
Attribute ForeColor.VB_UserMemId = -513
   ForeColor = UserControl.ForeColor
End Property
Public Property Let ForeColor(ByVal oColor As OLE_COLOR)
   UserControl.ForeColor = oColor
   If (m_hDC <> 0) Then
      SetTextColor m_hDC, TranslateColor(oColor)
   End If
   If (m_bRedraw) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "ForeColor"
End Property
Public Property Get GridLineColor() As OLE_COLOR
Attribute GridLineColor.VB_Description = "Gets/sets the colour used to draw grid lines."
Attribute GridLineColor.VB_ProcData.VB_Invoke_Property = ";Appearance"
   GridLineColor = m_oGridLineColor
End Property
Public Property Let GridLineColor(ByVal oColor As OLE_COLOR)
   m_oGridLineColor = oColor
   If (m_bRedraw) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "GridLineColor"
End Property

Public Property Get GridFillLineColor() As OLE_COLOR
Attribute GridFillLineColor.VB_Description = "Gets the colour used to draw fill grid lines.  Set to -1 to use the default grid line colour."
   GridFillLineColor = m_oGridFillLineColor
End Property
Public Property Let GridFillLineColor(ByVal oColor As OLE_COLOR)
   m_oGridFillLineColor = oColor
   If (m_bRedraw) Then
      m_bDirty = True
      Draw
   End If
   PropertyChanged "GridFillLineColor"
End Property

Public Property Get Font() As StdFont
Attribute Font.VB_Description = "Gets/sets the font used by the control."
Attribute Font.VB_ProcData.VB_Invoke_Property = ";Appearance"
Attribute Font.VB_UserMemId = -512
Dim tLF As LOGFONT
   Set Font = UserControl.Font
End Property
Public Property Set Font(ByVal sFont As StdFont)
Dim tLF As LOGFONT
   
   Set UserControl.Font = sFont
   m_cHeader.SetFont UserControl.hdc, sFont
   If (m_hFntDC <> 0) Then
      If (m_hDC <> 0) Then
         If (m_hFntOldDC <> 0) Then
            SelectObject m_hDC, m_hFntOldDC
         End If
         DeleteObject m_hFntDC
      End If
   End If
   pOLEFontToLogFont sFont, UserControl.hdc, tLF
   m_hFntDC = CreateFontIndirect(tLF)
   If (m_hDC <> 0) Then
      m_hFntOldDC = SelectObject(m_hDC, m_hFntDC)
   End If
   PropertyChanged "Font"
   
End Property

Public Property Get AddRowsOnDemand() As Boolean
Attribute AddRowsOnDemand.VB_Description = "Gets/sets whether the grid is in Virtual Mode (i.e. rows are added as required via the RequestRow and RequestRowData events)."
   AddRowsOnDemand = m_bAddRowsOnDemand
End Property
Public Property Let AddRowsOnDemand(ByVal bAddRowsOnDemand As Boolean)
   m_bAddRowsOnDemand = bAddRowsOnDemand
   If Not m_bAddRowsOnDemand Then
      m_bInAddRowRequest = False
   Else
      m_bInAddRowRequest = True
   End If
   PropertyChanged "AddRowsOnDemand"
End Property

''' <summary>
''' Draws all the dirty cells in the grid.
''' </summary>
Public Sub Draw()
Attribute Draw.VB_Description = "Draws the control."
Dim bDirty As Boolean

   If (m_bRedraw) Then
      ' Draw split row cells:
      If (m_lSplitRow > 0) Then
         bDirty = m_bDirty
         pDraw True
         m_bDirty = bDirty
      End If
      
      ' Draw main grid:
      pDraw False
   End If
   
End Sub

''' <summary>
''' Draws all the dirty cells in the grid.
''' </summary>
''' <param name="bSplitArea">Whether drawing the split area or not</param>
Private Sub pDraw(ByVal bSplitArea As Boolean)

''' TODO this function is hopelessly procedural, it needs to be split
''' up so each cell draws itself.  However, there are issues with
''' making sure the selection is drawn correctly in that case.
''' Not just that, but variables are being reused for other purposes
''' which is pretty rubbish. Bad Boy!  In your bed!

Dim iStartRow As Long
Dim iStartCol As Long
Dim iStartX As Long
Dim iStartY As Long
Dim lRowStartX As Long
Dim lThisRowStartX As Long
Dim lRowEndX As Long
Dim iEndRow As Long
Dim iEndCol As Long
Dim lStartX As Long
Dim lStartY As Long
Dim iEndX As Long
Dim iEndY As Long
Dim iY As Long
Dim iRow As Long
Dim iCol As Long
Dim iCellCol As Long
Dim iCRowTextCol As Long
Dim iFirstColInSelect As Long
Dim iLastColInSelect As Long
Dim tR As RECT
Dim tTR As RECT
Dim tBR As RECT
Dim tFR As RECT
Dim tLR As RECT
Dim tGR As RECT
Dim sText As String
Dim sCopy As String
Dim sHeaderTitle As String
Dim lBltOffset As Long
Dim lBltStart As Long
Dim lBltHeight As Long
Dim hBr As Long
Dim hBrGrid As Long
Dim hBrGridFill As Long
Dim hBrGutter As Long
Dim hFntOld As Long
Dim lLastPos As Long
Dim lOffsetX As Long
Dim lOffsetY As Long
Dim bSel As Boolean
Dim bDoIt As Boolean
Dim bCellSelected As Boolean
Dim bGroupLastDrawn As Boolean
Dim lStartColIndex As Long
Dim lItemData As Long
Dim bVisible As Boolean
Dim bGroupRow As Boolean
Dim bNoMoreRows As Boolean
Dim lHeight As Long
Dim bRecall As Boolean
Dim bDefaultStartCol As Boolean
Dim bHeaderTruncateDraw As Boolean
Dim bAlternateRow As Boolean
Dim lHighlightColor  As Long
Dim bLastSelCol() As Boolean
Dim impl As IGridCellOwnerDraw
Dim cCell As cGridCell
Dim bSkipDefault As Boolean

   ' No redrawing is done unless we are in run mode and
   ' the redraw flag is set:
   If m_bRedraw And m_bUserMode Then
      
      If Not (m_lPtrOwnerDraw = 0) Then
         Set impl = ObjectFromPtr(m_lPtrOwnerDraw)
      End If
      
      
      lStartY = m_lStartY
      
      ' Get the initial offset for the top row of the grid:
      If (m_cHeader.Visible) Then
         lOffsetX = m_cHeader.ColumnGroupCount * m_lDefaultRowHeight
         lOffsetY = m_cHeader.Height + m_cHeader.TOp
      End If
      If (bSplitArea) Then
         lStartY = 0
      Else
         lOffsetY = lOffsetY + plSplitSize()
      End If
      
      
      
      ' Get the size of the control and prepare to draw:
      GetClientRect UserControl.hwnd, tR
      tBR.Right = m_lAvailWidth + 24 + Abs(m_tCols(iStartCol).lStartX - m_lStartX)
      tBR.Bottom = m_lMaxRowHeight
      
      
      ' Ensure the scroll bars are set correctly:
      If pbScrollVisible() Then
         UserControl_Resize
         ' Resize redraws entire control;
         ' no need to do it again
         Exit Sub
      End If
      
      
      
      
      ' Find the start and end of drawing:
      GetStartEndCell _
         bSplitArea, _
         iStartRow, iStartCol, iStartX, iStartY, _
         iEndRow, iEndCol, iEndX, iEndY, bAlternateRow
      If (iEndCol >= iStartCol) Then
         ReDim bLastSelCol(iStartCol To iEndCol) As Boolean
      End If
         
      ' If in add rows on demand mode then we prepare for more rows:
      If (m_bAddRowsOnDemand And m_bInAddRowRequest) Then
         If (iEndY < m_lAvailheight) Then
            iY = iEndY
            Do
               iEndRow = iEndRow + 1
               iY = iY + m_lDefaultRowHeight
            Loop While iY < m_lAvailheight
         End If
      End If
               
      ' Evaluate the default group column start & end:
      lStartColIndex = m_lRowTextStartCol
      bDefaultStartCol = (lStartColIndex = 0)
      For iCol = 1 To m_iCols
         If iFirstColInSelect = 0 Then
            If (m_tCols(iCol).bIncludeInSelect And m_tCols(iCol).bVisible) Then
               iFirstColInSelect = iCol
               iLastColInSelect = iCol
               iCRowTextCol = iCol
               lRowStartX = m_tCols(iCol).lStartX - m_lStartX
               If (m_lRowTextStartCol = 0) Then
                  lStartColIndex = iCol
               End If
            End If
         ElseIf (m_tCols(iCol).bVisible And Not (m_tCols(iCol).bRowTextCol)) Then
            iLastColInSelect = iCol
         End If
         If (m_tCols(iCol).lCellColIndex = lStartColIndex) And Not (bDefaultStartCol) Then
            lRowStartX = m_tCols(iCol).lStartX - m_lStartX
         ElseIf (m_tCols(iCol).lCellColIndex = m_iRowTextCol) Then
            iCRowTextCol = iCol
         ElseIf (m_tCols(iCol).bVisible And m_tCols(iCol).iGroupOrder = -1) Then
            If (m_tCols(iCol).lStartX + m_tCols(iCol).lWidth - m_lStartX) > lRowEndX Then
               lRowEndX = m_tCols(iCol).lStartX + m_tCols(iCol).lWidth - m_lStartX
            End If
         End If
      Next iCol
           
      
      'Set up for grid lines:
      If (m_bGridLines) Then
         If (m_bEnabled) Then
            hBrGrid = CreateSolidBrush(TranslateColor(m_oGridLineColor))
            hBrGridFill = CreateSolidBrush(TranslateColor(m_oGridFillLineColor))
         Else
            hBrGrid = GetSysColorBrush(vbGrayText And &H1F&)
            hBrGridFill = GetSysColorBrush(vbGrayText And &H1F&)
         End If
      End If
      
      ' Text colour for disabled grid:
      If Not (m_bEnabled) Then
         SetTextColor m_hDC, TranslateColor(vbGrayText)
      End If
      
      
      ' Draw the dirty cells:
      For iRow = iStartRow To iEndRow
         
         
         ' Request new row if in add rows on demand mode:
         If (iRow > m_iRows) Then
            If m_iCols > 0 Then
               If (m_bAddRowsOnDemand) Then
                  lHeight = m_lDefaultRowHeight
                  bVisible = True
                  RaiseEvent RequestRow(iRow, lItemData, bVisible, lHeight, bNoMoreRows)
                  If bNoMoreRows Then
                     ' that's it
                     m_bInAddRowRequest = False
                     pbScrollVisible
                     bRecall = True
                     Exit For
                  Else
                     AddRow , lItemData, bVisible, lHeight
                     pbScrollVisible
                     RaiseEvent RequestRowData(iRow)
                  End If
               Else
                  ' This does not occur:
                  Debug.Assert iRow <= m_iRows
                  Exit For
               End If
            Else
               ' Can't do it until cols are set up
               ' 2004-01-14: Removed exit sub here, it caused GDI leak - erk..
            End If
         End If
         
         
         ' If the row should be drawn:
         If (m_tRows(iRow).bVisible) Then
      
            bAlternateRow = Not (bAlternateRow)
            
            tR.TOp = 0
            tR.Bottom = tR.TOp + m_tRows(iRow).lHeight
               
            pFillBackground m_hDC, tBR, 0, m_tRows(iRow).lStartY - lStartY, bAlternateRow
            If Not (m_oGutterBackColor = CLR_NONE) Then
               ' *** not working yet, doh... ***
               'hBrGutter = CreateSolidBrush(TranslateColor(m_oGutterBackColor))
               'LSet tGR = tBR
               'tGR.right = tGR.left + (m_cHeader.ColumnGroupCount - m_tRows(iRow).lGroupIndentLevel + 1) * 16
               'FillRect m_HDC, tGR, hBrGutter
               'DeleteObject hBrGutter
            End If
            
            
            bDoIt = m_bDirty
            If Not (bDoIt) Then
               ' Any dirty cells on this row?
               If m_tRows(iRow).bGroupRow Then
                  If m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag Then
                     bDoIt = True
                     m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = False
                  End If
               Else
                  For iCol = iStartCol To iEndCol
                     iCellCol = m_tCols(iCol).lCellColIndex
                     If m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag Then
                        bDoIt = True
                        m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = False
                     End If
                  Next iCol
               End If
            End If
            
            If (bDoIt) Then
               
               ' Draw individual columns unless this row has the group row style, in
               ' which case we draw only the RowTextColumn.
               If Not (m_tRows(iRow).bGroupRow) Then
                  
                  For iCol = iStartCol To iEndCol
                     
                     If (m_tCols(iCol).bVisible And m_tCols(iCol).iGroupOrder = -1) And Not (iCol = m_iRowTextCol) Then
                        
                        bSkipDefault = False
                        bCellSelected = False
                        iCellCol = m_tCols(iCol).lCellColIndex
                        tR.Left = m_tCols(iCol).lStartX - m_lStartX + m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).lIndent
                        tR.Right = tR.Left + m_tCols(iCol).lWidth - m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).lIndent
                        OffsetRect tR, -1, 0
                        
                        ' 2004-01-15 Owner Draw pre
                        If Not (m_lPtrOwnerDraw = 0) Then
                           Set cCell = cell(iRow, iCellCol)
                           impl.Draw cCell, m_hDC, ecgBeforeAll, tR.Left, tR.TOp, tR.Right, tR.Bottom, bSkipDefault
                        End If
                        
                        If Not (bSkipDefault) Then
                        
                           ' 2004-01-10
                           ' Moving this here ensures that if there is an indent with a background colour
                           ' then the background is correctly filled before the selection starts
                           If (m_bEnabled) Then
                              If Not (m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).oBackColor = CLR_NONE) Then
                                 hBr = CreateSolidBrush(TranslateColor(m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).oBackColor))
                                 LSet tTR = tR
                                 If Not (m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).lIndent = 0) Then
                                    tTR.Left = tTR.Left - m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).lIndent
                                 End If
                                 FillRect m_hDC, tTR, hBr
                                 DeleteObject hBr
                              End If
                              If Not (m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).oForeColor = CLR_NONE) Then
                                 SetTextColor m_hDC, TranslateColor(m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).oForeColor)
                                 bSel = True
                              Else
                                 If (bSel) Then
                                    SetTextColor m_hDC, TranslateColor(UserControl.ForeColor)
                                    bSel = False
                                 End If
                              End If
                           End If
                           
                           ' Draw selection for this cell if that is appropriate
                           If (m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).bSelected) And (m_bEnabled) Then
                              If (m_tCols(iCol).bIncludeInSelect) Or (iCol >= iFirstColInSelect) Then
                              
                                 lHighlightColor = m_oHighlightBackColor
                                 If (m_bInFocus) Or (m_bInEdit) Then
                                    bCellSelected = True
                                 Else
                                    lHighlightColor = m_oNoFocusHighlightBackColor
                                 End If
                                 If (m_bAlphaBlendSelection And m_bTrueColor) Then
                                    If (m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).oBackColor = CLR_NONE) Then
                                       hBr = CreateSolidBrush(BlendColor(lHighlightColor, UserControl.BackColor, 92))
                                    Else
                                       hBr = CreateSolidBrush(BlendColor(lHighlightColor, m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).oBackColor))
                                    End If
                                 Else
                                    hBr = CreateSolidBrush(TranslateColor(lHighlightColor))
                                 End If
                                 
                                 
                                 LSet tTR = tR
                                 If (m_bGridLines) Then
                                    InflateRect tTR, Not (m_bNoVerticalGridLines), Not (m_bNoHorizontalGridLines)
                                 End If
                                 If (m_bRowMode) Then
                                    If (iCol > iFirstColInSelect) Then
                                       tTR.Left = tTR.Left - m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).lIndent
                                    End If
                                 End If
                                 LSet tFR = tTR
                                 
                                 If Not (m_bRowMode) Then
                                    If m_bGridLines And (m_bEnabled) Then
                                       If (iCellCol = m_iSelCol) And (iRow = m_iSelRow) Then
                                          If m_bDrawFocusRectangle Then
                                             LSet tFR = tTR
                                             InflateRect tFR, Not (m_bNoVerticalGridLines), Not (m_bNoHorizontalGridLines)
                                             If Not (m_bNoVerticalGridLines) Then
                                                tFR.Left = tFR.Left - 1
                                             Else
                                                tFR.TOp = tFR.TOp - 1
                                                tFR.Bottom = tFR.Bottom - 1
                                             End If
                                             If Not (m_bNoHorizontalGridLines) Then
                                                tFR.Bottom = tFR.Bottom + 1
                                             End If
                                          End If
                                       End If
                                    End If
                                 Else
                                    If Not (m_bGridLines) Then
                                       tFR.TOp = tFR.TOp - 1
                                    Else
                                       If Not (m_bNoVerticalGridLines) Then
                                          tFR.TOp = tFR.TOp + 1
                                          If (iCol > iFirstColInSelect) Then
                                             tFR.Left = tFR.Left - 1
                                          Else
                                             tFR.Left = tFR.Left + 1
                                          End If
                                          If (iCol >= iLastColInSelect) Then
                                             tFR.Right = tFR.Right - 2
                                          Else
                                             tFR.Right = tFR.Right + 1
                                          End If
                                       End If
                                       If Not (m_bNoHorizontalGridLines) Then
                                          If (m_bNoVerticalGridLines) Then
                                             tFR.Bottom = tFR.Bottom - 2
                                          Else
                                             If (iRow = m_iSelRow) Then
                                                tFR.Bottom = tFR.Bottom - 1
                                             Else
                                                tFR.Bottom = tFR.Bottom + 1
                                             End If
                                          End If
                                       End If
                                    End If
                                 End If
                                 If (bLastSelCol(iCol)) Then
                                    tFR.TOp = tFR.TOp - 4
                                 End If
                                 FillRect m_hDC, tFR, hBr
                                 bLastSelCol(iCol) = True
                                 DeleteObject hBr
                              Else
                                 bLastSelCol(iCol) = False
                              End If
                              
                              bSel = True
                           Else
                              bLastSelCol(iCol) = False
                           End If
                           
                           
                           
                           If (m_bGridLines) Then
                              LSet tTR = tR
                              tTR.Left = tTR.Left - m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).lIndent
                              tTR.Right = tR.Right + 1
                              tTR.Bottom = tR.Bottom + 1
                              If Not (m_bNoHorizontalGridLines Or m_bNoVerticalGridLines) Then
                                 LSet tLR = tTR
                                 OffsetRect tLR, -1, 0
                                 If (iRow < m_iRows) Then
                                    If (m_tRows(iRow + 1).bGroupRow) Then
                                       tLR.Bottom = tLR.Bottom - 1
                                    End If
                                 End If
                                 FrameRect m_hDC, tLR, hBrGrid
                              Else
                                 If (m_bNoHorizontalGridLines) And Not (m_bNoVerticalGridLines) Then
                                    LSet tLR = tTR
                                    tLR.Left = tLR.Right - 2
                                    tLR.Right = tLR.Right - 1
                                    tLR.TOp = tLR.TOp - 1
                                    tLR.Bottom = tLR.Bottom + 1
                                    FillRect m_hDC, tLR, hBrGrid
                                 ElseIf (m_bNoVerticalGridLines) And Not (m_bNoHorizontalGridLines) Then
                                    LSet tLR = tTR
                                    tLR.TOp = tLR.Bottom - 2
                                    tLR.Bottom = tLR.TOp + 1
                                    FillRect m_hDC, tLR, hBrGrid
                                 End If
                              End If
                              LSet tTR = tR
                              InflateRect tTR, -1 + Not (m_bNoVerticalGridLines), -1 + Not (m_bNoVerticalGridLines)
                           Else
                              LSet tTR = tR
                              InflateRect tTR, -1, -1
                           End If
                           
                           
                           
                           If Not (m_bRowMode) Then
                              If (m_bEnabled) Then
                                 If (iCellCol = m_iSelCol) And (iRow = m_iSelRow) Then
                                    pDrawFocusRectangle m_hDC, tFR, iCellCol, iRow, False
                                 ElseIf (m_tCols(iCol).lCellColIndex = m_lHotTrackCol) And (iRow = m_lHotTrackRow) Then
                                    pDrawFocusRectangle m_hDC, tTR, m_tCols(iCol).lCellColIndex, iRow, True
                                 End If
                              End If
                           End If
                           
                           If Not (m_lPtrOwnerDraw = 0) Then
                              impl.Draw cCell, m_hDC, ecgBeforeIconAndText, tTR.Left, tTR.TOp, tTR.Right, tTR.Bottom, bSkipDefault
                           End If
                           
                           If Not (bSkipDefault) Then
                           
                              If (m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).lExtraIconIndex > -1) Then
                                 DrawImage m_hIml, m_ptrVb6ImageList, m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).lExtraIconIndex, m_hDC, tTR.Left, tTR.TOp, m_lIconSizeX, m_lIconSizeY, , m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).bSelected And m_bHighlightSelectedIcons, Not (m_bEnabled) And m_bDisableIcons, m_oHighlightBackColor
                                 tTR.Left = tTR.Left + m_lIconSizeX + 2
                              End If
                              If (m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).iIconIndex > -1) Then
                                 DrawImage m_hIml, m_ptrVb6ImageList, m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).iIconIndex, m_hDC, tTR.Left, tTR.TOp, m_lIconSizeX, m_lIconSizeY, , m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).bSelected And m_bHighlightSelectedIcons, Not (m_bEnabled) And m_bDisableIcons, m_oHighlightBackColor
                                 tTR.Left = tTR.Left + m_lIconSizeX + 2
                              End If
                              If Not (IsMissing(m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).sText)) Then
                                 If (Len(m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).sText) > 0) Then
                                    If Not (m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).iFntIndex = 0) Then
                                       hFntOld = SelectObject(m_hDC, m_hFnt(m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).iFntIndex))
                                    End If
                                    sCopy = m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).sText
                                    If (Len(m_tCols(iCol).sFmtString) > 0) Then
                                       sCopy = Format$(sCopy, m_tCols(iCol).sFmtString)
                                    End If
                                    If bCellSelected Then
                                       ' 19/10/1999 (8): Add no focus color
                                       ' 20/12/2003 : Add custom colours
                                       If (m_bInFocus) Or (m_bInEdit) Then
                                          SetTextColor m_hDC, TranslateColor(m_oHighlightForeColor)
                                       Else
                                          SetTextColor m_hDC, TranslateColor(m_oNoFocusHighlightForeColor)
                                       End If
                                    End If
                                    DrawText m_hDC, sCopy & vbNullChar, -1, tTR, m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).eTextFlags
                                    If bCellSelected Then
                                       SetTextColor m_hDC, TranslateColor(UserControl.ForeColor)
                                    End If
                                    If Len(m_sSearchString) > 0 And m_bEnabled Then
                                       If (iRow = m_iSelRow) And (iCellCol = m_iSearchCol) Then
                                          SetBkMode m_hDC, OPAQUE
                                          SetBkColor m_hDC, TranslateColor(UserControl.BackColor)
                                          SetTextColor m_hDC, TranslateColor(UserControl.ForeColor)
                                          sCopy = Left$(m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).sText, Len(m_sSearchString))
                                          DrawText m_hDC, sCopy & vbNullChar, -1, tTR, m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).eTextFlags
                                          SetBkMode m_hDC, TRANSPARENT
                                       End If
                                    End If
                                    If Not (hFntOld = 0) Then
                                       SelectObject m_hDC, hFntOld
                                       hFntOld = 0
                                    End If
                                 End If
                              End If
                              
                              If Not (m_lPtrOwnerDraw = 0) Then
                                 impl.Draw cCell, m_hDC, ecgAfter, tTR.Left, tTR.TOp, tTR.Right, tTR.Bottom, bSkipDefault
                              End If
                              
                           End If
                           
                        End If
                                    
                     End If
                     
                  Next iCol
                  
               End If
                              
                              
               If (m_bGridLines) And Not (m_bNoHorizontalGridLines) Then
                  ' If grid lines requested ensure we continue them off RHS of the grid:
                  If (tR.Right < m_lAvailWidth + 32) Then
                     
                     If (iRow > m_lSplitRow + 1) Then
                        If (m_tRows(iRow).bGroupRow) Then
                           If (bGroupLastDrawn) Then
                              tLR.Right = lRowEndX + Not (m_bNoVerticalGridLines)
                              tLR.TOp = 0
                              tLR.Bottom = 1
                              tR.Right = tLR.Right
                           End If
                        End If
                     End If
                     lBltOffset = tLR.Bottom
                     tLR.Left = tLR.Right
                     tLR.Right = tLR.Left + (m_lAvailWidth - tR.Right)
                     tLR.Bottom = tLR.TOp + 1
                     
                     FillRect m_hDC, tLR, hBrGridFill
                     
                     If (iRow < m_iRows) Then
                        If (m_tRows(iRow + 1).bGroupRow) Then
                           tLR.TOp = lBltOffset - 1
                           tLR.Bottom = tLR.TOp + 1
                           FillRect m_hDC, tLR, hBrGridFill
                        End If
                     End If
                  End If
               End If
                  
               ' Draw focus rectangle for row mode to cover
               ' all the cells:
               If (m_bRowMode) And Not (m_tRows(iRow).bGroupRow) Then
                  If (iRow = m_iSelRow) Or (iRow = m_lHotTrackRow) Then
                     
                     If (m_bEnabled) Then
                        tTR.TOp = 1
                        tTR.Bottom = tR.Bottom
                        tTR.Left = m_tCols(iFirstColInSelect).lStartX - m_lStartX - 1 + m_tCells(m_tCols(iFirstColInSelect).lCellColIndex, m_tRows(iRow).lGridCellArrayRow).lIndent - 1
                        tTR.Right = tR.Right
                        ' 19/10/1999 (14):
                           
                        LSet tFR = tTR
                        If Not (m_bGridLines) Then
                           tFR.Bottom = tFR.Bottom - 1
                        Else
                           If Not (m_bNoVerticalGridLines) Then
                              If (m_bNoHorizontalGridLines) Then
                              Else
                                 tFR.TOp = tFR.TOp + 1
                              End If
                              tFR.Left = tFR.Left + 1
                              tFR.Right = tFR.Right - 2
                           End If
                           If Not (m_bNoHorizontalGridLines) Then
                              If (m_bNoVerticalGridLines) Then
                                 tFR.Bottom = tFR.Bottom - 2
                              Else
                                 tFR.Bottom = tFR.Bottom - 1
                              End If
                           End If
                        End If
                        pDrawFocusRectangle m_hDC, tFR, 0, iRow, Not (iRow = m_iSelRow)
                     End If
                     
                  End If
               End If
               
               
               ' Draw the grouped cells:
               If (m_bRowMode) Or (m_tRows(iRow).bGroupRow) Then
               
                  bSkipDefault = False
               
                  If Not (m_iRowTextCol = 0) Then
                     LSet tTR = tR
                     If Not m_tRows(iRow).bGroupRow Then
                        tTR.TOp = m_lDefaultRowHeight
                     Else
                        tTR.TOp = 1
                        bSel = False
                     End If
                     lThisRowStartX = lRowStartX
                     If m_tRows(iRow).bGroupRow And Not (m_tRows(iRow).lGroupStartColIndex = 0) Then
                        If (m_tRows(iRow).lGroupIndentLevel > 0) Then
                           lThisRowStartX = -m_lStartX - (m_cHeader.ColumnGroupCount - m_tRows(iRow).lGroupIndentLevel + 1) * m_lDefaultRowHeight
                        Else
                           ' Must evaluate the correct start and end points:
                           For iCol = 1 To m_iCols
                              If m_tCols(iCol).lCellColIndex = m_tRows(iRow).lGroupStartColIndex Then
                                 lThisRowStartX = m_tCols(iCol).lStartX - m_lStartX
                              End If
                           Next iCol
                        End If
                     End If
                     tTR.Left = lThisRowStartX + m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).lIndent
                     tTR.Right = lRowEndX + Not (m_bNoVerticalGridLines)
                     
                     If Not (m_lPtrOwnerDraw = 0) Then
                        Set cCell = cell(iRow, m_iRowTextCol)
                        impl.Draw cCell, m_hDC, ecgBeforeIconAndText, tTR.Left, tTR.TOp, tTR.Right, tTR.Bottom, bSkipDefault
                     End If
                     
                     If Not (bSkipDefault) Then
                     
                        If Not IsMissing(m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).sText) Then
                           sCopy = m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).sText
                        Else
                           sCopy = ""
                        End If
                        If Len(m_tCols(iCRowTextCol).sFmtString) > 0 Then
                           sCopy = Format$(sCopy, m_tCols(iCRowTextCol).sFmtString)
                        End If
                        
                        bCellSelected = False
                        If m_tRows(iRow).bGroupRow Then
                           If m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).bSelected Then
                                                            
                              lHighlightColor = m_oHighlightBackColor
                              If (m_bInFocus) Then
                                 bCellSelected = True
                              Else
                                 lHighlightColor = m_oNoFocusHighlightBackColor
                              End If
                              If (m_bAlphaBlendSelection And m_bTrueColor) Then
                                 If (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oBackColor = CLR_NONE) Then
                                    hBr = CreateSolidBrush(BlendColor(lHighlightColor, UserControl.BackColor, 92))
                                 Else
                                    hBr = CreateSolidBrush(BlendColor(lHighlightColor, m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oBackColor))
                                 End If
                              Else
                                 hBr = CreateSolidBrush(TranslateColor(lHighlightColor))
                              End If
                           
                              FillRect m_hDC, tTR, hBr
                              DeleteObject hBr
                              
                              ' 19/10/1999 (14):
                              'If m_bDrawFocusRectangle And m_bInFocus And m_bEnabled Then
                              '   DrawFocusRect m_hDC, tTR
                              'End If
                              
                              ' 19/10/1999 (8)
                              If (m_bInFocus) Then
                                 SetTextColor m_hDC, TranslateColor(m_oHighlightForeColor)
                              Else
                                 SetTextColor m_hDC, TranslateColor(m_oNoFocusHighlightForeColor)
                              End If
                           Else
                              If Not (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oBackColor = CLR_NONE) Then
                                 hBr = CreateSolidBrush(TranslateColor(m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oBackColor))
                                 FillRect m_hDC, tTR, hBr
                                 DeleteObject hBr
                              End If
                              If Not (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oForeColor = CLR_NONE) Then
                                 SetTextColor m_hDC, TranslateColor(m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oForeColor)
                              Else
                                 SetTextColor m_hDC, TranslateColor(UserControl.ForeColor)
                              End If
                           End If
                        Else
                           If Not (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oBackColor = CLR_NONE) Then
                              hBr = CreateSolidBrush(TranslateColor(m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oBackColor))
                              FillRect m_hDC, tTR, hBr
                              DeleteObject hBr
                           End If
                           If m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).bSelected Then
                              If (m_bInFocus) Then
                                 SetTextColor m_hDC, TranslateColor(m_oHighlightForeColor)
                              Else
                                 SetTextColor m_hDC, TranslateColor(m_oNoFocusHighlightForeColor)
                              End If
                           Else
                              If Not (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oForeColor = CLR_NONE) Then
                                 SetTextColor m_hDC, TranslateColor(m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).oForeColor)
                              End If
                           End If
                        End If
                     
                        If (m_tRows(iRow).bGroupRow) And (bCellSelected Or iRow = m_lHotTrackRow) Then
                           LSet tFR = tTR
                           If Not (iRow = m_iSelRow) Then
                              tFR.TOp = tFR.TOp + 1
                              tFR.Left = tFR.Left + 1
                              tFR.Right = tFR.Right - 1
                              tFR.Bottom = tFR.Bottom - 1
                           End If
                           pDrawFocusRectangle m_hDC, tFR, 0, iRow, Not (iRow = m_iSelRow)
                        End If
                     
                        If Not (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).iFntIndex = 0) Then
                           hFntOld = SelectObject(m_hDC, m_hFnt(m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).iFntIndex))
                        End If
                     
                        If bCellSelected Then
                           ' 19/10/1999 (8) : Add no focus color
                           ' 20/12/2003 : Add custom colours
                           If (m_bInFocus) Then
                              SetTextColor m_hDC, TranslateColor(m_oHighlightForeColor)
                           Else
                              SetTextColor m_hDC, TranslateColor(m_oNoFocusHighlightForeColor)
                           End If
                        End If
                        If (m_tRows(iRow).lGroupIndentLevel = 0) Then
                           If (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).lExtraIconIndex > -1) Then
                              DrawImage m_hIml, m_ptrVb6ImageList, m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).lExtraIconIndex, m_hDC, tTR.Left, tTR.TOp, m_lIconSizeX, m_lIconSizeY, , m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).bSelected And m_bHighlightSelectedIcons, Not (m_bEnabled) And m_bDisableIcons, m_oHighlightBackColor
                              tTR.Left = tTR.Left + m_lIconSizeX + 2
                           End If
                           If (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).iIconIndex > -1) Then
                              DrawImage m_hIml, m_ptrVb6ImageList, m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).iIconIndex, m_hDC, tTR.Left, tTR.TOp, m_lIconSizeX, m_lIconSizeY, , m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).bSelected And m_bHighlightSelectedIcons, Not (m_bEnabled) And m_bDisableIcons, m_oHighlightBackColor
                              tTR.Left = tTR.Left + m_lIconSizeX + 2
                           End If
                           DrawText m_hDC, sCopy, -1, tTR, m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).eTextFlags
                        Else
                           If (iRow < m_iRows) Then
                              DrawOpenCloseGlyph UserControl.hwnd, m_hDC, tTR, m_tRows(iRow + 1).bCollapsed
                           End If
                           tTR.Left = tTR.Left + 16
                           If (m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).lExtraIconIndex > -1) Then
                              DrawImage m_hIml, m_ptrVb6ImageList, m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).lExtraIconIndex, m_hDC, tTR.Left, tTR.TOp, m_lIconSizeX, m_lIconSizeY, , m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).bSelected And m_bHighlightSelectedIcons, Not (m_bEnabled) And m_bDisableIcons, m_oHighlightBackColor
                              tTR.Left = tTR.Left + m_lIconSizeX + 2
                           End If
                           sHeaderTitle = m_tCols(m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).lItemData).sHeader
                           If (Len(sHeaderTitle) > 0) Then
                              If Len(sCopy) > 0 Then
                                 sCopy = sHeaderTitle & ": " & sCopy
                              Else
                                 sCopy = sHeaderTitle
                              End If
                           End If
                           DrawText m_hDC, sCopy, -1, tTR, m_tCells(m_iRowTextCol, m_tRows(iRow).lGridCellArrayRow).eTextFlags
                        End If
                        ' Fix for row getting selection colour after group row:
                        SetTextColor m_hDC, TranslateColor(UserControl.ForeColor)
                        If Not (hFntOld = 0) Then
                           SelectObject m_hDC, hFntOld
                           hFntOld = 0
                        End If
                        
                        If Not (m_lPtrOwnerDraw = 0) Then
                           Set cCell = cell(iRow, m_iRowTextCol)
                           impl.Draw cCell, m_hDC, ecgAfter, tTR.Left, tTR.TOp, tTR.Right, tTR.Bottom, bSkipDefault
                        End If
                        
                     End If
                     
                  End If
                  
               End If
               
               
               ' 2003-11-26 never draw above or behind the header
               bHeaderTruncateDraw = False
               lBltOffset = m_tRows(iRow).lStartY - lStartY + lOffsetY
               If (m_bHeader) And Not (bSplitArea) Then
                  If (lBltOffset < (m_cHeader.TOp + m_cHeader.Height + plSplitSize())) Then
                     BitBlt UserControl.hdc, 0, m_cHeader.TOp + m_cHeader.Height + plSplitSize(), m_lAvailWidth + Abs(m_tCols(iStartCol).lStartX - m_lStartX) + 32, (m_tRows(iRow).lHeight + lBltOffset - m_cHeader.TOp - m_cHeader.Height - plSplitSize()), m_hDC, 0, (m_tRows(iRow).lHeight - (m_tRows(iRow).lHeight + lBltOffset - m_cHeader.TOp - m_cHeader.Height - plSplitSize())), vbSrcCopy
                     bHeaderTruncateDraw = True
                  End If
               End If
               If Not (bHeaderTruncateDraw) Then
                  BitBlt UserControl.hdc, 0, lBltOffset, m_lAvailWidth + Abs(m_tCols(iStartCol).lStartX - m_lStartX) + 32, m_tRows(iRow).lHeight, m_hDC, 0, 0, vbSrcCopy
               End If
               
            End If ' row not dirty
            
            
            
            lLastPos = m_tRows(iRow).lStartY - lStartY + m_tRows(iRow).lHeight
            bCellSelected = False
         
            bGroupLastDrawn = m_tRows(iRow).bGroupRow

         
         End If ' Row visible
         
      Next iRow
      
      
      ' Is there any space left over at the bottom?
      If Not (bSplitArea) Then
      
         tR.Bottom = UserControl.Height \ Screen.TwipsPerPixelY
         If (lLastPos < tR.Bottom) Then
            tR.Left = 0
            tR.TOp = lLastPos + lOffsetY
            tR.Right = m_lAvailWidth + 32
            
            If (m_bGridLines And m_iCols > 0) Then
                  
               ' If we have horizontal grid lines then draw the last grid line:
               If Not (m_bNoHorizontalGridLines) Then
                  iY = tR.Bottom
                  tR.TOp = tR.TOp - 1
                  tR.Bottom = tR.TOp + 1
                  LSet tFR = tR
                  bDoIt = True
                  For iCol = iStartCol To iEndCol
                     If (m_tCols(iCol).bVisible) And Not (m_tCols(iCol).bRowTextCol) Then
                        If (bDoIt) Then
                           tFR.Left = m_tCols(iCol).lStartX - m_lStartX - 1
                           bDoIt = False
                        End If
                        tFR.Right = m_tCols(iCol).lStartX + m_tCols(iCol).lWidth - 1 - m_lStartX
                     End If
                  Next iCol
                  FrameRect UserControl.hdc, tFR, hBrGrid
                  tR.TOp = tR.TOp + 1
                  tR.Bottom = iY
               End If
            
               If (m_eGridLineMode = ecgGridFillControl) Then
                  ' Need more grid lines:
                  If (m_bNoHorizontalGridLines And m_bNoVerticalGridLines) Then
                     ' no we don't :)
                     pFillBackground UserControl.hdc, tR, 0, -(tR.TOp - lOffsetY), False
                  Else
                     iStartY = tR.TOp
                     iEndY = tR.Bottom
                     iEndX = 0
                     For iY = iStartY To iEndY Step m_lDefaultRowHeight
                        LSet tFR = tR
                        tFR.TOp = 0 'iY
                        tFR.Bottom = m_lDefaultRowHeight + 1
                        pFillBackground m_hDC, tFR, 0, iY - lOffsetY, False
                        If (m_bNoVerticalGridLines) Then
                           ' Horizontal lines only
                           FrameRect m_hDC, tFR, hBrGridFill
                        Else
                           For iCol = iStartCol To iEndCol
                              If (m_tCols(iCol).bVisible) And Not (m_tCols(iCol).bRowTextCol) And Not (m_tCols(iCol).bIsGrouped) Then
                                 iCellCol = m_tCols(iCol).lCellColIndex
                                 tFR.Left = m_tCols(iCol).lStartX - m_lStartX
                                 tFR.Right = tFR.Left + m_tCols(iCol).lWidth + 1
                                 OffsetRect tFR, -2, 0
                              
                                 If (m_bNoHorizontalGridLines) Then
                                    ' Vertical lines only
                                    lBltOffset = tFR.Right
                                    tFR.Right = tFR.Left + 1
                                    FrameRect m_hDC, tFR, hBrGridFill
                                    tFR.Left = lBltOffset - 1
                                    tFR.Right = tFR.Left + 1
                                    FrameRect m_hDC, tFR, hBrGridFill
                                 Else
                                    ' both sets
                                    FrameRect m_hDC, tFR, hBrGridFill
                                 End If
                              End If
                              If (tFR.Right > iEndX) Then
                                 iEndX = tFR.Right
                              End If
                           Next iCol
                           tFR.Left = iEndX - 1
                           tFR.Right = tR.Right
                           If Not (m_bNoHorizontalGridLines) Then
                              FrameRect m_hDC, tFR, hBrGridFill
                           End If
                        End If
                        BitBlt UserControl.hdc, 0, iY, m_lAvailWidth + Abs(m_tCols(iStartCol).lStartX - m_lStartX) + 32, m_lDefaultRowHeight, m_hDC, 0, 0, vbSrcCopy
                     Next iY
                  End If
               Else
                  pFillBackground UserControl.hdc, tR, 0, -(tR.TOp - lOffsetY), False
               End If
            Else
               pFillBackground UserControl.hdc, tR, 0, -(tR.TOp - lOffsetY), False
            End If
            
         End If
      End If
      
      
      If (m_bGridLines) Then
         DeleteObject hBrGrid
         DeleteObject hBrGridFill
      End If
      
      If (bSel) Then
         SetTextColor m_hDC, TranslateColor(UserControl.ForeColor)
      End If
      
      m_iLastSelRow = m_iSelRow
      m_iLastSelCol = m_iSelCol
      m_bDirty = False
      
      
      
      ' For AddNewRowsOnDemand mode
      If bRecall Then
         bRecall = False
         m_bDirty = True
         Draw
      End If
      
      
   End If

End Sub

Private Sub pDrawFocusRectangle(ByVal lhDC As Long, tR As RECT, ByVal iCellCol As Long, ByVal iRow As Long, ByVal bHotTrack As Boolean)
Dim hBr As Long
Dim iCol As Long
Dim bSetDirty As Boolean
Dim tRCopy As RECT
   If m_bEnabled Then
      If (bHotTrack) Then
         hBr = CreateSolidBrush(TranslateColor(m_oHighlightBackColor))
         FrameRect lhDC, tR, hBr
         LSet tRCopy = tR
         InflateRect tRCopy, 1, 1
         FrameRect lhDC, tRCopy, hBr
         DeleteObject hBr
         bSetDirty = True
      Else
         If (m_bDrawFocusRectangle And m_bInFocus) Then
            DrawFocusRect lhDC, tR
            bSetDirty = True
         ElseIf (m_bOutlineSelection) Then
            If (m_bInFocus) Then
               hBr = CreateSolidBrush(TranslateColor(m_oHighlightBackColor))
            Else
               If (m_bTrueColor) Then
                  hBr = CreateSolidBrush(BlendColor(m_oHighlightBackColor, m_oNoFocusHighlightBackColor, 64))
               Else
                  hBr = CreateSolidBrush(TranslateColor(m_oNoFocusHighlightBackColor))
               End If
            End If
            FrameRect lhDC, tR, hBr
            If (m_lHotTrackRow = iRow) And (m_bRowMode Or (m_iSelCol = m_lHotTrackCol)) Then
               LSet tRCopy = tR
               InflateRect tRCopy, -1, -1
               FrameRect lhDC, tRCopy, hBr
            End If
            DeleteObject hBr
            bSetDirty = True
         End If
      End If
      
      If (bSetDirty) Then
         If (iCellCol = 0) Then
            For iCol = 1 To m_iCols
               m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
            Next iCol
         Else
            m_tCells(iCellCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
         End If
      End If
      
   End If
   
End Sub

''' <summary>
''' Fills the specified rectangle with the background.
''' This may either be a bitmap or the background colour,
''' which can vary depending on whether the alternate
''' row colour mode is selected.
''' </summary>
''' <param name="lhDC">Device context to draw into</param>
''' <param name="tR">Bounding rectangle to fill</param>
''' <param name="lOffsetX">Horizontal offset from top-left of grid for use when
''' rendering a bitmap</param>
''' <param name="lOffsetY">Vertical offset from top-left of grid for use when
''' rendering a bitmap</param>
''' <param name="bAlternate">Whether this is an alternate row or not</param>
'''
''' TODO: consider allowing alpha/image processing effects
'''
Private Sub pFillBackground( _
      ByVal lhDC As Long, _
      ByRef tR As RECT, _
      ByVal lOffsetX As Long, _
      ByVal lOffsetY As Long, _
      ByVal bAlternate As Boolean _
   )
Dim hBr As Long

   If (bAlternate) And Not (m_oAlternateRowBackColor = -1) Then
      hBr = CreateSolidBrush(TranslateColor(m_oAlternateRowBackColor))
      FillRect lhDC, tR, hBr
      DeleteObject hBr
   Else
      If (m_bBitmap) Then
         TileArea lhDC, tR.Left, tR.TOp, tR.Right - tR.Left, tR.Bottom - tR.TOp, m_hDCSrc, m_lBitmapW, m_lBitmapH, lOffsetX, lOffsetY
      Else
         If Not (m_bEnabled) Then
            hBr = GetSysColorBrush(vbButtonFace And &H1F&)
         Else
            If (UserControl.BackColor And &H80000000) = &H80000000 Then
               hBr = GetSysColorBrush(UserControl.BackColor And &H1F&)
            Else
               hBr = CreateSolidBrush(TranslateColor(UserControl.BackColor))
            End If
         End If
         FillRect lhDC, tR, hBr
         DeleteObject hBr
      End If
   End If
   
End Sub

''' <summary>
''' Initialises the classes used in the grid and the subclass
''' when in run-mode.
''' </summary>
Private Sub pInitialise()

   If (UserControl.Ambient.UserMode) Then
      m_bUserMode = True
      Set m_cScroll = New cScrollBars
      With m_cScroll
         .Create UserControl.hwnd
         .Orientation = efsoBoth
         .Visible(efsHorizontal) = False
         .Visible(efsVertical) = False
      End With
      Set m_cFlatHeader = New cFlatHeader
      m_cFlatHeader.Attach hwnd
      If Not (m_hWnd = 0) Then
         DetachMessage Me, m_hWnd, WM_SETTINGCHANGE
         DetachMessage Me, m_hWnd, WM_DISPLAYCHANGE
         m_hWnd = 0
      End If
      m_hWnd = UserControl.hwnd
      AttachMessage Me, m_hWnd, WM_SETTINGCHANGE
      AttachMessage Me, m_hWnd, WM_DISPLAYCHANGE
      Set m_tmrMarquee = New CTimer
      m_bTrueColor = (GetDeviceCaps(UserControl.hdc, BITSPIXEL) > 8)
      Set m_tmrHotTrack = New CTimer
   Else
      m_bUserMode = False
   End If
   
   
End Sub

''' <summary>
''' Initialises the header "control" - actually a class
''' because VB can't recompile a binary compatible control
''' which includes a private internal control without
''' crashing (which really is a pile of fucking shit).
''' </summary>
Private Sub pCreateHeader()
   Set m_cHeader = New cHeaderControl
   m_cHeader.Init UserControl.hwnd, UserControl.Ambient.UserMode
End Sub

''' <summary>
''' Ensure that the specified cell is visible in the grid.
''' </summary>
''' <param name="lRow">cell row</param>
''' <param name="lCol">cell col</param>
Private Function pbEnsureVisible( _
      ByVal lRow As Long, _
      ByVal lCol As Long _
   ) As Boolean
Dim lXStart As Long
Dim lXEnd As Long
Dim lYStart As Long
Dim lYEnd As Long
Dim lOffset As Long
Dim lValue As Long
Dim iCellCol As Long
Dim lStartColIndex As Long
Dim bRet As Boolean

   bRet = False
   
   ' Check x:
   If Not (m_bRowMode) Or (m_bMouseDown) Then
      For iCellCol = 1 To m_iCols
         If (m_tCols(iCellCol).lCellColIndex = lCol) Then
            lCol = iCellCol
            If lStartColIndex <> 0 Then
               Exit For
            End If
         End If
         If m_lRowTextStartCol = 0 Then
            If m_tCols(iCellCol).bIncludeInSelect Then
               lStartColIndex = iCellCol
            End If
         End If
      Next iCellCol
      
      If m_tRows(lRow).bGroupRow Then
         If (m_tRows(lRow).lGroupIndentLevel > 0) Then
            lXStart = -(m_cHeader.ColumnGroupCount - m_tRows(lRow).lGroupIndentLevel + 1) * m_lDefaultRowHeight + 8
         Else
            If m_tRows(lRow).lGroupStartColIndex = 0 Then
               lStartColIndex = m_lRowTextStartCol
            Else
               If m_tRows(lRow).lGroupStartColIndex <> 0 Then
                  lStartColIndex = m_tRows(lRow).lGroupStartColIndex
               End If
            End If
            lXStart = m_tCols(lStartColIndex).lStartX
         End If
         If m_bTryToFitGroupRows Then
            lXEnd = m_tCols(m_iCols).lStartX + m_tCols(m_iCols).lWidth
         Else
            lXEnd = lXStart + 1
         End If
      Else
         lXStart = m_tCols(lCol).lStartX
         lXEnd = lXStart + m_tCols(lCol).lWidth
      End If
      If (lXStart > m_lStartX) Then
         If (lXEnd < m_lStartX + m_lAvailWidth) Then
            ' Ok
         Else
            ' Have to shift x rightwards:
            If (m_tCols(lCol).lWidth > m_lAvailWidth) Then
               ' Ensure start of column is visible:
               lOffset = lXStart - m_lStartX
               lValue = m_cScroll.Value(efsHorizontal)
               m_cScroll.Value(efsHorizontal) = m_cScroll.Value(efsHorizontal) + lOffset
               bRet = Not (m_cScroll.Value(efsHorizontal) = lValue)
            Else
               ' Make entire cell visible:
               lOffset = lXEnd - (m_lStartX + m_lAvailWidth) + 8
               lValue = m_cScroll.Value(efsHorizontal)
               m_cScroll.Value(efsHorizontal) = m_cScroll.Value(efsHorizontal) + lOffset
               bRet = Not (m_cScroll.Value(efsHorizontal) = lValue)
            End If
         End If
      Else
         ' have to shift x leftwards:
         If (lXStart < m_lStartX) Then
            lOffset = lXStart - m_lStartX - 8
            lValue = m_cScroll.Value(efsHorizontal)
            m_cScroll.Value(efsHorizontal) = m_cScroll.Value(efsHorizontal) + lOffset
            bRet = Not (m_cScroll.Value(efsHorizontal) = lValue)
         End If
      End If
   End If
   
   ' Check y
   If (lRow <= m_lSplitRow) Then
      ' This is always visible
      pbEnsureVisible = bRet
      Exit Function
   End If
   
   lYStart = m_tRows(lRow).lStartY
   lYEnd = lYStart + m_tRows(lRow).lHeight
   If (lYStart > m_lStartY) Then
      If (lYEnd < m_lStartY + m_lAvailheight) Then
         ' Ok
      Else
         ' Have to shift y downwards:
         If (m_tRows(lRow).lHeight < m_lAvailheight) Then
            lOffset = lYEnd - (m_lStartY + m_lAvailheight) + 8
            lValue = m_cScroll.Value(efsVertical)
            m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) + lOffset
            bRet = Not (m_cScroll.Value(efsVertical) = lValue)
         End If
      End If
   Else
      ' Have to shift y upwards:
      If (lYStart < m_lStartY) Then
         lOffset = lYStart - m_lStartY - 8
         lValue = m_cScroll.Value(efsVertical)
         m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) + lOffset
         bRet = Not (m_cScroll.Value(efsVertical) = lValue)
      End If
   End If
   
   pbEnsureVisible = bRet
   
End Function

''' <summary>
''' Determines the visible range of cells in the grid
''' </summary>
''' <param name="iStartRow">Start cell row</param>
''' <param name="iStartCol">Start cell col</param>
''' <param name="iEndRow">End cell row</param>
''' <param name="iEndCol">End cell col</param>
''' <param name="bSplitArea">Whether to look in the split
''' area or not.</param>
Public Sub GetVisibleCellRange( _
      ByRef iStartRow As Long, _
      ByRef iStartCol As Long, _
      ByRef iEndRow As Long, _
      ByRef iEndCol As Long, _
      Optional ByVal bSplitArea As Boolean = False _
   )
Attribute GetVisibleCellRange.VB_Description = "Gets the visible cell range in the grid.  Cells that are partially displayed are included in the range."
Dim iSX As Long
Dim iSY As Long
Dim iEX As Long
Dim iEY As Long
Dim bAlt As Boolean
   GetStartEndCell bSplitArea, _
      iStartRow, iStartCol, iSX, iSY, _
      iEndRow, iEndCol, iEX, iEY, bAlt
End Sub

''' <summary>
''' Determine the visible start and end cell in the grid
''' </summary>
''' <param name="bSplitArea">Whether to look in the split
''' area or not.</param>
''' <param name="iStartRow">Start cell row</param>
''' <param name="iStartCol">Start cell col</param>
''' <param name="iStartX">X position of start cell</param>
''' <param name="iStartY">Y position of start cell</param>
''' <param name="iEndRow">End cell row</param>
''' <param name="iEndCol">End cell col</param>
''' <param name="iEndX">X position of end cell</param>
''' <param name="iEndY">Y position of end cell</param>
''' <param name="bFirstAlternate">Whether the first visible row is an
''' alternate row or not.</param>
Private Sub GetStartEndCell( _
      ByVal bSplitArea As Boolean, _
      ByRef iStartRow As Long, ByRef iStartCol As Long, _
      ByRef iStartX As Long, ByRef iStartY As Long, _
      ByRef iEndRow As Long, ByRef iEndCol As Long, _
      ByRef iEndX As Long, ByRef iEndY As Long, _
      ByRef bFirstAlternate As Boolean _
   )
Dim i As Long
Dim iRetryState As Long
Dim bRedrawCache As Boolean
Dim lStartY As Long

   If Not (bSplitArea) Then
      lStartY = m_lStartY
   End If

   iStartCol = 0: iEndCol = m_iCols
   
   ' 2003-12-19: Bug fix for large resize in column width: try the loop twice
   ' in case the scroll bar isn't synchronized with the new column header
   ' sizes:
   Do While (iRetryState < 2)
      For i = 1 To m_iCols
         If (m_tCols(i).bVisible And m_tCols(i).iGroupOrder = -1) And (i <> m_iRowTextCol) Then
            If (iStartCol = 0) Then
               If (m_tCols(i).lStartX + m_tCols(i).lWidth > m_lStartX) Then
                  iStartCol = i
                  ' We don't need to retry:
                  iRetryState = 2
                  iStartX = m_tCols(i).lStartX - m_lStartX
               End If
            End If
            iEndCol = i
            iEndX = m_tCols(i).lStartX - m_lStartX + m_tCols(i).lWidth
            If (m_tCols(i).lStartX > m_lStartX + m_lAvailWidth) Then
               Exit For
            End If
         End If
      Next i
   
      ' 2003-12-19: It is possible that m_lStartX is off the end of the grid if we've
      ' just resized a large column.  The implication is that the scroll bar setting
      ' for m_lStartX is now incorrect, so we need to force an early scroll refresh.
      ' since that invokes a redraw, and this is been called from draw, turn redraw
      ' off temporarily:
      If (iStartCol = 0) Then
         bRedrawCache = m_bRedraw
         m_bRedraw = False
         m_cScroll_Change efsHorizontal
         m_bRedraw = bRedrawCache
      End If
      iRetryState = iRetryState + 1
   Loop
   
   '
   ' **Note** rows above the split cannot be made invisible.
   ' If they are, there will be rendering bugs
   '
   iStartRow = 0: iEndRow = m_iRows
   If (bSplitArea) Then
      iStartRow = 1
      If (m_iRows >= m_lSplitRow) Then
         iEndRow = m_lSplitRow
         iStartY = m_tRows(iStartRow).lStartY
         For i = iStartRow To iEndRow
            iEndY = iEndY + m_tRows(i).lHeight
         Next i
      End If
   Else
      bFirstAlternate = False
      For i = m_lSplitRow + 1 To m_iRows
         If (m_tRows(i).bVisible) Then
            If (iStartRow = 0) Then
               bFirstAlternate = Not (bFirstAlternate)
               If m_tRows(i).lStartY + m_tRows(i).lHeight > lStartY Then
                  iStartRow = i
                  iStartY = m_tRows(i).lStartY - lStartY
                  If m_tRows(i).bGroupRow Then
                     iEndCol = m_iCols
                  End If
               End If
            Else
               If m_tRows(i).bGroupRow Then
                  iEndCol = m_iCols
               End If
               iEndRow = i
               iEndY = m_tRows(i).lStartY - lStartY + m_tRows(i).lHeight
               If (m_tRows(i).lStartY > lStartY + m_lAvailheight) Then
                  Exit For
               End If
            End If
         End If
      Next i
   End If
   
End Sub

''' <summary>
''' Determines which column header is under the specified
''' mouse point in pixels relative to the control.
''' </summary>
''' <param name="xPixels">X point in pixels relative to the control.</param>
''' <param name="yPixels">Y point in pixels relative to the control.</param>
''' <returns>The index of the column header if any, otherwise 0.</returns>
Public Function ColumnHeaderFromPoint( _
      ByVal xPixels As Long, _
      ByVal yPixels As Long _
   ) As Long
Attribute ColumnHeaderFromPoint.VB_Description = "Determines which column header is under the specified mouse point in pixels relative to the control."
Dim lCol As Long
Dim i As Long
   
   lCol = m_cHeader.ColumnHeaderFromPoint(xPixels, yPixels)
   If (lCol > -1) Then
      For i = 1 To m_iCols
         If (m_tCols(i).lHeaderColIndex = lCol + 1) Then
            ColumnHeaderFromPoint = m_tCols(i).lCellColIndex
            Exit For
         End If
      Next i
   End If
   
   
End Function

''' <summary>
''' Determines which cell header is under the specified
''' mouse point in pixels relative to the control.
''' </summary>
''' <param name="xPixels">X point in pixels relative to the control.</param>
''' <param name="yPixels">Y point in pixels relative to the control.</param>
''' <param name="lRow">Row index if cell is found, otherwise 0.</param>
''' <param name="lCol">Col index if cell is found, otherwise 0.</param>
Public Sub CellFromPoint( _
      ByVal xPixels As Long, _
      ByVal yPixels As Long, _
      ByRef lRow As Long, _
      ByRef lCol As Long _
   )
Attribute CellFromPoint.VB_Description = "Gets the cell which contains the given X,Y coordinates (relative to the grid) in pixels."
Dim iCol As Long
Dim iStartRow As Long
Dim iEndRow As Long
Dim iRow As Long
Dim lOffset As Long

   lRow = 0
   lCol = 0

   lOffset = Abs(m_cHeader.Visible) * (m_cHeader.Height + m_cHeader.TOp + plSplitSize())
   
   If (yPixels <= Abs(m_cHeader.Visible) * (m_cHeader.Height + m_cHeader.TOp) And yPixels > 0) Then
      Exit Sub
   End If

   xPixels = xPixels + m_lStartX
   If (m_lSplitRow > 0) Then
      If (yPixels < lOffset) Then
         iStartRow = 1
         iEndRow = m_lSplitRow
         yPixels = yPixels - Abs(m_cHeader.Visible) * (m_cHeader.Height + m_cHeader.TOp)
      Else
         iStartRow = m_lSplitRow + 1
         iEndRow = m_iRows
         yPixels = yPixels + m_lStartY - lOffset
      End If
   Else
      yPixels = yPixels + m_lStartY - lOffset
      iStartRow = 1
      iEndRow = m_iRows
   End If
   lCol = 0: lRow = 0
   For iRow = iStartRow To iEndRow
      If (m_tRows(iRow).bVisible) Then
         If (yPixels > m_tRows(iRow).lStartY) Then
            If (yPixels <= m_tRows(iRow).lStartY + m_tRows(iRow).lHeight) Then ' slight speed up move this
               lRow = iRow
               Exit For
            End If
         End If
      End If
   Next iRow
   If (iRow = 0) Then
      iCol = 0
   End If
   For iCol = 1 To m_iCols
      If m_tRows(lRow).bGroupRow Then
         lCol = m_iRowTextCol
      Else
         If (m_tCols(iCol).bVisible And m_tCols(iCol).iGroupOrder = -1) And (iCol <> m_iRowTextCol) Then
            If (xPixels > m_tCols(iCol).lStartX) And (xPixels <= m_tCols(iCol).lStartX + m_tCols(iCol).lWidth) Then
               lCol = m_tCols(iCol).lCellColIndex
               Exit For
            End If
         End If
      End If
   Next iCol
   
End Sub

''' <summary>
''' Returns the current horizontal scroll offset from the origin.
''' </summary>
''' <returns>Horizontal scroll offset in pixels from the origin.</returns>
Public Property Get ScrollOffsetX() As Long
Attribute ScrollOffsetX.VB_Description = "Gets the current horizontal scroll offset in pixels."
   If (m_cScroll.Visible(efsHorizontal)) Then
      ScrollOffsetX = -m_cScroll.Value(efsHorizontal)
   End If
End Property

''' <summary>
''' Returns the current vertical scroll offset from the origin.
''' </summary>
''' <returns>Vertical scroll offset in pixels from the origin.</returns>
Public Property Get ScrollOffsetY() As Long
Attribute ScrollOffsetY.VB_Description = "Gets the current vertical scroll offset in pixels."
   If (m_cScroll.Visible(efsVertical)) Then
      ScrollOffsetY = -m_cScroll.Value(efsVertical)
   End If
End Property

''' <summary>
''' Gets the boundary of a particular cell relative to the control
''' in pixels.
''' </summary>
''' <param name="lRow">Row of cell</param>
''' <param name="lCol">Column of cell</param>
''' <param name="lLeft">Left point of cell bounding rectangle</param>
''' <param name="lTop">Top point of cell bounding rectangle</param>
''' <param name="lWidth">Width of cell bounding rectangle</param>
''' <param name="lHeight">Height of cell bounding rectangle</param>
Public Sub CellBoundary( _
      ByVal lRow As Long, _
      ByVal lCol As Long, _
      ByRef lLeft As Long, _
      ByRef lTop As Long, _
      ByRef lWidth As Long, _
      ByRef lHeight As Long _
   )
Attribute CellBoundary.VB_Description = "Gets the co-ordinates of the bounding rectangle for a cell in the grid, in twips."
Dim lOffsetY As Long
Dim lOffsetX As Long
Dim iCol As Long
Dim lCellCol As Long

   ' TODO: get the cell boundary correct for row text cells.

   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lCellColIndex = lCol) Then
         lCellCol = iCol
         Exit For
      End If
   Next iCol

   lOffsetY = Abs(m_bHeader) * (m_cHeader.Height + m_cHeader.TOp)
   If (lRow > m_lSplitRow) Then
      lOffsetY = lOffsetY + Abs(m_bHeader) * plSplitSize()
   End If
   lOffsetX = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lIndent + (Abs(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iIconIndex <> -1) * m_lIconSizeX) + (Abs(m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).lExtraIconIndex <> -1) * m_lIconSizeX)
   If (m_tRows(lRow).bGroupRow) Then
      lLeft = -m_lStartX - (m_cHeader.ColumnGroupCount - m_tRows(lRow).lGroupIndentLevel + 1) * m_lDefaultRowHeight
   Else
      lLeft = (m_tCols(lCellCol).lStartX - m_lStartX + lOffsetX)
   End If
   lLeft = lLeft * Screen.TwipsPerPixelX
   lWidth = (m_tCols(lCellCol).lWidth - lOffsetX) * Screen.TwipsPerPixelX
   If (lRow > m_lSplitRow) Then
      lTop = ((m_tRows(lRow).lStartY - m_lStartY) + lOffsetY) * Screen.TwipsPerPixelY
   Else
      lTop = (m_tRows(lRow).lStartY + lOffsetY) * Screen.TwipsPerPixelY
   End If
   lHeight = m_tRows(lRow).lHeight * Screen.TwipsPerPixelY
End Sub

''' <summary>
''' Makes the specified cell visible in the grid, scrolling
''' if necessary.
''' </summary>
''' <param name="lRow">Row of cell</param>
''' <param name="lCol">Column of cell</param>
Public Sub EnsureVisible( _
      ByVal lRow As Long, _
      ByVal lCol As Long _
   )
Attribute EnsureVisible.VB_Description = "Ensures that the specified grid cell is made visible in the control."
Dim iCol As Long
   If pbValid(lRow, lCol) Then
      If m_tRows(lRow).bVisible Then
         If (m_tCols(lCol).bVisible And m_tCols(lCol).iGroupOrder = -1) Or m_tRows(lRow).bGroupRow Then
            ' If rowtext column, choose the start pos based on the
            ' grid's settings:
            If m_tCols(lCol).bRowTextCol Or m_tRows(lRow).bGroupRow Then
               lCol = 0
               If m_lRowTextStartCol > 0 Then
                  lCol = m_lRowTextStartCol
               Else
                  For iCol = 1 To m_iCols
                     If m_tCols(iCol).bIncludeInSelect And (m_tCols(iCol).bVisible And m_tCols(iCol).iGroupOrder = -1) Then
                        lCol = iCol
                        Exit For
                     End If
                  Next iCol
               End If
            End If
            ' Call inbuild ensure visible method:
            If lCol > 0 Then
               pbEnsureVisible lRow, lCol
            End If
         Else
            ' can't ensure an invisible col visible... Don't raise error
         End If
      Else
         ' can't ensure an invisible row visible...  Don't raise error
      End If
   End If
End Sub

''' <summary>
''' Clears the current selection in the control.
''' </summary>
Public Sub ClearSelection()
Attribute ClearSelection.VB_Description = "Clears the current selection in the control."
'  19/10/99 4)
Dim lRow As Long
Dim lCol As Long
   If m_bMultiSelect Then
      For lRow = 1 To m_iRows
         For lCol = 1 To m_iCols
            m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bSelected
            m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bSelected = False
         Next lCol
      Next lRow
      Draw
   Else
      If m_iSelRow > 0 And m_iSelRow <= m_iRows Then
         If m_bRowMode Then
            For lCol = 1 To m_iCols
               m_tCells(lCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = m_tCells(lCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected
               m_tCells(lCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = False
            Next lCol
         Else
            If m_iSelCol > 0 And m_iSelCol <= m_iCols Then
               m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
               m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = False
            End If
         End If
      End If
      m_iSelRow = 0: m_iSelCol = 0
      Draw
   End If
End Sub

''' <summary>
''' Gets the control's Window handle.
''' </summary>
''' <returns>hWnd of the control</returns>
Public Property Get hwnd() As Long
Attribute hwnd.VB_Description = "Gets the Window handle of the control."
'  19/10/99 1)
   hwnd = UserControl.hwnd
End Property

''' <summary>
''' Adds a new column to the grid.  Note that if the control
''' contains a row text column, this will always have the last
''' index in the grid.
''' </summary>
''' <param name="vKey">String key for the column.</param>
''' <param name="sHeader">Text for column header.</param>
''' <param name="eAlign">Alignment of column header text and icon.</param>
''' <param name="iIconIndex">0-based index of an icon from the HeaderImageList
''' to use in the column.  Set to -1 for no icon.</param>
''' <param name="lColumnWidth">Column Width in pixels.  Set to -1 for the
''' default width.</param>
''' <param name="bVisible">Whether the new column should be visible
''' or not.  Defaults to <c>True</c></param>
''' <param name="bFixed">Whether the column has fixed width or not.</param>
''' <param name="vKeyBefore">Optional key or index of the column to insert
''' this column before.</param>
''' <param name="bIncludeInSelect">Whether to include this column in the
''' selection rectangle when the grid is in row mode.</param>
''' <param name="sFmtString">String to use when formatting text of
''' cells in this column.  For example, if the column will contain
''' Dates, then the format string might be "mmm yyyy".</param>
''' <param name="bRowTextColumn">Whether the column is the
''' column used to associate the row text with a column.  A row
''' text column does not appear in the header and any contents
''' are rendered underneath the row itself.  The row text column
''' must be the last column in the control.</param>
''' <param name="eSortType">Sort type to use when sorting the
''' items in the column</param>
''' <param name="bOwnerDraw">Not implemented in this version.  Will be
''' used to determine whether the cells in the column should
''' call the IGridCellDraw interface on the container.
''' </param>
''' <returns>Index of the new column.</returns>
Public Function AddColumn( _
      Optional ByVal vKey As String, _
      Optional ByVal sHeader As String, _
      Optional ByVal eAlign As ECGHdrTextAlignFlags, _
      Optional ByVal iIconIndex As Long = -1, _
      Optional ByVal lColumnWidth As Long = -1, _
      Optional ByVal bVisible As Boolean = True, _
      Optional ByVal bFixedWidth As Boolean = False, _
      Optional ByVal vKeyBefore As Variant, _
      Optional ByVal bIncludeInSelect As Boolean = True, _
      Optional ByVal sFmtString As String, _
      Optional ByVal bRowTextColumn As Boolean = False, _
      Optional ByVal eSortType As ECGSortTypeConstants = CCLSortString, _
      Optional ByVal bOwnerDraw As Boolean = False _
   ) As Long
Attribute AddColumn.VB_Description = "Adds or inserts a new column.  For performance, it is best to set up columns before adding any data."
Dim i As Long
Dim lColBefore As Long
Dim lCol As Long
Dim iRow As Long
      
   ' Check for valid key:
   If Not (pbIsValidColumnKey(vKey)) Then
      Exit Function
   End If
   
   If (bRowTextColumn) Then
      If m_bHasRowText Then
         ' 2003-11-27: It's an error to have two row text columns
         gErr 500, "Cannot add a second row text column to the grid."
         Exit Function
      Else
         m_bHasRowText = True
      End If
   End If
   
   ' If key valid then check for valid key after:
   If Not IsMissing(vKeyBefore) Then
      lColBefore = ColumnIndexByVariant(vKeyBefore)
      If (lColBefore < 1) Then
         gErr 9, "Column before does not exist"
         Exit Function
      End If
   End If
   
   ' Correct missing params:
   If (lColumnWidth = -1) Then
      lColumnWidth = m_lDefaultColumnWidth
   End If
   
   ' All ok, add the column:
   ReDim Preserve m_tCols(0 To m_iCols + 1) As tColPosition
   If (lColBefore <> 0) Then
      For lCol = m_iCols + 1 To lColBefore Step -1
         LSet m_tCols(lCol) = m_tCols(lCol - 1)
         m_tCols(lCol).lCellColIndex = m_tCols(lCol).lCellColIndex + 1
      Next lCol
      lCol = lColBefore
   Else
      lCol = m_iCols + 1
   End If
         
   With m_tCols(lCol)
      .lCellColIndex = lCol
      .sKey = vKey
      .bIncludeInSelect = bIncludeInSelect
      .sHeader = sHeader
      .iIconIndex = iIconIndex
      .eTextAlign = eAlign
      .sFmtString = sFmtString
      .bVisible = bVisible
      .iGroupOrder = -1
      .eSortType = eSortType
      .bRowTextCol = bRowTextColumn
      .bFixedWidth = (bFixedWidth And Not (bRowTextColumn)) ' note the row text col can't be fixed with
   End With
   If (bRowTextColumn) Then
      m_iRowTextCol = lCol
   End If
   m_iCols = m_iCols + 1
   ColumnWidth(lCol) = lColumnWidth
   '
   If m_iRows > 0 Then
      ' (12) We need to add the extra data to the grid!
      pAddColToGridArray lCol
   End If

   ' Add to header:
   If (m_tCols(lCol).bVisible) Then
      SetHeaders
   End If
   
   ' 2003-11-26: return the column...
   AddColumn = lCol
   
End Function

''' <summary>
''' Synchronises the internal column representation in the control
''' with the order of the columns in the header itself.  This is
''' needed when the user drag-drop re-orders columns, particularly
''' when columns are dragged out of the header for grouping.
''' </summary>
Private Sub pSyncHeaderOrder()
Dim lCol As Long
Dim lMaxOrder As Long
Dim lNewIndex As Long
Dim j As Long
Dim lOrderInHeader As Long
Dim tColSwap As tColPosition
Dim lEndCol As Long
Dim lLastWidth As Long

   For lCol = 1 To m_iCols
      If (m_tCols(lCol).lHeaderColIndex > 0) Then
         m_tCols(lCol).iGroupOrder = m_cHeader.ColumnGroupOrder(m_tCols(lCol).lHeaderColIndex - 1)
         m_tCols(lCol).bIsGrouped = (m_tCols(lCol).iGroupOrder > -1)
      End If
   Next lCol

   lMaxOrder = 0
   If (m_bHasRowText) Then
      lEndCol = m_iRowTextCol
   Else
      lEndCol = m_iCols
   End If
   
   For lCol = 1 To lEndCol
      If (m_tCols(lCol).lHeaderColIndex > 0) Then
         lOrderInHeader = m_cHeader.ColumnIndex(m_tCols(lCol).lHeaderColIndex - 1)
         If (lOrderInHeader < lMaxOrder) Then
            ' Shift this one down until it is in the right position
            lNewIndex = 1
            For j = lCol - 1 To 1 Step -1
               If (m_tCols(j).lHeaderColIndex > 0) Then 'And (m_tCols(j).iGroupOrder = -1) Then
                  If (m_cHeader.ColumnIndex(m_tCols(j).lHeaderColIndex - 1) < lOrderInHeader) Then
                     Exit For
                  Else
                     lNewIndex = j
                  End If
               End If
            Next j
            If Not (lCol = lNewIndex) Then
               LSet tColSwap = m_tCols(lCol)
               For j = lCol - 1 To lNewIndex Step -1
                  LSet m_tCols(j + 1) = m_tCols(j)
               Next j
               LSet m_tCols(lNewIndex) = tColSwap
            End If
         End If
         If (lOrderInHeader > lMaxOrder) Then
            lMaxOrder = lOrderInHeader
         End If
      End If
   Next lCol
   
   m_tCols(0).lWidth = 0
   m_tCols(0).lCorrectWidth = 0
   For lCol = 1 To m_iCols
      If (m_tCols(lCol).bVisible And m_tCols(lCol).iGroupOrder = -1) Then
         m_tCols(lCol).lStartX = m_tCols(lCol - 1).lStartX + lLastWidth
         lLastWidth = m_tCols(lCol).lWidth
      Else
         m_tCols(lCol).lStartX = m_tCols(lCol - 1).lStartX
      End If
   Next lCol
   
End Sub

''' <summary>
''' Adds a new column to the internal array which maintains
''' grid data.  If the grid already contains rows, then
''' there may be a performance hit when this is called.
''' Ideally the grid should be configured with all columns
''' needed, and columns hidden rather than dynamically
''' adding and removing columns.
''' </summary>
''' <param name="lCol">Index of column to add.</param>
Private Sub pAddColToGridArray(ByVal lCol As Long)
Dim iRow As Long
Dim iCol As Long
Dim iACol As Long
Dim tGridCopy() As tGridCell

   ' This is very bad for performance.  You should add columns
   ' before adding any data to the grid.
   ReDim tGridCopy(1 To m_iCols, 1 To m_iTotalCellRows) As tGridCell
   For iRow = 1 To m_iTotalCellRows
      For iCol = 1 To m_iCols - 1
         If (iCol > lCol) Then
            iACol = iCol + 1
         Else
            iACol = iCol
         End If
         LSet tGridCopy(iACol, iRow) = m_tCells(iCol, iRow)
      Next iCol
   Next iRow
   ReDim m_tCells(1 To m_iCols, 1 To m_iTotalCellRows) As tGridCell
   For iRow = 1 To m_iTotalCellRows
      For iCol = 1 To m_iCols
         If iCol = lCol Then
            LSet m_tCells(iCol, iRow) = m_tDefaultCell
         Else
            LSet m_tCells(iCol, iRow) = tGridCopy(iCol, iRow)
         End If
      Next iCol
   Next iRow
   
End Sub

''' <summary>
''' Removes the column from the control.  This is an
''' expensive operation if the grid contains data; if you
''' can make the column invisible instead that is quicker.
''' </summary>
''' <param name="vKey">Key or index of column to remove</param>
Public Sub RemoveColumn( _
      ByVal vKey As Variant _
   )
Attribute RemoveColumn.VB_Description = "Permanently removes a column from the grid.  If all columns are removed, the grid will be cleared.  If you want to temporarily remove a column, use the ColumnVisible property."
Dim lCol As Long
Dim iRow As Long
Dim iCol As Long
Dim iCCol As Long
Dim lGridCol As Long
Dim tGridCopy() As tGridCell

   lCol = ColumnIndexByVariant(vKey)
   If (lCol <> 0) Then
      ' 19/10/99: (7)
      If m_tCols(lCol).bRowTextCol Then
         m_iRowTextCol = 0
         m_lRowTextStartCol = 0
         m_bHasRowText = False
      End If
      
      ' Quite a lot of hacking to do here!
      If (m_iCols > 1) Then
         ' Make a copy of the grid:
         ReDim tGridCopy(1 To m_iCols, 1 To m_iRows) As tGridCell
         For iRow = 1 To m_iRows
            For iCol = 1 To m_iCols
               LSet tGridCopy(iCol, m_tRows(iRow).lGridCellArrayRow) = m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow)
            Next iCol
         Next iRow
         
         ' Now remove the column:
         For iCol = 1 To m_iCols
            If (m_tCols(iCol).lCellColIndex = lCol) Then
               iCCol = iCol
               Exit For
            End If
         Next iCol
         For iCol = iCCol To m_iCols - 1
            LSet m_tCols(iCol) = m_tCols(iCol + 1)
         Next iCol
         
         m_iCols = m_iCols - 1
         For iCol = 1 To m_iCols
            If (m_tCols(iCol).lCellColIndex > lCol) Then
               m_tCols(iCol).lCellColIndex = m_tCols(iCol).lCellColIndex - 1
            End If
         Next iCol
         ReDim Preserve m_tCols(0 To m_iCols) As tColPosition
         m_tCols(1).lStartX = 0
         ColumnWidth(1) = ColumnWidth(1)
         
         ' Having removed the column, rebuild the grid cells:
         ReDim m_tCells(1 To m_iCols, 1 To m_iRows) As tGridCell
         For iRow = 1 To m_iRows
            For iCol = 1 To m_iCols
               If (iCol >= lCol) Then
                  lGridCol = iCol + 1
               Else
                  lGridCol = iCol
               End If
               LSet m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow) = tGridCopy(lGridCol, m_tRows(iRow).lGridCellArrayRow)
            Next iCol
         Next iRow
         
         ' Set the headers back up if required:
         If (m_bHeader) Then
            SetHeaders
         End If
         
         ' Now redraw:
         m_bDirty = True
         Draw
         
      Else
         ' No columns, no grid!
         m_iCols = 0
         m_iRows = 0
         ReDim m_tRows(0 To 0) As tRowPosition
         ReDim m_tCols(0 To 0) As tColPosition
         Erase m_tCells
         m_iTotalCellRows = 0
         
         ' Set the headers back up if required:
         If (m_bHeader) Then
            SetHeaders
         End If
                  
         m_bDirty = True
         Draw
      End If
   End If
   
End Sub

''' <summary>
''' Sets the headers so they match the columns set up in the control.
''' </summary>
Public Sub SetHeaders()
Attribute SetHeaders.VB_Description = "Populates the headers in the control based on the columns in the grid.  Called automatically by the control when Headers is set to True."
Dim i As Long
Dim j As Long
Dim iIndex As Long
Dim iGroupOrderCol() As Long
Dim iGroupOrderColCount As Long
Dim iGroupOrder As Long
Dim bRedraw As Boolean
   
   bRedraw = m_bRedraw
   m_bRedraw = False
   
   ' Remove all the headers:
   For i = m_cHeader.ColumnCount To 1 Step -1
      m_cHeader.RemoveColumn i - 1
   Next i
   
   ' Add them back in again:
   iGroupOrderColCount = 0
   For i = 1 To m_iCols
      If (m_tCols(i).bVisible) And Not (i = m_iRowTextCol) Then
         m_cHeader.AddColumn m_tCols(i).sHeader, m_tCols(i).lWidth, m_tCols(i).eTextAlign, , m_tCols(i).iIconIndex
         If (m_tCols(i).bImageOnRight) Then
            m_cHeader.ColumnImageOnRight(m_cHeader.ColumnCount - 1) = True
         End If
         m_tCols(i).lHeaderColIndex = m_cHeader.ColumnCount
         
         If (m_tCols(i).iGroupOrder > -1) Then
            iIndex = 0
            For j = 1 To iGroupOrderColCount
               If (m_tCols(iGroupOrderCol(j)).iGroupOrder > m_tCols(i).iGroupOrder) Then
                  iIndex = j
                  Exit For
               End If
            Next j
            iGroupOrderColCount = iGroupOrderColCount + 1
            ReDim Preserve iGroupOrderCol(1 To iGroupOrderColCount) As Long
            If (iIndex = 0) Then
               iIndex = iGroupOrderColCount
            Else
               For j = iGroupOrderColCount - 1 To iIndex Step -1
                  iGroupOrderCol(j + 1) = iGroupOrderCol(j)
               Next j
            End If
            iGroupOrderCol(iIndex) = i
         End If
      Else
         m_tCols(i).lHeaderColIndex = 0
      End If
   Next i
   
   ' 2003-11-27
   ' Set the grouping as required:
   For i = 1 To iGroupOrderColCount
      m_cHeader.ColumnIsGrouped(m_tCols(iGroupOrderCol(i)).lHeaderColIndex - 1) = True
   Next i
      
   pResizeHeader
   
   Redraw = bRedraw
   
End Sub

Public Property Get ColumnIndex(ByVal sColumnKey As String) As Long
Attribute ColumnIndex.VB_Description = "Gets the index of the column with the specified key."
Dim iCol As Long
Dim i As Long
   For i = 1 To m_iCols
      If StrComp(m_tCols(i).sKey, sColumnKey) = 0 Then
         ColumnIndex = m_tCols(i).lCellColIndex
         Exit Property
      End If
   Next i
   gErr 9, "Column not found"
End Property

''' <summary>
''' Internal method to get column index for a variant key.
''' </summary>
''' <param name="vColumn">Key or index of column</param>
''' <returns>Valid column index or 0 if not found.</returns>
Private Function plColumnIndexByKey(ByVal sKey As String) As Long
Dim i As Long
   For i = 1 To m_iCols
      If StrComp(m_tCols(i).sKey, sKey) = 0 Then
         plColumnIndexByKey = i
         Exit For
      End If
   Next i
End Function
Private Function ColumnIndexByVariant(ByVal vKey As Variant) As Long
Dim lCol As Long
   If IsNumeric(vKey) Then
      lCol = plColumnIndexByIndex(vKey)
   Else
      lCol = plColumnIndexByKey(vKey)
   End If
   If (lCol = 0) Then
      gErr 9, "Column not found"
   End If
   ColumnIndexByVariant = lCol
End Function

Private Function plColumnIndexByIndex(ByVal lIndex As Long) As Long
Dim i As Long
   ' return the index of this column in the column header array
   For i = 1 To m_iCols
      If (m_tCols(i).lCellColIndex = lIndex) Then
         plColumnIndexByIndex = i
         Exit For
      End If
   Next i
End Function

Public Property Get ColumnImage(ByVal vColumn As Variant) As Long
Attribute ColumnImage.VB_Description = "Gets/sets the image index to show in a column's header. Image indexes are 0 based indexes of the images in an  ImageList."
Dim lCol As Long
   
   lCol = ColumnIndexByVariant(vColumn)
   If Not (lCol = 0) Then
      ColumnImage = m_tCols(lCol).iIconIndex
   End If
   
End Property
Public Property Let ColumnImage(ByVal vColumn As Variant, ByVal lImage As Long)
Dim lCol As Long

   lCol = ColumnIndexByVariant(vColumn)
   If (lCol <> 0) Then
      m_tCols(lCol).iIconIndex = lImage
      If (m_tCols(lCol).bVisible) And Not (lCol = m_iRowTextCol) Then
         m_cHeader.ColumnImage(m_tCols(lCol).lHeaderColIndex - 1) = lImage
      End If
   End If
End Property

Public Property Get ColumnImageOnRight(ByVal vColumn As Variant) As Boolean
Attribute ColumnImageOnRight.VB_Description = "Gets/sets whether images (if any) will be shown on the right or not in a column header."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If Not (lCol = 0) Then
      ColumnImageOnRight = m_tCols(lCol).bImageOnRight
   End If
End Property
Public Property Let ColumnImageOnRight(ByVal vColumn As Variant, ByVal bState As Boolean)
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If Not (lCol = 0) Then
      m_tCols(lCol).bImageOnRight = bState
      If (m_tCols(lCol).bVisible) And Not (lCol = m_iRowTextCol) Then
         m_cHeader.ColumnImageOnRight(m_tCols(lCol).lHeaderColIndex - 1) = bState
      End If
   End If
   
End Property

Public Property Get ColumnAlign(ByVal vColumn As Variant) As ECGHdrTextAlignFlags
Attribute ColumnAlign.VB_Description = "Gets/sets the alignment used to draw the column header for a column."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If Not (lCol = 0) Then
      ColumnAlign = m_tCols(lCol).eTextAlign
   End If
End Property

Public Property Let ColumnAlign(ByVal vColumn As Variant, ByVal eAlign As ECGHdrTextAlignFlags)
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If Not (lCol = 0) Then
      m_tCols(lCol).eTextAlign = eAlign
      If (m_tCols(lCol).bVisible) And Not (lCol = m_iRowTextCol) Then
         m_cHeader.ColumnTextAlign(m_tCols(lCol).lHeaderColIndex - 1) = eAlign
      End If
   End If
   
End Property

Public Property Get ColumnIsGrouped(ByVal vColumn As Variant) As Boolean
Attribute ColumnIsGrouped.VB_Description = "Gets/sets whether the specified column is grouped in the control."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If Not (lCol = 0) Then
      ColumnIsGrouped = m_tCols(lCol).bIsGrouped
   End If
End Property

Public Property Let ColumnIsGrouped(ByVal vColumn As Variant, ByVal bIsGrouped As Boolean)
Dim lCol As Long
Dim lHeaderColumn As Long

   lCol = ColumnIndexByVariant(vColumn)
   If Not (lCol = 0) Then
      If Not (m_tCols(lCol).bIsGrouped = bIsGrouped) Then
         lHeaderColumn = m_tCols(lCol).lHeaderColIndex - 1
         If Not (bIsGrouped) Then
            ' Remove
            m_cHeader.ColumnIsGrouped(lHeaderColumn) = False
            m_cHeader_ColumnGroupChange lHeaderColumn
         Else
            If Not (m_cHeader.AllowGrouping) Then
               AllowGrouping = True
            End If
            ' Add
            m_cHeader.ColumnIsGrouped(lHeaderColumn) = True
            m_cHeader_ColumnGroupChange lHeaderColumn
         End If
      End If
   End If
   
End Property

Public Property Get ColumnGroupOrder(ByVal vColumn As Variant) As Long
Attribute ColumnGroupOrder.VB_Description = "Gets the order the column appears at in the column grouping.  If the column is not grouped, then returns 0."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If Not (lCol = 0) Then
      If m_tCols(lCol).bIsGrouped Then
         ColumnGroupOrder = m_cHeader.ColumnGroupOrder(m_tCols(lCol).lHeaderColIndex - 1)
      End If
   End If
End Property
Public Property Get ColumnKey(ByVal vColumn As Variant) As String
Attribute ColumnKey.VB_Description = "Gets/sets the key for column."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If (lCol > 0) Then
      ColumnKey = m_tCols(lCol).sKey
   End If
End Property
Public Property Let ColumnKey(ByVal vColumn As Variant, ByVal sKey As String)
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If (lCol > 0) Then
      If Not (StrComp(m_tCols(lCol).sKey, sKey) = 0) Then
         If (pbIsValidColumnKey(sKey)) Then
            m_tCols(lCol).sKey = sKey
         End If
      End If
   End If

End Property
''' <summary>
''' Gets the tag value for the specified column.
''' </summary>
''' <param name="lCol">Column index</param>
''' <returns>Tag for column</returns>
Public Property Get ColumnTag(ByVal vColumn As Variant) As String
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If (lCol > 0) Then
      ColumnTag = m_tCols(lCol).sTag
   Else
      gErr 9, "Column subscript out of range"
   End If
End Property
''' <summary>
''' Sets the tag value for the specified column.
''' </summary>
''' <param name="lCol">Column index</param>
''' <param name="sTag">Tag for column</param>
Public Property Let ColumnTag(ByVal vColumn As Variant, ByVal sTag As String)
Attribute ColumnTag.VB_Description = "Gets/sets a tag string associated with a column in the grid."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vColumn)
   If (lCol > 0) Then
      If Not (StrComp(m_tCols(lCol).sTag, sTag) = 0) Then
         m_tCols(lCol).sTag = sTag
      End If
   End If

End Property

''' <summary>
''' Determines whether a key is an appropriate new key value
''' for a column; throws an error if not.
''' </summary>
''' <param name="sKey">New Key Value</param>
''' <returns><c>True</c> if column key is ok, <c>False</c> otherwise</returns>
Private Function pbIsValidColumnKey(ByVal sKey As String) As Boolean
Dim i As Long
   If Len(sKey) > 0 Then
      For i = 1 To m_iCols
         If (m_tCols(i).sKey = sKey) Then
            gErr 457, "Key already exists in column collection"
            Exit Function
         End If
      Next i
   End If
   pbIsValidColumnKey = True
End Function

Private Sub pGetAvailableWidthAndHeight()
Dim tR As RECT
   GetWindowRect UserControl.hwnd, tR
   m_lAvailWidth = tR.Right - tR.Left
   m_lAvailheight = tR.Bottom - tR.TOp
   If (m_eBorderStyle = ecgBorderStyle3d) Then
      m_lAvailWidth = m_lAvailWidth - 4
      m_lAvailheight = m_lAvailheight - 4
   ElseIf (m_eBorderStyle = ecgBorderStyle3dThin) Then
      m_lAvailWidth = m_lAvailWidth - 2
      m_lAvailheight = m_lAvailheight - 2
   End If
   If (m_bHeader) Then
      m_lAvailheight = m_lAvailheight - (m_cHeader.Height + m_cHeader.TOp + plSplitSize())
   End If
End Sub

''' <summary>
''' Sets scroll bar visibility depending on
''' the current size of the grid.
''' </summary>
Private Function pbScrollVisible() As Boolean
Dim bHorz As Boolean
Dim bHorzTaken As Boolean
Dim bVert As Boolean
Dim bVertTaken As Boolean
Dim lProportion As Long
Dim iLastRow As Long
Dim iCol As Long
Dim lLargeChange As Long
Dim bRet As Boolean
Dim lLastColumn As Long
   
   pGetAvailableWidthAndHeight
   
   For iCol = 1 To m_iCols
      If (m_tCols(iCol).bVisible And m_tCols(iCol).iGroupOrder = -1) And (m_tCols(iCol).lCellColIndex <> m_iRowTextCol) Then
         m_lGridWidth = m_tCols(iCol).lStartX + m_tCols(iCol).lCorrectWidth
         lLastColumn = iCol
      End If
   Next iCol
   If (m_cHeader.AllowGrouping) Then
      m_lGridWidth = m_lGridWidth + m_cHeader.ColumnGroupCount * m_lDefaultRowHeight
   End If
   
   iLastRow = plGetLastVisibleRow()
   If (m_bAddRowsOnDemand And m_bInAddRowRequest) Then
      ' Make the grid pretend to be bigger than it is:
      m_lGridHeight = m_tRows(m_iRows).lStartY + m_tRows(m_iRows).lHeight + m_lDefaultRowHeight
   Else
      m_lGridHeight = m_tRows(iLastRow).lStartY + m_tRows(iLastRow).lHeight
   End If
      
   ' Check horizontal:
   If (m_lGridWidth > m_lAvailWidth) Then
      bHorz = True
   End If
   If (m_lGridHeight > m_lAvailheight) Then
      bVert = True
   End If
   
   If Not (bVert And bHorz) Then
      If (bVert) Then
         If (m_bAllowVert) Then
            m_lAvailWidth = m_lAvailWidth - GetSystemMetrics(SM_CXVSCROLL)
            bVertTaken = True
         End If
         If (m_lGridWidth > m_lAvailWidth) Then
            bHorz = True
         End If
      ElseIf (bHorz) Then
         If (m_bAllowHorz) Then
            m_lAvailheight = m_lAvailheight - GetSystemMetrics(SM_CYHSCROLL)
            bHorzTaken = True
         End If
         If (m_lGridHeight > m_lAvailheight) Then
            bVert = True
         End If
      End If
   Else
      If (m_bAllowHorz) Then
         m_lAvailWidth = m_lAvailWidth - GetSystemMetrics(SM_CXVSCROLL)
         bVertTaken = True
      End If
      If (m_bAllowVert) Then
         m_lAvailheight = m_lAvailheight - GetSystemMetrics(SM_CYHSCROLL)
         bHorzTaken = True
      End If
   End If
   
   ' Set visibility:
   If Not (m_cScroll.Visible(efsHorizontal) = bHorz) Then
      If Not (bHorz And m_bAllowHorz) Then
         m_cScroll.Value(efsHorizontal) = 0
      End If
      m_cScroll.Visible(efsHorizontal) = bHorz And m_bAllowHorz
      bRet = True
      pResizeHeader
      UserControl_Resize
   End If
   If m_cScroll.Visible(efsVertical) <> bVert Then
      If Not (bVert And m_bAllowVert) Then
         m_cScroll.Value(efsHorizontal) = 0
      End If
      m_cScroll.Visible(efsVertical) = bVert And m_bAllowVert
      bRet = True
      UserControl_Resize
   End If
      
   ' Check scaling:
   m_lStartX = -m_cHeader.ColumnGroupCount * m_lDefaultRowHeight
   m_lStartY = 0
   
   If (bHorz) Then
      With m_cScroll
         If (bVert) Then
            If Not (bVertTaken) Then  ' 2003-11-27 finally fixed the space bug
               m_lAvailWidth = m_lAvailWidth - GetSystemMetrics(SM_CXVSCROLL)
            End If
         End If
         If (.Max(efsHorizontal) <> m_lGridWidth - m_lAvailWidth) Then
            .Max(efsHorizontal) = m_lGridWidth - m_lAvailWidth
            bRet = True
            If (m_lAvailWidth > 0) Then
               lProportion = ((m_lGridWidth - m_lAvailWidth) \ m_lAvailWidth) + 1
               lLargeChange = (m_lGridWidth - m_lAvailWidth) \ lProportion
               .LargeChange(efsHorizontal) = IIf(lLargeChange < 20, 20, lLargeChange)
               .SmallChange(efsHorizontal) = 20
            End If
            pResizeHeader
         End If
         m_lStartX = m_lStartX + m_cScroll.Value(efsHorizontal)
      End With
   End If
   If (bVert) Then
      With m_cScroll
         If (bHorz) Then
            If Not (bHorzTaken) Then ' 2003-11-27 finally fixed the space bug
               m_lAvailheight = m_lAvailheight - GetSystemMetrics(SM_CYHSCROLL)
            End If
         End If
         If (m_bAddRowsOnDemand And m_bInAddRowRequest) Then
            If (.Max(efsVertical) <> (m_lGridHeight + m_lDefaultRowHeight - m_lAvailheight)) Then
               .Max(efsVertical) = m_lGridHeight + m_lDefaultRowHeight - m_lAvailheight
               bRet = True
            End If
         Else
            If (.Max(efsVertical) <> (m_lGridHeight - m_lAvailheight)) Then
               .Max(efsVertical) = m_lGridHeight - m_lAvailheight
               bRet = True
            End If
         End If
         If (m_lAvailheight > 0) Then
            lProportion = ((m_lGridHeight - m_lAvailheight) \ m_lAvailheight) + 1
            lLargeChange = (m_lGridHeight - m_lAvailheight) \ lProportion
            .LargeChange(efsVertical) = IIf(lLargeChange < m_lDefaultRowHeight, m_lDefaultRowHeight, lLargeChange)
            .SmallChange(efsVertical) = m_lDefaultRowHeight
         End If
         m_lStartY = m_cScroll.Value(efsVertical)
      End With
   End If
      
   If Not (bHorz) Then
      If (m_bStretchLastColumnToFit) Then
         
         If Not (m_lStretchedColumn = 0) Then
            If Not (m_lStretchedColumn = m_tCols(lLastColumn).lCellColIndex) Then
               ' Clear stretching on this column:
               Dim lCol As Long
               lCol = plColumnIndexByIndex(m_lStretchedColumn)
               m_tCols(lCol).lWidth = m_tCols(lCol).lCorrectWidth
               m_cHeader.StealthSetColumnWidth m_tCols(lCol).lHeaderColIndex - 1, m_tCols(lCol).lWidth
               m_lStretchedColumn = 0
            End If
         End If
         
         Dim lExtra As Long
         lExtra = m_lAvailWidth - m_lGridWidth
         m_tCols(lLastColumn).lWidth = m_tCols(lLastColumn).lCorrectWidth + lExtra
         m_cHeader.StealthSetColumnWidth m_tCols(lLastColumn).lHeaderColIndex - 1, m_tCols(lLastColumn).lWidth + 8
         m_lStretchedColumn = m_tCols(lLastColumn).lCellColIndex
      End If
   Else
      If (m_bStretchLastColumnToFit) Then
      
      End If
   End If
      
   pbScrollVisible = bRet

End Function

''' <summary>
''' Gets whether the header is visible or not.
''' </summary>
''' <returns><c>True</c> if header is visible, <c>False</c> otherwise</returns>
Public Property Get Header() As Boolean
Attribute Header.VB_Description = "Gets/sets whether the grid has a header or not."
Attribute Header.VB_ProcData.VB_Invoke_Property = ";Behavior"
   Header = m_bHeader
End Property
''' <summary>
''' Sets whether the header is visible or not.
''' </summary>
''' <param name="bState"><c>True</c> to make header visible, <c>False</c> otherwise</param>
Public Property Let Header(ByVal bState As Boolean)
   m_bHeader = bState
   m_cHeader.Visible = bState
   pResizeHeader
   PropertyChanged "Header"
End Property
''' <summary>
''' Gets whether the header is rendered with a flat style or not.
''' </summary>
''' <returns><c>True</c> if header is rendered with flat style, <c>False</c> otherwise</returns>
Public Property Get HeaderFlat() As Boolean
Attribute HeaderFlat.VB_Description = "Gets/sets whether the header is rendered with a flat style or not."
   HeaderFlat = m_bHeaderFlat
End Property
''' <summary>
''' Sets whether the header is rendered with a flat style or not.
''' </summary>
''' <returns><c>True</c> to render header with flat style, <c>False</c> otherwise</returns>
Public Property Let HeaderFlat(ByVal bState As Boolean)
   m_bHeaderFlat = bState
   If Not (m_cFlatHeader Is Nothing) Then
      If bState Then
         m_cFlatHeader.Attach UserControl.hwnd
      Else
         m_cFlatHeader.Detach
      End If
   End If
   PropertyChanged "Header"
End Property
Public Property Get HeaderHeight() As Long
Attribute HeaderHeight.VB_Description = "Gets/sets the height of the header."
   HeaderHeight = m_cHeader.Height
End Property
Public Property Let HeaderHeight(ByVal lHeight As Long)
   If (lHeight = -1) Then
      m_cHeader.Height = m_cHeader.IdealHeight
   Else
      m_cHeader.Height = lHeight
   End If
   pResizeHeader
   Draw
   PropertyChanged "HeaderHeight"
End Property
Public Property Get HeaderDragReOrderColumns() As Boolean
Attribute HeaderDragReOrderColumns.VB_Description = "Gets/sets whether the grid's header columns can be dragged around to reorder them."
Attribute HeaderDragReOrderColumns.VB_ProcData.VB_Invoke_Property = ";Behavior"
   HeaderDragReOrderColumns = m_cHeader.DragReOrderColumns
End Property
Public Property Let HeaderDragReOrderColumns(ByVal bState As Boolean)
   m_cHeader.DragReOrderColumns = bState
   SetHeaders
   PropertyChanged "HeaderDragReOrderColumns"
End Property
Public Property Get HeaderButtons() As Boolean
Attribute HeaderButtons.VB_Description = "Gets/sets whether the grid's header has clickable buttons or not."
Attribute HeaderButtons.VB_ProcData.VB_Invoke_Property = ";Behavior"
   HeaderButtons = m_cHeader.HasButtons
End Property
Public Property Let HeaderButtons(ByVal bState As Boolean)
   m_cHeader.HasButtons = bState
   SetHeaders
   PropertyChanged "HeaderButtons"
End Property
Public Property Get HeaderHotTrack() As Boolean
Attribute HeaderHotTrack.VB_Description = "Gets/sets whether the grid's header tracks mouse movements and highlights the header column the mouse is over or not."
Attribute HeaderHotTrack.VB_ProcData.VB_Invoke_Property = ";Behavior"
   HeaderHotTrack = m_cHeader.HotTrack
End Property
Public Property Let HeaderHotTrack(ByVal bState As Boolean)
   m_cHeader.HotTrack = bState
   SetHeaders
   PropertyChanged "HeaderHotTrack"
End Property
Public Property Get HotTrack() As Boolean
Attribute HotTrack.VB_Description = "Gets/sets whether the grid cells are hot tracked with the mouse."
   HotTrack = m_bHotTrack
End Property
Public Property Let HotTrack(ByVal bState As Boolean)
   If Not (m_bHotTrack = bState) Then
      m_bHotTrack = bState
      PropertyChanged "HotTrack"
   End If
End Property
Public Property Get SelectionAlphaBlend() As Boolean
Attribute SelectionAlphaBlend.VB_Description = "Gets/sets whether the selection colour is alpha-blended with the background colour or not."
   SelectionAlphaBlend = m_bAlphaBlendSelection
End Property
Public Property Let SelectionAlphaBlend(ByVal bState As Boolean)
   If Not (m_bAlphaBlendSelection = bState) Then
      m_bAlphaBlendSelection = bState
      PropertyChanged "SelectionAlphaBlend"
   End If
End Property
Public Property Get SelectionOutline() As Boolean
Attribute SelectionOutline.VB_Description = "Gets/sets whether the selection is outlined or not.  DrawFocusRectangle must be False for this to work."
   SelectionOutline = m_bOutlineSelection
End Property
Public Property Let SelectionOutline(ByVal bState As Boolean)
   If Not (m_bOutlineSelection = bState) Then
      m_bOutlineSelection = bState
      PropertyChanged "SelectionOutline"
   End If
End Property
Private Function pbValid(ByVal lRow As Long, ByVal lCol As Long) As Boolean
   If (lCol > 0) And (lCol <= m_iCols) Then
      If (lRow > 0) And (lRow <= m_iRows) Then
         pbValid = True
      Else
         gErr 9, "Invalid Row Index"
      End If
   Else
      gErr 9, "Invalid Column Index"
   End If
End Function
Public Sub CellDetails( _
      ByVal lRow As Long, ByVal lCol As Long, _
      Optional ByVal sText As Variant, _
      Optional ByVal eTextAlign As ECGTextAlignFlags = DT_WORD_ELLIPSIS Or DT_SINGLELINE, _
      Optional ByVal lIconIndex As Long = -1, _
      Optional ByVal oBackColor As OLE_COLOR = CLR_NONE, _
      Optional ByVal oForeColor As OLE_COLOR = CLR_NONE, _
      Optional ByVal oFont As StdFont = Nothing, _
      Optional ByVal lIndent As Long = 0, _
      Optional ByVal lExtraIconIndex As Long = -1, _
      Optional ByVal lItemData As Long = 0 _
   )
Attribute CellDetails.VB_Description = "Sets multiple format details for a cell at the same time. Quicker than calling the properties individually."
   If (lRow > m_iRows) Then
      Rows = lRow
   End If
   If pbValid(lRow, lCol) Then
      With m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow)
         .sText = sText
         .eTextFlags = eTextAlign Or DT_NOPREFIX
         .bDirtyFlag = True
         .oBackColor = oBackColor
         .oForeColor = oForeColor
         .iIconIndex = lIconIndex
         .lExtraIconIndex = lExtraIconIndex
         .lIndent = lIndent
         If Not (oFont Is Nothing) Then
            .iFntIndex = plAddFontIfRequired(oFont)
         End If
         .bDirtyFlag = True
         .lItemData = lItemData
      End With
      Draw
   End If
End Sub
Public Property Get cell(ByVal lRow As Long, ByVal lCol As Long) As cGridCell
Attribute cell.VB_Description = "Gets an object representing a cell in the grid."
   
   If pbValid(lRow, lCol) Then
      Dim cS As New cGridCell
      Dim lGridCellRow As Long
      Dim oFont As StdFont
      Dim bHot As Boolean
            
      lGridCellRow = m_tRows(lRow).lGridCellArrayRow
      If (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iFntIndex = 0) Then
      Else
         Set oFont = CellFont(lRow, lCol)
      End If
      If (m_bHotTrack) And (m_bEnabled) Then
         If (m_bRowMode) Then
            bHot = (m_lHotTrackRow = lRow)
         Else
            bHot = ((m_lHotTrackRow = lRow) And (m_tCols(lCol).lCellColIndex = m_lHotTrackCol))
         End If
      End If
      
      cS.InitWithData Me, lRow, lCol, _
         oFont, _
         m_tCells(lCol, lGridCellRow).eTextFlags And Not DT_CALCRECT Or DT_NOPREFIX, _
         m_tCells(lCol, lGridCellRow).iIconIndex, _
         m_tCells(lCol, lGridCellRow).oBackColor, _
         m_tCells(lCol, lGridCellRow).oForeColor, _
         m_tCells(lCol, lGridCellRow).lIndent, _
         m_tCells(lCol, lGridCellRow).lExtraIconIndex, _
         m_tCells(lCol, lGridCellRow).sText, _
         m_tCells(lCol, lGridCellRow).lItemData, _
         m_tCells(lCol, lGridCellRow).bSelected, _
         bHot
      Set cell = ObjectFromPtr(ObjPtr(cS))
   End If
End Property
Public Property Let cell(ByVal lRow As Long, ByVal lCol As Long, ByRef cG As cGridCell)
   CellDetails lRow, lCol, cG.Text, cG.TextAlign, cG.IconIndex, cG.BackColor, cG.ForeColor, cG.Font, cG.Indent, cG.ExtraIconIndex
End Property

Public Property Get NewCellFormatObject() As cGridCell
Attribute NewCellFormatObject.VB_Description = "Returns a new cell object.  This can be used to set the attributes of a cell added using the Cell property."
   Dim cS As New cGridCell
   Set NewCellFormatObject = ObjectFromPtr(ObjPtr(cS))
End Property

Private Function plAddFontIfRequired(ByVal oFont As StdFont) As Long
Dim iFnt As Long
Dim tULF As LOGFONT
   For iFnt = 1 To m_iFontCount
      If (oFont.Name = m_Fnt(iFnt).Name) And (oFont.Bold = m_Fnt(iFnt).Bold) And (oFont.Italic = m_Fnt(iFnt).Italic) And (oFont.Underline = m_Fnt(iFnt).Underline) And (oFont.Size = m_Fnt(iFnt).Size) And (oFont.Strikethrough = m_Fnt(iFnt).Strikethrough) Then
         plAddFontIfRequired = iFnt
         Exit Function
      End If
   Next iFnt
   m_iFontCount = m_iFontCount + 1
   ReDim Preserve m_Fnt(1 To m_iFontCount) As StdFont
   ReDim Preserve m_hFnt(1 To m_iFontCount) As Long
   Set m_Fnt(m_iFontCount) = New StdFont
   With m_Fnt(m_iFontCount)
      .Name = oFont.Name
      .Size = oFont.Size
      .Bold = oFont.Bold
      .Italic = oFont.Italic
      .Underline = oFont.Underline
      .Strikethrough = oFont.Strikethrough
   End With
   pOLEFontToLogFont m_Fnt(m_iFontCount), UserControl.hdc, tULF
   m_hFnt(m_iFontCount) = CreateFontIndirect(tULF)
   plAddFontIfRequired = m_iFontCount
End Function
Public Property Get RowHeight(ByVal lRow As Long) As Long
Attribute RowHeight.VB_Description = "Gets/sets the height of a row in the grid."
   If (lRow > 0) And (lRow <= m_iRows) Then
      RowHeight = m_tRows(lRow).lHeight
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Let RowHeight(ByVal lRow As Long, ByVal lHeight As Long)
Dim lCalcRow As Long
Dim lPreviousRowHeight As Long
Dim lPreviousStartY As Long
Dim tR As RECT

   If (lRow > 0) Then
      If (lRow > m_iRows) Then
         ReDim Preserve m_tRows(0 To lRow) As tRowPosition
         ' TODO need a check for adding a row into the split here
         For lCalcRow = m_iRows + 1 To lRow
            m_tRows(lCalcRow).bVisible = True
            m_tRows(lCalcRow).lHeight = m_lDefaultRowHeight
            m_tRows(lCalcRow).lStartY = m_tRows(lCalcRow - 1).lStartY + m_tRows(lCalcRow - 1).lHeight
         Next lCalcRow
         m_iRows = lRow
      End If
      
      If Not (lHeight = m_tRows(lRow).lHeight) Then
         m_tRows(lRow).lHeight = lHeight
         m_tRows(0).lHeight = 0
         If (lRow <= m_lSplitRow) Then
            For lCalcRow = lRow To m_lSplitRow
               m_tRows(lCalcRow).lStartY = m_tRows(lCalcRow - 1).lStartY + m_tRows(lCalcRow - 1).lHeight
            Next lCalcRow
            If (m_iRows > m_lSplitRow) Then
               m_tRows(m_lSplitRow + 1).lStartY = 0
            End If
         End If
         
         For lCalcRow = m_lSplitRow + 2 To m_iRows
            If (m_tRows(lCalcRow - 1).bVisible) Then
               m_tRows(lCalcRow).lStartY = m_tRows(lCalcRow - 1).lStartY + m_tRows(lCalcRow - 1).lHeight
            Else
               m_tRows(lCalcRow).lStartY = m_tRows(lCalcRow - 1).lStartY
            End If
         Next lCalcRow
      End If
      If (lHeight > m_lMaxRowHeight) Then
         BuildMemDC lHeight
      End If
      
   Else
      gErr 9, "Row subscript out of range"
   End If
End Property

Private Sub BuildMemDC(ByVal lHeight As Long)
Dim tR As RECT
Dim hBr As Long
   
   If (m_hBmp <> 0) Then
      If (m_hBmpOld <> 0) Then
         SelectObject m_hDC, m_hBmpOld
      End If
      If (m_hBmp <> 0) Then
         DeleteObject m_hBmp
      End If
      m_hBmp = 0
      m_hBmpOld = 0
   End If
   
   If (m_hDC = 0) Then
      m_hDC = CreateCompatibleDC(UserControl.hdc)
   Else
      SelectObject m_hDC, m_hFntOldDC
   End If
   
   If (m_hDC <> 0) Then
      m_lMaxRowHeight = lHeight
      
      m_hBmp = CreateCompatibleBitmap(UserControl.hdc, m_lMaxMemDCWidth, lHeight)
      If (m_hBmp <> 0) Then
         m_hBmpOld = SelectObject(m_hDC, m_hBmp)
         If (m_hBmpOld = 0) Then
            DeleteObject m_hBmp
            DeleteObject m_hDC
            m_hBmp = 0
            m_hDC = 0
         Else
            SetTextColor m_hDC, TranslateColor(UserControl.ForeColor)
            SetBkColor m_hDC, TranslateColor(UserControl.BackColor)
            SetBkMode m_hDC, TRANSPARENT
            m_hFntOldDC = SelectObject(m_hDC, m_hFntDC)
            tR.Right = Screen.Width \ Screen.TwipsPerPixelX
            tR.Bottom = lHeight
            hBr = CreateSolidBrush(TranslateColor(UserControl.BackColor))
            FillRect m_hDC, tR, hBr
            DeleteObject hBr
         End If
      Else
         DeleteObject m_hDC
         m_hDC = 0
      End If
   End If
End Sub
Public Property Get ColumnOrder(ByVal vKey As Variant) As Long
Attribute ColumnOrder.VB_Description = "Gets/sets the order of a column in the control."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnOrder = lCol
   End If
End Property
Public Property Let ColumnOrder(ByVal vKey As Variant, ByVal lOrder As Long)
Dim lCol As Long
Dim tSwap As tColPosition
Dim lStartX As Long
Dim i As Long

   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      If (lCol <> lOrder) Then
         ' We want to swap item lCol in the m_tCols array with
         ' the item at position lOrder, then recreate the header
         LSet tSwap = m_tCols(lCol)
         LSet m_tCols(lCol) = m_tCols(lOrder)
         LSet m_tCols(lOrder) = tSwap
         For i = 1 To m_iCols
            m_tCols(i).lStartX = lStartX
            If (m_tCols(i).bVisible And m_tCols(i).iGroupOrder = -1) Then
               lStartX = lStartX + m_tCols(i).lWidth
            End If
         Next i
         SetHeaders
         m_bDirty = True
         Draw
      End If
   End If
End Property
Public Property Get ColumnSortType(ByVal vKey As Variant) As ECGSortTypeConstants
Attribute ColumnSortType.VB_Description = "Gets/sets a variable which you can use to store the current column sort type."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnSortType = m_tCols(lCol).eSortType
   End If
End Property
Public Property Let ColumnSortType(ByVal vKey As Variant, ByVal eSortType As ECGSortTypeConstants)
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      m_tCols(lCol).eSortType = eSortType
   End If
End Property
Public Property Get ColumnSortOrder(ByVal vKey As Variant) As ECGSortOrderConstants
Attribute ColumnSortOrder.VB_Description = "Gets/sets a variable which you can use to store the current column sort order."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnSortOrder = m_tCols(lCol).eSortOrder
   End If
End Property
Public Property Let ColumnSortOrder(ByVal vKey As Variant, ByVal eSortOrder As ECGSortOrderConstants)
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      m_tCols(lCol).eSortOrder = eSortOrder
   End If
End Property

Public Property Get KeySearchColumn() As Long
Attribute KeySearchColumn.VB_Description = "Gets/sets the column in the grid to be used for automatic searching when the grid is not being edited.  Set to 0 to prevent automatic searching."
Attribute KeySearchColumn.VB_MemberFlags = "400"
   KeySearchColumn = m_iSearchCol
End Property
Public Property Let KeySearchColumn(ByVal lCol As Long)
   m_iSearchCol = lCol
End Property
Public Property Get ColumnWidth(ByVal vKey As Variant) As Long
Attribute ColumnWidth.VB_Description = "Gets/sets the width of a column in the grid."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnWidth = m_tCols(lCol).lWidth
   End If
End Property
Public Property Let ColumnWidth(ByVal vKey As Variant, ByVal lWidth As Long)
Dim lCalcCol As Long
Dim lCellColIndex As Long
Dim lCol As Long
Dim lLastWidth As Long
Dim iVisibleCols As Long
   
   lCol = ColumnIndexByVariant(vKey)
   
   If (lCol > 0) Then
      If (m_tCols(lCol).lWidth = lWidth) Then
         'Exit Property
      End If
   
      If (lCol > m_iCols) Then
         ReDim Preserve m_tCols(0 To lCol) As tColPosition
         For lCalcCol = m_iCols + 1 To lCol
            m_tCols(lCalcCol).lWidth = m_lDefaultColumnWidth
            m_tCols(lCalcCol).lCorrectWidth = m_lDefaultColumnWidth
            m_tCols(lCalcCol).bVisible = True ' SPM: TODO Doesn't look right
         Next lCalcCol
         m_iCols = lCol
      End If
      
      m_tCols(0).lWidth = 0
      m_tCols(0).lCorrectWidth = 0
      m_tCols(lCol).lWidth = lWidth
      m_tCols(lCol).lCorrectWidth = lWidth
      
      For lCalcCol = 1 To m_iCols
         If (m_tCols(lCalcCol).bVisible And m_tCols(lCalcCol).iGroupOrder = -1) Then
            m_tCols(lCalcCol).lStartX = m_tCols(lCalcCol - 1).lStartX + lLastWidth
            lLastWidth = m_tCols(lCalcCol).lWidth
         Else
            m_tCols(lCalcCol).lStartX = m_tCols(lCalcCol - 1).lStartX
         End If
      Next lCalcCol
               
      If (m_tCols(lCol).lHeaderColIndex - 1) >= 0 Then ' Finally fixed this one 2003-12-20
         If m_cHeader.ColumnWidth(m_tCols(lCol).lHeaderColIndex - 1) <> lWidth Then
            m_cHeader.ColumnWidth(m_tCols(lCol).lHeaderColIndex - 1) = lWidth
         End If
      End If
      
   End If

End Property
Public Property Get ColumnHeader(ByVal vKey As Variant) As String
Attribute ColumnHeader.VB_Description = "Gets/sets the text to appear in a column header."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnHeader = m_tCols(lCol).sHeader
   End If
End Property
Public Property Let ColumnHeader(ByVal vKey As Variant, ByVal sHeader As String)
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      m_tCols(lCol).sHeader = sHeader
      If (m_tCols(lCol).bVisible) And lCol <> m_iRowTextCol Then
         m_cHeader.ColumnHeader(m_tCols(lCol).lHeaderColIndex - 1) = sHeader
      End If
   End If
End Property
Public Property Get ColumnFormatString(ByVal vKey As Variant) As String
Attribute ColumnFormatString.VB_Description = "Gets/sets a format string used to format all text in the column.  Format strings are the same as those used in the VB Format$ function."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnFormatString = m_tCols(lCol).sFmtString
   End If
End Property
Public Property Let ColumnFormatString(ByVal vKey As Variant, ByVal sFmtString As String)
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      m_tCols(lCol).sFmtString = sFmtString
      If (m_tCols(lCol).bVisible) Then
         m_bDirty = True
         Draw
      End If
   End If
End Property

Public Property Get ColumnFixedWidth(ByVal vKey As Variant) As Boolean
Attribute ColumnFixedWidth.VB_Description = "Gets/sets whether the specified column has fixed width or not."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnFixedWidth = m_tCols(lCol).bFixedWidth
   End If
End Property
Public Property Let ColumnFixedWidth(ByVal vKey As Variant, ByVal bState As Boolean)
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      m_tCols(lCol).bFixedWidth = bState
   End If
End Property

Public Property Get ColumnIsRowTextColumn(ByVal vKey As Variant) As Boolean
Attribute ColumnIsRowTextColumn.VB_Description = "Gets whether this column is the row text column for the grid.  The row text column must be the last column in the grid."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnIsRowTextColumn = m_tCols(lCol).bRowTextCol
   End If
End Property

Public Property Get RowTextColumnIndex() As Long
Attribute RowTextColumnIndex.VB_Description = "Gets the index of the row text column if the grid has one, otherwise returns 0."
Dim i As Long
   For i = 1 To m_iCols
      If (m_tCols(i).bRowTextCol) Then
         RowTextColumnIndex = m_tCols(i).lCellColIndex
         Exit For
      End If
   Next i
End Property

Public Property Get ColumnVisible(ByVal vKey As Variant) As Boolean
Attribute ColumnVisible.VB_Description = "Gets/sets whether a column will be visible or not in the grid."
Dim lCol As Long
   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      ColumnVisible = m_tCols(lCol).bVisible
   End If
End Property
Public Property Let ColumnVisible(ByVal vKey As Variant, ByVal bState As Boolean)
Dim lCol As Long
Dim lHeaderCol As Long
Dim lStretchCol As Long

   lCol = ColumnIndexByVariant(vKey)
   If (lCol > 0) Then
      If Not (bState = m_tCols(lCol).bVisible) Then
                  
         If Not bState Then ' Making the column invisible
            If m_tCols(lCol).bIsGrouped Then
               ColumnIsGrouped(vKey) = False
               lCol = ColumnIndexByVariant(vKey)
            End If
            m_tCols(lCol).lHeaderColIndex = 0
            m_tCols(lCol).lWidth = m_tCols(lCol).lCorrectWidth
         End If
         
         m_tCols(lCol).bVisible = bState
         
         If Not (lCol = m_iRowTextCol) Then
            If (bState) Then
               If (m_bStretchLastColumnToFit) Then
                  ' Confirm whether this column occurs subsequently to
                  ' the last visible column:
                  If Not (m_lStretchedColumn = 0) Then
                     lStretchCol = plColumnIndexByIndex(m_lStretchedColumn)
                     If (lStretchCol < lCol) Then
                        m_tCols(lStretchCol).lWidth = m_tCols(lStretchCol).lCorrectWidth
                        m_cHeader.StealthSetColumnWidth m_tCols(lStretchCol).lHeaderColIndex - 1, m_tCols(lStretchCol).lWidth
                        m_lStretchedColumn = 0
                     End If
                  End If
               End If
            End If
            ColumnWidth(m_tCols(lCol).lCellColIndex) = m_tCols(lCol).lWidth
            SetHeaders
            m_bDirty = True
            Draw
         End If
         
      End If
   End If
End Property
Public Property Get StretchLastColumnToFit() As Boolean
Attribute StretchLastColumnToFit.VB_Description = "Gets/sets whether the last column is stretched to fit when the control is wider than all of the visible columns."
   StretchLastColumnToFit = m_bStretchLastColumnToFit
End Property
Public Property Let StretchLastColumnToFit(ByVal bState As Boolean)
   If Not (m_bStretchLastColumnToFit = bState) Then
      m_bStretchLastColumnToFit = bState
      PropertyChanged "StretchLastColumnToFit"
   End If
End Property
Public Property Get Columns() As Long
Attribute Columns.VB_Description = "Gets the number of columns in the grid, including hidden and RowText columns."
   Columns = m_iCols
End Property
Public Property Get Rows() As Long
Attribute Rows.VB_Description = "Gets/sets the number of rows in the grid."
   Rows = m_iRows
End Property
Public Property Let Rows(ByVal lRows As Long)
Dim lStartRow As Long
Dim lRow As Long
Dim iCol As Long
Dim lGridCellArrayRow As Long
      
   If (lRows > 0) Then
      If (m_iCols = 0) Then
         gErr 9, "Attempt to add rows with no columns."
      Else
         If (lRows < m_iRows) Then
            For lRow = lRows + 1 To m_iRows
               m_colGarbageRows.Add m_tRows(lRow).lGridCellArrayRow, CStr(m_tRows(lRow).lGridCellArrayRow)
            Next lRow
         End If
      
         ReDim Preserve m_tRows(0 To lRows) As tRowPosition
         
         If (lRows > m_iTotalCellRows) Then
            ReDim Preserve m_tCells(1 To m_iCols, 1 To lRows) As tGridCell
            m_iTotalCellRows = lRows
         End If
         
         If (lRows > m_iRows) Then
            lStartRow = m_iRows + 1
            RowHeight(lRows) = m_lDefaultRowHeight
            For lRow = lStartRow To lRows
               lGridCellArrayRow = lRow
               If (m_colGarbageRows.Count > 0) Then
                  lGridCellArrayRow = m_colGarbageRows(1)
                  m_colGarbageRows.Remove 1
               End If
               m_tRows(lRow).lGridCellArrayRow = lGridCellArrayRow
               For iCol = 1 To m_iCols
                  LSet m_tCells(iCol, lGridCellArrayRow) = m_tDefaultCell
               Next iCol
            Next lRow
            m_iRows = lRows
         Else
            m_iRows = lRows
            If (m_iLastSelRow > m_iRows) Then
               m_iLastSelRow = m_iRows
            End If
         End If
         m_bDirty = True
         Draw
      End If
   Else
      gErr 9, "Row subscript out of range"
   End If
      
End Property
Private Sub DrawText(ByVal hdc As Long, ByVal sString As String, ByVal lCount As Long, tR As RECT, ByVal lFlags As Long)
Dim lPtr As Long
Dim tIR As RECT
   LSet tIR = tR
   If Not (lFlags And DT_CALCRECT) = DT_CALCRECT Then
      InflateRect tIR, -2, 0
   End If
   If (IsNt) Then
      lPtr = StrPtr(sString)
      If Not (lPtr = 0) Then
         DrawTextW hdc, lPtr, -1, tIR, lFlags
      End If
   Else
      DrawTextA hdc, sString, -1, tIR, lFlags
   End If
   If (lFlags And DT_CALCRECT) = DT_CALCRECT Then
      LSet tR = tIR
      InflateRect tR, 2, 0
   End If
End Sub

Private Sub pSelectMarquee(ByVal lNewRow As Long, ByVal lNewCol As Long)
Dim iStartCol As Long
Dim iEndCol As Long
Dim iStartRow As Long
Dim iEndRow As Long
Dim lRow As Long
Dim lCol As Long
Dim bNewState As Boolean
Dim bChanged As Boolean
Dim iIntMarqueeStartCol As Long
Dim iIntMarqueeEndCol As Long
Dim iIntNewCol As Long
Dim bRedraw As Boolean
   
   If (lNewRow > 0) And (lNewCol > 0) Then
   
      If (m_bRowMode) Then
      
         If (m_lMarqueeEndRow = 0) Then
            m_lMarqueeEndRow = lNewRow
         End If
      
         If (m_lMarqueeEndRow < m_lMarqueeStartRow) Then
            iStartRow = m_lMarqueeEndRow
            iEndRow = m_lMarqueeStartRow
         Else
            iStartRow = m_lMarqueeStartRow
            iEndRow = m_lMarqueeEndRow
         End If
      
         If (lNewRow > iEndRow) Then
            iEndRow = lNewRow
         End If
         If (lNewRow < iStartRow) Then
            iStartRow = lNewRow
         End If
      
         bRedraw = m_bRedraw
         m_bRedraw = False
         For lRow = iStartRow To iEndRow
            bNewState = pbRowInMarquee(lRow, m_lMarqueeStartRow, lNewRow)
            If Not (CellSelected(lRow, 1) = bNewState) Then
               CellSelected(lRow, 1) = bNewState
               bChanged = True
            End If
         Next lRow
         m_bRedraw = bRedraw
         
      End If
            
      m_lMarqueeEndRow = lNewRow
      m_lMarqueeEndCol = lNewCol
      
      m_iSelRow = m_lMarqueeStartRow
      m_iSelCol = m_lMarqueeStartCol
      
      If (bChanged) Then
         Draw
      End If
            
   End If
End Sub

Private Function pbRowInMarquee( _
      ByVal lRow As Long, _
      ByVal lMarqueeStartRow As Long, _
      ByVal lMarqueeEndRow As Long _
   ) As Boolean
Dim lSwap As Long
   If (lMarqueeEndRow < lMarqueeStartRow) Then
      lSwap = lMarqueeEndRow
      lMarqueeEndRow = lMarqueeStartRow
      lMarqueeStartRow = lSwap
   End If
   If (lRow >= lMarqueeStartRow) And (lRow <= lMarqueeEndRow) Then
      pbRowInMarquee = True
   End If
End Function
Private Function pbInMarqueeRect( _
      ByVal lRow As Long, _
      ByVal lCol As Long, _
      ByVal lMarqueeStartRow As Long, _
      ByVal lMarqueeStartCol As Long, _
      ByVal lMarqueeEndRow As Long, _
      ByVal lMarqueeEndCol As Long _
   ) As Boolean
Dim lSwap As Long
   If (lMarqueeEndRow < lMarqueeStartRow) Then
      lSwap = lMarqueeEndRow
      lMarqueeEndRow = lMarqueeStartRow
      lMarqueeStartRow = lSwap
   End If
   If (lMarqueeEndCol < lMarqueeStartCol) Then
      lSwap = lMarqueeEndCol
      lMarqueeEndCol = lMarqueeStartCol
      lMarqueeStartCol = lSwap
   End If
   If (lRow >= lMarqueeStartRow) And (lRow <= lMarqueeEndRow) Then
      If (lCol >= lMarqueeStartCol) And (lCol <= lMarqueeEndCol) Then
         pbInMarqueeRect = True
      End If
   End If
End Function

Private Sub pAddRow( _
      ByVal lRowBefore As Long, _
      ByVal lItemData As Long, _
      ByVal bVisible As Boolean, _
      ByVal lHeight As Long, _
      ByVal bGroupRow As Boolean, _
      ByVal lGroupColStartIndex As Long _
   )
   
Dim iRow As Long
Dim iCol As Long
Dim lOffset As Long
Dim lStartY As Long
Dim bSelDone As Boolean
Dim tR As RECT
Dim lGridCellArrayRow As Long
Dim copySize As Long
Dim i As Long
Dim j As Long

   ' Prepare for the new row
   If (lHeight < 0) Then
      lHeight = m_lDefaultRowHeight
   End If
   
   m_iRows = m_iRows + 1
   ReDim Preserve m_tRows(0 To m_iRows) As tRowPosition
   
   If (m_colGarbageRows.Count = 0) Then
      If (m_iTotalCellRows > m_iRows) Then
      Else
         m_iTotalCellRows = m_iTotalCellRows + 128
         ReDim Preserve m_tCells(1 To m_iCols, 1 To m_iTotalCellRows) As tGridCell
         For i = m_iTotalCellRows - 127 To m_iTotalCellRows
            For j = 1 To m_iCols
               LSet m_tCells(j, i) = m_tDefaultCell
            Next j
         Next i
      End If
      lGridCellArrayRow = m_iRows
   Else
      lGridCellArrayRow = m_colGarbageRows(1)
      m_colGarbageRows.Remove 1
   End If
      
   ' Now add the row, depending on whether we're adding or inserting:
   
   If (lRowBefore > 0) And (m_iRows > 0) Then
      
      ' This is an insert
      copySize = LenB(m_tRows(0))
      copySize = copySize * (m_iRows - lRowBefore)
      CopyMemory ByVal VarPtr(m_tRows(lRowBefore + 1)), ByVal VarPtr(m_tRows(lRowBefore)), copySize
      
      If (lRowBefore > m_lSplitRow + 1) Then
         lStartY = m_tRows(lRowBefore - 1).lStartY
         If (m_tRows(lRowBefore - 1).bVisible) Then
            lStartY = lStartY + m_tRows(lRowBefore - 1).lHeight
         End If
      End If
      
      With m_tRows(lRowBefore)
         .bGroupRow = bGroupRow
         .lGroupStartColIndex = lGroupColStartIndex
         .lGroupIndentLevel = 0
         .bVisible = bVisible
         .lHeight = lHeight
         .lStartY = lStartY
         .lGridCellArrayRow = lGridCellArrayRow
         .lItemData = lItemData
      End With
      
      For iCol = 1 To m_iCols
         LSet m_tCells(iCol, lGridCellArrayRow) = m_tDefaultCell
      Next iCol
      
      If (m_iSelRow >= lRowBefore) Then
         If Not (m_bMultiSelect) Then
            m_iSelRow = m_iSelRow + 1
            pSingleModeSelect
         End If
      End If
      
   Else
   
      ' Add row to end:
      With m_tRows(m_iRows)
         .bGroupRow = bGroupRow
         .lGroupStartColIndex = lGroupColStartIndex
         .bVisible = bVisible
         .lHeight = lHeight
         .lItemData = lItemData
         If (m_iRows > m_lSplitRow) Then
            If (m_iRows > m_lSplitRow + 1) Then
               .lStartY = m_tRows(m_iRows - 1).lStartY - (m_tRows(m_iRows - 1).bVisible * m_tRows(m_iRows - 1).lHeight)
            Else
               .lStartY = 0
            End If
         ElseIf (m_iRows > 1) Then
            .lStartY = m_tRows(m_iRows - 1).lStartY - (m_tRows(m_iRows - 1).bVisible * m_tRows(m_iRows - 1).lHeight)
         Else
            .lStartY = 0
         End If
         .lGridCellArrayRow = lGridCellArrayRow
      End With
      
      For iCol = 1 To m_iCols
         LSet m_tCells(iCol, lGridCellArrayRow) = m_tDefaultCell
      Next iCol
   End If
   
   If (lHeight > m_lMaxRowHeight) Then
      BuildMemDC lHeight
   End If
   
End Sub

''' <summary>
''' Adds or inserts a new row into the grid
''' </summary>
''' <param name="lRowBefore">Optional row to insert before</param>
''' <param name="lItemData">Item data used to identify the row.</param>
''' <param name="bVisible">Whether row is visible or not</param>
''' <param name="lHeight">Height of row, or -1 to use <c>DefaultRowHeight</c></param>
''' <param name="lGroupColStartIndex">The column at which the group row text column
''' starts rendering</param>
Public Sub AddRow( _
      Optional ByVal lRowBefore As Long = -1, _
      Optional ByVal lItemData As Long = 0, _
      Optional ByVal bVisible As Boolean = True, _
      Optional ByVal lHeight As Long = -1, _
      Optional ByVal lGroupColStartIndex As Long = 0 _
   )
Attribute AddRow.VB_Description = "Adds or inserts a new row into the grid."
   
   pAddRow lRowBefore, lItemData, bVisible, lHeight, False, lGroupColStartIndex
   If (lRowBefore > 0) Then
      pRowVisibility lRowBefore
   End If
   
   m_bDirty = True
   Draw

End Sub

''' <summary>
''' Shifts the last row in the grid to it's correct
''' location in the sort, taking into account any grouping
''' that has been applied
''' </summary>
''' <returns>The new row location</returns>
Public Function ShiftLastRowToSortLocation() As Long
Attribute ShiftLastRowToSortLocation.VB_Description = "Moves the last row in the grid to the correct position given the current grouping and/or sorting options."
   
   If (m_cSort.Count > 0) Then
      '
      Dim iResult As Long
      Dim lRow As Long
      Dim i As Long
      Dim j As Long
      Dim iCol As Long
      Dim lSwap As Long
      Dim bAfterGroupRow As Boolean
      Dim bMatch As Boolean
      Dim lRowBefore As Long
      Dim lRowCompare As Long
      Dim lItemData As Long
      Dim sCompText As String
      Dim sTheText As String
      
      lRow = m_cSort.FindInsertLocation(m_tCells, m_tRows, m_lSplitRow + 1, m_iRows, iResult)
      
      If (iResult = 0) Then
         ' This item belongs to a pre-existing group, we should insert after
         If (lRow >= m_iRows - 1) Then
            ' It's already in the correct place, we just need to set the
            ' expand/collapse state correctly (TODO)
            ShiftLastRowToSortLocation = m_iRows
         Else
            ' Move all rows
            If (m_tRows(lRow).bGroupRow) Then
               lRow = lRow + 1
               bAfterGroupRow = True
            End If
            lSwap = m_tRows(m_iRows).lGridCellArrayRow
            For i = m_iRows - 1 To lRow Step -1
               LSet m_tRows(i + 1) = m_tRows(i)
            Next i
            m_tRows(lRow).lGridCellArrayRow = lSwap
            m_tRows(lRow).bGroupRow = False
            m_tRows(lRowBefore).lGroupIndentLevel = 0
            If (bAfterGroupRow) Then
               If (m_tRows(lRow + 1).bCollapsed) Then
                  m_tRows(lRow).bCollapsed = m_tRows(lRow).bVisible
               End If
            End If
            
            pRowVisibility lRow
            m_bDirty = True
            Draw
            
            ShiftLastRowToSortLocation = lRow
         End If
      Else
         Dim lLastSortGroupColumn As Long
      
         lLastSortGroupColumn = m_cSort.GetLastGroupSortColumn
         
         ' A new group is needed for this item
         If (iResult = -1) Then ' insert before
            lRowBefore = lRow
            lRowCompare = lRow - 1
         Else  ' insert after
            lRowBefore = lRow + 1
            lRowCompare = lRow
         End If
         
         If (lLastSortGroupColumn > 0) Then
            
            ' Check each of the sort columns in the prior row to see
            ' if they match to evaluate which groups we need to add
            bMatch = True
                           
            ReDim vLastItem(1 To m_cHeader.ColumnGroupCount) As Variant
            For i = 1 To m_cHeader.ColumnGroupCount
                                       
               iCol = m_cSort.SortColumn(i)
               ' Does the previous row's column match?
               If (m_cSort.SortType(i) = CCLSortIcon) Then
                  vLastItem(i) = m_tCells(iCol, m_tRows(m_iRows).lGridCellArrayRow).iIconIndex
                  If (lRowCompare <= 0) Then
                     lItemData = m_tRows(m_iRows).lItemData
                     bMatch = False
                  Else
                     If Not (m_tCells(iCol, m_tRows(m_iRows).lGridCellArrayRow).iIconIndex = m_tRows(lRowCompare).lGridCellArrayRow) Then
                        lItemData = m_tRows(m_iRows).lItemData
                        bMatch = False
                     End If
                  End If
               Else
                  If IsMissing(m_tCells(iCol, m_tRows(m_iRows).lGridCellArrayRow).sText) Then
                     sCompText = "(none)"
                  Else
                     sCompText = m_tCells(iCol, m_tRows(m_iRows).lGridCellArrayRow).sText
                     If (Len(m_tCols(m_cSort.GridColumnArrayIndex(i)).sFmtString) > 0) Then
                        sCompText = Format$(sCompText, m_tCols(m_cSort.GridColumnArrayIndex(i)).sFmtString)
                     End If
                  End If
                  vLastItem(i) = sCompText
                  
                  If (lRowCompare <= 0) Then
                     lItemData = m_tRows(m_iRows).lItemData
                     bMatch = False
                  Else
                     If IsMissing(m_tCells(iCol, m_tRows(lRowCompare).lGridCellArrayRow).sText) Then
                        sTheText = "(none)"
                     Else
                        sTheText = m_tCells(iCol, m_tRows(lRowCompare).lGridCellArrayRow).sText
                        If (Len(m_tCols(m_cSort.GridColumnArrayIndex(i)).sFmtString) > 0) Then
                           sTheText = Format$(sTheText, m_tCols(m_cSort.GridColumnArrayIndex(i)).sFmtString)
                        End If
                     End If
                     
                     If Not (StrComp(sTheText, sCompText) = 0) Then
                        lItemData = m_tRows(m_iRows).lItemData
                        bMatch = False
                     End If
                  End If
                  
               End If
                  
               If Not (bMatch) Then
                  ' Need to add a grouping row for this:
                  pAddRow lRowBefore, lItemData, True, m_lDefaultRowHeight, True, i
                  
                  If (m_cSort.SortType(i) = CCLSortIcon) Then
                     CellDetails lRowBefore, m_iRowTextCol, , DT_VCENTER Or DT_SINGLELINE Or DT_WORD_ELLIPSIS Or DT_LEFT, vLastItem(i), m_oGroupRowBackColor, m_oGroupRowForeColor, , , , m_cSort.GridColumnArrayIndex(i)
                  Else
                     CellDetails lRowBefore, m_iRowTextCol, vLastItem(i), DT_VCENTER Or DT_SINGLELINE Or DT_WORD_ELLIPSIS Or DT_LEFT, , m_oGroupRowBackColor, m_oGroupRowForeColor, , , , m_cSort.GridColumnArrayIndex(i)
                  End If
                  CellDetails lRowBefore, iCol, vLastItem(i)
                  For j = 1 To i
                     CellDetails lRowBefore, m_cSort.SortColumn(j), vLastItem(j)
                  Next j
                  m_tRows(lRowBefore).bGroupRow = True
                  m_tRows(lRowBefore).lGroupIndentLevel = i
                     
                  lRowBefore = lRowBefore + 1
               End If
               
            Next i
            
            ' Ok with that out of the way we can add the new row:
            lSwap = m_tRows(m_iRows).lGridCellArrayRow
            For i = m_iRows - 1 To lRowBefore Step -1
               LSet m_tRows(i + 1) = m_tRows(i)
            Next i
            m_tRows(lRowBefore).lGridCellArrayRow = lSwap
            m_tRows(lRowBefore).lGroupIndentLevel = 0
            m_tRows(lRowBefore).bCollapsed = m_tRows(lRowBefore).bVisible
            m_tRows(lRowBefore).bVisible = False
            m_tRows(lRowBefore).bGroupRow = False
            
            If (lRowBefore < lRow) Then
               lRow = lRowBefore
            End If
            If (lRowCompare < lRow) Then
               lRow = lRowCompare
            End If
            pRowVisibility lRow
            m_bDirty = True
            Draw
            
            ShiftLastRowToSortLocation = lRowBefore
            
         End If
      End If
      
      '
   Else
      ' no sort, nothing to do
      ShiftLastRowToSortLocation = m_iRows
   End If
   
End Function

Private Sub pInitCell( _
      ByVal lRow As Long, _
      ByVal lCol As Long _
   )
   LSet m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow) = m_tDefaultCell
End Sub
Private Sub pRemoveRow( _
      ByVal lRow As Long, _
      Optional ByVal bfixUpPositions As Boolean _
   )
Dim iRow As Long
Dim iCol As Long
Dim lOffset As Long
Dim copySize As Long
Dim bSelChange As Boolean

   If (m_iRows = 1) Then
      
      ' Clear grid:
      Clear False
      
   Else
      
      ' Remove this row:
      If (lRow = m_iRows) Then
         
         If (m_iSelRow = m_iRows) Then
            bSelChange = True
         End If
         
         ' Last row:
         m_colGarbageRows.Add m_tRows(m_iRows).lGridCellArrayRow, CStr(m_tRows(m_iRows).lGridCellArrayRow)
         m_iRows = m_iRows - 1
         ReDim Preserve m_tRows(0 To m_iRows) As tRowPosition
         
         If (bSelChange) Then
            m_iSelRow = m_iRows
            If Not (m_bMultiSelect) Then
               pSingleModeSelect
            End If
         End If
         
         m_bDirty = True
         Draw
         
      Else
         
         If (m_tRows(lRow).bVisible) Then
            lOffset = m_tRows(lRow).lHeight
         End If
                  
         m_colGarbageRows.Add m_tRows(lRow).lGridCellArrayRow, CStr(m_tRows(lRow).lGridCellArrayRow)
            
            ' non-optimised method
            'For iRow = lRow + 1 To m_iRows
            '   LSet m_tRows(iRow - 1) = m_tRows(iRow)
            '   m_tRows(iRow - 1).lStartY = m_tRows(iRow - 1).lStartY - lOffset
            'Next iRow
         copySize = LenB(m_tRows(0))
         copySize = copySize * (m_iRows - lRow)
         CopyMemory ByVal VarPtr(m_tRows(lRow)), ByVal VarPtr(m_tRows(lRow + 1)), copySize
         
         m_tRows(lRow).lStartY = m_tRows(lRow).lStartY - lOffset
         If (bfixUpPositions) Then
            pRowVisibility lRow
         End If

         If m_iSelRow >= lRow And (m_iSelRow > 1) Then
            m_iSelRow = m_iSelRow - 1
            If Not (m_bMultiSelect) Then
               pSingleModeSelect
            End If
         End If
         
         m_iRows = m_iRows - 1
         ReDim Preserve m_tRows(0 To m_iRows) As tRowPosition
         m_bDirty = True
         Draw
         
      End If
   End If
      
End Sub

Public Sub RemoveRow( _
      ByVal lRow As Long _
   )
Attribute RemoveRow.VB_Description = "Deletes a row from the grid."
   
   pRemoveRow lRow, True
   
End Sub

Public Property Get RowItemData(ByVal lRow As Long) As Long
Attribute RowItemData.VB_Description = "Gets/sets a long value associated with a row."
   If (lRow > 0) And (lRow <= m_iRows) Then
      RowItemData = m_tRows(lRow).lItemData
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Let RowItemData(ByVal lRow As Long, ByVal lItemData As Long)
   If (lRow > 0) And (lRow <= m_iRows) Then
      m_tRows(lRow).lItemData = lItemData
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property

Public Property Get RowVisible(ByVal lRow As Long) As Boolean
Attribute RowVisible.VB_Description = "Gets/sets whether a row is visible in the grid or not."
   If (lRow > 0) And (lRow <= m_iRows) Then
      RowVisible = m_tRows(lRow).bVisible
   Else
      gErr 9, "Invalid Row Subscript"
   End If
End Property
Public Property Let RowVisible(ByVal lRow As Long, ByVal bState As Boolean)
Dim lStartY As Long
Dim lCalcRow As Long
   If (lRow > 0) And (lRow <= m_iRows) Then
      
      ' Check if this row is in the split; if it is, then it is an invalid
      ' operation:
      If (lRow <= m_lSplitRow) Then
         gErr 9, "Cannot make a row within the split area invisible."
         Exit Property
      End If
   
      ' TODO: consider what happens if we're in a group and need expand/collapse
      m_tRows(lRow).bVisible = bState
      lStartY = m_tRows(lRow).lStartY
      ' Re-evaluate row sizes:
      For lCalcRow = lRow + 1 To m_iRows
         If (m_tRows(lCalcRow - 1).bVisible) Then
            lStartY = lStartY + m_tRows(lCalcRow - 1).lHeight
         End If
         m_tRows(lCalcRow).lStartY = lStartY
      Next lCalcRow
      
      m_bDirty = True
      pbScrollVisible
      Draw
      
   Else
      gErr 9, "Invalid Row Subscript"
   End If
   
End Property
Public Sub Clear(Optional ByVal bRemoveCols As Boolean = False)
Attribute Clear.VB_Description = "Clears the rows from the grid, optionally removing the columns too."
Dim bRedraw As Boolean
Dim iCol As Long
   
   bRedraw = m_bRedraw
   m_bRedraw = False
   
   If (m_cHeader.AllowGrouping) Then
      m_cHeader.AllowGrouping = False
   End If
   
   ' Clear the data
   Erase m_tCells
   m_iTotalCellRows = 0
   Set m_colGarbageRows = New Collection
   ' 2003-11-27: There was a bug here, the rows were not being
   ' removed since it was using the "m_tRow" variable not
   ' "m_tRows".  'Redim' can be very dangerous...
   ReDim m_tRows(0 To 0) As tRowPosition
   m_iRows = 0
   
   If (bRemoveCols) Then
      ' 19/10/99: (7)
      ReDim m_tCols(0 To 0) As tColPosition
      m_iCols = 0
      m_iRowTextCol = 0
      m_lRowTextStartCol = 0
      m_bHasRowText = False
   End If
   
   ' Reset all cached row/col variables
   m_iSelRow = 0
   m_iSelCol = 0
   m_iLastSelRow = 0
   m_iLastSelCol = 0
   m_iEditRow = 0
   m_iEditCol = 0
   m_lMarqueeStartRow = 0
   m_lMarqueeStartCol = 0
   m_lMarqueeEndRow = 0
   m_lMarqueeEndCol = 0

   
   ' Redraw grid
   m_bDirty = True
   m_bInAddRowRequest = m_bAddRowsOnDemand
   m_cScroll.Value(efsVertical) = 0
   m_cScroll.Value(efsHorizontal) = 0
   
   Redraw = bRedraw
   
End Sub

Public Property Get BorderStyle() As ECGBorderStyle
Attribute BorderStyle.VB_Description = "Gets/sets the border style for the control."
Attribute BorderStyle.VB_ProcData.VB_Invoke_Property = ";Appearance"
Attribute BorderStyle.VB_UserMemId = -504
   BorderStyle = m_eBorderStyle
End Property
Public Property Let BorderStyle(ByVal eStyle As ECGBorderStyle)
Dim lStyle As Long
   m_eBorderStyle = eStyle
   If (eStyle = ecgBorderStyleNone) Then
      UserControl.BorderStyle() = 0
   Else
      UserControl.BorderStyle() = 1
      lStyle = GetWindowLong(UserControl.hwnd, GWL_EXSTYLE)
      If (eStyle = ecgBorderStyle3dThin) Then
         lStyle = lStyle And Not WS_EX_CLIENTEDGE Or WS_EX_STATICEDGE
      Else
         lStyle = lStyle Or WS_EX_CLIENTEDGE And Not WS_EX_STATICEDGE
      End If
      SetWindowLong UserControl.hwnd, GWL_EXSTYLE, lStyle
      SetWindowPos UserControl.hwnd, 0, 0, 0, 0, 0, SWP_NOACTIVATE Or SWP_NOZORDER Or SWP_FRAMECHANGED Or SWP_NOSIZE Or SWP_NOMOVE
   End If
   PropertyChanged "BorderStyle"
End Property
Private Sub pScrollSetDirty(ByVal bNoOptimise As Boolean)
Dim iStartX As Long, iEndX As Long, iStartY As Long, iEndY As Long
Dim iStartRow As Long, iEndRow As Long
Dim iStartCol As Long, iEndCol As Long
Dim iRow As Long, iCol As Long
Dim iRowCount As Long
Dim iH As Long, iV As Long
Static s_iLastStartRow As Long, s_iLastEndRow As Long
Static s_iLastStartCol As Long, s_iLastEndCol As Long
Static s_iLastH As Long, s_iLastV As Long
Dim iToDirtyX As Long, iToDirtyY As Long
Dim iXStart As Long, iXEnd As Long
Dim iYStart As Long, iYEnd As Long
Dim tSR As RECT, tR As RECT, tJunk As RECT
Dim bJunk As Boolean
   
   'm_bDirty = True
   'Exit Sub
   If (m_iRows = 0) Or (m_iCols = 0) Then
      Exit Sub
   End If
      
   GetStartEndCell False, iStartRow, iStartCol, iStartX, iStartY, iEndRow, iEndCol, iEndX, iEndY, bJunk
   iStartRow = iStartRow - 1
   If (iStartRow < 1) Then iStartRow = 1

   If (m_cScroll.Visible(efsHorizontal)) Then
      iH = m_cScroll.Value(efsHorizontal)
   End If
   If (m_cScroll.Visible(efsVertical)) Then
      iV = m_cScroll.Value(efsVertical)
   End If
   
   iToDirtyY = Abs(s_iLastStartRow - iStartRow) + 1
   If (Abs(s_iLastEndRow - iEndRow) + 1) > iToDirtyY Then
      iToDirtyY = (Abs(s_iLastEndRow - iEndRow) + 1)
   End If
   iToDirtyX = Abs(s_iLastStartCol - iStartCol) + 1
   If (Abs(s_iLastEndCol - iEndCol) + 1) > iToDirtyX Then
      iToDirtyX = (Abs(s_iLastEndCol - iEndCol) + 1)
   End If
         
   bNoOptimise = bNoOptimise Or m_bNoOptimiseScroll
   If (m_bBitmap) Then
      ' Can't optimise with a background bitmap as it has to stay in place:
      bNoOptimise = True
   End If
   
   If Not (bNoOptimise) Then
      
      'GetClientRect UserControl.hwnd, tR
      tR.TOp = 0: tR.Bottom = 0: tR.Right = UserControl.ScaleWidth \ Screen.TwipsPerPixelX: tR.Bottom = UserControl.ScaleHeight \ Screen.TwipsPerPixelY
      tR.TOp = tR.TOp + (m_cHeader.Height + m_cHeader.TOp + plSplitSize()) * Abs(m_bHeader)
      If (Abs(s_iLastH - iH) < (tR.Right - tR.Left) \ 2) And (Abs(s_iLastV - iV) < (tR.Bottom - tR.TOp) \ 2) Then
         ' We can optimise using ScrollDC:
         LSet tSR = tR
         If (Abs(s_iLastH - iH) > 0) Then
            ' scrolling in X:
            iYStart = iStartRow
            iYEnd = iEndRow
            If Sgn(s_iLastH - iH) = -1 Then
               iXStart = iEndCol - iToDirtyX
               iXEnd = iEndCol
               tSR.Left = tSR.Left - (s_iLastH - iH)
            Else
               iXStart = iStartCol
               iXEnd = iStartCol + iToDirtyX
               tSR.Right = tSR.Right - (s_iLastH - iH)
            End If
         Else
            ' scrolling in Y
            iXStart = iStartCol
            iXEnd = iEndCol
            If Sgn(s_iLastV - iV) = -1 Then
               iYStart = iEndRow
               iRowCount = 0
               Do While iRowCount < iToDirtyY
                  iYStart = iYStart - 1
                  If iYStart < 1 Then
                     Exit Do
                  Else
                     If m_tRows(iYStart).bVisible Then
                        iRowCount = iRowCount + 1
                     End If
                  End If
               Loop
               If (iYStart < 1) Then iYStart = 1
               iYEnd = iEndRow
               tSR.TOp = tSR.TOp - (s_iLastV - iV)
            Else
               iYStart = iStartRow
               iYEnd = iStartRow
               iRowCount = 0
               Do While iRowCount < iToDirtyY
                  iYEnd = iYEnd + 1
                  If iYEnd > m_iRows Then
                     Exit Do
                  Else
                     If m_tRows(iYEnd).bVisible Then
                        iRowCount = iRowCount + 1
                     End If
                  End If
               Loop
               tSR.Bottom = tSR.Bottom - (s_iLastV - iV)
            End If
         End If
         If (iXStart < 1) Then iXStart = 1
         If (iYStart < 1) Then iYStart = 1
         If (iXEnd > m_iCols) Then iXEnd = m_iCols
         If (iYEnd > m_iRows) Then iYEnd = m_iRows
         
         ScrollDC UserControl.hdc, s_iLastH - iH, s_iLastV - iV, tSR, tR, 0, tJunk
         
         For iRow = iYStart To iYEnd
            For iCol = iXStart To iXEnd
               m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
            Next iCol
         Next iRow
         If (m_lSplitRow > 0) Then
            For iRow = 1 To m_lSplitRow
               For iCol = iXStart To iXEnd
                  m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
               Next iCol
            Next iRow
         End If
      Else
         bNoOptimise = True
      End If
   End If
   
   If (bNoOptimise) Then
      For iRow = iStartRow To iEndRow
         For iCol = iStartCol To iEndCol
            m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
         Next iCol
      Next iRow
      If (m_lSplitRow > 0) Then
         For iRow = 1 To m_lSplitRow
            For iCol = iStartCol To iEndCol
               m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
            Next iCol
         Next iRow
      End If
   End If
   
   s_iLastStartRow = iStartRow
   s_iLastEndRow = iEndRow
   s_iLastStartCol = iStartCol
   s_iLastEndCol = iEndCol
   If (m_cScroll.Visible(efsHorizontal)) Then
      s_iLastH = m_cScroll.Value(efsHorizontal)
   Else
      s_iLastH = 0
   End If
   If (m_cScroll.Visible(efsVertical)) Then
      s_iLastV = m_cScroll.Value(efsVertical)
   Else
      s_iLastV = 0
   End If
   
End Sub
Private Sub pResizeHeader()
Dim lWidth As Long
Dim lLeft As Long
   If (m_bHeader) Then
      lLeft = m_cHeader.ColumnGroupCount * m_lDefaultRowHeight
      If Not (m_cScroll Is Nothing) Then
         lWidth = UserControl.ScaleWidth \ Screen.TwipsPerPixelX + m_cScroll.Max(efsHorizontal)
         If (m_cScroll.Visible(efsHorizontal)) Then
            lLeft = lLeft - m_cScroll.Value(efsHorizontal)
         End If
      Else
         lWidth = UserControl.ScaleWidth \ Screen.TwipsPerPixelX
      End If
      If Not (m_cHeader.Left = lLeft And m_cHeader.TOp = (m_cHeader.IdealHeight - m_cHeader.Height) And m_cHeader.Width = lWidth) Then
         m_cHeader.Move lLeft, (m_cHeader.IdealHeight - m_cHeader.Height), lWidth, m_cHeader.Height
      End If
   End If
End Sub


Private Sub pRequestEdit(Optional ByVal iKeyAscii As Integer = 0)
Dim iRow As Long
Dim iCol As Long
Dim iNextROw As Long
Dim sOrigSearch As String
Dim bCancel As Boolean

   If (m_bEnabled) Then
      If Not (m_iSelRow = 0) And Not (m_iSelCol = 0) Then
         If (m_bEditable) Then
            ' SPM 2003-11-10: Don't ask to go into edit mode if we already
            ' are in edit mode
            If Not (m_bInEdit) Then
               If Not (m_tRows(m_iSelRow).bGroupRow) Then
                  bCancel = False
                  RaiseEvent RequestEdit(m_iSelRow, m_iSelCol, iKeyAscii, bCancel)
                  m_bInEdit = Not (bCancel)
                  ' SPM 2003-11-10: Store which cell we're editing, and start
                  ' tracking the mouse using a mouse hook
                  If (m_bInEdit) Then
                     ' SPM 2003-12-18: Post a mouse up first
                     PostMessage UserControl.hwnd, WM_LBUTTONUP, 0, &H7FFF7FFF
                     ReleaseCapture
                     EnableWindow UserControl.hwnd, 0
                     m_iEditRow = m_iSelRow
                     m_iEditCol = m_iSelCol
                     AttachMouseHook Me
                     m_hWndParentForm = GetParentFormhWNd()
                     AttachMessage Me, m_hWndParentForm, WM_ACTIVATEAPP
                  End If
               End If
            End If
         Else
            If (iKeyAscii <> 0) And (iKeyAscii <> 13) Then  ' 2003-11-25 fix for return
               ' Search in the search col for the item:
               If (m_iSearchCol > 0) Then
                  sOrigSearch = m_sSearchString
                  If (iKeyAscii = 8) Then
                     If Len(m_sSearchString) > 0 Then
                        If (Len(m_sSearchString) = 1) Then
                           m_sSearchString = ""
                        Else
                           m_sSearchString = Left$(m_sSearchString, Len(m_sSearchString) - 1)
                        End If
                     End If
                  Else
                     m_sSearchString = m_sSearchString & Chr$(iKeyAscii)
                  End If
                  m_sSearchString = UCase$(m_sSearchString)
                  If Len(m_sSearchString) > 0 Then
                     iRow = FindSearchMatchRow(m_sSearchString)
                     If (iRow = 0) Then
                        m_sSearchString = sOrigSearch
                        iNextROw = FindSearchMatchRow(m_sSearchString)
                        If (iNextROw <> iRow) Then
                           iRow = iNextROw
                        End If
                     End If
                     
                     If (iRow <> 0) Then
                        If (m_bMultiSelect) Then
                           m_iSelRow = iRow
                           m_iSelCol = m_iSearchCol
                           For iRow = 1 To m_iRows
                              For iCol = 1 To m_iCols
                                 If (m_bRowMode) Then
                                    m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> (iRow = m_iSelRow))
                                    m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow)
                                 Else
                                    m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> ((iRow = m_iSelRow) And (iCol = m_iSelCol)))
                                    m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol))
                                 End If
                              Next iCol
                           Next iRow
                           m_tCells(m_iSearchCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                        Else
                           m_iSelRow = iRow
                           m_iSelCol = m_iSearchCol
                           pSingleModeSelect
                        End If
                        If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
                           Draw
                        End If
                     Else
                        m_sSearchString = sOrigSearch
                     End If
                  End If
               End If
            End If
         End If
      End If
   End If
End Sub

Public Function FindSearchMatchRow( _
      ByVal sSearchString As String, _
      Optional ByVal bLoop As Boolean = True, _
      Optional ByVal bVisibleRowsOnly As Boolean = True _
   ) As Long
Attribute FindSearchMatchRow.VB_Description = "Finds the first matching row for a given search string."
Dim iRow As Long
Dim iFindRow As Long
Dim iStart As Long
Dim sText As String

   If (m_iSearchCol > 0) And (m_iSearchCol < m_iCols) Then
      If (m_iSelRow = 0) Then
         If (bLoop) Then
            iStart = m_iSelRow + 1
         Else
            iStart = m_iSelRow
         End If
      Else
         iStart = 1
      End If
      For iRow = iStart To m_iRows
         If (m_tRows(iRow).bVisible) Or Not (bVisibleRowsOnly) Then
            If Not IsMissing(m_tCells(m_iSearchCol, m_tRows(iRow).lGridCellArrayRow).sText) Then
               sText = UCase$(m_tCells(m_iSearchCol, m_tRows(iRow).lGridCellArrayRow).sText)
               If (Len(sText) >= Len(sSearchString)) Then
                  If (InStr(sText, sSearchString) = 1) Then
                     iFindRow = iRow
                     Exit For
                  End If
               End If
            End If
         End If
      Next iRow
      If (iFindRow = 0) Then
         If (bLoop) Then
            For iRow = 1 To iStart
               If (m_tRows(iRow).bVisible) Or Not (bVisibleRowsOnly) Then
                  If Not IsMissing(m_tCells(m_iSearchCol, m_tRows(iRow).lGridCellArrayRow).sText) Then
                     sText = UCase$(m_tCells(m_iSearchCol, m_tRows(iRow).lGridCellArrayRow).sText)
                     If (Len(sText) >= Len(sSearchString)) Then
                        If (InStr(sText, sSearchString) = 1) Then
                           iFindRow = iRow
                           Exit For
                        End If
                     End If
                  End If
               End If
            Next iRow
         End If
      End If
      
      FindSearchMatchRow = iFindRow
   End If
End Function

Public Property Get InEditMode() As Boolean
Attribute InEditMode.VB_Description = "Gets whether the control is currently in Edit Mode."
   InEditMode = m_bInEdit
End Property

''' <summary>
''' Request the normal end of an edit operation, if any.  This will
''' fire the <c>PreCancelEdit</c> event which provides a way
''' to validate the edited data prior to the editing operation
''' being completed.
''' </summary>
Public Sub EndEdit()
Attribute EndEdit.VB_Description = "Request the normal end of an edit operation, if any.  This will fire the PreCancelEdit event which provides a wayto validate the edited data prior to the editing operation being completed."

   If (m_bInEndEditInterlock) Then
      Exit Sub
   End If

   m_bInEndEditInterlock = True
   ' 2003-11-24: Add new method to end editing and commit.
   If (m_bInEdit) Then
      Dim newValue As Variant
      Dim bStayInEditMode As Boolean
      RaiseEvent PreCancelEdit(m_iEditRow, m_iEditCol, newValue, bStayInEditMode)
      If Not (bStayInEditMode) Then
         CancelEdit
      Else
         ' ensure we are still hooked:
         If (m_hWndParentForm = 0) Then
            AttachMouseHook Me
            m_hWndParentForm = GetParentFormhWNd()
            AttachMessage Me, m_hWndParentForm, WM_ACTIVATEAPP
         End If
         m_bInEdit = True
      End If
   End If
   m_bInEndEditInterlock = False

End Sub

Public Sub StartEdit(ByVal lRow As Long, ByVal lCol As Long)
Attribute StartEdit.VB_Description = "Starts editing on the specified cell."
   If (m_bEditable) Then
      pCancelEdit False
      If Not (m_bInEdit) Then
         CellSelected(lRow, lCol) = True
         pRequestEdit 0
      End If
   End If
End Sub

''' <summary>
''' Request cancellation of an edit operation, if any.
''' </summary>
Public Sub CancelEdit()
Attribute CancelEdit.VB_Description = "Call to cancel an edit request when the control you are using to edit a cell looses focus."
   pCancelEdit False
End Sub

Private Sub pCancelEdit(ByVal bAppDeactivate As Boolean)
   
   ' 2003-11-24: Otherwise, standard cancel edit mode.
   If (m_bInEdit) Then
      DetachMouseHook Me
      DetachMessage Me, m_hWndParentForm, WM_ACTIVATEAPP
      m_hWndParentForm = 0
      EnableWindow UserControl.hwnd, 1
      RaiseEvent CancelEdit
      
      If Not (bAppDeactivate) Then
         On Error Resume Next ' Just in case we're not in VB.
         UserControl.Extender.SetFocus
         On Error GoTo 0
      End If
      
      If Not (m_bRunningInVBIDE) Then
         If Not (m_iRepostMsg = 0) Then
         
            Dim lFlagUp As Long
            Dim lFlagDown As Long
            
            Select Case m_iRepostMsg
            Case WM_LBUTTONDOWN
               lFlagDown = MOUSEEVENTF_LEFTDOWN
               lFlagUp = MOUSEEVENTF_LEFTUP
            Case WM_RBUTTONDOWN
               lFlagDown = MOUSEEVENTF_RIGHTDOWN
               lFlagUp = MOUSEEVENTF_RIGHTUP
            Case WM_MBUTTONDOWN
               lFlagDown = MOUSEEVENTF_MIDDLEDOWN
               lFlagUp = MOUSEEVENTF_MIDDLEUP
            End Select
            mouse_event lFlagDown Or MOUSEEVENTF_ABSOLUTE, 0, 0, 0, 0
            mouse_event lFlagUp Or MOUSEEVENTF_ABSOLUTE, 0, 0, 0, 0
         
         End If
         
      End If
      
      m_iRepostMsg = 0
      m_bInEdit = False
   End If

End Sub

''' <summary>
''' Ensures the correct items in the grid are selected
''' when single selection mode is on.
''' </summary>
Private Sub pSingleModeSelect()
Dim iCol As Long
   If (m_iRows = 0) Or (m_iCols = 0) Then
      Exit Sub
   End If
   If (m_iSelRow <= 0) Then
      m_iSelRow = 1
   End If
   If (m_iSelCol <= 0) Then
      m_iSelCol = 1
   End If
   If (m_bRowMode) Then
      For iCol = 1 To m_iCols
         If Not (m_iLastSelRow = 0) Then
            If (m_iLastSelRow > m_iRows) Then
               m_iLastSelRow = m_iRows
            End If
            m_tCells(iCol, m_tRows(m_iLastSelRow).lGridCellArrayRow).bDirtyFlag = True
            m_tCells(iCol, m_tRows(m_iLastSelRow).lGridCellArrayRow).bSelected = False
         End If
         m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
         m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = True
      Next iCol
   Else
      If (m_iLastSelRow > 0) And (m_iLastSelCol > 0) Then
         If (m_iLastSelRow > m_iRows) Then
            m_iLastSelRow = m_iRows
         End If
         If (m_iLastSelCol > m_iCols) Then
            m_iLastSelCol = m_iCols
         End If
         m_tCells(m_iLastSelCol, m_tRows(m_iLastSelRow).lGridCellArrayRow).bDirtyFlag = True
         m_tCells(m_iLastSelCol, m_tRows(m_iLastSelRow).lGridCellArrayRow).bSelected = False
      End If
      m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
      m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = True
   End If
   
End Sub

Private Sub pGetNextVisibleCell( _
      ByVal cx As Long, _
      ByVal cy As Long _
   )
Dim i As Long
Dim iColIndex As Long
Dim iNew As Long
Dim iOrigRow As Long
Dim bCheckRowVisible As Boolean
Dim bFound As Boolean
Dim iIter As Long
Dim iRowTextCol As Long
   
   If (cx <> 0) Then
      For i = 1 To m_iCols
         If m_tCols(i).lCellColIndex = m_iSelCol Then
            iColIndex = i
            Exit For
         End If
      Next i
   
      iNew = iColIndex + cx
      If (iNew > 0) And (iNew <= m_iCols) Then
         If m_tRows(m_iSelRow).bGroupRow Then
            iNew = 0
         Else
            If Not (m_bRowMode) Then
               iRowTextCol = m_iRowTextCol
            Else
               iRowTextCol = 0
            End If
            Do
               If (m_tCols(iNew).bVisible And m_tCols(iNew).iGroupOrder = -1) Or iNew = iRowTextCol Then
                  Exit Do
               Else
                  iNew = iNew + cx
                  If iNew > m_iCols Or iNew < 0 Then
                     Exit Do
                  End If
               End If
            Loop
         End If
      End If
      
      If (iNew < 1) Then
         For i = m_iCols To 1 Step -1
            If (m_tCols(i).bVisible And m_tCols(i).iGroupOrder = -1) Or i = iRowTextCol Then
               iNew = i
               iOrigRow = m_iSelRow
               Do
                  iOrigRow = iOrigRow - 1
                  If Not (m_bRowMode) Then
                     iRowTextCol = m_iRowTextCol
                  Else
                     iRowTextCol = 0
                  End If
                  If (iOrigRow < 1) Then
                     Exit Do
                  Else
                     If m_tRows(iOrigRow).bVisible Then
                        If m_tRows(iOrigRow).bGroupRow Then
                           m_iSelCol = m_tCols(m_iRowTextCol).lCellColIndex
                           m_iSelRow = iOrigRow
                           Exit Do
                        Else
                           m_iSelCol = m_tCols(iNew).lCellColIndex
                           m_iSelRow = iOrigRow
                           Exit Do
                        End If
                     End If
                  End If
               Loop
               Exit For
            End If
         Next i
      ElseIf (iNew > m_iCols) Then
         For i = 1 To m_iCols
            If (m_tCols(i).bVisible And m_tCols(i).iGroupOrder = -1) Or i = iRowTextCol Then
               iNew = i
               iOrigRow = m_iSelRow
               Do
                  iOrigRow = iOrigRow + 1
                  If Not (m_bRowMode) Then
                     iRowTextCol = m_iRowTextCol
                  Else
                     iRowTextCol = 0
                  End If
                  If (iOrigRow > m_iRows) Then
                     Exit Do
                  Else
                     If m_tRows(iOrigRow).bVisible Then
                        If m_tRows(iOrigRow).bGroupRow Then
                           m_iSelCol = m_tCols(m_iRowTextCol).lCellColIndex
                           m_iSelRow = iOrigRow
                           Exit Do
                        Else
                           m_iSelCol = m_tCols(iNew).lCellColIndex
                           m_iSelRow = iOrigRow
                           Exit Do
                        End If
                     End If
                  End If
               Loop
               Exit For
            End If
         Next i
      Else
         m_iSelCol = m_tCols(iNew).lCellColIndex
      End If
            
   End If
   
   If (cy <> 0) Or (bCheckRowVisible) Then
      iOrigRow = m_iSelRow
      bFound = False
      Do
         m_iSelRow = m_iSelRow + cy
         iIter = iIter + 1
         If (iIter > m_iRows) Then
            ' No visible rows
            m_iSelCol = 0: m_iSelRow = 0
            Exit Sub
         End If
         
         If (m_iSelRow > m_iRows) Then
            m_iSelRow = iOrigRow
            Exit Sub
         ElseIf (m_iSelRow < 1) Then
            m_iSelRow = iOrigRow
            Exit Sub
         End If
         If (m_tRows(m_iSelRow).bVisible) Then
            If (m_tRows(m_iSelRow).bGroupRow) Then
               m_iSelCol = m_iRowTextCol
            ElseIf (m_iSelCol = m_iRowTextCol) Then
               For i = 1 To m_iCols
                  If (m_tCols(i).bVisible And m_tCols(i).iGroupOrder = -1) Then
                     m_iSelCol = m_tCols(i).lCellColIndex
                     Exit For
                  End If
               Next i
            End If
            bFound = True
         End If
         
      Loop While Not bFound
   End If
   
End Sub

Private Function plGetFirstVisibleRow() As Long
Dim bFound As Boolean
Dim iRow As Long
   iRow = m_lSplitRow + 1
   Do
      If (m_tRows(iRow).bVisible) Then
         bFound = True
      Else
         iRow = iRow + 1
         If (iRow > m_iRows) Then
            iRow = 0
            bFound = True
         End If
      End If
   Loop While Not bFound
   plGetFirstVisibleRow = iRow
End Function

Private Function plGetLastVisibleRow() As Long
Dim bFound As Boolean
Dim iRow As Long
   iRow = m_iRows
   Do
      If (m_tRows(iRow).bVisible) Then
         bFound = True
      Else
         iRow = iRow - 1
         If (iRow < m_lSplitRow + 1) Then
            iRow = 0
            bFound = True
         End If
      End If
   Loop While Not bFound
   plGetLastVisibleRow = iRow
End Function

Public Sub AutoWidthColumn(ByVal vKey As Variant)
Attribute AutoWidthColumn.VB_Description = "Automatically resizes a column to accommodate the largest item."
Dim iRow As Long
Dim lWidth As Long
Dim lMaxWidth As Long
Dim lMaxTextWidth As Long
Dim iCol As Long
Dim iCCol As Long
   
   iCol = ColumnIndexByVariant(vKey)
   If (iCol > 0) Then
      iCCol = m_tCols(iCol).lCellColIndex
      For iRow = 1 To m_iRows
         If (m_tRows(iRow).bVisible) Or (m_tRows(iRow).bCollapsed) Then
            ' lMaxTextWidth is an optimisation for multi-line rows
            lWidth = plEvaluateTextWidth(iRow, iCCol, True, lMaxTextWidth)
            If (lWidth > lMaxTextWidth) Then
               lMaxTextWidth = lWidth
            End If
            lWidth = lWidth + m_tCells(iCCol, m_tRows(iRow).lGridCellArrayRow).lIndent
            lWidth = lWidth + ((m_tCells(iCCol, m_tRows(iRow).lGridCellArrayRow).iIconIndex > 0) * -m_lIconSizeX)
            lWidth = lWidth + ((m_tCells(iCCol, m_tRows(iRow).lGridCellArrayRow).lExtraIconIndex > 0) * -m_lIconSizeY)
            lWidth = lWidth + 4
            lWidth = lWidth + (m_bGridLines And (Not (m_bNoVerticalGridLines))) * -4
            If (lWidth > lMaxWidth) Then
               lMaxWidth = lWidth
            End If
         End If
      Next iRow
      If (lMaxWidth < 26) Then
         lMaxWidth = 26
      End If
      ColumnWidth(iCCol) = lMaxWidth
   
   End If
   
End Sub

Public Sub AutoHeightRow(ByVal lRow As Long, Optional ByVal lMinimumHeight As Long = -1)
Attribute AutoHeightRow.VB_Description = "Automatically sets the height of a row based on the contents of the cells."
Dim lCol As Long
Dim lHeight As Long
Dim lMaxHeight As Long
   
   If lMinimumHeight <= 8 Then
      lMinimumHeight = m_lDefaultRowHeight
      If lMinimumHeight <= 8 Then
         lMinimumHeight = 8
      End If
   End If
   If (lRow > 0) And (lRow <= m_iRows) Then
      For lCol = 1 To m_iCols
         lHeight = EvaluateTextHeight(lRow, lCol)
         If (m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).iIconIndex >= 0) Then
            If lHeight < m_lIconSizeY Then
               lHeight = m_lIconSizeY
            End If
         End If
         If (lHeight < lMinimumHeight) Then
            lHeight = lMinimumHeight
         End If
         If (lHeight > lMaxHeight) Then
            lMaxHeight = lHeight
         End If
      Next lCol
      RowHeight(lRow) = lMaxHeight + Abs(m_bGridLines And Not (m_bNoHorizontalGridLines)) * 2 + 2
   Else
      gErr 9, "Row subscript out of range"
   End If
   
End Sub

Private Sub pRemoveGroupingRows()
Dim iRow As Long
   
   For iRow = m_iRows To 1 Step -1
      If (m_tRows(iRow).bGroupRow) Then
         pRemoveRow iRow, False
      ElseIf (m_tRows(iRow).bCollapsed) Then
         m_tRows(iRow).bCollapsed = False
         m_tRows(iRow).bVisible = True
      End If
   Next iRow

End Sub

Private Sub pRowVisibility(ByVal iStartRow As Long)
Dim lStartY As Long
Dim lCalcRow As Long
   
   If (m_iRows <= 0) Then
      Exit Sub
   End If

   ' Same as RowVisible except every row in the grid in one hit
   lStartY = m_tRows(iStartRow).lStartY
   For lCalcRow = iStartRow + 1 To m_iRows
      If (m_tRows(lCalcRow - 1).bVisible) Then
         lStartY = lStartY + m_tRows(lCalcRow - 1).lHeight
      End If
      m_tRows(lCalcRow).lStartY = lStartY
   Next lCalcRow
   
End Sub

Private Sub pExpandCollapseGroupingRow(ByVal iRow As Long)
Dim iLevel As Long
Dim iWorkRow As Long
Dim iStartRow As Long
Dim iEndRow As Long
Dim bExpand As Boolean
Dim bComplete As Boolean
Dim iWorkLevel As Long
Dim iLastWorkLevel As Long
Dim bRedraw As Boolean

   bRedraw = m_bRedraw
   If (bRedraw) Then
      Redraw = False
   End If

   ' Sanity
   'Debug.Assert (m_tRows(iRow).bGroupRow And InStr(m_tRows(iRow).sKey, GROUP_MAGIC_KEY_PREFIX) = 1)
   
   If (iRow >= m_iRows) Then
      ' Nothing to do
      Exit Sub
   End If
   
   ' Get level of this row
   iLevel = m_tRows(iRow).lGroupIndentLevel
   iWorkRow = iRow + 1
   
   ' Find expand/collapse state of next row in:
   bExpand = False
   If Not (m_tRows(iWorkRow).bVisible) Then
      bExpand = True
   End If
   
   Dim bCancel As Boolean
   RaiseEvent RowGroupingStateChange(iRow, IIf(bExpand, ecgExpanded, ecgCollapsed), bCancel)
   
   If Not (bCancel) Then
      bComplete = False
      iLastWorkLevel = iLevel
      iStartRow = iWorkRow
      Do While Not (bComplete)
         iWorkLevel = &H7FFF&
         If m_tRows(iWorkRow).lGroupIndentLevel > 0 Then
            iWorkLevel = m_tRows(iWorkRow).lGroupIndentLevel
            iLastWorkLevel = iWorkLevel
         Else
            iWorkLevel = iLastWorkLevel + 1
         End If
         If (iWorkLevel <= iLevel) Then
            bComplete = True
         Else
            iEndRow = iWorkRow
            If (bExpand) And (iWorkLevel = iLevel + 1) Then
               m_tRows(iWorkRow).bVisible = m_tRows(iWorkRow).bCollapsed
               m_tRows(iWorkRow).bCollapsed = False
            Else
               If Not (m_tRows(iWorkRow).bCollapsed) Then
                  m_tRows(iWorkRow).bCollapsed = m_tRows(iWorkRow).bVisible
                  m_tRows(iWorkRow).bVisible = False
               End If
            End If
            iWorkRow = iWorkRow + 1
            If (iWorkRow > m_iRows) Then
               bComplete = True
            End If
         End If
      Loop
      
      pRowVisibility iStartRow
      
   End If
   
   If (bRedraw) Then
      Redraw = True
   End If
   
End Sub

Private Sub pSetSortFromColumnHeader()
Dim i As Long
Dim iSortCols() As Long
Dim iSortColCount As Long
Dim j As Long
Dim iTargetIndexBefore As Long
   
   If (m_cHeader.ColumnGroupCount <= 0) Then
      ' Ensure sort does not include any grouped rows:
      For i = 1 To m_cSort.Count
         If (m_cSort.GroupBy(i)) Then
            m_cSort.GroupBy(i) = False
         End If
      Next i
      Exit Sub
   End If
   
   iSortColCount = 0
   For i = 1 To m_iCols
      If m_tCols(i).iGroupOrder > -1 Then
         
         iTargetIndexBefore = 0
         For j = 1 To iSortColCount
            If (m_tCols(i).iGroupOrder < m_tCols(iSortCols(j)).iGroupOrder) Then
               iTargetIndexBefore = j
               Exit For
            End If
         Next j
         
         iSortColCount = iSortColCount + 1
         ReDim Preserve iSortCols(1 To iSortColCount) As Long
         If (iTargetIndexBefore > 0) Then
            For j = iSortColCount - 1 To iTargetIndexBefore Step -1
               iSortCols(j + 1) = iSortCols(j)
            Next j
            iSortCols(iTargetIndexBefore) = i
         Else
            iSortCols(iSortColCount) = i
         End If
         
      End If
   Next i
   
   If (iSortColCount = 0) Then
      ' We're done!
      Exit Sub
   End If
   
   ' b) Followed by the sort for the row
   '    that is not grouped, if any:
   For i = 1 To m_iCols
      If Not (m_tCols(i).bIsGrouped) Then
         
         If Not (m_tCols(i).eSortOrder = CCLOrderNone) Then
         
            iSortColCount = iSortColCount + 1
            ReDim Preserve iSortCols(1 To iSortColCount) As Long
            iSortCols(iSortColCount) = i
            Exit For
            
         End If
         
      End If
   Next i

   ' Now set up the sort:
   m_cSort.Clear
   For i = 1 To iSortColCount
      m_cSort.SortColumn(i) = m_tCols(iSortCols(i)).lCellColIndex
      m_cSort.SortOrder(i) = m_tCols(iSortCols(i)).eSortOrder
      m_cSort.SortType(i) = m_tCols(iSortCols(i)).eSortType
      m_cSort.GroupBy(i) = (i <= m_cHeader.ColumnGroupCount)
      If (m_cSort.GroupBy(i) And m_cSort.SortOrder(i) = CCLOrderNone) Then
         m_cSort.SortOrder(i) = CCLOrderAscending
      End If
      m_cSort.GridColumnArrayIndex(i) = iSortCols(i)
   Next i
   m_cSort.SetGridMatch
   
   ' Sort the grid
   Sort
   
End Sub

Private Sub pAddGroupingRows()
Dim i As Long
Dim j As Long
Dim iRow As Long
Dim iCol As Long
Dim vLastItem() As Variant
Dim bChanged As Boolean
Dim iGroupItemCount As Long
Dim lGroupWidth As Long
Dim iGroupCol As Long
Dim sTheText As String
Dim lItemData As Long
   
   If (m_cHeader.ColumnGroupCount <= 0) Then
      Exit Sub
   End If
     
   ' Set up a variant array to hold the values
   ' at the last point in the grid.
   iGroupItemCount = m_cHeader.ColumnGroupCount
   ReDim vLastItem(1 To iGroupItemCount) As Variant
     
   
   ' Check whether we have a grouping column: if we don't
   ' we'll need to add one:
   If Not (m_bHasRowText) Then
      lGroupWidth = 96 + 256 + 96 + 96 ' TODO work out what this ought to be
      iGroupCol = AddColumn(GROUP_COLUMN_MAGIC_KEY, , , , lGroupWidth, , , , , , True)
   Else
      iGroupCol = m_iRowTextCol
   End If
   ' Should not be possible to end with no grouping column.
   Debug.Assert (iGroupCol > 0)
   If (iGroupCol = 0) Then
      Exit Sub
   End If
   
   ' Now to add the grouping rows:
   iRow = m_lSplitRow + 1
   bChanged = True
   Do
      If Not m_tRows(iRow).bGroupRow Then
         
         For i = 1 To iGroupItemCount
         
            iCol = m_cSort.SortColumn(i)
            
            Select Case m_tCols(m_cSort.GridColumnArrayIndex(i)).eSortType
            Case CCLSortIcon
               If Not (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).iIconIndex = vLastItem(i)) Or bChanged Then
                  vLastItem(i) = m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).iIconIndex
                  For j = i + 1 To iGroupItemCount
                     vLastItem(j) = Empty
                  Next j
                  If Not (bChanged) Then
                     lItemData = m_tRows(iRow).lItemData
                  End If
                  pAddRow iRow, lItemData, True, m_lDefaultRowHeight, True, i
                  CellDetails iRow, iCol, vLastItem(i)
                  CellDetails iRow, iGroupCol, , DT_VCENTER Or DT_SINGLELINE Or DT_WORD_ELLIPSIS Or DT_LEFT, , m_oGroupRowBackColor, m_oGroupRowForeColor, , , vLastItem(i), m_cSort.GridColumnArrayIndex(i)
                  For j = 1 To i
                     CellDetails iRow, m_cSort.SortColumn(j), vLastItem(j)
                  Next j
                  m_tRows(iRow).bGroupRow = True
                  m_tRows(iRow).lGroupIndentLevel = i
                  iRow = iRow + 1
                  bChanged = True
               End If
            
            Case Else
               If IsMissing(m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).sText) Then
                  sTheText = "(none)"
               Else
                  sTheText = m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).sText
                  If (Len(m_tCols(m_cSort.GridColumnArrayIndex(i)).sFmtString) > 0) Then
                     sTheText = Format$(sTheText, m_tCols(m_cSort.GridColumnArrayIndex(i)).sFmtString)
                  End If
               End If
               
               If Not (StrComp(sTheText, vLastItem(i)) = 0) Or bChanged Then
                  vLastItem(i) = sTheText
                  For j = i + 1 To iGroupItemCount
                     vLastItem(j) = Empty
                  Next j
                  If Not (bChanged) Then
                     lItemData = m_tRows(iRow).lItemData
                  End If
                  pAddRow iRow, lItemData, True, m_lDefaultRowHeight, True, i
                  CellDetails iRow, iGroupCol, vLastItem(i), DT_VCENTER Or DT_SINGLELINE Or DT_WORD_ELLIPSIS Or DT_LEFT, , m_oGroupRowBackColor, m_oGroupRowForeColor, , , , m_cSort.GridColumnArrayIndex(i)
                  CellDetails iRow, iCol, vLastItem(i)
                  For j = 1 To i
                     CellDetails iRow, m_cSort.SortColumn(j), vLastItem(j)
                  Next j
                  m_tRows(iRow).bGroupRow = True
                  m_tRows(iRow).lGroupIndentLevel = i
                  iRow = iRow + 1
                  bChanged = True
               End If
               
            End Select
         Next i

         bChanged = False
      End If
      
      m_tRows(iRow).bCollapsed = m_tRows(iRow).bVisible
      m_tRows(iRow).bVisible = False
      iRow = iRow + 1
         
   Loop While iRow <= m_iRows

End Sub

Private Sub pGetDragImageRect(ByVal lCol As Long, ByVal lWidth As Long, ByRef tR As RECT, ByVal bFirst As Boolean)
Dim iCol As Long, iGCol As Long
Dim tP As POINTAPI

   ' Find start position for header column index lCol:
   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lHeaderColIndex = lCol + 1) Then
         iGCol = iCol
         Exit For
      End If
   Next iCol
   
   If (iGCol > 0) Then
      ' Add the width:
      If (bFirst) Then
         tR.Left = m_tCols(iGCol).lStartX + m_tCols(iCol).lWidth - 1
      Else
         tR.Left = m_tCols(iGCol).lStartX + lWidth - 1
      End If
      tR.Left = tR.Left - m_lStartX
      tR.Right = tR.Left + 2
      tR.TOp = m_cHeader.Height + m_cHeader.TOp
      tR.Bottom = UserControl.ScaleHeight \ Screen.TwipsPerPixelY
      
      ' Return the rectangle relative to the screen:
      tP.x = tR.Left: tP.y = tR.TOp
      ClientToScreen UserControl.hwnd, tP
      tR.Left = tP.x: tR.TOp = tP.y
      tP.x = tR.Right: tP.y = tR.Bottom
      ClientToScreen UserControl.hwnd, tP
      tR.Right = tP.x: tR.Bottom = tP.y
      OffsetRect tR, -1, 0
      
   End If
End Sub

Private Property Let ISubclass_MsgResponse(ByVal RHS As EMsgResponse)
   '
End Property

Private Property Get ISubclass_MsgResponse() As EMsgResponse
   '
   ISubclass_MsgResponse = emrPostProcess
   '
End Property

Private Function ISubclass_WindowProc(ByVal hwnd As Long, ByVal iMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
   '
   Select Case iMsg
   Case WM_ACTIVATEAPP
      If (wParam = 0) Then
         If (m_bInEdit) Then
            ' Stop editing
            pCancelEdit True
         End If
      End If
      
   Case WM_SETTINGCHANGE, WM_DISPLAYCHANGE
      
      m_bTrueColor = (GetDeviceCaps(UserControl.hdc, BITSPIXEL) > 8)
      UserControl_Resize
      
   End Select
   '
End Function

Private Sub m_cHeader_ColumnBeginDrag(ByVal lColumn As Long)
   '
   '
End Sub

Private Sub m_cHeader_ColumnClick(ByVal lColumn As Long)
Dim iCol As Long
Dim lCCol As Long
   
   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lHeaderColIndex = lColumn + 1) Then
         lCCol = m_tCols(iCol).lCellColIndex
         Exit For
      End If
   Next iCol
   RaiseEvent ColumnClick(lCCol)
   
End Sub

Private Sub m_cHeader_ColumnDblClick(ByVal lColumn As Long)
   '
   '
End Sub

Private Sub m_cHeader_ColumnEndDrag(ByVal lColumn As Long, ByVal lOrder As Long)
Dim iCol As Long
Dim lColPosition As Long
Dim lOrderPosition As Long
Dim tSwap As tColPosition
Dim lStartX As Long
Dim lLastCol As Long
Dim lLastWidth As Long
Dim lCheckCol As Long
Dim bCheckForFixUp As Boolean

   If (lOrder <> -1) Then  ' Dropped off the grid...
      
      If (m_bStretchLastColumnToFit) Then
         If Not (m_lStretchedColumn = 0) Then
            Dim lCol As Long
            lCol = plColumnIndexByIndex(m_lStretchedColumn)
            If (lColumn = m_tCols(lCol).lHeaderColIndex - 1) Then
               m_tCols(lCol).lWidth = m_tCols(lCol).lCorrectWidth
               m_cHeader.StealthSetColumnWidth m_tCols(lCol).lHeaderColIndex - 1, m_tCols(lCol).lWidth
               m_lStretchedColumn = 0
            Else
               bCheckForFixUp = True
               lCheckCol = m_tCols(lCol).lCellColIndex
            End If
         End If
      End If
      
      pSyncHeaderOrder
                  
      If (bCheckForFixUp) Then
         bCheckForFixUp = False
         lLastCol = 0
         For lCol = 1 To m_iCols
            If (m_tCols(lCol).bVisible And m_tCols(lCol).iGroupOrder = -1) Then
               If Not (m_tCols(lCol).bRowTextCol) Then
                  lLastCol = lCol
               End If
            End If
         Next lCol
         If (m_tCols(lLastCol).lHeaderColIndex - 1 = lColumn) Then
            bCheckForFixUp = True
         End If
      End If
      
      ' Redraw grid:
      m_bDirty = True
      Draw
      
      If (bCheckForFixUp) Then
         ColumnWidth(m_tCols(lLastCol).lCellColIndex) = m_tCols(lLastCol).lWidth
      End If
      
   End If
   
   RaiseEvent ColumnOrderChanged
   
End Sub

Private Sub m_cHeader_ColumnFilterChange(ByVal lColumn As Long, ByVal sFilter As String)
   '
   ' For future expansion
   '
End Sub

Private Sub m_cHeader_ColumnFilterClick(ByVal lColumn As Long)
   '
   ' For future expansion
   '
End Sub

Private Sub m_cHeader_ColumnGroupChange(lColumn As Long)
Dim bResetRedraw As Boolean

   Screen.MousePointer = vbHourglass
         
   If (m_bStretchLastColumnToFit) Then
      If Not (m_lStretchedColumn = 0) Then
         Dim lCol As Long
         lCol = plColumnIndexByIndex(m_lStretchedColumn)
         If (lColumn = m_tCols(lCol).lHeaderColIndex - 1) Then
            m_tCols(lCol).lWidth = m_tCols(lCol).lCorrectWidth
            m_cHeader.StealthSetColumnWidth m_tCols(lCol).lHeaderColIndex - 1, m_tCols(lCol).lWidth
            m_lStretchedColumn = 0
         End If
      End If
   End If

   ' Resync header
   pSyncHeaderOrder
      
   ' Stop redrawing
   If (m_bRedraw) Then
      bResetRedraw = True
      Redraw = False
   End If
      
   ' Remove all the group rows
   pRemoveGroupingRows
   
   ' Add the grouping rows we need
   pSetSortFromColumnHeader
   pAddGroupingRows
   
   ' Make sure rows are correctly visible
   pRowVisibility m_lSplitRow + 1
      
   ' Draw everything again
   If (bResetRedraw) Then
      Redraw = True
   End If
   
   Screen.MousePointer = vbDefault
   
   '
End Sub

Private Sub m_cHeader_ColumnManualDragRequest(ByVal lColumn As Long, bForceManualDragDrop As Boolean)
   '
   '
End Sub

Private Sub m_cHeader_ColumnUnGroup(lColumn As Long)
Dim bResetRedraw As Boolean

   Screen.MousePointer = vbHourglass

   ' Column ordering:
   pSyncHeaderOrder
      
   ' Stop redrawing
   If (m_bRedraw) Then
      bResetRedraw = True
      Redraw = False
   End If
   
   ' Remove all the group rows
   pRemoveGroupingRows
   
   ' Find out what's happened and determine what to do with the grouped
   ' rows.
   pSetSortFromColumnHeader
   pAddGroupingRows
   
   ' Make sure rows are visible
   pRowVisibility m_lSplitRow + 1
   
   ' Draw everything again
   If (bResetRedraw) Then
      Redraw = True
   End If
   
   Screen.MousePointer = vbDefault
   
   '
End Sub

Private Sub m_cHeader_ColumnWidthChanged(ByVal lColumn As Long, lWidth As Long)
Dim lCol As Long
Dim lColIndex As Long
Dim tR As RECT
Dim bCancel As Boolean
   
   For lCol = 1 To m_iCols
      If (m_tCols(lCol).lHeaderColIndex = lColumn + 1) Then
         lColIndex = m_tCols(lCol).lCellColIndex
         Exit For
      End If
   Next lCol
   
   If (lColIndex = 0) Then
      Debug.Print "ERK!!!"
      Exit Sub
   End If
   
   If (m_tCols(lColIndex).bFixedWidth) Then
      Exit Sub
   End If
   DrawDragImage tR, False, True

   
   ' 19/10/1999 (13)
   If (m_tCols(lColIndex).bVisible) Then
      ' 2003-11-27: Fix the column index that's sent
      RaiseEvent ColumnWidthChanged(lColIndex, lWidth, bCancel)
   End If
   If Not bCancel Then
      ColumnWidth(lColIndex) = lWidth
      m_bDirty = True
      Draw
      pResizeHeader
   End If
   
End Sub


Private Sub m_cHeader_ColumnWidthChanging(ByVal lColumn As Long, lWidth As Long, bCancel As Boolean)
Dim iCol As Long
Dim iIntCol As Long
Dim tR As RECT
   
   pGetDragImageRect lColumn, lWidth, tR, False

   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lHeaderColIndex = lColumn + 1) Then
         lColumn = m_tCols(iCol).lCellColIndex
         iIntCol = iCol
         Exit For
      End If
   Next iCol
   
   If (m_tCols(iIntCol).bFixedWidth) Then
      bCancel = True
      Exit Sub
   End If
   
   DrawDragImage tR, False, False
   RaiseEvent ColumnWidthChanging(lColumn, lWidth, bCancel)
   If (bCancel) Then
      DrawDragImage tR, False, True
   End If
   
End Sub

Private Sub m_cHeader_DividerDblClick(ByVal lColumn As Long)
Dim iCCol As Long
Dim iCol As Long
Dim bCancel As Boolean

   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lHeaderColIndex = lColumn + 1) Then
         iCCol = m_tCols(iCol).lCellColIndex
         Exit For
      End If
   Next iCol
   
   RaiseEvent ColumnDividerDblClick(iCCol, bCancel)
   
   If Not (bCancel) Then
      AutoWidthColumn iCCol
   End If
   
End Sub

''' <summary>
''' Fired when the m_cHeader wants to start an OleDrag.
''' </summary>
Private Sub m_cHeader_OleDrag()
   ' Pass through request to Ole Drag
   UserControl.OleDrag
   '
End Sub

''' <summary>
''' Fired when the header needs to be repainted
''' </summary>
Private Sub m_cHeader_RePaint()
   ' Pass through request to refresh the header portion
   UserControl_Paint
End Sub

''' <summary>
''' Fired when the header needs to be resized
''' </summary>
Private Sub m_cHeader_Resize()
   ' Pass through request to resize the header
   '
End Sub

''' <summary>
''' Fired when the user right clicks on the header
''' </summary>
Private Sub m_cHeader_RightClick(ByVal x As Single, ByVal y As Single)
   RaiseEvent HeaderRightClick(x, y)
End Sub

''' <summary>
''' Fired before a column's width is about to be changed.
''' </summary>
''' <param name="lColumn">Column index</param>
''' <param name="lWidth">Current width</param>
''' <param name="bCancel">Whether to cancel width changing</param>
Private Sub m_cHeader_StartColumnWidthChange(ByVal lColumn As Long, lWidth As Long, bCancel As Boolean)
Dim tR As RECT
Dim iCol As Long
   For iCol = 1 To m_iCols
      If (m_tCols(iCol).lHeaderColIndex = lColumn + 1) Then
         If (m_tCols(iCol).bFixedWidth) Then
            bCancel = True
         End If
      End If
   Next iCol
   If Not (bCancel) Then
      RaiseEvent ColumnWidthStartChange(lColumn + 1, lWidth, bCancel)
   End If
   If Not (bCancel) Then
      pGetDragImageRect lColumn, lWidth, tR, True
      DrawDragImage tR, True, False
   End If
End Sub

''' <summary>
''' Fired when the scroll bar changes.
''' </summary>
''' <param name="eBar">The scroll bar which changed.</param>
Private Sub m_cScroll_Change(eBar As EFSScrollBarConstants)
Dim bRedraw As Boolean
   
   If (eBar = efsHorizontal) Then
      m_lStartX = m_cScroll.Value(eBar) - m_cHeader.ColumnGroupCount * m_lDefaultRowHeight
   Else
      m_lStartY = m_cScroll.Value(eBar)
   End If
   If (eBar = efsHorizontal) Then
      If (m_cHeader.Visible) Then
         m_cHeader.Left = m_cScroll.Visible(efsHorizontal) * m_cScroll.Value(efsHorizontal) + m_cHeader.ColumnGroupCount * m_lDefaultRowHeight
      Else
         m_cHeader.Left = m_cHeader.ColumnGroupCount * m_lDefaultRowHeight
      End If
   End If
   pScrollSetDirty False
   Draw
      
   RaiseEvent ScrollChange(eBar)
   
      
End Sub

''' <summary>
''' Fired when the scroll bar is scrolled.
''' </summary>
''' <param name="eBar">The scroll bar which was scrolled.</param>
Private Sub m_cScroll_Scroll(eBar As EFSScrollBarConstants)
   m_cScroll_Change eBar
End Sub

Private Sub m_tmrHotTrack_ThatTime()
   If (m_bHotTrack) Then
      If (m_lHotTrackRow > 0) And (m_lHotTrackCol > 0) Then
         Dim tP As POINTAPI
         Dim tR As RECT
         Dim iGridCol As Long
         GetCursorPos tP
         ScreenToClient m_hWnd, tP
         GetClientRect m_hWnd, tR
         If (PtInRect(tR, tP.x, tP.y) = 0) Then
            If (m_bRowMode) Then
               For iGridCol = 1 To m_iCols
                  m_tCells(iGridCol, m_tRows(m_lHotTrackRow).lGridCellArrayRow).bDirtyFlag = True
               Next iGridCol
            Else
               iGridCol = plColumnIndexByIndex(m_lHotTrackCol)
               m_tCells(iGridCol, m_tRows(m_lHotTrackRow).lGridCellArrayRow).bDirtyFlag = True
            End If
            m_lHotTrackRow = 0
            m_lHotTrackCol = 0
            Draw
            RaiseEvent HotItemChange(0, 0)
            m_tmrHotTrack.Interval = 0
         End If
      Else
         m_tmrHotTrack.Interval = 0
      End If
   End If
End Sub

Private Sub m_tmrMarquee_ThatTime()
Dim tP As POINTAPI
Dim bKeepScrolling As Boolean

   If (m_bMultiSelect And m_bMarquee) Then
      If Not (GetAsyncKeyState(vbKeyLButton) = 0) Then
         If (m_lMarqueeStartRow > 0) And (m_lMarqueeStartCol > 0) Then
            GetCursorPos tP
            ScreenToClient m_hWnd, tP
            If (tP.y * Screen.TwipsPerPixelY > UserControl.ScaleHeight - 16 * Screen.TwipsPerPixelY) And (m_cScroll.Visible(efsVertical)) Then
               If (m_cScroll.Value(efsVertical) < m_cScroll.Max(efsVertical)) Then
                  m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) + m_cScroll.SmallChange(efsVertical)
                  bKeepScrolling = True
               End If
            ElseIf (tP.y < (m_cHeader.TOp + m_cHeader.Height) * Abs(m_bHeader) + 16) Then
               If (m_cScroll.Value(efsVertical) > 0) Then
                  m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) - m_cScroll.SmallChange(efsVertical)
                  bKeepScrolling = True
               End If
            End If
         End If
      End If
   End If
   
   If Not (bKeepScrolling) Then
      m_tmrMarquee.Interval = 0
   Else
      UserControl_MouseMove vbLeftButton, 0, tP.x * Screen.TwipsPerPixelX, tP.y * Screen.TwipsPerPixelY
   End If
   
End Sub

''' <summary>
''' Fired when the mouse is double clicked on the control.
''' </summary>
Private Sub UserControl_DblClick()
Dim tP As POINTAPI
Dim lRow As Long
Dim lCol As Long

On Error GoTo ErrorHandler
   If (m_bEnabled) Then
      GetCursorPos tP
      ScreenToClient UserControl.hwnd, tP
      CellFromPoint tP.x, tP.y, lRow, lCol
      If (lRow > 0) And (lCol > 0) Then
         If Not (m_iSelRow = lRow) Or Not (m_iSelCol = lCol) Then
            UserControl_MouseDown vbLeftButton, 0, UserControl.ScaleX(tP.x, vbPixels, UserControl.ScaleMode), UserControl.ScaleY(tP.y, vbPixels, UserControl.ScaleMode)
         End If
         RaiseEvent DblClick(m_iSelRow, m_iSelCol)
         If (m_iSelRow > 0) And (m_iSelCol > 0) Then
            If (m_iSelRow <= m_iRows) And (m_iSelCol <= m_iCols) Then
               Dim bIsGroupRow As Boolean
               If (m_tRows(m_iSelRow).lGroupIndentLevel > 0) Then
                  pExpandCollapseGroupingRow m_iSelRow
               Else
                  ' 2003-12-20: Don't go into edit mode unless the
                  ' double click occurs on a cell
                  pRequestEdit
               End If
            End If
         End If
      End If
   End If
   Exit Sub
ErrorHandler:
   Debug.Assert False
   Exit Sub
   
   Resume 0
End Sub

''' <summary>
''' Fired when the control gets the focus.
''' </summary>
Private Sub UserControl_GotFocus()
On Error GoTo ErrorHandler
   m_bInFocus = True
   pScrollSetDirty True
   Draw
   Exit Sub
ErrorHandler:
   Debug.Assert False
   Exit Sub
   Resume 0
End Sub

''' <summary>
''' Control constructor.
''' </summary>
Private Sub UserControl_Initialize()
   
   debugmsg "vbalGrid:Initialize"
   
   ' Hack for XP Crash under VB6
   m_hMod = LoadLibrary("shell32.dll")
   InitCommonControls
   
   ' Prepare default cell data:
   With m_tDefaultCell
      .iIconIndex = -1
      .lExtraIconIndex = -1
      .oBackColor = CLR_NONE
      .oForeColor = CLR_NONE
      .eTextFlags = DT_SINGLELINE Or DT_WORD_ELLIPSIS Or DT_LEFT Or DT_NOPREFIX
      .sText = Empty
      .lIndent = 0
      .bDirtyFlag = True
      .bSelected = False
      .lItemData = 0
   End With
   
   ' Initialse basic variables and default properties:
   ReDim m_tRows(0 To 0) As tRowPosition
   ReDim m_tCols(0 To 0) As tColPosition
   m_lDefaultColumnWidth = 64
   m_lDefaultRowHeight = 20
   m_oGridLineColor = vbButtonFace
   m_oGridFillLineColor = vb3DLight
   m_oHighlightBackColor = vbHighlight ' 19/10/1999 (8)
   m_oHighlightForeColor = vbHighlightText
   m_oNoFocusHighlightForeColor = vbWindowText ' 2003/11/24
   m_oNoFocusHighlightBackColor = vbButtonFace ' 2003/11/24
   m_oGroupRowBackColor = vbButtonFace ' 2003/11/27
   m_oGroupRowForeColor = vbWindowText ' 2003/11/27
   m_oGroupAreaBackColor = vbButtonShadow ' 2003/11/27
   m_oAlternateRowBackColor = -1 ' 2003/12/07
   m_oGutterBackColor = -1 ' 2003/12/13
   m_bAllowVert = True
   m_bAllowHorz = True
   m_eBorderStyle = ecgBorderStyle3d
   m_bRedraw = True
   m_bDrawFocusRectangle = True
   m_bDisableIcons = True
   m_bHighlightSelectedIcons = True
   m_lSplitSeparatorSize = 4
   
End Sub

''' <summary>
''' Initialise the control when there is no persisted data.
''' </summary>
Private Sub UserControl_InitProperties()
   
   pCreateHeader
   ' 2003-11-10: Fix to ensure that scroll bars are created when New control
   pInitialise
   
   BackColor = vbWindowBackground
   ForeColor = vbWindowText
   Set Font = Ambient.Font
   BorderStyle = ecgBorderStyle3d
   Header = True
   Enabled = True
   
End Sub

''' <summary>
''' Fired when a key is pressed and the control has the input focus.
''' </summary>
''' <param name="KeyCode">Virtual key code of key</param>
''' <param name="Shift">Flags specifying which shift modifiers are
''' pressed, if any.</param>
Private Sub UserControl_KeyDown(KeyCode As Integer, Shift As Integer)
Dim iRow As Long, iCol As Long
Dim iInitSelCol As Long, iInitSelRow As Long
Dim lNextPage As Long
Dim bFound As Boolean
Dim iSelRow As Long
Dim bSingleGroupRowScroll As Boolean
Dim bDoDefault As Boolean

On Error GoTo ErrorHandler

   If (m_iRows = 0) Or (m_iCols = 0) Then
      Exit Sub
   End If

   If (KeyCode = vbKeyTab) Then
      If (Shift And vbShiftMask) = vbShiftMask Then
         If (m_bRowMode) Then
            KeyCode = vbKeyUp
         Else
            KeyCode = vbKeyLeft
         End If
      Else
         If (m_bRowMode) Then
            KeyCode = vbKeyDown
         Else
            KeyCode = vbKeyRight
         End If
      End If
   End If
   
   If Not (m_bEnabled) Then
      Select Case KeyCode
      Case vbKeyUp
         If (m_cScroll.Visible(efsVertical)) Then
            m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) - m_cScroll.SmallChange(efsVertical)
         End If
      Case vbKeyDown
         If (m_cScroll.Visible(efsVertical)) Then
            m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) + m_cScroll.SmallChange(efsVertical)
         End If
      Case vbKeyLeft
         If (m_cScroll.Visible(efsHorizontal)) Then
            m_cScroll.Value(efsHorizontal) = m_cScroll.Value(efsHorizontal) - m_cScroll.SmallChange(efsHorizontal)
         End If
      Case vbKeyRight
         If (m_cScroll.Visible(efsHorizontal)) Then
            m_cScroll.Value(efsHorizontal) = m_cScroll.Value(efsHorizontal) + m_cScroll.SmallChange(efsHorizontal)
         End If
      Case vbKeyPageUp
         If (m_cScroll.Visible(efsVertical)) Then
            m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) - m_cScroll.LargeChange(efsVertical)
         End If
      Case vbKeyPageDown
         If (m_cScroll.Visible(efsVertical)) Then
            m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) + m_cScroll.LargeChange(efsVertical)
         End If
      End Select
      Exit Sub
   End If

   If m_iRows > 0 And m_iCols > 0 Then
      bDoDefault = True
   End If
   RaiseEvent KeyDown(KeyCode, Shift, bDoDefault)
   If (bDoDefault) Then

      '
      If (m_iRows = 0) Or (m_iCols = 0) Then
         Exit Sub
      End If
      
      If m_iSelRow <= 0 Or m_iSelRow <= 0 Then
         Exit Sub
      End If
      
      If (KeyCode = vbKeyLeft Or KeyCode = vbKeyRight) And Shift = 0 Then
         If (m_tRows(m_iSelRow).bGroupRow) Then
            If m_cScroll.Visible(efsHorizontal) Then
               If KeyCode = vbKeyLeft Then
                  If m_cScroll.Value(efsHorizontal) <> 0 Then
                     bSingleGroupRowScroll = True
                  End If
               Else
                  If m_cScroll.Value(efsHorizontal) <> m_cScroll.Max(efsHorizontal) Then
                     bSingleGroupRowScroll = True
                  End If
               End If
            End If
         End If
      End If
      
      iInitSelCol = m_iSelCol
      iInitSelRow = m_iSelRow
         
      Select Case KeyCode
      Case vbKeySpace
         If (Shift And vbCtrlMask) = vbCtrlMask Then
            If (m_bMultiSelect) Then
               ' Select/deselect this cell
               If (m_bRowMode) Then
                  For iCol = 1 To m_iCols
                     m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected)
                     m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                  Next iCol
               Else
                  m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected)
                  m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
               End If
               Draw
               pRequestEdit
            End If
         End If
      
      Case vbKeyLeft
         m_sSearchString = ""
         If (m_bRowMode) Or bSingleGroupRowScroll Then
            ' Equivalent to scrolling left
            If m_cScroll.Visible(efsHorizontal) Then
               m_cScroll.Value(efsHorizontal) = m_cScroll.Value(efsHorizontal) - m_cScroll.SmallChange(efsHorizontal)
            End If
         Else
            pGetNextVisibleCell -1, 0
            If (m_bMultiSelect) Then
               If (Shift And vbShiftMask) = vbShiftMask Then
                  ' Add this cell to the selection:
                  m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected)
                  m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
               ElseIf (Shift And vbCtrlMask) = vbCtrlMask Then
                  m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
               ElseIf (Shift = 0) Then
                  ' This is the selected cell:
                  For iRow = 1 To m_iRows
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (((iRow = m_iSelRow) And (iCol = m_iSelCol)) <> m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol))
                     Next iCol
                  Next iRow
               End If
            Else
               pSingleModeSelect
            End If
            If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
               Draw
            End If
            
         End If
         
      Case vbKeyRight
         m_sSearchString = ""
         If (m_bRowMode) Or bSingleGroupRowScroll Then
            ' Equivalent to scrolling right
            If (m_cScroll.Visible(efsHorizontal)) Then
               m_cScroll.Value(efsHorizontal) = m_cScroll.Value(efsHorizontal) + m_cScroll.SmallChange(efsHorizontal)
            End If
         Else
            pGetNextVisibleCell 1, 0
            If (m_bMultiSelect) Then
               If (Shift And vbShiftMask) = vbShiftMask Then
                  ' Add this cell to the selection:
                  m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected)
                  m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
               ElseIf (Shift And vbCtrlMask) = vbCtrlMask Then
                  m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
               ElseIf (Shift = 0) Then
                  ' This is the selected cell:
                  For iRow = 1 To m_iRows
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (((iRow = m_iSelRow) And (iCol = m_iSelCol)) <> m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol))
                     Next iCol
                  Next iRow
               End If
            Else
               pSingleModeSelect
            End If
            If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
               Draw
            End If
         End If
      
      Case vbKeyUp
         ' Move selection up if there is one, otherwise scroll:
         m_sSearchString = ""
         If (m_iSelRow <> 0) Then
            If (m_iSelRow > 1) Then
               pGetNextVisibleCell 0, -1
               If (m_bMultiSelect) Then
                  If (m_bRowMode) Then
                     If (Shift And vbShiftMask) = vbShiftMask Then
                        ' Add this row to the selection:
                        For iCol = 1 To m_iCols
                           m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected)
                           m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                        Next iCol
                     ElseIf (Shift And vbCtrlMask) = vbCtrlMask Then
                        m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                     ElseIf (Shift = 0) Then
                        ' Switch selected row to current:
                        For iRow = 1 To m_iRows
                           For iCol = 1 To m_iCols
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = ((iRow = m_iSelRow) <> m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow)
                           Next iCol
                        Next iRow
                     End If
                  Else
                     If (Shift And vbShiftMask) = vbShiftMask Then
                        ' Add/remove this cell from the selection:
                        m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected)
                        m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                     ElseIf (Shift And vbCtrlMask) = vbCtrlMask Then
                        m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                     ElseIf (Shift = 0) Then
                        ' Switch selected cell to current:
                        For iRow = 1 To m_iRows
                           For iCol = 1 To m_iCols
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (((iRow = m_iSelRow) And (iCol = m_iSelCol)) <> m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol))
                           Next iCol
                        Next iRow
                     End If
                  End If
               Else
                  pSingleModeSelect
               End If
               If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
                  Draw
               End If
            End If
         Else
            m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) - m_cScroll.SmallChange(efsVertical)
         End If
      
      Case vbKeyDown
         ' Move selection up if there is one, otherwise scroll:
         m_sSearchString = ""
         If (m_iSelRow <> 0) Then
            If (m_iSelRow < m_iRows) Then
               pGetNextVisibleCell 0, 1
               If (m_bMultiSelect) Then
                  If (m_bRowMode) Then
                     If (Shift And vbShiftMask) = vbShiftMask Then
                        ' Add this row to the selection:
                        For iCol = 1 To m_iCols
                           m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected)
                           m_tCells(iCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                        Next iCol
                     ElseIf (Shift And vbCtrlMask) = vbCtrlMask Then
                        m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                     ElseIf (Shift = 0) Then
                        ' Switch selected row to current:
                        For iRow = 1 To m_iRows
                           For iCol = 1 To m_iCols
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = ((iRow = m_iSelRow) <> m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow)
                           Next iCol
                        Next iRow
                     End If
                  Else
                     If (Shift And vbShiftMask) = vbShiftMask Then
                        ' Add/remove this cell from the selection:
                        m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bSelected)
                        m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                     ElseIf (Shift And vbCtrlMask) = vbCtrlMask Then
                        m_tCells(m_iSelCol, m_tRows(m_iSelRow).lGridCellArrayRow).bDirtyFlag = True
                     ElseIf (Shift = 0) Then
                        ' Switch selected cell to current:
                        For iRow = 1 To m_iRows
                           For iCol = 1 To m_iCols
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> ((iRow = m_iSelRow) And (iCol = m_iSelCol)))
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol))
                           Next iCol
                        Next iRow
                     End If
                  End If
               Else
                  pSingleModeSelect
               End If
               If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
                  Draw
               End If
            End If
         Else
            m_cScroll.Value(efsVertical) = m_cScroll.Value(efsVertical) - m_cScroll.SmallChange(efsVertical)
         End If
      
      Case vbKeyPageUp
         ' Move up by the equivalent of one page:
         m_sSearchString = ""
         iRow = m_iSelRow
         lNextPage = m_tRows(iRow).lStartY - m_lAvailheight + m_tRows(iRow).lHeight
         Do
            iRow = iRow - 1
            If (iRow < 1) Then
               iRow = plGetFirstVisibleRow()
               bFound = True
            Else
               If (m_tRows(iRow).bVisible) Then
                  If (m_tRows(iRow).lStartY < lNextPage) Then
                     bFound = True
                  End If
               End If
            End If
         Loop While Not bFound
         
         If (m_bMultiSelect) Then
            iSelRow = iRow
            If (Shift And vbShiftMask) = vbShiftMask Then
               ' Toggle everything between m_iSelRow and iRow to the selection
               If (m_bRowMode) Then
                  For iRow = m_iSelRow - 1 To iRow Step -1
                     For iCol = 1 To m_iCols
                        m_tCells(m_iSelCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                     Next iCol
                  Next iRow
               Else
                  For iRow = m_iSelRow - 1 To iRow Step -1
                     m_tCells(m_iSelCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                     m_tCells(m_iSelCol, m_tRows(iRow).lGridCellArrayRow).bSelected = Not (m_tCells(m_iSelCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                  Next iRow
               End If
            ElseIf (Shift And vbCtrlMask) = vbCtrlMask Then
            
            Else
               If (m_bRowMode) Then
                  For iRow = 1 To m_iRows
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> (iRow = iSelRow))
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = iSelRow)
                     Next iCol
                  Next iRow
               Else
                  For iRow = 1 To m_iRows
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> ((iRow = iSelRow) And (iCol = m_iSelCol)))
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = iSelRow) And (iCol = m_iSelCol))
                     Next iCol
                  Next iRow
               End If
            End If
            m_iSelRow = iSelRow
         Else
            m_iSelRow = iRow
            pSingleModeSelect
         End If
         If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
            Draw
         End If
      
      Case vbKeyPageDown
         m_sSearchString = ""
         ' Move down by the equivalent of one page:
         iRow = m_iSelRow
         lNextPage = m_tRows(iRow).lStartY + m_lAvailheight - m_tRows(iRow).lHeight
         Do
            iRow = iRow + 1
            If (iRow > m_iRows) Then
               iRow = plGetLastVisibleRow()
               bFound = True
            End If
            If (m_tRows(iRow).bVisible) Then
               If (m_tRows(iRow).lStartY > lNextPage) Then
                  bFound = True
               End If
            End If
         Loop While Not bFound
         
         If (m_bMultiSelect) Then
            iSelRow = iRow
            If (Shift And vbShiftMask) = vbShiftMask Then
               ' Toggle everything between m_iSelRow and iRow to the selection
               If (m_bRowMode) Then
                  For iRow = m_iSelRow + 1 To iRow
                     For iCol = 1 To m_iCols
                        m_tCells(m_iSelCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                     Next iCol
                  Next iRow
               Else
                  For iRow = m_iSelRow + 1 To iRow
                     m_tCells(m_iSelCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                     m_tCells(m_iSelCol, m_tRows(iRow).lGridCellArrayRow).bSelected = Not (m_tCells(m_iSelCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                  Next iRow
               End If
            ElseIf (Shift And vbCtrlMask) = vbCtrlMask Then
            
            ElseIf (Shift = 0) Then
               If (m_bRowMode) Then
                  For iRow = 1 To m_iRows
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> (iRow = iSelRow))
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = iSelRow)
                     Next iCol
                  Next iRow
               Else
                  For iRow = 1 To m_iRows
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected <> ((iRow = iSelRow) And (iCol = m_iSelCol)))
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = iSelRow) And (iCol = m_iSelCol))
                     Next iCol
                  Next iRow
               End If
               
            End If
            m_iSelRow = iSelRow
         Else
            m_iSelRow = iRow
            pSingleModeSelect
         End If
         If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
            Draw
         End If
         
      
      Case vbKeyHome
         m_sSearchString = ""
         m_iSelRow = plGetFirstVisibleRow()
         If (m_bMultiSelect) Then
            If (Shift And vbShiftMask) = vbShiftMask Then
               For iRow = m_iSelRow To 1 Step -1
                  If m_bRowMode Then
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                     Next iCol
                  Else
                     For iCol = 1 To m_iSelCol
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                     Next iCol
                  End If
               Next iRow
            Else
               For iRow = 1 To m_iRows
                  For iCol = 1 To m_iCols
                     If (m_bRowMode) Then
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow))
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow)
                     Else
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol)))
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol))
                     End If
                  Next iCol
               Next iRow
            End If
         Else
            pSingleModeSelect
         End If
         If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
            Draw
         End If
         
      Case vbKeyEnd
         m_sSearchString = ""
         m_iSelRow = plGetLastVisibleRow()
         If (m_bMultiSelect) Then
            If (Shift And vbShiftMask) = vbShiftMask Then
               For iRow = m_iSelRow To m_iRows
                  If m_bRowMode Then
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                     Next iCol
                  Else
                     For iCol = 1 To m_iSelCol
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                     Next iCol
                  End If
               Next iRow
            Else
               For iRow = 1 To m_iRows
                  For iCol = 1 To m_iCols
                     If (m_bRowMode) Then
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow))
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = (iRow = m_iSelRow)
                     Else
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol)))
                        m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = ((iRow = m_iSelRow) And (iCol = m_iSelCol))
                     End If
                  Next iCol
               Next iRow
            End If
         Else
            pSingleModeSelect
         End If
         If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
            Draw
         End If
      
      Case vbKeyReturn, vbKeyF2, vbKeyF4
         ' Equivalent to double-clicking the cell:
         If (m_tRows(m_iSelRow).bGroupRow) Then
            pExpandCollapseGroupingRow m_iSelRow
         End If
         pRequestEdit
         
      Case vbKeyEscape
         ' If in Edit then cancel editing:
         m_sSearchString = ""
         CancelEdit
               
      End Select
      
      If (iInitSelCol <> m_iSelCol) Or (iInitSelRow <> m_iSelRow) Then
         RaiseEvent SelectionChange(m_iSelRow, m_iSelCol)
      End If
   End If
   Exit Sub

ErrorHandler:
   Debug.Assert False
   Exit Sub
   Resume 0
End Sub

''' <summary>
''' Fired when a key is pressed, the control has the input focus and
''' the virtual key code has been translated to an ASCII code.
''' </summary>
''' <param name="KeyAscii">ASCII code of key which was pressed.</param>
Private Sub UserControl_KeyPress(KeyAscii As Integer)

On Error GoTo ErrorHandler
   
   If (m_iRows = 0) Or (m_iCols = 0) Then
      Exit Sub
   End If
   
   pRequestEdit KeyAscii
   RaiseEvent KeyPress(KeyAscii)
   
   Exit Sub
   
ErrorHandler:
   Debug.Assert False
   Exit Sub
End Sub

''' <summary>
''' Fired when a key is released following a KeyDown event.
''' </summary>
''' <param name="KeyCode">Virtual key code of key</param>
''' <param name="Shift">Flags specifying which shift modifiers are
''' pressed, if any.</param>
Private Sub UserControl_KeyUp(KeyCode As Integer, Shift As Integer)
On Error GoTo ErrorHandler
      
   RaiseEvent KeyUp(KeyCode, Shift)
   
   Exit Sub
ErrorHandler:
   Debug.Assert False
   Exit Sub
End Sub

''' <summary>
''' Fired when the control goes out of focus.
''' </summary>
Private Sub UserControl_LostFocus()
On Error GoTo ErrorHandler
   m_bInFocus = False
   pScrollSetDirty True
   Draw
   Exit Sub
ErrorHandler:
   Debug.Assert False
   Exit Sub
End Sub

''' <summary>
''' Fired when the mouse is clicked over the control.
''' </summary>
''' <param name="Button">Mouse button being used.</param>
''' <param name="Shift">Flags specifying shift keys which are pressed.</param>
''' <param name="x">X position of mouse.</param>
''' <param name="y">Y position of mouse.</param>
Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim lSelRow As Long, lSelCol As Long
Dim iRow As Long, iCol As Long
Dim iStartCol As Long, iEndCol As Long, iStartRow As Long, iEndRow As Long
Dim bS As Boolean
Dim iInitSelCol As Long, iInitSelRow As Long
Dim bDefault As Boolean
Dim bInHeader As Boolean
Dim mX As Single, mY As Single

On Error GoTo ErrorHandler

   If Not (m_bEnabled) Then
      Exit Sub
   End If
   
   m_bSelChange = False
   
   RaiseEvent MouseDown(Button, Shift, x, y, bDefault)
      
   mX = UserControl.ScaleX(x, UserControl.ScaleMode, vbPixels)
   mY = UserControl.ScaleY(y, UserControl.ScaleMode, vbPixels)
   If (m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox)) And (m_bHeader) Then
      If (mY <= m_cHeader.TOp + m_cHeader.Height) Then
         bInHeader = True
      End If
   End If
   
   If (bInHeader) Then
      m_cHeader.UserControl_MouseDown Button, Shift, mX, mY
   Else
      CellFromPoint mX, mY, lSelRow, lSelCol
      If (Button = vbLeftButton) Then
         bDefault = True
      ElseIf (Button = vbRightButton) Then
         If (lSelRow > 0) And (lSelCol > 0) Then
            If Not (m_tCells(lSelCol, m_tRows(lSelRow).lGridCellArrayRow).bSelected) Then
               bDefault = True
            End If
         End If
      End If
      
      If (bDefault) Then
         m_sSearchString = ""
         m_bMouseDown = True
         iInitSelCol = m_iSelCol
         iInitSelRow = m_iSelRow
         If (lSelRow > 0) And (lSelCol > 0) Then
            If (Shift And vbShiftMask) = vbShiftMask Then
               If (m_iSelRow = 0) Or (m_iSelCol = 0) Then
                  m_iSelRow = lSelRow
                  m_iSelCol = lSelCol
               End If
               If (m_bMultiSelect) Then
                  If (lSelRow > 0) And (lSelCol > 0) Then
                     If (lSelRow = m_iSelRow) And (lSelCol = m_iSelCol) Then
                        pRequestEdit
                        Exit Sub
                     Else
                        ' We have made a selection with shift held down.
                        ' Select all the cells between here and the previous selected point:
                        If (lSelCol > m_iSelCol) Then
                           If (m_bRowMode) Then
                              iStartCol = 1
                              iEndCol = m_iCols
                           Else
                              iStartCol = m_iSelCol
                              iEndCol = lSelCol
                           End If
                        Else
                           If (m_bRowMode) Then
                              iStartCol = 1
                              iEndCol = m_iCols
                           Else
                              iStartCol = lSelCol
                              iEndCol = m_iSelCol
                           End If
                        End If
                        If (lSelRow > m_iSelRow) Then
                           iStartRow = m_iSelRow
                           iEndRow = lSelRow
                        Else
                           iStartRow = lSelRow
                           iEndRow = m_iSelRow
                        End If
                        For iRow = 1 To m_iRows
                           For iCol = 1 To m_iCols
                              If (iRow >= iStartRow) And (iRow <= iEndRow) Then
                                 If (iCol >= iStartCol) And (iCol <= iEndCol) Then
                                    bS = True
                                 Else
                                    bS = False
                                 End If
                              Else
                                 bS = False
                              End If
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = Not (bS = m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = bS
                           Next iCol
                        Next iRow
                        If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
                           Draw
                        End If
                        Exit Sub
                     End If
                  End If
               End If
            Else
               m_iSelRow = lSelRow
               m_iSelCol = lSelCol
            End If
            
            ' Select according to mode:
            If (lSelRow = m_iLastSelRow) And (lSelCol = m_iLastSelCol) Then
               pRequestEdit
               Exit Sub
            End If
            
            If m_bMultiSelect Then
               
               ' Select this cell or row depending on mode:
               If (Shift And vbCtrlMask) = vbCtrlMask Then
                  If (m_bRowMode) Then
                     ' .. add row to selection:
                     For iCol = 1 To m_iCols
                        m_tCells(iCol, m_tRows(lSelRow).lGridCellArrayRow).bDirtyFlag = True
                        m_tCells(iCol, m_tRows(lSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(iCol, m_tRows(lSelRow).lGridCellArrayRow).bSelected)
                     Next iCol
                  Else
                     ' .. add cell to selection:
                     m_tCells(lSelCol, m_tRows(lSelRow).lGridCellArrayRow).bDirtyFlag = True
                     m_tCells(lSelCol, m_tRows(lSelRow).lGridCellArrayRow).bSelected = Not (m_tCells(lSelCol, m_tRows(lSelRow).lGridCellArrayRow).bSelected)
                  End If
               Else
                  If (m_bRowMode) Then
                     ' .. add row to selection and remove others:
                     For iRow = 1 To m_iRows
                        For iCol = 1 To m_iCols
                           If (iRow = lSelRow) Then
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = True
                              bS = True 'Not (m_tCells(iCol, iRow).bSelected)
                           Else
                              bS = False
                              m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (bS <> m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                           End If
                           m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = bS
                        Next iCol
                     Next iRow
                  Else
                     ' .. Add cell to selection and remove others:
                     For iRow = 1 To m_iRows
                        For iCol = 1 To m_iCols
                           If ((iRow = lSelRow) And (iCol = lSelCol)) Then
                              bS = Not (m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                           Else
                              bS = False
                           End If
                           m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bDirtyFlag = (bS <> m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected)
                           m_tCells(iCol, m_tRows(iRow).lGridCellArrayRow).bSelected = bS
                        Next iCol
                     Next iRow
                  End If
               End If
               
               If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
                  Draw
               End If
            Else
               pSingleModeSelect
               If Not (pbEnsureVisible(m_iSelRow, m_iSelCol)) Then
                  Draw
               End If
            End If
         End If
      
         If (iInitSelCol <> m_iSelCol) Or (iInitSelRow <> m_iSelRow) Then
            m_bSelChange = True
            RaiseEvent SelectionChange(m_iSelRow, m_iSelCol)
         End If
         
         If (m_bMultiSelect And m_bMarquee) Then
            If (m_lMarqueeStartRow = 0) Then
               m_lMarqueeStartRow = m_iSelRow
               m_lMarqueeEndRow = m_iSelRow
            End If
            If (m_lMarqueeStartCol = 0) Then
               m_lMarqueeStartCol = m_iSelCol
               m_lMarqueeEndCol = m_iSelCol
            End If
         End If
      End If
      
   End If
   Exit Sub
   
ErrorHandler:
   Debug.Assert False
   Exit Sub
   ' The classic :)
   ' I thought of adding a quote mark each time I got in there but there might be more
   ' quotes than code...
   Resume 0
End Sub

''' <summary>
''' Fired when the mouse moves over the control, or moves anywhere after
''' being clicked over the control.
''' </summary>
''' <param name="Button">Mouse button being used.</param>
''' <param name="Shift">Flags specifying shift keys which are pressed.</param>
''' <param name="x">X position of mouse.</param>
''' <param name="y">Y position of mouse.</param>
Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)

Dim mX As Single
Dim mY As Single
Dim lRow As Long
Dim lCol As Long
Dim iGridCol As Long
Dim bUpdate As Boolean

On Error GoTo ErrorHandler
   
   If Not (m_bEnabled) Then
      Exit Sub
   End If
   
   RaiseEvent MouseMove(Button, Shift, x, y)
      
   mX = UserControl.ScaleX(x, UserControl.ScaleMode, vbPixels)
   mY = UserControl.ScaleY(y, UserControl.ScaleMode, vbPixels)
   
   If (Button = vbLeftButton) And _
      (m_bMultiSelect And m_bMarquee) And _
      (m_lMarqueeStartRow > 0) And (m_lMarqueeStartCol > 0) Then
         
      If (y > UserControl.ScaleHeight - 16 * Screen.TwipsPerPixelY) And (m_cScroll.Visible(efsVertical)) Then
         If (m_cScroll.Value(efsVertical) < m_cScroll.Max(efsVertical)) Then
            m_tmrMarquee.Interval = 50
            mY = UserControl.ScaleHeight \ Screen.TwipsPerPixelY - 1
         End If
      ElseIf (mY < (m_cHeader.TOp + m_cHeader.Height) * Abs(m_bHeader) + 16) Then
         If (m_cScroll.Value(efsVertical) > 0) Then
            m_tmrMarquee.Interval = 50
            mY = (m_cHeader.TOp + m_cHeader.Height) * Abs(m_bHeader) + 1
         End If
      End If
      
      CellFromPoint mX, mY, lRow, lCol
      
      If (lCol > 0) And (lRow > 0) Then
         If Not ((lRow = m_lMarqueeEndRow) And (lCol = m_lMarqueeEndCol)) Then
            pSelectMarquee lRow, lCol
            RaiseEvent SelectionChange(m_iSelRow, m_iSelCol)
         End If
      End If

   Else
   
      If (m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox)) And m_bHeader And _
         (mY <= m_cHeader.TOp + m_cHeader.Height) Then
         
         m_cHeader.UserControl_MouseMove Button, Shift, mX, mY
      
      End If
      
      If (Button = 0) And (m_bHotTrack) Then
      
         CellFromPoint mX, mY, lRow, lCol
         If (lCol = 0) Then lRow = 0
         If (lRow = 0) Then lCol = 0
         
         If (lRow = m_lHotTrackRow) And (lCol = m_lHotTrackCol) Then
         Else
            
            If (m_lHotTrackRow > 0) And (m_lHotTrackCol > 0) Then
               If (m_bRowMode) Then
                  For iGridCol = 1 To m_iCols
                     m_tCells(iGridCol, m_tRows(m_lHotTrackRow).lGridCellArrayRow).bDirtyFlag = True
                  Next iGridCol
               Else
                  m_tCells(m_lHotTrackCol, m_tRows(m_lHotTrackRow).lGridCellArrayRow).bDirtyFlag = True
               End If
               bUpdate = True
            End If
            
            If (lRow > 0) And (lCol > 0) Then
               If (m_bRowMode) Then
                  For iGridCol = 1 To m_iCols
                     m_tCells(iGridCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
                  Next iGridCol
               Else
                  m_tCells(lCol, m_tRows(lRow).lGridCellArrayRow).bDirtyFlag = True
               End If
               bUpdate = True
            End If
            
            m_lHotTrackRow = lRow
            m_lHotTrackCol = lCol
            
            If (bUpdate) Then
               Draw
               RaiseEvent HotItemChange(lRow, lCol)
            End If
            
            If Not (m_lHotTrackRow = 0 Or m_lHotTrackCol = 0) Then
               m_tmrHotTrack.Interval = 50
            Else
               m_tmrHotTrack.Interval = 0
            End If
                        
         End If
      End If
      
   End If
   
   Exit Sub
   
ErrorHandler:
   Debug.Assert False
   Exit Sub
   
   Resume 0
End Sub

''' <summary>
''' Fired when a mouse button is released after being clicked over the control.
''' </summary>
''' <param name="Button">Mouse button being used.</param>
''' <param name="Shift">Flags specifying shift keys which are pressed.</param>
''' <param name="x">X position of mouse.</param>
''' <param name="y">Y position of mouse.</param>
Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim lSelRow As Long, lSelCol As Long
Dim iRow As Long, iCol As Long
Dim bS As Boolean
Dim mX As Single, mY As Single
Dim bRedraw As Boolean

On Error GoTo ErrorHandler
   
   If Not (m_bEnabled) Then
      Exit Sub
   End If
      
   m_tmrMarquee.Interval = 0
   m_lMarqueeStartRow = 0
   m_lMarqueeEndRow = 0
   m_lMarqueeStartCol = 0
   m_lMarqueeEndCol = 0
   
   m_bMouseDown = False
   RaiseEvent MouseUp(Button, Shift, x, y)
   
   mX = UserControl.ScaleX(x, UserControl.ScaleMode, vbPixels)
   mY = UserControl.ScaleY(y, UserControl.ScaleMode, vbPixels)
   If (m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox)) And m_bHeader Then
      If (mY <= m_cHeader.TOp + m_cHeader.Height) Then
         m_cHeader.UserControl_MouseUp Button, Shift, mX, mY
      End If
   End If
   
   If (m_bSingleClickEdit) And (Button = vbLeftButton) Then
      If (m_bSelChange) Then
         bRedraw = m_bRedraw
         m_bRedraw = False
         UserControl_MouseDown Button, Shift, x, y
         m_bRedraw = bRedraw
      End If
   End If
   
   
   Exit Sub

ErrorHandler:
   Debug.Assert False
   Exit Sub
End Sub

''' <summary>
''' Fired during a drag-drop operation when a drag operation is completed.
''' </summary>
''' <param name="Effect">Flags specifying what can happen during drag-drop.</param>
Private Sub UserControl_OLECompleteDrag(Effect As Long)
   '
   If (m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox) And m_bHeader) Then
      m_cHeader.UserControl_OLECompleteDrag Effect
   End If
   '
End Sub

''' <summary>
''' Fired during a drag-drop operation when an object is dropped on the cotnrol.
''' </summary>
''' <param name="Data"><c>DataObject</c> specifying the drag-drop data.</param>
''' <param name="Effect">Flags specifying what can happen during drag-drop.</param>
''' <param name="Button">Mouse button being used.</param>
''' <param name="Shift">Flags specifying shift keys which are pressed.</param>
''' <param name="x">X position of mouse.</param>
''' <param name="y">Y position of mouse.</param>
Private Sub UserControl_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)
   
   ' Pass through event to the header
   If (m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox) And m_bHeader) Then
      m_cHeader.UserControl_OLEDragDrop Data, Effect, Button, Shift, x, y
   End If
   
End Sub

''' <summary>
''' Fired during a drag-drop operation when an object is dragged over the cotnrol.
''' </summary>
''' <param name="Data"><c>DataObject</c> specifying the drag-drop data.</param>
''' <param name="Effect">Flags specifying what can happen during drag-drop.</param>
''' <param name="Button">Mouse button being used.</param>
''' <param name="Shift">Flags specifying shift keys which are pressed.</param>
''' <param name="x">X position of mouse.</param>
''' <param name="y">Y position of mouse.</param>
''' <param name="State">state of drag-drop operation.</param>
Private Sub UserControl_OLEDragOver(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)
   
   ' Pass through event to the header
   If (m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox) And m_bHeader) Then
      m_cHeader.UserControl_OLEDragOver Data, Effect, Button, Shift, x, y, State
   End If
   '
End Sub

''' <summary>
''' Start drag-drop processing
''' </summary>
''' <param name="Data"><c>DataObject</c> specifying the drag-drop data.</param>
''' <param name="AllowedEffects">Flags specifying what can happen during drag-drop.</param>
Private Sub UserControl_OLEStartDrag(Data As DataObject, AllowedEffects As Long)
   '
   If (m_cHeader.AllowGrouping And Not (m_cHeader.HideGroupingBox) And m_bHeader) Then
      m_cHeader.UserControl_OLEStartDrag Data, AllowedEffects
   End If
   '
End Sub

''' <summary>
''' Draw the control when it or any portion is uncovered.
''' </summary>
Private Sub UserControl_Paint()
On Error GoTo ErrorHandler
   
   If m_bRedraw And m_bUserMode Then
   
      ' Draw the headers:
      m_cHeader.PaintGroups UserControl.hdc, m_oGroupAreaBackColor
      If (m_cHeader.Left > 0) Then
         Dim tR As RECT
         tR.Left = 0
         tR.TOp = m_cHeader.TOp
         tR.Right = m_cHeader.Left
         tR.Bottom = m_cHeader.TOp + m_cHeader.Height
         DrawPreHeaderPart UserControl.hwnd, UserControl.hdc, tR, m_bHeaderFlat
      End If
      
      ' Split part:
      If (m_lSplitRow > 0) Then
         If (m_lSplitSeparatorSize > 0) Then
            GetClientRect UserControl.hwnd, tR
            tR.TOp = m_cHeader.TOp + m_cHeader.Height + plSplitSize() - m_lSplitSeparatorSize
            tR.Bottom = tR.TOp + m_lSplitSeparatorSize
            Dim hBr As Long
            hBr = GetSysColorBrush(vbButtonFace And &H1F&)
            FillRect UserControl.hdc, tR, hBr
            DeleteObject hBr
         End If
      End If
   
      ' Draw the grid:
      pScrollSetDirty True
      Draw
      
   End If
   
   Exit Sub
ErrorHandler:
   Debug.Assert False
   Exit Sub
   Resume 0
End Sub

''' <summary>
''' Realize properties from the container's storage.
''' </summary>
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
   
   pCreateHeader
   ' 2003-11-10: Fix to ensure that scroll bars are created when New control
   pInitialise
   
   MultiSelect = PropBag.ReadProperty("MultiSelect", False)
   RowMode = PropBag.ReadProperty("RowMode", False)
   GridLines = PropBag.ReadProperty("GridLines", False)
   ' 2003-11-26: More grid line properties
   NoHorizontalGridLines = PropBag.ReadProperty("NoHorizontalGridLines", False)
   NoVerticalGridLines = PropBag.ReadProperty("NoVerticalGridLines", False)
   GridLineMode = PropBag.ReadProperty("GridLineMode", ecgGridStandard)
   
   Set BackgroundPicture = PropBag.ReadProperty("BackgroundPicture", Nothing)
   BackgroundPictureHeight = PropBag.ReadProperty("BackgroundPictureHeight", 0)
   BackgroundPictureWidth = PropBag.ReadProperty("BackgroundPictureWidth", 0)
   BackColor = PropBag.ReadProperty("BackColor", vbWindowBackground)
   ForeColor = PropBag.ReadProperty("ForeColor", vbWindowText)
   GridLineColor = PropBag.ReadProperty("GridLineColor", vbButtonFace)
   GridFillLineColor = PropBag.ReadProperty("GridFillLineColor", vb3DLight)
   HighlightBackColor = PropBag.ReadProperty("HighlightBackColor", vbHighlight) ' 19/10/1999 (8)
   HighlightForeColor = PropBag.ReadProperty("HighlightForeColor", vbHighlightText)
   ' 2003-11-24: More colours
   NoFocusHighlightForeColor = PropBag.ReadProperty("NoFocusHighlightForeColor", vbWindowText) ' 2003/11/24
   NoFocusHighlightBackColor = PropBag.ReadProperty("NoFocusHighlightBackColor", vbButtonFace) ' 2003/11/24
   ' 2003-11-27: More colours
   GroupRowBackColor = PropBag.ReadProperty("GroupRowBackColor", vbButtonFace) ' 2003/11/27
   GroupRowForeColor = PropBag.ReadProperty("GroupRowForeColor", vbWindowText) ' 2003/11/27
   GroupingAreaBackColor = PropBag.ReadProperty("GroupingAreaBackColor", vbButtonShadow) ' 2003/11/27
   ' 2003-12-07: Alternate Row BackColor
   AlternateRowBackColor = PropBag.ReadProperty("AlternateRowBackColor", -1)
   ' 2003-12-13: Gutter BackColor
   GroupingGutterBackColor = PropBag.ReadProperty("GutterBackColor", -1)
   
   Dim sFnt As New StdFont
   sFnt.Name = "MS Sans Serif"
   sFnt.Size = 8
   Set Font = PropBag.ReadProperty("Font", sFnt)
   Header = PropBag.ReadProperty("Header", True)
   HeaderButtons = PropBag.ReadProperty("HeaderButtons", True)
   ' 19/10/1999 (9): ensure persist all header vals
   HeaderDragReOrderColumns = PropBag.ReadProperty("HeaderDragReorderColumns", True)
   HeaderHotTrack = PropBag.ReadProperty("HeaderHotTrack", True)
   ' 19/10/1999 (10): allow to change the height of the header (may not look ok with icons, watch it)
   HeaderHeight = PropBag.ReadProperty("HeaderHeight", 20)
   ' 19/10/1999 (2): flat headers:
   HeaderFlat = PropBag.ReadProperty("HeaderFlat", False)
   BorderStyle = PropBag.ReadProperty("BorderStyle", ecgBorderStyle3d)
   ScrollBarStyle = PropBag.ReadProperty("ScrollBarStyle", efsRegular)
   Editable = PropBag.ReadProperty("Editable", False)
   SingleClickEdit = PropBag.ReadProperty("SingleClickEdit", False)
   Enabled = PropBag.ReadProperty("Enabled", True)
   DisableIcons = PropBag.ReadProperty("DisableIcons", False)
   HighlightSelectedIcons = PropBag.ReadProperty("HighlightSelectedIcons", True)
   DrawFocusRectangle = PropBag.ReadProperty("DrawFocusRectangle", True)
   AddRowsOnDemand = PropBag.ReadProperty("AddRowsOnDemand", False)
   DefaultRowHeight = PropBag.ReadProperty("DefaultRowHeight", 20)
   
   ' 2003-11-26 Adding auto-grouping
   AllowGrouping = PropBag.ReadProperty("AllowGrouping", False)
   HideGroupingBox = PropBag.ReadProperty("HideGroupingBox", False)
   GroupBoxHintText = PropBag.ReadProperty("GroupBoxHintText", DEFAULT_GROUPBOX_HINT_TEXT)

   ' 2003-12-18 Add split row
   SplitSeparatorSize = PropBag.ReadProperty("SplitSeparatorSize", 4)
   
   StretchLastColumnToFit = PropBag.ReadProperty("StretchLastColumnToFit", False)
   HotTrack = PropBag.ReadProperty("HotTrack", False)
   SelectionAlphaBlend = PropBag.ReadProperty("SelectionAlphaBlend", False)
   SelectionOutline = PropBag.ReadProperty("SelectionOutline", False)

   UserControl_Resize

End Sub

''' <summary>
''' Resize the control.
''' </summary>
Private Sub UserControl_Resize()
Dim lWidth As Long
Dim tR As RECT
On Error GoTo ErrorHandler
   
   GetClientRect UserControl.hwnd, tR
   
   If (tR.Right - tR.Left > m_lMaxMemDCWidth) Then
      m_lMaxMemDCWidth = tR.Right - tR.Left
      BuildMemDC m_lMaxRowHeight
   End If
   
   If m_bRedraw And m_bUserMode Then
      
      m_bDirty = True
      pScrollSetDirty True
      Draw
      pResizeHeader
   
   ElseIf Not (UserControl.Ambient.UserMode) Then
      If (m_bHeader) Then
         lWidth = tR.Right - tR.Left
         m_cHeader.Move 0, 0, lWidth, m_cHeader.Height
      End If
      
   End If
   
   Exit Sub
   
ErrorHandler:
   Debug.Assert False
   Exit Sub
   
   Resume 0
End Sub

''' <summary>
''' Fired when the control is shown for the first time.
''' </summary>
Private Sub UserControl_Show()
Dim lS As Long
Static s_bNotFirst As Boolean
   '
   If Not (s_bNotFirst) Then
      lS = GetWindowLong(UserControl.hwnd, GWL_STYLE)
      SetWindowLong UserControl.hwnd, GWL_STYLE, lS
      SetWindowPos UserControl.hwnd, 0, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOZORDER Or SWP_FRAMECHANGED
      s_bNotFirst = True
   End If
   
End Sub

''' <summary>
''' Terminate the control.
''' </summary>
Private Sub UserControl_Terminate()
Dim iFnt As Long
   
   If Not (m_tmrMarquee Is Nothing) Then
      m_tmrMarquee.Interval = 0
      Set m_tmrMarquee = Nothing
   End If
   If Not (m_tmrHotTrack Is Nothing) Then
      m_tmrHotTrack.Interval = 0
      Set m_tmrHotTrack = Nothing
   End If
   
   pCancelEdit True
   
   If Not (m_hWnd = 0) Then
      DetachMessage Me, m_hWnd, WM_SETTINGCHANGE
      DetachMessage Me, m_hWnd, WM_DISPLAYCHANGE
      m_hWnd = 0
   End If
   
   Set m_cFlatHeader = Nothing
   Set m_cHeader = Nothing
   Set m_cScroll = Nothing
   
   If (m_hDC <> 0) Then
      If (m_hBmpOld <> 0) Then
         SelectObject m_hDC, m_hBmpOld
      End If
      If (m_hBmp <> 0) Then
         DeleteObject m_hBmp
      End If
      If (m_hFntOldDC <> 0) Then
         SelectObject m_hDC, m_hFntOldDC
      End If
      DeleteDC m_hDC
      m_hDC = 0
   End If
   
   If (m_hFntDC <> 0) Then
      DeleteObject m_hFntDC
      m_hFntDC = 0
   End If
   
   For iFnt = 1 To m_iFontCount
      DeleteObject m_hFnt(iFnt)
   Next iFnt
      
   If Not (m_hMod = 0) Then
      FreeLibrary m_hMod
      m_hMod = 0
   End If
      
   debugmsg "vbalGrid:Terminate"
   
End Sub

''' <summary>
''' Persist properties to the container's storage.
''' </summary>
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
   
   PropBag.WriteProperty "MultiSelect", MultiSelect, False
   PropBag.WriteProperty "RowMode", RowMode, False
   PropBag.WriteProperty "GridLines", GridLines, False
   ' 2003-11-26: More grid line properties
   PropBag.WriteProperty "NoHorizontalGridLines", NoHorizontalGridLines, False
   PropBag.WriteProperty "NoVerticalGridLines", NoVerticalGridLines, False
   PropBag.WriteProperty "GridLineMode", m_eGridLineMode, ecgGridStandard
   
   PropBag.WriteProperty "BackgroundPicture", BackgroundPicture, Nothing
   PropBag.WriteProperty "BackgroundPictureHeight", BackgroundPictureHeight
   PropBag.WriteProperty "BackgroundPictureWidth", BackgroundPictureWidth
   PropBag.WriteProperty "BackColor", BackColor, vbWindowBackground
   PropBag.WriteProperty "ForeColor", ForeColor, vbWindowText
   PropBag.WriteProperty "GridLineColor", GridLineColor, vbButtonFace
   PropBag.WriteProperty "GridFillLineColor", GridFillLineColor, vb3DLight
   PropBag.WriteProperty "HighlightBackColor", HighlightBackColor, vbHighlight ' 19/10/1999 (8)
   PropBag.WriteProperty "HighlightForeColor", HighlightForeColor, vbHighlightText
   PropBag.WriteProperty "NoFocusHighlightForeColor", NoFocusHighlightForeColor, vbWindowText  ' 2003/11/24
   PropBag.WriteProperty "NoFocusHighlightBackColor", NoFocusHighlightBackColor, vbButtonFace  ' 2003/11/24
   PropBag.WriteProperty "GroupRowBackColor", GroupRowBackColor, vbButtonFace  ' 2003/11/27
   PropBag.WriteProperty "GroupRowForeColor", GroupRowForeColor, vbWindowText  ' 2003/11/27
   PropBag.WriteProperty "GroupingAreaBackColor", GroupingAreaBackColor, vbButtonShadow ' 2003/11/27
   ' 2003-12-07: Alternate Row BackColor
   PropBag.WriteProperty "AlternateRowBackColor", AlternateRowBackColor, -1
   ' 2003-12-13: Gutter BackColor
   PropBag.WriteProperty "GutterBackColor", GroupingGutterBackColor, -1

   Dim sFnt As New StdFont
   sFnt.Name = "MS Sans Serif"
   sFnt.Size = 8
   PropBag.WriteProperty "Font", Font, sFnt
   PropBag.WriteProperty "Header", Header, True
   PropBag.WriteProperty "HeaderButtons", HeaderButtons, True
   ' 19/10/1999 (9): ensure persist all header vals
   PropBag.WriteProperty "HeaderDragReorderColumns", HeaderDragReOrderColumns, True
   PropBag.WriteProperty "HeaderHotTrack", HeaderHotTrack, True
   ' 19/10/1999 (10): header height:
   PropBag.WriteProperty "HeaderHeight", HeaderHeight, 20
   ' 19/10/1999 (2): flat headers:
   PropBag.WriteProperty "HeaderFlat", HeaderFlat, False
   PropBag.WriteProperty "BorderStyle", BorderStyle, ecgBorderStyle3d
   PropBag.WriteProperty "ScrollBarStyle", ScrollBarStyle, efsRegular
   PropBag.WriteProperty "Editable", Editable, False
   PropBag.WriteProperty "SingleClickEdit", SingleClickEdit, False
   PropBag.WriteProperty "Enabled", Enabled, True
   PropBag.WriteProperty "DisableIcons", DisableIcons, False
   PropBag.WriteProperty "HighlightSelectedIcons", HighlightSelectedIcons, True
   PropBag.WriteProperty "DrawFocusRectangle", DrawFocusRectangle, True
   PropBag.WriteProperty "AddRowsOnDemand", AddRowsOnDemand, False
   PropBag.WriteProperty "DefaultRowHeight", DefaultRowHeight, 20
   
   ' 2003-11-26 Adding auto-grouping
   PropBag.WriteProperty "AllowGrouping", AllowGrouping, False
   PropBag.WriteProperty "HideGroupingBox", HideGroupingBox, False
   PropBag.WriteProperty "GroupBoxHintText", GroupBoxHintText, DEFAULT_GROUPBOX_HINT_TEXT
   
   ' 2003-12-18 Add split row
   PropBag.WriteProperty "SplitSeparatorSize", SplitSeparatorSize, 4
   'PropBag.WriteProperty "IncludeSplitRowInSort", IncludeSplitRowInSort, False
   
   PropBag.WriteProperty "StretchLastColumnToFit", StretchLastColumnToFit, False
   
   PropBag.WriteProperty "HotTrack", HotTrack, False
   PropBag.WriteProperty "SelectionAlphaBlend", SelectionAlphaBlend, False
   PropBag.WriteProperty "SelectionOutline", SelectionOutline, False
   
End Sub



'
' Dev Info; contains inaccuracies
'
' Tested Systems
' Win98, PII 266 96Mb, IE6, TrueColor and 256 Color, 800 x 640 "Elonex Pirahna"
' Win2000 SP3, PIV 900 256Mb, IE6, TrueColor 1024 x 768 "IBM ThinkPad"
' WinXP SP1, Athlon 2.2 512Mb, IE6, TrueColor Multi-monitor 2560 x 1024, XP Styles and Classic "Mesh Matrix"
'
' Tested Hosts
' VB5 Sp3
' VB6 Sp4
' Word Office XP
'
' Coding Days
' 45
' Bugs/Issues Resolved
' 93
' "Go straight to jail; do not pass go" days
' 5
' Budvars (500cl)
' 85.3
' Makers Mark (750cl)
' 2
' Cigarettes
' 363
' Health Problems
' 3
'
' One evening's playlist
' The Stranglers - Let Me Introduce You To The Family
' Arthur Argent - Hold Your Head Up (SoulWax Mix)
' Seelenluft - Manila (Headman Mix)
' M83 - Gone
' Plaid - Zeal
' Autechre - 6ie.cr
' Broadcast - Hawk
' The Postal Service - Nothing Better
' Barry Adamson - Something Wicked This Way Comes
' Bush Tetras - Too Many Creeps
' Hieroglyphics - Love Flowin'
' Kraftwerk - Tour De France Etape 1 - 3
' LFO - Mum - man
' Soul Of Man - The Drum
' Scritti Politti - Skank Block Bologna
' Herbie Hancock - Watermelon Man
' Broadcast - Man Is Not A Bird
' Raul de Souza - Sweet Lucy
' The Junkyard Band - The Word
'
' Watched
' Lost In Translation
' Kill Bill
' Fight Club
' Eraserhead/Lost Highway/Mulholland Drive
' Buffy
'
' Read
' The Man Who Walked
' Carter Beats The Devil
' The Corrections
' Hangover Square
' Life - A User's Manual
' Don't Read This Book If You're Stupid
' Formulas (sic) for Flavour - Cooking Restaurant Dishes at Home
' Wired
' Guardian
'
' Dry Cleaner Visits
' 3
' Coloured Washes
' 6
' White Washes
' 1
' Hangovers
' 16
' Late in to Work
' 45
' Haircuts
' 0
'
' Top Eight:
' My Bloody Valentine - Isn't Anything
'  Sublime, my hairs stand on end.
' 2 Many DJs - As Heard on Radio Soulwax Pt II **
'  Quite simply the greatest (only good?) mix album anyone managed to get clearance to release.
' Jesus And Mary Chain - Psycho Candy
'  Wall of feedback; why are there no more like this.
' The Smiths - Hatful of Hollow
'  Heaven knows I'm not miserable now. The wittiest lyricist vs some perfect music.
' M83 - Dead Cities, Red Seas & Lost Ghosts *
'  Soaring, digital and near perfect electronica.  Next: some vocals?
' Public Enemy - It Takes A Nation Of Millions To Hold Us Back
'  Funny, sharp, corrosive and hardcore; sampled hip-hop at its innovative peak.
' Massive Attack - Blue Lines
'  A blueprint for all other chilled- soul music.
' Kid Koala - Carpal Tunnel Syndrone
'  How to genuinely play the turntable. Made amazing by its huge imagination and humour.
'
'
' * - new entry
' ** - new-ish entry
' no stars - old entry
