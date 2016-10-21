VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cGridSortObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' =================================================================
' Class:    cGridSortObject
' Author:   SPM
' Date:     1 Feb 1997, modified 12/01/99 to support tGridCells
'
' Shell sorts a variant array according to a given
' column, using numeric, string or date type, ascending
' or descending.
'
' 19/10/99
' * Added CCLSortStringNoCase
' 2004-12-14
' * Change to use row indirection for sorting
' * Added CCLSortItemData
' * Added properties to interrogate the sort information
' * Grouping can now be configured using the sort object
'
' FREE SOURCE CODE - ENJOY!
' =================================================================

Public Enum ECGSortTypeConstants
   
   ' Text sorting:
    CCLSortNumeric = 100
    CCLSortString = 102
    CCLSortStringNoCase = 103
    
    ' Date sorting
    CCLSortDate = 200
    CCLSortDateYearAccuracy = 250
    CCLSortDateMonthAccuracy = 251
    CCLSortDateDayAccuracy = 252
    CCLSortDateHourAccuracy = 253
    CCLSortDateMinuteAccuracy = 254
    
    ' Icon sorting:
    CCLSortIcon = 300
    CCLSortExtraIcon = 301
    
    ' Colour sorting:
    CCLSortForeColor = 400
    CCLSortBackColor = 401
    
    ' Font sorting:
    CCLSortFontIndex = 500
    
    ' Selection sorting
    CCLSortSelected = 600
    
    ' Indentation sorting
    CCLSortIndentation = 700
    
    ' Item Data sorting
    CCLSortItemData = 800
    
End Enum

Private Const INTERNAL_FIND_GROUP_LEVEL As Long = &H2000&

Public Enum ECGSortOrderConstants
   CCLOrderNone = 0
   CCLOrderAscending = 1
   CCLOrderDescending = 2
End Enum

Private Type tSortInfo
   Column As Integer
   SortOrder As ECGSortOrderConstants
   SortType As ECGSortTypeConstants
   Group As Boolean
   GridColumnArrayIndex As Integer
End Type
Private m_tSort() As tSortInfo
Private m_iSortIndexCount As Integer
Private m_iLastSortIndex As Integer

Private m_bGridMatch As Boolean

Friend Sub SetGridMatch()
   m_bGridMatch = True
End Sub

Friend Property Get GridMatch() As Boolean
   GridMatch = m_bGridMatch
End Property

Friend Sub RemoveGroupBubbles()
Dim i As Long
Dim j As Long
Dim iLastGroupItem As Long
Dim tSwap As tSortInfo

   For i = 1 To m_iSortIndexCount
      If (m_tSort(i).Group) Then
         If (i - iLastGroupItem > 1) Then
            ' This item needs to be shuffled down
            ' until it reaches iLastGroupItem + 1
            LSet tSwap = m_tSort(i)
            For j = i To iLastGroupItem + 1 Step -1
               LSet m_tSort(j) = m_tSort(j - 1)
            Next j
            iLastGroupItem = iLastGroupItem + 1
            LSet m_tSort(iLastGroupItem) = tSwap
         Else
            iLastGroupItem = i
         End If
      End If
   Next i

End Sub

Public Sub Clear()
Attribute Clear.VB_Description = "Clears all columns from the sort object."
   m_iSortIndexCount = 0
   Erase m_tSort
   m_bGridMatch = False
End Sub

Public Property Get Count() As Long
Attribute Count.VB_Description = "Gets the number of sorting columns."
   Count = m_iSortIndexCount
End Property

Public Property Get IndexOf(ByVal lCol As Long) As Long
Attribute IndexOf.VB_Description = "Gets the index of the sort data for the specified column, or zero if no sorting should be applied to the column."
Dim i As Long
   For i = 1 To m_iSortIndexCount
      If (m_tSort(i).Column = lCol) Then
         IndexOf = i
         Exit For
      End If
   Next i
End Property

