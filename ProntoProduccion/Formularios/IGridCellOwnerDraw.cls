VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "IGridCellOwnerDraw"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Sub Draw( _
      cell As cGridCell, _
      ByVal lhDC As Long, _
      ByVal eDrawStage As ECGDrawStage, _
      ByVal lLeft As Long, _
      ByVal lTop As Long, _
      ByVal lRight As Long, _
      ByVal lBottom As Long, _
      ByRef bSkipDefault As Boolean _
   )
Attribute Draw.VB_Description = "Called when a cell is to be drawn.  eDrawStage specifies the stage of the drawing (before, before text or after).  Setting bSkipDefault instructs the grid to skip its normal drawing."

End Sub
