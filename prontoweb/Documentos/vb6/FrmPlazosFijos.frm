VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form FrmPlazosFijos 
   Caption         =   "Plazos fijos"
   ClientHeight    =   5460
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12015
   Icon            =   "FrmPlazosFijos.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   5460
   ScaleWidth      =   12015
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check3 
      Caption         =   "Acreditar intereses al finalizar el plazo fijo"
      Height          =   195
      Left            =   3915
      TabIndex        =   60
      Top             =   3150
      Width           =   3210
   End
   Begin VB.TextBox txtRetencionGanancia 
      Alignment       =   1  'Right Justify
      DataField       =   "RetencionGanancia"
      Height          =   285
      Left            =   2430
      TabIndex        =   14
      Top             =   3105
      Width           =   1350
   End
   Begin VB.Frame Frame2 
      Height          =   375
      Left            =   5760
      TabIndex        =   55
      Top             =   3420
      Width           =   1905
      Begin VB.OptionButton Option3 
         Caption         =   "Caja"
         Height          =   195
         Left            =   90
         TabIndex        =   57
         Top             =   135
         Width           =   735
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Banco"
         Height          =   195
         Left            =   945
         TabIndex        =   56
         Top             =   135
         Width           =   825
      End
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Left            =   2475
      TabIndex        =   50
      Top             =   540
      Width           =   1905
      Begin VB.OptionButton Option2 
         Caption         =   "Banco"
         Height          =   195
         Left            =   945
         TabIndex        =   52
         Top             =   135
         Width           =   825
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Caja"
         Height          =   195
         Left            =   90
         TabIndex        =   51
         Top             =   135
         Width           =   735
      End
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Marca de finalizacion del plazo fijo"
      Height          =   195
      Left            =   9045
      TabIndex        =   47
      Top             =   3150
      Width           =   2850
   End
   Begin VB.TextBox txtCotizacionMonedaAlFinal 
      Alignment       =   1  'Right Justify
      DataField       =   "CotizacionMonedaAlFinal"
      Height          =   285
      Left            =   10890
      TabIndex        =   43
      Top             =   2745
      Width           =   1035
   End
   Begin VB.TextBox txtCotizacionMonedaAlInicio 
      Alignment       =   1  'Right Justify
      DataField       =   "CotizacionMonedaAlInicio"
      Height          =   285
      Left            =   8190
      TabIndex        =   41
      Top             =   2745
      Width           =   1035
   End
   Begin VB.CheckBox Check1 
      Height          =   195
      Left            =   6255
      TabIndex        =   38
      Top             =   990
      Width           =   195
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
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
      Left            =   2430
      TabIndex        =   32
      Top             =   3465
      Width           =   1350
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      Height          =   285
      Left            =   8190
      TabIndex        =   5
      Top             =   1665
      Width           =   3720
   End
   Begin VB.TextBox txtOrden 
      DataField       =   "Orden"
      Height          =   285
      Left            =   8190
      TabIndex        =   3
      Top             =   1305
      Width           =   3720
   End
   Begin VB.TextBox txtImporteIntereses 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteIntereses"
      Height          =   285
      Left            =   2430
      TabIndex        =   13
      Top             =   2745
      Width           =   1350
   End
   Begin VB.TextBox txtImporte 
      Alignment       =   1  'Right Justify
      DataField       =   "Importe"
      Height          =   285
      Left            =   2430
      TabIndex        =   12
      Top             =   2385
      Width           =   1350
   End
   Begin VB.TextBox txtTasaEfectivaMensual 
      Alignment       =   1  'Right Justify
      DataField       =   "TasaEfectivaMensual"
      Height          =   285
      Left            =   8190
      TabIndex        =   11
      Top             =   2385
      Width           =   810
   End
   Begin VB.TextBox txtTasaNominalAnual 
      Alignment       =   1  'Right Justify
      DataField       =   "TasaNominalAnual"
      Height          =   285
      Left            =   5400
      TabIndex        =   10
      Top             =   2385
      Width           =   765
   End
   Begin VB.TextBox txtPlazoEnDias 
      Alignment       =   1  'Right Justify
      DataField       =   "PlazoEnDias"
      Height          =   285
      Left            =   5400
      TabIndex        =   6
      Top             =   2025
      Width           =   765
   End
   Begin VB.TextBox txtCodigoClase 
      Alignment       =   1  'Right Justify
      DataField       =   "CodigoClase"
      Height          =   285
      Left            =   10845
      TabIndex        =   8
      Top             =   2025
      Width           =   1080
   End
   Begin VB.TextBox txtCodigoDeposito 
      Alignment       =   1  'Right Justify
      DataField       =   "CodigoDeposito"
      Height          =   285
      Left            =   8190
      TabIndex        =   7
      Top             =   2025
      Width           =   810
   End
   Begin VB.TextBox txtTitulares 
      DataField       =   "Titulares"
      Height          =   285
      Left            =   2430
      TabIndex        =   4
      Top             =   1665
      Width           =   3720
   End
   Begin VB.TextBox txtDireccionEmisionYPago 
      DataField       =   "DireccionEmisionYPago"
      Height          =   285
      Left            =   2430
      TabIndex        =   2
      Top             =   1305
      Width           =   3720
   End
   Begin VB.TextBox txtNumeroCertificado1 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCertificado1"
      Height          =   285
      Left            =   2430
      TabIndex        =   1
      Top             =   945
      Width           =   1575
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Anular"
      Height          =   405
      Index           =   1
      Left            =   135
      TabIndex        =   16
      Top             =   4410
      Width           =   1170
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   135
      TabIndex        =   17
      Top             =   4905
      Width           =   1170
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   15
      Top             =   3915
      Width           =   1170
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdBanco"
      Height          =   315
      Index           =   0
      Left            =   2430
      TabIndex        =   0
      Tag             =   "Bancos"
      Top             =   225
      Width           =   3720
      _ExtentX        =   6562
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdBanco"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaVencimiento"
      Height          =   285
      Index           =   0
      Left            =   2430
      TabIndex        =   9
      Top             =   2025
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   59834369
      CurrentDate     =   36432
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1365
      Left            =   1485
      TabIndex        =   34
      Top             =   4050
      Width           =   10455
      _ExtentX        =   18441
      _ExtentY        =   2408
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "FrmPlazosFijos.frx":076A
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdPlazoFijoOrigen"
      Height          =   315
      Index           =   1
      Left            =   6480
      TabIndex        =   37
      Tag             =   "PlazosFijos"
      Top             =   945
      Width           =   5430
      _ExtentX        =   9578
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPlazoFijo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMoneda"
      Height          =   315
      Index           =   2
      Left            =   4695
      TabIndex        =   39
      Tag             =   "Monedas"
      Top             =   2745
      Width           =   1470
      _ExtentX        =   2593
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaInicioPlazoFijo"
      Height          =   285
      Index           =   1
      Left            =   8550
      TabIndex        =   45
      Top             =   180
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   59834369
      CurrentDate     =   36432
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   4500
      TabIndex        =   48
      Top             =   585
      Width           =   7410
      _ExtentX        =   13070
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   4
      Left            =   7740
      TabIndex        =   53
      Top             =   3465
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "ANULADO"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   9945
      TabIndex        =   59
      Top             =   135
      Visible         =   0   'False
      Width           =   1950
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Importe retencion ganancias :"
      Height          =   285
      Index           =   18
      Left            =   135
      TabIndex        =   58
      Top             =   3105
      Width           =   2130
   End
   Begin VB.Label lblData 
      Caption         =   "Destino de los fondos :"
      Height          =   285
      Index           =   4
      Left            =   3915
      TabIndex        =   54
      Top             =   3510
      Width           =   1770
   End
   Begin VB.Label lblData 
      Caption         =   "Origen de los fondos :"
      Height          =   240
      Index           =   3
      Left            =   135
      TabIndex        =   49
      Top             =   630
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha de inicio del plazo fijo :"
      Height          =   240
      Index           =   17
      Left            =   6255
      TabIndex        =   46
      Top             =   225
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cotizacion al final :"
      Height          =   285
      Index           =   16
      Left            =   9405
      TabIndex        =   44
      Top             =   2760
      Width           =   1410
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cotizacion al inicio :"
      Height          =   285
      Index           =   15
      Left            =   6345
      TabIndex        =   42
      Top             =   2760
      Width           =   1725
   End
   Begin VB.Label lblData 
      Caption         =   "Moneda :"
      Height          =   240
      Index           =   1
      Left            =   3915
      TabIndex        =   40
      Top             =   2790
      Width           =   690
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Plazo fijo original :"
      Height          =   240
      Index           =   14
      Left            =   4770
      TabIndex        =   36
      Top             =   990
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Trasabilidad :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   13
      Left            =   1530
      TabIndex        =   35
      Top             =   3870
      Width           =   1230
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Importe total : "
      Height          =   285
      Index           =   12
      Left            =   135
      TabIndex        =   33
      Top             =   3480
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Detalle : "
      Height          =   285
      Index           =   11
      Left            =   6345
      TabIndex        =   31
      Top             =   1680
      Width           =   1725
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Orden : "
      Height          =   285
      Index           =   10
      Left            =   6345
      TabIndex        =   30
      Top             =   1320
      Width           =   1725
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Importe intereses : "
      Height          =   285
      Index           =   9
      Left            =   135
      TabIndex        =   29
      Top             =   2745
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Index           =   21
      Left            =   135
      TabIndex        =   28
      Top             =   2070
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Importe capital : "
      Height          =   285
      Index           =   8
      Left            =   135
      TabIndex        =   27
      Top             =   2400
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Tasa efectiva mensual : "
      Height          =   285
      Index           =   7
      Left            =   6345
      TabIndex        =   26
      Top             =   2400
      Width           =   1725
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Tasa nominal anual : "
      Height          =   285
      Index           =   6
      Left            =   3870
      TabIndex        =   25
      Top             =   2400
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Plazo en dias : "
      Height          =   285
      Index           =   5
      Left            =   3870
      TabIndex        =   24
      Top             =   2040
      Width           =   1455
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo de clase :"
      Height          =   240
      Index           =   4
      Left            =   9405
      TabIndex        =   23
      Top             =   2070
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo de deposito :"
      Height          =   285
      Index           =   3
      Left            =   6345
      TabIndex        =   22
      Top             =   2040
      Width           =   1725
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Titulares : "
      Height          =   285
      Index           =   2
      Left            =   135
      TabIndex        =   21
      Top             =   1680
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Direccion emision / pago :"
      Height          =   285
      Index           =   0
      Left            =   135
      TabIndex        =   20
      Top             =   1320
      Width           =   2130
   End
   Begin VB.Label lblData 
      Caption         =   "Banco : "
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   19
      Top             =   270
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Numero certificado : "
      Height          =   285
      Index           =   1
      Left            =   135
      TabIndex        =   18
      Top             =   960
      Width           =   2130
   End
