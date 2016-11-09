Attribute VB_Name = "mSGrid"
Option Explicit

' ======================================================================================
' Name:     mSGrid
' Author:   Steve McMahon (steve@vbaccelerator.com)
' Date:     22 December 1998
'
' Copyright © 1998-2003 Steve McMahon for vbAccelerator
' --------------------------------------------------------------------------------------
' Visit vbAccelerator - advanced free source code for VB programmers
' http://vbaccelerator.com
' --------------------------------------------------------------------------------------
'
' Various GDI declares and helper functions for the vbAcceleratorGrid
' control.
'
' FREE SOURCE CODE - ENJOY!
' ======================================================================================
#Const DEBUGMODE = 0

' ------------------ START GLOBAL API DECLARES ------------------------------
Public Type RECT
   left As Long
   top As Long
   right As Long
   bottom As Long
End Type

Public Type POINTAPI
   x As Long
   y As Long
End Type

Public Declare Function timeGetTime Lib "winmm.dll" () As Long

Private Const LF_FACESIZE = 32
Public Type LOGFONT
   lfHeight As Long ' The font size (see below)
   lfWidth As Long ' Normally you don't set this, just let Windows create the Default
   lfEscapement As Long ' The angle, in 0.1 degrees, of the font
   lfOrientation As Long ' Leave as default
   lfWeight As Long ' Bold, Extra Bold, Normal etc
   lfItalic As Byte ' As it says
   lfUnderline As Byte ' As it says
   lfStrikeOut As Byte ' As it says
   lfCharSet As Byte ' As it says
   lfOutPrecision As Byte ' Leave for default
   lfClipPrecision As Byte ' Leave for default
   lfQuality As Byte ' Leave for default
   lfPitchAndFamily As Byte ' Leave for default
   lfFaceName(LF_FACESIZE) As Byte ' The font name converted to a byte array
End Type
' ------------------ END GLOBAL API DECLARES ------------------------------