Public Sub Remove(ByVal lIndex As Long)
Attribute Remove.VB_Description = "Removes the sort data for the specified index."
   If (lIndex > 0) And (lIndex <= m_iSortIndexCount) Then
      Dim i As Long
      For i = lIndex To m_iSortIndexCount - 1
         LSet m_tSort(i) = m_tSort(i + 1)
      Next i
      m_iSortIndexCount = m_iSortIndexCount - 1
      If (m_iSortIndexCount > 0) Then
         ReDim Preserve m_tSort(1 To m_iSortIndexCount) As tSortInfo
      End If
      m_bGridMatch = False
   Else
      gErr 9, "Subscript out of range."
   End If
End Sub

Public Sub ClearNongrouped()
Attribute ClearNongrouped.VB_Description = "Clears only non-grouping sort rows from the sort object."
Dim i As Long
Dim j As Long
   For i = m_iSortIndexCount To 1 Step -1
      If Not (m_tSort(i).Group) Then
         If (m_iSortIndexCount > 1) Then
            For j = i + 1 To m_iSortIndexCount
               LSet m_tSort(j - 1) = m_tSort(j)
            Next j
            m_iSortIndexCount = m_iSortIndexCount - 1
            ReDim Preserve m_tSort(1 To m_iSortIndexCount) As tSortInfo
         Else
            Erase m_tSort
            m_iSortIndexCount = 0
            Exit For
         End If
      End If
   Next i
   m_bGridMatch = False ' maybe...
End Sub

Public Property Get LastSortIndex() As Integer
Attribute LastSortIndex.VB_Description = "Deprecated."
    LastSortIndex = m_iLastSortIndex
End Property
Public Property Let LastSortIndex( _
        ByVal iLastSortIndex As Integer _
    )
    m_iLastSortIndex = iLastSortIndex
End Property

Public Property Let SortColumn( _
        ByVal iSortIndex As Integer, _
        ByVal iSortColumn As Integer _
    )
Attribute SortColumn.VB_Description = "Gets/sets the column to sort by for the specified index."
   If (pbValidSortIndex(iSortIndex)) Then
      If Not (m_tSort(iSortIndex).Column = iSortColumn) Then
         m_tSort(iSortIndex).Column = iSortColumn
         m_bGridMatch = False
      End If
   End If
End Property
Public Property Get SortColumn( _
        ByVal iSortIndex As Integer _
    ) As Integer
    SortColumn = m_tSort(iSortIndex).Column
End Property

Public Property Get GroupBy( _
      ByVal iSortIndex As Integer _
   ) As Boolean
Attribute GroupBy.VB_Description = "Gets/sets whether the grid data should be grouped by the specified sorting column."
   GroupBy = m_tSort(iSortIndex).Group
End Property
Public Property Let GroupBy( _
      ByVal iSortIndex As Integer, _
      ByVal bState As Boolean _
   )
   If (pbValidSortIndex(iSortIndex)) Then
      If Not (m_tSort(iSortIndex).Group = bState) Then
         m_tSort(iSortIndex).Group = bState
         m_bGridMatch = False
      End If
   End If
End Property
   
Public Property Get SortOrder( _
      ByVal iSortIndex As Integer _
   ) As ECGSortOrderConstants
Attribute SortOrder.VB_Description = "Gets/sets the order to sort in for the specified index."
   SortOrder = m_tSort(iSortIndex).SortOrder
End Property
Public Property Let SortOrder( _
      ByVal iSortIndex As Integer, _
      ByVal iSortOrder As ECGSortOrderConstants _
   )
   If (pbValidSortIndex(iSortIndex)) Then
      If Not (m_tSort(iSortIndex).SortOrder = iSortOrder) Then
         m_tSort(iSortIndex).SortOrder = iSortOrder
         m_bGridMatch = False
      End If
   End If
End Property

Public Property Get SortType( _
      ByVal iSortIndex As Integer _
   ) As ECGSortTypeConstants
Attribute SortType.VB_Description = "Gets/sets the sorting type to use for the specified index."
   SortType = m_tSort(iSortIndex).SortType
End Property
Public Property Let SortType( _
      ByVal iSortIndex As Integer, _
      ByVal eSortType As ECGSortTypeConstants _
   )
   If (pbValidSortIndex(iSortIndex)) Then
      If Not (m_tSort(iSortIndex).SortType = eSortType) Then
         m_tSort(iSortIndex).SortType = eSortType
         m_bGridMatch = False
      End If
   End If
