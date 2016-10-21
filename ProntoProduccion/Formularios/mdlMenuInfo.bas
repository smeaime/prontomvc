Attribute VB_Name = "mdlMenuInfo"
Option Explicit

Enum MenuShortcuts
    vbNoShortcut
    vbCtrlA
    vbCtrlB
    vbCtrlC
    vbCtrlD
    vbCtrlE
    vbCtrlF
    vbCtrlG
    vbCtrlH
    vbCtrlI
    vbCtrlJ
    vbCtrlK
    vbCtrlL
    vbCtrlM
    vbCtrlN
    vbCtrlO
    vbCtrlP
    vbCtrlQ
    vbCtrlR
    vbCtrlS
    vbCtrlT
    vbCtrlU
    vbCtrlV
    vbCtrlW
    vbCtrlX
    vbCtrlY
    vbCtrlZ
    vbF1
    vbF2
    vbF3
    vbF4
    vbF5
    vbF6
    vbF7
    vbF8
    vbF9
    vbF10
    vbF11
    vbF12
    vbCtrlF1
    vbCtrlF2
    vbCtrlF3
    vbCtrlF4
    vbCtrlF5
    vbCtrlF6
    vbCtrlF7
    vbCtrlF8
    vbCtrlF9
    vbCtrlF10
    vbCtrlF11
    vbCtrlF12
    vbShiftF1
    vbShiftF2
    vbShiftF3
    vbShiftF4
    vbShiftF5
    vbShiftF6
    vbShiftF7
    vbShiftF8
    vbShiftF9
    vbShiftF10
    vbShiftF11
    vbShiftF12
    vbShiftCtrlF1
    vbShiftCtrlF2
    vbShiftCtrlF3
    vbShiftCtrlF4
    vbShiftCtrlF5
    vbShiftCtrlF6
    vbShiftCtrlF7
    vbShiftCtrlF8
    vbShiftCtrlF9
    vbShiftCtrlF10
    vbShiftCtrlF11
    vbShiftCtrlF12
    vbCtrlInsert
    vbShiftInset
    vbDelete
    vbShiftDel
    vbAltBackspace
End Enum

'*********************************************************************************************
' Menu flags
'*********************************************************************************************
Enum MenuFlags
    Checked = &H1
    Hidden = &H2
    Grayed = &H4
    PopUp = &H8
    WindowList = &H20
    LastItem = &H100
End Enum

'*********************************************************************************************
' VB5 Internal menu struct
'*********************************************************************************************
Type MenuStruct
    Reserved(0 To 48) As Long
    dwFlags As MenuFlags
    lpNextMenu As Long
    lpFirstItem As Long
    lpszName As Long
    hMenu As Long
    wID As Integer
    wShortcut As Integer
End Type
'*********************************************************************************************
' GetFirstChildMenu
'*********************************************************************************************
'
' Parameters:
'
'   MenuObject:     The menu object of which the
'                   menu handle is wanted.
'
' Returns:
'
'   The menu handle if it's a popup menu.
'
'*********************************************************************************************
Public Function GethMenu(ByVal MenuObject As VB.Menu) As Long
Dim Mnu As MenuStruct
    
    ' Get the menu struct
    
    MoveMemory Mnu, ByVal ObjPtr(MenuObject), Len(Mnu)
    
    ' Get the hMenu only if the menu
    ' is a popup menu. A popup menu is a
    ' menu with child items.

    If Mnu.lpFirstItem Then
        GethMenu = Mnu.hMenu
    Else
        GethMenu = 0
    End If
    
End Function

'*********************************************************************************************
' GetParenthMenu
'*********************************************************************************************
'
' Parameters:
'
'   MenuObject:     The menu object of which
'                   parent menu handle is wanted.
'
' Returns:
'
'   The parent menu handle.
'
'*********************************************************************************************
Public Function GetParenthMenu(ByVal MenuObject As VB.Menu) As Long
Dim Mnu As MenuStruct
    
    ' Get the menu struct
    
    MoveMemory Mnu, ByVal ObjPtr(MenuObject), Len(Mnu)
    
    ' Get the hMenu only if the menu
    ' isn't a popup menu.

    If Mnu.lpFirstItem = 0 Then
        GetParenthMenu = Mnu.hMenu
    Else
        GetParenthMenu = 0
    End If
    
End Function

'*********************************************************************************************
' GetShortcut
'*********************************************************************************************
'
' Parameters:
'
'   MenuObject:     The menu object of which
'                   the shortcut is wanted.
'
' Returns:
'
'   The shortcut.
'
'*********************************************************************************************
Public Function GetShortcut(ByVal MenuObject As VB.Menu) As MenuShortcuts
Dim Mnu As MenuStruct

    ' Get the menu struct
    
    MoveMemory Mnu, ByVal ObjPtr(MenuObject), Len(Mnu)
    
    ' Only non popup items can have a shortcut
    
    If Mnu.lpFirstItem = 0 Then
        GetShortcut = Mnu.wShortcut
    Else
        GetShortcut = vbNoShortcut
    End If
    
End Function