''' <summary>
''' Defines the data held associated which each grid cell
''' </summary>
Public Type tGridCell
   ''' <summary>
   ''' Background colour or -1 for default
   ''' </summary>
   oBackColor As Long
   ''' <summary>
   ''' Foreground colour or -1 for default
   ''' </summary>
   oForeColor As Long
   ''' <summary>
   ''' Index of font to use when rendering the cell
   ''' in the grid's font array.
   ''' </summary>
   iFntIndex As Long
   ''' <summary>
   ''' Variant containing an object to use as text.
   ''' The column's sFmtString is used to format this
   ''' into the text to display if provided.
   ''' </summary>
   sText As Variant
   ''' <summary>
   ''' Flags controlling how the text is drawn using
   ''' the API DrawText call.
   ''' </summary>
   eTextFlags As Long 'ECGTextAlignFlags
   ''' <summary>
   ''' 0-based index of the icon to draw in the cell
   ''' or -1 for no icon.
   ''' </summary>
   iIconIndex As Long
   ''' <summary>
   ''' Whether this cell is selected or not.
   ''' </summary>
   bSelected As Boolean
   ''' <summary>
   ''' Whether this cell is dirty (needs redrawing)
   ''' or not.
   ''' </summary>
   bDirtyFlag As Boolean
   ''' <summary>
   ''' Indentation from left of cell before cell
   ''' is drawn.
   ''' </summary>
   lIndent As Long
   ''' <summary>
   ''' 0-based index of an additional icon to draw in
   ''' the cell, or -1 for no additional icon.
   ''' </summary>
   lExtraIconIndex As Long
   ''' <summary>
   ''' Long variable storing some additional data
   ''' for the cell.
   ''' </summary>
   lItemData As Long
End Type


''' <summary>
''' Defines each row in the grid.
''' </summary>
Public Type tRowPosition
   ''' <summary>
   ''' The index of this row's cells within the grid array
   ''' 2003-11-26 - allows row indirection so insert and
   ''' delete are much faster
   ''' </summary>
   lGridCellArrayRow As Long
   ''' <summary>
   ''' Height of the row.
   ''' </summary>
   lHeight As Long
   ''' <summary>
   ''' Vertical start position in the grid.
   ''' </summary>
   lStartY As Long
   ''' <summary>
   ''' Whether the row is visible or not.
   ''' </summary>
   bVisible As Boolean
   ''' <summary>
   ''' Whether this row is a grouping row when
   ''' the grid is hierarchically grouped
   ''' </summary>
   bGroupRow As Boolean
   ''' <summary>
   ''' The column at which the group row text column starts
   ''' rendering in the grid.
   ''' </summary>
   lGroupStartColIndex As Long
   
   ' 2003-11-26 more
   ''' <summary>
   ''' If this row has been collapsed in a hierarchically
   ''' grouped grid.
   ''' </summary>
   bCollapsed As Boolean
   ''' <summary>
   ''' The ident level of the group row in the grid.
   ''' </summary>
   lGroupIndentLevel As Long
   
   ''' <summary>
   ''' The ItemData of the row.  Used for owner-draw
   ''' grids.
   ''' </summary>
   lItemData As Long
End Type

' Private declares used locally

' SPM 2003-11-10: Added for hook based cancellation
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Private Declare Function CreateDCAsNull Lib "gdi32" Alias "CreateDCA" ( _
   ByVal lpDriverName As String, lpDeviceName As Any, lpOutput As Any, lpInitData As Any) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function SetROP2 Lib "gdi32" (ByVal hdc As Long, ByVal nDrawMode As Long) As Long
     Private Const R2_BLACK = 1 ' 0
     Private Const R2_COPYPEN = 13 ' P
     Private Const R2_LAST = 16
     Private Const R2_MASKNOTPEN = 3 ' DPna
     Private Const R2_MASKPEN = 9 ' DPa
     Private Const R2_MASKPENNOT = 5 ' PDna
     Private Const R2_MERGENOTPEN = 12    ' DPno
     Private Const R2_MERGEPEN = 15 ' DPo
     Private Const R2_MERGEPENNOT = 14    ' PDno
     Private Const R2_NOP = 11    ' D
     Private Const R2_NOT = 6 ' Dn
     Private Const R2_NOTCOPYPEN = 4 ' PN
     Private Const R2_NOTMASKPEN = 8 ' DPan
     Private Const R2_NOTMERGEPEN = 2 ' DPon
     Private Const R2_NOTXORPEN = 10 ' DPxn
     Private Const R2_WHITE = 16 ' 1
     Private Const R2_XORPEN = 7 ' DPx
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
Private Const LOGPIXELSX = 88    '  Logical pixels/inch in X
Private Const LOGPIXELSY = 90    '  Logical pixels/inch in Y
Private Declare Function MulDiv Lib "kernel32" (ByVal nNumber As Long, ByVal nNumerator As Long, ByVal nDenominator As Long) As Long
Private Declare Function CreateFontIndirect Lib "gdi32" Alias "CreateFontIndirectA" (lpLogFont As LOGFONT) As Long
Private Const FW_NORMAL = 400
Private Const FW_BOLD = 700
Private Const FF_DONTCARE = 0
Private Const DEFAULT_QUALITY = 0 ' Appearance of the font is set to default
Private Const DRAFT_QUALITY = 1 ' Appearance is less important that PROOF_QUALITY.
Private Const PROOF_QUALITY = 2 ' Best character quality
Private Const NONANTIALIASED_QUALITY = 3 ' Don't smooth font edges even if system is set to smooth font edges
Private Const ANTIALIASED_QUALITY = 4 ' Ensure font edges are smoothed if system is set to smooth font edges
Private Const CLEARTYPE_QUALITY = 5
Private Const DEFAULT_PITCH = 0
Private Const DEFAULT_CHARSET = 1
Private Declare Function OleTranslateColor Lib "OLEPRO32.DLL" (ByVal OLE_COLOR As Long, ByVal HPALETTE As Long, pccolorref As Long) As Long
Private Const CLR_INVALID = -1
' Corrected Draw State function declarations:
Private Declare Function DrawState Lib "user32" Alias "DrawStateA" _
   (ByVal hdc As Long, _
   ByVal hBrush As Long, _
   ByVal lpDrawStateProc As Long, _
   ByVal lParam As Long, _
   ByVal wParam As Long, _
   ByVal x As Long, _
   ByVal y As Long, _
   ByVal cx As Long, _
   ByVal cy As Long, _
   ByVal fuFlags As Long) As Long
Private Declare Function DrawStateString Lib "user32" Alias "DrawStateA" _
   (ByVal hdc As Long, _
   ByVal hBrush As Long, _
   ByVal lpDrawStateProc As Long, _
   ByVal lpString As String, _
   ByVal cbStringLen As Long, _
   ByVal x As Long, _
   ByVal y As Long, _
   ByVal cx As Long, _
   ByVal cy As Long, _
   ByVal fuFlags As Long) As Long

' Missing Draw State constants declarations:
'/* Image type */
Private Const DST_COMPLEX = &H0
Private Const DST_TEXT = &H1
Private Const DST_PREFIXTEXT = &H2
Private Const DST_ICON = &H3
Private Const DST_BITMAP = &H4

' /* State type */
Private Const DSS_NORMAL = &H0
Private Const DSS_UNION = &H10
Private Const DSS_DISABLED = &H20
Private Const DSS_MONO = &H80
Private Const DSS_RIGHT = &H8000

Private Declare Function GetSysColorBrush Lib "user32" (ByVal nIndex As Long) As Long
Private Declare Function FillRect Lib "user32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long
Private Declare Function CreatePen Lib "gdi32" (ByVal nPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long) As Long
Private Declare Function GetSysColor Lib "user32" (ByVal nIndex As Long) As Long
Private Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, lpPoint As POINTAPI) As Long
Private Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long) As Long
Private Const PS_SOLID = 0

' Create an Image List
Private Declare Function ImageList_Create Lib "comctl32.dll" ( _
        ByVal cx As Long, _
        ByVal cy As Long, _
        ByVal fMask As Long, _
        ByVal cInitial As Long, _
        ByVal cGrow As Long _
    ) As Long
Private Const ILC_MASK = 1&
Private Const ILC_COLOR = 0&
Private Const ILC_COLORDDB = &HFE&
Private Const ILC_COLOR4 = &H4&
Private Const ILC_COLOR8 = &H8&
Private Const ILC_COLOR16 = &H10&
Private Const ILC_COLOR24 = &H18&
Private Const ILC_COLOR32 = &H20&
Private Const ILC_PALETTE = &H800&

Private Declare Function ImageList_Destroy Lib "comctl32.dll" ( _
        ByVal hIml As Long _
    ) As Long

' Add a masked bitmap to an image lisf
Private Declare Function ImageList_AddMasked Lib "comctl32.dll" ( _
        ByVal hIml As Long, _
        ByVal hBmp As Long, _
        ByVal crMask As Long _
    ) As Long
' Create a new icon based on an image list icon:
Private Declare Function ImageList_GetIcon Lib "comctl32.dll" ( _
        ByVal hIml As Long, _
        ByVal i As Long, _
        ByVal diIgnore As Long _
    ) As Long
' Draw an item in an ImageList:
Private Declare Function ImageList_Draw Lib "comctl32.dll" ( _
        ByVal hIml As Long, _
        ByVal i As Long, _
        ByVal hdcDst As Long, _
        ByVal x As Long, _
        ByVal y As Long, _
        ByVal fStyle As Long _
    ) As Long
' Draw an item in an ImageList with more control over positioning
' and colour:
Private Declare Function ImageList_DrawEx Lib "comctl32.dll" ( _
      ByVal hIml As Long, _
      ByVal i As Long, _
      ByVal hdcDst As Long, _
      ByVal x As Long, _
      ByVal y As Long, _
      ByVal dx As Long, _
      ByVal dy As Long, _
      ByVal rgbBk As Long, _
      ByVal rgbFg As Long, _
      ByVal fStyle As Long _
   ) As Long
' Built in ImageList drawing methods:
Private Const ILD_NORMAL = 0
Private Const ILD_TRANSPARENT = 1
Private Const ILD_BLEND25 = 2
Private Const ILD_SELECTED = 4
Private Const ILD_FOCUS = 4
Private Const ILD_OVERLAYMASK = 3840
Private Declare Function DestroyIcon Lib "user32" (ByVal hIcon As Long) As Long

' Standard GDI draw icon function:
Private Declare Function DrawIconEx Lib "user32" (ByVal hdc As Long, ByVal xLeft As Long, ByVal yTop As Long, ByVal hIcon As Long, ByVal cxWidth As Long, ByVal cyWidth As Long, ByVal istepIfAniCur As Long, ByVal hbrFlickerFreeDraw As Long, ByVal diFlags As Long) As Long
Private Const DI_MASK = &H1
Private Const DI_IMAGE = &H2
Private Const DI_NORMAL = &H3
Private Const DI_COMPAT = &H4
Private Const DI_DEFAULTSIZE = &H8

Private Declare Function LoadImageByNum Lib "user32" Alias "LoadImageA" (ByVal hInst As Long, ByVal lpsz As Long, ByVal un1 As Long, ByVal n1 As Long, ByVal n2 As Long, ByVal un2 As Long) As Long
    Public Const LR_LOADMAP3DCOLORS = &H1000
    Public Const LR_LOADFROMFILE = &H10
    Public Const LR_LOADTRANSPARENT = &H20
    Public Const IMAGE_BITMAP = 0

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
    lpvDest As Any, lpvSource As Any, ByVal cbCopy As Long)
    
' XP detection
Private Declare Function GetVersion Lib "kernel32" () As Long
Private Declare Function OpenThemeData Lib "uxtheme.dll" _
   (ByVal hwnd As Long, ByVal pszClassList As Long) As Long
Private Declare Function CloseThemeData Lib "uxtheme.dll" _
   (ByVal hTheme As Long) As Long
Private Declare Function DrawThemeBackground Lib "uxtheme.dll" _
   (ByVal hTheme As Long, ByVal lhDC As Long, _
    ByVal iPartId As Long, ByVal iStateId As Long, _
    pRect As RECT, pClipRect As RECT) As Long
    
    
' SGrid Constants
Public Const DEFAULT_GROUPBOX_HINT_TEXT As String = "Drag a Column Header Here to Group by that Column"

Public Const GROUP_COLUMN_MAGIC_KEY As String = "#6BA873:VBAL:SGRID:GROUPCOLUMN"

Public Const MAGIC_END_EDIT_IGNORE_WINDOW_PROP As String = "VBAL:SGRID:EDITOR"

' Use default rgb colour:
Public Const CLR_NONE = -1

    
' Private variables
Private m_bIsXp As Boolean
Private m_bIsNt As Boolean
Private m_bInit As Boolean

''' <summary>
''' Returns the class name for the Window with the
''' specified handle.
''' </summary>
''' <param name="hWnd">Window handle</param>
''' <returns>Class name</returns>
Public Function WindowClassName(ByVal hwnd As Long) As String
Dim szBuf As String
Dim lR As Long
   szBuf = String$(260, 0)
   lR = GetClassName(hwnd, szBuf, 260)
   lR = InStr(szBuf, vbNullChar)
   If (lR > 0) Then
      WindowClassName = left$(szBuf, lR - 1)
   Else
      WindowClassName = szBuf
   End If
End Function

''' <summary>
''' Draws the dragging image shown when a column
''' is resized using XOR techniques.
''' </summary>
''' <param name="rcNew">Rectangle to show the drag
''' image in</param>
''' <param name="bFirst">Whether this is the first time
''' that the image has been drawn.</param>
''' <param name="bLast">Whether this is the last time
''' that the image will be drawn.</param>
Public Sub DrawDragImage( _
      ByRef rcNew As RECT, _
      ByVal bFirst As Boolean, _
      ByVal bLast As Boolean _
   )
Static rcCurrent As RECT
Dim hdc As Long
   
   ' First get the Desktop DC:
   hdc = CreateDCAsNull("DISPLAY", ByVal 0&, ByVal 0&, ByVal 0&)
   ' Set the draw mode to XOR:
   SetROP2 hdc, R2_NOTXORPEN
   
   '// Draw over and erase the old rectangle
   If Not (bFirst) Then
      Rectangle hdc, rcCurrent.left, rcCurrent.top, rcCurrent.right, rcCurrent.bottom
   End If
   
   If Not (bLast) Then
      '// Draw the new rectangle
      Rectangle hdc, rcNew.left, rcNew.top, rcNew.right, rcNew.bottom
   End If
   
   ' Store this position so we can erase it next time:
   LSet rcCurrent = rcNew
   
   ' Free the reference to the Desktop DC we got (make sure you do this!)
   DeleteDC hdc
    
End Sub

''' <summary>
''' Draws an image from an image list using the
''' specified options.
''' </summary>
''' <param name="hIml">Handle to a ComCtl32.DLL ImageList</param>
''' <param name="ptrVB6ImageList">Pointer to a VB6 Image List.
''' The VB6 ImageList is incompatible with ComCtl32.DLL and hence
''' different techniques are needed to draw icons from it.</param>
''' <param name="iIndex">0-based index of image to draw</param>
''' <param name="hDC">Handle to device context to draw onto</param>
''' <param name="xPixels">X position to draw at.</param>
''' <param name="yPixels">Y Position to draw at.</param>
''' <param name="lIconSizeX">Horizontal size of icon.</param>
''' <param name="lIconSizeY">Vertical size of icon.</param>
''' <param name="bSelected">Set to <c>True</c> to draw a selected
''' icon</param>
''' <param name="bCut">Set to <c>True</c> to draw icon using a
''' cut effect.</param>
''' <param name="bDisabled">Set to <c>True</c> to draw the icon
''' disabled.</param>
''' <param name="oCutDitherColour">The colour to use to dither
''' the icon when using the cut effect.</param>
''' <param name="hExternalIml">Not needed.  Used instead of hIml
''' if provided.</param>
Public Sub DrawImage( _
      ByVal hIml As Long, _
      ByVal ptrVB6ImageList As Long, _
      ByVal iIndex As Long, _
      ByVal hdc As Long, _
      ByVal xPixels As Integer, _
      ByVal yPixels As Integer, _
      ByVal lIconSizeX As Long, ByVal lIconSizeY As Long, _
      Optional ByVal bSelected = False, _
      Optional ByVal bCut = False, _
      Optional ByVal bDisabled = False, _
      Optional ByVal oCutDitherColour As OLE_COLOR = vbWindowBackground, _
      Optional ByVal hExternalIml As Long = 0 _
    )
Dim hIcon As Long
Dim lFlags As Long
Dim lhIml As Long
Dim lColor As Long
Dim iImgIndex As Long
Dim o As Object

   ' Draw the image at 1 based index or key supplied in vKey.
   ' on the hDC at xPixels,yPixels with the supplied options.
   ' You can even draw an ImageList from another ImageList control
   ' if you supply the handle to hExternalIml with this function.
   
   iImgIndex = iIndex
   If (iImgIndex > -1) Then
      If (hExternalIml <> 0) Then
          lhIml = hExternalIml
      Else
          lhIml = hIml
      End If
      
      lFlags = ILD_TRANSPARENT
      If (bSelected) Or (bCut) Then
          lFlags = lFlags Or ILD_SELECTED
      End If
      
      If (bCut) Then
         
         If Not (ptrVB6ImageList = 0) Then
            
            On Error Resume Next
            Set o = ObjectFromPtr(ptrVB6ImageList)
            If Not (o Is Nothing) Then
               o.ListImages(iImgIndex + 1).Draw hdc, xPixels * Screen.TwipsPerPixelX, yPixels * Screen.TwipsPerPixelY, ILD_SELECTED
            End If
            On Error GoTo 0
         Else
        
            ' Draw dithered:
            lColor = TranslateColor(oCutDitherColour)
            If (lColor = -1) Then lColor = TranslateColor(vbWindowBackground)
            ImageList_DrawEx _
                  lhIml, _
                  iImgIndex, _
                  hdc, _
                  xPixels, yPixels, 0, 0, _
                  CLR_NONE, lColor, _
                  lFlags
         End If
         
      ElseIf (bDisabled) Then
         
         If Not (ptrVB6ImageList = 0) Then
         
            On Error Resume Next
            Set o = ObjectFromPtr(ptrVB6ImageList)
            If Not (o Is Nothing) Then
               
               Dim lhDCDisp As Long
               Dim lhDC As Long
               Dim lhBmp As Long
               Dim lhBmpOld As Long
               Dim lDishIml As Long
                        
               lhDCDisp = CreateDCAsNull("DISPLAY", ByVal 0&, ByVal 0&, ByVal 0&)
               lhDC = CreateCompatibleDC(lhDCDisp)
               lhBmp = CreateCompatibleBitmap(lhDCDisp, o.ImageWidth, o.ImageHeight)
               DeleteDC lhDCDisp
               lhBmpOld = SelectObject(lhDC, lhBmp)
               o.ListImages.Item(iImgIndex + 1).Draw lhDC, 0, 0, 0
               SelectObject lhDC, lhBmpOld
               DeleteDC lhDC
               lDishIml = ImageList_Create(o.ImageWidth, o.ImageHeight, ILC_MASK Or ILC_COLOR32, 1, 1)
               ImageList_AddMasked lDishIml, lhBmp, TranslateColor(o.BackColor)
               DeleteObject lhBmp
               hIcon = ImageList_GetIcon(lDishIml, 0, 0)
               ImageList_Destroy lhIml
               
            End If
            On Error GoTo 0
         
         Else
            ' extract a copy of the icon:
            hIcon = ImageList_GetIcon(hIml, iImgIndex, 0)
         End If
            
         ' Draw it disabled at x,y:
         If Not (hIcon = 0) And Not (hIcon = -1) Then
            DrawState hdc, 0, 0, hIcon, 0, xPixels, yPixels, lIconSizeX, lIconSizeY, DST_ICON Or DSS_DISABLED
            ' Clear up the icon:
            DestroyIcon hIcon
         End If
              
      Else
         If Not (ptrVB6ImageList = 0) Then
            
            On Error Resume Next
            Set o = ObjectFromPtr(ptrVB6ImageList)
            If Not (o Is Nothing) Then
               o.ListImages(iImgIndex + 1).Draw hdc, xPixels * Screen.TwipsPerPixelX, yPixels * Screen.TwipsPerPixelY, 0
            End If
            On Error GoTo 0
         
         Else
            ' Standard draw:
            ImageList_Draw _
               lhIml, _
               iImgIndex, _
               hdc, _
               xPixels, _
               yPixels, _
               lFlags
         End If
      End If
   End If
End Sub

''' <summary>
''' Draws an open-close glyph for a hierachical grouping row
''' in the grid.  If running on XP with a theme in effect,
''' the TreeView's open/close glyph is drawn.
''' Otherwise a button with a + or - is drawn.
''' </summary>
''' <param name="hWnd">Window handle to use to detect theme.</param>
''' <param name="lHDC">Handle to device context to draw onto.</param>
''' <param name="tTR">Bounding rectangle to draw glyph into.</param>
''' <param name="bCollapsed"><c>True</c> to draw collapsed glyph,
''' <c>False</c> to draw expanded glyph.</param>
Public Sub DrawOpenCloseGlyph( _
      ByVal hwnd As Long, _
      ByVal lhDC As Long, _
      tTR As RECT, _
      ByVal bCollapsed As Boolean _
   )
