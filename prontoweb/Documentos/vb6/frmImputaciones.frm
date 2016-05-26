VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmImputaciones 
   Caption         =   "Carga de imputaciones de cuenta corriente "
   ClientHeight    =   4920
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10275
   Icon            =   "frmImputaciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4920
   ScaleWidth      =   10275
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   8100
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   4410
      Width           =   1230
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Volver"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   0
      Top             =   4410
      Width           =   1485
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4065
      Left            =   45
      TabIndex        =   1
      Top             =   270
      Width           =   10185
      _ExtentX        =   17965
      _ExtentY        =   7170
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmImputaciones.frx":076A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      DataField       =   "Observaciones"
      Height          =   420
      Left            =   9675
      TabIndex        =   3
      Top             =   4455
      Visible         =   0   'False
      Width           =   510
      _ExtentX        =   900
      _ExtentY        =   741
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmImputaciones.frx":0786
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total imputaciones :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   6
      Left            =   5940
      TabIndex        =   5
      Top             =   4455
      Width           =   2115
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3735
      TabIndex        =   2
      Top             =   45
      Width           =   2895
   End
End
Attribute VB_Name = "frmImputaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private mvarId As Long
Private mvarTipoCuenta As String, mvarMoneda As String
Private oAp As ComPronto.Aplicacion
Public oTab As ADOR.Recordset

Public Property Let TipoCuenta(ByVal vNewValue As String)

   mvarTipoCuenta = vNewValue

End Property

Public Property Let Moneda(ByVal vNewValue As String)

   mvarMoneda = vNewValue

End Property

Public Property Let Id(ByVal vNewValue As Long)

   mvarId = vNewValue

End Property

Private Sub cmd_Click(Index As Integer)

   Me.Hide
   
End Sub

Private Sub Form_Activate()

   Dim oRsTotales As ADOR.Recordset
   Dim Trs As Long, i As Long
   Dim Sdo As Double
   Dim mTransaccionesSaldoCero As String
         
   Lista.ListItems.Clear
   
   Set oRsTotales = CopiarEstructura(oTab)
   
   Sdo = 0
   mTransaccionesSaldoCero = ""
   
   With oTab
      If .RecordCount > 0 Then
         .MoveFirst
         Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value)
         Do While Not .EOF
            If Trs <> IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value) Then
               oRsTotales.AddNew
               oRsTotales.Fields("IdImputacion").Value = Trs
               oRsTotales.Fields("SaldoTrs").Value = Sdo
               oRsTotales.Update
               If Sdo = 0 Then mTransaccionesSaldoCero = mTransaccionesSaldoCero & Trs & "|"
               Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value)
               Sdo = 0
            End If
            Sdo = Sdo + IIf(IsNull(.Fields("Saldo Comp.").Value), 0, .Fields("Saldo Comp.").Value)
            If Not IsNull(.Fields("Observaciones").Value) Then
               rchObservaciones.TextRTF = .Fields("Observaciones").Value
               .Fields("Observaciones").Value = "" & rchObservaciones.Text
               .Update
            End If
            .MoveNext
         Loop
         oRsTotales.AddNew
         oRsTotales.Fields("IdImputacion").Value = Trs
         oRsTotales.Fields("SaldoTrs").Value = Sdo
         oRsTotales.Update
         If Sdo = 0 Then mTransaccionesSaldoCero = mTransaccionesSaldoCero & Trs & "|"
         
         oRsTotales.MoveFirst
         Do While Not oRsTotales.EOF
            .AddNew
            .Fields("IdImputacion").Value = oRsTotales.Fields("IdImputacion").Value
            .Fields("SaldoTrs").Value = oRsTotales.Fields("SaldoTrs").Value
            .Update
            oRsTotales.MoveNext
         Loop
         
         oRsTotales.Close
         Set oRsTotales = Nothing
         
         .Sort = "IdImputacion"
         BorraTransacciones oTab, mTransaccionesSaldoCero
      
         If oTab.RecordCount > 0 Then
            Lista.Sorted = False
            Set Lista.DataSource = oTab
         End If
      End If
   End With
   
         
End Sub

Private Sub Form_Load()

   Set oAp = Aplicacion
   
   Select Case mvarTipoCuenta
      Case "Deudores"
         If mvarMoneda = "Pesos" Then
            Set oTab = CopiarTodosLosRegistros(oAp.CtasCtesD.TraerFiltrado("ParaImputar", mvarId))
         Else
            Set oTab = CopiarTodosLosRegistros(oAp.CtasCtesD.TraerFiltrado("ParaImputar_Dolares", mvarId))
         End If
      Case "Acreedores"
         If mvarMoneda = "Pesos" Then
            Set oTab = CopiarTodosLosRegistros(oAp.CtasCtesA.TraerFiltrado("ParaImputar", mvarId))
         ElseIf mvarMoneda = "Dolares" Then
            Set oTab = CopiarTodosLosRegistros(oAp.CtasCtesA.TraerFiltrado("ParaImputar_Dolares", mvarId))
         Else
            Set oTab = CopiarTodosLosRegistros(oAp.CtasCtesA.TraerFiltrado("ParaImputar_Euros", mvarId))
         End If
   End Select
   
   Label1.Caption = "Expresado en " & mvarMoneda

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   oTab.Close
   Set oTab = Nothing
   Set oAp = Nothing
   
End Sub

Private Sub Lista_Click()

   If Not Lista.SelectedItem Is Nothing Then
      If Len(Trim(Lista.SelectedItem.Text)) <> 0 Then
         If Lista.SelectedItem.ListSubItems(7).Text = "*" Then
            Lista.SelectedItem.ListSubItems(7).Text = ""
         Else
            Lista.SelectedItem.ListSubItems(7).Text = "*"
         End If
         MostrarTotal
      End If
   End If

End Sub

Private Sub BorraTransacciones(ByRef oRs As ADOR.Recordset, ByVal TransaccionesABorrar As String)

   Dim i As Integer
   Dim mVectorTransaccionesABorrar
   
   mVectorTransaccionesABorrar = VBA.Split(TransaccionesABorrar, "|")
   
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            For i = 0 To UBound(mVectorTransaccionesABorrar)
               If IsNumeric(mVectorTransaccionesABorrar(i)) Then
                  If CLng(mVectorTransaccionesABorrar(i)) = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value) Then
                     .Delete
                     .Update
                     Exit For
                  End If
               End If
            Next
            .MoveNext
         Loop
         If .RecordCount > 0 Then .MoveFirst
      End If
   End With

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Public Sub MostrarTotal()

   Dim oL As ListItem
   Dim mTotal As Double
   
   mTotal = 0
   For Each oL In Lista.ListItems
      If oL.SubItems(7) = "*" Then
         If IsNumeric(oL.SubItems(5)) Then mTotal = mTotal + Val(oL.SubItems(5))
      End If
   Next
   txtTotal(0).Text = Format(mTotal, "#,##0.00")

End Sub
