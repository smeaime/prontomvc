Attribute VB_Name = "MODaPP"
Option Explicit

Public Enum EnumAcciones
   alta = 0
   Modificacion = 1
   baja = 2
End Enum

Public Enum EnumAccesos
   Alto = 1
   Nivel2 = 2
   Nivel3 = 3
   Nivel4 = 4
   Medio = 5
   Nivel6 = 6
   Nivel7 = 7
   Nivel8 = 8
   Bajo = 9
End Enum

Public Type RegistroMenu
   Id As Long
   Nivel As Integer
   Nombre As String * 70
End Type

Public Enum EnumFormularios
   ListaAcopio = 1
   ListaMateriales = 2
   RequerimientoMateriales = 3
   NotaPedido = 4
   Comparativa = 5
   AjusteStock = 6
   Presupuesto = 7
   SolicitudMateriales = 8
   SalidaMateriales = 9
   OtroIngresoAlmacen = 10
   RecepcionMateriales = 11
   OrdenesCompra = 21
   Remitos = 22
   Facturas = 23
   Devoluciones = 24
   Recibos = 25
   NotasDebito = 26
   NotasCredito = 27
   ComprobantesProveedores = 31
   OrdenesPago = 32
   Subdiarios = 41
   Asientos = 42
   DepositosBancarios = 51
   DebitosCreditosBancarios = 52
   ResumenesConciliacion = 53
   PlazosFijos = 54
End Enum

'Public Type RegistroMenuMultinivel
'   Id As Long
'   Clave01 As String * 50
'   Descripcion01 As String * 50
'   Clave02 As String * 50
'   Descripcion02 As String * 50
'   Clave03 As String * 50
'   Descripcion03 As String * 50
'   Clave04 As String * 50
'   Descripcion04 As String * 50
'   Clave05 As String * 50
'   Descripcion05 As String * 50
'   Clave06 As String * 50
'   Descripcion06 As String * 50
'   Clave07 As String * 50
'   Descripcion07 As String * 50
'   Clave08 As String * 50
'   Descripcion08 As String * 50
'   Clave09 As String * 50
'   Descripcion09 As String * 50
'   Clave10 As String * 50
'   Descripcion10 As String * 50
'   Clave11 As String * 50
'   Descripcion11 As String * 50
'   Clave12 As String * 50
'   Descripcion12 As String * 50
'   Clave13 As String * 50
'   Descripcion13 As String * 50
'   Articulo As String * 250
'End Type

Global Aplicacion As ComPronto.Aplicacion 'el problema con sacarse el tipado del compronto es que no lo
                                        ' puedo hacer en los WithEvents de los forms, porque WithEvents no permite
                                        ' declararlas como Object  http://msdn.microsoft.com/es-es/library/aty3352y.aspx
Global AplicacionProd As ComPronto.Aplicacion



Global cPMenu As cPopupMenu
Global UsuarioSistema As String, glbEmpresa As String, glbDetalleNombre As String
Global glbDireccion As String, glbLocalidad As String, glbCodigoPostal As String
Global glbProvincia As String, glbTelefono1 As String, glbTelefono2 As String
Global glbEmail As String, glbInicialesUsuario As String, glbCuit As String
Global glbCondicionIva As String, glbDatosAdicionales1 As String, gblBD As String
Global glbNombreUsuario As String, glbDatosAdicionales2 As String, gblHOST As String
Global glbDatosAdicionales3 As String, glbArchivoAyuda As String, glbIdUsuario As String
Global glbStringConexion As String, glbEmpresaSegunString As String, glbIdSector As String
Global glbPathPlantillas As String, glbActivarCircuitoChequesDiferidos As String
Global glbBasePRONTOSyJAsociada As String, glbDtsExec As String, glbDtsExt As String
Global glbActivarSolicitudMateriales As String, glbIdiomaActual As String
Global gblMaximaLongitudAdjuntos As Integer, glbTipoUsuario As Integer, glbIdCodigoIva As Integer
Global glbIdMonedaDolar As Long, glbIdMonedaEuro As Long, glbLegajo As Long
Global glbIdCuentaFFUsuario As Long, glbIdObraAsignadaUsuario As Long
Global gblFechaUltimoCierre As Date
Global glbMenuPopUpCargado As Boolean, glbPermitirModificacionTabulados As Boolean
Global glbParametrizacionNivel1 As Boolean, glbSonidoNavegacion As Boolean
Global glbMenuPopUpCargado1 As Boolean, glbModoAccesosUsuarios As Boolean
Global glbAdministrador As Boolean, glbSeñal1 As Boolean, glbCargaEnSerie As Boolean
Public POP_hMenu As Long
Public OldWindowLong As Long, POP_menuheight As Long, POP_breakpoint As Long, POP_Key As Long

Global glbUsarPartidasParaStock As Boolean

Global glbIdArticuloRet ' As Long
Global glbCantRet 'As Long
Global glbUniRet 'As Long
Global glbClienteRet ' As Long
Global glbIdColorRet ' As Long
Global glbFechaEntrega
Global glbIdOC
Global glbIdDetOC
Global glbNumeroOC

Global Const KC_VERDE = &H80FF80
Global Const KC_ROJO = &H8080FF
Global Const KC_AZUL = &HFFC0C0
Global Const KC_BLANCO = &HFFFFFF
Global Const KC_NEGRO = &H80000008
Global Const KC_GRIS = &HE0E0E0
Global Const KC_AMARILLO = &HFFFF&
Global Const KC_AMARILLOCLARO = &HC0FFFF
Global Const KC_VIOLETA = &HFFC0FF

Public Function Degradado(vForm As Form) As Boolean
   
   Dim intContador As Integer
   
   vForm.DrawStyle = vbInsideSolid
   vForm.DrawMode = vbCopyPen
   vForm.ScaleMode = vbPixels
   vForm.DrawWidth = 2
   vForm.ScaleHeight = 256
   
   For intContador = 0 To 255
      vForm.Line (0, intContador)-(Screen.Width, _
      intContador - 1), RGB(0, 0, 255 - intContador), B
   Next intContador

End Function

Public Function SiguienteOrdenLMateriales(oRs As Recordset, NroItem As Integer) As Integer

   Dim NroOrd As Integer, CantReg As Integer
   
   NroOrd = 0
   CantReg = 0
   
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         If oRs.Fields("NumeroItem").Value = NroItem Then
            If oRs.Fields("NumeroOrden").Value > NroOrd Then
               NroOrd = oRs.Fields("NumeroOrden").Value
            End If
            CantReg = CantReg + 1
         End If
         oRs.MoveNext
      Loop
   End If
   
   oRs.Close
   Set oRs = Nothing
   
   If CantReg <= 1 Then
      SiguienteOrdenLMateriales = 0
   Else
      SiguienteOrdenLMateriales = NroOrd + 10
   End If
   
End Function

Public Function CopiarRsCon1Registro(ByVal oRsOrigen As ADOR.Recordset) As ADOR.Recordset

   Dim oFld As ADOR.Field
   Dim oRsDest As ADOR.Recordset
   
   Set oRsDest = CreateObject("Ador.Recordset")
   
   With oRsDest
      For Each oFld In oRsOrigen.Fields
         .Fields.Append oFld.Name, oFld.type, oFld.DefinedSize, oFld.Attributes
         .Fields.Item(oFld.Name).Precision = oFld.Precision
         .Fields.Item(oFld.Name).NumericScale = oFld.NumericScale
      Next
      .Open
      .AddNew
      .Fields(0).Value = -1
      .Fields(1).Value = "Sin información"
      .Update
   End With
   
   Set CopiarRsCon1Registro = oRsDest
   Set oRsDest = Nothing

End Function

Public Sub GrabarMenu(ByVal oRs As ADOR.Recordset)

   Dim Arch As String
   Arch = app.Path & "\PopUp"
   If Len(Trim(Dir(Arch))) <> 0 Then
      Kill Arch
   End If

   Dim MiReg As RegistroMenu
   Dim Nv1 As Long, Nv2 As Long, Nv3 As Long, Nv4 As Long, Nv5 As Long, Reg As Long

   Reg = 0
   
   Open Arch For Random As #1 Len = Len(MiReg)
   
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            Nv1 = oRs.Fields("IdRubro").Value
            With MiReg
               .Id = Nv1
               .Nivel = 1
               .Nombre = oRs.Fields("Rubro").Value
            End With
            Reg = Reg + 1
            Put #1, Reg, MiReg
            Do While Not oRs.EOF
               Nv2 = oRs.Fields("IdSubrubro").Value
               With MiReg
                  .Id = Nv2
                  .Nivel = 2
                  .Nombre = oRs.Fields("Subrubro").Value
               End With
               Reg = Reg + 1
               Put #1, Reg, MiReg
               Do While Not oRs.EOF
                  Nv3 = iisNull(oRs.Fields("IdFamilia").Value, 0)
                  With MiReg
                     .Id = Nv3
                     .Nivel = 3
                     .Nombre = iisNull(oRs.Fields("Familia").Value, "")
                  End With
                  Reg = Reg + 1
                  Put #1, Reg, MiReg
                  Do While Not oRs.EOF
                     If Nv1 <> oRs.Fields("IdRubro").Value Or Nv2 <> oRs.Fields("IdSubrubro").Value Or Nv3 <> oRs.Fields("IdFamilia").Value Then
                        Exit Do
                     End If
                     Nv4 = oRs.Fields("IdArticulo").Value
                     With MiReg
                        .Id = Nv4
                        .Nivel = 9
                        .Nombre = oRs.Fields("Descripcion").Value
                     End With
                     Reg = Reg + 1
                     Put #1, Reg, MiReg
                     oRs.MoveNext
                  Loop
                  If Not oRs.EOF Then
                     If Nv1 <> oRs.Fields("IdRubro").Value Or Nv2 <> oRs.Fields("IdSubrubro").Value Then Exit Do
                  End If
               Loop
               If Not oRs.EOF Then
                  If Nv1 <> oRs.Fields("IdRubro").Value Then Exit Do
               End If
            Loop
         Loop
      End If
   End If

   Close #1
   
End Sub

Public Function LeerMenu() As ADOR.Recordset

   Dim Arch As String
   Dim MiReg As RegistroMenu
   Dim Datos As ADOR.Recordset
   
   Set Datos = CreateObject("ADOR.Recordset")
   With Datos
      .Fields.Append "Id", adInteger
      .Fields.Append "Nivel", adInteger
      .Fields.Append "Nombre", adVarChar, 70
   End With
   Datos.Open
   
   Arch = app.Path & "\PopUp"
   
   Open Arch For Random As #1 Len = Len(MiReg)
   
   Do While Not EOF(1)
      Get #1, , MiReg
      With Datos
         .AddNew
         .Fields("Id").Value = MiReg.Id
         .Fields("Nivel").Value = MiReg.Nivel
         .Fields("Nombre").Value = MiReg.Nombre
         .Update
      End With
   Loop
   
   Close #1

   Set LeerMenu = Datos

End Function

Public Function AddSubMenu(ByVal Caption As String, ByVal hParentMenu As Long) As Long

   ' Create a new popup
   AddSubMenu = CreatePopupMenu()
   Caption = Trim(Caption)
   ' Add the popup menu to the hParentMenu
   AppendMenu hParentMenu, MF_POPUP, AddSubMenu, Caption
   
End Function

Public Function AddMenuItem(ByVal Caption As String, ByVal hParentMenu As Long, ByVal Tg As Long) As Long

   Caption = Trim(Caption)
   ' Add the item to the menu
   AppendMenu hParentMenu, MF_STRING, Tg, Caption
   AddMenuItem = 0
     
End Function

Public Function GetCurrentUserName() As String

   Dim sBuffer As String
   Dim lBufferSize As Long, lReturnCode As Long
   
   'Fill buffer
   sBuffer = String(200, 0)
   
   'Initialize buffer size
   lBufferSize = 199
   
   'Get the User Name, lBufferSize will contain the number of characters
   'returned by GetUserName.  If lReturnCode is 0, an error has occurred. Non-zero on success.
   lReturnCode = GetUserName(sBuffer, lBufferSize)
   
   'Validate the return value.
   If lReturnCode <> 0 Then
      'Success!  Return the User Name
      GetCurrentUserName = Left(sBuffer, lBufferSize)
   Else
      GetCurrentUserName = "Err"
      'lReturnValue = 0, an error has occurred.
'      MsgBox "An error has occurred while retrieving the User Name.", _
'          vbCritical, "GetCurrentUserName Sample"
      ''If you have the GetLastErrorDescription module loaded in your project,
      ''you would use this statement instead:
      '
      'MsgBox GetLastErrorDescription, vbCritical, "GetCurrentUserName Sample"
      '
      ''The GetLastErrorDescription module can be found at:  http://www.submain.com/vb
   End If

End Function

Public Function NumeroMes(ByVal Mes As String) As Integer
   
   Dim NroMes As Integer
   
   Select Case Mes
      Case "Enero"
         NroMes = 1
      Case "Febrero"
         NroMes = 2
      Case "Marzo"
         NroMes = 3
      Case "Abril"
         NroMes = 4
      Case "Mayo"
         NroMes = 5
      Case "Junio"
         NroMes = 6
      Case "Julio"
         NroMes = 7
      Case "Agosto"
         NroMes = 8
      Case "Setiembre"
         NroMes = 9
      Case "Octubre"
         NroMes = 10
      Case "Noviembre"
         NroMes = 11
      Case "Diciembre"
         NroMes = 12
      Case Else
         NroMes = 0
   End Select

   NumeroMes = NroMes

End Function

Public Function NombreMes(ByVal NumeroMes As Integer) As String
   
   Dim NroMes As Integer
   
   Select Case NumeroMes
      Case 1
         NombreMes = "Enero"
      Case 2
         NombreMes = "Febrero"
      Case 3
         NombreMes = "Marzo"
      Case 4
         NombreMes = "Abril"
      Case 5
         NombreMes = "Mayo"
      Case 6
         NombreMes = "Junio"
      Case 7
         NombreMes = "Julio"
      Case 8
         NombreMes = "Agosto"
      Case 9
         NombreMes = "Setiembre"
      Case 10
         NombreMes = "Octubre"
      Case 11
         NombreMes = "Noviembre"
      Case 12
         NombreMes = "Diciembre"
      Case Else
         NombreMes = ""
   End Select

End Function

Public Function NombreMesCorto(ByVal NumeroMes As Integer) As String
   
   Dim NroMes As Integer
   
   Select Case NumeroMes
      Case 1
         NombreMesCorto = "Ene"
      Case 2
         NombreMesCorto = "Feb"
      Case 3
         NombreMesCorto = "Mar"
      Case 4
         NombreMesCorto = "Abr"
      Case 5
         NombreMesCorto = "May"
      Case 6
         NombreMesCorto = "Jun"
      Case 7
         NombreMesCorto = "Jul"
      Case 8
         NombreMesCorto = "Ago"
      Case 9
         NombreMesCorto = "Set"
      Case 10
         NombreMesCorto = "Oct"
      Case 11
         NombreMesCorto = "Nov"
      Case 12
         NombreMesCorto = "Dic"
      Case Else
         NombreMesCorto = ""
   End Select

End Function

Public Function NombreMesCortoRev(ByVal NombreMesCorto As String) As Integer
   
   Select Case NombreMesCorto
      Case "Ene"
         NombreMesCortoRev = 1
      Case "Feb"
         NombreMesCortoRev = 2
      Case "Mar"
         NombreMesCortoRev = 3
      Case "Abr"
         NombreMesCortoRev = 4
      Case "May"
         NombreMesCortoRev = 5
      Case "Jun"
         NombreMesCortoRev = 6
      Case "Jul"
         NombreMesCortoRev = 7
      Case "Ago"
         NombreMesCortoRev = 8
      Case "Set"
         NombreMesCortoRev = 9
      Case "Oct"
         NombreMesCortoRev = 10
      Case "Nov"
         NombreMesCortoRev = 11
      Case "Dic"
         NombreMesCortoRev = 12
      Case Else
         NombreMesCortoRev = 0
   End Select

End Function

Public Function NombreDia(ByVal Dia As Integer, ByVal Mes As Integer, ByVal Anio As Integer) As String

   Select Case Weekday(DateSerial(Anio, Mes, Dia))
      Case vbSunday
         NombreDia = "domingo"
      Case vbMonday
         NombreDia = "lunes"
      Case vbTuesday
         NombreDia = "martes"
      Case vbWednesday
         NombreDia = "miércoles"
      Case vbThursday
         NombreDia = "jueves"
      Case vbFriday
         NombreDia = "viernes"
      Case vbSaturday
         NombreDia = "sábado"
      Case Else
         NombreDia = ""
   End Select
      
End Function
   
Public Function DiasDelMes(stNombreONro As String, iAnio As Long) As Integer

   DiasDelMes = -1
    
   Select Case LCase(stNombreONro)
      Case "febrero", "feb", "2"
         If iAnio Mod 4 = 0 Then
            DiasDelMes = 29
         Else
            DiasDelMes = 28
         End If
      Case "enero", "marzo", "mayo", "julio", "agosto", _
          "octubre", "diciembre", "ene", "mar", "may", "jul", "ago", _
          "oct", "dic", "1", "3", "5", "7", "8", "10", "12"
          DiasDelMes = 31
      Case Else
         DiasDelMes = 30
   End Select

End Function

Public Function CalcularPeso(ByVal IdArt As Long, _
                             ByVal Cant As Double, _
                             Optional ByVal Cant1 As Double, _
                             Optional ByVal Cant2 As Double) As Double

   Dim oRs As ADOR.Recordset
   Dim mvarPeso As Double
   
   mvarPeso = 0
   
   Set oRs = Aplicacion.Articulos.Item(IdArt).Registro
   
   If oRs.RecordCount > 0 Then
      If Not IsNull(oRs.Fields("Peso").Value) Then
         If oRs.Fields("Peso").Value <> 0 Then
            mvarPeso = oRs.Fields("Peso").Value * Cant
            If Not IsEmpty(Cant1) And Not IsNull(oRs.Fields("Largo").Value) Then
               If Cant1 <> 0 And oRs.Fields("Largo").Value <> 0 Then
                  mvarPeso = (Cant1 / oRs.Fields("Largo").Value) * oRs.Fields("Peso").Value * Cant
               End If
            End If
            If Not IsEmpty(Cant1) And Not IsEmpty(Cant2) And Not IsNull(oRs.Fields("Largo").Value) Then
               If Cant1 <> 0 And Cant2 <> 0 And oRs.Fields("Largo").Value <> 0 And oRs.Fields("Ancho").Value <> 0 Then
                  mvarPeso = ((Cant1 * Cant2) / (oRs.Fields("Largo").Value * oRs.Fields("Ancho").Value)) * oRs.Fields("Peso").Value * Cant
               End If
            End If
         End If
      End If
      'If ExisteCampo(oRs, "Densidad") Then
       '  If Not IsNull(oRs.Fields("Densidad").Value) Then
      '      If oRs.Fields("Densidad").Value <> 0 Then
      '
      '      End If
      '   End If
      'End If
   End If
               
   Set oRs = Nothing
   
   CalcularPeso = mvarPeso
            
End Function

Public Function CalculaEdad(ByVal FechaNacimiento As Variant, FechaHasta As Variant) As Integer

   Dim iResult As Integer
   
   If FechaHasta = 0 Then FechaHasta = Now
   
   iResult = Year(FechaHasta) - Year(FechaNacimiento)
   
   If Month(FechaHasta) < Month(FechaNacimiento) Then
      iResult = iResult - 1
   ElseIf Month(FechaHasta) = Month(FechaNacimiento) Then
      If Day(FechaHasta) < Day(FechaNacimiento) Then iResult = iResult - 1
   End If
   
   CalculaEdad = iResult

End Function

Public Function ArmarXML(ByVal oRs As ADOR.Recordset) As String

   Dim oStr As ADODB.Stream
   
   With oRs
      If .RecordCount Then
         Set oStr = CreateObject("ADODB.Stream")
         .Save oStr, adPersistXML
         .Close
         With oStr
            .Position = 0
            ArmarXML = .ReadText
         End With
      End If
   End With

   Set oStr = Nothing

End Function

Public Function CreateADORSFromXML(ByVal sXML As String) As ADOR.Recordset
   
   Dim oXML As MSXML.DOMDocument
   Dim oRs As ADOR.Recordset
   
   Set oXML = CreateObject("MSXML.DOMDocument")
   Set oRs = CreateObject("ADOR.Recordset")
   
   oXML.loadXML mId(sXML, 5, Len(sXML) - 4)
   
   oRs.Open oXML
   
   Set CreateADORSFromXML = oRs
   
   Set oRs = Nothing
   Set oXML = Nothing

End Function

Public Function CheckAttachment(ByVal Attachment As String, AttachPath As String, AttachName As String) As Boolean
   
   If Len(Attachment) = 0 Then Exit Function
   CheckAttachment = True
   If InStr(Attachment, "\") Then
      AttachPath = Attachment
      AttachName = mId$(Attachment, InStrRev(Attachment, "\") + 1)
   Else
      AttachPath = app.Path & "\" & Attachment
      AttachName = Attachment
   End If

End Function

Sub GuardarArchivoSecuencial(ByVal NombreArchivo As String, ByVal Contenido As Variant)

   Dim nArch As Long, mVuelta As Integer
   
   On Error GoTo Mal
   
   nArch = FreeFile
   mVuelta = 1
Seguir:
   Open NombreArchivo For Output As nArch
   Print #nArch, Contenido
   Close nArch
   
   Exit Sub
   
Mal:
   If Err.Number = 70 And mVuelta < 30 Then
      Sleep 1000
      mVuelta = mVuelta + 1
      Resume Seguir:
      GoTo Seguir
   Else
      MsgBox Err.Description
   End If

End Sub

Function LeerArchivoSecuencial(ByVal NombreArchivo As String) As String

   Dim mChar
   Dim nArch As Long
   nArch = FreeFile
   Open NombreArchivo For Input As nArch
   mChar = ""
   Do While Not EOF(nArch)
      mChar = mChar + Input(1, nArch)
   Loop
   Close nArch

   LeerArchivoSecuencial = mChar
   
End Function

Function LeerArchivoSecuencial1(ByVal NombreArchivo As String) As String

   Dim s As String
   Dim nArch As Long
   nArch = FreeFile
   Open NombreArchivo For Binary As nArch
   s = String$(LOF(nArch), 0)
   Get nArch, 1, s
   Close nArch
   LeerArchivoSecuencial1 = s

End Function

Public Sub FiltradoLista(ByRef mLista As DbListView)

   If mLista.ColumnHeaders.Count = 0 Then
      MsgBox "No hay informacion ingresada a la lista!", vbExclamation
      Exit Sub
   End If
         
   Dim oF As frmBusqueda
   Dim col As ColumnHeader
   Dim filtro As String, filtro_add As String, filtro_like As String
   Dim oper(5) As String
   Dim i As Integer
   
   oper(0) = "="
   oper(1) = "LIKE"
   oper(2) = ">"
   oper(3) = "<"
   oper(4) = "<>"
   
   filtro = ""
   filtro_add = ""
   filtro_like = ""
   
   Set oF = New frmBusqueda
   With oF
      Set .Lista = mLista
      For Each col In mLista.ColumnHeaders
         .Combo1(0).AddItem col.Text
         .Combo1(1).AddItem col.Text
         .Combo1(2).AddItem col.Text
      Next
      .Combo1(0).ListIndex = 0
      .Combo1(1).ListIndex = 0
      .Combo1(2).ListIndex = 0
      
      On Error GoTo MalBuscar
      
      .Show vbModal
   End With
   
'   Me.MousePointer = vbHourglass
   DoEvents
   
   mLista.Idioma = glbIdiomaActual
   
   If oF.txtControl.Text = 0 Then
      For i = 0 To 2
         If Len(Trim(oF.Combo1(i).Text)) <> 0 And Len(Trim(oF.text1(i).Text)) <> 0 Then
            If oF.Combo2(i).ListIndex = 1 Then
               filtro_like = "*"
            Else
               filtro_like = ""
            End If
            filtro = filtro & filtro_add & "[" & oF.Combo1(i).Text & "] " & oper(oF.Combo2(i).ListIndex) & " '" & filtro_like & oF.text1(i).Text & filtro_like & "'"
            filtro_add = " and "
         Else
            filtro_add = " "
         End If
      Next
      mLista.Filtrado = filtro
      mLista.Refresh
   End If
   
'   StatusBar1.Panels(3).Text = Ultimo_Nodo & " " & Lista.ListItems.Count & " elementos en la lista"

   ReemplazarEtiquetasListas mLista
   
   GoTo Salida
   
MalBuscar:
   
   MsgBox "Error de busqueda" & vbCrLf & "Recuerde que no puede usar BUSCAR con campos numericos, utilice cualquier otro", vbExclamation

Salida:

   Unload oF
   Set oF = Nothing
   
'   Me.MousePointer = vbDefault

End Sub

Public Sub ExportarAExcel(ByRef mLista As DbListView, _
                           Optional ByRef Titulos As String, _
                           Optional ByRef Macro As String, _
                           Optional ByVal Parametros As String)

On Error Resume Next

   If mLista.ListItems.Count = 0 And mId(Titulos, 1, 17) <> "DEPOSITO BANCARIO" Then
      MsgBox "No hay elementos para exportar", vbExclamation
      Exit Sub
   End If
   
   Dim s As String, mParametrosEncabezado As String
   Dim fl As Long, cl As Long, cl1 As Long, i As Long, SaltoCada As Long
   Dim mContador As Long, mColumnaTransporte As Long
   Dim mColumnaSumador1 As Integer, mColumnaSumador2 As Integer
   Dim mColumnaSumador3 As Integer, mColumnaSumador4 As Integer
   Dim mColumnaSumador5 As Integer, mColumnaSumador6 As Integer
   Dim mColumnaSumador7 As Integer, mColumnaSumador8 As Integer
   Dim mColumnaSumador9 As Integer, mColumnaSumador10 As Integer
   Dim mPaginaInicial As Integer, mFontDiario As Integer, mRowHeight As Integer
   Dim mTotalPagina1 As Double, mTotalPagina2 As Double, mTotalPagina3 As Double
   Dim mTotalPagina4 As Double, mTotalPagina5 As Double, mTotalPagina6 As Double
   Dim mTotalPagina7 As Double, mTotalPagina8 As Double, mTotalPagina9 As Double
   Dim mTotalPagina10 As Double
   Dim mTotalizar As Boolean, mFinTransporte As Boolean
   Dim oEx As Excel.Application
   Dim oL As ListItem
   Dim oS As ListSubItem
   Dim oCol As ColumnHeader
   Dim mVector, mVectorParametros, mSubVectorParametros, mVectorAux, mResumen(3, 1000)
   
   If Not IsMissing(Titulos) Then
      mVector = VBA.Split(Titulos, "|")
   End If
   
   mContador = 0
   SaltoCada = 0
   mColumnaSumador1 = 0
   mColumnaSumador2 = 0
   mColumnaSumador3 = 0
   mColumnaSumador4 = 0
   mColumnaSumador5 = 0
   mColumnaSumador6 = 0
   mColumnaSumador7 = 0
   mColumnaSumador8 = 0
   mColumnaSumador9 = 0
   mColumnaSumador10 = 0
   mTotalPagina1 = 0
   mTotalPagina2 = 0
   mTotalPagina3 = 0
   mTotalPagina4 = 0
   mTotalPagina5 = 0
   mTotalPagina6 = 0
   mTotalPagina7 = 0
   mTotalPagina8 = 0
   mTotalPagina9 = 0
   mTotalPagina10 = 0
   mColumnaTransporte = 0
   mPaginaInicial = 0
   mParametrosEncabezado = ""
   mFinTransporte = False
   
   If Not IsMissing(Parametros) Then
      mVectorParametros = VBA.Split(Parametros, "|")
      If UBound(mVectorParametros) > 0 Then
         For i = 0 To UBound(mVectorParametros)
            If InStr(mVectorParametros(i), "SaltoDePaginaCada") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               SaltoCada = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja1") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador1 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja2") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador2 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja3") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador3 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja4") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador4 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja5") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador5 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja6") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador6 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja7") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador7 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja8") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador8 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja9") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador9 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja10") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador10 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "ColumnaTransporte") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaTransporte = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "PaginaInicial") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mPaginaInicial = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "Enc:") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mParametrosEncabezado = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "FontDiario:") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mFontDiario = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "RowHeightDiario:") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mRowHeight = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "TransporteInicialDiario:") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mTotalPagina1 = CDbl(mSubVectorParametros(1))
               mTotalPagina2 = CDbl(mSubVectorParametros(1))

            End If
         Next
      End If
   End If
   
   If mColumnaTransporte = 0 Then mColumnaTransporte = 3
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      
      .Visible = True
      
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         
         With .ActiveSheet

            cl = 1
            If mLista.ListItems.Count > 0 Then
               For Each oCol In mLista.ColumnHeaders
                  If oCol.Width > 0 Or oCol.Text = "Vector_E" Then
                     .Cells(1, cl) = oCol.Text
                     cl = cl + 1
                  End If
               Next
            End If

            fl = 2
            
            If mTotalPagina1 <> 0 Or mTotalPagina2 <> 0 Or mTotalPagina3 <> 0 Or _
                  mTotalPagina4 <> 0 Or mTotalPagina5 <> 0 Or mTotalPagina6 <> 0 Or _
                  mTotalPagina7 <> 0 Or mTotalPagina8 <> 0 Or mTotalPagina9 <> 0 Or _
                  mTotalPagina10 <> 0 Then
               .Cells(fl, mColumnaTransporte) = "Transporte"
               If mColumnaSumador1 <> 0 Then
                  .Cells(fl, mColumnaSumador1) = mTotalPagina1
                  .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador2 <> 0 Then
                  .Cells(fl, mColumnaSumador2) = mTotalPagina2
                  .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador3 <> 0 Then
                  .Cells(fl, mColumnaSumador3) = mTotalPagina3
                  .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador4 <> 0 Then
                  .Cells(fl, mColumnaSumador4) = mTotalPagina4
                  .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador5 <> 0 Then
                  .Cells(fl, mColumnaSumador5) = mTotalPagina5
                  .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador6 <> 0 Then
                  .Cells(fl, mColumnaSumador6) = mTotalPagina6
                  .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador7 <> 0 Then
                  .Cells(fl, mColumnaSumador7) = mTotalPagina7
                  .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador8 <> 0 Then
                  .Cells(fl, mColumnaSumador8) = mTotalPagina8
                  .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador9 <> 0 Then
                  .Cells(fl, mColumnaSumador9) = mTotalPagina9
                  .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador10 <> 0 Then
                  .Cells(fl, mColumnaSumador10) = mTotalPagina10
                  .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
               End If
               fl = fl + 1
            End If
            
            For Each oL In mLista.ListItems
               
               If mLista.ColumnHeaders.Item(1).Width <> 0 Then
                  If mLista.TipoDatoColumna(0) = "D" Then
                     If IsDate(oL.Text) Then .Cells(fl, 1) = CDate(oL.Text)
                  Else
                     If mLista.TipoDatoColumna(0) = "S" Then
                        .Cells(fl, 1) = "'" & oL.Text
                     Else
                        .Cells(fl, 1) = oL.Text
                     End If
                  End If
                  cl1 = 1
               Else
                  cl1 = 0
               End If
               
               cl = 1
               For Each oS In oL.ListSubItems
                  cl = cl + 1
                  If mLista.ColumnHeaders.Item(oS.Index + 1).Width <> 0 Or _
                        mLista.ColumnHeaders.Item(oS.Index + 1).Text = "Vector_E" Then
                     cl1 = cl1 + 1
                     If Len(Trim(oS.Text)) <> 0 Then
                        If mLista.TipoDatoColumna(cl - 1) = "D" Then
                           .Cells(fl, cl1) = CDate(oS.Text)
                        Else
                           If mLista.TipoDatoColumna(cl - 1) = "S" Then
                              .Cells(fl, cl1) = "'" & mId(oS.Text, 1, 1000)
                           Else
                              .Cells(fl, cl1) = mId(oS.Text, 1, 1000)
                           End If
                        End If
                     End If
                     
                     mTotalizar = True
                     mVectorAux = VBA.Split(oL.SubItems(oL.ListSubItems.Count), "|")
                     If IsArray(mVectorAux) Then
                        If UBound(mVectorAux) >= oS.Index Then
                           If InStr(1, mVectorAux(oS.Index), "NOSUMAR") <> 0 Then
                              mTotalizar = False
                           End If
                        End If
                     End If
                      
                     If mLista.ColumnHeaders.Item(oS.Index + 1).Text = "Vector_E" Then
                        If InStr(1, oS.Text, "FinTransporte") <> 0 Then
                           mFinTransporte = True
                        End If
                     End If
                     
                     If mColumnaSumador1 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina1 = mTotalPagina1 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador2 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina2 = mTotalPagina2 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador3 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina3 = mTotalPagina3 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador4 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina4 = mTotalPagina4 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador5 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina5 = mTotalPagina5 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador6 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina6 = mTotalPagina6 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador7 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina7 = mTotalPagina7 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador8 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina8 = mTotalPagina8 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador9 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina9 = mTotalPagina9 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador10 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina10 = mTotalPagina10 + CDbl(oS.Text)
                     End If
                  End If
               Next
               fl = fl + 1
               mContador = mContador + 1
               
               If SaltoCada = mContador And Not mFinTransporte Then
                  mContador = 0
                  .Cells(fl, mColumnaTransporte) = "Transporte"
                  If mColumnaSumador1 <> 0 Then
                     .Cells(fl, mColumnaSumador1) = mTotalPagina1
                     .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador2 <> 0 Then
                     .Cells(fl, mColumnaSumador2) = mTotalPagina2
                     .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador3 <> 0 Then
                     .Cells(fl, mColumnaSumador3) = mTotalPagina3
                     .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador4 <> 0 Then
                     .Cells(fl, mColumnaSumador4) = mTotalPagina4
                     .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador5 <> 0 Then
                     .Cells(fl, mColumnaSumador5) = mTotalPagina5
                     .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador6 <> 0 Then
                     .Cells(fl, mColumnaSumador6) = mTotalPagina6
                     .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador7 <> 0 Then
                     .Cells(fl, mColumnaSumador7) = mTotalPagina7
                     .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador8 <> 0 Then
                     .Cells(fl, mColumnaSumador8) = mTotalPagina8
                     .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador9 <> 0 Then
                     .Cells(fl, mColumnaSumador9) = mTotalPagina9
                     .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador10 <> 0 Then
                     .Cells(fl, mColumnaSumador10) = mTotalPagina10
                     .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
                  End If
                  fl = fl + 1
               End If
            
            Next
            
            If SaltoCada = -1 Then
               If mColumnaSumador1 <> 0 Then
                  .Cells(fl, mColumnaSumador1) = mTotalPagina1
                  .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador2 <> 0 Then
                  .Cells(fl, mColumnaSumador2) = mTotalPagina2
                  .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador3 <> 0 Then
                  .Cells(fl, mColumnaSumador3) = mTotalPagina3
                  .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador4 <> 0 Then
                  .Cells(fl, mColumnaSumador4) = mTotalPagina4
                  .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador5 <> 0 Then
                  .Cells(fl, mColumnaSumador5) = mTotalPagina5
                  .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador6 <> 0 Then
                  .Cells(fl, mColumnaSumador6) = mTotalPagina6
                  .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador7 <> 0 Then
                  .Cells(fl, mColumnaSumador7) = mTotalPagina7
                  .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador8 <> 0 Then
                  .Cells(fl, mColumnaSumador8) = mTotalPagina8
                  .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador9 <> 0 Then
                  .Cells(fl, mColumnaSumador9) = mTotalPagina9
                  .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador10 <> 0 Then
                  .Cells(fl, mColumnaSumador10) = mTotalPagina10
                  .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
               End If
               fl = fl + 1
            End If
            
            .Range("A1").Select

            oEx.Run "ArmarFormato"
      
            .Rows("1:1").Select
            oEx.Selection.Insert Shift:=xlDown
            For i = 0 To UBound(mVector)
               oEx.Selection.Insert Shift:=xlDown
            Next
            For i = 0 To UBound(mVector)
               .Range("A" & i + 1).Select
               oEx.ActiveCell.FormulaR1C1 = mVector(i)
               oEx.Selection.Font.Size = 12
               If i = 0 Then oEx.Selection.Font.Bold = True
            Next
      
            'If mPaginaInicial > 0 Then mPaginaInicial = mPaginaInicial - 1
            oEx.Run "InicializarEncabezados", glbEmpresa, _
                        glbDireccion & " " & glbLocalidad, glbTelefono1, _
                        glbDatosAdicionales1, mPaginaInicial, mParametrosEncabezado
         
            With oEx.ActiveSheet.PageSetup
                .PrintTitleRows = "$1:$" & UBound(mVector) + 3
                .PrintTitleColumns = ""
            End With
         
            If Not IsMissing(Macro) Then
               If Len(Macro) > 0 Then
                  If InStr(Macro, "|") = 0 Then
                     oEx.Run Macro
                  Else
                     mVector = VBA.Split(Macro, "|")
                     s = ""
                     For i = 1 To UBound(mVector): s = s & mVector(i) & "|": Next
                     If Len(s) > 0 Then s = mId(s, 1, Len(s) - 1)
                     oEx.Run mVector(0), glbStringConexion, s
                  End If
               End If
            End If
         
         End With
      
      End With
      
   End With
   
   Set oEx = Nothing

