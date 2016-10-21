VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cGridCell"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_lPtrGrid As Long
Private m_lRow As Long
Private m_lCol As Long

Private m_oFont As StdFont
Private m_eAlign As ECGTextAlignFlags
Private m_lIconIndex As Long
Private m_oBackColor As OLE_COLOR
Private m_oForeColor As OLE_COLOR
Private m_lIndent As Long
Private m_lExtraIconIndex As Long
Private m_vText As Variant
Private m_lItemData As Long

Private m_bSelected As Boolean
Private m_bHot As Boolean

Public Property Get Row() As Long
   Row = m_lRow
End Property
Public Property Get Column() As Long
   Column = m_lCol
End Property

Public Property Get Selected() As Boolean
   Selected = m_bSelected
End Property

Public Property Let Selected(ByVal bState As Boolean)
   
End Property

Public Property Get Hot() As Boolean
   Hot = m_bHot
End Property

Public Property Get ItemData() As Long
Attribute ItemData.VB_Description = "Gets/sets a long value associated with this cell."
   ItemData = m_lItemData
End Property
Public Property Let ItemData(ByVal lItemData As Long)
   m_lItemData = lItemData
   If (m_lPtrGrid <> 0) Then
      grd.CellItemData(m_lRow, m_lCol) = lItemData
   End If
End Property
Public Property Get TextAlign() As ECGTextAlignFlags
Attribute TextAlign.VB_Description = "Gets/sets the alignment flags used to control the text position."
   TextAlign = m_eAlign
End Property
Public Property Let TextAlign(ByVal eAlign As ECGTextAlignFlags)
   m_eAlign = eAlign
   If (m_lPtrGrid <> 0) Then
      grd.CellTextAlign(m_lRow, m_lCol) = m_eAlign
   End If
End Property
Public Property Get Text() As Variant
Attribute Text.VB_Description = "Gets/sets the object to render as text for this cell.  If this is not a string, the column's ColumnFormat string is used to format the text for display."
   Text = m_vText
End Property
Public Property Let Text(ByVal vText As Variant)
   m_vText = vText
   If (m_lPtrGrid <> 0) Then
      grd.CellText(m_lRow, m_lCol) = vText
   End If
End Property

Public Property Get Font() As StdFont
Attribute Font.VB_Description = "Gets/sets the Font to use for this cell.  Set to Nothing for the default font."
   Set Font = m_oFont
End Property
Public Property Set Font(ByRef oFont As StdFont)
   Set m_oFont = oFont
   If (m_lPtrGrid <> 0) Then
      If (oFont Is Nothing) Then
         grd.CellDefaultFont m_lRow, m_lCol
      Else
         grd.CellFont(m_lRow, m_lCol) = oFont
      End If
   End If
End Property
Public Property Get IconIndex() As Long
Attribute IconIndex.VB_Description = "Gets/sets the 0-based index of the main icon for this cell.  Set to -1 for no icon."
   IconIndex = m_lIconIndex
End Property
Public Property Let IconIndex(ByVal lIconIndex As Long)
   m_lIconIndex = lIconIndex
   If (m_lPtrGrid <> 0) Then
      grd.CellIcon(m_lRow, m_lCol) = lIconIndex
   End If
End Property
Public Property Get ExtraIconIndex() As Long
Attribute ExtraIconIndex.VB_Description = "Gets/sets the 0-based index of an additional icon shown for this cell.  Set to -1 for no additional icon."
   ExtraIconIndex = m_lExtraIconIndex
End Property
Public Property Let ExtraIconIndex(ByVal lExtraIconIndex As Long)
   m_lExtraIconIndex = lExtraIconIndex
   If (m_lPtrGrid <> 0) Then
      grd.CellExtraIcon(m_lRow, m_lCol) = lExtraIconIndex
   End If
End Property
Public Property Get Indent() As Long
Attribute Indent.VB_Description = "Gets/sets the ident for this cell in pixels."
   Indent = m_lIndent
