Attribute VB_Name = "mMouseHook"
Option Explicit

' ======================================================================================
' Name:     mGDI
' Author:   Steve McMahon (steve@vbaccelerator.com)
' Date:     22 December 1998
'
' Copyright © 1998-1999 Steve McMahon for vbAccelerator
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

Private Type POINTAPI
   x As Long
   y As Long
End Type

Private Type MOUSEHOOKSTRUCT
    pt As POINTAPI
    hwnd As Long
    wHitTestCode As Long
    dwExtraInfo As Long
End Type

Private Declare Function SetWindowsHookEx Lib "user32" Alias "SetWindowsHookExA" (ByVal idHook As Long, ByVal lpFn As Long, ByVal hmod As Long, ByVal dwThreadId As Long) As Long
Private Declare Function UnhookWindowsHookEx Lib "user32" (ByVal hHook As Long) As Long
Private Declare Function CallNextHookEx Lib "user32" (ByVal hHook As Long, ByVal nCode As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function GetCurrentThreadId Lib "kernel32" () As Long
Private Declare Function IsWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function GetActiveWindow Lib "user32" () As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
    lpvDest As Any, lpvSource As Any, ByVal cbCopy As Long)
Private Const WH_MOUSE = 7

Private Const WM_RBUTTONUP As Long = &H205

''' <summary>
''' Mouse hook handle
''' </summary>
Private m_hMouseHook As Long
''' <summary>
''' Array of unreferenced pointers to the Grid object to
''' call when a mouse hook event occurs
''' </summary>
Private m_lMouseHookPtr() As Long
''' <summary>
''' Array of window handles to the Grid object to call
''' when a mouse hook event occurs.
''' </summary>
Private m_lMouseHookhWnd() As Long
''' <summary>
''' Count of grids receiving mouse hook notifications
''' </summary>
Private m_iMouseHookCount As Long

''' <summary>
''' Attaches a mouse hook for a particular grid.
''' </summary>
''' <param name="ctlGrid">The Grid to attach the mouse
''' hook for</param>
Public Sub AttachMouseHook(ctlGrid As vbalGrid)
Dim lpFn As Long
Dim lPtr As Long
Dim i As Long
   
   If m_iMouseHookCount = 0 Then
      lpFn = HookAddress(AddressOf MouseFilter)
      m_hMouseHook = SetWindowsHookEx(WH_MOUSE, lpFn, 0&, GetCurrentThreadId())
      Debug.Assert (m_hMouseHook <> 0)
   End If
   lPtr = ObjPtr(ctlGrid)
   For i = 1 To m_iMouseHookCount
      If lPtr = m_lMouseHookPtr(i) Then
         ' we already have it:
         Debug.Assert False
         Exit Sub
      End If
   Next i
   ReDim Preserve m_lMouseHookPtr(1 To m_iMouseHookCount + 1) As Long
   ReDim Preserve m_lMouseHookhWnd(1 To m_iMouseHookCount + 1) As Long
   m_iMouseHookCount = m_iMouseHookCount + 1
   m_lMouseHookPtr(m_iMouseHookCount) = lPtr
   m_lMouseHookhWnd(m_iMouseHookCount) = ctlGrid.hwnd
   
End Sub

''' <summary>
''' Detaches a mouse hook attached by a particular grid.
''' </summary>
''' <param name="ctlGrid">The Grid which attached the mouse
''' hook</param>
Public Sub DetachMouseHook(ctlGrid As vbalGrid)
Dim i As Long
Dim lPtr As Long
Dim iThis As Long
   
   lPtr = ObjPtr(ctlGrid)
   For i = 1 To m_iMouseHookCount
      If m_lMouseHookPtr(i) = lPtr Then
         iThis = i
         Exit For
      End If
   Next i
   If iThis <> 0 Then
      If m_iMouseHookCount > 1 Then
         For i = iThis To m_iMouseHookCount - 1
            m_lMouseHookPtr(i) = m_lMouseHookPtr(i + 1)
         Next i
      End If
      m_iMouseHookCount = m_iMouseHookCount - 1
      If m_iMouseHookCount >= 1 Then
         ReDim Preserve m_lMouseHookPtr(1 To m_iMouseHookCount) As Long
      Else
         Erase m_lMouseHookPtr
      End If
   Else
      ' Trying to detach SGrid which was never attached...
   End If
   
   If m_iMouseHookCount <= 0 Then
      If (m_hMouseHook <> 0) Then
         UnhookWindowsHookEx m_hMouseHook
         m_hMouseHook = 0
      End If
   End If
   
End Sub

''' <summary>
''' Hack to return the value returned by <c>AddressOf</c> to
''' allow it to be placed into a variable
''' </summary>
''' <param name="lPtr">Variable to receive <c>AddressOf</c>
''' value.</param>
''' <returns>Pointer returned by <c>AddressOf</c></returns>
Private Function HookAddress(ByVal lPtr As Long) As Long
   HookAddress = lPtr
End Function

''' <summary>
''' Call back routine for a Mouse Hook
''' </summary>
''' <param name="nCode">Hook Code</param>
''' <param name="wParam">Mouse message code</param>
''' <param name="lParam">Pointer to MOUSEHOOKSTRUCT containing information about the
''' mouse message</param>
''' <returns>Value of next mouse hook, if any</returns>
Private Function MouseFilter(ByVal nCode As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Dim tMHS As MOUSEHOOKSTRUCT
Dim i As Long
Dim ctlGrid As vbalGrid

On Error GoTo ErrorHandler

   ' Decode lParam:
   CopyMemory tMHS, ByVal lParam, Len(tMHS)
   
   ' Loop through attached grids (there should only be one)
   For i = 1 To m_iMouseHookCount
      ' Call the MouseEvent of any Grid that is attached:
      If Not (m_lMouseHookPtr(i) = 0) Then
         If Not (IsWindow(m_lMouseHookhWnd(i)) = 0) Then
            Set ctlGrid = ObjectFromPtr(m_lMouseHookPtr(i))
            If Not ctlGrid Is Nothing Then
               If ctlGrid.MouseEvent(wParam, tMHS.hwnd, _
                  tMHS.pt.x, tMHS.pt.y, tMHS.wHitTestCode) Then
                  
               End If
            End If
         End If
      End If
   Next i
   
   If Not (m_hMouseHook = 0) Then
      MouseFilter = CallNextHookEx(m_hMouseHook, nCode, wParam, lParam)
   End If

   Exit Function

ErrorHandler:
   debugmsg "Error in MouseFilter:" & Err.Number & "," & Err.Description
   Exit Function
End Function