End Sub

Public Sub ImprimirConExcel(ByRef mLista As DbListView, _
                           Optional ByRef Titulos As String, _
                           Optional ByRef Macro As String, _
                           Optional ByVal Parametros As String)

   Dim s As String, mPrinter As String, mHorientacion As String
   Dim mParametrosEncabezado As String
   Dim fl As Long, cl As Long, cl1 As Long, i As Long, mCopias As Long
   Dim SaltoCada As Long, mContador As Long, mColumnaTransporte As Long
   Dim mPaginaInicial As Long
   Dim mColumnaSumador1 As Integer, mColumnaSumador2 As Integer
   Dim mColumnaSumador3 As Integer, mColumnaSumador4 As Integer
   Dim mColumnaSumador5 As Integer, mColumnaSumador6 As Integer
   Dim mColumnaSumador7 As Integer, mColumnaSumador8 As Integer
   Dim mColumnaSumador9 As Integer, mColumnaSumador10 As Integer
   Dim mHojasAncho As Integer
   Dim mTotalPagina1 As Double, mTotalPagina2 As Double, mTotalPagina3 As Double
   Dim mTotalPagina4 As Double, mTotalPagina5 As Double, mTotalPagina6 As Double
   Dim mTotalPagina7 As Double, mTotalPagina8 As Double, mTotalPagina9 As Double
   Dim mTotalPagina10 As Double
   Dim mTotalizar As Boolean, mFinTransporte As Boolean
   Dim oEx As Excel.Application
   Dim mOk As Boolean
   Dim oL As ListItem
   Dim oS As ListSubItem
   Dim oCol As ColumnHeader
   Dim mVector, mVectorParametros, mSubVectorParametros, mVectorAux
   
   If mLista.ListItems.Count = 0 Then
      MsgBox "No hay elementos para exportar", vbExclamation
      Exit Sub
   End If
   
   If Not IsMissing(Titulos) Then
      mVector = VBA.Split(Titulos, "|")
   End If
   
   mContador = 0
   SaltoCada = 0
   mColumnaSumador1 = 0
   mColumnaSumador2 = 0
   mColumnaSumador3 = 0
   mColumnaSumador4 = 0
   mColumnaSumador5 = 0
   mColumnaSumador6 = 0
   mColumnaSumador7 = 0
   mColumnaSumador8 = 0
   mColumnaSumador9 = 0
   mColumnaSumador10 = 0
   mTotalPagina1 = 0
   mTotalPagina2 = 0
   mTotalPagina3 = 0
   mTotalPagina4 = 0
   mTotalPagina5 = 0
   mTotalPagina6 = 0
   mTotalPagina7 = 0
   mTotalPagina8 = 0
   mTotalPagina9 = 0
   mTotalPagina10 = 0
   mColumnaTransporte = 0
   mPaginaInicial = 0
   mParametrosEncabezado = ""
   mFinTransporte = False
   
   If Not IsMissing(Parametros) Then
      mVectorParametros = VBA.Split(Parametros, "|")
      If UBound(mVectorParametros) > 0 Then
         For i = 0 To UBound(mVectorParametros)
            If InStr(mVectorParametros(i), "SaltoDePaginaCada") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               SaltoCada = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja1") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador1 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja2") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador2 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja3") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador3 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja4") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador4 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja5") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador5 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja6") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador6 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja7") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador7 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja8") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador8 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja9") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador9 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja10") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador10 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "ColumnaTransporte") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaTransporte = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "PaginaInicial") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mPaginaInicial = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "Enc:") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mParametrosEncabezado = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "TransporteInicialDiario:") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mTotalPagina1 = CDbl(mSubVectorParametros(1))
               mTotalPagina2 = CDbl(mSubVectorParametros(1))

            End If
         Next
      End If
   End If
   
   If mColumnaTransporte = 0 Then mColumnaTransporte = 3
   
   Dim oF As frmImpresion
   Set oF = New frmImpresion
   With oF
      .Show vbModal
      mOk = .Ok
      mPrinter = .Combo1.Text
      mCopias = Val(.txtCopias.Text)
      mHojasAncho = Val(.txtHojas.Text)
      If .Option1 Then
         mHorientacion = "H"
      Else
         mHorientacion = "V"
      End If
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      
      .Visible = True
      
      With .Workbooks.Add(glbPathPlantillas & "\Listado.xlt")
         
         With .ActiveSheet

            cl = 1
            For Each oCol In mLista.ColumnHeaders
               If oCol.Width > 0 Or oCol.Text = "Vector_E" Then
                  .Cells(1, cl) = oCol.Text
                  cl = cl + 1
               End If
            Next

            fl = 2
            
            If mTotalPagina1 <> 0 Or mTotalPagina2 <> 0 Or mTotalPagina3 <> 0 Or _
                  mTotalPagina4 <> 0 Or mTotalPagina5 <> 0 Or mTotalPagina6 <> 0 Or _
                  mTotalPagina7 <> 0 Or mTotalPagina8 <> 0 Or mTotalPagina9 <> 0 Or _
                  mTotalPagina10 <> 0 Then
               .Cells(fl, mColumnaTransporte) = "Transporte"
               If mColumnaSumador1 <> 0 Then
                  .Cells(fl, mColumnaSumador1) = mTotalPagina1
                  .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador2 <> 0 Then
                  .Cells(fl, mColumnaSumador2) = mTotalPagina2
                  .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador3 <> 0 Then
                  .Cells(fl, mColumnaSumador3) = mTotalPagina3
                  .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador4 <> 0 Then
                  .Cells(fl, mColumnaSumador4) = mTotalPagina4
                  .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador5 <> 0 Then
                  .Cells(fl, mColumnaSumador5) = mTotalPagina5
                  .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador6 <> 0 Then
                  .Cells(fl, mColumnaSumador6) = mTotalPagina6
                  .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador7 <> 0 Then
                  .Cells(fl, mColumnaSumador7) = mTotalPagina7
                  .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador8 <> 0 Then
                  .Cells(fl, mColumnaSumador8) = mTotalPagina8
                  .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador9 <> 0 Then
                  .Cells(fl, mColumnaSumador9) = mTotalPagina9
                  .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador10 <> 0 Then
                  .Cells(fl, mColumnaSumador10) = mTotalPagina10
                  .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
               End If
               fl = fl + 1
            End If
            
            For Each oL In mLista.ListItems
               
               If mLista.ColumnHeaders.Item(1).Width <> 0 Then
                  If mLista.TipoDatoColumna(0) = "D" Then
                     If IsDate(oL.Text) Then .Cells(fl, 1) = CDate(oL.Text)
                  Else
                     If mLista.TipoDatoColumna(0) = "S" Then
                        .Cells(fl, 1) = "'" & oL.Text
                     Else
                        .Cells(fl, 1) = oL.Text
                     End If
                  End If
                  cl1 = 1
               Else
                  cl1 = 0
               End If
               
               cl = 1
               For Each oS In oL.ListSubItems
                  cl = cl + 1
                  If mLista.ColumnHeaders.Item(oS.Index + 1).Width <> 0 Or _
                        mLista.ColumnHeaders.Item(oS.Index + 1).Text = "Vector_E" Then
                     cl1 = cl1 + 1
                     If Len(Trim(oS.Text)) <> 0 Then
                        If mLista.TipoDatoColumna(cl - 1) = "D" Then
                           .Cells(fl, cl1) = CDate(oS.Text)
                        Else
                           If mLista.TipoDatoColumna(cl - 1) = "S" Then
                              .Cells(fl, cl1) = "'" & oS.Text
                           Else
                              .Cells(fl, cl1) = oS.Text
                           End If
                        End If
                     End If
                     
                     mTotalizar = True
                     mVectorAux = VBA.Split(oL.SubItems(oL.ListSubItems.Count), "|")
                     If IsArray(mVectorAux) Then
                        If UBound(mVectorAux) >= oS.Index Then
                           If InStr(1, mVectorAux(oS.Index), "NOSUMAR") <> 0 Then
                              mTotalizar = False
                           End If
                        End If
                     End If
                      
                     If mLista.ColumnHeaders.Item(oS.Index + 1).Text = "Vector_E" Then
                        If InStr(1, oS.Text, "FinTransporte") <> 0 Then
                           mFinTransporte = True
                        End If
                     End If
                     
                     If mColumnaSumador1 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina1 = mTotalPagina1 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador2 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina2 = mTotalPagina2 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador3 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina3 = mTotalPagina3 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador4 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina4 = mTotalPagina4 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador5 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina5 = mTotalPagina5 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador6 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina6 = mTotalPagina6 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador7 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina7 = mTotalPagina7 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador8 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina8 = mTotalPagina8 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador9 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina9 = mTotalPagina9 + CDbl(oS.Text)
                     End If
                     If mColumnaSumador10 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                        mTotalPagina10 = mTotalPagina10 + CDbl(oS.Text)
                     End If
                  End If
               Next
               fl = fl + 1
               mContador = mContador + 1
               
               If SaltoCada = mContador And Not mFinTransporte Then
                  mContador = 0
                  .Cells(fl, mColumnaTransporte) = "Transporte"
                  If mColumnaSumador1 <> 0 Then
                     .Cells(fl, mColumnaSumador1) = mTotalPagina1
                     .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador2 <> 0 Then
                     .Cells(fl, mColumnaSumador2) = mTotalPagina2
                     .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador3 <> 0 Then
                     .Cells(fl, mColumnaSumador3) = mTotalPagina3
                     .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador4 <> 0 Then
                     .Cells(fl, mColumnaSumador4) = mTotalPagina4
                     .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador5 <> 0 Then
                     .Cells(fl, mColumnaSumador5) = mTotalPagina5
                     .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador6 <> 0 Then
                     .Cells(fl, mColumnaSumador6) = mTotalPagina6
                     .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador7 <> 0 Then
                     .Cells(fl, mColumnaSumador7) = mTotalPagina7
                     .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador8 <> 0 Then
                     .Cells(fl, mColumnaSumador8) = mTotalPagina8
                     .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador9 <> 0 Then
                     .Cells(fl, mColumnaSumador9) = mTotalPagina9
                     .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
                  End If
                  If mColumnaSumador10 <> 0 Then
                     .Cells(fl, mColumnaSumador10) = mTotalPagina10
                     .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
                  End If
                  fl = fl + 1
               End If
               
            Next
            
            If SaltoCada = -1 Then
               If mColumnaSumador1 <> 0 Then
                  .Cells(fl, mColumnaSumador1) = mTotalPagina1
                  .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador2 <> 0 Then
                  .Cells(fl, mColumnaSumador2) = mTotalPagina2
                  .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador3 <> 0 Then
                  .Cells(fl, mColumnaSumador3) = mTotalPagina3
                  .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador4 <> 0 Then
                  .Cells(fl, mColumnaSumador4) = mTotalPagina4
                  .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador5 <> 0 Then
                  .Cells(fl, mColumnaSumador5) = mTotalPagina5
                  .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador6 <> 0 Then
                  .Cells(fl, mColumnaSumador6) = mTotalPagina6
                  .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador7 <> 0 Then
                  .Cells(fl, mColumnaSumador7) = mTotalPagina7
                  .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador8 <> 0 Then
                  .Cells(fl, mColumnaSumador8) = mTotalPagina8
                  .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador9 <> 0 Then
                  .Cells(fl, mColumnaSumador9) = mTotalPagina9
                  .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
               End If
               If mColumnaSumador10 <> 0 Then
                  .Cells(fl, mColumnaSumador10) = mTotalPagina10
                  .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
               End If
               fl = fl + 1
            End If
            
            oEx.Run "ArmarFormato"
            
            .Rows("1:1").Select
            oEx.Selection.Insert Shift:=xlDown
            For i = 0 To UBound(mVector)
               oEx.Selection.Insert Shift:=xlDown
            Next
            For i = 0 To UBound(mVector)
               .Range("A" & i + 1).Select
               oEx.ActiveCell.FormulaR1C1 = mVector(i)
               oEx.Selection.Font.Size = 12
               If i = 0 Then oEx.Selection.Font.Bold = True
            Next
      
            'If mPaginaInicial > 0 Then mPaginaInicial = mPaginaInicial - 1
            oEx.Run "InicializarEncabezados", glbEmpresa, _
                        glbDireccion & " " & glbLocalidad, glbTelefono1, _
                        glbDatosAdicionales1, mPaginaInicial, mParametrosEncabezado
         
            With oEx.ActiveSheet.PageSetup
                .PrintTitleRows = "$1:$" & UBound(mVector) + 3
                .PrintTitleColumns = ""
            End With
            
            If Not IsMissing(Macro) Then
               If Len(Macro) > 0 Then
                  If InStr(Macro, "|") = 0 Then
                     oEx.Run Macro
                  Else
                     mVector = VBA.Split(Macro, "|")
                     s = ""
                     For i = 1 To UBound(mVector): s = s & mVector(i) & "|": Next
                     If Len(s) > 0 Then s = mId(s, 1, Len(s) - 1)
                     oEx.Run mVector(0), glbStringConexion, s
                  End If
               End If
            End If
         
            oEx.Run "Imprimir", mPrinter, mCopias, mHojasAncho, mHorientacion
            
         End With
         
        .Close False
      
      End With
      
      .Quit
   
   End With
   
   Set oEx = Nothing

End Sub

Public Sub EmisionDiario(ByVal oRs As ADOR.Recordset, _
                           ByVal FechaDesde As Date, _
                           ByVal FechaHasta As Date, _
                           ByVal Parametros As String)

   On Error GoTo Mal
   
   Dim oW As Word.Application
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      With .Documents.Add(glbPathPlantillas & "\Diario.dot")
         oW.Application.Run MacroName:="ArmarDiario", varg1:=oRs, _
                     varg2:=FechaDesde, varg3:=FechaHasta, varg4:=Parametros, _
                     varg5:=glbEmpresa & "|" & glbDireccion & " " & glbLocalidad & "|" & glbCuit
      End With
   End With

Mal:

   Set oW = Nothing

End Sub

Public Sub ActivarPopUp(frm As Form)

   If OldWindowLong = 0 Then
      OldWindowLong = GetWindowLong(frm.hwnd, GWL_WNDPROC)
      SetWindowLong frm.hwnd, GWL_WNDPROC, AddressOf MenuItemClick
   End If
   
End Sub

Public Sub DesactivarPopUp(frm As Form)

   If OldWindowLong <> 0 Then
      SetWindowLong frm.hwnd, GWL_WNDPROC, OldWindowLong
      OldWindowLong = 0
   End If

End Sub