End Property
Public Property Let Indent(ByVal lIndent As Long)
   m_lIndent = lIndent
   If (m_lPtrGrid <> 0) Then
      grd.CellIndent(m_lRow, m_lCol) = lIndent
   End If
End Property
Public Property Get BackColor() As OLE_COLOR
Attribute BackColor.VB_Description = "Gets/sets the background colour of the cell."
   BackColor = m_oBackColor
End Property
Public Property Let BackColor(ByVal oColor As OLE_COLOR)
   m_oBackColor = oColor
   If (m_lPtrGrid <> 0) Then
      grd.CellBackColor(m_lRow, m_lCol) = oColor
   End If
End Property
Public Sub DefaultBackColor()
Attribute DefaultBackColor.VB_Description = "Sets the background colour to the default (-1)."
   m_oBackColor = CLR_NONE
   If (m_lPtrGrid <> 0) Then
      grd.CellBackColor(m_lRow, m_lCol) = CLR_NONE
   End If
End Sub
Public Property Get ForeColor() As OLE_COLOR
Attribute ForeColor.VB_Description = "Gets/sets the foreground colour for this cell."
   ForeColor = m_oForeColor
End Property
Public Property Let ForeColor(ByVal oColor As OLE_COLOR)
   m_oForeColor = oColor
   If (m_lPtrGrid <> 0) Then
      grd.CellForeColor(m_lRow, m_lCol) = oColor
   End If
End Property
Public Sub DefaultForeColor()
Attribute DefaultForeColor.VB_Description = "Sets the foreground colour to the default (-1)."
   m_oForeColor = CLR_NONE
   If (m_lPtrGrid <> 0) Then
      grd.CellForeColor(m_lRow, m_lCol) = CLR_NONE
   End If
End Sub
Private Property Get grd() As vbalGrid
Dim oTemp As vbalGrid
   If (m_lPtrGrid <> 0) Then
      Set grd = ObjectFromPtr(m_lPtrGrid)
   End If
End Property

Friend Sub InitNew( _
      ByVal grdThis As vbalGrid, _
      ByVal lRow As Long, _
      ByVal lCol As Long _
   )
   m_lRow = lRow
   m_lCol = lCol
   m_lPtrGrid = ObjPtr(grdThis)
End Sub

Friend Sub InitWithData( _
      ByVal grdThis As vbalGrid, _
      ByVal lRow As Long, _
      ByVal lCol As Long, _
      oFont As StdFont, _
      ByVal eAlign As ECGTextAlignFlags, _
      ByVal lIconIndex As Long, _
      ByVal oBackColor As OLE_COLOR, _
      ByVal oForeColor As OLE_COLOR, _
      ByVal lIndent As Long, _
      ByVal lExtraIconIndex As Long, _
      ByVal vText As Variant, _
      ByVal lItemData As Long, _
      ByVal bSelected As Boolean, _
      ByVal bHot As Boolean _
   )
   InitNew grdThis, lRow, lCol
   Set m_oFont = oFont
   m_eAlign = eAlign
   m_lIconIndex = lIconIndex
   m_oBackColor = oBackColor
   m_oForeColor = oForeColor
   m_lIndent = lIndent
   m_lExtraIconIndex = lExtraIconIndex
   m_vText = vText
   m_lItemData = lItemData
   m_bSelected = bSelected
   m_bHot = bHot
End Sub


Private Sub Class_Initialize()
   'debugmsg "cGridCell:Initialize"
   m_eAlign = DT_WORD_ELLIPSIS Or DT_SINGLELINE Or DT_VCENTER
   m_lIconIndex = -1
   m_oBackColor = CLR_NONE
   m_oForeColor = CLR_NONE
   m_lIndent = 0
   Set m_oFont = Nothing
   m_lExtraIconIndex = -1
   m_vText = Empty
End Sub

Private Sub Class_Terminate()
   m_lPtrGrid = 0
   'debugmsg "cGridCell:Terminate"
End Sub
