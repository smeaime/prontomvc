VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CEmailOL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'==========================================================================
'Copyright © 2001
'
'   CEmailOL.cls
'   Sends Email using Outlook objects
'   EmailTest Send Utility
'   Date Created: 11-Nov-2000
'
'   Notes:
'   This class requires a VB reference to: Microsoft Outlook 9.0 Object Library (MSOUTL9.OLB)
'==========================================================================

'Member variables
Dim m_oOLApp As Outlook.Application
Dim m_oOLMailItem As Outlook.MailItem
Dim m_oOLGN As Outlook.NameSpace
Dim m_oOLFolder As Outlook.MAPIFolder
Dim mRespuestasOk As String

Public Function Send(ByVal ListName As String, ByVal ClientActive As Boolean, ByVal Subject As String, ByVal Body As String, Optional ByVal Attachment As String) As Long

   'send using Outlook objects
   Dim sAddresses() As String
   Dim sAttachments() As String
   Dim sPath As String, sName As String
   Dim lRecip, lAttach, lBody As Long
   
   On Error Resume Next
   
   'check that email is enabled for this List
   If Len(ListName) = 0 Then
      Send = -1
      Exit Function
   End If
   
   'Outlook shows the Logon form if needed, so the ClientActive parameter isn't used
   Set m_oOLMailItem = m_oOLApp.CreateItem(olMailItem)
   With m_oOLMailItem
      .Subject = Subject
      'Set list of recipients & resolve (list is semicolon-delimited)
      sAddresses = Split(ListName, ",")
      For lRecip = 0 To UBound(sAddresses, 1)
         .Recipients.Add sAddresses(lRecip)
      Next
      .Recipients.ResolveAll
      'leave space after body text
      .Body = Body & vbCrLf & vbCrLf
      .Importance = olImportanceNormal
      'one attachment in this example
      lBody = Len(.Body) + 1
      sAttachments = Split(Attachment, ",")
      For lAttach = 0 To UBound(sAttachments, 1)
         If CheckAttachment(sAttachments(lAttach), sPath, sName) Then
            .Attachments.Add sPath, olByValue, lBody, sName
            lBody = lBody + Len(sName) + 1
         End If
      Next
      'Send the new message
      .Send
   End With
   
   'return any error code that occurs (0=success)
   Send = Err

End Function

Public Function Abrir(ByVal ListName As String, ByVal ClientActive As Boolean, ByVal Subject As String, ByVal Body As String, Optional ByVal Attachment As String) As Long

   'send using Outlook objects
   Dim sAddresses() As String
   Dim sAttachments() As String
   Dim sPath As String, sName As String
   Dim lRecip, lAttach, lBody As Long
   
   On Error Resume Next
   
   'check that email is enabled for this List
   If Len(ListName) = 0 Then Exit Function

   'Outlook shows the Logon form if needed, so the ClientActive parameter isn't used
   Set m_oOLMailItem = m_oOLApp.CreateItem(olMailItem)
   With m_oOLMailItem
      .Display
      .Subject = Subject
      'Set list of recipients & resolve (list is semicolon-delimited)
      sAddresses = Split(ListName, ",")
      For lRecip = 0 To UBound(sAddresses, 1)
         .Recipients.Add sAddresses(lRecip)
      Next
      .Recipients.ResolveAll
      'leave space after body text
      .Body = Body & vbCrLf & vbCrLf
      .Importance = olImportanceNormal
      'one attachment in this example
      lBody = Len(.Body) + 1
      sAttachments = Split(Attachment, ",")
      For lAttach = 0 To UBound(sAttachments, 1)
         If CheckAttachment(sAttachments(lAttach), sPath, sName) Then
            .Attachments.Add sPath, olByValue, lBody, sName
            lBody = lBody + Len(sName) + 1
         End If
      Next
   End With
   
   'return any error code that occurs (0=success)
   Abrir = Err

End Function

Public Function Leer(ByVal PathEntrante As String, oF As Form) As Long

   Dim i As Integer, i1 As Integer, i2 As Integer, i3 As Integer, mSeñal As Integer
   Dim mOk As String, mOrigen As String, mFechaRecepcion As String, mArch As String
   Dim mFecha As Date
   
   mOk = ""
   
   Set m_oOLGN = m_oOLApp.GetNamespace("MAPI")