Public Function MenuItemClick(ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long

   Select Case wMsg
      Case WM_CLOSE:
         SetWindowLong hwnd, GWL_WNDPROC, OldWindowLong
      
'      Case WM_MENUSELECT:
'         POP_Key = CLng(wParam And &HFFFF&)
      
      Case WM_COMMAND:
         If wParam > 0 And wParam < 999999 Then
            POP_Key = CLng(wParam And &HFFFF&)
         End If
'         MsgBox "You clicked on " & CInt(wParam)
   End Select
   
   MenuItemClick = CallWindowProc(OldWindowLong, hwnd, wMsg, wParam, lParam)

End Function

Public Function LoadMenuPopUp()

   Dim oRs As ADOR.Recordset
   Static mItem(15), mHoja As String
   Dim mAux As Long
   Dim submenu As Long
   Dim hmenu1 As Long
   Dim mRefMenu(15) As Long
   Dim i, X As Integer
   Dim mCorte(15) As String
   Dim mClave As String, mDesc As String, mDescripcion As String

   For i = 1 To 14
      mCorte(i) = ""
      mItem(i) = 0
   Next
   
   POP_menuheight = GetSystemMetrics(SM_CYMENU)
   POP_breakpoint = (GetSystemMetrics(SM_CYFULLSCREEN) - POP_menuheight) \ POP_menuheight
   
   POP_hMenu = CreatePopupMenu
   mRefMenu(1) = POP_hMenu
   
   Set oRs = MenuMultinivel
   
   With oRs
      
      If .RecordCount > 0 Then
         
         .MoveFirst
         Do While Not .EOF
            
            For i = 1 To 12
               
               mClave = "Campo" & Format(i, "00") & "_Clave"
               
               If Not IsNull(.Fields(mClave).Value) Then
                  
                  mDesc = "Campo" & Format(i, "00") & "_Descripcion"
                  If Not IsNull(.Fields(mDesc).Value) Then
                     mDescripcion = IIf(Len(.Fields(mDesc).Value) = 0, "s/d", .Fields(mDesc).Value)
                  Else
                     mDescripcion = "s/d"
                  End If
                  
                  If mCorte(i) <> mDescripcion Then
                     mItem(i) = mItem(i) + 1
                     If mItem(i) Mod POP_breakpoint = 0 Then
                        submenu = CreatePopupMenu()
                        InsertMenu mRefMenu(i), .AbsolutePosition, MF_STRING Or MF_BYPOSITION Or MF_POPUP, submenu, "Mas " & CStr(.Fields(mClave).Value)
                        mRefMenu(i) = submenu
                     End If
                     If mCorte(i) = "" Then InsertMenu mRefMenu(i), 0, MF_STRING Or MF_BYPOSITION, -1, CStr(.Fields(mClave).Value)
                     submenu = CreatePopupMenu()
                     InsertMenu mRefMenu(i), .AbsolutePosition, MF_STRING Or MF_BYPOSITION Or MF_POPUP, submenu, mDescripcion
                     mRefMenu(i + 1) = submenu
                     mCorte(i) = mDescripcion
                     For X = i + 1 To 12
                        mCorte(X) = ""
                     Next
                     If i < 12 Then mItem(i + 1) = 0
                     mHoja = 0
                  End If
                  
                  If i < 12 Then
                     mClave = "Campo" & Format(i + 1, "00") & "_Clave"
                     If IsNull(.Fields(mClave).Value) Then
                        mHoja = mHoja + 1
                        If mHoja Mod POP_breakpoint = 0 Then
                           submenu = CreatePopupMenu()
                           InsertMenu mRefMenu(i + 1), .AbsolutePosition, MF_STRING Or MF_BYPOSITION Or MF_POPUP, submenu, "Mas materiales ..."
                           mRefMenu(i + 1) = submenu
                        End If
                        InsertMenu mRefMenu(i + 1), 0, MF_STRING Or MF_BYPOSITION, .Fields("IdArticulo").Value, CStr(.Fields("Articulo").Value)
                     End If
                  End If
               
               End If
               
            Next
            
            .MoveNext
         Loop
      
      End If
      
      .Close
   
   End With
   
   Set oRs = Nothing

End Function

Public Function MenuMultinivel() As ADOR.Recordset

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim mSelect As String, mJoin As String, mCampo As String, mTabla As String
   Dim i As Integer
   
   mSelect = ""
   mJoin = ""
   
   Set oAp = Aplicacion
   Set oRs = oAp.ItemsPopUpMateriales.TraerFiltrado("_Todos")

   With oRs
      If .RecordCount > 0 Then
         mSelect = "INSERT INTO #PopUp " & vbCrLf
         .MoveFirst
         Do While Not .EOF
            mSelect = mSelect & "Select Articulos.IdArticulo,Articulos.IdRubro,Articulos.IdSubrubro," & vbCrLf & _
                                 "'Rubros',Rubros.Descripcion," & vbCrLf & _
                                 "'Subrubros',Subrubros.Descripcion,"
            mJoin = "Left Outer Join Rubros On Rubros.IdRubro=Articulos.IdRubro " & vbCrLf
            mJoin = mJoin & "Left Outer Join Subrubros On Subrubros.IdSubrubro=Articulos.IdSubrubro " & vbCrLf
            mJoin = mJoin & "Left Outer Join ItemsPopUpMateriales It On It.IdRubro=Articulos.IdRubro And It.IdSubrubro=Articulos.IdSubrubro " & vbCrLf
            For i = 1 To 10
               mCampo = "Campo" & Format(i, "00") & "_Nombre"
               mTabla = "Campo" & Format(i, "00") & "_Tabla"
               If Not IsNull(.Fields(mTabla).Value) And Len(.Fields(mTabla).Value) > 0 Then
                  mSelect = mSelect & vbCrLf & "'" & .Fields(mTabla).Value & "'," & _
                                 .Fields(mTabla).Value & ".Descripcion,"
                  mJoin = mJoin & "Left Outer Join " & .Fields(mTabla).Value & " On " & _
                                 .Fields(mTabla).Value & "." & .Fields(mCampo).Value & _
                                 "=Articulos." & .Fields(mCampo).Value & " " & vbCrLf
               Else
                  If Not IsNull(.Fields(mCampo).Value) Then
                     mSelect = mSelect & vbCrLf & "'" & .Fields(mCampo).Value & "',Articulos." & .Fields(mCampo).Value & ","
                  Else
                     mSelect = mSelect & vbCrLf & "Null,Null,"
                  End If
               End If
            Next
            mSelect = mId(mSelect, 1, Len(mSelect) - 1) & vbCrLf & "From Articulos " & vbCrLf
            mJoin = mJoin & "Where It.IdItemPopUpMateriales is not Null and " & vbCrLf & _
                  "Articulos.IdRubro=" & .Fields("IdRubro").Value & " And " & _
                  "Articulos.IdSubrubro=" & .Fields("IdSubrubro").Value & vbCrLf
            mSelect = mSelect & mJoin & vbCrLf
            .MoveNext
            If Not .EOF Then
               mSelect = mSelect & "UNION ALL " & vbCrLf & vbCrLf
            End If
         Loop
      End If
      .Close
   End With
   
   Set MenuMultinivel = oAp.ItemsPopUpMateriales.TraerFiltrado("_ParaMenu", mSelect)
   
   Set oRs = Nothing
   Set oAp = Nothing
   
End Function

Public Function Cotizacion(ByVal Fecha As Date, ByVal IdMoneda As Long) As Double

   Dim oRs As ADOR.Recordset
   Dim mvarIdMonedaPesos As Integer
   
   Set oRs = Aplicacion.Parametros.TraerTodos
   mvarIdMonedaPesos = IIf(IsNull(oRs.Fields("IdMoneda").Value), 0, oRs.Fields("IdMoneda").Value)
   oRs.Close
   
   If IdMoneda <> mvarIdMonedaPesos Then
      Set oRs = Aplicacion.Cotizaciones.TraerFiltrado("_PorFechaMoneda", Array(Fecha, IdMoneda))
      Cotizacion = 0
      If oRs.RecordCount > 0 Then
         Cotizacion = IIf(IsNull(oRs.Fields("CotizacionLibre").Value), 0, oRs.Fields("CotizacionLibre").Value)
      End If
      oRs.Close
   Else
      Cotizacion = 1
   End If
   
   Set oRs = Nothing
   
End Function

Public Sub ExportarDiferenciasDeCambioAExcel(ByRef mLista As DbListView)

   If mLista.ListItems.Count = 0 Then
      MsgBox "No hay elementos para exportar", vbExclamation
      Exit Sub
   End If
   
   Dim s As String
   Dim fl As Integer, cl As Integer, mvarTipoIVA As Integer
   Dim mTipoEntidad As String
   Dim oAp As ComPronto.Aplicacion
   Dim oEx As Excel.Application
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mvarP_IVA1 As Double, mvarP_IVA2 As Double, mvarDecimales As Double
   Dim mvarSubTotal As Double, mvarIVA1 As Double, mvarIVA2 As Double, mvarTotal As Double
   
   If mLista.ColumnHeaders.Item(2).Text = "Cliente" Then
      mTipoEntidad = "Cli"
   Else
      mTipoEntidad = "Prov"
   End If
   
   Set oAp = Aplicacion
   
   Set oRs = Aplicacion.Parametros.TraerTodos
   With oRs
      mvarP_IVA1 = .Fields("Iva1").Value
      mvarP_IVA2 = .Fields("Iva2").Value
      mvarDecimales = .Fields("Decimales").Value
      .Close
   End With
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      
      .Visible = True
      
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         
         With .ActiveSheet

            If mTipoEntidad = "Cli" Then
               .Cells(2, 1) = "Detalle de calculo de diferencias de cambio (cobranzas)"
            Else
               .Cells(2, 1) = "Detalle de calculo de diferencias de cambio (pagos)"
            End If
            
            With .Cells(2, 1).Font
               .Name = "Arial"
               .Size = 14
               .Underline = xlUnderlineStyleSingle
               .Bold = True
            End With
            
            fl = 4
            
            For Each oL In mLista.ListItems
               
               If oL.SubItems(15) = "SI" Then
   
                  If mTipoEntidad = "Cli" Then
                     .Cells(fl, 1) = "Cliente : " & oL.SubItems(1) & " - " & oL.Text
                  Else
                     .Cells(fl, 1) = "Proveedor : " & oL.SubItems(1) & " - " & oL.Text
                  End If
                  With .Cells(fl, 1).Font
                     .Underline = xlUnderlineStyleSingle
                     .Bold = True
                  End With
                  If mTipoEntidad = "Cli" Then
                     .Cells(fl + 1, 2) = "Recibo : " & oL.SubItems(2) & " del " & oL.SubItems(3)
                  Else
                     .Cells(fl + 1, 2) = "Orden de pago : " & oL.SubItems(2) & " del " & oL.SubItems(3)
                  End If
                  .Cells(fl + 2, 2) = "s/Comprobante : " & oL.SubItems(4) & " del " & oL.SubItems(5)
                  .Cells(fl + 3, 2) = "Total comprobante en u$s : "
                  .Cells(fl + 3, 4) = CDbl(oL.SubItems(6))
                  .Cells(fl + 3, 5) = " s/cotizacion u$s de :"
                  .Cells(fl + 3, 6) = CDbl(oL.SubItems(7))
                  If mTipoEntidad = "Cli" Then
                     .Cells(fl + 4, 2) = "Cobrado en u$s : "
                  Else
                     .Cells(fl + 4, 2) = "Pagado en u$s : "
                  End If
                  .Cells(fl + 4, 4) = CDbl(oL.SubItems(8))
                  .Cells(fl + 4, 5) = " s/cotizacion u$s de :"
                  .Cells(fl + 4, 6) = CDbl(oL.SubItems(9))
                  .Cells(fl + 5, 2) = "Diferencia cambio en u$s : "
                  .Cells(fl + 5, 4) = CDbl(oL.SubItems(11))
                  .Cells(fl + 6, 2) = "Diferencia cambio en $ : "
                  .Cells(fl + 6, 4) = CDbl(oL.SubItems(12))
                  If CDbl(oL.SubItems(12)) >= 0 Then
                     .Cells(fl + 7, 2) = "Subtotal debito : "
                  Else
                     .Cells(fl + 7, 2) = "Subtotal credito : "
                  End If
                  .Cells(fl + 7, 4) = CDbl(oL.SubItems(12))
                  .Columns("C:C").ColumnWidth = 8.29
                  .Columns("E:E").ColumnWidth = 9.71
                  .Columns("F:F").ColumnWidth = 10.57
                  .Columns("D:D").NumberFormat = "#,##0.00"
                  .Columns("F:F").NumberFormat = "#,##0.00"
                  
                  With .Range(.Cells(fl + 7, 2), .Cells(fl + 7, 4))
                     .Borders(xlDiagonalDown).LineStyle = xlNone
                     .Borders(xlDiagonalUp).LineStyle = xlNone
                     With .Borders(xlEdgeLeft)
                         .LineStyle = xlContinuous
                         .Weight = xlThin
                     End With
                     With .Borders(xlEdgeTop)
                         .LineStyle = xlContinuous
                         .Weight = xlThin
                     End With
                     With .Borders(xlEdgeBottom)
                         .LineStyle = xlContinuous
                         .Weight = xlThin
                     End With
                     With .Borders(xlEdgeRight)
                         .LineStyle = xlContinuous
                         .Weight = xlThin
                     End With
                     .Borders(xlInsideVertical).LineStyle = xlNone
                     .Borders(xlInsideHorizontal).LineStyle = xlNone
                  End With
    
                  With .Range(.Cells(fl + 7, 2), .Cells(fl + 7, 4))
                     .Font.Bold = True
                     With .Interior
                         .ColorIndex = 15
                         .Pattern = xlSolid
                     End With
                  End With
                  
                  fl = fl + 13
               
               End If
            
            Next
            
            .Range("A1").Select
         
         End With
         
      End With
      
      .ActiveWindow.DisplayGridlines = False
      
   End With
   
   Set oEx = Nothing
   Set oRs = Nothing
   Set oAp = Nothing

End Sub

Public Function GetRegionalSetting(lRegionalSetting As Long) As String
    
    On Error GoTo EH
    Dim sBuffer As String * 100
    Dim lNullPos As Long
    
    If GetLocaleInfo(LOCALE_USER_DEFAULT, lRegionalSetting, sBuffer, 99) Then
        lNullPos = InStr(sBuffer, vbNullChar)
        If lNullPos Then
            GetRegionalSetting = Left$(sBuffer, lNullPos - 1)
            Exit Function
        End If
    End If
    
    GetRegionalSetting = vbNullChar
    
    Exit Function
EH:
    GetRegionalSetting = vbNullChar

End Function

Public Function GetWinDir() As String

' Get Windows directory
   Dim sTemp As String
   Dim Rtn As Integer
   Const iBufLen = 1024
   sTemp = Space$(iBufLen)         ' max path length
   Rtn = GetWindowsDirectory(sTemp, iBufLen)
   If Rtn > 0 Then
       sTemp = Left$(sTemp, Rtn)
'       sTemp = AddBackslash(sTemp)
   End If
   GetWinDir = sTemp

End Function

Public Function GetCompName() As String

   Dim dwLen As Long
   Dim strString As String
       
   'Create a buffer
   dwLen = MAX_COMPUTERNAME_LENGTH + 1
   strString = String(dwLen, "X")
       
   'Get the computer name
   GetComputerName strString, dwLen
       
   'get only the actual data
   GetCompName = Left(strString, dwLen)

End Function

Public Function TrasabilidadPlazosFijos(ByVal mIdPlazoFijo As Long) As ADOR.Recordset

   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim oFld As ADOR.Field
   Dim i As Integer
   Dim mIdPlazoFijoOrigen As Long
   
   'Set oRs = CopiarTodosLosRegistros(Aplicacion.PlazosFijos.TraerFiltrado("_TT", mIdPlazoFijo))
   mIdPlazoFijoOrigen = IIf(IsNull(oRs.Fields("IdPlazoFijoOrigen").Value), 0, oRs.Fields("IdPlazoFijoOrigen").Value)
   
   For i = 1 To 100
      If mIdPlazoFijoOrigen = 0 Then
         Exit For
      Else
         Set oRs1 = Aplicacion.PlazosFijos.TraerFiltrado("_TT", mIdPlazoFijoOrigen)
         With oRs1
            If .RecordCount > 0 Then
               oRs.AddNew
               For Each oFld In oRs.Fields
                  oRs.Fields(oFld.Name).Value = .Fields(oFld.Name).Value
               Next
               .Update
            End If
            .Close
         End With
         mIdPlazoFijoOrigen = IIf(IsNull(oRs.Fields("IdPlazoFijoOrigen").Value), 0, oRs.Fields("IdPlazoFijoOrigen").Value)
      End If
   Next

   Set TrasabilidadPlazosFijos = oRs
   
   Set oRs = Nothing
   Set oRs1 = Nothing

End Function

Public Sub ExportarDocumentos(ByVal Documento As String, _
                              ByVal VectorIdDocumento As String, _
                              ByVal Info As String)

   Dim oAp As ComPronto.Aplicacion
   Dim oW As Word.Application, oW1 As Word.Application
   
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oRsPrv As ADOR.Recordset
   Dim oRsArt As ADOR.Recordset
   Dim oRsEmp As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim oRsLMat As ADOR.Recordset
   Dim oRsObra As ADOR.Recordset
   Dim oRsCC As ADOR.Recordset
   Dim oRsFact As ADOR.Recordset
   Dim oRsEqu As ADOR.Recordset
   Dim oRsCli As ADOR.Recordset
   Dim oRsRev As ADOR.Recordset
   Dim oRsAco As ADOR.Recordset
   Dim oRsPlano As ADOR.Recordset
   Dim oRsDetVal As ADOR.Recordset
   
   Dim oF As Form
   
   Dim cALetra As New clsNum2Let
   
   Dim mPaginas As Integer, i As Integer, j As Integer, Index As Integer
   Dim mCantidadFirmas As Integer, mCopias As Integer
   Dim mvarUnidad As String, mvarMedidas As String, mvarLocalidad As String
   Dim mvarDescripcion As String, mvarAutorizo As String, mPlantilla As String
   Dim mvarFecha As String, mAdjuntos As String, mNumero As String, mPiePedido As String
   Dim mResp As String, mvarTag As String, mCarpeta As String, mImprime As String
   Dim mvarObra As String, mvarMoneda As String, mFormulario As String
   Dim mConSinAviso As String, mCC As String, mvarCantidad As String, espacios As String
   Dim mvarUnidadPeso As String, mCodigo As String, mvarDireccion As String
   Dim mvarOrigen1 As String, mvarOrigen2 As String, mvarDescripcionIva As String
   Dim mvarNumLet As String, mvarDocumento As String, mvarBorrador As String
   Dim mImprimirAdjuntos As String, mExterior As String
   Dim mPrecio As Double, mTotalItem As Double, mvarSubTotal As Double
   Dim mvarSubtotalGravado As Double, mvarIVA1 As Double, mvarIVA2 As Double
   Dim mvarTotalPedido As Double, mvarBonificacionPorItem As Double
   Dim mvarBonificacion As Double, mvarTotalPeso As Double, mvarTotalImputaciones As Double
   Dim mvarTotalOrdenPago As Double, mvarTotalDebe As Double, mvarTotalValores As Double
   Dim mvarId As Long, mvarCCostos As Long, mIdOPComplementaria As Long
   Dim mVectorAutorizaciones(10) As Integer, mDelay As Integer
   Dim HayVariosCCostos As Boolean, mImprimio As Boolean, mItemsAgrupados As Boolean
   Dim mRTF As Boolean
   Dim mVectorId, mInfo
   
   On Error GoTo Mal
   
   mVectorId = VBA.Split(VectorIdDocumento, "|")
   mInfo = VBA.Split(Info, "|")
   
   Index = CInt(mInfo(2))
   mCarpeta = mInfo(3)
   mImprime = mInfo(4)
   mCopias = CInt(mInfo(5))
   mFormulario = mInfo(6)
   mConSinAviso = mInfo(7)
   
   Set oAp = Aplicacion
   Set oF = New frmExcel1
   
   Set oW = CreateObject("Word.Application")
   
   Select Case Documento
   
      Case "Pedidos"
   
         mImprimirAdjuntos = mInfo(10)
         mRTF = False
         If mInfo(11) = "RTF" Then mRTF = True
         mDelay = Val(BuscarClaveINI("Delay para impresion de pedidos"))
         
         For i = 0 To UBound(mVectorId)
            
            mvarId = mVectorId(i)
            
            Set oRs = oAp.Pedidos.TraerFiltrado("_PorId", mvarId)
            mNumero = oRs.Fields("NumeroPedido").Value
            If Not IsNull(oRs.Fields("Subnumero").Value) Then
               mNumero = mNumero & " / " & oRs.Fields("Subnumero").Value
            End If
            mExterior = "NO"
            If Not IsNull(oRs.Fields("PedidoExterior").Value) Then
               mExterior = oRs.Fields("PedidoExterior").Value
            End If
            oRs.Close
            
            mPlantilla = ""
            If mExterior = "SI" Then
               mPlantilla = BuscarClaveINI("PlantillaPedidosExterior")
            End If
            If Len(mPlantilla) = 0 Then mPlantilla = "Pedido"
            
            With oW
               .Visible = True
               With .Documents.Add(glbPathPlantillas & "\" & mPlantilla & "_" & glbEmpresaSegunString & ".dot")
                  oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, _
                                                         varg2:=mvarId, varg3:=Info
                  oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
                  oW.Application.Run MacroName:="DatosDelPie"
                  If Index = 0 Then
                     For j = 1 To mCopias
                        mPiePedido = ""
                        Select Case j
                           Case 1
                              mPiePedido = "ORIGINAL " & BuscarClaveINI("Destino de copia 1 de pedido")
                           Case 2
                              mPiePedido = "DUPLICADO " & BuscarClaveINI("Destino de copia 2 de pedido")
                           Case 3
                              mPiePedido = "TRIPLICADO " & BuscarClaveINI("Destino de copia 3 de pedido")
                           Case 4
                              mPiePedido = "CUADRUPLICADO " & BuscarClaveINI("Destino de copia 4 de pedido")
                        End Select
                        oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageFooter
                        oW.Selection.HomeKey Unit:=wdStory
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & mPiePedido
                        oW.ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
                        oW.Documents(1).PrintOut False, , , , , , , 1
                        If mDelay > 0 Then Sleep (mDelay)
                     Next
                     oW.Documents(1).Close False
                     If mImprimirAdjuntos = "SI" Then
                        Set oRs = oAp.Pedidos.TraerFiltrado("_PorId", mvarId)
                        If oRs.RecordCount > 0 Then
                           For j = 1 To 10
                              If Not IsNull(oRs.Fields("ArchivoAdjunto" & j).Value) Then
                                 If Right(UCase(oRs.Fields("ArchivoAdjunto" & j).Value), 3) = "DOC" Then
                                    With oW.Documents.Add("" & oRs.Fields("ArchivoAdjunto" & j).Value)
                                       oW.Documents(1).PrintOut False, , , , , , , 1
                                       oW.Documents(1).Close False
                                    End With
                                 End If
                              End If
                           Next
                        End If
                        oRs.Close
                        Set oRs = Nothing
                     End If
                  ElseIf Index = 2 Then
                     If mRTF Then
                        oW.Documents(1).SaveAs Filename:=app.Path & "\Pedido.rtf", _
                                 FileFormat:=wdFormatRTF, LockComments:=False, Password:="", _
                                 AddToRecentFiles:=True, WritePassword:="", _
                                 ReadOnlyRecommended:=False, EmbedTrueTypeFonts:=False, _
                                 SaveNativePictureFormat:=False, SaveFormsData:=False, _
                                 SaveAsAOCELetter:=False
                     Else
                        oW.Documents(1).SaveAs app.Path & "\Pedido.doc"
                     End If
                  ElseIf Index = 3 Then
                     If mvarBorrador = "SI" Then mNumero = mNumero & " [Borrador]"
                     mNumero = Replace(mNumero, "/", "-")
                     If Len(mCarpeta) > 0 Then
                        oW.Documents(1).SaveAs mCarpeta & "\" & mNumero & " - A.doc"
                     End If
                     If mImprime = "SI" Then
                        oW.Documents(1).PrintOut False, , , , , , , 1
                     End If
                     oW.Documents(1).Close False
                  End If
               End With
            End With
         
         Next
         
         If Index <> 1 And Index <> 4 Then
            oW.Quit
         End If
         
         GoTo Salida

      
      Case "Requerimientos"

         For i = 0 To UBound(mVectorId)
            
            mvarId = mVectorId(i)
            
            mvarCCostos = 0
            HayVariosCCostos = False

            With oW
         
               .Visible = True
         
               If mFormulario = "Legal" Then
                  mPlantilla = "Requerimiento.dot"
               Else
                  mPlantilla = "Requerimiento1.dot"
               End If
               
               With .Documents.Add(glbPathPlantillas & "\" & mPlantilla)
         
                  Set oRs = oAp.Requerimientos.TraerFiltrado("_PorId", mvarId)
                  Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_Todos", mvarId)
                  
                  ' Armar el detalle
                  oW.Selection.HomeKey Unit:=wdStory
                  oW.Selection.MoveDown Unit:=wdLine, Count:=2
                  If mFormulario = "Legal" Then
                     oW.Selection.MoveRight Unit:=wdCell, Count:=16
                  Else
                     oW.Selection.MoveRight Unit:=wdCell, Count:=12
                  End If
         
                  ' estoy ubicado al final del texto fijo
                  With oRsDet
                     If .RecordCount > 0 Then
                        .MoveFirst
                        Do Until .EOF
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & Format(.Fields("NumeroItem").Value, "General Number")
                           oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                           oW.Selection.MoveRight Unit:=wdCell
                           If Not IsNull(.Fields("IdDetalleLMateriales").Value) Then
                              Set oRsLMat = oAp.Requerimientos.TraerFiltrado("_PorDetLmat", .Fields("IdDetalleLMateriales").Value)
                              oW.Selection.TypeText Text:="" & Format(oRsLMat.Fields("NumeroLMateriales").Value, "General Number")
                              oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & Format(oRsLMat.Fields("NumeroItem").Value, "General Number")
                              oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                              oW.Selection.MoveRight Unit:=wdCell
                              oRsLMat.Close
                           Else
                              oW.Selection.MoveRight Unit:=wdCell, Count:=2
                           End If
                           oW.Selection.TypeText Text:="" & Format(.Fields("Cantidad").Value, "Fixed")
                           oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                           oW.Selection.MoveRight Unit:=wdCell
                           If Not IsNull(.Fields("IdUnidad").Value) Then
                              oW.Selection.TypeText Text:="" & Format(oAp.Unidades.Item(.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value, "Fixed")
                           End If
                           oW.Selection.MoveRight Unit:=wdCell
         
                           If Not IsNull(.Fields("IdArticulo").Value) Then
                              Set oRsArt = oAp.Articulos.Item(.Fields("IdArticulo").Value).Registro
                              mCodigo = ""
                              If Not IsNull(oRsArt.Fields("Codigo").Value) Then
                                 mCodigo = oRsArt.Fields("Codigo").Value
                              End If
                              mvarMedidas = ""
                              If Not IsNull(oRsArt.Fields("IdCuantificacion").Value) Then
                                 If Not IsNull(oRsArt.Fields("Unidad11").Value) Then
                                    Set oRsAux = oAp.Unidades.Item(oRsArt.Fields("Unidad11").Value).Registro
                                    If Not IsNull(oRsAux.Fields("Abreviatura").Value) Then
                                       mvarUnidad = oRsAux.Fields("Abreviatura").Value
                                    Else
                                       mvarUnidad = oRsAux.Fields("Descripcion").Value
                                    End If
                                    oRsAux.Close
                                 End If
                                 Select Case oRsArt.Fields("IdCuantificacion").Value
                                    Case 3
                                       mvarMedidas = "" & .Fields(8).Value & " x " & .Fields(9).Value & " " & mvarUnidad
                                    Case 2
                                       mvarMedidas = "" & .Fields(8).Value & " " & mvarUnidad
                                 End Select
                              End If
                              oRsArt.Close
                              oW.Selection.TypeText Text:="" & mvarMedidas
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & mCodigo
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & oAp.Articulos.Item(.Fields("IdArticulo").Value).Registro.Fields("Descripcion").Value
                           Else
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & .Fields("DescripcionManual").Value & "(*)"
                           End If
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & Format(.Fields("FechaEntrega").Value, "Short Date")
                           oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
                           oW.Selection.MoveRight Unit:=wdCell
                           mvarTag = ""
                           If Not IsNull(.Fields("IdEquipo").Value) Then
                              Set oRsEqu = oAp.Equipos.Item(.Fields("IdEquipo").Value).Registro
                              If Not IsNull(oRsEqu.Fields("Tag").Value) Then
                                 mvarTag = oRsEqu.Fields("Tag").Value
                              End If
                              oRsEqu.Close
                              Set oRsEqu = Nothing
                           End If
                           oW.Selection.TypeText Text:="" & mvarTag
                           oW.Selection.MoveRight Unit:=wdCell
                           mCC = ""
                           If Not IsNull(.Fields("IdCentroCosto").Value) Then
                              Set oRsCC = oAp.CentrosCosto.Item(.Fields("IdCentroCosto").Value).Registro
                              If Not IsNull(oRsCC.Fields("Codigo").Value) Then
                                 mCC = mCC & oRsCC.Fields("Codigo").Value & " "
                              End If
                              If Not IsNull(oRsCC.Fields("Descripcion").Value) Then
                                 mCC = mCC & oRsCC.Fields("Descripcion").Value
                              End If
                              oRsCC.Close
                           End If
                           If Not IsNull(.Fields("IdCuenta").Value) Then
                              If Len(Trim(mCC)) <> 0 Then mCC = mCC & vbCrLf
                              Set oRsCC = oAp.Cuentas.Item(.Fields("IdCuenta").Value).Registro
                              If Not IsNull(oRsCC.Fields("Codigo").Value) Then
                                 mCC = mCC & oRsCC.Fields("Codigo").Value & " "
                              End If
                              If Not IsNull(oRsCC.Fields("Descripcion").Value) Then
                                 mCC = mCC & oRsCC.Fields("Descripcion").Value
                              End If
                              oRsCC.Close
                           End If
                           oW.Selection.TypeText Text:="" & mCC
                           oW.Selection.MoveRight Unit:=wdCell
                           If Not IsNull(.Fields("EsBienDeUso").Value) Then
                              oW.Selection.TypeText Text:=.Fields("EsBienDeUso").Value
                           Else
                              oW.Selection.TypeText Text:="NO"
                           End If
                           oW.Selection.MoveRight Unit:=wdCell
                           If Not IsNull(.Fields("IdControlCalidad").Value) Then
                              oW.Selection.TypeText Text:="" & oAp.ControlesCalidad.Item(.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value
                           End If
                           oW.Selection.MoveRight Unit:=wdCell
                           If Not IsNull(.Fields("Adjunto").Value) Then
                              oW.Selection.TypeText Text:="" & .Fields("Adjunto").Value
                           End If
                           If mFormulario = "Legal" Then
                              Set oRsFact = oAp.FacturasCompra.TraerFiltrado("_DetallePorDetalleComprobante", Array(EnumFormularios.RequerimientoMateriales, .Fields(0).Value))
                              If oRsFact.RecordCount > 0 Then
                                 oRsFact.MoveFirst
                                 Do While Not oRsFact.EOF
                                    oW.Selection.MoveRight Unit:=wdCell
                                    If Not IsNull(oRsFact.Fields("Proveedor").Value) Then
                                       oW.Selection.TypeText Text:="" & mId(oRsFact.Fields("Proveedor").Value, 1, 20)
                                    End If
                                    oW.Selection.MoveRight Unit:=wdCell
                                    If Not IsNull(oRsFact.Fields("NumeroFactura1").Value) Then
                                       oW.Selection.TypeText Text:="" & oRsFact.Fields("NumeroFactura1").Value & "-" & oRsFact.Fields("NumeroFactura2").Value
                                    End If
                                    oW.Selection.MoveRight Unit:=wdCell
                                    If Not IsNull(oRsFact.Fields("FechaFactura").Value) Then
                                       oW.Selection.TypeText Text:="" & Format(oRsFact.Fields("FechaFactura").Value, "dd/mm/yy")
                                    End If
                                    oRsFact.MoveNext
                                    If Not oRsFact.EOF Then
                                       oW.Selection.MoveRight Unit:=wdCell, Count:=13
                                    End If
                                 Loop
                              Else
                                 oW.Selection.MoveRight Unit:=wdCell, Count:=3
                              End If
                              oRsFact.Close
                           End If
                           If Len(Trim(.Fields("Observaciones").Value)) <> 0 Then
                              oF.rchObservaciones.TextRTF = .Fields("Observaciones").Value
                              oW.Selection.MoveRight Unit:=wdCell, Count:=1
                              .MoveNext
                              If Not .EOF Then
                                 If mFormulario = "Legal" Then
                                    oW.Selection.MoveRight Unit:=wdCell, Count:=17
                                 Else
                                    oW.Selection.MoveRight Unit:=wdCell, Count:=14
                                 End If
                                 oW.Selection.MoveUp Unit:=wdLine, Count:=1
                              End If
                              .MovePrevious
                              If mFormulario = "Legal" Then
                                 oW.Selection.MoveRight Unit:=wdCharacter, Count:=17, Extend:=wdExtend
                              Else
                                 oW.Selection.MoveRight Unit:=wdCharacter, Count:=14, Extend:=wdExtend
                              End If
                              oW.Selection.Cells.Merge
                              oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                              oW.Selection.TypeText Text:="" & oF.rchObservaciones.Text
                           End If
                           If Not IsNull(.Fields("IdCentroCosto").Value) Then
                              If mvarCCostos = 0 Then
                                 mvarCCostos = .Fields("IdCentroCosto").Value
                              Else
                                 If mvarCCostos <> .Fields("IdCentroCosto").Value Then
                                    mvarCCostos = -1
                                    HayVariosCCostos = True
                                 End If
                              End If
                           End If
                           .MoveNext
                        Loop
                     End If
                  End With
         
                  'Registro de numero de paginas
                  oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
                  oW.Application.Run MacroName:="DatosDelPie"
         
                  ' datos del pie de pagina
                  If oW.ActiveWindow.View.SplitSpecial <> wdPaneNone Then
                     oW.ActiveWindow.Panes(2).Close
                  End If
                  oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
                  If oW.Selection.HeaderFooter.IsHeader = True Then
                     oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageFooter
                  Else
                     oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
                  End If
         
                  mvarMoneda = ""
                  If Not IsNull(oRs.Fields("IdMoneda").Value) Then
                     Set oRsCC = oAp.Monedas.Item(oRs.Fields("IdMoneda").Value).Registro
                     If oRsCC.RecordCount > 0 Then
                        mvarMoneda = oRsCC.Fields("Abreviatura").Value
                     End If
                     oRsCC.Close
                  End If
                  
                  oW.Selection.HomeKey Unit:=wdStory
                  oW.Selection.MoveRight Unit:=wdCell, Count:=3
                  oW.Selection.TypeText Text:="" & mvarMoneda
                  oW.Selection.MoveRight Unit:=wdCell, Count:=1
                  If Not IsNull(oRs.Fields("MontoPrevisto").Value) Then
                     oW.Selection.TypeText Text:="" & Format(oRs.Fields("MontoPrevisto").Value, "Fixed")
                  End If
                  oW.Selection.MoveDown Unit:=wdLine, Count:=1
                  oW.Selection.MoveLeft Unit:=wdCell, Count:=1
                  oW.Selection.TypeText Text:="" & mvarMoneda
                  oW.Selection.MoveRight Unit:=wdCell, Count:=1
                  If Not IsNull(oRs.Fields("MontoParaCompra").Value) Then
                     oW.Selection.TypeText Text:="" & Format(oRs.Fields("MontoParaCompra").Value, "Fixed")
                  End If
                  oW.Selection.MoveDown Unit:=wdLine, Count:=3
                  oW.Selection.TypeText Text:="" & Now
                  oW.Selection.HomeKey Unit:=wdStory
                  oW.Selection.MoveDown Unit:=wdLine
                  If Not IsNull(oRs.Fields("LugarEntrega").Value) Then
                     oF.rchObservaciones.TextRTF = oRs.Fields("LugarEntrega").Value
                     oW.Selection.TypeText Text:="" & oF.rchObservaciones.Text
                  End If
                  oW.Selection.MoveRight Unit:=wdCell
                  If Not IsNull(oRs.Fields("Observaciones").Value) Then
                     oF.rchObservaciones.TextRTF = oRs.Fields("Observaciones").Value
                     oW.Selection.TypeText Text:="" & oF.rchObservaciones.Text
                  End If
                  oW.Selection.HomeKey Unit:=wdStory
                  oW.Selection.MoveDown Unit:=wdLine, Count:=3
                  If Not IsNull(oRs.Fields("Aprobo").Value) Then
                     Set oRsEmp = oAp.Empleados.Item(oRs.Fields("Aprobo").Value).Registro
                     If Not IsNull(oRsEmp.Fields("Iniciales").Value) Then
                        oW.Selection.TypeText Text:="" & oRsEmp.Fields("Iniciales").Value & " " & oRs.Fields("FechaAprobacion").Value
                     End If
                     oRsEmp.Close
                  End If
         
                  mCantidadFirmas = 0
                  Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.RequerimientoMateriales, 0))
                  If Not oRsAut Is Nothing Then
                     If oRsAut.RecordCount > 0 Then
                        oRsAut.MoveFirst
                        Do While Not oRsAut.EOF
                           mCantidadFirmas = mCantidadFirmas + 1
                           mVectorAutorizaciones(mCantidadFirmas) = oRsAut.Fields(0).Value
                           oRsAut.MoveNext
                        Loop
                     End If
                     oRsAut.Close
                  End If
                  
                  Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.RequerimientoMateriales, mvarId))
                  If oRsAut.RecordCount > 0 Then
                     For j = 1 To mCantidadFirmas
                        mvarAutorizo = ""
                        oRsAut.MoveFirst
                        Do While Not oRsAut.EOF
                           If mVectorAutorizaciones(j) = oRsAut.Fields("OrdenAutorizacion").Value Then
                              Set oRsEmp = oAp.Empleados.Item(oRsAut.Fields("IdAutorizo").Value).Registro
                              If Not IsNull(oRsEmp.Fields("Iniciales").Value) Then
                                 mvarAutorizo = mvarAutorizo & "" & oRsEmp.Fields("Iniciales").Value
                              End If
                              If Not IsNull(oRsAut.Fields("FechaAutorizacion").Value) Then
                                 mvarAutorizo = mvarAutorizo & " " & oRsAut.Fields("FechaAutorizacion").Value
                              End If
                              oRsEmp.Close
                              If mvarAutorizo = "" Then mvarAutorizo = "???"
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & mvarAutorizo
                              Exit Do
                           End If
                           oRsAut.MoveNext
                        Loop
                        If mvarAutorizo = "" Then
                           oW.Selection.MoveRight Unit:=wdCell
                        End If
                     Next
                  End If
                  oRsAut.Close
         
                  oW.ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
         
                  'Volcado de datos de cabecera del requerimiento
                  mNumero = "" & oRs.Fields("NumeroRequerimiento").Value
                  oW.ActiveDocument.FormFields("Numero").Result = oRs.Fields("NumeroRequerimiento").Value
                  oW.ActiveDocument.FormFields("Fecha").Result = oRs.Fields("FechaRequerimiento").Value
                  If Not IsNull(oRs.Fields("IdSolicito").Value) Then
                     oW.ActiveDocument.FormFields("Solicito").Result = oAp.Empleados.Item(oRs.Fields("IdSolicito").Value).Registro.Fields("Nombre").Value
                  End If
                  If Not IsNull(oRs.Fields("IdSector").Value) Then
                     oW.ActiveDocument.FormFields("Sector").Result = oAp.Sectores.Item(oRs.Fields("IdSector").Value).Registro.Fields("Descripcion").Value
                  End If
                  If Not IsNull(oRs.Fields("IdObra").Value) Then
                     Set oRsObra = oAp.Obras.Item(oRs.Fields("IdObra").Value).Registro
                     oW.ActiveDocument.FormFields("Tipo").Result = "Obra :"
                     If Not IsNull(oRsObra.Fields("NumeroObra").Value) Then
                        mvarObra = "" & oRsObra.Fields("NumeroObra").Value
                        If Not IsNull(oRs.Fields("Consorcial").Value) Then
                           If oRs.Fields("Consorcial").Value = "SI" Then
                              mvarObra = mvarObra & " (Consorcial)"
                           Else
                              mvarObra = mvarObra & " (Cautiva)"
                           End If
                        End If
                        oW.ActiveDocument.FormFields("TipoDes").Result = "" & mvarObra
                     End If
                     If Not IsNull(oRsObra.Fields("Descripcion").Value) Then
                        oW.ActiveDocument.FormFields("TipoDes1").Result = "" & oRsObra.Fields("Descripcion").Value
                     End If
                     oRsObra.Close
                  Else
                     oW.ActiveDocument.FormFields("Tipo").Result = "Centro de costo :"
                     If HayVariosCCostos Then
                        oW.ActiveDocument.FormFields("TipoDes").Result = "<< Varios >>"
                     Else
                        Set oRsCC = oAp.CentrosCosto.Item(oRs.Fields("IdCentroCosto").Value).Registro
                        oW.ActiveDocument.FormFields("TipoDes").Result = "" & oRsCC.Fields("Codigo").Value & " - " & oRsCC.Fields("Descripcion").Value
                        oRsCC.Close
                     End If
                  End If
         
                  oRsDet.Close
         
               End With
                  
            End With
                  
            If Index = 0 Then
               oW.ActiveDocument.PrintOut False, , , , , , , mCopias
               oW.ActiveDocument.Close False
            ElseIf Index = 2 Then
               oW.ActiveDocument.SaveAs app.Path & "\Requerimiento.doc"
            ElseIf Index = 3 Then
               mNumero = Replace(mNumero, "/", "-")
               oW.ActiveDocument.SaveAs mCarpeta & "\RM-" & mNumero & ".doc"
               If mImprime = "SI" Then
                  oW.ActiveDocument.PrintOut False, , , , , , , 1
               End If
               oW.ActiveDocument.Close False
            End If
      
         Next
                  
         oW.Quit

      
      Case "ListasMateriales"

         For i = 0 To UBound(mVectorId)
            
            mvarId = mVectorId(i)
            
            mvarUnidadPeso = ""
            mvarTotalPeso = 0

            With oW
         
               .Visible = True
         
               With .Documents.Add(glbPathPlantillas & "\LMateriales.dot")
            
                  Set oRs = oAp.LMateriales.TraerFiltrado("_PorId", mvarId)
                  Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetLMateriales", "_PorLMat", mvarId)
                  Set oRsRev = oAp.TablasGenerales.TraerFiltrado("DetLMaterialesRevisiones", "AcoRev", mvarId)
                  Set oRsCli = oAp.Clientes.Item(oRs.Fields("IdCliente").Value).Registro
                  
                  ' Armar el detalle
                  oW.Selection.HomeKey Unit:=wdStory
                  oW.Selection.MoveDown Unit:=wdLine, Count:=3
                  oW.Selection.MoveLeft Unit:=wdCell, Count:=1
                   
                  ' estot ubicado al final del texto fijo
                  With oRsDet
                     If .RecordCount > 0 Then
                        .MoveFirst
                        Do Until .EOF
                           If .Fields("NumeroOrden").Value <> 0 Then
                              espacios = "     "
                           Else
                              espacios = ""
                           End If
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & Format(.Fields("NumeroItem").Value, "General Number") & " - " & Format(.Fields("NumeroOrden").Value, "General Number")
                           If Len(Trim(.Fields("Detalle").Value)) <> 0 Then
                              oW.Selection.MoveRight Unit:=wdCell, Count:=7
                              oW.Selection.Font.Bold = True
                              oW.Selection.Font.Size = 12
                              oW.Selection.TypeText Text:="" & .Fields("Detalle").Value
                              oW.Selection.Font.Bold = False
                              oW.Selection.Font.Size = 10
                              oW.Selection.MoveRight Unit:=wdCell, Count:=4
                           Else
                              oW.Selection.MoveRight Unit:=wdCell
                              If IsNull(.Fields("Revision").Value) Then
                                 oW.Selection.TypeText Text:=""
                              Else
                                 oW.Selection.TypeText Text:="" & Format(.Fields("Revision").Value, "General Number")
                              End If
                              oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                              oW.Selection.MoveRight Unit:=wdCell
                              
                              If Not IsNull(.Fields("IdDetalleAcopios").Value) Then
                                 Set oRsAco = oAp.Acopios.TraerFiltrado("_DatosAcopio", .Fields("IdDetalleAcopios").Value)
                                 If oRsAco.RecordCount > 0 Then
                                    oW.Selection.TypeText Text:="" & Format(oRsAco.Fields("NumeroAcopio").Value, "General Number")
                                    oW.Selection.MoveRight Unit:=wdCell
                                    oW.Selection.TypeText Text:="" & Format(oRsAco.Fields("NumeroItem").Value, "General Number")
                                    oW.Selection.MoveRight Unit:=wdCell
                                 Else
                                    oW.Selection.MoveRight Unit:=wdCell
                                    oW.Selection.MoveRight Unit:=wdCell
                                 End If
                                 oRsAco.Close
                              Else
                                 oW.Selection.MoveRight Unit:=wdCell, Count:=2
                              End If
                              
                              oW.Selection.TypeText Text:="" & .Fields("Cantidad").Value
                              oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("IdUnidad").Value), " ", oAp.Unidades.Item(.Fields("IdUnidad").Value).Registro.Fields("Descripcion").Value)
                              oW.Selection.MoveRight Unit:=wdCell
                              
                              mvarMedidas = ""
                              If Not IsNull(.Fields("IdArticulo").Value) Then
                                 Set oRsArt = oAp.Articulos.Item(.Fields("IdArticulo").Value).Registro
                                 If Not IsNull(oRsArt.Fields("IdCuantificacion").Value) Then
                                    If Not IsNull(oRsArt.Fields("Unidad11").Value) Then
                                       mvarUnidad = oAp.Unidades.Item(oRsArt.Fields("Unidad11").Value).Registro.Fields("Abreviatura").Value
                                    End If
                                    Select Case oRsArt.Fields("IdCuantificacion").Value
                                       Case 3
                                          mvarMedidas = "" & .Fields("Cantidad1").Value & " x " & oRsDet.Fields("Cantidad2").Value & " " & mvarUnidad
                                       Case 2
                                          mvarMedidas = "" & .Fields("Cantidad1").Value & " " & mvarUnidad
                                    End Select
                                 End If
                                 oRsArt.Close
                                 oW.Selection.TypeText Text:="" & mvarMedidas
                                 oW.Selection.MoveRight Unit:=wdCell
                                 mvarDescripcion = espacios & oAp.Articulos.Item(.Fields("IdArticulo").Value).Registro.Fields("Descripcion").Value
                              Else
                                 oW.Selection.MoveRight Unit:=wdCell
                                 mvarDescripcion = espacios & .Fields("DescripcionManual").Value & "(*)"
                              End If
                              oW.Selection.Font.Bold = False
                              oW.Selection.Font.Size = 10
                              If Len(Trim(.Fields("Observaciones").Value)) <> 0 Then
                                oF.rchObservaciones.TextRTF = .Fields("Observaciones").Value
                                mvarDescripcion = mvarDescripcion & vbCrLf & oF.rchObservaciones.Text
                              End If
                              oW.Selection.TypeText Text:="" & mvarDescripcion
                              oW.Selection.MoveRight Unit:=wdCell
                              
                              If Not IsNull(.Fields("Peso").Value) Then
                                 If .Fields("Peso").Value <> 0 Then
                                    If Not IsNull(.Fields("IdUnidadPeso").Value) Then
                                       mvarUnidadPeso = oAp.Unidades.Item(.Fields("IdUnidadPeso").Value).Registro.Fields("Abreviatura").Value
                                    End If
                                    oW.Selection.TypeText Text:="" & Int(.Fields("Peso").Value)
                                    oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                                    oW.Selection.MoveRight Unit:=wdCell
                                    oW.Selection.TypeText Text:="" & mvarUnidadPeso
                                    oW.Selection.MoveRight Unit:=wdCell
                                    mvarTotalPeso = mvarTotalPeso + .Fields("Peso").Value
                                 Else
                                    oW.Selection.MoveRight Unit:=wdCell
                                    oW.Selection.MoveRight Unit:=wdCell
                                 End If
                              Else
                                 oW.Selection.MoveRight Unit:=wdCell
                                 oW.Selection.MoveRight Unit:=wdCell
                              End If
                                 
                              If Not IsNull(.Fields("IdControlCalidad").Value) Then
                                 oW.Selection.TypeText Text:="" & oAp.ControlesCalidad.Item(.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value
                              End If
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & .Fields("Adjunto").Value
                              
                              If .Fields("Adjunto").Value = "SI" Then
                                 mAdjuntos = "Arch.Adjunto : "
                                 For j = 1 To 10
                                    If Not IsNull(.Fields("ArchivoAdjunto" & j).Value) Then
                                       If Len(.Fields("ArchivoAdjunto" & j).Value) > 0 And mId(.Fields("ArchivoAdjunto" & j).Value, Len(.Fields("ArchivoAdjunto" & j).Value), 1) <> "\" Then
                                          mAdjuntos = mAdjuntos & Trim(.Fields("ArchivoAdjunto" & j).Value) & ", "
                                       End If
                                    End If
                                 Next
                                 mAdjuntos = mId(mAdjuntos, 1, Len(mAdjuntos) - 2)
                                 oW.Selection.MoveRight Unit:=wdCell, Count:=8
                                 oW.Selection.TypeText Text:="" & mAdjuntos
                                 oW.Selection.MoveRight Unit:=wdCell, Count:=4
                              End If
                           
                           End If
                           
                           .MoveNext
                        Loop
                     End If
                  End With
                   
                  'Observaciones en pie de informe
                  oW.ActiveWindow.View.SeekView = wdSeekEndnotes
                  oW.Selection.MoveDown Unit:=wdLine, Count:=2
                  If Not IsNull(oRs.Fields("Observaciones").Value) Then
                     oF.rchObservaciones.TextRTF = oRs.Fields("Observaciones").Value
                     oW.Selection.TypeText Text:="" & oF.rchObservaciones.Text
                  End If
                  oW.Selection.MoveDown Unit:=wdLine, Count:=4
                  oW.Selection.HomeKey Unit:=wdRow
                  oW.Selection.MoveLeft Unit:=wdCell
                  'Avances
                  If mConSinAviso = "S" Then
                     With oRsRev
                        If oRsRev.State <> adStateClosed Then
                           If .RecordCount > 0 Then
                              .MoveFirst
                              Do Until .EOF
                                 If .Fields("Tipo").Value = "A" Then
                                    If Not IsNull(.Fields("IdDetalleLMateriales").Value) Then
                                    Set oRsAux = oAp.TablasGenerales.TraerFiltrado("DetLMateriales", "_UnItem", .Fields("IdDetalleLMateriales").Value)
                                    If oRsAux.RecordCount > 0 Then
                                       oW.Selection.MoveRight Unit:=wdCell
                                       oW.Selection.TypeText Text:="" & oRsAux.Fields("NumeroItem").Value
                                       oW.Selection.MoveRight Unit:=wdCell
                                       oW.Selection.TypeText Text:="" & oRsAux.Fields("NumeroOrden").Value
                                       oW.Selection.MoveRight Unit:=wdCell
                                       oW.Selection.TypeText Text:="" & oRsAux.Fields("Revision").Value
                                    Else
                                       oW.Selection.MoveRight Unit:=wdCell, Count:=3
                                    End If
                                    oRsAux.Close
                                    Else
                                       oW.Selection.MoveRight Unit:=wdCell, Count:=3
                                    End If
                                    oW.Selection.MoveRight Unit:=wdCell
                                    oW.Selection.TypeText Text:="" & .Fields("Numero").Value
                                    oW.Selection.MoveRight Unit:=wdCell
                                    oW.Selection.TypeText Text:="" & .Fields("Fecha").Value
                                    oW.Selection.MoveRight Unit:=wdCell
                                    oW.Selection.TypeText Text:="" & .Fields("Detalle").Value
                                 End If
                                 .MoveNext
                              Loop
                           End If
                        End If
                     End With
                  Else
                     oW.Selection.Tables(1).Select
                     oW.Selection.Tables(1).Delete
                     oW.Selection.TypeBackspace
                  End If
                  oW.ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
                  
                  'Volcado de revisiones
                  If oW.ActiveWindow.View.SplitSpecial <> wdPaneNone Then
                      oW.ActiveWindow.Panes(2).Close
                  End If
                  oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
                  If oW.Selection.HeaderFooter.IsHeader = True Then
                     oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageFooter
                  Else
                     oW.ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
                  End If
                   
                  oW.Selection.HomeKey Unit:=wdStory
                  oW.Selection.MoveDown Unit:=wdLine, Count:=2
                  oW.Selection.MoveLeft Unit:=wdCell, Count:=1
                  
                  With oRsRev
                     If oRsRev.State <> adStateClosed Then
                        If .RecordCount > 0 Then
                           .MoveFirst
                           Do Until .EOF
                              If Not .Fields("Tipo").Value = "A" Then
                                 oW.Selection.MoveRight Unit:=wdCell
                                 oW.Selection.TypeText Text:="" & .Fields("Numero").Value
                                 oW.Selection.ParagraphFormat.Alignment = wdAlignParagraphRight
                                 oW.Selection.MoveRight Unit:=wdCell
                                 oW.Selection.TypeText Text:="" & .Fields("Fecha").Value
                                 oW.Selection.MoveRight Unit:=wdCell
                                 oW.Selection.TypeText Text:="" & .Fields("Detalle").Value
                                 oW.Selection.MoveRight Unit:=wdCell
                                 If Not IsNull(.Fields("Realizo").Value) Then
                                    oW.Selection.TypeText Text:="" & .Fields("Realizo").Value
                                 End If
                                 oW.Selection.MoveRight Unit:=wdCell
                                 oW.Selection.TypeText Text:="" & .Fields("Fecha realiz.").Value
                                 oW.Selection.MoveRight Unit:=wdCell
                                 If Not IsNull(.Fields("Aprobo").Value) Then
                                    oW.Selection.TypeText Text:="" & .Fields("Aprobo").Value
                                 End If
                                 oW.Selection.MoveRight Unit:=wdCell
                                 oW.Selection.TypeText Text:="" & .Fields("Fecha aprob.").Value
                              End If
                              .MoveNext
                           Loop
                        End If
                     End If
                  End With
                  
                  oW.ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
                   
                  'Registro de numero de paginas, fecha y hora
                  oW.Application.Run MacroName:="DatosDelPie"
                   
                  'Volcado de datos de cabecera de la lista de materiales
                  mNumero = "" & oRs.Fields("NumeroLMateriales").Value
                  oW.ActiveDocument.FormFields("NumeroInterno").Result = "(" & oRs.Fields("NumeroLMateriales").Value & ")"
                  oW.ActiveDocument.FormFields("Numero").Result = oRs.Fields("Nombre").Value
                  oW.ActiveDocument.FormFields("Fecha").Result = oRs.Fields("Fecha").Value
                  oW.ActiveDocument.FormFields("Obra").Result = "" & oAp.Obras.Item(oRs.Fields("IdObra").Value).Registro.Fields("NumeroObra").Value
                  oW.ActiveDocument.FormFields("Equipo").Result = "" & oAp.Equipos.Item(oRs.Fields("IdEquipo").Value).Registro.Fields("Descripcion").Value
                  oW.ActiveDocument.FormFields("Tag").Result = "" & oAp.Equipos.Item(oRs.Fields("IdEquipo").Value).Registro.Fields("Tag").Value
                  oW.ActiveDocument.FormFields("Cliente").Result = IIf(IsNull(oRsCli.Fields("RazonSocial").Value), "", oRsCli.Fields("RazonSocial").Value)
                  Set oRsPlano = Aplicacion.Planos.Item(oRs.Fields("IdPlano").Value).Registro
                  If oRsPlano.RecordCount > 0 Then
                     oW.ActiveDocument.FormFields("Plano").Result = oRsPlano.Fields("NumeroPlano").Value & " - " & oRsPlano.Fields("Descripcion").Value
                  End If
                  oRsPlano.Close
                  If Not IsNull(oRs.Fields("Realizo").Value) Then
                     Set oRsEmp = oAp.Empleados.Item(oRs.Fields("Realizo").Value).Registro
                     If oRsEmp.RecordCount > 0 Then
                        oW.ActiveDocument.FormFields("Realizo").Result = IIf(IsNull(oRsEmp.Fields("Nombre").Value), "", oRsEmp.Fields("Nombre").Value)
                     End If
                     oRsEmp.Close
                  End If
                  If Not IsNull(oRs.Fields("Aprobo").Value) Then
                     Set oRsEmp = oAp.Empleados.Item(oRs.Fields("Aprobo").Value).Registro
                     If oRsEmp.RecordCount > 0 Then
                        oW.ActiveDocument.FormFields("Aprobo").Result = IIf(IsNull(oRsEmp.Fields("Nombre").Value), "", oRsEmp.Fields("Nombre").Value)
                     End If
                     oRsEmp.Close
                  End If
                  oW.ActiveDocument.FormFields("TotalPeso").Result = Format(mvarTotalPeso, "Fixed") & " " & mvarUnidadPeso
                   
                  oRsDet.Close
                  oRsCli.Close
                   
               End With
               
            End With
            
            If Index = 0 Then
               oW.Documents(1).PrintOut False, , , , , , , mCopias
               oW.Documents(1).Close False
            ElseIf Index = 2 Then
               oW.Documents(1).SaveAs app.Path & "\ListaMateriales.doc"
            ElseIf Index = 3 Then
               mNumero = Replace(mNumero, "/", "-")
               oW.Documents(1).SaveAs mCarpeta & "\LM-" & mNumero & ".doc"
               If mImprime = "SI" Then
                  oW.Documents(1).PrintOut False, , , , , , , 1
               End If
               oW.Documents(1).Close False
            End If
      
         Next
                  
         oW.Quit

   
   End Select

Salida:

   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oRsPrv = Nothing
   Set oRsArt = Nothing
   Set oRsEmp = Nothing
   Set oRsAux = Nothing
   Set oRsLMat = Nothing
   Set oRsObra = Nothing
   Set oRsCC = Nothing
   Set oRsFact = Nothing
   Set oRsEqu = Nothing
   Set oRsCli = Nothing
   Set oRsRev = Nothing
   Set oRsAco = Nothing
   Set oRsPlano = Nothing
   Set oRsDetVal = Nothing
   
   Set oW = Nothing
   Set oW1 = Nothing
   
   Set oAp = Nothing
   
   Set cALetra = Nothing
   
   Unload oF
   Set oF = Nothing
   
'   Me.MousePointer = vbDefault

   Exit Sub
   
Mal:
   MsgBox "Se ha producido un problema en la emision del documento" & vbCrLf & Err.Description, vbCritical
   Resume Salida

End Sub

Public Sub ListadoObras(ByVal Documento As String, _
                        ByVal VectorIdDocumento As String, _
                        ByVal Info As String)

   Dim oAp As ComPronto.Aplicacion
   Dim oW As Word.Application
   
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oF As Form
   Dim i As Integer, j As Integer, Index As Integer, mCopias As Integer
   Dim mvarId As Integer
   Dim mCarpeta As String, mImprime As String, mFormulario As String
   Dim mArchivosAdjuntos As String
   Dim mVectorId
   Dim mInfo
   
   On Error GoTo Salida
   
   mVectorId = VBA.Split(VectorIdDocumento, "|")
   mInfo = VBA.Split(Info, "|")
   
   Index = CInt(mInfo(2))
   mCarpeta = mInfo(3)
   mImprime = mInfo(4)
   mCopias = CInt(mInfo(5))
   mFormulario = mInfo(6)
   
   Set oAp = Aplicacion
   Set oF = New frmExcel1
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      With .Documents.Add(glbPathPlantillas & "\" & Documento & ".dot")
         
         For i = 0 To UBound(mVectorId)
      
            mvarId = mVectorId(i)
         
            Set oRs = oAp.Obras.TraerFiltrado("_PorIdObraConDatos", mvarId)
            If oRs.RecordCount > 0 Then
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Obra"
               oW.Selection.Tables(1).Select
               oW.Selection.Copy
               oW.Selection.MoveUp Unit:=wdLine, Count:=1
               oW.Selection.TypeParagraph
               oW.Selection.MoveUp Unit:=wdLine, Count:=1
               oW.Selection.Paste
               oW.Selection.MoveUp Unit:=wdLine, Count:=7

               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & IIf(IsNull(oRs.Fields("NumeroObra").Value), "", oRs.Fields("NumeroObra").Value) & " " & _
                           IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("TipoObra").Value
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("FechaInicio").Value
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("FechaEntrega").Value
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("FechaFinalizacion").Value
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("Cliente").Value
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               If IsNull(oRs.Fields("Activa").Value) Or oRs.Fields("Activa").Value = "SI" Then
                  oW.Selection.TypeText Text:="Activa"
               Else
                  oW.Selection.TypeText Text:="Inactiva"
               End If
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("Jefe de obra").Value
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("Jerarquia").Value
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("UnidadOperativa").Value
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="" & oRs.Fields("GeneraReservaStock").Value
               
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               mArchivosAdjuntos = ""
               For j = 1 To 10
                  If Not IsNull(oRs.Fields("ArchivoAdjunto" & j).Value) Then
                     If Len(oRs.Fields("ArchivoAdjunto" & j).Value) > 0 Then
                        mArchivosAdjuntos = mArchivosAdjuntos & oRs.Fields("ArchivoAdjunto" & i).Value & ", "
                     End If
                  End If
               Next
               If Len(mArchivosAdjuntos) > 0 Then
                  mArchivosAdjuntos = mId(mArchivosAdjuntos, 1, Len(mArchivosAdjuntos) - 2)
               End If
               oW.Selection.TypeText Text:=mArchivosAdjuntos
               
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               If Not IsNull(oRs.Fields("Observaciones").Value) Then
                  If Len(Trim(oRs.Fields("Observaciones").Value)) > 2 Then
                     oF.rchObservaciones.TextRTF = oRs.Fields("Observaciones").Value
                     oW.Selection.TypeText Text:="" & oF.rchObservaciones.Text
                  End If
               End If
               
               Set oRsDet = oAp.Obras.TraerFiltrado("_PolizasPorIdObraConDatos", oRs.Fields(0).Value)
               If oRsDet.RecordCount > 0 Then
                  oW.Selection.Goto What:=wdGoToBookmark, Name:="TituloPolizas"
                  oW.Selection.Tables(1).Select
                  oW.Selection.Copy
                  oW.Selection.Goto What:=wdGoToBookmark, Name:="Obra"
                  oW.Selection.MoveUp Unit:=wdLine, Count:=1
                  oW.Selection.TypeParagraph
                  oW.Selection.MoveUp Unit:=wdLine, Count:=1
                  oW.Selection.Paste
                  oRsDet.MoveFirst
                  Do While Not oRsDet.EOF
                     oW.Selection.Goto What:=wdGoToBookmark, Name:="Polizas"
                     oW.Selection.Tables(1).Select
                     oW.Selection.Copy
                     oW.Selection.Goto What:=wdGoToBookmark, Name:="Obra"
                     oW.Selection.MoveUp Unit:=wdLine, Count:=1
                     oW.Selection.TypeParagraph
                     oW.Selection.MoveUp Unit:=wdLine, Count:=1
                     oW.Selection.Paste
                     oW.Selection.MoveUp Unit:=wdLine, Count:=6
                     
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("Tipo poliza").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("Aseguradora").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & Format(oRsDet.Fields("Importe").Value, "#,##0.00")
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("NumeroPoliza").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("FechaVigencia").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("FechaFinalizacionCobertura").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("FechaVencimientoCuota").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("FechaEstimadaRecupero").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("FechaRecupero").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("CondicionRecupero").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     oW.Selection.TypeText Text:="" & oRsDet.Fields("MotivoDeContratacionSeguro").Value
                     oW.Selection.MoveRight Unit:=wdCell, Count:=2
                     If Not IsNull(oRsDet.Fields("Observaciones").Value) Then
                        If Len(Trim(oRsDet.Fields("Observaciones").Value)) > 2 Then
                           oF.rchObservaciones.TextRTF = oRsDet.Fields("Observaciones").Value
                           oW.Selection.TypeText Text:="" & oF.rchObservaciones.Text
                        End If
                     End If
                     oRsDet.MoveNext
                  Loop
               End If
               oRsDet.Close
            End If
            oRs.Close
            
         Next
         
         oW.Selection.Goto What:=wdGoToBookmark, Name:="Obra"
         oW.Selection.Tables(1).Select
         oW.Selection.Tables(1).Delete
         oW.Selection.Goto What:=wdGoToBookmark, Name:="TituloPolizas"
         oW.Selection.Tables(1).Select
         oW.Selection.Tables(1).Delete
         oW.Selection.Goto What:=wdGoToBookmark, Name:="Polizas"
         oW.Selection.Tables(1).Select
         oW.Selection.Tables(1).Delete

         oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
         oW.Application.Run MacroName:="DatosDelPie"
            
      End With
      
   End With
   
   If Index = 0 Then
      If Len(mInfo(9)) > 0 Then oW.ActivePrinter = mInfo(9)
      oW.Documents(1).PrintOut False, , , , , , , mCopias
      If Len(mInfo(8)) > 0 Then oW.ActivePrinter = mInfo(8)
      oW.Documents(1).Close False
   End If
            
Salida:

   Set oW = Nothing
   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oRsAux = Nothing
   Set oAp = Nothing

   Unload oF
   Set oF = Nothing

End Sub

Public Sub EmisionOrdenPago(ByVal Documento As String, _
                              ByVal VectorIdDocumento As String, _
                              ByVal Info As String)

   Dim oAp As ComPronto.Aplicacion
   Dim oW As Word.Application
   
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oRsPrv As ADOR.Recordset
   Dim oRsDetVal As ADOR.Recordset
   
   Dim oF As Form
   
   Dim cALetra As New clsNum2Let
   
   Dim mPaginas As Integer, i As Integer, j As Integer, Index As Integer
   Dim mCopias As Integer
   Dim mvarLocalidad As String, mvarDescripcion As String, mPlantilla As String
   Dim mCarpeta As String, mImprime As String, mvarMoneda As String
   Dim mConSinAviso As String, mvarDireccion As String, mvarOrigen1 As String
   Dim mvarOrigen2 As String, mvarDescripcionIva As String, mvarNumLet As String
   Dim mvarDocumento As String, mFormulario As String, mDestino As String
   Dim mvarEmiteAsiento As String, mNoMostrarImputaciones As String
   Dim mvarTotalOrdenPago As Double, mvarTotalDebe As Double, mvarTotalValores As Double
   Dim mvarTotalImputaciones As Double, mTotalOPComplementariaFF As Double
   Dim mvarId As Long, mvarCCostos As Long, mIdOPComplementaria As Long
   Dim mNumeroOPComplementariaFF As Long
   Dim mImprimio As Boolean
   Dim mVectorId
   Dim mInfo
   
   On Error GoTo Mal
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   mvarEmiteAsiento = IIf(IsNull(oRs.Fields("EmiteAsientoEnOP").Value), "NO", _
                                       oRs.Fields("EmiteAsientoEnOP").Value)
   oRs.Close
   
   mVectorId = VBA.Split(VectorIdDocumento, "|")
   mInfo = VBA.Split(Info, "|")
   
   Index = CInt(mInfo(2))
   mCarpeta = mInfo(3)
   mImprime = mInfo(4)
   mCopias = CInt(mInfo(5))
   mFormulario = mInfo(6)
   mConSinAviso = mInfo(7)
   
   mNoMostrarImputaciones = BuscarClaveINI("No mostrar imputaciones en OP fondo fijo")
   
   Set oAp = Aplicacion
   Set oF = New frmExcel1
   
   Set oW = CreateObject("Word.Application")
   
   For i = 0 To UBound(mVectorId)
      
      mvarId = mVectorId(i)
      
      With oW

         .Visible = True
         
         With .Documents.Add(glbPathPlantillas & "\OrdenPago.dot")
      
            Set oRs = oAp.OrdenesPago.TraerFiltrado("_PorId", mvarId)
            
            If Not IsNull(oRs.Fields("IdOPComplementariaFF").Value) Then
               Set oRsAux = oAp.OrdenesPago.TraerFiltrado("_PorId", oRs.Fields("IdOPComplementariaFF").Value)
               If oRsAux.RecordCount > 0 Then
                  mNumeroOPComplementariaFF = oRsAux.Fields("NumeroOrdenPago").Value
                  mTotalOPComplementariaFF = oRsAux.Fields("Valores").Value
               End If
               oRsAux.Close
            End If
            
            If oRs.Fields("Tipo").Value = "CC" Then
               mvarDocumento = "ORDEN DE PAGO"
               Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetOrdenesPago", "OrdenPago", mvarId)
            ElseIf oRs.Fields("Tipo").Value = "FF" Then
               mvarDocumento = "ORDEN DE PAGO (FF)"
               If Not IsNull(oRs.Fields("IdOPComplementariaFF").Value) Then
                  mIdOPComplementaria = oRs.Fields("IdOPComplementariaFF").Value
               Else
                  mIdOPComplementaria = -1
               End If
               Set oRsDet = Aplicacion.OrdenesPago.TraerFiltrado("_TraerGastosPorOrdenPago", _
                              Array(mvarId, mIdOPComplementaria, oRs.Fields("IdMoneda").Value))
            ElseIf oRs.Fields("Tipo").Value = "OT" Then
               mvarDocumento = "ORDEN DE PAGO (OTROS)"
               Set oRsDet = oAp.TablasGenerales.TraerFiltrado("AnticiposAlPersonal", "_OPago", mvarId)
            End If
            Set oRsDetVal = Aplicacion.OrdenesPago.TraerFiltrado("_ValoresPorIdOrdenPago", mvarId)
            
            If Not IsNull(oRs.Fields("IdProveedor").Value) Then
               Set oRsPrv = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", oRs.Fields("IdProveedor").Value)
               mvarOrigen1 = "Proveedor : "
               mvarOrigen2 = IIf(IsNull(oRsPrv.Fields("CodigoEmpresa").Value), "", oRsPrv.Fields("CodigoEmpresa").Value)
               mvarOrigen2 = Trim(mvarOrigen2) & " " & IIf(IsNull(oRsPrv.Fields("RazonSocial").Value), "", oRsPrv.Fields("RazonSocial").Value)
               mvarDireccion = IIf(IsNull(oRsPrv.Fields("Direccion").Value), "", oRsPrv.Fields("Direccion").Value)
               mvarLocalidad = IIf(IsNull(oRsPrv.Fields("Localidad").Value), "", oRsPrv.Fields("Localidad").Value)
               mvarLocalidad = Trim(mvarLocalidad) & " " & IIf(IsNull(oRsPrv.Fields("Provincia").Value), "", oRsPrv.Fields("Provincia").Value)
               mvarDescripcionIva = "CUIT : " & IIf(IsNull(oRsPrv.Fields("Cuit").Value), "", oRsPrv.Fields("Cuit").Value)
               mvarDescripcionIva = Trim(mvarDescripcionIva) & " - " & IIf(IsNull(oRsPrv.Fields("CondicionIVA").Value), "", oRsPrv.Fields("CondicionIVA").Value)
               oRsPrv.Close
            ElseIf Not IsNull(oRs.Fields("IdCuenta").Value) Then
               Set oRsAux = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", oRs.Fields("IdCuenta").Value)
               mvarOrigen1 = "Cuenta : "
               If Not IsNull(oRsAux.Fields("Codigo1").Value) Then
                  mvarOrigen2 = "" & oRsAux.Fields("Codigo1").Value
               Else
                  mvarOrigen2 = "" & IIf(IsNull(oRsAux.Fields("Codigo").Value), "", oRsAux.Fields("Codigo").Value)
               End If
               If Not IsNull(oRsAux.Fields("Descripcion1").Value) Then
                  mvarOrigen2 = Trim(mvarOrigen2) & " " & oRsAux.Fields("Descripcion1").Value
               Else
                  mvarOrigen2 = Trim(mvarOrigen2) & " " & IIf(IsNull(oRsAux.Fields("Descripcion").Value), "", oRsAux.Fields("Descripcion").Value)
               End If
               mvarDireccion = ""
               mvarLocalidad = ""
               mvarDescripcionIva = ""
               oRsAux.Close
            Else
               mvarOrigen1 = ""
               mvarOrigen2 = ""
               mvarDireccion = ""
               mvarLocalidad = ""
               mvarDescripcionIva = ""
            End If
            
            oW.Selection.HomeKey Unit:=wdStory
            oW.Selection.MoveDown Unit:=wdLine, Count:=2
            oW.Selection.MoveRight Unit:=wdCell, Count:=1
             
            oW.Selection.TypeText Text:=mvarOrigen1
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & mvarOrigen2
            oW.Selection.MoveDown Unit:=wdLine
            oW.Selection.TypeText Text:="" & mvarDireccion
            oW.Selection.MoveDown Unit:=wdLine
            oW.Selection.TypeText Text:="" & mvarLocalidad
            oW.Selection.MoveDown Unit:=wdLine
            oW.Selection.TypeText Text:="" & mvarDescripcionIva
             
            oW.Selection.Goto What:=wdGoToBookmark, Name:="Imputaciones"
            oW.Selection.MoveDown Unit:=wdLine, Count:=2
            oW.Selection.MoveLeft Unit:=wdCell
            
            mvarTotalImputaciones = 0
            If oRs.Fields("Tipo").Value = "CC" Then
               With oRsDet
                  Do Until .EOF
                     oW.Selection.MoveRight Unit:=wdCell
                     If Not IsNull(.Fields(3).Value) Then
                        oW.Selection.TypeText Text:="" & .Fields(3).Value & "  " & .Fields(4).Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("FechaComprobante").Value), "", .Fields("FechaComprobante").Value)
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("FechaVencimiento").Value), "", .Fields("FechaVencimiento").Value)
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(.Fields(6).Value, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                     Else
                        oW.Selection.TypeText Text:="Anticipo"
                        oW.Selection.MoveRight Unit:=wdCell, Count:=4
                     End If
                     oW.Selection.TypeText Text:="" & Format(.Fields(8).Value, "#,##0.00")
                     mvarTotalImputaciones = mvarTotalImputaciones + .Fields(8).Value
                     .MoveNext
                  Loop
                  .Close
               End With
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Cuentas"
               oW.Selection.Tables(1).Select
               oW.Selection.Tables(1).Delete
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Totales4"
               oW.Selection.Tables(1).Select
               oW.Selection.Tables(1).Delete
               oW.Selection.MoveUp Unit:=wdLine
               oW.Selection.Delete Unit:=wdCharacter, Count:=2
   
            ElseIf oRs.Fields("Tipo").Value = "FF" Then
               If mNoMostrarImputaciones <> "SI" Then
                  With oRsDet
                     Do Until .EOF
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields(1).Value & "  " & .Fields(3).Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields(5).Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields(6).Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(.Fields(12).Value, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(.Fields(12).Value, "#,##0.00")
                        mvarTotalImputaciones = mvarTotalImputaciones + .Fields(12).Value
                        .MoveNext
                     Loop
                     .Close
                  End With
               Else
                  oW.Selection.Goto What:=wdGoToBookmark, Name:="Imputaciones"
                  oW.Selection.Tables(1).Select
                  oW.Selection.Tables(1).Delete
                  oW.Selection.Goto What:=wdGoToBookmark, Name:="Totales1"
                  oW.Selection.Tables(1).Select
                  oW.Selection.Tables(1).Delete
               End If
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Cuentas"
               oW.Selection.Tables(1).Select
               oW.Selection.Tables(1).Delete
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Totales4"
               oW.Selection.Tables(1).Select
               oW.Selection.Tables(1).Delete
               oW.Selection.MoveUp Unit:=wdLine
               oW.Selection.Delete Unit:=wdCharacter, Count:=2
            
            ElseIf oRs.Fields("Tipo").Value = "OT" Then
               With oRsDet
                  If Not .EOF Then
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.MoveUp Unit:=wdLine
                     oW.Selection.MoveLeft Unit:=wdCell
                     oW.Selection.TypeText Text:="Detalle anticipos : "
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="Beneficiario"
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="Cuotas"
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="Detalle"
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="Cta.banco"
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="Anticipo"
                  Else
                     oW.Selection.Goto What:=wdGoToBookmark, Name:="Imputaciones"
                     oW.Selection.Tables(1).Select
                     oW.Selection.Tables(1).Delete
                     oW.Selection.Goto What:=wdGoToBookmark, Name:="Totales1"
                     oW.Selection.Tables(1).Select
                     oW.Selection.Tables(1).Delete
                     oW.Selection.MoveUp Unit:=wdLine
                     oW.Selection.Delete Unit:=wdCharacter, Count:=2
                  End If
                  Do Until .EOF
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="" & .Fields("Legajo").Value & "  " & .Fields("Nombre").Value
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="" & .Fields("Cuotas").Value
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="" & .Fields("Detalle").Value
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="" & .Fields("Cuenta banco").Value
                     oW.Selection.MoveRight Unit:=wdCell
                     oW.Selection.TypeText Text:="" & Format(.Fields("Importe").Value, "#,##0.00")
                     mvarTotalImputaciones = mvarTotalImputaciones + .Fields("Importe").Value
                     .MoveNext
                  Loop
                  .Close
               End With
               
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Cuentas"
               oW.Selection.MoveDown Unit:=wdLine, Count:=2
               oW.Selection.MoveLeft Unit:=wdCell, Count:=1
               mvarTotalDebe = 0
               Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetOrdenesPagoCuentas", "OrdenPago", mvarId)
               With oRsDet
                  If .Fields.Count > 0 Then
                     If .RecordCount > 0 Then
                        Do Until .EOF
                           If Not IsNull(.Fields(5).Value) Then
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & .Fields(3).Value
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & .Fields(4).Value
                              oW.Selection.MoveRight Unit:=wdCell
                              oW.Selection.TypeText Text:="" & Format(.Fields(5).Value, "#,##0.00")
                              mvarTotalDebe = mvarTotalDebe + .Fields(5).Value
                           End If
                           .MoveNext
                        Loop
                     End If
                  End If
                  .Close
               End With
               mvarTotalOrdenPago = mvarTotalValores
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Totales4"
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="Subtotal cuentas : "
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(mvarTotalDebe, "#,##0.00")
               
            End If
            
            If mvarTotalImputaciones <> 0 Then
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Totales1"
               oW.Selection.MoveRight Unit:=wdCell
               If oRs.Fields("Tipo").Value = "OT" Then
                  oW.Selection.TypeText Text:="Subtotal anticipos : "
               Else
                  oW.Selection.TypeText Text:="Subtotal imputaciones : "
               End If
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(mvarTotalImputaciones, "#,##0.00")
            End If
            
            oW.Selection.Goto What:=wdGoToBookmark, Name:="Valores"
            oW.Selection.MoveDown Unit:=wdLine, Count:=2
            oW.Selection.MoveLeft Unit:=wdCell, Count:=1
            mvarTotalValores = 0
            With oRsDetVal
               Do Until .EOF
                  oW.Selection.MoveRight Unit:=wdCell
                  oW.Selection.TypeText Text:="" & .Fields(4).Value
                  oW.Selection.MoveRight Unit:=wdCell
                  oW.Selection.TypeText Text:="" & .Fields(5).Value
                  oW.Selection.MoveRight Unit:=wdCell
                  oW.Selection.TypeText Text:="" & .Fields(6).Value
                  oW.Selection.MoveRight Unit:=wdCell
                  If Not IsNull(.Fields(9).Value) Then
                     oW.Selection.TypeText Text:="" & .Fields(9).Value
                  ElseIf Not IsNull(.Fields(11).Value) Then
                     oW.Selection.TypeText Text:="" & .Fields(11).Value
                  End If
                  oW.Selection.MoveRight Unit:=wdCell
                  oW.Selection.TypeText Text:="" & .Fields(7).Value
                  oW.Selection.MoveRight Unit:=wdCell
                  oW.Selection.TypeText Text:="" & Format(.Fields(10).Value, "#,##0.00")
                  mvarTotalValores = mvarTotalValores + .Fields(10).Value
                  .MoveNext
               Loop
               .Close
            End With
            
            mvarTotalOrdenPago = mvarTotalValores
            oW.Selection.Goto What:=wdGoToBookmark, Name:="Totales2"
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="Subtotal valores : "
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & Format(mvarTotalValores, "#,##0.00")
            
            If Not IsNull(oRs.Fields("Efectivo").Value) Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Efectivo : "
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(oRs.Fields("Efectivo").Value, "#,##0.00")
               mvarTotalOrdenPago = mvarTotalOrdenPago + oRs.Fields("Efectivo").Value
            End If
            If Not IsNull(oRs.Fields("RetencionIVA").Value) Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Retencion IVA : "
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(oRs.Fields("RetencionIVA").Value, "#,##0.00")
               mvarTotalOrdenPago = mvarTotalOrdenPago + oRs.Fields("RetencionIVA").Value
            End If
            If Not IsNull(oRs.Fields("RetencionGanancias").Value) Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Retencion ganancias : "
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(oRs.Fields("RetencionGanancias").Value, "#,##0.00")
               mvarTotalOrdenPago = mvarTotalOrdenPago + oRs.Fields("RetencionGanancias").Value
            End If
            If Not IsNull(oRs.Fields("RetencionIBrutos").Value) Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Retencion ing. Brutos : "
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(oRs.Fields("RetencionIBrutos").Value, "#,##0.00")
               mvarTotalOrdenPago = mvarTotalOrdenPago + oRs.Fields("RetencionIBrutos").Value
            End If
            If Not IsNull(oRs.Fields("RetencionSUSS").Value) Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Retencion SUSS : "
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(oRs.Fields("RetencionSUSS").Value, "#,##0.00")
               mvarTotalOrdenPago = mvarTotalOrdenPago + oRs.Fields("RetencionSUSS").Value
            End If
            If Not IsNull(oRs.Fields("GastosGenerales").Value) Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Devolucion fondo fijo : "
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(oRs.Fields("GastosGenerales").Value * -1, "#,##0.00")
               mvarTotalOrdenPago = mvarTotalOrdenPago + oRs.Fields("GastosGenerales").Value * -1
            End If
            If Not IsNull(oRs.Fields("Descuentos").Value) Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Descuentos : "
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(oRs.Fields("Descuentos").Value, "#,##0.00")
               mvarTotalOrdenPago = mvarTotalOrdenPago + oRs.Fields("Descuentos").Value
            End If
            
            oW.Selection.Goto What:=wdGoToBookmark, Name:="Totales3"
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="Total orden de pago : "
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & Format(mvarTotalOrdenPago, "#,##0.00")
            
            Set oRsAux = oAp.Monedas.TraerFiltrado("_PorId", oRs.Fields("IdMoneda").Value)
            mvarMoneda = ""
            If oRsAux.RecordCount > 0 Then
               mvarMoneda = IIf(IsNull(oRsAux.Fields("Nombre").Value), "", oRsAux.Fields("Nombre").Value)
            End If
            oRsAux.Close
            cALetra.Numero = mvarTotalOrdenPago
            mvarNumLet = cALetra.ALetra
            mvarNumLet = Replace(mvarNumLet, "pesos", mvarMoneda)
            oW.Selection.Goto What:=wdGoToBookmark, Name:="TotalEnLetras"
            oW.Selection.TypeText Text:="Son : " & mvarNumLet
   
            oF.rchObservaciones.TextRTF = IIf(IsNull(oRs.Fields("Observaciones").Value), "", oRs.Fields("Observaciones").Value)
            If Len(Trim(oF.rchObservaciones.Text)) > 2 Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Observaciones : " & mId(oF.rchObservaciones.Text, 1, 255)
            End If
            
            If oRs.Fields("Tipo").Value = "FF" And mNumeroOPComplementariaFF <> 0 Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Orden de pago complementaria : " & mNumeroOPComplementariaFF & _
                        " por $ " & mTotalOPComplementariaFF
            End If
   
            If mInfo(8) = "SI" Then
               oW.Selection.MoveRight Unit:=wdCell, Count:=2
               oW.Selection.TypeText Text:="Cotizacion dolar en pesos : " & oRs.Fields("CotizacionDolar").Value & ".-"
            End If
            
            oW.Selection.Goto What:=wdGoToBookmark, Name:="Rubros"
            oW.Selection.MoveDown Unit:=wdLine, Count:=2
            oW.Selection.MoveLeft Unit:=wdCell, Count:=1
            mImprimio = False
            Set oRsAux = oAp.TablasGenerales.TraerFiltrado("DetOrdenesPagoRubrosContables", "OrdenPago", mvarId)
            With oRsAux
               If .Fields.Count > 0 Then
                  If .RecordCount > 0 Then
                     Do Until .EOF
                        mImprimio = True
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & .Fields(1).Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(.Fields(2).Value, "#,##0.00")
                        .MoveNext
                     Loop
                  End If
               End If
               .Close
            End With
            If Not mImprimio Then
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Rubros"
               oW.Selection.Tables(1).Select
               oW.Selection.Tables(1).Delete
            End If
            
            If mvarEmiteAsiento = "SI" Then
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Cuentas1"
               oW.Selection.MoveDown Unit:=wdLine, Count:=2
               oW.Selection.MoveLeft Unit:=wdCell, Count:=1
               mImprimio = False
               Set oRsAux = oAp.TablasGenerales.TraerFiltrado("DetOrdenesPagoCuentas", "OrdenPago", mvarId)
               With oRsAux
                  If .Fields.Count > 0 Then
                     If .RecordCount > 0 Then
                        Do Until .EOF
                           mImprimio = True
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & .Fields("CodigoCuenta").Value
                           oW.Selection.MoveRight Unit:=wdCell
                           oW.Selection.TypeText Text:="" & .Fields("Cuenta").Value
                           oW.Selection.MoveRight Unit:=wdCell
                           If Not IsNull(.Fields("Debe").Value) And .Fields("Debe").Value <> 0 Then
                              oW.Selection.TypeText Text:="" & Format(.Fields("Debe").Value, "#,##0.00")
                           End If
                           oW.Selection.MoveRight Unit:=wdCell
                           If Not IsNull(.Fields("Haber").Value) And .Fields("Haber").Value <> 0 Then
                              oW.Selection.TypeText Text:="" & Format(.Fields("Haber").Value, "#,##0.00")
                           End If
                           .MoveNext
                        Loop
                     End If
                  End If
                  .Close
               End With
            Else
               oW.Selection.Goto What:=wdGoToBookmark, Name:="Cuentas1"
               oW.Selection.Tables(1).Select
               oW.Selection.Tables(1).Delete
            End If
            
            oW.ActiveDocument.FormFields("Documento").Result = mvarDocumento
            oW.ActiveDocument.FormFields("NumeroOrdenPago").Result = Format(oRs.Fields("NumeroOrdenPago").Value, "000000")
            oW.ActiveDocument.FormFields("Fecha").Result = oRs.Fields("FechaOrdenPago").Value
   
            oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
            oW.Application.Run MacroName:="DatosDelPie"
            
            If Index = 0 Then
               If Len(mInfo(10)) > 0 Then oW.ActivePrinter = mInfo(10)
               oW.Documents(1).PrintOut False, , , , , , , mCopias
               If Len(mInfo(9)) > 0 Then oW.ActivePrinter = mInfo(9)
               oW.Documents(1).Close False
               mDestino = "Printer"
            Else
               mDestino = "Word"
            End If
            
            If Not IsNull(oRs.Fields("RetencionGanancias").Value) And _
                  oRs.Fields("RetencionGanancias").Value <> 0 Then
               EmisionCertificadoRetencionGanancias mvarId, mDestino, mInfo(10)
            End If
            
            If Not IsNull(oRs.Fields("RetencionIVA").Value) And _
                  oRs.Fields("RetencionIVA").Value <> 0 Then
               EmisionCertificadoRetencionIVA mvarId, mDestino, mInfo(10)
            End If
            
            If Not IsNull(oRs.Fields("RetencionIBrutos").Value) And _
                  oRs.Fields("RetencionIBrutos").Value <> 0 Then
               EmisionCertificadoRetencionIIBB mvarId, mDestino, mInfo(10)
            End If
            
            If Not IsNull(oRs.Fields("RetencionSUSS").Value) And _
                  oRs.Fields("RetencionSUSS").Value <> 0 Then
               EmisionCertificadoRetencionSUSS mvarId, mDestino, mInfo(10)
            End If
         
         End With
      
      End With
      
   Next
      
   If Index <> 1 Then
      oW.Quit
   End If

Mal:

   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oRsPrv = Nothing
   Set oRsAux = Nothing
   Set oRsDetVal = Nothing
   
   Set oW = Nothing
   
   Set oAp = Nothing
   
   Set cALetra = Nothing
   
   Unload oF
   Set oF = Nothing
   
End Sub

Public Sub EmisionCertificadoRetencionGanancias(ByVal mIdOrdenPago As String, _
                                                ByVal mDestino As String, _
                                                ByVal mPrinter As String)

   Dim oW As Word.Application
   Dim oRs As ADOR.Recordset
   Dim mNumeroCertificado As Long, mIdProveedor As Long
   Dim mCopias As Integer
   Dim mFecha As Date
   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String
   Dim mCuitSujeto As String, mProvincia As String, mPrinterAnt As String
   Dim mAux1 As String, mAnulada As String
   Dim mRetenido As Double, mCotMon As Double, mMontoOrigen As Double
   
   On Error GoTo Mal
   
   mCopias = 1
   mAux1 = BuscarClaveINI("Copias retenciones en op")
   If IsNumeric(mAux1) Then mCopias = Val(mAux1)
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mIdOrdenPago)
   With oRs
      mComprobante = Format(.Fields("NumeroOrdenPago").Value, "00000000")
      mIdProveedor = .Fields("IdProveedor").Value
      mCotMon = .Fields("CotizacionMoneda").Value
      mFecha = .Fields("FechaOrdenPago").Value
      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
      .Close
   End With
   
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
   If oRs.RecordCount > 0 Then
      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
   End If
   oRs.Close
   Set oRs = Nothing
   
   Set oW = CreateObject("Word.Application")
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoImpuestos", "OrdenPago", mIdOrdenPago)
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If oRs.Fields("Tipo").Value = "Ganancias" And _
                  Not IsNull(oRs.Fields("Certif.Gan.").Value) Then
   
               mNumeroCertificado = oRs.Fields("Certif.Gan.").Value
               mMontoOrigen = oRs.Fields("Pago s/imp.").Value * mCotMon
               mRetenido = oRs.Fields("Retencion").Value * mCotMon
               
               With oW
                  .Visible = True
                  With .Documents.Add(glbPathPlantillas & "\CertificadoRetencionGanancias.dot")
                     oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
                     oW.ActiveDocument.FormFields("Fecha").Result = mFecha
                     oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
                     oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
                     oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
                     oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
                     oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
                     oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
                     oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
                     oW.ActiveDocument.FormFields("Regimen").Result = oRs.Fields("Categoria").Value
                     oW.ActiveDocument.FormFields("MontoOrigen").Result = Format(mMontoOrigen, "$ #,##0.00")
                     oW.ActiveDocument.FormFields("Retencion").Result = Format(mRetenido, "$ #,##0.00")
                     oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
                     mAux1 = BuscarClaveINI("Aclaracion para certificado de retencion de ganancias")
                     If Len(mAux1) > 0 Then
                        oW.ActiveDocument.FormFields("Aclaracion").Result = mAux1
                     End If
                  End With
               End With
            
               If mDestino = "Printer" Then
                  mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
                  If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                  oW.Documents(1).PrintOut False, , , , , , , mCopias
                  If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                  oW.Documents(1).Close False
               End If
            
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   oRs.Close
   
   oW.Selection.HomeKey wdStory

Mal:

   If mDestino = "Printer" Then oW.Quit
   Set oW = Nothing
   Set oRs = Nothing

End Sub

Public Sub EmisionCertificadoRetencionIIBB(ByVal mIdOrdenPago As String, _
                                                ByVal mDestino As String, _
                                                ByVal mPrinter As String)

   Dim oW As Word.Application
   Dim cALetra As New clsNum2Let
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim mNumeroCertificado As Long, mIdProveedor As Long
   Dim mCopias As Integer
   Dim mFecha As Date
   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String
   Dim mCuitSujeto As String, mProvincia As String, mPrinterAnt As String
   Dim mIBNumeroInscripcion As String, mAux1 As String, mPlantilla As String
   Dim mCodPos As String, mImporteLetras As String, mAnulada As String
   Dim mRetenido As Double, mRetencionAdicional As Double, mCotMon As Double
   
   On Error GoTo Mal
   
   mCopias = 1
   mAux1 = BuscarClaveINI("Copias retenciones en op")
   If IsNumeric(mAux1) Then mCopias = Val(mAux1)
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mIdOrdenPago)
   With oRs
      mComprobante = Format(.Fields("NumeroOrdenPago").Value, "00000000")
      mIdProveedor = .Fields("IdProveedor").Value
      mCotMon = .Fields("CotizacionMoneda").Value
      mFecha = .Fields("FechaOrdenPago").Value
      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
      .Close
   End With
   
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
   If oRs.RecordCount > 0 Then
      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
      mIBNumeroInscripcion = IIf(IsNull(oRs.Fields("IBNumeroInscripcion").Value), "", oRs.Fields("IBNumeroInscripcion").Value)
      mCodPos = IIf(IsNull(oRs.Fields("CodigoPostal").Value), "", oRs.Fields("CodigoPostal").Value)
