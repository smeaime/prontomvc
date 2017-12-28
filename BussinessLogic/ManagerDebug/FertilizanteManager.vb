'Option Strict On
Option Explicit On

Option Infer On

Imports System
Imports System.Web
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
Imports System.Data.Linq 'lo necesita el CompileQuery?
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.Data
Imports System.Data.DataSetExtensions
Imports Microsoft.Reporting.WebForms
Imports System.IO

Imports System.Data.SqlClient

Imports System.Web.Security
Imports System.Security

Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager

Imports ClaseMigrar.SQLdinamico

Imports System.Drawing
'Namespace Pronto.ERP.Bll

Imports System.Collections.Generic

Imports System.Xml
Imports System.Text
Imports System.Security.Cryptography

Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports OpenXmlPowerTools
Imports DocumentFormat.OpenXml.Drawing.Wordprocessing

Imports System.Web.UI.WebControls

Imports Word = Microsoft.Office.Interop.Word
Imports Excel = Microsoft.Office.Interop.Excel

Imports System.Net
'Imports System.Configuration
'Imports System.Web.Security


Imports CartaDePorteManager
Imports CDPMailFiltrosManager2
'
Imports LogicaImportador.FormatosDeExcelFertilizantes
Imports LogicaImportador

Imports ProntoMVC.Data.Models

'Namespace Pronto.ERP.Bll