End
Attribute VB_Name = "FrmPlazosFijos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.PlazoFijo
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mvarIdMonedaPesos As Long, mvarIdMonedaDolar As Long
Dim actL2 As ControlForm
Private mNivelAcceso As Integer, mOpcionesAcceso As String

Public Property Let NivelAcceso(ByVal mNivelA As EnumAccesos)
   
   mNivelAcceso = mNivelA
   
End Property

Public Property Get NivelAcceso() As EnumAccesos

   NivelAcceso = mNivelAcceso
   
End Property

Public Property Let OpcionesAcceso(ByVal mOpcionesA As String)
   
   mOpcionesAcceso = mOpcionesA
   
End Property

Public Property Get OpcionesAcceso() As String

   OpcionesAcceso = mOpcionesAcceso
   
End Property

Private Sub Check1_Click()

   If Check1.Value = 0 Then
      origen.Registro.Fields("IdPlazoFijoOrigen").Value = Null
   End If

End Sub

Private Sub Check2_Click()

   If Check2.Value = 1 Then
      If DataCombo1(2).BoundText = mvarIdMonedaPesos Then
         txtCotizacionMonedaAlFinal.Text = 1
      Else
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTPicker1(0).Value, DataCombo1(2).BoundText))
         If oRs.RecordCount > 0 Then
            txtCotizacionMonedaAlFinal.Text = oRs.Fields("CotizacionLibre").Value
         Else
            MsgBox "No hay cotizacion, ingresela manualmente"
            txtCotizacionMonedaAlFinal.Text = ""
         End If
         oRs.Close
         Set oRs = Nothing
      End If
      Frame2.Enabled = True
      DataCombo1(4).Enabled = True
   Else
      Frame2.Enabled = False
      With origen.Registro
         .Fields("IdCajaDestino").Value = Null
         .Fields("IdCuentaBancariaDestino").Value = Null
      End With
      With DataCombo1(4)
         .Text = ""
         .Enabled = False
      End With
      Option3.Value = False
      Option4.Value = False
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar el banco", vbExclamation
            Exit Sub
         End If
         
         If Len(txtNumeroCertificado1.Text) = 0 Then
            MsgBox "Debe indicar el numero de certificado", vbExclamation
            Exit Sub
         End If
         
         If Len(txtCotizacionMonedaAlInicio.Text) = 0 Then
            MsgBox "Debe indicar la cotizacion de la moneda al inicio del plazo fijo", vbExclamation
            Exit Sub
         End If
         
         If Check2.Value = 1 And Len(txtCotizacionMonedaAlFinal.Text) = 0 Then
            MsgBox "Debe indicar la cotizacion de la moneda al final del plazo fijo", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(2).BoundText) Then
            MsgBox "Ingrese la moneda", vbExclamation
            Exit Sub
         End If
         
         If Not CambioDeMonedaValido(DataCombo1(2).BoundText) Then
            MsgBox "La moneda del plazo fijo no coincide con la del origen/destino de los fondos, revise los datos"
            Exit Sub
         End If
         
         If DTPicker1(1).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTPicker1(1).Value) Then
            MsgBox "La fecha de inicio no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         If DTPicker1(0).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTPicker1(0).Value) Then
            MsgBox "La fecha de finalizacion no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If
         
         If Val(txtTotal) = 0 Then
            MsgBox "El total no puede ser cero", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim oRs As ADOR.Recordset
         
         Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
         With oRs
            If IIf(IsNull(.Fields("IdCuentaPlazosFijos").Value), 0, .Fields("IdCuentaPlazosFijos").Value) = 0 Then
               MsgBox "No esta definida la cuenta contable para plazos fijos en los parametros generales", vbExclamation
               Set oRs = Nothing
               Exit Sub
            End If
            If IIf(IsNull(.Fields("IdCuentaInteresesPlazosFijos").Value), 0, .Fields("IdCuentaInteresesPlazosFijos").Value) = 0 Then
               MsgBox "No esta definida la cuenta contable para los intereses ganados en los parametros generales", vbExclamation
               Set oRs = Nothing
               Exit Sub
            End If
            If IIf(IsNull(.Fields("IdCuentaRetencionGananciasCobros").Value), 0, .Fields("IdCuentaRetencionGananciasCobros").Value) = 0 Then
               MsgBox "No esta definida la cuenta contable para las retenciones a las ganancias" & vbCrLf & _
                      "a los plazos fijos en los parametros generales", vbExclamation
               Set oRs = Nothing
               Exit Sub
            End If
         End With
         oRs.Close
      
         With origen.Registro
            For Each dtp In DTPicker1
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            
            For Each dc In DataCombo1
               If dc.Enabled Then
                  If Not IsNumeric(dc.BoundText) And dc.Index <> 1 Then
                     MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                     Exit Sub
                  End If
                  If IsNumeric(dc.BoundText) Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            
            If Check2.Value = 1 Then
               .Fields("Finalizado").Value = "SI"
            Else
               .Fields("Finalizado").Value = "NO"
            End If
            If Check3.Value = 1 Then
               .Fields("AcreditarInteresesAlFinalizar").Value = "SI"
            Else
               .Fields("AcreditarInteresesAlFinalizar").Value = "NO"
            End If
         End With
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "PlazosFijosTodos,PlazosFijosAVencer,PlazosFijosVencidos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
   
         AnularPlazoFijo
         
         est = Modificacion
            
         With actL2
            .ListaEditada = "PlazosFijosTodos,PlazosFijosAVencer,PlazosFijosVencidos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me

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
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.PlazosFijos.Item(vnewvalue)
   Set oBind = New BindingCollection
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
      mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