'      If Not IsNull(oRs.Fields("PlantillaRetencionIIBB").Value) Then
'         If Len(RTrim(oRs.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
'            mPlantilla = oRs.Fields("PlantillaRetencionIIBB").Value
'         End If
'      End If
   End If
   oRs.Close
   Set oRs = Nothing
   
   Set oW = CreateObject("Word.Application")
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoImpuestos", "OrdenPago", mIdOrdenPago)
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If oRs.Fields("Tipo").Value = "I.Brutos" And _
                  Not IsNull(oRs.Fields("Certif.IIBB").Value) Then
   
               mNumeroCertificado = oRs.Fields("Certif.IIBB").Value
               mRetenido = oRs.Fields("Retencion").Value * mCotMon
               mRetencionAdicional = IIf(IsNull(oRs.Fields("Impuesto adic.").Value), 0, oRs.Fields("Impuesto adic.").Value) * mCotMon
               
               mPlantilla = "CertificadoRetencionIIBB.dot"
               Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_IdCuentaPorProvincia", oRs.Fields("IdTipoImpuesto").Value)
               If oRsAux.RecordCount > 0 Then
                  If Not IsNull(oRsAux.Fields("PlantillaRetencionIIBB").Value) Then
                     If Len(RTrim(oRsAux.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
                        mPlantilla = oRsAux.Fields("PlantillaRetencionIIBB").Value
                     End If
                  End If
               End If
               oRsAux.Close
               
               With oW
                  .Visible = True
                  With .Documents.Add(glbPathPlantillas & "\" & mPlantilla)
                     
                     If mPlantilla = "CertificadoRetencionIIBB.dot" Then
                        oW.ActiveDocument.FormFields("NumeroCertificado").Result = Format(mNumeroCertificado, "00000000")
                        oW.ActiveDocument.FormFields("Fecha").Result = mFecha
                        oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
                        oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
                        oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
                        oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
                        oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
                        oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
                        oW.ActiveDocument.FormFields("NumeroInscripcion").Result = mIBNumeroInscripcion
                        oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
                  
                        oW.Selection.Goto What:=wdGoToBookmark, Name:="DetalleComprobantes"
                        oW.Selection.MoveDown Unit:=wdLine
                        oW.Selection.MoveLeft Unit:=wdCell
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & oRs.Fields("Categoria").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Pagos mes").Value, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Ret. mes").Value, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & oRs.Fields("% a tomar s/base").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & oRs.Fields("Alicuota.IIBB").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(mRetenido - mRetencionAdicional, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & oRs.Fields("% adic.").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(mRetencionAdicional, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(mRetenido, "#,##0.00")
                     
                        oW.Selection.Goto What:=wdGoToBookmark, Name:="TotalRetencion"
                        oW.Selection.MoveRight Unit:=wdCell, Count:=2
                        oW.Selection.TypeText Text:="" & Format(mRetenido, "#,##0.00")
                     
                     ElseIf mPlantilla = "CertificadoRetencionIIBB_Salta.dot" Then
                        cALetra.Numero = mRetenido
                        mImporteLetras = cALetra.ALetra
                        oW.ActiveDocument.FormFields("NombreSujeto1").Result = mNombreSujeto
                        oW.ActiveDocument.FormFields("CuitSujeto1").Result = mCuitSujeto
                        oW.ActiveDocument.FormFields("DomicilioSujeto1").Result = mDomicilioSujeto
                        oW.ActiveDocument.FormFields("CodigoPostal1").Result = mCodPos
                        oW.ActiveDocument.FormFields("Monto1").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
                        oW.ActiveDocument.FormFields("Alicuota1").Result = oRs.Fields("Alicuota.IIBB").Value
                        oW.ActiveDocument.FormFields("Retencion1").Result = mRetenido
                        oW.ActiveDocument.FormFields("ImporteEnLetras1").Result = mImporteLetras
                        oW.ActiveDocument.FormFields("Fecha1").Result = mFecha
                        
                        oW.ActiveDocument.FormFields("NombreSujeto2").Result = mNombreSujeto
                        oW.ActiveDocument.FormFields("CuitSujeto2").Result = mCuitSujeto
                        oW.ActiveDocument.FormFields("DomicilioSujeto2").Result = mDomicilioSujeto
                        oW.ActiveDocument.FormFields("CodigoPostal2").Result = mCodPos
                        oW.ActiveDocument.FormFields("Monto2").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
                        oW.ActiveDocument.FormFields("Alicuota2").Result = oRs.Fields("Alicuota.IIBB").Value
                        oW.ActiveDocument.FormFields("Retencion2").Result = mRetenido
                        oW.ActiveDocument.FormFields("ImporteEnLetras2").Result = mImporteLetras
                        oW.ActiveDocument.FormFields("Fecha2").Result = mFecha
                     
                        oW.ActiveDocument.FormFields("NombreSujeto3").Result = mNombreSujeto
                        oW.ActiveDocument.FormFields("CuitSujeto3").Result = mCuitSujeto
                        oW.ActiveDocument.FormFields("DomicilioSujeto3").Result = mDomicilioSujeto
                        oW.ActiveDocument.FormFields("CodigoPostal3").Result = mCodPos
                        oW.ActiveDocument.FormFields("Monto3").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
                        oW.ActiveDocument.FormFields("Alicuota3").Result = oRs.Fields("Alicuota.IIBB").Value
                        oW.ActiveDocument.FormFields("Retencion3").Result = mRetenido
                        oW.ActiveDocument.FormFields("ImporteEnLetras3").Result = mImporteLetras
                        oW.ActiveDocument.FormFields("Fecha3").Result = mFecha
                     
                     End If
            
                  End With
               End With
               
               If mDestino = "Printer" Then
                  mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
                  If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                  oW.Documents(1).PrintOut False, , , , , , , mCopias
                  If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                  oW.Documents(1).Close False
               End If
               
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   oRs.Close
   
   oW.Selection.HomeKey wdStory

Mal:

   If mDestino = "Printer" Then oW.Quit
   Set oW = Nothing
   Set oRs = Nothing
   Set oRsAux = Nothing
   Set cALetra = Nothing
   
End Sub

Public Sub EmisionCertificadoRetencionIVA(ByVal mIdOrdenPago As String, _
                                                ByVal mDestino As String, _
                                                ByVal mPrinter As String)

   Dim oW As Word.Application
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim mNumeroCertificado As Long, mIdProveedor As Long
   Dim mCopias As Integer
   Dim mFecha As Date
   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String
   Dim mCuitSujeto As String, mProvincia As String, mPrinterAnt As String
   Dim mAux1 As String, mAnulada As String
   Dim mRetenido As Double, mCotMon As Double
   
   On Error GoTo Mal
   
   mCopias = 1
   mAux1 = BuscarClaveINI("Copias retenciones en op")
   If IsNumeric(mAux1) Then mCopias = Val(mAux1)
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mIdOrdenPago)
   With oRs
      mNumeroCertificado = .Fields("NumeroCertificadoRetencionIVA").Value
      mComprobante = Format(.Fields("NumeroOrdenPago").Value, "00000000")
      mIdProveedor = .Fields("IdProveedor").Value
      mCotMon = .Fields("CotizacionMoneda").Value
      mFecha = .Fields("FechaOrdenPago").Value
      mRetenido = .Fields("RetencionIVA").Value * mCotMon
      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
      .Close
   End With
   
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
   If oRs.RecordCount > 0 Then
      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
   End If
   oRs.Close
   Set oRs = Nothing
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      With .Documents.Add(glbPathPlantillas & "\CertificadoRetencionIVA.dot")
         oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
         oW.ActiveDocument.FormFields("Fecha").Result = mFecha
         oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
         oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
         oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
         oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
         oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
         oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
'         oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
         oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
      End With
   End With

   Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPago", "OrdenPago", mIdOrdenPago)
   oW.Selection.Goto What:=wdGoToBookmark, Name:="DetalleComprobantes"
   oW.Selection.MoveDown Unit:=wdLine
   oW.Selection.MoveLeft Unit:=wdCell
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("Ret.Iva").Value) And .Fields("Ret.Iva").Value <> 0 Then
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & .Fields("Comp.").Value & " " & _
                     .Fields("Numero").Value
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & .Fields("Fecha").Value
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Round(.Fields("Tot.Comp.").Value * IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value), 2)
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Round(.Fields("IVA").Value * IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value), 2)
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & .Fields("Ret.Iva").Value * mCotMon
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRsDet = Nothing

   oW.Selection.Goto What:=wdGoToBookmark, Name:="TotalRetencion"
   oW.Selection.MoveRight Unit:=wdCell, Count:=2
   oW.Selection.TypeText Text:="" & Format(mRetenido, "#,##0.00")

   If mDestino = "Printer" Then
      mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
      If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
      oW.Documents(1).PrintOut False, , , , , , , mCopias
      If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
      oW.Documents(1).Close False
   End If
   
   oW.Selection.HomeKey wdStory