Dim tGR As RECT
Dim bDone As Boolean
   
   LSet tGR = tTR
   tGR.left = tGR.left + 2
   tGR.right = tGR.left + 12
   tGR.top = tGR.top + (tGR.bottom - tGR.top - 12) \ 2
   tGR.bottom = tGR.top + 12

   If (isXp) Then
      Dim hTheme As Long
      hTheme = OpenThemeData(hwnd, StrPtr("TREEVIEW"))
      If Not (hTheme = 0) Then
         DrawThemeBackground hTheme, lhDC, 2, IIf(bCollapsed, 1, 2), tGR, tGR
         CloseThemeData hTheme
         bDone = True
      End If
   End If
   
   If Not (bDone) Then
         
      ' Draw button border
      Dim hBr As Long
      hBr = GetSysColorBrush(vbButtonFace And &H1F&)
      FillRect lhDC, tGR, hBr
      DeleteObject hBr
      
      Dim hPen As Long
      Dim hPenOld As Long
      Dim tJ As POINTAPI
      
            
      hPen = CreatePen(PS_SOLID, 1, GetSysColor(vbButtonShadow And &H1F&))
      hPenOld = SelectObject(lhDC, hPen)
      MoveToEx lhDC, tGR.left + 1, tGR.bottom - 2, tJ
      LineTo lhDC, tGR.right - 2, tGR.bottom - 2
      LineTo lhDC, tGR.right - 2, tGR.top
      SelectObject lhDC, hPenOld
      DeleteObject hPen
      
      hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DHighlight And &H1F&))
      hPenOld = SelectObject(lhDC, hPen)
      MoveToEx lhDC, tGR.right - 2, tGR.top, tJ
      LineTo lhDC, tGR.left, tGR.top
      LineTo lhDC, tGR.left, tGR.bottom - 1
      SelectObject lhDC, hPenOld
      DeleteObject hPen
                        
      hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DDKShadow And &H1F&))
      hPenOld = SelectObject(lhDC, hPen)
      MoveToEx lhDC, tGR.left, tGR.bottom - 1, tJ
      LineTo lhDC, tGR.right - 1, tGR.bottom - 1
      LineTo lhDC, tGR.right - 1, tGR.top
   
      ' Draw collapse/expand glyph
      MoveToEx lhDC, tGR.left + 3, tGR.top + 5, tJ
      LineTo lhDC, tGR.left + 8, tGR.top + 5
      If (bCollapsed) Then
         MoveToEx lhDC, tGR.left + 5, tGR.top + 3, tJ
         LineTo lhDC, tGR.left + 5, tGR.top + 8
      End If
      SelectObject lhDC, hPenOld
      DeleteObject hPen
      
   End If