End Property

Friend Property Get GridColumnArrayIndex( _
      ByVal iSortIndex As Integer _
   ) As Long
   GridColumnArrayIndex = m_tSort(iSortIndex).GridColumnArrayIndex
End Property
Friend Property Let GridColumnArrayIndex( _
      ByVal iSortIndex As Integer, _
      ByVal iGridColumnArrayIndex As Long _
   )
   m_tSort(iSortIndex).GridColumnArrayIndex = iGridColumnArrayIndex
End Property

Private Function pbValidSortIndex( _
      ByVal iSortIndex As Integer _
   ) As Boolean
   
   If (iSortIndex > 0) And (iSortIndex <= 8) Then
      If (iSortIndex > m_iSortIndexCount) Then
         m_iSortIndexCount = iSortIndex
         ReDim Preserve m_tSort(1 To m_iSortIndexCount) As tSortInfo
      End If
      pbValidSortIndex = True
   Else
      gErr 503, "Invalid sort array index."
   End If
   
End Function

Friend Sub SortItems( _
        ByRef vItems() As tGridCell, _
        ByRef tRows() As tRowPosition, _
        ByVal lStartItem As Long, _
        ByVal lItems As Long _
    )
Dim iSwapIndex As Long
Dim iIncrement As Long
Dim iMainLoop As Long
Dim iSubLoop As Long
Dim vSortItems() As tGridCell
Dim tSortRow As tRowPosition
Dim iItemCount As Long
Dim iMainLoopRow As Long
Dim bIsEqual As Boolean
           
   ' 2003-10-14: Check it out, no shift of cell data, can be >10x quicker
           
    iItemCount = lItems

    ' Shell sort the list:
    ' ========================================================
    ' Implementation of Shell Sort algorithm using
    ' + 1 * 3 increment.
    ' ========================================================
    ' Prepare swap space storage:
    'ReDim vSortItems(1 To iColumns) As tGridCell
    ' Get inital shell sort increment
    If (iItemCount > 2) Then
        iIncrement = piGetSuitableShellSortInitialIncrement(iItemCount)
        Do Until iIncrement < 1
            For iMainLoop = iIncrement + 1 To iItemCount
            
                LSet tSortRow = tRows(iMainLoop)
                iMainLoopRow = tRows(iMainLoop).lGridCellArrayRow
                
                ' Loop from MainLoop-Increment to start item
                For iSubLoop = (iMainLoop - iIncrement) To lStartItem Step -iIncrement
                    If (pbGreater(vItems(), iMainLoopRow, tRows(iSubLoop).lGridCellArrayRow, bIsEqual)) Then
                        Exit For
                    End If
                    LSet tRows(iSubLoop + iIncrement) = tRows(iSubLoop)
                Next iSubLoop
                LSet tRows(iSubLoop + iIncrement) = tSortRow
            Next iMainLoop
            ' Get next shell sort increment value:
            iIncrement = iIncrement - 1
            iIncrement = iIncrement \ 3
        Loop
    Else
        ' For only two items just check whether the second should
        ' be swapped with the first:
        '    Fix - last version caused GPF as it fell off the end
        '    of the array..
        If (iItemCount = lStartItem + 1) Then
            'For iCol = 1 To iColumns
            '   LSet vSortItems(iCol) = vItems(iCol, lStartItem)
            'Next iCol
            If (pbGreater(vItems(), tRows(lStartItem).lGridCellArrayRow, tRows(lStartItem + 1).lGridCellArrayRow, bIsEqual)) Then
               ' swap
               LSet tSortRow = tRows(lStartItem)
               LSet tRows(lStartItem) = tRows(lStartItem + 1)
               LSet tRows(lStartItem + 1) = tSortRow
            End If
         End If
    End If
    
End Sub

Friend Function GetLastGroupSortColumn() As Long
Dim i As Long
Dim lIndex As Long
   For i = 1 To m_iSortIndexCount
      If (m_tSort(i).Group) Then
         lIndex = i
      End If
   Next i
   GetLastGroupSortColumn = lIndex
