Attribute VB_Name = "mdlHook"
'------------------------------------------------------------------
'Módulo para subclasificación (subclassing)             (26/Jun/98)
'
'
'©Guillermo 'guille' Som, 1998
'------------------------------------------------------------------
Option Explicit

'Para almacenar el form de llamada y el hWnd del form
Private elForm As Form
Private elhWnd As Long

Public PrevWndProc As Long
'Public Const GWL_WNDPROC = (-4&)

Public Declare Function CallWindowProc Lib "User32" Alias "CallWindowProcA" _
    (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, _
    ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long

Public Declare Function SetWindowLong Lib "User32" Alias "SetWindowLongA" _
    (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long

Public Type RegistroMenu
   Id As Long
   Nivel As Integer
   Nombre As String * 70
End Type

Public Function WndProc(ByVal hwnd As Long, ByVal uMSG As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    WndProc = CallWindowProc(PrevWndProc, hwnd, uMSG, wParam, lParam)
    'Los mensajes de windows llegarán aquí
    'Lo que hay que hacer es "capturar" los que se necesiten,
    'en este caso se devuelven los mensajes al form, usando para
    'ello un procedimiento público llamado miMSG con los
    'siguientes parámetros:
    'ByVal uMSG As Long, ByVal wParam As Long, ByVal lParam As Long
    'la copia del form se hará al crear el Hook, es importante que
    'sólo se subclasifiquen ventanas cuando no halla ninguna activa
    '(de esto se encarga HookForm y unHookForm)
    '
    'Nos aseguramos que el form aún está disponible
    If Not elForm Is Nothing Then
      If uMSG = WM_MENUSELECT Then
         elForm.miMSG uMSG, wParam, lParam
      End If
    End If
End Function

Public Sub HookForm(ByVal unForm As Form)
    'unForm será el form de llamada,
    'para llamar a este procedimiento: HookForm Me
    '
    'Si aún existía una subclasificación
    If Not elForm Is Nothing Then
        unHookForm
    End If
    Set elForm = unForm
    elhWnd = unForm.hwnd
    PrevWndProc = SetWindowLong(elhWnd, GWL_WNDPROC, AddressOf WndProc)
    'Es importante recordar que se debe llamar a unHookForm antes
    'de cerrar el form... sobre todo si se usa en el IDE
End Sub

Public Sub unHookForm()
    Dim Ret As Long
    'Para llamar a este procedimiento: unHookForm
    '
    'Siempre se debe llamar primero a HookForm y después se llama
    'a este otro para dejar de interceptar los mensajes de Windows
    'Si haces pruebas en el IDE, no te olvides de llamar a este
    'procedimiento, cerrando la aplicación con el botón "Stop"
    'no se llamará a este procedimiento.
    '
    'Si el valor de elhWnd es cero es que no se ha usado
    If elhWnd <> 0 Then
        Ret = SetWindowLong(elhWnd, GWL_WNDPROC, PrevWndProc)
    End If
    'Quitamos la referencia al form
    Set elForm = Nothing
    'Asignamos el valor cero a elhWnd
    elhWnd = 0
End Sub