Mal:

   If mDestino = "Printer" Then oW.Quit
   Set oW = Nothing

End Sub

Public Sub EmisionCertificadoRetencionSUSS(ByVal mIdOrdenPago As String, _
                                                ByVal mDestino As String, _
                                                ByVal mPrinter As String)

   Dim oW As Word.Application
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim mNumeroCertificado As Long, mIdProveedor As Long
   Dim mCopias As Integer
   Dim mFecha As Date
   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String
   Dim mCuitSujeto As String, mProvincia As String, mPrinterAnt As String
   Dim mAux1 As String, mAnulada As String
   Dim mRetenido As Double, mCotMon As Double, mvarPorcentajeRetencionSUSS As Double
   Dim mvarBaseCalculoSUSS As Double
   
   On Error GoTo Mal
   
   mCopias = 1
   mAux1 = BuscarClaveINI("Copias retenciones en op")
   If IsNumeric(mAux1) Then mCopias = Val(mAux1)
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   mvarPorcentajeRetencionSUSS = IIf(IsNull(oRs.Fields("PorcentajeRetencionSUSS").Value), 0, _
                                       oRs.Fields("PorcentajeRetencionSUSS").Value)
   oRs.Close
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mIdOrdenPago)
   With oRs
      mNumeroCertificado = .Fields("NumeroCertificadoRetencionSUSS").Value
      mComprobante = Format(.Fields("NumeroOrdenPago").Value, "00000000")
      mIdProveedor = .Fields("IdProveedor").Value
      mCotMon = .Fields("CotizacionMoneda").Value
      mFecha = .Fields("FechaOrdenPago").Value
      mRetenido = .Fields("RetencionSUSS").Value * mCotMon
      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
      .Close
   End With
   
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
   If oRs.RecordCount > 0 Then
      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
      If Not IsNull(oRs.Fields("IdImpuestoDirectoSUSS").Value) Then
         Set oRsAux = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorId", _
                           oRs.Fields("IdImpuestoDirectoSUSS").Value)
         If oRsAux.RecordCount > 0 Then
            mvarPorcentajeRetencionSUSS = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
         End If
         oRsAux.Close
      End If
   End If
   oRs.Close
   
   Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPago", "OrdenPago", mIdOrdenPago)
   mvarBaseCalculoSUSS = 0
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("s/impuesto").Value) And .Fields("Gravado IVA").Value <> 0 Then
               mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + .Fields("Gravado IVA").Value
            Else
               mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + .Fields("Importe").Value
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      With .Documents.Add(glbPathPlantillas & "\CertificadoRetencionSUSS.dot")
         oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
         oW.ActiveDocument.FormFields("Fecha").Result = mFecha
         oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
         oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
         oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
         oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
         oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
         oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
         oW.ActiveDocument.FormFields("Comprobante").Result = "OP " & mComprobante
         oW.ActiveDocument.FormFields("Porcentaje").Result = mvarPorcentajeRetencionSUSS
         oW.ActiveDocument.FormFields("BaseCalculoSUSS").Result = Format(mvarBaseCalculoSUSS, "#,##0.00")
         oW.ActiveDocument.FormFields("Retenido").Result = Format(mRetenido, "#,##0.00")
         oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
      End With
   End With
   
   oW.Selection.HomeKey wdStory

   If mDestino = "Printer" Then
      mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
      If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
      oW.Documents(1).PrintOut False, , , , , , , mCopias
      If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
      oW.Documents(1).Close False
   End If