End Sub

''' <summary>
''' Draws part of the header when the header's origin has been
''' scrolled to the left, using the current XP theme if any.
''' </summary>
''' <param name="hWnd">Window handle to use to detect theme.</param>
''' <param name="lHDC">Handle to device context to draw onto.</param>
''' <param name="tTR">Bounding rectangle to draw glyph into.</param>
''' <param name="bThinHeader"><c>True</c> if the header is being
''' overdrawn in thin mode.</param>
Public Sub DrawPreHeaderPart( _
      ByVal hwnd As Long, _
      ByVal lhDC As Long, _
      tTR As RECT, _
      ByVal bThinHeader As Boolean _
   )
Dim bDone As Boolean

   If (isXp) Then
      Dim hTheme As Long
      hTheme = OpenThemeData(hwnd, StrPtr("HEADER"))
      If Not (hTheme = 0) Then
         DrawThemeBackground hTheme, lhDC, 1, 1, tTR, tTR
         CloseThemeData hTheme
         bDone = True
      End If
   End If
   
   If Not (bDone) Then
         
      Dim hBr As Long
      hBr = GetSysColorBrush(vbButtonFace And &H1F&)
      FillRect lhDC, tTR, hBr
      DeleteObject hBr
      
      Dim hPen As Long
      Dim hPenOld As Long
      Dim tJ As POINTAPI
      
            
      hPen = CreatePen(PS_SOLID, 1, GetSysColor(vbButtonShadow And &H1F&))
      hPenOld = SelectObject(lhDC, hPen)
      If (bThinHeader) Then
         MoveToEx lhDC, tTR.left, tTR.bottom - 1, tJ
         LineTo lhDC, tTR.right - 1, tTR.bottom - 1
         LineTo lhDC, tTR.right - 1, tTR.top
      Else
         MoveToEx lhDC, tTR.left + 1, tTR.bottom - 2, tJ
         LineTo lhDC, tTR.right - 2, tTR.bottom - 2
         LineTo lhDC, tTR.right - 2, tTR.top
      End If
      SelectObject lhDC, hPenOld
      DeleteObject hPen
      
      hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DHighlight And &H1F&))
      hPenOld = SelectObject(lhDC, hPen)
      MoveToEx lhDC, tTR.right - 2, tTR.top, tJ
      LineTo lhDC, tTR.left, tTR.top
      LineTo lhDC, tTR.left, tTR.bottom - 1
      SelectObject lhDC, hPenOld
      DeleteObject hPen
                        
      If Not (bThinHeader) Then
         hPen = CreatePen(PS_SOLID, 1, GetSysColor(vb3DDKShadow And &H1F&))
         hPenOld = SelectObject(lhDC, hPen)
         MoveToEx lhDC, tTR.left, tTR.bottom - 1, tJ
         LineTo lhDC, tTR.right - 1, tTR.bottom - 1
         LineTo lhDC, tTR.right - 1, tTR.top
         SelectObject lhDC, hPenOld
         DeleteObject hPen
      End If
      
   End If
   
End Sub

''' <summary>
''' Translates an <c>OLE_COLOR</c> into an RGB long value.
''' </summary>
''' <param name="oClr">Colour to translate.</param>
''' <param name="hPal">Handle to colour palette to use when translating.</param>
''' <returns>RGB equivalent, or -1 if none</returns>
Public Function TranslateColor(ByVal oClr As OLE_COLOR, _
                        Optional hPal As Long = 0) As Long
    ' Convert Automation color to Windows color
    If OleTranslateColor(oClr, hPal, TranslateColor) Then
        TranslateColor = CLR_INVALID
    End If
End Function

''' <summary>
''' Blends two colours together using the specified alpha amount.
''' </summary>
''' <param name="oColorFrom">Base Colour.</param>
''' <param name="oColorTo">Colour to blend.</param>
''' <param name="alpha">Amount of alpha (0-255) to use in the blend.</param>
''' <returns>Blended colour as RGB</returns>
Public Property Get BlendColor( _
      ByVal oColorFrom As OLE_COLOR, _
      ByVal oColorTo As OLE_COLOR, _
      Optional ByVal alpha As Long = 128 _
   ) As Long
Dim lCFrom As Long
Dim lCTo As Long
   lCFrom = TranslateColor(oColorFrom)
   lCTo = TranslateColor(oColorTo)

Dim lSrcR As Long
Dim lSrcG As Long
Dim lSrcB As Long
Dim lDstR As Long
Dim lDstG As Long
Dim lDstB As Long
   
   lSrcR = lCFrom And &HFF
   lSrcG = (lCFrom And &HFF00&) \ &H100&
   lSrcB = (lCFrom And &HFF0000) \ &H10000
   lDstR = lCTo And &HFF
   lDstG = (lCTo And &HFF00&) \ &H100&
   lDstB = (lCTo And &HFF0000) \ &H10000
     
   
   BlendColor = RGB( _
      ((lSrcR * alpha) / 255) + ((lDstR * (255 - alpha)) / 255), _
      ((lSrcG * alpha) / 255) + ((lDstG * (255 - alpha)) / 255), _
      ((lSrcB * alpha) / 255) + ((lDstB * (255 - alpha)) / 255) _
      )

End Property

''' <summary>
''' Translates an <c>StdFont</c> object into the equivalent Windows GDI
''' <c>LOGFONT</c> structure.
''' </summary>
''' <param name="fntThis">Font to translate.</param>
''' <param name="hDC">Device context to get DPI information from.</param>
''' <param name="tLF">LOGFONT structure to populate.</param>
Public Sub pOLEFontToLogFont(fntThis As StdFont, hdc As Long, tLF As LOGFONT)
Dim sFont As String
Dim iChar As Integer

   ' Convert an OLE StdFont to a LOGFONT structure:
   With tLF
       sFont = fntThis.Name
       ' There is a quicker way involving StrConv and CopyMemory, but
       ' this is simpler!:
       For iChar = 1 To Len(sFont)
           .lfFaceName(iChar - 1) = CByte(Asc(Mid$(sFont, iChar, 1)))
       Next iChar
       ' Based on the Win32SDK documentation:
       .lfHeight = -MulDiv((fntThis.Size), (GetDeviceCaps(hdc, LOGPIXELSY)), 72)
       .lfItalic = fntThis.Italic
       If (fntThis.Bold) Then
           .lfWeight = FW_BOLD
       Else
           .lfWeight = FW_NORMAL
       End If
       .lfUnderline = fntThis.Underline
       .lfStrikeOut = fntThis.Strikethrough
       .lfCharSet = fntThis.Charset
         If (isXp) Then
            .lfQuality = CLEARTYPE_QUALITY
         Else
            .lfQuality = ANTIALIASED_QUALITY
         End If
   End With

End Sub
''' <summary>
''' Tiles a bitmap into the selected area.
''' </summary>
''' <param name="hDC">Handle to device context to draw onto.</param>
''' <param name="x">x start position.</param>
''' <param name="y">y start position.</param>
''' <param name="Width">Width of area to tile.</param>
''' <param name="Height">Height of area to tile.</param>
''' <param name="lSrcDC">Handle to device context containing image
''' to tile.</param>
''' <param name="lBitmapW">Width of the source bitmap.</param>
''' <param name="lBitmapH">Height of source bitmap.</param>
''' <param name="lSrcOffsetX">X offset in the source bitmap
''' to start tiling from.</param>
''' <param name="lSrcOffsetY">Y offset in the source bitmap
''' to start tiling from.</param>
Public Sub TileArea( _
        ByVal hdc As Long, _
        ByVal x As Long, _
        ByVal y As Long, _
        ByVal Width As Long, _
        ByVal Height As Long, _
        ByVal lSrcDC As Long, _
        ByVal lBitmapW As Long, _
        ByVal lBitmapH As Long, _
        ByVal lSrcOffsetX As Long, _
        ByVal lSrcOffsetY As Long _
    )
Dim lSrcX As Long
Dim lSrcY As Long
Dim lSrcStartX As Long
Dim lSrcStartY As Long
Dim lSrcStartWidth As Long
Dim lSrcStartHeight As Long
Dim lDstX As Long
Dim lDstY As Long
Dim lDstWidth As Long
Dim lDstHeight As Long

    lSrcStartX = ((x + lSrcOffsetX) Mod lBitmapW)
    lSrcStartY = ((y + lSrcOffsetY) Mod lBitmapH)
    lSrcStartWidth = (lBitmapW - lSrcStartX)
    lSrcStartHeight = (lBitmapH - lSrcStartY)
    lSrcX = lSrcStartX
    lSrcY = lSrcStartY
    
    lDstY = y
    lDstHeight = lSrcStartHeight
    
    Do While lDstY < (y + Height)
        If (lDstY + lDstHeight) > (y + Height) Then
            lDstHeight = y + Height - lDstY
        End If
        lDstWidth = lSrcStartWidth
        lDstX = x
        lSrcX = lSrcStartX
        Do While lDstX < (x + Width)
            If (lDstX + lDstWidth) > (x + Width) Then
                lDstWidth = x + Width - lDstX
                If (lDstWidth = 0) Then
                    lDstWidth = 4
                End If
            End If
            'If (lDstWidth > Width) Then lDstWidth = Width
            'If (lDstHeight > Height) Then lDstHeight = Height
            BitBlt hdc, lDstX, lDstY, lDstWidth, lDstHeight, lSrcDC, lSrcX, lSrcY, vbSrcCopy
            lDstX = lDstX + lDstWidth
            lSrcX = 0
            lDstWidth = lBitmapW
        Loop
        lDstY = lDstY + lDstHeight
        lSrcY = 0
        lDstHeight = lBitmapH
    Loop
End Sub



''' <summary>
''' Translates a unreferenced pointer to a COM object returned
''' by ObjPtr into an object reference.
''' </summary>
''' <param name="lPtr">Unreferenced pointer to a COM object</param>
''' <returns>COM object for the pointer</returns>
Public Property Get ObjectFromPtr(ByVal lPtr As Long) As Object
Dim oTemp As Object
   ' Turn the pointer into an illegal, uncounted interface
   CopyMemory oTemp, lPtr, 4
   ' Do NOT hit the End button here! You will crash!
   ' Assign to legal reference
   Set ObjectFromPtr = oTemp
   ' Still do NOT hit the End button here! You will still crash!
   ' Destroy the illegal reference
   CopyMemory oTemp, 0&, 4
   ' OK, hit the End button if you must--you'll probably still crash,
   ' but it will be because of the subclass, not the uncounted reference
End Property


Public Sub debugmsg(ByVal sMsg As String)
#If DEBUGMODE = 1 Then
   MsgBox sMsg
#Else
   Debug.Print sMsg
#End If
End Sub

''' <summary>
''' Returns whether the system is running XP (or above) or not.
''' </summary>
''' <returns><c>True</c> if the system is running XP or above.</returns>
Public Property Get isXp() As Boolean
   If Not (m_bInit) Then
      VerInitialise
   End If
   isXp = m_bIsXp
End Property
''' <summary>
''' Returns whether the system is running any flavour of NT or not.
''' </summary>
''' <returns><c>True</c> if the system is running NT/2000/XP or above.</returns>
Public Property Get IsNt() As Boolean
   If Not (m_bInit) Then
      VerInitialise
   End If
   IsNt = m_bIsNt
End Property

''' <summary>
''' Gets the Windows version and caches whether NT/XP
''' </summary>
Private Sub VerInitialise()
   Dim lMajor As Long
   Dim lMinor As Long
   GetWindowsVersion lMajor, lMinor
   If (lMajor > 5) Then
      m_bIsXp = True
   ElseIf (lMajor = 5) And (lMinor >= 1) Then
      m_bIsXp = True
   End If
   m_bInit = True
End Sub

''' <summary>
''' Returns current running Windows Version.
''' </summary>
''' <param name="lMajor">Variable to set to the major version of
''' Windows.</param>
''' <param name="lMinor">Variable to set to the minor version of
''' Windows.</param>
''' <param name="lRevision">Variable to set to the revision of
''' Windows.</param>
''' <param name="lBuildNumber">Variable to set to the build number of
''' Windows.</param>
Private Sub GetWindowsVersion( _
      Optional ByRef lMajor = 0, _
      Optional ByRef lMinor = 0, _
      Optional ByRef lRevision = 0, _
      Optional ByRef lBuildNumber = 0 _
   )
Dim lR As Long
   lR = GetVersion()
   lBuildNumber = (lR And &H7F000000) \ &H1000000
   If (lR And &H80000000) Then lBuildNumber = lBuildNumber Or &H80
   lRevision = (lR And &HFF0000) \ &H10000
   lMinor = (lR And &HFF00&) \ &H100
   lMajor = (lR And &HFF)
   m_bIsNt = ((lR And &H80000000) = 0)
End Sub

Public Sub gErr(ByVal lErr As Long, ByVal sErr As String)
   
   Err.Raise lErr, App.EXEName & ".sGrid", sErr

End Sub