End Function

Friend Function FindInsertLocation( _
        ByRef vItems() As tGridCell, _
        ByRef tRows() As tRowPosition, _
        ByVal lStartItem As Long, _
        ByVal lItems As Long, _
        ByRef iResult As Long _
      ) As Long
Dim iStartRow As Long
Dim iEndRow As Long
Dim iMidRow As Long
Dim lRow As Long
Dim bGroupRowsOnly As Boolean
Dim bRemoveTempSort As Boolean
Dim lIndentMatchLevel As Long
Dim lIndexLastGroup As Long

   lIndexLastGroup = GetLastGroupSortColumn
   If (lIndexLastGroup = m_iSortIndexCount) And (m_iSortIndexCount > 0) Then
      lIndentMatchLevel = lIndexLastGroup
      ' Temporarily Add row group indent level to the sort
      m_iSortIndexCount = m_iSortIndexCount + 1
      ReDim Preserve m_tSort(1 To m_iSortIndexCount) As tSortInfo
      m_tSort(m_iSortIndexCount).SortType = INTERNAL_FIND_GROUP_LEVEL
      bRemoveTempSort = True
   End If

   iStartRow = lStartItem
   iEndRow = lItems - 1

   ' Binary search
   iResult = 0
   lRow = plBinSearch(vItems, tRows, lItems, iStartRow, iEndRow, lIndentMatchLevel, iResult)

   If (bRemoveTempSort) Then
      m_iSortIndexCount = m_iSortIndexCount - 1
      ReDim Preserve m_tSort(1 To m_iSortIndexCount) As tSortInfo
   End If
   
   FindInsertLocation = lRow
   
End Function

Private Function plBinSearch( _
      ByRef vItems() As tGridCell, _
      ByRef tRows() As tRowPosition, _
      ByVal lMatchFor As Long, _
      ByVal lStart As Long, _
      ByVal lEnd As Long, _
      ByVal lIndentMatchLevel As Long, _
      ByRef iR As Long _
   ) As Long
Dim iP As Long
Dim bIsEqual As Boolean
Dim bGreater As Boolean
   
   If lEnd - lStart > 1 Then
      iP = lStart + (lEnd - lStart) \ 2
      bGreater = pbGreaterBinSearch( _
            vItems, _
            tRows(iP).lGridCellArrayRow, _
            tRows(lMatchFor).lGridCellArrayRow, _
            tRows(iP).lGroupIndentLevel, _
            lIndentMatchLevel, _
            bIsEqual)
      If bIsEqual Then
         ' Success:
         iR = 0
         plBinSearch = iP
      ElseIf bGreater Then
         ' the centre element is greater than the
         ' item we're searching for.  Set the end
         ' to the centre element & repeat:
         lEnd = iP - 1
         plBinSearch = plBinSearch(vItems, tRows, lMatchFor, lStart, lEnd, lIndentMatchLevel, iR)
      Else
         ' the centre element is less than the
         ' item we're searching for.  Set the start
         ' to the centre element & repeat:
         lStart = iP + 1
         plBinSearch = plBinSearch(vItems, tRows, lMatchFor, lStart, lEnd, lIndentMatchLevel, iR)
      End If
   Else
      ' 1 or 2 items left.  Check if either
      ' match the search item.
      bGreater = pbGreaterBinSearch( _
            vItems, _
            tRows(lMatchFor).lGridCellArrayRow, _
            tRows(lEnd).lGridCellArrayRow, _
            lIndentMatchLevel, _
            tRows(lEnd).lGroupIndentLevel, _
            bIsEqual)
      If bIsEqual Then
         iR = 0
         plBinSearch = lEnd
      ElseIf (bGreater) Then
         iR = 1
         plBinSearch = lEnd
      Else
         bGreater = pbGreaterBinSearch( _
               vItems, _
               tRows(lStart).lGridCellArrayRow, _
               tRows(lMatchFor).lGridCellArrayRow, _
               tRows(lStart).lGroupIndentLevel, _
               lIndentMatchLevel, _
               bIsEqual)
         If (bIsEqual) Then
            iR = 0
            plBinSearch = lStart
         Else
            iR = IIf(bGreater, -1, 1)
            plBinSearch = lStart
         End If
      End If
   End If
   