'*********************************************************************************************
' GetNextMenu
'*********************************************************************************************
'
' Parameters:
'
'   MenuObject:     The menu object of which
'                   next menu object is wanted.
'
' Returns:
'
'   The next menu object or Nothing if this is the
'   last menu.
'
'*********************************************************************************************
Public Function GetNextMenu(ByVal MenuObject As VB.Menu) As VB.Menu
Dim Mnu As MenuStruct, Nxt As VB.Menu

    ' Get the menu struct
    
    MoveMemory Mnu, ByVal ObjPtr(MenuObject), Len(Mnu)
            
    ' Get the next menu only if there's one
    ' and this is not the last item
    
    If Mnu.lpNextMenu <> 0 And (Mnu.dwFlags And LastItem) = 0 Then
        
        ' Get a copy without AddRef
        MoveMemory Nxt, Mnu.lpNextMenu, 4
        
        ' Get the object with AddRef
        Set GetNextMenu = Nxt
        
        ' Release the copy
        MoveMemory Nxt, 0&, 4
        
    End If

End Function

'*********************************************************************************************
' GetParentMenu
'*********************************************************************************************
'
' Parameters:
'
'   MenuObject:     The menu object of which
'                   parent menu object is wanted.
'
' Returns:
'
'   The parent menu object.
'
'*********************************************************************************************
Public Function GetParentMenu(ByVal MenuObject As VB.Menu) As VB.Menu
Dim Nxt As VB.Menu, Mnu As MenuStruct

    ' Get the next menu until we found the last item
    ' in the menu. In the last menu object the next
    ' menu points to the parent.

    Set Nxt = GetNextMenu(MenuObject)
    
    Do While Not Nxt Is Nothing
    
        MoveMemory Mnu, ByVal ObjPtr(Nxt), Len(Mnu)
        
        If (Mnu.dwFlags And LastItem) = LastItem Then
            
            Dim Parent As VB.Menu
            
            MoveMemory Parent, Mnu.lpNextMenu, 4
        
            ' Get the object with AddRef
            Set GetParentMenu = Parent
        
            MoveMemory Parent, 0&, 4
            
            Exit Do
            
        End If
        
        Set Nxt = GetNextMenu(Nxt)
        
    Loop

End Function


'*********************************************************************************************
' GetFirstChildMenu
'*********************************************************************************************
'
' Parameters:
'
'   MenuObject:     The menu object of which the
'                   first child is wanted.
'
' Returns:
'
'   The first child menu object.
'
'*********************************************************************************************
Public Function GetFirstChildMenu(ByVal MenuObject As VB.Menu) As VB.Menu
Dim Mnu As MenuStruct, Itm As Menu

    ' Get menu struct from object
    MoveMemory Mnu, ByVal ObjPtr(MenuObject), Len(Mnu)

    ' Check the pointer. If it's null there's
    ' no child item.
    If Mnu.lpFirstItem <> 0 Then
        
        ' Get the object reference. Since
        ' IUnknown::AddRef is not called
        ' DO NOT set this object to Nothing.
        MoveMemory Itm, Mnu.lpFirstItem, 4
        
        ' Get a copy with AddRef.
        Set GetFirstChildMenu = Itm
        
        MoveMemory Itm, 0&, 4
        
    End If
    
End Function



'*********************************************************************************************
' GetShortcut
'*********************************************************************************************
'
' Parameters:
'
'   MenuObject:     The menu object.
'
' Returns:
'
'   True if the menu item has children, otherwise False.
'
'*********************************************************************************************
Public Function IsPopupMenu(MenuObject As VB.Menu) As Boolean
Dim Mnu As MenuStruct

    MoveMemory Mnu, ByVal ObjPtr(MenuObject), Len(Mnu)
    
    IsPopupMenu = Mnu.lpFirstItem

End Function

'*********************************************************************************************
' SetShortcut
'*********************************************************************************************
'
' Changes a menu shortcut
'
' Parameters:
'
'   MenuObject:     The menu object.
'
'*********************************************************************************************
Public Sub SetShortcut(ByVal MenuObject As VB.Menu, ByVal NewShortcut As MenuShortcuts)
Dim Mnu As MenuStruct

    ' Get the menu struct
    
    MoveMemory Mnu, ByVal ObjPtr(MenuObject), Len(Mnu)
    
    ' Only non popup items can have a shortcut
    
    If Mnu.lpFirstItem = 0 Then
    
        If NewShortcut > vbAltBackspace Then
            NewShortcut = vbAltBackspace
        ElseIf NewShortcut < 0 Then
            NewShortcut = vbNoShortcut
        End If
        
        Mnu.wShortcut = NewShortcut
        
        ' Change only that value
    
        MoveMemory ByVal ObjPtr(MenuObject) + 218, Mnu.wShortcut, 2
        
        ' Set the caption to update
        ' the shortcut text
        MenuObject.Caption = MenuObject.Caption
        
    End If

End Sub

'*********************************************************************************************
' GetCommand
'*********************************************************************************************
'
' Parameters:
'
'   MenuObject:     The menu object of which the
'                   Command is wanted. Only non
'                   popup items have a Command.
'
' Returns:
'
'   The Command.
'
'*********************************************************************************************
Public Function GetCommand(ByVal MenuObject As VB.Menu) As Long
Dim Mnu As MenuStruct
    
    ' Get the menu struct from object
    
    MoveMemory Mnu, ByVal ObjPtr(MenuObject), Len(Mnu)
    
    ' Get the Command only if the menu
    ' isn't a popup menu.

    If Mnu.lpFirstItem = 0 Then
        GetCommand = Mnu.wID
    Else
        GetCommand = 0
    End If
    
End Function