'   Set m_oOLFolder = m_oOLGN.Folders.Item(2).Folders.Item(1)
   Set m_oOLFolder = m_oOLGN.GetDefaultFolder(olFolderInbox)
   
   i1 = 0
   i2 = 0
   
   For i3 = m_oOLFolder.Items.Count To 1 Step -1
      i1 = i1 + 1
      oF.Label2.Caption = "Revisando bandeja de entrada : " & i1 & " de " & m_oOLFolder.Items.Count & " mensajes."
      DoEvents
      Set m_oOLMailItem = m_oOLFolder.Items.Item(i3)
      mSeñal = InStr(1, m_oOLMailItem.Subject, "_")
      If mSeñal <> 0 Then
         mOrigen = mId(m_oOLMailItem.Subject, 1, mSeñal - 1)
         If mOrigen = glbEmpresaSegunString Then
            i2 = i2 + 1
            oF.Label3.Caption = "Mensajes recuperados para procesar : " & i2
            If mId(m_oOLMailItem.Subject, Len(m_oOLMailItem.Subject) - 1, 2) = "Ok" Then
               mOk = mOk & m_oOLMailItem.Subject & "|"
            End If
            If m_oOLMailItem.Attachments.Count > 0 Then
               mFecha = m_oOLMailItem.ReceivedTime
               mFechaRecepcion = "" & Year(mFecha) & Format(Month(mFecha), "00") & _
                                 Format(Day(mFecha), "00") & Hour(mFecha) & Minute(mFecha)
               mArch = m_oOLMailItem.Attachments.Item(1).DisplayName
               mSeñal = 0
               For i = Len(mArch) To 1 Step -1
                  If mId(mArch, i, 1) = "." Then
                     mSeñal = i
                     Exit For
                  End If
               Next
               If mSeñal > 0 Then
                  mArch = mId(mArch, 1, mSeñal - 1) & "_" & mFechaRecepcion & _
                           mId(mArch, mSeñal, 10)
               End If
               m_oOLMailItem.Attachments.Item(1).SaveAsFile PathEntrante & "\" & mArch
            End If
            m_oOLMailItem.Delete
         End If
      End If
   Next
   
   If Len(mOk) Then mOk = mId(mOk, 1, Len(mOk) - 1)
   Me.RespuestasOK = mOk
   
   'return any error code that occurs (0=success)
   Leer = Err

End Function

Public Function LeerPedidosEstadoObras(ByRef oF As Form) As Long

   Dim i, i1, i2, i3 As Integer
   Dim mOk As String
   
   mOk = ""
   
   Set m_oOLGN = m_oOLApp.GetNamespace("MAPI")
   Set m_oOLFolder = m_oOLGN.GetDefaultFolder(olFolderInbox)
   
   i1 = 0
   i2 = 0
   
   For i3 = m_oOLFolder.Items.Count To 1 Step -1
      i1 = i1 + 1
      oF.Label2.Caption = "Revisando bandeja de entrada : " & i1 & " de " & m_oOLFolder.Items.Count & " mensajes."
      DoEvents
      Set m_oOLMailItem = m_oOLFolder.Items.Item(i3)
      If UCase(mId(m_oOLMailItem.Subject, 1, 14)) = "ESTADO DE OBRA" Then
         i2 = i2 + 1
         oF.Label3.Caption = "Mensajes recuperados para procesar : " & i2
         mOk = mOk & m_oOLMailItem.Subject & "*" & m_oOLMailItem.SentOnBehalfOfName & "|"
         m_oOLMailItem.Delete
      End If
   Next
   
   If Len(mOk) Then mOk = mId(mOk, 1, Len(mOk) - 1)
   Me.RespuestasOK = mOk
   
   'return any error code that occurs (0=success)
   LeerPedidosEstadoObras = Err

End Function

Public Property Get RespuestasOK() As String

   RespuestasOK = mRespuestasOk
   
End Property

Public Property Let RespuestasOK(ByVal vNewValue As String)

   mRespuestasOk = vNewValue
   
End Property

Private Sub Class_Initialize()

   Dim mPrimerPaso As Boolean
   
   mRespuestasOk = ""
   mPrimerPaso = True
   
   'set up for Outlook mail operations
   On Error GoTo CI_Error
   Set m_oOLApp = GetObject(, "Outlook.Application")
Crear:
   If m_oOLApp Is Nothing Then
      Set m_oOLApp = CreateObject("Outlook.Application")
   End If
   Exit Sub
    
CI_Error:
   If Err.Number = 429 And mPrimerPaso Then
      mPrimerPaso = False
      GoTo Crear
   End If
   Err.Raise Err, "CEmailOL", "Startup/Logon failed"

End Sub

Private Sub Class_Terminate()
   
   'destroy objects that might be in use
   Set m_oOLApp = Nothing
   Set m_oOLGN = Nothing
   Set m_oOLFolder = Nothing
   Set m_oOLMailItem = Nothing

End Sub