End Function

Private Function pbGreaterBinSearch( _
      ByRef vItems() As tGridCell, _
      ByVal iRow1 As Long, _
      ByVal iRow2 As Long, _
      ByVal lGroupIndentRow1 As Long, _
      ByVal lGroupIndentRow2 As Long, _
      ByRef bIsEqual As Boolean _
   ) As Boolean
Dim iSortIndex As Integer
Dim bR As Boolean

   For iSortIndex = 1 To m_iSortIndexCount
      If (m_tSort(iSortIndex).SortType = INTERNAL_FIND_GROUP_LEVEL) Then
         If (lGroupIndentRow1 = 0) Then lGroupIndentRow1 = &H4000&
         If (lGroupIndentRow2 = 0) Then lGroupIndentRow2 = &H4000&
         bIsEqual = (lGroupIndentRow1 = lGroupIndentRow2)
         If Not (bIsEqual) Then
            bR = (lGroupIndentRow1 > lGroupIndentRow2)
         End If
      Else
         bR = pbIsGreater( _
            vItems(m_tSort(iSortIndex).Column, iRow1), _
            vItems(m_tSort(iSortIndex).Column, iRow2), _
            iSortIndex, bIsEqual)
      End If
      If (iSortIndex < m_iSortIndexCount) And bIsEqual Then
         ' Must go to the next one
      Else
         pbGreaterBinSearch = bR
         Exit For
      End If
   Next iSortIndex
   
End Function

Private Function pbGreater( _
      ByRef vItems() As tGridCell, _
      ByVal iRow1 As Long, _
      ByVal iRow2 As Long, _
      ByRef bIsEqual As Boolean _
   ) As Boolean
Dim iSortIndex As Integer
Dim bR As Boolean

   For iSortIndex = 1 To m_iSortIndexCount
      bR = pbIsGreater( _
         vItems(m_tSort(iSortIndex).Column, iRow1), _
         vItems(m_tSort(iSortIndex).Column, iRow2), _
         iSortIndex, bIsEqual)
      If (iSortIndex < m_iSortIndexCount) And bIsEqual Then
         ' Must go to the next one
      Else
         pbGreater = bR
         Exit For
      End If
   Next iSortIndex
   
End Function

Private Function pbIsGreater( _
        ByRef vSortItem As tGridCell, _
        ByRef vItem As tGridCell, _
        ByVal iSortIndex As Long, _
        ByRef bIsEqual As Boolean _
    ) As Boolean