Mal:
   
   If mDestino = "Printer" Then oW.Quit
   Set oW = Nothing
   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oRsAux = Nothing
   
End Sub

Public Function GeneraImputacionesBis(ByVal mIdPedido As Long) As String

   Dim oAp As ComPronto.Aplicacion
   Dim oRsDet As ADOR.Recordset
   Dim i As Integer
   Dim mvarDes As String, mvarVal As String
   Dim cCContable As Contenedor
   
   Set oAp = Aplicacion
   
   Set cCContable = New Contenedor
   
   Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetPedidos", "Ped", mIdPedido)
         
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do Until .EOF
            If Not IsNull(.Fields("IdCuenta").Value) Then
               mvarDes = oAp.Cuentas.Item(.Fields("IdCuenta").Value).Registro.Fields("Codigo").Value
               mvarVal = cCContable.Valor(mvarDes) & "" & .Fields("Item").Value & ", "
               cCContable.NuevaVar mvarDes, .Fields("IdCuenta").Value, ""
               cCContable.NuevoValor mvarDes, mvarVal
            Else
               mvarDes = "Sin Cuenta"
               mvarVal = cCContable.Valor(mvarDes) & "" & .Fields("Item").Value & ", "
               cCContable.NuevaVar mvarDes, 0, ""
               cCContable.NuevoValor mvarDes, mvarVal
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
          
   mvarDes = ""
   For i = 1 To cCContable.CuentaVar
      mvarDes = mvarDes & cCContable.NombreVar(i) & ", Items : " & IIf(Len(cCContable.Valor(i)) = 0, "", mId(cCContable.Valor(i), 1, Len(cCContable.Valor(i)) - 1)) & vbCrLf
   Next

   Set oRsDet = Nothing
   Set cCContable = Nothing
   Set oAp = Nothing
   
   GeneraImputacionesBis = mvarDes
   
End Function

Public Function GeneraInspeccionesBis(ByVal mIdPedido As Long) As String

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset, oRsDet As ADOR.Recordset, oRsCalidad As ADOR.Recordset
   Dim i As Integer, Contador As Integer
   Dim mvarDes As String, mvarVal As String
   Dim cCCalidad As Contenedor
   Dim oPar As ComPronto.Parametro
   Dim oF As Form
   
   Set oF = New frmInformacion
   
   Set oAp = Aplicacion
   
   Contador = 1
   
   Set cCCalidad = New Contenedor
   
   Set oRsDet = oAp.TablasGenerales.TraerFiltrado("DetPedidos", "Ped", mIdPedido)
         
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do Until .EOF
            If Not IsNull(.Fields("IdControlCalidad").Value) Then
               Set oRsCalidad = oAp.ControlesCalidad.Item(.Fields("IdControlCalidad").Value).Registro
               mvarDes = ""
               If Not IsNull(oRsCalidad.Fields("Detalle").Value) Then
                  oF.rchObservaciones.TextRTF = oRsCalidad.Fields("Detalle").Value
                  mvarDes = oF.rchObservaciones.Text
               End If
               oRsCalidad.Close
               mvarVal = cCCalidad.Valor(mvarDes) & "" & .Fields("Item").Value & ", "
               cCCalidad.NuevaVar mvarDes, .Fields("IdControlCalidad").Value, ""
               cCCalidad.NuevoValor mvarDes, mvarVal
            Else
               mvarDes = "Sin C.C."
               mvarVal = cCCalidad.Valor(mvarDes) & "" & .Fields("Item").Value & ", "
               cCCalidad.NuevaVar mvarDes, 0, ""
               cCCalidad.NuevoValor mvarDes, mvarVal
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
          
   Set oPar = oAp.Parametros.Item(1)
   mvarDes = "5.1 "
   If Not IsNull(oPar.Registro.Fields("PedidosInspecciones").Value) Then
      oF.rchObservaciones.TextRTF = oPar.Registro.Fields("PedidosInspecciones").Value
      mvarDes = mvarDes & oF.rchObservaciones.Text & vbCrLf
   End If
   Set oPar = Nothing
   For i = 1 To cCCalidad.CuentaVar
      Contador = Contador + 1
      mvarDes = mvarDes & "5." & Contador & " " & cCCalidad.NombreVar(i) & _
               ", Items : " & IIf(Len(cCCalidad.Valor(i)) = 0, "", mId(cCCalidad.Valor(i), 1, Len(cCCalidad.Valor(i)) - 1)) & vbCrLf
   Next

   Unload oF
   Set oF = Nothing
   
   Set oRsDet = Nothing
   Set oRsCalidad = Nothing
   Set cCCalidad = Nothing
   Set oAp = Nothing
   
   GeneraInspeccionesBis = mvarDes
   
End Function

Public Function DefinirAdministrador() As Boolean

   Dim oF As frmAutorizacion
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .Administradores = True
      .Show vbModal
   End With
   DefinirAdministrador = oF.Ok
   Unload oF
   Set oF = Nothing

End Function

Public Function Crypt(texti, salasana) As String

   Dim t As Integer, TT As Integer, X1 As Integer, G As Integer, sana As Integer
   Dim Crypted As String
   
   On Error Resume Next

   For t = 1 To Len(salasana)
      sana = Asc(mId(salasana, t, 1))
      X1 = X1 + sana
   Next

   X1 = Int((X1 * 0.1) / 6)
   salasana = X1
   G = 0

   For TT = 1 To Len(texti)
      sana = Asc(mId(texti, TT, 1))
      G = G + 1
      If G = 6 Then G = 0
      X1 = 0
      If G = 0 Then X1 = sana - (salasana - 2)
      If G = 1 Then X1 = sana + (salasana - 5)
      If G = 2 Then X1 = sana - (salasana - 4)
      If G = 3 Then X1 = sana + (salasana - 2)
      If G = 4 Then X1 = sana - (salasana - 3)
      If G = 5 Then X1 = sana + (salasana - 5)
      X1 = X1 + G
      Crypted = Crypted & Chr(X1)
   Next

   Crypt = Crypted

End Function

Public Function DeCrypt(texti, salasana) As String

   Dim t As Integer, TT As Integer, X1 As Integer, G As Integer, sana As Integer
   Dim DeCrypted As String
   
   On Error Resume Next

   For t = 1 To Len(salasana)
      sana = Asc(mId(salasana, t, 1))
      X1 = X1 + sana
   Next

   X1 = Int((X1 * 0.1) / 6)
   salasana = X1
   G = 0

   For TT = 1 To Len(texti)
      sana = Asc(mId(texti, TT, 1))
      G = G + 1
      If G = 6 Then G = 0
      X1 = 0
      If G = 0 Then X1 = sana + (salasana - 2)
      If G = 1 Then X1 = sana - (salasana - 5)
      If G = 2 Then X1 = sana + (salasana - 4)
      If G = 3 Then X1 = sana - (salasana - 2)
      If G = 4 Then X1 = sana + (salasana - 3)
      If G = 5 Then X1 = sana - (salasana - 5)
      X1 = X1 - G
      DeCrypted = DeCrypted & Chr(X1)
   Next

   DeCrypt = DeCrypted

End Function

Public Function AccesoHabilitado(ByVal CadenaAutorizacion As String, _
                                 ByVal FechaControl As Date) As Boolean

   If Len(CadenaAutorizacion) = 0 Then
      AccesoHabilitado = False
   Else
      Dim mVector
      mVector = VBA.Split(CadenaAutorizacion, "|")
      AccesoHabilitado = True
      If Date < CDate(mVector(0)) Or Date > CDate(mVector(1)) Then
         AccesoHabilitado = False
      ElseIf FechaControl < CDate(mVector(2)) Then
         AccesoHabilitado = False
      End If
   End If

End Function

Public Sub ControlTabuladosInput(ByRef oForm As Form)

   Dim oCtrl As Control
   Dim oRs As ADOR.Recordset
   Dim objName As String, mIndex As String, mEnabled As String, mTag As String
   Dim mContador As Integer, mIndex1 As Integer, mTabIndex As Integer, mLeft As Integer
   Dim mTop As Integer
   
   On Error Resume Next
   
   mContador = 1
   For Each oCtrl In oForm.Controls
      Select Case TypeName(oCtrl)
         Case "CommandButton", "ComboBox", "DataCombo", "ListBox", _
               "DBListView", "TextBox", "CheckBox", "OptionButton", _
               "DTPicker", "RichTextBox"
            If (oCtrl.Visible Or (Not oCtrl.Visible And oForm.Name = "frmComprobantesPrv" And oCtrl.Name = "dcfields")) And _
                  oCtrl.Name <> "Command1" And _
                  mId(oCtrl.Name, 1, 6) <> "txtTab" Then
               mIndex = ""
               mIndex = "" & oCtrl.Index
               If mIndex = "" Then
                  mIndex1 = -1
               Else
                  mIndex1 = CInt(mIndex)
               End If
               If oCtrl.Enabled Then
                  mEnabled = "V"
               Else
                  mEnabled = "F"
               End If
               mTag = "" & oCtrl.Name & "|" & mIndex1 & "|" & mEnabled
               objName = ""
               If Not ExisteControlTabulado(oForm, mTag, objName) Then
                  objName = "txtTab" & mContador
                  oForm.Controls.Add "VB.TextBox", objName
                  mContador = mContador + 1
               End If
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("FormulariosTabIndex", _
                           "_PorFormularioControl", Array(oForm.Name, oCtrl.Name, mIndex1))
               mTabIndex = oCtrl.TabIndex
               If oRs.RecordCount > 0 Then
                  mTabIndex = oRs.Fields("TabIndex").Value
               End If
               oRs.Close
               mLeft = oCtrl.Left
               mTop = oCtrl.TOp
               If oCtrl.Container.Name <> oForm.Name Then
                  mLeft = (mLeft / 20) + oCtrl.Container.Left
                  mTop = (mTop / 35) + oCtrl.Container.TOp
               End If
               With oForm.Controls(objName)
                  .Tag = mTag
                  .Left = mLeft
                  .TOp = mTop
                  .Width = 25
                  .Height = 8
                  .Text = mTabIndex
                  .BackColor = &HC0FFFF
                  .Enabled = True
                  .Locked = False
                  .Visible = True
               End With
               oCtrl.Visible = False
            End If
      End Select
   Next
   
   For Each oCtrl In oForm.Controls
      If TypeName(oCtrl) = "Frame" Or oCtrl.Name = "lblComprobante" Then
         oCtrl.Visible = False
      End If
   Next
   
   Set oRs = Nothing

End Sub

Public Sub ControlTabuladosOutput(ByRef oForm As Form)

   Dim oCtrl As Control, oCtrl1 As Control
   Dim objName As String, Enabled As String
   Dim mIndex As Integer
   Dim mProcesar As Boolean, mEnabled As Boolean
   Dim mVector
   
'   On Error Resume Next
   
   Aplicacion.Tarea "FormulariosTabIndex_BorrarRegistrosDeUnFormulario", Array(oForm.Name)
   
   For Each oCtrl In oForm.Controls
      If mId(oCtrl.Name, 1, 6) = "txtTab" Then
         mVector = VBA.Split(oCtrl.Tag, "|")
         objName = mVector(0)
         mIndex = CInt(mVector(1))
         If mVector(2) = "V" Then
            mEnabled = True
         Else
            mEnabled = False
         End If
         For Each oCtrl1 In oForm.Controls
            If oCtrl1.Name = objName Then
               mProcesar = False
               If mIndex = -1 Then
                  mProcesar = True
               Else
                  If oCtrl1.Index = mIndex Then
                     mProcesar = True
                  End If
               End If
               If mProcesar Then
                  oCtrl1.TabIndex = oCtrl.TabIndex
                  oCtrl1.Enabled = mEnabled
                  oCtrl1.Visible = True
                  Aplicacion.Tarea "FormulariosTabIndex_Agregar", _
                        Array(oForm.Name, objName, mIndex, oCtrl.Text)
                  Exit For
               End If
            End If
         Next
         oCtrl.Visible = False
      End If
   Next

   For Each oCtrl In oForm.Controls
      If TypeName(oCtrl) = "Frame" Then
         oCtrl.Visible = True
      End If
   Next
   
End Sub

Public Function ExisteControlTabulado(ByRef oForm As Form, _
                                       ByVal mTag As String, _
                                       ByRef objName As String) As Boolean

   Dim oCtrl As Control
   Dim mExiste As Boolean
   
   mExiste = False
   For Each oCtrl In oForm.Controls
      If mId(oCtrl.Name, 1, 6) = "txtTab" And oCtrl.Tag = mTag Then
         objName = oCtrl.Name
         mExiste = True
         Exit For
      End If
   Next
   
   ExisteControlTabulado = mExiste

End Function

Public Function ExisteControlEnFormulario(ByRef oForm As Form, _
                                          ByRef objName As String) As Boolean

   Dim oCtrl As Control
   Dim mExiste As Boolean
   
   mExiste = False
   For Each oCtrl In oForm.Controls
      If oCtrl.Name = objName Then
         mExiste = True
         Exit For
      End If
   Next
   
   ExisteControlEnFormulario = mExiste

End Function

Public Sub AsignarTabulados(ByRef oForm As Form)

   Dim oCtrl As Control
   Dim oRs As ADOR.Recordset
   Dim mProcesar As Boolean
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("FormulariosTabIndex", "_PorFormulario", oForm.Name)
   
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         For Each oCtrl In oForm.Controls
            If oCtrl.Name = oRs.Fields("Control").Value Then
               mProcesar = False
               If oRs.Fields("Subindice").Value = -1 Then
                  mProcesar = True
               Else
                  If oCtrl.Index = oRs.Fields("Subindice").Value Then
                     mProcesar = True
                  End If
               End If
               If mProcesar Then
                  oCtrl.TabIndex = 0
                  Exit For
               End If
            End If
         Next
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Public Sub ArmarSaldosTransaccionAFecha(ByVal Fecha As Date)

   Dim oRsCtaCte As ADOR.Recordset
   Dim mPosTrs As Long, mPos As Long, mIdCtaCte As Long, mIdProveedor As Long
   Dim Trs As Long
   Dim mSaldo As Double, mSaldoAux As Double
   
   'Set oRsCtaCte = CopiarTodosLosRegistros(Aplicacion.CtasCtesA.TraerFiltrado("_PorTrsParaCubo", Fecha))
   
   mIdProveedor = -9
   Trs = -9
   
   With oRsCtaCte
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            
            If mIdProveedor <> .Fields("IdProveedor").Value Or _
                  Trs <> IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value) Then
               mIdProveedor = .Fields("IdProveedor").Value
               Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value)
               mPosTrs = .AbsolutePosition
            End If
            
'If Trs = 3291 Then
'   Trs = Trs
'End If
            
            mSaldo = IIf(IsNull(.Fields("Saldo").Value), 0, .Fields("Saldo").Value)
            If mSaldo <> 0 Then
               mIdCtaCte = .Fields(1).Value
               mPos = .AbsolutePosition
               .AbsolutePosition = mPosTrs
               Do While Not .EOF

'If .Fields("IdCtaCte").Value = 2855 Then
'   Trs = Trs
'End If
                  
                  If mIdProveedor = .Fields("IdProveedor").Value And _
                        Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value) Then
                     If IIf(IsNull(.Fields("Saldo").Value), 0, .Fields("Saldo").Value) <> 0 And _
                           mIdCtaCte <> .Fields(1).Value And mSaldo <> 0 Then
                        mSaldoAux = IIf(IsNull(.Fields("Saldo").Value), 0, .Fields("Saldo").Value)
                        If mSaldo > 0 And mSaldoAux < 0 Then
                           If Abs(mSaldo) > Abs(mSaldoAux) Then
                              mSaldo = mSaldo - Abs(mSaldoAux)
                              .Fields("Saldo").Value = 0
                           Else
                              .Fields("Saldo").Value = mSaldoAux + mSaldo
                              mSaldo = 0
                           End If
                        ElseIf mSaldo < 0 And mSaldoAux > 0 Then
                           If Abs(mSaldo) > Abs(mSaldoAux) Then
                              mSaldo = mSaldo + mSaldoAux
                              .Fields("Saldo").Value = 0
                           Else
                              .Fields("Saldo").Value = mSaldoAux + mSaldo
                              mSaldo = 0
                           End If
                        End If
                        .Update
                     End If
                  Else
                     Exit Do
                  End If
                  .MoveNext
               Loop
               .AbsolutePosition = mPos
               .Fields("Saldo").Value = mSaldo
               .Update
            End If
            
            .MoveNext
         Loop
      End If
   End With
   
   If oRsCtaCte.RecordCount > 0 Then
      oRsCtaCte.MoveFirst
   End If
   
   Aplicacion.Tarea "_TempCuentasCorrientesAcreedores_BorrarTabla"
   Aplicacion.TablasGenerales.ActualizacionEnLotes "_TempCuentasCorrientesAcreedores", oRsCtaCte
   
   Set oRsCtaCte = Nothing

End Sub

Public Sub ProcesarINI(ByRef mForm As Form)

   Select Case mForm.Name
   
      Case "frmComprobantesPrv"
      
         If BuscarClaveINI("Waldbott") = "SI" Then
            mForm.rchObservaciones.Height = mForm.rchObservaciones.Height / 2
            mForm.lblCAI1.TOp = mForm.rchObservaciones.TOp + mForm.rchObservaciones.Height + 100
            mForm.txtNumeroCAI.TOp = mForm.lblCAI1.TOp
            mForm.lblCAI2.TOp = mForm.lblCAI1.TOp
            mForm.DTFields(3).TOp = mForm.lblCAI1.TOp
            mForm.lblAuxiliar1.Visible = True
            mForm.txtInformacionAuxiliar.Visible = True
            With mForm.lblAuxiliar2
               .TOp = mForm.txtNumeroCAI.TOp + mForm.txtNumeroCAI.Height + 100
               .Visible = True
            End With
            With mForm.txtGravadoParaSUSS
               .TOp = mForm.lblAuxiliar2.TOp
               .Visible = True
            End With
            With mForm.lblAuxiliar3
               .TOp = mForm.lblAuxiliar2.TOp
               .Visible = True
            End With
            With mForm.txtPorcentajeParaSUSS
               .TOp = mForm.lblAuxiliar2.TOp
               .Visible = True
            End With
         End If
      
         If BuscarClaveINI("Fondo reparo") = "SI" Then
            mForm.Label2.Visible = True
            mForm.txtFondoReparo.Visible = True
         End If
      
   End Select

End Sub

Public Function BuscarClaveINI(ByVal mClave As String) As String

   Dim Arch As String
   Dim INI As INIFile, mSection As INISection, mValue As INIValue

   Arch = app.Path & "\Pronto.ini"
   If Len(Trim(Dir(Arch))) = 0 Then
      Exit Function
   End If

   Set INI = New INIFile
   INI.Filename = Arch

   For Each mSection In INI.Sections
      If UCase(mSection.SectionName) = UCase(glbEmpresaSegunString) Then
         For Each mValue In mSection.Values
            If mValue.ValueName = mClave Then
               BuscarClaveINI = mValue.Value
               GoTo Salida
            End If
         Next
      End If
   Next

   BuscarClaveINI = ""

Salida:

   Set mValue = Nothing
   Set mSection = Nothing
   Set INI = Nothing
   
'   Dim oRs As ADOR.Recordset
'   Dim s As String
'
'   s = ""
'
'   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("ProntoIni", "_PorClave", Array(mClave, glbIdUsuario))
'   If oRs.RecordCount > 0 Then
'      s = IIf(IsNull(oRs.Fields("Valor").Value), "", oRs.Fields("Valor").Value)
'   End If
'   oRs.Close
'   Set oRs = Nothing
'
'   BuscarClaveINI = s

End Function

Public Function CircuitoFirmasCompleto(ByVal Comprobante As EnumFormularios, _
                                       ByVal IdComprobante As Long, _
                                       Optional ByVal Importe As Double) As Boolean

   Dim oRsAut1 As ADOR.Recordset
   Dim oRsAut2 As ADOR.Recordset
   Dim mCompleto As Boolean
   Dim mCantidadFirmas As Integer, i As Integer
   Dim mFirmas() As Boolean
   
   mCompleto = False
   
   Set oRsAut1 = Aplicacion.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(Comprobante, Importe))
   
   If oRsAut1.RecordCount > 0 Then
   
      mCantidadFirmas = oRsAut1.RecordCount
      ReDim mFirmas(mCantidadFirmas)
      For i = 1 To mCantidadFirmas
         mFirmas(i) = False
      Next
   
      Set oRsAut2 = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(Comprobante, IdComprobante))
      With oRsAut2
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               oRsAut1.MoveFirst
               Do While Not oRsAut1.EOF
                  If oRsAut1.Fields(0).Value = .Fields("OrdenAutorizacion").Value Then
                     mFirmas(oRsAut1.AbsolutePosition) = True
                     Exit Do
                  End If
                  oRsAut1.MoveNext
               Loop
               .MoveNext
            Loop
         End If
         oRsAut2.Close
      End With
   
      CircuitoFirmasCompleto = True
      
      If Comprobante = RequerimientoMateriales Then
         Set oRsAut2 = Aplicacion.Requerimientos.TraerFiltrado("_PorId", IdComprobante)
         If oRsAut2.RecordCount > 0 Then
            If IIf(IsNull(oRsAut2.Fields("CircuitoFirmasCompleto").Value), "NO", oRsAut2.Fields("CircuitoFirmasCompleto").Value) = "SI" Then
               oRsAut2.Close
               GoTo Salida
            End If
            oRsAut2.Close
         End If
      ElseIf Comprobante = NotaPedido Then
         Set oRsAut2 = Aplicacion.Pedidos.TraerFiltrado("_PorId", IdComprobante)
         If oRsAut2.RecordCount > 0 Then
            If IIf(IsNull(oRsAut2.Fields("CircuitoFirmasCompleto").Value), "NO", oRsAut2.Fields("CircuitoFirmasCompleto").Value) = "SI" Then
               oRsAut2.Close
               GoTo Salida
            End If
            oRsAut2.Close
         End If
      End If
      
      For i = 1 To mCantidadFirmas
         If Not mFirmas(i) Then
            CircuitoFirmasCompleto = False
            Exit For
         End If
      Next
      
   Else
      
      CircuitoFirmasCompleto = True
   
   End If

Salida:
   oRsAut1.Close
   
   Set oRsAut1 = Nothing
   Set oRsAut2 = Nothing

End Function

Public Function CantidadFirmasConfirmadas(ByVal Comprobante As EnumFormularios, _
                                          ByVal IdComprobante As Long, _
                                          Optional ByVal Importe As Double) As Integer

   Dim oRsAut1 As ADOR.Recordset
   Dim oRsAut2 As ADOR.Recordset
   Dim mCantidadFirmas As Integer, i As Integer, mFirmasConfirmadas As Integer
   Dim mFirmas() As Boolean
   
   mFirmasConfirmadas = 0

   Set oRsAut1 = Aplicacion.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(Comprobante, Importe))
   
   If oRsAut1.RecordCount > 0 Then
   
      mCantidadFirmas = oRsAut1.RecordCount
      ReDim mFirmas(mCantidadFirmas)
      For i = 1 To mCantidadFirmas
         mFirmas(i) = False
      Next
   
      Set oRsAut2 = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(Comprobante, IdComprobante))
      With oRsAut2
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               oRsAut1.MoveFirst
               Do While Not oRsAut1.EOF
                  If oRsAut1.Fields(0).Value = .Fields("OrdenAutorizacion").Value Then
                     mFirmas(oRsAut1.AbsolutePosition) = True
                     Exit Do
                  End If
                  oRsAut1.MoveNext
               Loop
               .MoveNext
            Loop
         End If
         oRsAut2.Close
      End With
   
      For i = 1 To mCantidadFirmas
         If mFirmas(i) Then mFirmasConfirmadas = mFirmasConfirmadas + 1
      Next
      
   End If
   
   oRsAut1.Close
   
   Set oRsAut1 = Nothing
   Set oRsAut2 = Nothing
   
   CantidadFirmasConfirmadas = mFirmasConfirmadas

End Function

