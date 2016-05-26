VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetComprobantesProveedoresImpo 
   Caption         =   "Datos importacion"
   ClientHeight    =   3480
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6765
   Icon            =   "frmDetComprobantesProveedoresImpo.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3480
   ScaleWidth      =   6765
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtImportacion_Guia 
      DataField       =   "Importacion_Guia"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   1935
      TabIndex        =   3
      Top             =   1530
      Width           =   3210
   End
   Begin VB.TextBox txtImportacion_Despacho 
      DataField       =   "Importacion_Despacho"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   1935
      TabIndex        =   2
      Top             =   1080
      Width           =   4650
   End
   Begin VB.TextBox txtImportacion_PosicionAduana 
      DataField       =   "Importacion_PosicionAduana"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   1935
      TabIndex        =   1
      Top             =   630
      Width           =   3210
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   360
      Index           =   1
      Left            =   2385
      TabIndex        =   8
      Top             =   3015
      Width           =   2160
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   360
      Index           =   0
      Left            =   135
      TabIndex        =   7
      Top             =   3015
      Width           =   2160
   End
   Begin VB.TextBox txtImportacion_FOB 
      Alignment       =   1  'Right Justify
      DataField       =   "Importacion_FOB"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   1935
      TabIndex        =   0
      Top             =   180
      Width           =   1590
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Importacion_IdPaisOrigen"
      Height          =   315
      Index           =   0
      Left            =   1935
      TabIndex        =   4
      Tag             =   "Paises"
      Top             =   1980
      Width           =   3225
      _ExtentX        =   5689
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdPais"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Importacion_FechaEmbarque"
      Height          =   330
      Index           =   0
      Left            =   1935
      TabIndex        =   5
      Top             =   2430
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   582
      _Version        =   393216
      Format          =   62652417
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "Importacion_FechaOficializacion"
      Height          =   330
      Index           =   1
      Left            =   5265
      TabIndex        =   6
      Top             =   2430
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   582
      _Version        =   393216
      Format          =   62652417
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de oficializacion :"
      Height          =   285
      Index           =   5
      Left            =   3420
      TabIndex        =   15
      Top             =   2475
      Width           =   1740
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de embarque :"
      Height          =   285
      Index           =   22
      Left            =   180
      TabIndex        =   14
      Top             =   2475
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Guia :"
      Height          =   285
      Index           =   4
      Left            =   180
      TabIndex        =   13
      Top             =   1575
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Despacho : "
      Height          =   285
      Index           =   2
      Left            =   180
      TabIndex        =   12
      Top             =   1125
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Posicion aduana :"
      Height          =   285
      Index           =   1
      Left            =   180
      TabIndex        =   11
      Top             =   675
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pais de origen :"
      Height          =   285
      Index           =   0
      Left            =   180
      TabIndex        =   10
      Top             =   2025
      Width           =   1650
   End
   Begin VB.Label lblLabels 
      Caption         =   "Valor FOB :"
      Height          =   285
      Index           =   3
      Left            =   180
      TabIndex        =   9
      Top             =   225
      Width           =   1650
   End
End
Attribute VB_Name = "frmDetComprobantesProveedoresImpo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim oComprobanteProveedor As ComPronto.ComprobanteProveedor
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Aceptado = True
         Me.Hide
      Case 1
         Me.Hide
   End Select
   
End Sub

Public Property Get ComprobanteProveedor() As ComPronto.ComprobanteProveedor

   Set ComprobanteProveedor = oComprobanteProveedor

End Property

Public Property Set ComprobanteProveedor(ByVal vNewValue As ComPronto.ComprobanteProveedor)

   Set oComprobanteProveedor = vNewValue

End Property

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Unload(Cancel As Integer)

   Set oComprobanteProveedor = Nothing
   
End Sub

Private Sub txtImportacion_Despacho_GotFocus()

   With txtImportacion_Despacho
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImportacion_Despacho_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtImportacion_Despacho
         If Len(Trim(.Text)) >= oComprobanteProveedor.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImportacion_FOB_GotFocus()

   With txtImportacion_FOB
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImportacion_FOB_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtImportacion_Guia_GotFocus()

   With txtImportacion_Guia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImportacion_Guia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtImportacion_Guia
         If Len(Trim(.Text)) >= oComprobanteProveedor.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImportacion_PosicionAduana_GotFocus()

   With txtImportacion_PosicionAduana
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImportacion_PosicionAduana_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtImportacion_PosicionAduana
         If Len(Trim(.Text)) >= oComprobanteProveedor.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