Dim vR As Variant
Dim lR As Long
Dim sSortItemText As String, sItemText As String
Dim vSortDate As Date, vDate As Date
Dim bSortDate As Boolean, bDate As Boolean
Dim lDiff As Long

   Select Case m_tSort(iSortIndex).SortType
   
   Case CCLSortSelected
      lR = Abs(vSortItem.bSelected) - Abs(vItem.bSelected)
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
         pbIsGreater = (lR >= 0)
      Else
         pbIsGreater = (lR <= 0)
      End If
    
   Case CCLSortFontIndex
      lR = vSortItem.iFntIndex - vItem.iFntIndex
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
         pbIsGreater = (lR >= 0)
      Else
         pbIsGreater = (lR <= 0)
      End If
    
   Case CCLSortIndentation
      lR = vSortItem.lIndent - vItem.lIndent
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
         pbIsGreater = (lR >= 0)
      Else
         pbIsGreater = (lR <= 0)
      End If
    
   Case CCLSortItemData
      lR = vSortItem.lItemData - vItem.lItemData
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
         pbIsGreater = (lR >= 0)
      Else
         pbIsGreater = (lR <= 0)
      End If
      
   Case CCLSortIcon
      lR = vSortItem.iIconIndex - vItem.iIconIndex
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
          pbIsGreater = (lR >= 0)
      Else
          pbIsGreater = (lR <= 0)
      End If
    
   Case CCLSortExtraIcon
      lR = vSortItem.lExtraIconIndex - vItem.lExtraIconIndex
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
         pbIsGreater = (lR >= 0)
      Else
         pbIsGreater = (lR <= 0)
      End If
    
    Case CCLSortForeColor
        lR = vSortItem.oForeColor - vItem.oForeColor
        bIsEqual = (vR = 0)
        If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
            pbIsGreater = (lR >= 0)
        Else
            pbIsGreater = (lR <= 0)
        End If
    
    Case CCLSortBackColor
      lR = vSortItem.oBackColor - vItem.oBackColor
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
         pbIsGreater = (lR >= 0)
      Else
         pbIsGreater = (lR <= 0)
      End If
    
   Case CCLSortNumeric
      On Error Resume Next
      vR = Val(vSortItem.sText - vItem.sText)
      If (Err.Number = 0) Then
         bIsEqual = (vR = 0)
      Else
         If (IsNumeric(vSortItem.sText)) Then
            vR = 1
         ElseIf (IsNumeric(vItem.sText)) Then
            vR = -1
         Else
            vR = 0
         End If
      End If
      On Error GoTo 0
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
         pbIsGreater = (vR >= 0)
      Else
         pbIsGreater = (vR <= 0)
      End If
        
   Case CCLSortString
      If Not (IsMissing(vSortItem.sText)) Then
         sSortItemText = vSortItem.sText
      End If
      If Not (IsMissing(vItem.sText)) Then
         sItemText = vItem.sText
      End If
      lR = StrComp(sSortItemText, sItemText)
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
          pbIsGreater = (lR > -1)
      Else
          pbIsGreater = (lR < 1)
      End If
      
   Case CCLSortStringNoCase
      If Not (IsMissing(vSortItem.sText)) Then
         sSortItemText = vSortItem.sText
      End If
      If Not (IsMissing(vItem.sText)) Then
         sItemText = vItem.sText
      End If
      lR = StrComp(sSortItemText, sItemText, vbTextCompare)
      bIsEqual = (lR = 0)
      If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
          pbIsGreater = (lR > -1)
      Else
          pbIsGreater = (lR < 1)
      End If
    
   Case CCLSortDate
      If Not (IsMissing(vSortItem.sText)) Then
         sSortItemText = vSortItem.sText
      End If
      If Not (IsMissing(vItem.sText)) Then
         sItemText = vItem.sText
      End If
      bIsEqual = (vSortItem.sText = vItem.sText)
      If Not (bIsEqual) Then
         If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
            pbIsGreater = (vSortItem.sText >= vItem.sText)
         Else
            pbIsGreater = (vItem.sText >= vSortItem.sText)
         End If
      Else
         pbIsGreater = True
      End If
        
   Case CCLSortDateYearAccuracy
      If IsDate(vSortItem.sText) Then
         vSortDate = DateSerial(Year(vSortItem.sText), 1, 1)
         bSortDate = True
      End If
      If IsDate(vItem.sText) Then
         vDate = DateSerial(Year(vItem.sText), 1, 1)
         bDate = True
      End If
      If (bSortDate) And (bDate) Then
         bIsEqual = (vDate = vSortDate)
         If Not (bIsEqual) Then
            If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
                pbIsGreater = (vSortItem.sText >= vItem.sText)
            Else
                pbIsGreater = (vItem.sText >= vSortItem.sText)
            End If
         End If
      ElseIf bSortDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderAscending)
      ElseIf bDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderDescending)
      Else
         bIsEqual = True
      End If
        
   Case CCLSortDateMonthAccuracy
      If IsDate(vSortItem.sText) Then
         vSortDate = DateSerial(Year(vSortItem.sText), Month(vSortItem.sText), 1)
         bSortDate = True
      End If
      If IsDate(vItem.sText) Then
         vDate = DateSerial(Year(vItem.sText), Month(vItem.sText), 1)
         bDate = True
      End If
      If (bSortDate) And (bDate) Then
         bIsEqual = (vDate = vSortDate)
         If Not (bIsEqual) Then
            If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
                pbIsGreater = (vSortItem.sText >= vItem.sText)
            Else
                pbIsGreater = (vItem.sText >= vSortItem.sText)
            End If
         End If
      ElseIf bSortDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderAscending)
      ElseIf bDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderDescending)
      Else
         bIsEqual = True
      End If
        
   Case CCLSortDateDayAccuracy
      If IsDate(vSortItem.sText) Then
         vSortDate = DateSerial(Year(vSortItem.sText), Month(vSortItem.sText), Day(vSortItem.sText))
         bSortDate = True
      End If
      If IsDate(vItem.sText) Then
         vDate = DateSerial(Year(vItem.sText), Month(vItem.sText), Day(vItem.sText))
         bDate = True
      End If
      If (bSortDate) And (bDate) Then
         bIsEqual = (vDate = vSortDate)
         If Not (bIsEqual) Then
            If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
                pbIsGreater = (vSortItem.sText >= vItem.sText)
            Else
                pbIsGreater = (vItem.sText >= vSortItem.sText)
            End If
         End If
      ElseIf bSortDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderAscending)
      ElseIf bDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderDescending)
      Else
         bIsEqual = True
      End If
    
   Case CCLSortDateHourAccuracy
      If IsDate(vSortItem.sText) Then
         vSortDate = DateSerial(Year(vSortItem.sText), Month(vSortItem.sText), Day(vSortItem.sText)) + TimeSerial(Hour(vSortItem.sText), 0, 0)
         bSortDate = True
      End If
      If IsDate(vItem.sText) Then
         vDate = DateSerial(Year(vItem.sText), Month(vItem.sText), Day(vItem.sText)) + TimeSerial(Hour(vItem.sText), 0, 0)
         bDate = True
      End If
      If (bSortDate) And (bDate) Then
         bIsEqual = (vDate = vSortDate)
         If Not (bIsEqual) Then
            If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
                pbIsGreater = (vSortItem.sText >= vItem.sText)
            Else
                pbIsGreater = (vItem.sText >= vSortItem.sText)
            End If
         End If
      ElseIf bSortDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderAscending)
      ElseIf bDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderDescending)
      Else
         bIsEqual = True
      End If
    
   Case CCLSortDateMinuteAccuracy
      If IsDate(vSortItem.sText) Then
         vSortDate = DateSerial(Year(vSortItem.sText), Month(vSortItem.sText), Day(vSortItem.sText)) + TimeSerial(Hour(vSortItem.sText), Minute(vSortItem.sText), 0)
         bSortDate = True
      End If
      If IsDate(vItem.sText) Then
         vDate = DateSerial(Year(vItem.sText), Month(vItem.sText), Day(vItem.sText)) + TimeSerial(Hour(vItem.sText), Minute(vItem.sText), 0)
         bDate = True
      End If
      If (bSortDate) And (bDate) Then
         bIsEqual = (vDate = vSortDate)
         If Not (bIsEqual) Then
            If (m_tSort(iSortIndex).SortOrder = CCLOrderAscending) Then
                pbIsGreater = (vSortItem.sText >= vItem.sText)
            Else
                pbIsGreater = (vItem.sText >= vSortItem.sText)
            End If
         End If
      ElseIf bSortDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderAscending)
      ElseIf bDate Then
         pbIsGreater = (m_tSort(iSortIndex).SortOrder = CCLOrderDescending)
      Else
         bIsEqual = True
      End If
             
       
   End Select
    
End Function
Private Function piGetSuitableShellSortInitialIncrement( _
        iSortSize As Long _
    ) As Long
' ==============================================================
' Part of the implementation of Shell Sort algorithm using
' + 1 * 3 increment strategy.  This function returns the
' largest increment based on +1*3 which is less than the
' sort size.
' ==============================================================
Dim iRet As Long
Dim iLastRet As Long
    iLastRet = 1
    iRet = 1
    Do While iRet < iSortSize
        iLastRet = iRet
        iRet = iRet * 3 + 1
    Loop
    piGetSuitableShellSortInitialIncrement = iLastRet
End Function

Private Sub Class_Initialize()
   'debugmsg "cShellSortTGridCells:Initialize"
End Sub

Private Sub Class_Terminate()
   'debugmsg "cShellSortTGridCells:Terminate"
End Sub