Public Function UltimoDiaDelMes(ByVal Fecha As Date) As Integer

   If Not IsDate(Fecha) Then
      UltimoDiaDelMes = 0
   Else
      UltimoDiaDelMes = Day(DateAdd("d", -1, _
                                 DateSerial(Year(DateAdd("m", 1, Fecha)), _
                                             Month(DateAdd("m", 1, Fecha)), 1)))
   End If

End Function

Public Sub GenerarCondicionesDeCompra()

'   Dim i As Integer
'   Dim oRs As ADOR.Recordset
'   Dim oRsResul As ADOR.Recordset
'
'   Set oRsResul = CreateObject("ADOR.Recordset")
'   With oRsResul
'      .Fields.Append "IdAux", adInteger, , adFldIsNullable
'      .Fields.Append "IdCondicionCompra", adInteger, , adFldIsNullable
'      .Fields.Append "Dias", adInteger, , adFldIsNullable
'      .Fields.Append "Porcentaje", adNumeric, , adFldIsNullable
'      .Fields.Item("Porcentaje").Precision = 6
'      .Fields.Item("Porcentaje").NumericScale = 2
'   End With
'   oRsResul.Open
'
'   Set oRs = Aplicacion.CondicionesCompra.TraerFiltrado("_TodosSF")
'   If oRs.RecordCount > 0 Then
'      oRs.MoveFirst
'      Do While Not oRs.EOF
'         For i = 1 To 12
'            If Not IsNull(oRs.Fields("CantidadDias" & i).Value) And _
'                  Not IsNull(oRs.Fields("Porcentaje" & i).Value) And _
'                  oRs.Fields("Porcentaje" & i).Value <> 0 Then
'               With oRsResul
'                  .AddNew
'                  .Fields("IdAux").Value = -1
'                  .Fields("IdCondicionCompra").Value = oRs.Fields("IdCondicionCompra").Value
'                  .Fields("Dias").Value = oRs.Fields("CantidadDias" & i).Value
'                  .Fields("Porcentaje").Value = oRs.Fields("Porcentaje" & i).Value
'                  .Update
'               End With
'            End If
'         Next
'         oRs.MoveNext
'      Loop
'   End If
'   oRs.Close
'
'   If oRsResul.RecordCount > 0 Then
'      oRsResul.MoveFirst
'   End If
   Aplicacion.Tarea "_TempCondicionesCompra_Generar"
'   Aplicacion.TablasGenerales.ActualizacionEnLotes "_TempCondicionesCompra", oRsResul
'
'   Set oRsResul = Nothing
'   Set oRs = Nothing
   
End Sub

Public Sub EmisionParteInstalacion(ByVal IdObra As Long, _
                                    ByVal Destino As Integer, _
                                    ByVal Fecha As Date)

   Dim oW As Word.Application
   Dim oRsDet As ADOR.Recordset
   Dim mCliente As String
   Dim mIdArticuloAsociado As Long, mIdCliente As Long
   
   
   mIdArticuloAsociado = 0
   mIdCliente = 0
   
   Set oRsDet = Aplicacion.Obras.TraerFiltrado("_PorId", IdObra)
   If oRsDet.RecordCount > 0 Then
      mIdArticuloAsociado = IIf(IsNull(oRsDet.Fields("IdArticuloAsociado").Value), 0, oRsDet.Fields("IdArticuloAsociado").Value)
      mIdCliente = IIf(IsNull(oRsDet.Fields("IdCliente").Value), 0, oRsDet.Fields("IdCliente").Value)
   End If
   oRsDet.Close
   
   mCliente = ""
   If mIdCliente <> 0 Then
      Set oRsDet = Aplicacion.Clientes.TraerFiltrado("_PorId", mIdCliente)
      If oRsDet.RecordCount > 0 Then
         mCliente = IIf(IsNull(oRsDet.Fields("RazonSocial").Value), "", oRsDet.Fields("RazonSocial").Value)
      End If
      oRsDet.Close
   End If
   
   Set oRsDet = Aplicacion.Articulos.TraerFiltrado("_PorIdConDatos", mIdArticuloAsociado)
   
   Set oW = CreateObject("Word.Application")
   With oW
      .Visible = True
      With .Documents.Add(glbPathPlantillas & "\ParteInstalacion.dot")
         oW.ActiveDocument.FormFields("Cliente").Result = mCliente
         oW.ActiveDocument.FormFields("Cliente1").Result = mCliente
         oW.ActiveDocument.FormFields("Fecha").Result = Format(Fecha, "dd/mm/yyyy")
         If oRsDet.RecordCount > 0 Then
            oW.ActiveDocument.FormFields("Dominio").Result = IIf(IsNull(oRsDet.Fields("Codigo").Value), "", oRsDet.Fields("Codigo").Value)
            oW.ActiveDocument.FormFields("Dominio1").Result = IIf(IsNull(oRsDet.Fields("Codigo").Value), "", oRsDet.Fields("Codigo").Value)
            oW.ActiveDocument.FormFields("Marca").Result = IIf(IsNull(oRsDet.Fields("Marca").Value), "", oRsDet.Fields("Marca").Value)
            oW.ActiveDocument.FormFields("Marca1").Result = IIf(IsNull(oRsDet.Fields("Marca").Value), "", oRsDet.Fields("Marca").Value)
            oW.ActiveDocument.FormFields("Modelo").Result = IIf(IsNull(oRsDet.Fields("Modelo").Value), "", oRsDet.Fields("Modelo").Value)
            oW.ActiveDocument.FormFields("Modelo1").Result = IIf(IsNull(oRsDet.Fields("Modelo").Value), "", oRsDet.Fields("Modelo").Value)
            oW.ActiveDocument.FormFields("Color").Result = IIf(IsNull(oRsDet.Fields("Color").Value), "", oRsDet.Fields("Color").Value)
         End If
      End With
   End With

   oW.Selection.Goto What:=wdGoToBookmark, Name:="DetalleEquipos"
   With oRsDet
      If .RecordCount > 0 Then
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Grado").Value), "", .Fields("Grado").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios1").Value), "", .Fields("Accesorios1").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios2").Value), "", .Fields("Accesorios2").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios3").Value), "", .Fields("Accesorios3").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios4").Value), "", .Fields("Accesorios4").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios5").Value), "", .Fields("Accesorios5").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios6").Value), "", .Fields("Accesorios6").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios7").Value), "", .Fields("Accesorios7").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios8").Value), "", .Fields("Accesorios8").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios9").Value), "", .Fields("Accesorios9").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios10").Value), "", .Fields("Accesorios10").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios11").Value), "", .Fields("Accesorios11").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios12").Value), "", .Fields("Accesorios12").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios13").Value), "", .Fields("Accesorios13").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios14").Value), "", .Fields("Accesorios14").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios15").Value), "", .Fields("Accesorios15").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios16").Value), "", .Fields("Accesorios16").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios17").Value), "", .Fields("Accesorios17").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios18").Value), "", .Fields("Accesorios18").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios19").Value), "", .Fields("Accesorios19").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Accesorios20").Value), "", .Fields("Accesorios20").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion1").Value), "", .Fields("Programacion1").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion2").Value), "", .Fields("Programacion2").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion3").Value), "", .Fields("Programacion3").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion4").Value), "", .Fields("Programacion4").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion5").Value), "", .Fields("Programacion5").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion6").Value), "", .Fields("Programacion6").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion7").Value), "", .Fields("Programacion7").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion8").Value), "", .Fields("Programacion8").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion9").Value), "", .Fields("Programacion9").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Programacion10").Value), "", .Fields("Programacion10").Value)
         oW.Selection.MoveRight Unit:=wdCell
         oW.Selection.MoveRight Unit:=wdCell
      End If
      .Close
   End With
   
   oW.Application.Run MacroName:="AgregarLogo", varg1:=glbEmpresaSegunString, varg2:=glbPathPlantillas & "\.."
   
   
   Set oRsDet = Nothing
   Set oW = Nothing

End Sub

Public Sub EmitirCertificadoDeServicios(ByVal s As String)

   Dim oW As Word.Application
   Dim tPrinter As Printer
   Dim mPrinter As String
   Dim iFilas As Integer
   Dim Filas, Columnas
   
'   mPrinter = ""
'   For Each tPrinter In Printers
'      If tPrinter.DeviceName = "MagicPDF" Then
'         mPrinter = tPrinter.DeviceName
'         Exit For
'      End If
'   Next
'   If mPrinter = "" Then
'      MsgBox "No tiene una salida PDF instalada en este equipo, instalela primero", vbExclamation
'      Exit Sub
'   End If
   
   Set oW = CreateObject("Word.Application")
   oW.Visible = True
   
   Filas = VBA.Split(s, vbCrLf)
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      oW.Documents.Add (glbPathPlantillas & "\CertificadoDeServicios_" & glbEmpresaSegunString & ".dot")
      oW.Application.Run MacroName:="Emision", varg1:=glbStringConexion, varg2:=Columnas(2)
      oW.ActiveDocument.Close False
   Next
   
   oW.Quit
   Set oW = Nothing

End Sub

Public Function GenerarSQL(ByVal clave As String, _
                           IdClave As Long, _
                           Optional IdIdentificador As Long) As String

   Dim oRs As ADOR.Recordset
   Dim mSQL As String, mAux1 As String, mAux2 As String, mAux3 As String
   Dim mVecX As String, mVecT As String, mVecC As String
   
   If IdClave = 0 And IdIdentificador <> 0 Then
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", IdIdentificador)
      If oRs.RecordCount > 0 Then
         IdClave = IIf(IsNull(oRs.Fields("IdRubro").Value), 0, oRs.Fields("IdRubro").Value)
      End If
      oRs.Close
   End If
   
   mSQL = "SELECT  Articulos.IdArticulo, " & vbCrLf & _
          "        Articulos.Codigo as [Codigo], " & vbCrLf & _
          "        Articulos.Descripcion, " & vbCrLf & _
          "        Articulos.IdArticulo as [Identificador]," & vbCrLf
   mVecX = "0111"
   mVecT = "04D9"
   mVecC = " Articulos : IdArticulo | | |"
   
   mAux1 = BuscarClaveINI("IdRubro de equipos")
   If Len(mAux1) > 0 And IsNumeric(mAux1) Then
      If CLng(mAux1) = IdClave Then
         mSQL = mSQL & "(Select Top 1 Obras.NumeroObra " & vbCrLf & _
                       " From DetalleObrasEquiposInstalados doei " & vbCrLf & _
                       " Left Outer Join Obras On doei.IdObra=Obras.IdObra " & vbCrLf & _
                       " Where doei.IdArticulo=Articulos.IdArticulo and " & vbCrLf & _
                       "       doei.FechaDesinstalacion is null " & vbCrLf & _
                       " Order by doei.FechaInstalacion Desc) as [Dominio], "
         mSQL = mSQL & "(Select Top 1 Clientes.RazonSocial " & vbCrLf & _
                       " From DetalleObrasEquiposInstalados doei " & vbCrLf & _
                       " Left Outer Join Obras On doei.IdObra=Obras.IdObra " & vbCrLf & _
                       " Left Outer Join Clientes On Obras.IdCliente=Clientes.IdCliente " & vbCrLf & _
                       " Where doei.IdArticulo=Articulos.IdArticulo and " & vbCrLf & _
                       "       doei.FechaDesinstalacion is null " & vbCrLf & _
                       " Order by doei.FechaInstalacion Desc) as [Cliente], "
         mVecX = "011111"
         mVecT = "04D922"
         mVecC = " Articulos : IdArticulo | | | | |"
      End If
   End If
   
   Set oRs = Aplicacion.DefinicionesArt.TraerFiltrado("_CamposPorIdRubro", IdClave)
   With oRs
      If .RecordCount > 0 Then
         Do While Not .EOF
            If Len(Trim(.Fields("TablaCombo").Value)) = 0 Or _
                  .Fields("TablaCombo").Value = "SiNo" Then
               mSQL = mSQL & "        Articulos." & .Fields("Campo").Value & _
                           " as [" & .Fields("Etiqueta").Value & "], " & vbCrLf
               mVecC = mVecC & "T : " & .Fields("Campo").Value & " |"
            Else
               If mId(.Fields("TablaCombo").Value, 1, 3) = "Aco" Then
                  mAux1 = Right(.Fields("TablaCombo").Value, Len(.Fields("TablaCombo").Value) - 3)
               Else
                  mAux1 = .Fields("TablaCombo").Value
               End If
               If mAux1 = "Schedulers" Then
                  mAux1 = "Scheduler"
               ElseIf mAux1 = "Tratamientos" Then
                  mAux1 = "TratamientosTermicos"
               End If
               mAux2 = "Descripcion"
               mAux3 = ""
               If .Fields("TablaCombo").Value = "Cuantificacion" Then
                  mAux2 = "TipoCuantificacion"
               ElseIf .Fields("TablaCombo").Value = "Clientes" Or _
                     .Fields("TablaCombo").Value = "Proveedores" Or _
                     .Fields("TablaCombo").Value = "Transportistas" Then
                  mAux2 = "RazonSocial"
               ElseIf .Fields("TablaCombo").Value = "Empleados" Then
                  mAux2 = "Nombre"
               ElseIf .Fields("TablaCombo").Value = "Empleados" Then
                  mAux2 = "Nombre"
               ElseIf .Fields("TablaCombo").Value = "SiNo" Then
                  mAux2 = "SiNo"
                  mAux3 = " COLLATE Modern_Spanish_CI_AS"
               End If
               mSQL = mSQL & "        (Select Top 1 " & mAux1 & "." & mAux2 & vbCrLf & _
                             "         From " & mAux1 & vbCrLf & _
                             "         Where Articulos." & .Fields("Campo").Value & "=" & _
                             "" & mAux1 & "." & .Fields("CampoCombo").Value & mAux3 & ") " & _
                             "as [" & .Fields("Etiqueta").Value & "], " & vbCrLf
               Select Case mAux1
                  Case "Tratamientos"
                     mAux1 = "TTermicos"
               End Select
               mVecC = mVecC & "D : " & .Fields("Campo").Value & " : " & _
                              .Fields("CampoCombo").Value & " : " & mAux1 & "_TL |"
            End If
            mVecX = mVecX & "1"
            mVecT = mVecT & "4"
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   
   mVecX = mVecX & "133"
   mVecT = mVecT & "900"
   mSQL = mSQL & "@Vector_C as Vector_C," & vbCrLf & _
                 "@Vector_T as Vector_T," & vbCrLf & _
                 "@Vector_X as Vector_X" & vbCrLf & _
                 "FROM Articulos " & vbCrLf
   
   If IdIdentificador = 0 Then
      mSQL = mSQL & "WHERE Articulos.IdRubro=" & IdClave & " " & vbCrLf
   Else
      mSQL = mSQL & "WHERE Articulos.IdArticulo=" & IdIdentificador & vbCrLf
   End If
   mSQL = mSQL & "      and IsNull(Articulos.Activo,'')<>'NO' " & vbCrLf
   mSQL = mSQL & "ORDER BY Articulos.Descripcion" & vbCrLf
   
   mSQL = "Declare @vector_X varchar(50), @vector_T varchar(50), @vector_C varchar(1000)" & vbCrLf & _
          "Set @vector_X='" & mVecX & "'" & vbCrLf & _
          "Set @vector_T='" & mVecT & "'" & vbCrLf & _
          "Set @vector_C='" & mVecC & "'" & vbCrLf & vbCrLf & _
          mSQL
   
   GenerarSQL = mSQL

End Function

Public Function TraerCodigoArticulo(ByVal IdArticulo As Long) As String

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", IdArticulo)
   If oRs.RecordCount > 0 Then
      TraerCodigoArticulo = IIf(IsNull(oRs.Fields("NumeroInventario").Value), "", oRs.Fields("NumeroInventario").Value)
   Else
      TraerCodigoArticulo = ""
   End If
   oRs.Close
   Set oRs = Nothing

End Function

Public Sub CambiarEtiquetas(ByRef mForm As Form)

'   Dim oControl As Control
'   Dim mTexto As String, mTextoBusca As String, mTextoReemplaza As String
'   Dim s As String
'   Dim mVector1, mVector2
'
'   s = BuscarClaveINI("Reemplazar etiquetas")
'   If Len(s) = 0 Then Exit Sub
'
'   mTextoBusca = "OBRA"
'   mTextoReemplaza = "CASA"
'
'   mVector1 = VBA.Split(s, ",")
'
'   For Each oControl In mForm.Controls
'      If TypeOf oControl Is Label Then
'         mTexto = UCase(oControl.Caption)
'         If InStr(1, mTexto, mTextoBusca) <> 0 Then
'            mTexto = mId(mTexto, 1, InStr(1, mTexto, mTextoBusca) - 1) & _
'                     LCase(mTextoReemplaza) & _
'                     mId(mTexto, InStr(1, mTexto, mTextoBusca) + Len(mTextoBusca), Len(mTexto))
'            oControl.AutoSize = False
'            oControl.Caption = mTexto
'         End If
'      End If
'   Next

End Sub

Public Sub ReemplazarEtiquetas(ByRef mForm As Form)

   Dim mTextos As String, mPropiedad As String, mClave1 As String, mClave2 As String
   Dim mCambiar As Boolean
   Dim i As Integer
   Dim oControl As Control
   Dim oNode As Node
   Dim oCH As ColumnHeader
   Dim mVectorCambios, mVector
   
   mTextos = BuscarClaveINI("Reemplazar etiquetas")
   If Len(mTextos) > 0 Then
      mVectorCambios = VBA.Split(mTextos, ",")
      For i = 0 To UBound(mVectorCambios)
         mVector = VBA.Split(mVectorCambios(i), ":")
         mClave1 = mVector(0)
         mClave2 = mVector(1)
         For Each oControl In mForm.Controls
            mCambiar = False
            
            If TypeOf oControl Is Label Then
               'If Len(oControl.Caption) And InStr(1, LCase(oControl.Caption), LCase(mClave1)) <> 0 Then
               If Len(oControl.Caption) And InStr(1, oControl.Caption, mClave1) <> 0 Then
                  oControl.AutoSize = False
                  mCambiar = True
                  mPropiedad = "Caption"
               End If
            ElseIf TypeOf oControl Is OptionButton Then
               If Len(oControl.Caption) And InStr(1, oControl.Caption, mClave1) <> 0 Then
                  mCambiar = True
                  mPropiedad = "Caption"
               End If
            ElseIf TypeOf oControl Is CommandButton Then
               If Len(oControl.Caption) And InStr(1, oControl.Caption, mClave1) <> 0 Then
                  mCambiar = True
                  mPropiedad = "Caption"
               End If
            ElseIf TypeOf oControl Is Frame Then
               If Len(oControl.Caption) And InStr(1, oControl.Caption, mClave1) <> 0 Then
                  mCambiar = True
                  mPropiedad = "Caption"
               End If
            ElseIf TypeOf oControl Is TreeView Then
               For Each oNode In oControl.Nodes
                  If InStr(1, oNode.Text, mClave1) <> 0 Then
                     oNode.Text = Replace(oNode.Text, mClave1, mClave2)
                  End If
               Next
            ElseIf TypeOf oControl Is DbListView Then
               For Each oCH In oControl.ColumnHeaders
                  If InStr(1, oCH.Text, mClave1) <> 0 Then
                     oCH.Text = Replace(oCH.Text, mClave1, mClave2)
                  End If
               Next
            ElseIf TypeOf oControl Is Menu Then
               If Len(oControl.Caption) And InStr(1, oControl.Caption, mClave1) <> 0 Then
                  mCambiar = True
                  mPropiedad = "Caption"
               End If
            End If
            
            If mCambiar Then
               If mPropiedad = "Caption" Then
                  oControl.Caption = Replace(oControl.Caption, mClave1, mClave2)
               ElseIf mPropiedad = "Text" Then
                  oControl.Text = Replace(oControl.Text, mClave1, mClave2)
               End If
            End If
         Next
         If InStr(1, mForm.Caption, mClave1) <> 0 Then
            mForm.Caption = Replace(mForm.Caption, mClave1, mClave2)
         End If
      Next
   End If

End Sub

Public Sub ReemplazarEtiquetasListas(ByRef mLista As DbListView)

   Dim mTextos As String, mClave1 As String, mClave2 As String
   Dim i As Integer
   Dim oCH As ColumnHeader
   Dim mVectorCambios, mVector
   
   mTextos = BuscarClaveINI("Reemplazar etiquetas")
   If Len(mTextos) > 0 Then
      mVectorCambios = VBA.Split(mTextos, ",")
      For i = 0 To UBound(mVectorCambios)
         mVector = VBA.Split(mVectorCambios(i), ":")
         mClave1 = mVector(0)
         mClave2 = mVector(1)
         For Each oCH In mLista.ColumnHeaders
            If InStr(1, oCH.Text, mClave1) <> 0 Then
               'oCH.Text = Replace(oCH.Text, mClave1, mClave2)
               oCH.Text = Replace(oCH.Text, mClave1, mClave2)
            End If
         Next
      Next
   End If

End Sub

Public Sub ArmarTXT(ByRef mLista As DbListView, _
                    Optional ByVal Codigo As String, _
                    Optional ByVal Titulos As String, _
                    Optional ByVal Parametros As String, _
                    Optional ByRef frmOrigen As Form)

   If mLista.ListItems.Count = 0 Then
      MsgBox "No hay elementos para exportar", vbExclamation
      Exit Sub
   End If
   
   Dim i As Integer, j As Integer, fl As Integer, fl1 As Integer, fl2 As Integer
   Dim cl As Integer, cl1 As Integer, mAuxI1 As Integer
   Dim Columnas As Integer, mCopias As Integer, mLineasPorPagina As Integer
   Dim mColumnaSumador1 As Integer, mColumnaSumador2 As Integer
   Dim mColumnaSumador3 As Integer, mColumnaSumador4 As Integer
   Dim mColumnaSumador5 As Integer, mColumnaSumador6 As Integer
   Dim mColumnaSumador7 As Integer, mColumnaSumador8 As Integer
   Dim mColumnaSumador9 As Integer, mColumnaSumador10 As Integer
   Dim mPagina As Integer
   Dim mTotalPagina1 As Double, mTotalPagina2 As Double, mTotalPagina3 As Double
   Dim mTotalPagina4 As Double, mTotalPagina5 As Double, mTotalPagina6 As Double
   Dim mTotalPagina7 As Double, mTotalPagina8 As Double, mTotalPagina9 As Double
   Dim mTotalPagina10 As Double
   Dim s As String, s1 As String, mPrinter As String, mBlancos As String, mTit As String
   Dim mTit1 As String, mTransp As String, mVectorE As String, mLinea As String
   Dim mSubtitulo1(100) As String, mSubtitulo2(100) As String
   Dim mOk As Boolean, mTotalizar As Boolean, mSeñal1 As Boolean
   Dim oL As ListItem
   Dim oS As ListSubItem
   Dim oCol As ColumnHeader
   Dim mVector, mVectorParametros, mSubVectorParametros, mVectorColumnas, mVectorAux
   Dim oF As Form
   
