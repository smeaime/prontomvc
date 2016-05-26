VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Object = "{F7D972E3-E925-4183-AB00-B6A253442139}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmImportarDATANET 
   Caption         =   "Importacion DATANET"
   ClientHeight    =   6960
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11835
   Icon            =   "frmImportarDATANET.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6960
   ScaleWidth      =   11835
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Grabar comprobantes"
      Enabled         =   0   'False
      Height          =   420
      Index           =   2
      Left            =   9900
      TabIndex        =   6
      Top             =   6030
      Width           =   1785
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1755
      TabIndex        =   4
      Top             =   6030
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Importar"
      Height          =   420
      Index           =   0
      Left            =   135
      TabIndex        =   3
      Top             =   6030
      Width           =   1470
   End
   Begin Controles1013.DbListView Lista 
      Height          =   5235
      Left            =   90
      TabIndex        =   0
      Top             =   675
      Width           =   11625
      _ExtentX        =   20505
      _ExtentY        =   9234
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmImportarDATANET.frx":076A
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   2475
      TabIndex        =   1
      Top             =   135
      Width           =   5595
      _ExtentX        =   9869
      _ExtentY        =   582
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   5
      Top             =   6570
      Width           =   11835
      _ExtentX        =   20876
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   8
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   7673
            MinWidth        =   5292
            Picture         =   "frmImportarDATANET.frx":0786
            Key             =   "Estado"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   900
            MinWidth        =   18
            TextSave        =   "CAPS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Object.Width           =   820
            MinWidth        =   18
            TextSave        =   "NUM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel7 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "01/09/2008"
            Key             =   "Fecha"
         EndProperty
         BeginProperty Panel8 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            AutoSize        =   2
            Object.Width           =   1482
            MinWidth        =   19
            TextSave        =   "10:42 a.m."
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   8370
      Top             =   5940
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmImportarDATANET.frx":0AA0
            Key             =   "Ok"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmImportarDATANET.frx":0DBA
            Key             =   "Error"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmImportarDATANET.frx":10D4
            Key             =   "Nada"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmImportarDATANET.frx":13EE
            Key             =   "Procesado"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Archivo Excel de importacion : "
      Height          =   255
      Index           =   0
      Left            =   135
      TabIndex        =   2
      Top             =   180
      Width           =   2220
   End
End
Attribute VB_Name = "frmImportarDATANET"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsVal As ADOR.Recordset
   Dim fl As Integer
   
   Select Case Index
      
      Case 0
         
         Dim oEx As Excel.Application
         Dim mVector_X, mVector_T As String
         Dim mIdProveedor As Long
         
         Set oAp = Aplicacion
         
         Set oRs = CreateObject("ADOR.Recordset")
         With oRs
            .Fields.Append "Id", adInteger, , adFldIsNullable
            .Fields.Append "Tipo", adVarChar, 10, adFldIsNullable
            .Fields.Append "Numero", adInteger, , adFldIsNullable
            .Fields.Append "Orden pago", adVarChar, 20, adFldIsNullable
            .Fields.Append "Fecha vto.", adDate, , adFldIsNullable
            .Fields.Append "Fecha entrada", adDate, , adFldIsNullable
            .Fields.Append "Importe", adDouble, , adFldIsNullable
            .Fields.Append "IdBanco", adInteger, , adFldIsNullable
            .Fields.Append "Banco", adVarChar, 50, adFldIsNullable
            .Fields.Append "Proveedor", adVarChar, 50, adFldIsNullable
            .Fields.Append "Observaciones", adVarChar, 50, adFldIsNullable
            .Fields.Append "Vector_T", adVarChar, 50
            .Fields.Append "Vector_X", adVarChar, 50
         End With
         oRs.Open
         
         fl = 2
         mVector_X = "0111111111133"
         mVector_T = "0555555555500"
         
         Set oEx = CreateObject("Excel.Application")
         With oEx
            .Visible = True
            .WindowState = xlMinimized
            Me.Refresh
            With .Workbooks.Open(FileBrowser1(0).Text)
               With .ActiveSheet
                  Do While True
                     If Len(Trim(.Cells(fl, 1))) > 0 Then
                        If Len(.Cells(fl, 4)) > 0 Then
                           Set oRsVal = oAp.Valores.TraerFiltrado("_PorNumero", CLng(.Cells(fl, 4)))
                           If oRsVal.RecordCount > 0 Then
                              If IsNull(oRsVal.Fields("FechaEntrada").Value) Then
                                 oRs.AddNew
                                 oRs.Fields("Tipo").Value = "EGRESO"
                                 oRs.Fields("Numero").Value = CLng(.Cells(fl, 4))
                                 oRs.Fields("Id").Value = oRsVal.Fields(0).Value
                                 oRs.Fields("Orden pago").Value = oRsVal.Fields("NumeroOrdenPago").Value
                                 oRs.Fields("Fecha vto.").Value = oRsVal.Fields("FechaValor").Value
                                 oRs.Fields("Fecha entrada").Value = CDate(.Cells(fl, 2))
                                 oRs.Fields("Importe").Value = oRsVal.Fields("Importe").Value
                                 oRs.Fields("Proveedor").Value = oRsVal.Fields("Proveedor").Value
                                 oRs.Fields("Banco").Value = oRsVal.Fields("Banco").Value
                                 oRs.Fields("Vector_T").Value = mVector_T
                                 oRs.Fields("Vector_X").Value = mVector_X
                                 oRs.Fields("Observaciones").Value = .Cells(fl, 3)
                                 oRs.Update
                              End If
                           End If
                           oRsVal.Close
                        Else