<DataObjectAttribute()> _
<Transaction(TransactionOption.Required)> _
Public Class FertilizanteManager
    Inherits ServicedComponent




    Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getCartaDePorteDetalles As Boolean) As FertilizantesCupos

        Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

        If id <= 0 Then Return Nothing

        Dim f = db.FertilizantesCupos.Find(id)


        Return f
    End Function

    Public Shared Function Anular(ByVal sc As String, ByVal cupo As FertilizantesCupos, ByVal IdUsuario As Integer, ByVal NombreUsuario As String) As Integer
        With cupo

            'esto tiene que estar en el manager, dios!
            .FechaAnulacion = Now
            '.UsuarioAnulacion = cmbUsuarioAnulo.SelectedValue
            '.Cumplido = "AN"

            .Anulada = "SI"

            'For Each i As CartaDePorteItem In .Detalles
            '    With i
            '        .Cumplido = "AN"
            '        '.EnviarEmail = 1
            '    End With
            'Next

            'revisar queda una en la familia, y ponerla como original
            Return Save(sc, cupo, IdUsuario, NombreUsuario)




            '                tira un error de duplicacion al anular
            '                _
            'URL:	/ProntoWeb/CartaDePorte.aspx?Id=1090650
            'User:           scabrera()
            '                Exception(Type) : System.ApplicationException()
            'Message:	Error en la grabacion Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'. The statement has been terminated.
            'Stack Trace:	 at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
            'at CartaDePorteManager.Anular(String sc, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
            'at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
            'at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
            'at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
            'at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
            'at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
            'at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
            'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
        End With
    End Function


    Public Shared Function DesAnular(ByVal sc As String, ByVal cupo As FertilizantesCupos, ByVal IdUsuario As Integer, ByVal NombreUsuario As String) As Integer
        With cupo

            'esto tiene que estar en el manager, dios!
            .FechaAnulacion = Now
            '.UsuarioAnulacion = cmbUsuarioAnulo.SelectedValue
            '.Cumplido = "AN"

            .Anulada = "NO"

            'For Each i As CartaDePorteItem In .Detalles
            '    With i
            '        .Cumplido = "AN"
            '        '.EnviarEmail = 1
            '    End With
            'Next
            Return Save(sc, cupo, IdUsuario, NombreUsuario)
        End With
    End Function



    Public Shared Function GetItemPorNumero(ByVal SC As String, ByVal NumeroCartaDePorte As String) As FertilizantesCupos

        ' Dim ds As Data.DataSet '= GeneralDB.TraerDatos(SC, "wCartasDePorte_TX_PorNumero", NumeroCartaDePorte, SubNumeroVagon)
        '        CREATE PROCEDURE [dbo].wCartasDePorte_TX_PorNumero
        '    @Numero BIGINT,
        '    @SubNumeroVagon INT = NULL
        '	--,@NumeroSubFijo  INT = NULL
        'AS 
        '    SELECT  *
        '    FROM    CartasDePorte
        '    WHERE   NumeroCartaDePorte = @Numero --AND SubNumero=@SubNumero
        '            AND SubNumeroVagon = ISNULL(@SubnumeroVagon, SubNumeroVagon)
        '            --AND NumeroSubFijo = ISNULL(@NumeroSubFijo, NumeroSubFijo)
        '			--AND isnull(Anulada,'NO')<>'SI'
        '	order by subnumerodefacturacion desc
        'go


        'arreglar esto, porque la segunda vez que se llama con el mismo subnumerodefacturacion, va a devolver un error



        Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))



        Dim familia = (From e In db.FertilizantesCupos _
                                      Where e.NumeradorTexto = NumeroCartaDePorte _
                                            Order By e.FechaAnulacion Descending _
                                      Select e).ToList()


        If familia.Count = 0 Then Return New FertilizantesCupos



        If familia.Count = 1 Then


            Return familia(0)

            ''devuelvo la primera que encontré -está MAL. si hay mas de uno, es un error
            'Dim myCartaDePorte As CartaDePorte
            'myCartaDePorte = CartaDePorteDB.GetItem(SC, ds.Tables(0).Rows(0).Item("IdCartaDePorte"))

            ''es un error. si estoy buscando un subnumero de facturacion especifico, me va a cagar
            'If SubnumeroFacturacion > 0 And myCartaDePorte.SubnumeroDeFacturacion <> SubnumeroFacturacion Then Return New CartaDePorte

            'Return myCartaDePorte

        Else
            'OJO:  puede ser una con otro subnumerodefacturacion...
            'ErrHandler2.WriteAndRaiseError("Ya existe una carta con ese número y vagon: " & NumeroCartaDePorte & " " & SubNumeroVagon & ".  Puede ser una con otro Subnumero de facturacion ")




            '            __________________________()

            '            Log(Entry)
            '04/11/2013 17:45:34
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=-1. Error Message:System.Exception
            'Application-defined or object-defined error.
            '   at Microsoft.VisualBasic.ErrObject.Raise(Int32 Number, Object Source, Object Description, Object HelpFile, Object HelpContext)
            '   at ErrHandler2.WriteAndRaiseError(String errorMessage) in E:\Backup\BDL\ProntoWeb\BusinessObject\ErrHandler2.vb:line 120
            '   at CartaDePorteManager.GetItemPorNumero(String SC, Int64 NumeroCartaDePorte, Int64 SubNumeroVagon)
            '   at CartaDePorteManager.validarUnicidad(String SC, String txtNumeroCDP, String txtSubNumeroVagon, Int32 IdEntity, CartaDePorte actualCartaDePorte)
            '            at(CartadeporteABM.RefrescarValidadorDuplicidad())
            '   at CartadeporteABM.txtNumeroCDP_TextChanged(Object sender, EventArgs e)
            '   at System.EventHandler.Invoke(Object sender, EventArgs e)
            '   at System.Web.UI.WebControls.TextBox.OnTextChanged(EventArgs e)
            '            at(System.Web.UI.WebControls.TextBox.RaisePostDataChangedEvent())
            '            at(System.Web.UI.WebControls.TextBox.System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent())
            '            at(System.Web.UI.Page.RaiseChangedEvents())
            '   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
            'Más de una carta tiene ese numero y vagon
            Return Nothing


        End If

    End Function



    Shared Function AdjuntarImagen2(SC As String, AsyncFileUpload1 As AjaxControlToolkit.AsyncFileUpload, forzarID As Long, ByRef sError As String, DirApp As String, NameOnlyFromFullPath As String) As String

        Dim DIRFTP = DirApp & "\DataBackupear\"
        Dim nombre = NameOnlyFromFullPath ' (AsyncFileUpload1.PostedFile.FileName)
        Randomize()
        Dim nombrenuevo = Int(Rnd(100000) * 100000).ToString.Replace(".", "") + Now.ToString("ddMMMyyyy_HHmmss") + "_" + nombre

        Dim numeroCarta = Val(nombre)
        Dim vagon = 0



        If (AsyncFileUpload1.HasFile) Then
            Try


                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))

                '    Session("NombreArchivoSubido") = DIRFTP + nombrenuevo

                Dim MyFile1 As New FileInfo(DIRFTP + nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try


                AsyncFileUpload1.SaveAs(DIRFTP + nombrenuevo)

            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If



        If forzarID = -1 Then
            Dim cdp = FertilizanteManager.GetItemPorNumero(SC, numeroCarta)
            If cdp.IdFertilizanteCupo = -1 Then
                sError = "No se encontró la carta " & numeroCarta
                Return nombrenuevo
                Exit Function
            End If
            forzarID = cdp.IdFertilizanteCupo
        End If


        Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))
        Dim oCarta = (From i In db.FertilizantesCupos Where i.IdFertilizanteCupo = forzarID).SingleOrDefault
        oCarta.PathImagen2 = nombrenuevo 'nombrenuevo
        db.SaveChanges()
        sError &= "<a href=""Fertilizante.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeradorTexto & "</a>; "


        Return nombrenuevo


    End Function


    Shared Function GrabaRenglonEnTablaFertilizantes(ByRef dr As DataRow, SC As String, Session As System.Web.SessionState.HttpSessionState, _
                                    cmbdespacho As System.Web.UI.WebControls.DropDownList, cmbpuntodespacho As System.Web.UI.WebControls.DropDownList, _
                                    chkAyer As System.Web.UI.WebControls.CheckBox, txtLogErrores As System.Web.UI.WebControls.TextBox, cmbPuntoVenta As System.Web.UI.WebControls.DropDownList, _
                                    txtFechaArribo As System.Web.UI.WebControls.TextBox, cmbFormato As System.Web.UI.WebControls.DropDownList, _
                                    NoValidarColumnas As List(Of String) _
        ) As String 'devuelve la columna del error si es que hubo
        'Dim dt = ViewstateToDatatable()

        'Dim dr = dt.Rows(row)

        Dim myCartaDePorte As New ProntoMVC.Data.Models.FertilizantesCupos






        'If existeLaCarta Then
        Dim numeroCarta As String = Replace(dr.Item("NumeroCDP"), "-", "")
        Dim vagon As Long = 0 'por ahora, las cdp importadas tendran subnumero 0
        Dim subfijo As Long = 0 'por ahora, las cdp importadas tendran subnumero 0


        Dim subnumerodefac As Long = Val(iisNull(dr.Item("SUBNUMERODEFACTURACION"), -1))
        If subnumerodefac <= 0 Then subnumerodefac = -1


        'Tomar como regla que cuando se haga la pegatina siempre se PEGUE con el prefijo 5 adelante. (ESTO TOMARLO COMO REGLA PARA TODAS LAS PEGATINAS DE TODOS LOS PUERTOS)
        'If numeroCarta < 100000000 Then numeroCarta += 500000000



        myCartaDePorte = FertilizanteManager.GetItemPorNumero(SC, numeroCarta)

        'y si tiene duplicados, como sabes?


        'End If

        With myCartaDePorte

            'If .IdFacturaImputada > 0 Then
            '    'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada, porque ya existe como facturada o rechazada")
            '    ErrHandler2.WriteAndRaiseError("La Carta " & numeroCarta & " no puede ser importada porque ya existe como facturada")
            '    Return 0
            'End If


            'If .NetoFinalDespuesDeRestadasMermas > 0 Or .NetoFinalAntesDeRestarMermas > 0 Then
            '    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9095
            '    'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada, porque ya existe como facturada o rechazada")
            '    ErrHandler2.WriteAndRaiseError("La Carta " & numeroCarta & " " & IIf(vagon = 0, "", vagon) & " está en estado <descarga> y no se le pueden pisar datos. ")
            '    Return 0
            'End If


            'If .Anulada = "SI" Then
            '    ErrHandler2.WriteError("La Carta " & numeroCarta & " estaba anulada. Se reestablece")
            '    LogPronto(SC, .Id, "IMPANU", Session(SESSIONPRONTO_UserName))
            '    CartaDePorteManager.CopiarEnHistorico(SC, .Id)    'hacer historico siempre en las modificaciones de cartas y clientes?

            '    .Anulada = "NO"
            'End If




            'If .Id > 0 And .SubnumeroDeFacturacion > -1 Then

            '    Dim q As IQueryable(Of CartasDePorte) = CartaDePorteManager.FamiliaDeDuplicadosDeCartasPorte(SC, myCartaDePorte)

            '    If q.Count > 1 Then
            '        'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada porque está duplicada para facturarsele a varios clientes")
            '        ErrHandler2.WriteAndRaiseError("La Carta " & numeroCarta & " no puede ser importada porque está duplicada para facturarsele a varios clientes")
            '        Return 0
            '    End If

            'ElseIf .Id <= 0 Then
            '    .SubnumeroDeFacturacion = -1
            'End If

















            'Pinta que no hay otra manera de actualizar un dataset suelto http://forums.asp.net/p/755961/1012665.aspx
            '.Numero = numeroCarta
            .NumeradorTexto = numeroCarta
            '.SubnumeroVagon = vagon
            '.SubnumeroDeFacturacion = subnumerodefac

            'If .NumeroCartaDePorte <= 0 Then
            '    'Debug.Print(r.Item("Carta Porte"))
            '    'renglonControl(r, "Carta Porte").BackColor = System.Drawing.Color.Red
            '    Stop
            '    Return 0
            'End If

            '.Cantidad = Val(dr.Item("NetoProc"))
            .KilosMaximo = Val(dr.Item("NetoProc"))


            .Contrato = Left(dr.Item(enumColumnasDeGrillaFinalFertilizantes.Auxiliar5.ToString).ToString, 20)

            .FechaIngreso = iisValidSqlDate(TextoAFecha(iisNull(dr.Item(enumColumnasDeGrillaFinalFertilizantes.FechaDescarga.ToString))))

            .Chasis = iisNull(dr.Item("Patente"))
            .Acoplado = iisNull(dr.Item("Acoplado"))

            .Puro = IIf(iisNull(dr.Item("Calidad")) = "X", 1, 0)
            .Mezcla = cmbPuntoVenta.SelectedValue

            .Porcentaje1 = StringToDecimal(iisNull(dr.Item("column17"))) * 100
            .Porcentaje2 = StringToDecimal(iisNull(dr.Item("column18"))) * 100
            .Porcentaje3 = StringToDecimal(iisNull(dr.Item("column19"))) * 100
            .Porcentaje4 = StringToDecimal(iisNull(dr.Item("column20"))) * 100


            Dim formadespacho As String = iisNull(dr.Item(enumColumnasDeGrillaFinalFertilizantes.Comprador.ToString)).ToString.Trim.ToUpper
            Select Case formadespacho
                Case "GRANEL"
                    .FormaDespacho = 1
                Case "BOLSA", "BOLSAS"
                    .FormaDespacho = 2
                Case "BIGBAG", "BIG BAGS (1000 KG)", "BIG BAGS (500 KG)"
                    .FormaDespacho = 3
                Case Else
                    If formadespacho.Contains("GRANEL") Then
                        .FormaDespacho = 1
                    ElseIf formadespacho.Contains("BOLSA") Then
                        .FormaDespacho = 2
                    ElseIf formadespacho.Contains("BIG") Then
                        .FormaDespacho = 3
                    Else
                        .FormaDespacho = Nothing
                    End If
            End Select


            .Despacho = cmbdespacho.Text
            .PuntoDespacho = cmbpuntodespacho.Text



            '/////////////////////////////////////////
            '/////////////////////////////////////////

            dr.Item("Producto") = iisNull(dr.Item("Producto"))
            If dr.Item("Producto") <> "NO_VALIDAR" Then
                .IdArticulo = BuscaIdArticuloPreciso(dr.Item("Producto"), SC)
                If .IdArticulo = -1 Then .IdArticulo = BuscaIdArticuloPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Producto")), SC)
                'dt.Rows(row).Item("IdArticulo") = .IdArticulo
                If .IdArticulo = -1 Then Return "Producto"
            End If


            '/////////////////////////////////////////
            'revisar MostrarAutocompleteCorrespondiente() en el codebehind de FertilizantesImportador

            dr.Item("column12") = iisNull(dr.Item("column12"))
            If dr.Item("column12") <> "NO_VALIDAR" And dr.Item("column12") <> "" Then
                .IdArticuloComponente1 = BuscaIdArticuloPreciso(dr.Item("column12"), SC)
                If .IdArticuloComponente1 = -1 Then .IdArticuloComponente1 = BuscaIdArticuloPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("column12")), SC)
                'dt.Rows(row).Item("IdArticulo") = .IdArticulo
                If .IdArticuloComponente1 = -1 Then Return "column12"
            End If

            dr.Item("column13") = iisNull(dr.Item("column13"))
            If dr.Item("column13") <> "NO_VALIDAR" And dr.Item("column13") <> "" Then
                .IdArticuloComponente2 = BuscaIdArticuloPreciso(dr.Item("column13"), SC)
                If .IdArticuloComponente2 = -1 Then .IdArticuloComponente2 = BuscaIdArticuloPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("column13")), SC)
                'dt.Rows(row).Item("IdArticulo") = .IdArticulo
                If .IdArticuloComponente2 = -1 Then Return "column13"
            End If

            dr.Item("column14") = iisNull(dr.Item("column14"))
            If dr.Item("column14") <> "NO_VALIDAR" And dr.Item("column14") <> "" Then
                .IdArticuloComponente3 = BuscaIdArticuloPreciso(dr.Item("column14"), SC)
                If .IdArticuloComponente3 = -1 Then .IdArticuloComponente3 = BuscaIdArticuloPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("column14")), SC)
                'dt.Rows(row).Item("IdArticulo") = .IdArticulo
                If .IdArticuloComponente3 = -1 Then Return "column14"
            End If

            dr.Item("column15") = iisNull(dr.Item("column15"))
            If dr.Item("column15") <> "NO_VALIDAR" And dr.Item("column15") <> "" Then
                .IdArticuloComponente4 = BuscaIdArticuloPreciso(dr.Item("column15"), SC)
                If .IdArticuloComponente4 = -1 Then .IdArticuloComponente4 = BuscaIdArticuloPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("column15")), SC)
                'dt.Rows(row).Item("IdArticulo") = .IdArticulo
                If .IdArticuloComponente4 = -1 Then Return "column15"
            End If





            ''/////////////////////////////////////////

            dr.Item("Titular") = iisNull(dr.Item("Titular"))
            If dr.Item("Titular") <> "NO_VALIDAR" And Not NoValidarColumnas.Contains("Titular") Then
                .Cliente = BuscaIdClientePrecisoConCUIT(dr.Item("Titular"), SC)
                If .Cliente = -1 Then .Cliente = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Titular")), SC)
                dr.Item("IdTitular") = .Cliente
                If .Cliente = -1 Then Return "Titular"
            End If



            dr.Item("Intermediario") = iisNull(dr.Item("Intermediario"))
            If dr.Item("Intermediario") <> "NO_VALIDAR" And Trim(dr.Item("Intermediario")) <> "" Then
                .CuentaOrden = BuscaIdClientePrecisoConCUIT(dr.Item("Intermediario"), SC)
                If .CuentaOrden = -1 Then .CuentaOrden = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Intermediario")), SC)
                dr.Item("IdIntermediario") = .CuentaOrden
                If .CuentaOrden = -1 Then Return "Intermediario"
            End If






            dr.Item("Destino") = iisNull(dr.Item("Destino"))
            If dr.Item("Destino") <> "NO_VALIDAR" And Not NoValidarColumnas.Contains("Destino") And Trim(dr.Item("Destino")) <> "" Then
                .Destino = BuscaIdWilliamsDestinoPreciso(RTrim(dr.Item("Destino")), SC)
                If .Destino = -1 Then .Destino = BuscaIdWilliamsDestinoPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Destino")), SC)
                'dt.Rows(row).Item("IdDestino") = .Destino
                If .Destino = -1 And dr.Item("Destino") = "" Then
                    'solo uso el default si está vacío el texto
                    '.Destino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, SC)
                End If
                If .Destino = -1 Then
                    Return "Destino"
                Else
                    'AsignarContratistasSegunDestino(dr, SC)
                End If
            End If




            dr.Item("Procedencia") = iisNull(dr.Item("Procedencia"))
            If dr.Item("Procedencia") <> "NO_VALIDAR" And Not NoValidarColumnas.Contains("Procedencia") And Trim(dr.Item("Procedencia")) <> "" Then
                .IdLocalidadTransportista = BuscaIdLocalidadPreciso(RTrim(dr.Item("Procedencia")), SC)
                If .IdLocalidadTransportista = -1 Then .IdLocalidadTransportista = BuscaIdLocalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Procedencia")), SC)
                'dt.Rows(row).Item("IdProcedencia") = .Procedencia
                If .IdLocalidadTransportista = -1 Then Return "Procedencia"
            End If



            'sector del confeccionó

            '/////////////////////////////////////////



            dr.Item("column21") = iisNull(dr.Item("column21"))
            If dr.Item("column21") <> "NO_VALIDAR" And dr.Item("column21") <> "" And Not NoValidarColumnas.Contains("column21") Then
                .IdTransportista = BuscaIdTransportistaPreciso(dr.Item("column21"), SC)
                If .IdTransportista = -1 Then .IdTransportista = BuscaIdTransportistaPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("column21")), SC)
                If .IdTransportista = -1 Then Return "column21"
            End If


            dr.Item("column23") = iisNull(dr.Item("column23"))
            If dr.Item("column23") <> "NO_VALIDAR" And dr.Item("column23") <> "" And Not NoValidarColumnas.Contains("column23") Then
                .IdChofer = BuscaIdChoferPreciso(dr.Item("column23"), SC)
                If .IdChofer = -1 Then .IdChofer = BuscaIdChoferPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("column23")), SC)
                If .IdChofer = -1 Then Return "column23"
            End If



            '/////////////////////////////////////////


            actualizar(.Observaciones, dr.Item("column25"))




            Dim ms As String
            If FertilizanteManager.IsValid(SC, myCartaDePorte, ms) Then
                '                Try


                Try
                    'EntidadManager.LogPronto(HFSC.Value, id, "CartaPorte Anulacion de posiciones ", Session(SESSIONPRONTO_UserName))

                    'loguear el formato usado   y el nombre del archivo importado
                    'Dim nombre = Session("NombreArchivoSubido")
                    'Dim formato '= FormatoDelArchivo(nombre, cmbFormato)
                    'Dim s = " F:" + formato.ToString + " " + nombre


                    'EntidadManager.Tarea(SC, "Log_InsertarRegistro", "IMPORT", _
                    '                          .Id, 0, Now, 0, "Tabla : CartaPorte", "", Session(SESSIONPRONTO_UserName), _
                    '                         s, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                    '                        DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                    '                        DBNull.Value, DBNull.Value, DBNull.Value)



                    'GetStoreProcedure(SC, enumSPs.Log_InsertarRegistro, IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
                    '                          CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario)

                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                If Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName)) = -1 Then
                    'Debug.Print("No se pudo grabar el renglon n° " & myCartaDePorte.NumeroCartaDePorte)
                    'ErrHandler2.WriteError("Error al grabar CDP importada")
                Else
                    'poner url hacia el ABM
                    'Response.Redirect(String.Format("CartaDePorte.aspx?Id={0}", IdCartaDePorte.ToString))

                    'Dim hl As WebControls.HyperLink = CType(r.Cells(getGridIDcolbyHeader("Ir a", gvExcel)).Controls(1), WebControls.HyperLink)
                    'hl.NavigateUrl = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)
                    'dr.Item("URLgenerada") = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)

                End If

            Else
                'Dim sError = "Error al validar CDP importada: " & myCartaDePorte.NumeroCartaDePorte & " " & ms
                'ErrHandler2.WriteError(sError)
                'txtLogErrores.Visible = True
                'If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
                'txtLogErrores.Text &= sError & vbCrLf
            End If

        End With

        Return 0
    End Function




    Public Enum FormatosDeExcelFertilizantes
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        Autodetectar
        Moviport
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
    End Enum

    Shared Function FormatoDelArchivoFertilizantes(ByVal sNombreArchivoImportado As String, cmbFormato As System.Web.UI.WebControls.DropDownList) As FormatosDeExcelFertilizantes
        '"Bunge Ramallo" 
        '"Cargill Planta Quebracho"
        '"Cargill Pta Alvear"
        '"LDC Gral Lagos" 
        '"LDC Planta Timbues"
        '"Muelle Pampa"
        '"Terminal 6"
        '"Toepfer Pto El Transito"
        '"Toepfer Destino"
        '"VICENTIN"


        If cmbFormato.SelectedIndex <> FormatosDeExcelFertilizantes.Autodetectar Then Return [Enum].Parse(GetType(FormatosDeExcelFertilizantes), cmbFormato.SelectedItem.Value.ToString)




        'If InStr(sNombreArchivoImportado.ToString.ToUpper, ".TXT") > 0 Then
        '    If InStr(sNombreArchivoImportado.ToString.ToUpper, "DESCAR") = 0 Then
        '        cmbFormato.SelectedIndex = FormatosDeExcelFertilizantes.PuertoACA
        '    Else
        '        cmbFormato.SelectedIndex = FormatosDeExcelFertilizantes.Reyser
        '    End If
        'ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, ".RTF") > 0 Then
        '    cmbFormato.SelectedIndex = FormatosDeExcelFertilizantes.Nidera
        'ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "BUNGE") > 0 Then
        '    cmbFormato.SelectedIndex = FormatosDeExcelFertilizantes.BungeRamallo
        'ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "PAMPA") > 0 Then
        '    cmbFormato.SelectedIndex = FormatosDeExcelFertilizantes.MuellePampa
        'ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "TIMBUES") > 0 Or InStr(sNombreArchivoImportado.ToString.ToUpper, "LDC") > 0 Then
        '    cmbFormato.SelectedIndex = FormatosDeExcelFertilizantes.LDCPlantaTimbues
        'ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "VICENT") > 0 Then
        '    cmbFormato.SelectedIndex = FormatosDeExcelFertilizantes.VICENTIN
        'End If


        'Return cmbFormato.SelectedIndex


        ''http://stackoverflow.com/questions/1061228/c-sharp-explicit-cast-string-to-enum
        ''http://stackoverflow.com/questions/424366/c-sharp-string-enums
        ''return (T)Enum.Parse(typeof(T), str)

        ''If cmbFormato.SelectedValue = "PuertoACA" Then 'formato CSV
        ''    Return PuertoACA
        ''ElseIf cmbFormato.SelectedValue = "AdmServPortuarios" Then

        ''    Return -1

        ''ElseIf cmbFormato.SelectedValue = "Toepfer Transito" Or InStr(nombre.ToUpper, "TRANSITO") Then

        ''    ds = GetExcel(DIRFTP + nombre, 3) 'hoja 3

        ''ElseIf InStr(nombre.ToUpper, "TOEPFER") Then

        ''    ds = GetExcel(DIRFTP + nombre, 1)

        ''ElseIf cmbFormato.SelectedValue = "Cargill" Or InStr(nombre.ToUpper, "CARGILL") Then

        ''    ds = GetExcel(DIRFTP + nombre, 1) 'hoja 1

        ''Else

        ''    ds = GetExcel(DIRFTP + nombre)

        ''End If
    End Function




    <DataObjectMethod(DataObjectMethodType.Update, True)> _
    Public Shared Function Save(ByVal SC As String, ByVal cupoFertilizante As ProntoMVC.Data.Models.FertilizantesCupos, ByVal IdUsuario As Integer, ByVal NombreUsuario As String, Optional ByVal bCopiarDuplicados As Boolean = True) As Integer
        Dim CartaDePorteId As Integer

        'Dim myTransactionScope As TransactionScope = New TransactionScope
        Try


            Dim ms As String
            If Not IsValid(SC, cupoFertilizante, ms) Then
                ErrHandler2.WriteError(ms)
                Return -1
            End If




            With cupoFertilizante
                Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))



                If .IdFertilizanteCupo <= 0 Then
                    .FechaIngreso = Now
                    .IdUsuarioIngreso = IdUsuario
                    .FechaModificacion = Now
                    .IdUsuarioModifico = IdUsuario
                    db.FertilizantesCupos.Add(cupoFertilizante)
                Else

                    .FechaModificacion = Now
                    .IdUsuarioModifico = IdUsuario
                    UpdateColecciones(cupoFertilizante, db)

                End If

                db.SaveChanges()



                'myCartaDePorte.FechaTimeStamp = TraerUltimoTimeStamp(SC, CartaDePorteId) 'si está haciendo un duplicado, el id del objeto es -1
                ' myCartaDePorte.Id = CartaDePorteId

            End With

        Catch ex As System.Data.Entity.Validation.DbEntityValidationException

            'http://stackoverflow.com/questions/10219864/ef-code-first-how-do-i-see-entityvalidationerrors-property-from-the-nuget-pac
            Dim sb = New StringBuilder()

            For Each failure In ex.EntityValidationErrors

                sb.AppendFormat("{0} failed validation\n", failure.Entry.Entity.GetType())
                For Each er In failure.ValidationErrors
                    sb.AppendFormat("- {0} : {1}", er.PropertyName, er.ErrorMessage)
                    sb.AppendLine()
                Next
            Next

            Throw New ApplicationException("Error en la grabacion " + sb.ToString(), ex)

        Catch ex As Exception
            'ContextUtil.SetAbort()
            ErrHandler2.WriteError(ex)
            Debug.Print(ex.ToString)
            Throw New ApplicationException("Error en la grabacion " + ex.ToString, ex)
            'Return -1

        End Try

        Return cupoFertilizante.IdFertilizanteCupo
    End Function



    Shared Sub UpdateColecciones(ByRef o As FertilizantesCupos, db As DemoProntoEntities)

        ' http://stackoverflow.com/questions/7968598/entity-4-1-updating-an-existing-parent-entity-with-new-child-entities

        Dim id = o.IdFertilizanteCupo

        Dim EntidadOriginal = db.FertilizantesCupos.Where(Function(p) p.IdFertilizanteCupo = id).SingleOrDefault()


        Dim EntidadEntry = db.Entry(EntidadOriginal)
        EntidadEntry.CurrentValues.SetValues(o)



        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified
    End Sub



    Public Enum enumColumnasDeGrillaFinalFertilizantes As Integer
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"


        Producto
        Titular
        Intermediario
        RComercial
        Corredor
        Comprador
        NumeroCDP
        Procedencia
        Destino
        Subcontratistas
        Calidad
        column18
        FechaDescarga
        Patente
        Acoplado
        NetoProc
        column12
        column13
        column14
        column15
        column16
        column17
        column19
        column20
        column21
        column22
        column23
        column24
        column25

        Auxiliar5

        CTG
        KmARecorrer
        TarifaTransportista

        EntregadorFiltrarPorWilliams 'columna que se debe filtrar en el excel para quedarnos solamente con las cartas de williams

        Exporta
        SubnumeroDeFacturacion


        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"


        _Desconocido
    End Enum



    Shared Function ExcepcionHermanado(ByVal s As String, ByVal sNombreArchivoImportado As String, ByVal LetraColumna As Integer, ByVal FormatoDelArchivo As FormatosDeExcelFertilizantes) As enumColumnasDeGrillaFinalFertilizantes
        'Consulta 5784
        '        Bunge
        'VENDEDOR es Destinatario (generalmente es Titular)
        'NETO es Neto proc (generalmente es Neto Pto)

        '        Timbues
        'KGS. es Neto Proc (generalmente es Neto Pto)




        'If cmbFormato.SelectedValue = "Toepfer Transito" Then

        s = s.ToUpper.Trim

        Select Case FormatoDelArchivo
            'Case BungeRamallo
            '    'cargador ----> titular
            '    'vendedor ----> remitcomer
            '    'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11790
            '    'CUANDO HAY CARGADOR Y VENDEDOR -> TITULAR, INTERMEDIARIO
            '    'CUANDO HAY CARGADOR, VENDEDOR Y C/ORDEN -> TITULAR, REMITENTE E INTERMEDIARIO

            '    'los reacomodo en FormatearColumnasDeCalidadesRamallo()
            '    If s = "CARGADOR" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.Titular 'en lugar de vendedor/titular
            '    ElseIf s = "VENDEDOR" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.Intermediario 'en lugar de intermediario
            '    ElseIf s = "C/ORDEN 1" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.RComercial 'en lugar de intermediario
            '    ElseIf s = "NETO" Then
            '        'en bunge muelle pampa usa "neto" para el netoproc
            '        Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
            '    ElseIf s = "RUBROS" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.column15
            '    ElseIf LetraColumna = 19 Then '"U" Then
            '        'Return enumColumnasDeGrillaFinalFertilizantes.column25
            '    End If
            'Case MuellePampa, Terminal6, NobleLima
            '    If s = "NETO" Then
            '        'en bunge muelle pampa usa "neto" para el netoproc
            '        Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
            '    End If
            'Case LDCPlantaTimbues, LDCGralLagos
            '    If s = "KGS." Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
            '    ElseIf s = "PROC" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
            '    ElseIf LetraColumna = 13 Then ' "N" Then
            '        'columna N en timbues (columna sin titulo) es OBSERVACIONES
            '        Return enumColumnasDeGrillaFinalFertilizantes.column25
            '    End If
            'Case VICENTIN

            '    If s = "DESC" Or s = "KILOS" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
            '    End If
            'Case VICENTIN_ExcepcionTagRemitenteConflictivo

            '    If s = "REMITENTE" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.Titular
            '    End If
            '    If s = "REMITENTE COMERCIAL" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.RComercial
            '    End If

            'Case Renova
            '    If s = "FECHA" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.column18
            '    End If
            '    If s = "NETO" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
            '    End If
            '    If s = "ACOPLADO" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.column24 'no te sirve poner _desconocido:  HermanarLeyenda() en ese caso se fija qué pasa. Lo mando entonces a una columna sin consecuencias (CUIT CHOFER)
            '    End If
            '    If s = "PATENTE" Then
            '        Return enumColumnasDeGrillaFinalFertilizantes.column24
            '    End If


        End Select





        Return enumColumnasDeGrillaFinalFertilizantes._Desconocido
    End Function


    Shared Function HermanarLeyendaConColumna(ByVal s As String, Optional ByVal sNombreArchivoImportado As String = "", Optional ByVal LetraColumna As Integer = -1, Optional ByVal formato As FormatosDeExcelFertilizantes = Nothing) As String
        Dim sRet As String = HermanarLeyendaConColumna_aCadena(s, sNombreArchivoImportado, LetraColumna, formato)

        If sRet = "" Then sRet = "_Desconocido" 'trucheo. arreglar

        Dim enumEntidad As enumColumnasDeGrillaFinalFertilizantes = [Enum].Parse(GetType(enumColumnasDeGrillaFinalFertilizantes), sRet)

        Dim reconversion As String = enumEntidad.ToString
        If reconversion = "_Desconocido" Then reconversion = "" 'trucheo. arreglar


        Return reconversion
    End Function

    Private Shared Function HermanarLeyendaConColumna_aCadena(ByVal s As String, Optional ByVal sNombreArchivoImportado As String = "", Optional ByVal LetraColumna As Integer = -1, Optional ByVal formato As FormatosDeExcelFertilizantes = Nothing) As String
        s = Trim(s)

        Dim excep = ExcepcionHermanado(s, sNombreArchivoImportado, LetraColumna, formato)
        If excep <> enumColumnasDeGrillaFinalFertilizantes._Desconocido Then
            Return excep.ToString
        End If

        Select Case s
            Case "PRODUCTO (UG,DAP,MAP,ETC)"
                Return enumColumnasDeGrillaFinalFertilizantes.Producto

            Case "Nº CUPO"
                Return enumColumnasDeGrillaFinalFertilizantes.NumeroCDP

            Case "DESTINO DE LA MERCADERIA"
                Return enumColumnasDeGrillaFinalFertilizantes.Destino


            Case "CLIENTE"
                Return enumColumnasDeGrillaFinalFertilizantes.Titular

            Case "FECHA"
                Return enumColumnasDeGrillaFinalFertilizantes.FechaDescarga

            Case "C/ORDEN"
                Return "Intermediario"


            Case "CONTRATO"
                '  Return enumColumnasDeGrillaFinalFertilizantes.
                Return enumColumnasDeGrillaFinalFertilizantes.Auxiliar5
            Case "PURO"
                Return enumColumnasDeGrillaFinalFertilizantes.Calidad
            Case "MEZCLA"
                Return enumColumnasDeGrillaFinalFertilizantes.Exporta






            Case "PRODUCTO 1"
                Return enumColumnasDeGrillaFinalFertilizantes.column12
            Case "PRODUCTO 2"
                Return enumColumnasDeGrillaFinalFertilizantes.column13
            Case "PRODUCTO 3"
                Return enumColumnasDeGrillaFinalFertilizantes.column14
            Case "PRODUCTO4", "PRODUCTO 4"
                Return enumColumnasDeGrillaFinalFertilizantes.column15

            Case "% PRODUCTO 1"
                Return enumColumnasDeGrillaFinalFertilizantes.column17
            Case "% PRODUCTO 2"
                Return enumColumnasDeGrillaFinalFertilizantes.column18
            Case "% PRODUCTO 3"
                Return enumColumnasDeGrillaFinalFertilizantes.column19
            Case "% PRODUCTO 4"
                Return enumColumnasDeGrillaFinalFertilizantes.column20




            Case "FORMA DE DESPACHO (GRANEL,BLS, BIGBAG)"

                Return enumColumnasDeGrillaFinalFertilizantes.Comprador

            Case "CANTIDAD (KG)"
                Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
            Case "RECORRIDO"
                Return enumColumnasDeGrillaFinalFertilizantes.KmARecorrer



            Case "TRANSPORTISTA", "TRANSP.", "TRANSPORTE"
                Return enumColumnasDeGrillaFinalFertilizantes.column21
            Case "CUIT TRANS"
                Return enumColumnasDeGrillaFinalFertilizantes.column22
            Case "NOMBRE DEL CHOFER"
                Return enumColumnasDeGrillaFinalFertilizantes.column23
            Case "CUIT CHOFER"
                Return enumColumnasDeGrillaFinalFertilizantes.column24


            Case "LOCALIDAD TRANSP"

                Return enumColumnasDeGrillaFinalFertilizantes.Procedencia

            Case "OBSERVACIONES.", "OBSERVACIONES", "OBSERVACION", "OBSERV.", "MER/REB", "ANÁLISIS"
                Return enumColumnasDeGrillaFinalFertilizantes.column25

            Case "PATENTE", "PAT CHASIS", "PTE.", "PATE", "CHASIS"
                Return enumColumnasDeGrillaFinalFertilizantes.Patente
            Case "ACOPLADO", "ACOPL", "PAT.ACOP."
                Return enumColumnasDeGrillaFinalFertilizantes.Acoplado



            Case "XXXXX"
            Case "XXXXX"
            Case "XXXXX"


            Case Else
                Debug.Print(s)
                Return ""



                'qué tendría que hacer para agregar nuevas columnas? (ctg, tarifa, 
                '-agregarlas en:
                '   la tabla temporal
                '   acá en el HermanarViejo
                '   a la enumeracion
                '   a la grilla
                '   a la GrabaRenglonEnTablaCDP
                'tambien sería bueno que estuviesen las columnas tipadas....


        End Select
    End Function


    Public Shared Function IsValid(ByVal SC As String, ByVal cupoFertilizante As ProntoMVC.Data.Models.FertilizantesCupos, Optional ByRef ms As String = "", Optional ByRef sWarnings As String = "") As Boolean

        With cupoFertilizante
            'validarUnicidad()



            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)
            'si manotearon la unicidad (numerocdp, vagon) tambien debería loguearse el cambio (lo ideal sería que no pudiesen cambiarlo...)



            'If iisNull(.NumeroCartaDePorte, 0) < 100000000 Or iisNull(.NumeroCartaDePorte, 0) > 9999999999 Then
            '    ms = "El número de CDP debe tener 9 o 10 dígitos"
            '    Return False
            'End If

            If .NumeradorTexto.Trim = "" Then ' > Int32.MaxValue Then
                ms = "El cupo debe tener una descripción"
                Return False
            End If


            'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=15079
            'Por lo de los litros, tiene que funcionar así:

            'En todos los camiones debe informarse en el remito el kilaje de la carga por un tema legal.
            'Por otro lado, ellos deben controlar el máximo autorizado, pero en AgroQuimicos o Liquidos este dato va en litros.
            'Por eso, en estos casos debe agregarse un campo "Litros Finales" y el control debe ser contra este dato (para Commodities y Especialidades debe ser contra Neto Final)



            If .Despacho = "AGROQUIMICOS" Or .Despacho = "LIQUIDOS" Then
                If .KilosMaximo < .LitrosFinal Then
                    ms = "Litros Final supera el máximo autorizado"
                    Return False
                End If
            Else
                If .KilosMaximo < .Cantidad Then
                    ms = "Kilos Final supera el máximo autorizado"
                    Return False
                End If
            End If







            'If EsUnoDeLosClientesExportador(SC, myCartaDePorte) And .SubnumeroDeFacturacion < 0 Then
            '    sWarnings &= "Se usará automáticamente un duplicado para facturarle al cliente exportador" & vbCrLf
            'End If
        End With


        Return True
    End Function














End Class