'   Set oF = New frmImpresion
'   With oF
'      .Frame1.Visible = False
'      .Label2.Visible = False
'      .Label3.Visible = False
'      .txtHojas.Visible = False
'      .Show vbModal
'      mOk = .Ok
'      mPrinter = .Combo1.Text
'      mCopias = Val(.txtCopias.Text)
'   End With
'   Unload oF
'   Set oF = Nothing
'   If Not mOk Then Exit Sub
   
   mBlancos = "                                                                      " & _
              "                                                                      "
   Columnas = 0
   mLineasPorPagina = 0
   mPagina = 0
   mColumnaSumador1 = 0
   mColumnaSumador2 = 0
   mColumnaSumador3 = 0
   mColumnaSumador4 = 0
   mColumnaSumador5 = 0
   mColumnaSumador6 = 0
   mColumnaSumador7 = 0
   mColumnaSumador8 = 0
   mColumnaSumador9 = 0
   mColumnaSumador10 = 0
   mTotalPagina1 = 0
   mTotalPagina2 = 0
   mTotalPagina3 = 0
   mTotalPagina4 = 0
   mTotalPagina5 = 0
   mTotalPagina6 = 0
   mTotalPagina7 = 0
   mTotalPagina8 = 0
   mTotalPagina9 = 0
   mTotalPagina10 = 0
   mTotalizar = True
   fl2 = 0
   
   If Not IsMissing(Parametros) Then
      mVectorParametros = VBA.Split(Parametros, "|")
      If UBound(mVectorParametros) > 0 Then
         For i = 0 To UBound(mVectorParametros)
            If InStr(mVectorParametros(i), "Columnas") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mVectorColumnas = VBA.Split(mSubVectorParametros(1), ",")
               Columnas = UBound(mVectorColumnas) + 1
            ElseIf InStr(mVectorParametros(i), "LineasPorPagina") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mLineasPorPagina = CInt(mSubVectorParametros(1))
            ElseIf InStr(mVectorParametros(i), "PaginaInicial") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mPagina = CInt(mSubVectorParametros(1))
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja1") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador1 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja2") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador2 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja3") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador3 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja4") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador4 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja5") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador5 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja6") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador6 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja7") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador7 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja8") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador8 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja9") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador9 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "SumadorPorHoja10") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mColumnaSumador10 = mSubVectorParametros(1)
            ElseIf InStr(mVectorParametros(i), "TransporteInicialDiario:") <> 0 Then
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mTotalPagina1 = CDbl(mSubVectorParametros(1))
               mTotalPagina2 = CDbl(mSubVectorParametros(1))
            End If
         Next
      End If
   End If
   
   mLinea = ""
   If Columnas >= 1 Then
      For i = 1 To Columnas
         mLinea = mLinea & String(mVectorColumnas(i - 1), "=") & "="
      Next
   End If
   
   If mPagina <> 0 Then
      mTit1 = glbEmpresa & Space(70) & "Pagina :" & mPagina & vbCrLf
   Else
      mTit1 = glbEmpresa & vbCrLf
   End If
   s = glbDireccion & " " & glbLocalidad & vbCrLf
   s = s & glbEmpresa & vbCrLf
   s = s & vbCrLf
   fl = 3
   
   If Not IsMissing(Titulos) Then
      mVector = VBA.Split(Titulos, "|")
      For i = 0 To UBound(mVector)
         s = s & mVector(i) & vbCrLf
         fl = fl + 1
      Next
   End If
   
   Set oL = mLista.ListItems(mLista.ListItems.Count)
   mVectorE = oL.ListSubItems(mLista.ColumnHeaders.Count - 1)
   mVectorParametros = VBA.Split(mVectorE, ",")
   mSeñal1 = False
   If IsArray(mVectorParametros) Then
      For i = 0 To UBound(mVectorParametros)
         Select Case UCase(mId(Trim(mVectorParametros(i)), 1, 3))
            Case "VAL"
               mSubVectorParametros = VBA.Split(mVectorParametros(i), ":")
               mVectorAux = VBA.Split(mSubVectorParametros(1), ";")
               mSubtitulo1(mVectorAux(1)) = mVectorAux(2)
               mSubtitulo2(mVectorAux(1)) = mVectorAux(3)
               mSeñal1 = True
         End Select
      Next
   End If
   
   s = s & mLinea & vbCrLf
   fl = fl + 1
   cl = 1
   For Each oCol In mLista.ColumnHeaders
      If oCol.Width > 0 Then
         If Len(mSubtitulo1(cl)) = 0 Then
            s1 = oCol.Text
         Else
            s1 = mSubtitulo1(cl)
         End If
         If Columnas >= cl Then
            mAuxI1 = mVectorColumnas(cl - 1) - Len(s1)
            If mAuxI1 > 0 Then s1 = mId(mBlancos, 1, Int(mAuxI1 / 2)) & s1
            s1 = mId(s1 & mBlancos, 1, mVectorColumnas(cl - 1))
         End If
         s = s & s1 & " "
         cl = cl + 1
      End If
   Next
   s = s & vbCrLf
   fl = fl + 1
   If mSeñal1 Then
      cl = 1
      For i = 0 To mLista.ColumnHeaders.Count - 1
         s1 = mSubtitulo2(i + 1)
         If Columnas >= cl Then s1 = mId(s1 & mBlancos, 1, mVectorColumnas(cl - 1))
         s = s & s1 & " "
         cl = cl + 1
      Next
      s = s & vbCrLf
      fl = fl + 1
   End If
   s = s & mLinea & vbCrLf
   fl = fl + 1
   mTit = s
   s = mTit1 & s
   fl = fl + 1
   fl1 = fl

   mTransp = ""
   If (mTotalPagina1 <> 0 Or mTotalPagina2 <> 0 Or mTotalPagina3 <> 0 Or _
       mTotalPagina4 <> 0 Or mTotalPagina5 <> 0) And Columnas > 0 Then
      For i = 1 To Columnas
         If mColumnaSumador1 = i And mTotalPagina1 <> 0 Then
            s1 = Format(mTotalPagina1, "#,##0.00")
            mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1)) & s1 & " "
         ElseIf mColumnaSumador2 = i And mTotalPagina2 <> 0 Then
            s1 = Format(mTotalPagina2, "#,##0.00")
            mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1)) & s1 & " "
         ElseIf mColumnaSumador3 = i And mTotalPagina3 <> 0 Then
            s1 = Format(mTotalPagina3, "#,##0.00")
            mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1)) & s1 & " "
         ElseIf mColumnaSumador4 = i And mTotalPagina4 <> 0 Then
            s1 = Format(mTotalPagina4, "#,##0.00")
            mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1)) & s1 & " "
         ElseIf mColumnaSumador5 = i And mTotalPagina5 <> 0 Then
            s1 = Format(mTotalPagina5, "#,##0.00")
            mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1)) & s1 & " "
         Else
            If i = 3 Then
               s1 = "Transporte"
               mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1)) & s1 & " "
            Else
               mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1)) & " "
            End If
         End If
      Next
   End If
   If Len(Trim(mTransp)) > 0 Then
      s = s & mTransp & vbCrLf
      fl = fl + 1
   End If
   
   For Each oL In mLista.ListItems
      
      mVectorE = oL.ListSubItems(mLista.ColumnHeaders.Count - 1)
      If mId(Trim(mVectorE), 1, 4) = "LIN:" Then
         s = s & mLinea
      Else
         If mLista.ColumnHeaders.Item(1).Width <> 0 Then
            s1 = oL.Text
            If Columnas >= 1 Then s1 = mId(s1 & mBlancos, 1, mVectorColumnas(0))
            s = s & s1 & " "
            cl1 = 1
         Else
            cl1 = 0
         End If
         
         If Not frmOrigen Is Nothing Then
            fl2 = fl2 + 1
            frmOrigen.lblInfo.Caption = "Procesando registro " & fl2 & " de " & mLista.ListItems.Count
            DoEvents
         End If
         
         cl = 1
         For Each oS In oL.ListSubItems
            cl = cl + 1
            If mLista.ColumnHeaders.Item(oS.Index + 1).Width <> 0 Then
               cl1 = cl1 + 1
               
               mTotalizar = True
               mVectorAux = VBA.Split(oL.SubItems(oL.ListSubItems.Count), "|")
               If IsArray(mVectorAux) Then
                  If UBound(mVectorAux) >= oS.Index Then
                     If InStr(1, mVectorAux(oS.Index), "NOSUMAR") <> 0 Then
                        mTotalizar = False
                     End If
                  End If
               End If
               
               If mLista.TipoDatoColumna(cl - 1) = "N" Then
                  s1 = oS.Text
                  If Columnas >= cl1 Then s1 = mId(mBlancos, 1, mVectorColumnas(cl1 - 1) - Len(s1) - 1) & s1 & " "
                  If mColumnaSumador1 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina1 = mTotalPagina1 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador2 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina2 = mTotalPagina2 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador3 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina3 = mTotalPagina3 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador4 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina4 = mTotalPagina4 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador5 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina5 = mTotalPagina5 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador6 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina6 = mTotalPagina6 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador7 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina7 = mTotalPagina7 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador8 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina8 = mTotalPagina8 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador9 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina9 = mTotalPagina9 + CDbl(oS.Text)
                  End If
                  If mColumnaSumador10 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                     mTotalPagina10 = mTotalPagina10 + CDbl(oS.Text)
                  End If
               Else
                  s1 = oS.Text
                  If Columnas >= cl1 Then s1 = mId(Trim(s1) & mBlancos, 1, mVectorColumnas(cl1 - 1))
               End If
               s = s & s1 & " "
            End If
         Next
      End If
      s = s & vbCrLf
      fl = fl + 1
      
      If mLineasPorPagina <> 0 And fl >= mLineasPorPagina - 5 Then
         mTransp = ""
         If mTotalizar And Columnas > 0 Then
            For i = 1 To Columnas
               If mColumnaSumador1 = i And mTotalPagina1 <> 0 Then
                  s1 = Format(mTotalPagina1, "#,##0.00")
                  mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1) - 1) & s1 & "  "
               ElseIf mColumnaSumador2 = i And mTotalPagina2 <> 0 Then
                  s1 = Format(mTotalPagina2, "#,##0.00")
                  mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1) - 1) & s1 & "  "
               ElseIf mColumnaSumador3 = i And mTotalPagina3 <> 0 Then
                  s1 = Format(mTotalPagina3, "#,##0.00")
                  mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1) - 1) & s1 & "  "
               ElseIf mColumnaSumador4 = i And mTotalPagina4 <> 0 Then
                  s1 = Format(mTotalPagina4, "#,##0.00")
                  mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1) - 1) & s1 & "  "
               ElseIf mColumnaSumador5 = i And mTotalPagina5 <> 0 Then
                  s1 = Format(mTotalPagina5, "#,##0.00")
                  mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1) - 1) & s1 & "  "
               Else
                  If i = 3 Then
                     s1 = "Transporte"
                     mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1) - Len(s1)) & s1 & " "
                  Else
                     mTransp = mTransp & mId(mBlancos, 1, mVectorColumnas(i - 1)) & " "
                  End If
               End If
            Next
         End If
         If Len(Trim(mTransp)) > 0 Then
            s = s & mTransp & vbCrLf
            fl = fl + 1
         End If
         For i = fl To mLineasPorPagina - 1: s = s & vbCrLf: Next
         If mPagina <> 0 Then
            mPagina = mPagina + 1
            s = s & glbEmpresa & Space(70) & "Pagina :" & mPagina & vbCrLf
         Else
            s = s & glbEmpresa & vbCrLf
         End If
         s = s & mTit
         fl = fl1
         If Len(Trim(mTransp)) > 0 Then
            s = s & mTransp & vbCrLf
            fl = fl + 1
         End If
      End If
   
   Next
            
   GuardarArchivoSecuencial "C:\Pronto\" & Codigo & ".txt", s
   i = Shell("c:\Pronto\" & Codigo & ".bat", vbHide)

End Sub

Public Sub GenerarValesAlmacen(ByVal StringRequerimientos As String)

   Dim mvarOK As Boolean
   Dim mvarIdAutorizo As Long
   Dim mSector As String
   Dim mAux1 As Variant
   Dim oRs As ADOR.Recordset
   
   mSector = "Compras"
   mAux1 = TraerValorParametro2("IdSectorReasignador")
   If Not IsNull(mAux1) And IsNumeric(mAux1) Then
      Set oRs = Aplicacion.Sectores.TraerFiltrado("_PorId", Val(mAux1))
      If oRs.RecordCount > 0 Then mSector = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
      oRs.Close
   End If
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = mSector
      .Show vbModal
      mvarOK = .Ok
      mvarIdAutorizo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then Exit Sub
   
   Dim oAp As ComPronto.Aplicacion
   Dim oReq As ComPronto.Requerimiento
   Dim oDetR As ComPronto.DetRequerimiento
   Dim of1 'As frmValesSalida
   Dim oL As ListItem
   Dim i As Integer
   Dim s As String, mObra As String
   Dim Filas, Columnas
   
   s = ""
   Filas = VBA.Split(StringRequerimientos, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If i = 1 Then mObra = Columnas(20)
      If mObra <> Columnas(20) Then
         MsgBox "Hay items con distinta Obra/C.Costos, deben ser iguales", vbExclamation
         Exit Sub
      End If
      s = s & Columnas(17) & ","
   Next
   If Len(s) > 0 Then s = mId(s, 1, Len(s) - 1)
   
   'Set of1 = New frmValesSalida
   With of1
      .DetalleRequerimientos = s
      .NivelAcceso = Alto
      .Id = -1
      .Show vbModal
      mvarOK = .Ok
   End With
   Set of1 = Nothing
   If Not mvarOK Then Exit Sub
   
   Set oAp = Aplicacion
   
   Filas = VBA.Split(StringRequerimientos, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If IsNumeric(Columnas(18)) Then
         Set oReq = oAp.Requerimientos.Item(Columnas(18))
         Set oDetR = oReq.DetRequerimientos.Item(Columnas(17))
'         oDetR.Registro.Fields("Cumplido").Value = "SI"
'         oDetR.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
'         oDetR.Registro.Fields("IdDioPorCumplido").Value = mvarIdAutorizo
'         oDetR.Registro.Fields("FechaDadoPorCumplido").Value = Now
'         oDetR.Registro.Fields("ObservacionesCumplido").Value = _
'                        "Generacion de vales de almacen - RM : " & Columnas(1) & " " & _
'                        "item " & Columnas(2)
'         oDetR.Modificado = True
         Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
         If Not IsNull(oRs.Fields("ActivarSolicitudMateriales").Value) And _
               oRs.Fields("ActivarSolicitudMateriales").Value = "SI" Then
            oDetR.Registro.Fields("TipoDesignacion").Value = "STK"
            oDetR.Modificado = True
            oReq.Guardar  'OJO QUE ESTA COMENTADO ABAJO
         End If
         oRs.Close
'         oReq.Guardar
         Set oDetR = Nothing
         Set oReq = Nothing
         Set oRs = Nothing
         oAp.Tarea "Requerimientos_ActualizarEstado", Array(Columnas(18), 0)
      End If
   Next
   
   Set oAp = Nothing

End Sub

Public Sub LiberarRMParaCompras(ByVal StringRequerimientos As String)

   Dim mvarOK As Boolean
   Dim mvarIdAutorizo As Long
   Dim mSector As String
   Dim mAux1 As Variant
   Dim oRs As ADOR.Recordset
   
   mSector = "Compras"
   mAux1 = TraerValorParametro2("IdSectorReasignador")
   If Not IsNull(mAux1) And IsNumeric(mAux1) Then
      Set oRs = Aplicacion.Sectores.TraerFiltrado("_PorId", Val(mAux1))
      If oRs.RecordCount > 0 Then mSector = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
      oRs.Close
   End If
   
   Dim oF As frmAutorizacion2
   Set oF = New frmAutorizacion2
   With oF
      .Sector = mSector
      .Show vbModal
      mvarOK = .Ok
      mvarIdAutorizo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then Exit Sub
   
   Dim oAp As ComPronto.Aplicacion
   Dim oReq As ComPronto.Requerimiento
   Dim oDetR As ComPronto.DetRequerimiento
   Dim oL As ListItem
   Dim i As Integer
   Dim Filas, Columnas
   
   Set oAp = Aplicacion
   
   Filas = VBA.Split(StringRequerimientos, vbCrLf)
   For i = 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(i), vbTab)
      If IsNumeric(Columnas(18)) And Columnas(26) <> "REC" Then
         Set oReq = oAp.Requerimientos.Item(Columnas(18))
         Set oDetR = oReq.DetRequerimientos.Item(Columnas(17))
         oDetR.Registro.Fields("IdLiberoParaCompras").Value = mvarIdAutorizo
         oDetR.Registro.Fields("FechaLiberacionParaCompras").Value = Now
         oDetR.Modificado = True
         Set oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
         If Not IsNull(oRs.Fields("ActivarSolicitudMateriales").Value) And _
               oRs.Fields("ActivarSolicitudMateriales").Value = "SI" Then
            oDetR.Registro.Fields("TipoDesignacion").Value = "CMP"
         End If
         oRs.Close
         oReq.Guardar
         Set oDetR = Nothing
         Set oReq = Nothing
         Set oRs = Nothing
      End If
   Next
   
   Set oAp = Nothing

End Sub

Function VerificarCuit(strCuit As String) As Boolean

   Dim intBase(9) As Integer
   Dim intNumero(9) As Integer
   Dim intCalculo As Integer
   Dim intVerificador As Integer
   Dim i As Integer
   Dim X As Integer

   VerificarCuit = False
   
   X = 5
   For i = 0 To 3
      intBase(i) = X
      X = X - 1
   Next
   
   X = 7
   For i = 4 To 9
      intBase(i) = X
      X = X - 1
   Next
   
   If Len(strCuit) <> 13 Then Exit Function
   
   If mId(strCuit, 3, 1) <> "-" Or mId(strCuit, 12, 1) <> "-" Then Exit Function
   
   For i = 0 To 1
      intNumero(i) = mId(strCuit, i + 1, 1)
      intCalculo = intCalculo + (intNumero(i) * intBase(i))
   Next
   
   For i = 2 To 9
      intNumero(i) = mId(strCuit, i + 2, 1)
      intCalculo = intCalculo + (intNumero(i) * intBase(i))
   Next
   
   intCalculo = 11 - (intCalculo - (Int(intCalculo / 11) * 11))
   
   Select Case intCalculo
      Case 11
         intCalculo = 0
      Case 10
         intCalculo = 9
   End Select
   
   If intCalculo = mId(strCuit, 13, 1) Then VerificarCuit = True

End Function

Public Function TraerValorParametro2(ByVal Campo As String) As Variant

   Dim mCampo As String
   Dim oRsParametros2 As ADOR.Recordset
   
   mCampo = Campo
   If mId(Campo, 1, 1) = "_" Then mCampo = mId(Campo, 2, 100)
   
   Set oRsParametros2 = Aplicacion.Parametros.TraerFiltrado("_Parametros2BuscarClave", mCampo)
   
   TraerValorParametro2 = Null
   With oRsParametros2
      If .RecordCount > 0 Then
         If Len(IIf(IsNull(.Fields("Valor").Value), "", .Fields("Valor").Value)) = 0 Then
            TraerValorParametro2 = Null
         Else
            TraerValorParametro2 = .Fields("Valor").Value
         End If
      End If
      .Close
   End With
   
   Set oRsParametros2 = Nothing

End Function

Public Sub GuardarValorParametro2(ByVal Campo As String, ByVal Valor As String)

   Dim mCampo As String
   
   mCampo = Campo
   If mId(Campo, 1, 1) = "_" Then mCampo = mId(Campo, 2, 100)
   
   Aplicacion.Tarea "Parametros_RegistrarParametros2", Array(mCampo, Valor)

End Sub

Sub Sonido(ByVal QueSonido As String)

'   If auxGetNumDevs > 0 Then ' si tiene placa de sonido
'      sndPlaySound QueSonido, SND_ASYNC + SND_NOSTOP + SND_NOWAIT
'   Else
      Beep
'   End If

End Sub

Public Function UnidadesHabilitadas(ByVal IdArticulo As Long) As ADOR.Recordset

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.Articulos.TraerFiltrado("_UnidadesHabilitadas", IdArticulo)
   If oRs.RecordCount = 0 Then
      oRs.Close
      Set oRs = Aplicacion.Unidades.TraerLista
   End If
   Set UnidadesHabilitadas = oRs
   Set oRs = Nothing

End Function

Public Function TablaExistente(ByVal Tabla As String) As Boolean

   Dim oRs As ADOR.Recordset
   Dim mEsta As Boolean
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("BD", "_Tablas")
   mEsta = False
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If UCase(.Fields("TABLE_NAME").Value) = UCase(Tabla) Then
               mEsta = True
               Exit Do
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRs = Nothing
   
   TablaExistente = mEsta

End Function

Sub EsperarShell(sCmd As String)

   Dim hShell As Long
   Dim hProc As Long
   Dim codExit As Long
   
   ' ejecutar comando
   hShell = Shell(Environ$("Comspec") & " /c " & sCmd, vbHide)
   
   ' esperar a que se complete el proceso
   hProc = OpenProcess(PROCESS_QUERY_INFORMATION, False, hShell)
   
   Dim timeout
   timeout = 1000000
   
   Do
      GetExitCodeProcess hProc, codExit
      DoEvents
      timeout = timeout - 1
   Loop While codExit = STILL_ACTIVE And timeout > 0
   
End Sub

Public Function EstadoEntidad(ByVal Entidad As String, ByVal IdEntidad As Long) As String

   EstadoEntidad = "ACTIVO"
   
   Dim oRs As ADOR.Recordset
   Dim mIdEstado As Long
   
   mIdEstado = 0
   
   Set oRs = Aplicacion.TablasGenerales.TraerUno(Entidad, IdEntidad)
   If oRs.RecordCount > 0 Then
      mIdEstado = IIf(IsNull(oRs.Fields("IdEstado").Value), 0, oRs.Fields("IdEstado").Value)
   End If
   oRs.Close
   
   If mIdEstado > 0 Then
      Set oRs = Aplicacion.TablasGenerales.TraerUno("EstadosProveedores", mIdEstado)
      If oRs.RecordCount > 0 Then
         If IIf(IsNull(oRs.Fields("Activo").Value), "SI", oRs.Fields("Activo").Value) = "NO" Then
            EstadoEntidad = "INACTIVO"
         End If
      End If
      oRs.Close
   End If
   
   Set oRs = Nothing

End Function

Public Function QuitarPath(ByVal Archivo As String) As String

   Dim X As Integer
   
   For X = Len(Archivo) To 1 Step -1
      If mId(Archivo, X, 1) = "\" Then Exit For
   Next
   QuitarPath = Archivo
   If X > 1 Then QuitarPath = mId(Archivo, X + 1, Len(Archivo))

End Function

Public Function Mensaje(ByVal Texto As String, ByVal Titulo As String) As Boolean

   Dim mvarResp As Integer
   mvarResp = MsgBox(Texto & vbCrLf & "Esta seguro ?", vbYesNo, Titulo)
   If mvarResp = vbYes Then
      Mensaje = True
   Else
      Mensaje = False
   End If

End Function

Public Function TotalizarCampo(ByRef mLista As DbListView) As String

   TotalizarCampo = ""
   
   If mLista.ColumnHeaders.Count = 0 Then
      MsgBox "No hay informacion ingresada a la lista!", vbExclamation
      Exit Function
   End If
         
   Dim oF
   Dim col As ColumnHeader
   Dim oL As ListItem
   Dim mIndex As Integer, i As Integer, X As Integer
   Dim mColumna As String, mValor As String
   Dim mTotal As Double
   Dim Filas, Columnas
   
   With oF
      .Id = 16
      For Each col In mLista.ColumnHeaders
         .Combo1(0).AddItem col.Text
      Next
      .Show vbModal
      mColumna = .Combo1(0).Text
      mIndex = .Combo1(0).ListIndex
   End With
   DoEvents
   
   If Len(mColumna) > 0 Then
      mTotal = 0
      Filas = VBA.Split(mLista.GetString, vbCrLf)
      For i = 1 To UBound(Filas)
         Columnas = VBA.Split(Filas(i), vbTab)
         mValor = Replace(Columnas(mIndex + 1), ",", "")
         If IsNumeric(mValor) Then mTotal = mTotal + Val(mValor)
      Next
      TotalizarCampo = "Suma " & mColumna & " : " & Format(mTotal, "#,##0.00")
   End If
   
Salida:

   Unload oF
   Set oF = Nothing
   
End Function

Public Function CargarImagenesThumbs(ByVal mIdArticulo As Long, ByRef oF As Form) As Integer

   Dim oRs As ADOR.Recordset
   Dim mArchivo As String
   
   With oF.VividThumbs1
      .Cls
   End With
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetArticulosImagenes", "_Img", mIdArticulo)
   With oRs
      If .RecordCount > 0 Then
         CargarImagenesThumbs = -1
         .MoveFirst
         Do While Not .EOF
            mArchivo = IIf(IsNull(.Fields("PathImagen").Value), "", .Fields("PathImagen").Value)
            If Len(Trim(Dir(mArchivo))) = 0 Then
               mArchivo = ""
            End If
            If mArchivo <> "" Then
               oF.VividThumbs1.AddThumb (mArchivo)
            End If
            .MoveNext
         Loop
      Else
         CargarImagenesThumbs = 0
      End If
      .Close
   End With
   Set oRs = Nothing
      
End Function

Public Sub CambiarLenguaje(ByRef Objeto As Object, ByVal IdiomaInicial As String, ByVal IdiomaFinal As String, _
                           Optional ByVal CodCtrl As String)

   If IdiomaInicial = IdiomaFinal Then
      Exit Sub
   End If

   Dim oControl As Control
   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim Texto As String

   Set oRs = Aplicacion.Traducciones.TraerFiltrado("_TodosSinFormato")

   Texto = Replace(Objeto.Caption, "&", "")
   Texto = Trim(Replace(Texto, ":", ""))
   Objeto.Caption = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)

   For Each oControl In Objeto.Controls
'      Debug.Print TypeName(oControl)

      If TypeOf oControl Is CommandButton And (CodCtrl = "" Or CodCtrl = "CommandButton") Then
         Texto = Replace(oControl.Caption, "&", "")
         Texto = Trim(Replace(Texto, ":", ""))
         oControl.Caption = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
      ElseIf TypeOf oControl Is DbListView And (CodCtrl = "" Or CodCtrl = "DbListView") Then
         For i = 1 To oControl.ColumnHeaders.Count
            Texto = oControl.ColumnHeaders(i).Text
            Texto = Trim(Replace(Texto, ":", ""))
            oControl.ColumnHeaders(i).Text = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
         Next
      ElseIf TypeOf oControl Is Label And (CodCtrl = "" Or CodCtrl = "Label") Then
         oControl.AutoSize = False
         Texto = Replace(oControl.Caption, "&", "")
         Texto = Trim(Replace(Texto, ":", ""))
         oControl.Caption = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
      ElseIf TypeOf oControl Is Frame And (CodCtrl = "" Or CodCtrl = "Frame") Then
         Texto = Replace(oControl.Caption, "&", "")
         Texto = Trim(Replace(Texto, ":", ""))
         oControl.Caption = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
      ElseIf TypeOf oControl Is OptionButton And (CodCtrl = "" Or CodCtrl = "OptionButton") Then
         Texto = Replace(oControl.Caption, "&", "")
         Texto = Trim(Replace(Texto, ":", ""))
         oControl.Caption = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
      ElseIf TypeOf oControl Is CheckBox And (CodCtrl = "" Or CodCtrl = "CheckBox") Then
         Texto = Replace(oControl.Caption, "&", "")
         Texto = Trim(Replace(Texto, ":", ""))
         oControl.Caption = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
      ElseIf TypeName(oControl) = "Toolbar" And (CodCtrl = "" Or CodCtrl = "Toolbar") Then
         For i = 1 To oControl.Buttons.Count
            Texto = oControl.Buttons(i).ToolTipText
            Texto = Trim(Replace(Texto, ":", ""))
            oControl.Buttons(i).ToolTipText = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
         Next
      ElseIf TypeOf oControl Is Menu And (CodCtrl = "" Or CodCtrl = "Menu") Then
         Texto = Replace(oControl.Caption, "&", "")
         Texto = Trim(Replace(Texto, ":", ""))
         oControl.Caption = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
      ElseIf TypeOf oControl Is TreeView And (CodCtrl = "" Or CodCtrl = "TreeView") Then
         Dim nodo As Node
         For Each nodo In oControl.Nodes
            Texto = nodo.Text
            Texto = Trim(Replace(Texto, ":", ""))
            nodo.Text = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
         Next
      End If
   Next

   oRs.Close
   Set oRs = Nothing

End Sub

Public Sub CambiarLenguajeLista(ByRef Lista As DbListView, ByVal IdiomaInicial As String, ByVal IdiomaFinal As String)

   If IdiomaInicial = IdiomaFinal Then
      Exit Sub
   End If

   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim Texto As String

   Set oRs = Aplicacion.Traducciones.TraerFiltrado("_TodosSinFormato")

   For i = 1 To Lista.ColumnHeaders.Count
      Texto = Lista.ColumnHeaders(i).Text
      Lista.ColumnHeaders(i).Text = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)
   Next

   oRs.Close
   Set oRs = Nothing

End Sub

Public Function TraducirTexto(ByVal Texto As String, ByVal IdiomaInicial As String, ByVal IdiomaFinal As String) As String

   Dim oRs As ADOR.Recordset

   Set oRs = Aplicacion.Traducciones.TraerFiltrado("_TodosSinFormato")

   TraducirTexto = BuscarTexto(Texto, IdiomaInicial, IdiomaFinal, oRs)

   oRs.Close
   Set oRs = Nothing

End Function

Public Function BuscarTexto(ByVal Texto As String, ByVal IdiomaInicial As String, ByVal IdiomaFinal As String, ByRef oRs As ADOR.Recordset) As String

   BuscarTexto = Replace(Texto, "'", "")
   
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         .Find "Descripcion_" & IdiomaInicial & " = '" & BuscarTexto & "'"
         If Not .EOF Then BuscarTexto = IIf(IsNull(.Fields("Descripcion_" & IdiomaFinal).Value), Texto, .Fields("Descripcion_" & IdiomaFinal).Value)
      End If
   End With
   
'      Do While Not oRs.EOF
'         If Texto = oRs.Fields("Descripcion_" & IdiomaInicial).Value Then
'            BuscarTexto = oRs.Fields("Descripcion_" & IdiomaFinal).Value
'            Exit Do
'         End If
'         oRs.MoveNext
'      Loop
'   End If

End Function

'////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////
'MARIANO
'Funciones Auxiliares

Function iisNull(X As Variant, Optional y As Variant = "") As Variant
On Error Resume Next
    If IsNull(X) Or IsEmpty(X) Or X = "" Then
        iisNull = y
    Else
        iisNull = X
    End If
End Function

Function iisEmpty(X As Variant, Optional y As Variant = 0) As Variant
On Error Resume Next
    If X = "" Then
        iisEmpty = y
    Else
        iisEmpty = X
    End If
End Function









'http://vbnet.mvps.org/index.html?code/comctl/lvcolumnautosize.htm
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Copyright ©1996-2009 VBnet, Randy Birch, All Rights Reserved.
' Some pages may also contain other copyrights by the author.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Distribution: You can freely use this code in your own
'               applications, but you may not reproduce
'               or publish this code on any web site,
'               online service, or distribute as source
'               on any media without express permission.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



'Private Const LVM_FIRST As Long = &H1000
'Private Const LVM_SETCOLUMNWIDTH As Long = (LVM_FIRST + 30)
'Private Const LVSCW_AUTOSIZE As Long = -1
'Private Const LVSCW_AUTOSIZE_USEHEADER As Long = -2
'
'Private Declare Function SendMessage Lib "user32" _
'   Alias "SendMessageA" _
'  (ByVal hwnd As Long, _
'   ByVal wMsg As Long, _
'   ByVal wParam As Long, _
'   lParam As Any) As Long

'
'
'Private Sub Form_Load()
'
'   Dim sItem As String
'   Dim dwbuff As Long
'   Dim dbuff As Date
'   Dim r As Long
'   Dim l As Long
'   Dim t As Long
'   Dim w As Long
'   Dim cnt As Long
'   Dim sLen As Long
'   Dim itmx As ListItem
'
'   Randomize
'
'   sItem = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
'   sLen = (Len(sItem) / 2)
'
'   With ListView1
'
'      .ColumnHeaders.Add , , "Main column"
'      .ColumnHeaders.Add , , "Sub col 1"
'      .ColumnHeaders.Add , , "Sub col 2"
'      .ColumnHeaders.Add , , "Sub col 3"
'
'      .View = lvwReport
'
'     'add random data of varying length
'      For cnt = 1 To 20
'
'         r = Int(Rnd * sLen) + 1
'         dbuff = CDate(Int(Rnd * 5484) + 33219)
'
'         Set itmx = ListView1.ListItems.Add(, , Left$(sItem, r))
'
'         itmx.SubItems(1) = Format$(Int(Rnd * 2000) + 1, "###,###")
'         itmx.SubItems(2) = Format$(dbuff, "yyyy MMM d")
'         itmx.SubItems(3) = IIf(cnt Mod 3, "Etiam", "Hendrerit")
'      Next
'
'   End With
'
'   l = ListView1.Left
'   t = ListView1.Top + ListView1.Height + 100
'   w = (ListView1.Width - 200) \ 3
'
'   With Command1
'      .Move l, t, w, 345
'      .Caption = "Size to Content"
'   End With
'
'   With Command2
'      .Move Command1.Left + Command1.Width + 100, t, w, 345
'      .Caption = "Size to Header"
'   End With
'
'   With Command3
'      .Move Command2.Left + Command2.Width + 100, t, w, 345
'      .Caption = "Maximize Width"
'   End With
'
'End Sub
'
'
'Private Sub Command1_Click()
'
'  'Size each column based on the width
'  'of the widest list item in the column.
'  'If the items are shorter than the column
'  'header text, the header text is truncated.
'
'  'You may need to lengthen column header
'  'captions to see this effect.
'   Dim col2adjust As Long
'
'   For col2adjust = 0 To ListView1.ColumnHeaders.Count - 1
'
'      Call SendMessage(ListView1.hwnd, _
'                       LVM_SETCOLUMNWIDTH, _
'                       col2adjust, _
'                       ByVal LVSCW_AUTOSIZE)
'   Next
'End Sub
'
'
'Private Sub Command2_Click()
'
'  'Size each column based on the maximum of
'  'EITHER the column header text width, or,
'  'if the items below it are wider, the
'  'widest list item in the column.
'  '
'  'The last column is always resized to occupy
'  'the remaining width in the control.
'
'   Dim col2adjust As Long
'
'   For col2adjust = 0 To ListView1.ColumnHeaders.Count - 1
'
'      Call SendMessage(ListView1.hwnd, _
'                       LVM_SETCOLUMNWIDTH, _
'                       col2adjust, _
'                       ByVal LVSCW_AUTOSIZE_USEHEADER)
'   Next
'
'End Sub
'
'
'Private Sub Command3_Click()
'
'  'Because applying LVSCW_AUTOSIZE_USEHEADER
'  'to the last column in the control always
'  'sets its width to the maximum remaining control
'  'space, calling SendMessage passing just the
'  'last column index will resize only the last column,
'  'resulting in a listview utilizing the full
'  'control width space. To see this resizing in practice,
'  'create a wide listview and press the "Size to Contents"
'  'button followed by the "Maximize Width" button.
'  'By explanation:  if a listview had a total width of 2000
'  'and the first three columns each had individual widths of 250,
'  'calling this will cause the last column to widen
'  'to cover the remaining 1250.
'
'  'Calling this will force the data to remain within the
'  'listview. If a column other than the last column is
'  'widened or narrowed, the last column will become
'  'sized to ensure all data remains within the control.
'  'This could truncate text depending on the overall
'  'widths of the other columns; the minimum width is still
'  'based on the length of that column's header text.
'   Dim col2adjust As Long
'
'   col2adjust = ListView1.ColumnHeaders.Count - 1
'
'   Call SendMessage(ListView1.hwnd, _
'            LVM_SETCOLUMNWIDTH, _
'            col2adjust, _
'            ByVal LVSCW_AUTOSIZE_USEHEADER)
'
'End Sub
'
Function FileExists(Filename As String) As Boolean
    On Error GoTo ErrorHandler
    ' get the attributes and ensure that it isn't a directory
    FileExists = (GetAttr(Filename) And vbDirectory) = 0
ErrorHandler:
    ' if an error occurs, this function returns False
End Function


Sub Delay(Optional pdblSeconds As Double = 1)

    ' delay for x secodns
    ' this sub used very little CPU resouces
    
    If pdblSeconds = 0 Then Exit Sub
    
    Const OneSecond As Double = 1# / (1440# * 60#)
    
    Dim dblWaitUntil As Date
    dblWaitUntil = Now + OneSecond * pdblSeconds
    Do Until Now > dblWaitUntil
        Sleep 100
        DoEvents ' Allow windows message to be processed
    Loop
    
End Sub


'http://www.fmsinc.com/TPapers/vbacode/Debug.asp

Function GetErrorTrappingOption() As String
  Dim strSetting As String
  Select Case Application.GetOption("Error Trapping")
    Case 0
      strSetting = "Break on All Errors"
    Case 1
      strSetting = "Break in Class Modules"
    Case 2
      strSetting = "Break on Unhandled Errors"
  End Select
  GetErrorTrappingOption = strSetting
End Function


Sub SafeStart()
  Application.SetOption "Error Trapping", 1
End Sub