'               If oControl.Tag = "Bancos" Then
'                  Set oControl.RowSource = oAp.Bancos.TraerFiltrado("_ConCuenta")
'               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
'               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
      
   End With
   
   If mvarId < 0 Then
      With origen.Registro
         .Fields("FechaInicioPlazoFijo").Value = Date
         .Fields("FechaVencimiento").Value = Date + 30
         .Fields("IdMoneda").Value = mvarIdMonedaPesos
      End With
      DTPicker1(0).Value = Date + 30
      DTPicker1(1).Value = Date
      Check2.Value = 0
      Check3.Value = 1
      Frame2.Enabled = False
      DataCombo1(4).Enabled = False
      cmd(1).Enabled = False
   Else
      CalcularTotal
      With origen.Registro
         If Not IsNull(.Fields("IdPlazoFijoOrigen").Value) Then
            Check1.Value = 1
            Set Lista.DataSource = TrasabilidadPlazosFijos(.Fields("IdPlazoFijoOrigen").Value)
         End If
         If Not IsNull(.Fields("IdCajaOrigen").Value) Then
            Option1.Value = True
         ElseIf Not IsNull(.Fields("IdCuentaBancariaOrigen").Value) Then
            Option2.Value = True
         End If
         If Not IsNull(.Fields("Finalizado").Value) And .Fields("Finalizado").Value = "SI" Then
            Check2.Value = 1
            Frame2.Enabled = True
            DataCombo1(4).Enabled = True
            If Not IsNull(.Fields("IdCajaDestino").Value) Then
               Option3.Value = True
            ElseIf Not IsNull(.Fields("IdCuentaBancariaDestino").Value) Then
               Option4.Value = True
            End If
         Else
            Check2.Value = 0
            Frame2.Enabled = False
            DataCombo1(4).Enabled = False
         End If
         If Not IsNull(.Fields("AcreditarInteresesAlFinalizar").Value) And _
               .Fields("AcreditarInteresesAlFinalizar").Value = "SI" Then
            Check3.Value = 1
         End If
      End With
   End If

   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   If mvarId > 0 And origen.Registro.Fields("FechaInicioPlazoFijo").Value <= gblFechaUltimoCierre Then
      DataCombo1(0).Enabled = False
      DataCombo1(2).Enabled = False
      Frame1.Enabled = False
      DTPicker1(1).Enabled = False
      txtImporte.Enabled = False
      txtCotizacionMonedaAlInicio.Enabled = False
      If Not IsNull(origen.Registro.Fields("Finalizado").Value) And _
            origen.Registro.Fields("Finalizado").Value = "SI" And _
            origen.Registro.Fields("FechaVencimiento").Value <= gblFechaUltimoCierre Then
         DTPicker1(0).Enabled = False
         txtImporteIntereses.Enabled = False
         txtRetencionGanancia.Enabled = False
         txtPlazoEnDias.Enabled = False
         txtTasaNominalAnual.Enabled = False
         txtCotizacionMonedaAlFinal.Enabled = False
         Check2.Enabled = False
         Frame2.Enabled = False
         DataCombo1(4).Enabled = False
      End If
   End If
   
   If mvarId > 0 And Not IsNull(origen.Registro.Fields("Anulado").Value) And _
         origen.Registro.Fields("Anulado").Value = "SI" Then
      cmd(1).Enabled = False
      cmd(0).Enabled = False
      lblEstado.Visible = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
      origen.Registro.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
      Select Case Index
         Case 1
            Check1.Value = 1
         Case 2
            If DataCombo1(Index).BoundText = mvarIdMonedaPesos Then
               txtCotizacionMonedaAlInicio.Text = 1
            Else
               Dim oRs As ADOR.Recordset
               Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(DTPicker1(1).Value, DataCombo1(Index).BoundText))
               If oRs.RecordCount > 0 Then
                  txtCotizacionMonedaAlInicio.Text = oRs.Fields("CotizacionLibre").Value
               Else
                  MsgBox "No hay cotizacion, ingresela manualmente"
                  txtCotizacionMonedaAlInicio.Text = ""
               End If
               oRs.Close
               Set oRs = Nothing
            End If
      End Select
   End If

End Sub

Private Sub DTPicker1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTPicker1(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      KeyAscii = 0
      SendKeys "{TAB}", True
   End If

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      Dim oRs As ADOR.Recordset
      Dim mIdCaja As Integer
      mIdCaja = IIf(IsNull(origen.Registro.Fields("IdCajaOrigen").Value), 0, origen.Registro.Fields("IdCajaOrigen").Value)
      With DataCombo1(3)
         Set .RowSource = Nothing
         .Text = ""
         .BoundColumn = "IdCaja"
         .DataField = "IdCajaOrigen"
         If IsNumeric(DataCombo1(2).BoundText) Then
            Set oRs = Aplicacion.Cajas.TraerFiltrado("_PorIdMoneda", DataCombo1(2).BoundText)
         Else
            Set oRs = Aplicacion.Cajas.TraerLista
         End If
         If oRs.RecordCount = 1 And mIdCaja = 0 Then
            mIdCaja = oRs.Fields(0).Value
         End If
         Set .RowSource = oRs
         .BoundText = mIdCaja
      End With
      origen.Registro.Fields("IdCuentaBancariaOrigen").Value = Null
      Set oRs = Nothing
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Dim oRs As ADOR.Recordset
      Dim mIdCuentaBancaria As Integer
      mIdCuentaBancaria = IIf(IsNull(origen.Registro.Fields("IdCuentaBancariaOrigen").Value), 0, origen.Registro.Fields("IdCuentaBancariaOrigen").Value)
      With DataCombo1(3)
         Set .RowSource = Nothing
         .Text = ""
         .BoundColumn = "IdCuentaBancaria"
         .DataField = "IdCuentaBancariaOrigen"
         If IsNumeric(DataCombo1(2).BoundText) Then
            Set oRs = Aplicacion.Bancos.TraerFiltrado("_PorCuentasBancariasIdMoneda", DataCombo1(2).BoundText)
         Else
            Set oRs = Aplicacion.Bancos.TraerFiltrado("_ConCuenta")
         End If
         If oRs.RecordCount = 1 And mIdCuentaBancaria = 0 Then
            mIdCuentaBancaria = oRs.Fields(0).Value
         End If
         Set .RowSource = oRs
         .BoundText = mIdCuentaBancaria
      End With
      origen.Registro.Fields("IdCajaOrigen").Value = Null
   End If

End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      Dim oRs As ADOR.Recordset
      Dim mIdCaja As Integer
      mIdCaja = IIf(IsNull(origen.Registro.Fields("IdCajaDestino").Value), 0, origen.Registro.Fields("IdCajaDestino").Value)
      With DataCombo1(4)
         Set .RowSource = Nothing
         .Text = ""
         .BoundColumn = "IdCaja"
         .DataField = "IdCajaDestino"
         If IsNumeric(DataCombo1(2).BoundText) Then
            Set oRs = Aplicacion.Cajas.TraerFiltrado("_PorIdMoneda", DataCombo1(2).BoundText)
         Else
            Set oRs = Aplicacion.Cajas.TraerLista
         End If
         If oRs.RecordCount = 1 And mIdCaja = 0 Then
            mIdCaja = oRs.Fields(0).Value
         End If
         Set .RowSource = oRs
         .BoundText = mIdCaja
      End With
      origen.Registro.Fields("IdCuentaBancariaDestino").Value = Null
      Set oRs = Nothing
   End If

End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      Dim oRs As ADOR.Recordset
      Dim mIdCuentaBancaria As Integer
      mIdCuentaBancaria = IIf(IsNull(origen.Registro.Fields("IdCuentaBancariaDestino").Value), 0, origen.Registro.Fields("IdCuentaBancariaDestino").Value)
      With DataCombo1(4)
         Set .RowSource = Nothing
         .Text = ""
         .BoundColumn = "IdCuentaBancaria"
         .DataField = "IdCuentaBancariaDestino"
         If IsNumeric(DataCombo1(2).BoundText) Then
            Set oRs = Aplicacion.Bancos.TraerFiltrado("_PorCuentasBancariasIdMoneda", DataCombo1(2).BoundText)
         Else
            Set oRs = Aplicacion.Bancos.TraerFiltrado("_ConCuenta")
         End If
         If oRs.RecordCount = 1 And mIdCuentaBancaria = 0 Then
            mIdCuentaBancaria = oRs.Fields(0).Value
         End If
         Set .RowSource = oRs
         .BoundText = mIdCuentaBancaria
      End With
      origen.Registro.Fields("IdCajaDestino").Value = Null
   End If

End Sub

Private Sub txtCodigoClase_GotFocus()

   With txtCodigoClase
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoDeposito_GotFocus()

   With txtCodigoDeposito
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionMonedaAlFinal_GotFocus()

   With txtCotizacionMonedaAlFinal
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionMonedaAlInicio_GotFocus()

   With txtCotizacionMonedaAlInicio
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDireccionEmisionYPago_GotFocus()

   With txtDireccionEmisionYPago
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporte_Change()

   CalcularTotal
   
End Sub

Private Sub txtImporte_GotFocus()

   With txtImporte
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporteIntereses_Change()

   CalcularTotal
   
End Sub

Private Sub txtImporteIntereses_GotFocus()

   With txtImporteIntereses
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCertificado1_GotFocus()

   With txtNumeroCertificado1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOrden_GotFocus()

   With txtOrden
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPlazoEnDias_GotFocus()

   With txtPlazoEnDias
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRetencionGanancia_Change()

   CalcularTotal
   
End Sub

Private Sub txtRetencionGanancia_GotFocus()

   With txtRetencionGanancia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTasaEfectivaMensual_GotFocus()

   With txtTasaEfectivaMensual
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTasaNominalAnual_GotFocus()

   With txtTasaNominalAnual
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTitulares_GotFocus()

   With txtTitulares
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
End Sub

Public Sub CalcularTotal()

   txtTotal.Text = Val(txtImporte.Text) - Val(txtRetencionGanancia.Text) + Val(txtImporteIntereses.Text)

End Sub

Public Function CambioDeMonedaValido(ByVal IdMoneda As Long) As Boolean

   Dim oRs As ADOR.Recordset
   Dim mCambioDeMoneda As Boolean
   
   mCambioDeMoneda = True
   
   If IsNumeric(DataCombo1(3).BoundText) Then
      If Option1.Value Then
         Set oRs = Aplicacion.Cajas.TraerFiltrado("_PorId", DataCombo1(3).BoundText)
         If oRs.RecordCount > 0 Then
            If oRs.Fields("IdMoneda").Value <> IdMoneda Then
               mCambioDeMoneda = False
            End If
         End If
         oRs.Close
      ElseIf Option2.Value Then
         Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorId", DataCombo1(3).BoundText)
         If oRs.RecordCount > 0 Then
            If oRs.Fields("IdMoneda").Value <> IdMoneda Then
               mCambioDeMoneda = False
            End If
         End If
         oRs.Close
      End If
   End If
   
   If IsNumeric(DataCombo1(4).BoundText) Then
      If Option3.Value Then
         Set oRs = Aplicacion.Cajas.TraerFiltrado("_PorId", DataCombo1(4).BoundText)
         If oRs.RecordCount > 0 Then
            If oRs.Fields("IdMoneda").Value <> IdMoneda Then
               mCambioDeMoneda = False
            End If
         End If
         oRs.Close
      ElseIf Option4.Value Then
         Set oRs = Aplicacion.CuentasBancarias.TraerFiltrado("_PorId", DataCombo1(4).BoundText)
         If oRs.RecordCount > 0 Then
            If oRs.Fields("IdMoneda").Value <> IdMoneda Then
               mCambioDeMoneda = False
            End If
         End If
         oRs.Close
      End If
   End If
   
   Set oRs = Nothing
   
   CambioDeMonedaValido = mCambioDeMoneda

End Function

Public Sub AnularPlazoFijo()

   Dim oF As frmAutorizacion
   Dim mOk As Boolean
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.PlazosFijos
      '.Administradores = True
      .Show vbModal, Me
      mOk = .Ok
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de anular el plazo fijo?", vbYesNo, "Anulacion de plazo fijo")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   With origen
      .Registro.Fields("Anulado").Value = "OK"
      .Guardar
   End With

End Sub