'                           If CDbl(.Cells(fl, 7)) > 0 Then
'                              Set oRsVal = oAp.Bancos.TraerFiltrado("_Busca1", .Cells(fl, 9))
'                              oRs.AddNew
'                              oRs.Fields("Tipo").Value = "INGRESO"
'                              oRs.Fields("Numero").Value = Null
'                              oRs.Fields("Id").Value = Null
'                              oRs.Fields("Orden pago").Value = Null
'                              oRs.Fields("Fecha emision").Value = Null
'                              oRs.Fields("Fecha vto.").Value = Null
'                              oRs.Fields("Fecha entrada").Value = CDate(.Cells(fl, 2))
'                              oRs.Fields("Importe").Value = CDbl(.Cells(fl, 7))
'                              oRs.Fields("Proveedor").Value = Null
'                              oRs.Fields("Numero SAP").Value = Null
'                              oRs.Fields("Rubro").Value = Null
'                              oRs.Fields("Banco").Value = .Cells(fl, 9)
'                              oRs.Fields("Observaciones").Value = .Cells(fl, 3)
'                              oRs.Fields("Vector_T").Value = mVector_T
'                              oRs.Fields("Vector_X").Value = mVector_X
'                              If oRsVal.RecordCount > 0 Then
'                                 oRs.Fields("IdBanco").Value = oRsVal.Fields(0).Value
'                              End If
'                              oRs.Update
'                              oRsVal.Close
'                           End If
                        End If
                        fl = fl + 1
                        StatusBar1.Panels(1).Text = " Procesando fila " & fl
                     Else
                        Exit Do
                     End If
                  Loop
               End With
               .Close False
            End With
            .Quit
         End With
         Set oEx = Nothing

         Dim oPar As ComPronto.Parametro
         Set oPar = oAp.Parametros.Item(1)
         oPar.Registro.Fields("PathArchivoExcelDATANET").Value = FileBrowser1(0).Text
         oPar.Guardar
         Set oPar = Nothing
         
         cmd(0).Enabled = False
         cmd(2).Enabled = True
         
         Lista.IconoGrande = "Nada"
         Lista.IconoPequeño = "Nada"
         Set Lista.DataSource = oRs
         
         StatusBar1.Panels(1).Text = " " & Lista.ListItems.Count & " elementos en la lista"
         
         Set oRs = Nothing
         Set oRsVal = Nothing
         Set oAp = Nothing
      
      Case 1
      
         Unload Me
   
      Case 2
      
         Dim oL As ListItem
         Dim oValor As ComPronto.Valor
'         Dim oValorIngreso As ComPronto.ValorIngreso
         
         Set oAp = Aplicacion
         
         fl = 1
         For Each oL In Lista.ListItems
            StatusBar1.Panels(1).Text = " Procesando registro " & fl & " de " & Lista.ListItems.Count
            Select Case oL.Text
               Case "EGRESO"
                  If Len(oL.SubItems(5)) <> 0 Then
                     Set oValor = oAp.Valores.Item(oL.Tag)
                     With oValor.Registro
                        .Fields("FechaEntrada").Value = CDate(oL.SubItems(5))
                        .Fields("FechaEntradaActivada").Value = "SI"
                     End With
                     oValor.Guardar
                     Set oValor = Nothing
                     oL.SmallIcon = "Ok"
                  Else
                     oL.SmallIcon = "Error"
                  End If
                  oL.ToolTipText = oL.SmallIcon
                  fl = fl + 1
               Case "INGRESO"
'                  If oL.SubItems(7) = "" Then
'                     MsgBox "Verifique la planilla de bajada de datos, trae un banco inexistente" & vbCrLf & _
'                              "el proceso sera detenido", vbCritical
'                     GoTo Salida
'                  Else
'                     Set oRs = oAp.ValoresIngresos.TraerFiltrado("_PorDatos", Array(CDate(oL.SubItems(5)), CDbl(oL.SubItems(6))))
'                     If oRs.RecordCount = 0 Then
'                        Set oValorIngreso = oAp.ValoresIngresos.Item(-1)
'                        With oValorIngreso.Registro
'                           .Fields("FechaIngreso").Value = CDate(oL.SubItems(5))
'                           .Fields("IdBanco").Value = CLng(oL.SubItems(7))
'                           .Fields("Observaciones").Value = oL.SubItems(12)
'                           .Fields("Importe").Value = CDbl(oL.SubItems(6))
'                        End With
'                        oValorIngreso.Guardar
'                        Set oValorIngreso = Nothing
'                        oL.SmallIcon = "Ok"
'                     End If
'                     oRs.Close
'                     fl = fl + 1
'                  End If
            End Select
         Next
         
         cmd(1).Caption = "Salir"
   
   End Select
   
Salida:

   Set oRs = Nothing
   Set oAp = Nothing
   Set oEx = Nothing
   
   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error de procesamiento" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
   End If
   
End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Nada"
   End With
   
   With StatusBar1.Panels
      .Item(2).Text = "Procesado"
      .Item(2).Picture = Img16.ListImages.Item(1).Picture
      .Item(3).Text = "Con error"
      .Item(3).Picture = Img16.ListImages.Item(2).Picture
      .Item(4).Text = "Existente"
      .Item(4).Picture = Img16.ListImages.Item(4).Picture
   End With

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Parametros.Item(1).Registro
   If Not IsNull(oRs.Fields("PathArchivoExcelDATANET").Value) Then
      FileBrowser1(0).Text = oRs.Fields("PathArchivoExcelDATANET").Value
   End If
   oRs.Close
   Set oRs = Nothing

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub
