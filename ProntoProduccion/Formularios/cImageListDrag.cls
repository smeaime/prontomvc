VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cImageListDrag"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Private Type POINTAPI
   x As Long
   y As Long
End Type
Private Type RECT
   left As Long
   top As Long
   right As Long
   bottom As Long
End Type

Private Declare Function ImageList_BeginDrag Lib "comctl32.dll" (ByVal himlTrack As Long, ByVal iTrack As Long, ByVal dxHotspot As Long, ByVal dyHotspot As Long) As Long
Private Declare Sub ImageList_EndDrag Lib "comctl32.dll" ()
Private Declare Function ImageList_DragEnter Lib "comctl32.dll" (ByVal hwndLock As Long, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function ImageList_DragLeave Lib "comctl32.dll" (ByVal hwndLock As Long) As Long
Private Declare Function ImageList_DragMove Lib "comctl32.dll" (ByVal x As Long, ByVal y As Long) As Long
Private Declare Function ImageList_SetDragCursorImage Lib "comctl32.dll" (ByVal himlDrag As Long, ByVal iDrag As Long, ByVal dxHotspot As Long, ByVal dyHotspot As Long) As Long

Private Declare Function ImageList_DragShowNolock Lib "comctl32.dll" (ByVal fShow As Long) As Long
Private Declare Function ImageList_GetDragImage Lib "comctl32.dll" (ppt As POINTAPI, pptHotspot As POINTAPI) As Long

Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long

Private m_hIml As Long
Private m_oOwner As Object
Private m_hWndLast As Long
Private m_bInDrag As Boolean
Private m_bStartDrag As Boolean

Public Property Let hImagelist(ByVal hIml As Long)
   m_hIml = hIml
End Property
Public Property Let Owner(oOwner As Object)
   Set m_oOwner = oOwner
End Property

Public Sub StartDrag( _
      ByVal iImageIndex As Long, _
      Optional ByVal xOffset As Long = 0, _
      Optional ByVal yOffset As Long = 0 _
   )
Dim lR As Long
   CompleteDrag
   lR = ImageList_BeginDrag(m_hIml, iImageIndex, xOffset, yOffset)
   If Not (lR = 0) Then
      m_bInDrag = True
      m_bStartDrag = True
   End If
End Sub
Public Sub DragDrop()
Dim hWndParent As Long
Dim xDst As Long
Dim yDst As Long
   If (m_bInDrag) Then
      pConvert hWndParent, xDst, yDst
      
      If (m_bStartDrag) Then
         ImageList_DragEnter hWndParent, xDst, yDst
         m_hWndLast = hWndParent
         m_bStartDrag = False
      End If
   
      ImageList_DragMove xDst, yDst
   
   End If
End Sub
Public Sub CompleteDrag()
   If (m_bInDrag) Then
      ImageList_EndDrag
      ImageList_DragLeave m_hWndLast
      m_hWndLast = 0
      m_bInDrag = False
   End If
End Sub
Public Sub HideDragImage(ByVal bState As Boolean)
   If (m_bInDrag) Then
      If (bState) Then
         ImageList_DragLeave m_hWndLast
         m_bStartDrag = True
      Else
         DragDrop
      End If
   End If
End Sub

Private Sub pConvert(hWndParent As Long, x As Long, y As Long)
Dim tP As POINTAPI
Dim tR As RECT
   
   GetCursorPos tP
   
   ' convert x & y to screen coordinates
   If (m_oOwner Is Nothing) Then
      ' Position relative to the screen, in pixels
      x = tP.x
      y = tP.y
   Else
      On Error Resume Next
      Dim oParent As Object
      oParent = m_oOwner.Parent
      If (Err.Number = 0) Then
         hWndParent = m_oOwner.Parent.hwnd
      Else
         hWndParent = m_oOwner.hwnd
      End If
      
      GetWindowRect hWndParent, tR
      x = tP.x - tR.left
      y = tP.y - tR.top
   End If
End Sub

Private Sub Class_Terminate()
   CompleteDrag
End Sub


