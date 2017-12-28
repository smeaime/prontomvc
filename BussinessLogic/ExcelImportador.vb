'Option Strict On
Option Explicit On

Option Infer On

Imports System.Data.OleDb

Imports System.Reflection
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

Imports ProntoMVC.Data

Imports System.Web.Security
Imports System.Security

Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager

Imports ClaseMigrar.SQLdinamico

Imports System.Drawing
'Namespace Pronto.ERP.Bll

Imports System.Collections.Generic


Imports System.Data.Entity.SqlServer

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

Imports ProntoMVC.Data.Models


Imports System.Net
'Imports System.Configuration
'Imports System.Web.Security

Imports Inlite.ClearImageNet


Imports CartaDePorteManager
Imports CDPMailFiltrosManager2

Imports LogicaImportador.FormatosDeExcel


Imports BitMiracle



Public Class LogicaImportador




    Public Enum FormatosDeExcel
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        Autodetectar
        PuertoACA
        BungeRamallo
        CargillPlantaQuebracho
        CargillPtaAlvear
        LDCGralLagos
        LDCPlantaTimbues
        MuellePampa
        NobleLima
        Renova
        Terminal6
        ToepferPtoElTransito
        Toepfer
        VICENTIN
        VICENTIN_ExcepcionTagRemitenteConflictivo
        Reyser
        ReyserCargillPosicion
        Reyser2
        ReyserAnalisis
        CerealnetToepfer
        Unidad6
        Unidad6Prefijo_NroCarta
        Unidad6Analisis
        AdmServPortuarios

        BungeRamalloDescargaTexto

        Nidera
        Urenport
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
    End Enum


    Public Shared Function PuertoACAToDataset(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 50
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()
        dr(0) = "F. DE CARGA"
        dr(1) = "HORA"
        dr(2) = "Carton"
        dr(3) = "Turno"
        dr(4) = "CTG"
        dr(5) = "CARGADOR"
        'dr(6) = "CUIT"
        dr(7) = "INTERMEDIARIO"
        'dr(8) = "CUIT"
        dr(9) = "REMITENTE COMERCIAL"
        'dr(10) = "CUIT"
        dr(13) = "CORREDOR"

        dr(19) = "DESTINATARIO"
        'dr(20) = "DESTINATARIOCUIT"

        dr(21) = "TRANSPORTISTA"
        dr(22) = "TRANSPCUIT"
        dr(23) = "CHOFER"
        dr(24) = "CHOFERCUIT"
        dr(25) = "PRODUCTO"
        dr(26) = "CARTA PORTE"








        ' 0        IngresoFecha(LLEGADA)
        ' 1        IngresoHora(HORA)
        ' 2 Carton (turno orden de ingreso) 
        ' 3 Turno  (código que le asigna ACA a cada camión ) (ORDEN)
        ' 4 Número de CTG  (CTG)
        ' 5 Cargador1 (TITULA DE CP) (CARGADOR)
        ' 6        CUIT()
        ' 7 Cargador2  (INTERMEDIARIO) (VEND. CJE.)
        ' 8        CUIT()
        ' 9 Cargador3 (REMITENTE COMERCIAL) (C Y ORD2)
        '10        CUIT()
        '11 Cargador4 (CUANDO CORRESPONDA “MERCADO A TERMINO”)
        '12        CUIT()
        '13 Corredor1 (CORREDOR QUE FIGURA EN CP “CORREDOR”) (CORREDOR) 
        '14        CUIT()
        '15 Corredor2 (CORREDOR QUE FIGURA EN OBSEVACIONES “CORR INTERVINIENTE”) (OBS)
        '16        CUIT()
        '17        Entregador1(ENTREGADOR)
        '18        CUIT()
        '19        Exportador1(DESTINATARIO)(COMPRADOR)
        '20        CUIT()
        '21        transportista()
        '22        CUIT(transportista(TRANSPORTISTA))
        '23        Chofer()
        '24        CUIT(chofer(CHOFER))
        '25        Producto(PRODUCTO)
        '26 Numero de CartaPorte (CARTA DE PORTE)





        '27        Procedencia.Bruto()
        dr(27) = "BRUTO PROC"
        '28        Procedencia.Tara()
        dr(28) = "TARA PROC"
        '29 Procedencia.Neto (KG PROCED)
        dr(29) = "NETO PROC"
        '30        Procedencia.Ciudad(PROCEDENCIA)
        dr(30) = "PROCEDENCIA"
        '31 Transporte ( A= SI ES CAMION    F= SI ES VAGON)
        'dr(31) = "PROCEDENCIA"
        '32        DominioChasis(PATENTE)
        dr(32) = "PATENTE"
        '33        DominioAcoplado(PAT.ACOPLADO)
        dr(33) = "ACOPLADO"
        '34        Contrato(CONTRATO)
        dr(34) = "CONTRATO"
        '35        SalidaBruto()
        dr(35) = "BRUTO PTO"
        '36        SalidaTara()
        dr(36) = "TARA PTO"
        '37 KilosMerma  (OTRAS MERMAS)
        dr(37) = "MERMA"
        '38 SalidaNeto 
        dr(38) = "NETO PTO"
        '39 SalidaFecha (DIA DESCARGA)
        dr(39) = "F. DE DESCARGA"
        '40        SalidaHora(HORA)
        'dr(40) = "HORA"
        '41 atributo de Porteria: “CON CUPO” o “SIN CUPO” o “LE DIERON CUPO”
        'dr(41) = "PROCEDENCIA"
        '42 atributo de Calada:  "DEMORADO" "ANALIZADO" "CONDICIONAL" "CONFORME"  "RECHAZADO"  "AUTORIZADO" camión ya autorizado por el entregador
        dr(42) = "CALIDAD"
        '43 Observaciones: comentarios varios, resultado de análisis de calidad, mermas, focos, etc. 
        dr(43) = "OBSERVACIONES"


        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {";"}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        If i = 43 Then
                            currentRow(i) = currentRow(i).Substring(0, IIf(currentRow(i).Length > 50, 50, currentRow(i).Length))
                        End If

                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler2.WriteError("Line " & ex.ToString & " is invalid.  Skipping")
                End Try
            End While
        End Using


        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds


        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


    End Function


    'grabarrenglontipado


    Public Shared Function GrabaRenglonEnTablaCDP(ByRef dr As DataRow, SC As String, Session As System.Web.SessionState.HttpSessionState,
                                    txtDestinatario As System.Web.UI.WebControls.TextBox, txtDestino As System.Web.UI.WebControls.TextBox,
                                    chkAyer As System.Web.UI.WebControls.CheckBox, txtLogErrores As System.Web.UI.WebControls.TextBox, cmbPuntoVenta As System.Web.UI.WebControls.DropDownList,
                                    txtFechaArribo As System.Web.UI.WebControls.TextBox, cmbFormato As System.Web.UI.WebControls.DropDownList,
                                    NoValidarColumnas As List(Of String)
        ) As String 'devuelve la columna del error si es que hubo
        'Dim dt = ViewstateToDatatable()

        'Dim dr = dt.Rows(row)

        Dim myCartaDePorte As New Pronto.ERP.BO.CartaDePorte


        If NoValidarColumnas Is Nothing Then NoValidarColumnas = New List(Of String)



        'If existeLaCarta Then
        Dim numeroCarta As Long = Val(Replace(dr.Item("NumeroCDP"), "-", ""))
        Dim vagon As Long = 0 'por ahora, las cdp importadas tendran subnumero 0
        Dim subfijo As Long = 0 'por ahora, las cdp importadas tendran subnumero 0


        Dim subnumerodefac As Long = Val(iisNull(dr.Item("SUBNUMERODEFACTURACION"), -1))
        If subnumerodefac <= 0 Then subnumerodefac = -1


        'Tomar como regla que cuando se haga la pegatina siempre se PEGUE con el prefijo 5 adelante. (ESTO TOMARLO COMO REGLA PARA TODAS LAS PEGATINAS DE TODOS LOS PUERTOS)
        If numeroCarta < 100000000 Then numeroCarta += 500000000


        'ver si vino el id en una columna
        Dim ssss = 0
        Try
            ssss = Val(dr.Item("Auxiliar4").ToString.Substring(6, 11))
        Catch ex As Exception
            ssss = 0
        End Try

        If ssss > 0 Then
            myCartaDePorte = CartaDePorteManager.GetItemPorNumero(SC, ssss, vagon, subnumerodefac)
            If myCartaDePorte.Id = -1 Then
                ErrHandler2.WriteAndRaiseError("La Carta " & numeroCarta & " no existe")
                Return 0
            End If
            myCartaDePorte.NumeroCartaDePorte = numeroCarta
        Else
            myCartaDePorte = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, subnumerodefac)
        End If







        'y si tiene duplicados, como sabes?


        'End If

        With myCartaDePorte

            If .IdFacturaImputada > 0 Then
                'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada, porque ya existe como facturada o rechazada")
                ErrHandler2.WriteAndRaiseError("La Carta " & numeroCarta & " no puede ser importada porque ya existe como facturada")
                Return 0
            End If


            If .NetoFinalDespuesDeRestadasMermas > 0 Or .NetoFinalAntesDeRestarMermas > 0 Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9095
                'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada, porque ya existe como facturada o rechazada")
                ErrHandler2.WriteAndRaiseError("La Carta " & numeroCarta & " " & IIf(vagon = 0, "", vagon) & " está en estado <descarga> y no se le pueden pisar datos. ")
                Return 0
            End If


            If .Anulada = "SI" Then
                ErrHandler2.WriteError("La Carta " & numeroCarta & " estaba anulada. Se reestablece")
                Dim Usuario As String = ""
                If Session IsNot Nothing Then Usuario = Session(SESSIONPRONTO_UserName)

                LogPronto(SC, .Id, "IMPANU", Usuario)

                CartaDePorteManager.CopiarEnHistorico(SC, .Id)    'hacer historico siempre en las modificaciones de cartas y clientes?

                .Anulada = "NO"
                .FechaAnulacion = Nothing
            End If




            If .Id > 0 And .SubnumeroDeFacturacion > -1 Then

                Dim q As IQueryable(Of CartasDePorte) = CartaDePorteManager.FamiliaDeDuplicadosDeCartasPorte(SC, myCartaDePorte)

                If q.Count > 1 Then
                    'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada porque está duplicada para facturarsele a varios clientes")
                    ErrHandler2.WriteAndRaiseError("La Carta " & numeroCarta & " no puede ser importada porque está duplicada para facturarsele a varios clientes")
                    Return 0
                End If

            ElseIf .Id <= 0 Then
                .SubnumeroDeFacturacion = -1
            End If

















            'Pinta que no hay otra manera de actualizar un dataset suelto http://forums.asp.net/p/755961/1012665.aspx
            .NumeroCartaDePorte = numeroCarta
            .SubnumeroVagon = vagon
            .SubnumeroDeFacturacion = subnumerodefac

            If .NumeroCartaDePorte <= 0 Then
                'Debug.Print(r.Item("Carta Porte"))
                'renglonControl(r, "Carta Porte").BackColor = System.Drawing.Color.Red
                'Stop
                Return 0
            End If



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

            dr.Item("Titular") = iisNull(dr.Item("Titular"))
            If dr.Item("Titular") <> "NO_VALIDAR" And Not NoValidarColumnas.Contains("Titular") Then
                .Titular = BuscaIdClientePrecisoConCUIT(dr.Item("Titular"), SC)
                If .Titular = -1 Then .Titular = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Titular")), SC)
                dr.Item("IdTitular") = .Titular
                If .Titular = -1 Then Return "Titular"
            End If


            dr.Item("Intermediario") = iisNull(dr.Item("Intermediario"))
            If dr.Item("Intermediario") <> "NO_VALIDAR" And Trim(dr.Item("Intermediario")) <> "" Then
                .CuentaOrden1 = BuscaIdClientePrecisoConCUIT(dr.Item("Intermediario"), SC)
                If .CuentaOrden1 = -1 Then .CuentaOrden1 = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Intermediario")), SC)
                dr.Item("IdIntermediario") = .CuentaOrden1
                If .CuentaOrden1 = -1 Then Return "Intermediario"
            End If


            dr.Item("RComercial") = iisNull(dr.Item("RComercial"))
            If dr.Item("RComercial") <> "NO_VALIDAR" And Trim(dr.Item("RComercial")) <> "" Then
                .CuentaOrden2 = BuscaIdClientePrecisoConCUIT(dr.Item("RComercial"), SC)
                If .CuentaOrden2 = -1 Then .CuentaOrden2 = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("RComercial")), SC)
                dr.Item("IdRComercial") = .CuentaOrden2
                If .CuentaOrden2 = -1 Then Return "RComercial"
            End If



            dr.Item("Corredor") = iisNull(dr.Item("Corredor"))
            If dr.Item("Corredor") <> "NO_VALIDAR" Then
                .Corredor = BuscaIdVendedorPrecisoConCUIT(dr.Item("Corredor"), SC)
                If .Corredor = -1 Then .Corredor = BuscaIdVendedorPrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Corredor")), SC)
                dr.Item("IdCorredor") = .Corredor
                If .Corredor = -1 Then Return "Corredor"
            End If





            dr.Item("Comprador") = iisNull(dr.Item("Comprador"))
            If dr.Item("Comprador") <> "NO_VALIDAR" Then
                .Entregador = BuscaIdClientePrecisoConCUIT(dr.Item("Comprador"), SC)
                If .Entregador = -1 Then .Entregador = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Comprador")), SC)
                dr.Item("IdDestinatario") = .Entregador
                If .Entregador = -1 Then
                    'solo uso el default si está vacío el texto
                    If dr.Item("Comprador") = "" Then .Entregador = BuscaIdClientePrecisoConCUIT(txtDestinatario.Text, SC)

                    'si sigue con problemas, pido la equivalencia al usuario
                    If .Entregador = -1 Then Return "Comprador"
                End If
            End If


            '/////////////////////////////////////////
            '/////////////////////////////////////////
            '/////////////////////////////////////////

            'verificar si la razon social no es ASOCIACION DE COOPERATIVAS ARGENTINAS COOPERATIVA LIMITADA
            'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=14744
            'Creo que tienen razón, según la consulta 13220
            ' Pegatina: las cartas de porte de ACA y LDC que ingresen por pegatina, ponerles siempre acopio "Otros"

            Dim idaca = 10
            Dim idldc = 2775


            Try

                If (.Titular > 0 AndAlso (.Titular = idaca Or .Titular = idldc Or InStr(EntidadManager.NombreCliente(SC, .Titular).ToUpper, "A.C.A") > 0)) _
                    Or
                    (.CuentaOrden1 > 0 AndAlso (.CuentaOrden1 = idaca Or .CuentaOrden1 = idldc Or InStr(If(EntidadManager.NombreCliente(SC, .CuentaOrden1), "").ToUpper, "A.C.A") > 0)) _
                    Or
                    (.CuentaOrden2 > 0 AndAlso (.CuentaOrden2 = idaca Or .CuentaOrden2 = idldc Or InStr(If(EntidadManager.NombreCliente(SC, .CuentaOrden2), "").ToUpper, "A.C.A") > 0)) Then
                    Dim excep = CartaDePorteManager.excepcionesAcopios(SC)

                    'Const otros = Array.FindIndex(excep, AddressOf EsOTROS)
                    Dim otros As Long
                    For n = 0 To excep.Count - 1
                        If excep(n).desc = "OTROS" Then
                            otros = n
                            Exit For
                        End If
                    Next


                    .EnumSyngentaDivision = excep(otros).desc
                    .Acopio1 = excep(otros).idacopio
                    .Acopio2 = excep(otros).idacopio
                    .Acopio3 = excep(otros).idacopio
                    .Acopio4 = excep(otros).idacopio
                    .Acopio5 = excep(otros).idacopio
                    .Acopio6 = excep(otros).idacopio


                End If
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                ErrHandler2.WriteError("Falta el titular, o cuentaorden1 o cuentaorden2")
            End Try


            '/////////////////////////////////////////
            '/////////////////////////////////////////
            '/////////////////////////////////////////
            '/////////////////////////////////////////



            dr.Item("Procedencia") = iisNull(dr.Item("Procedencia"))
            If dr.Item("Procedencia") <> "NO_VALIDAR" And Not NoValidarColumnas.Contains("Procedencia") Then
                .Procedencia = BuscaIdLocalidadPreciso(RTrim(dr.Item("Procedencia")), SC)
                If .Procedencia = -1 Then .Procedencia = BuscaIdLocalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Procedencia")), SC)
                'dt.Rows(row).Item("IdProcedencia") = .Procedencia
                If .Procedencia = -1 Then Return "Procedencia"
            End If








            dr.Item("Destino") = iisNull(dr.Item("Destino"))
            If dr.Item("Destino") <> "NO_VALIDAR" And Not NoValidarColumnas.Contains("Destino") Then


                .Destino = BuscaIdWilliamsDestinoPreciso(RTrim(dr.Item("Destino")), SC)
                If .Destino = -1 Then .Destino = BuscaIdWilliamsDestinoPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Destino")), SC)
                'dt.Rows(row).Item("IdDestino") = .Destino



                'ver si vino la localidaddestino (por el flexicapture) en una columna
                Dim localidaddestino As String = dr.Item("Auxiliar3").ToString
                Dim destinocuit As String = dr.Item("Auxiliar2").ToString
                If localidaddestino <> "" And destinocuit <> "" Then

                    Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


                    'Dim destinocuit = (From dest In db.WilliamsDestinos _
                    '        Where dest.IdWilliamsDestino = .Destino).FirstOrDefault().CUIT

                    .Destino = CartaDePorteManager.BuscarDestinoPorCUIT(destinocuit, SC, dr.Item("Destino"), localidaddestino)
                End If



                If .Destino = -1 And dr.Item("Destino") = "" Then
                    'solo uso el default si está vacío el texto
                    .Destino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, SC)
                End If
                If .Destino = -1 Then
                    Return "Destino"
                Else
                    AsignarContratistasSegunDestino(dr, SC)
                End If
            End If






            '/////////////////////////////////////////



            dr.Item("Subcontratista1") = iisNull(dr.Item("Subcontratista1"))
            If dr.Item("Subcontratista1") <> "NO_VALIDAR" And dr.Item("Subcontratista1") <> "" Then
                .Subcontr1 = BuscaIdClientePrecisoConCUIT(dr.Item("Subcontratista1"), SC)
                If .Subcontr1 = -1 Then .Subcontr1 = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Subcontratista1")), SC)
                If .Subcontr1 = -1 Then Return "Subcontratista1"
            End If


            dr.Item("Subcontratista2") = iisNull(dr.Item("Subcontratista2"))
            If dr.Item("Subcontratista2") <> "NO_VALIDAR" And dr.Item("Subcontratista2") <> "" Then
                .Subcontr2 = BuscaIdClientePrecisoConCUIT(dr.Item("Subcontratista2"), SC)
                If .Subcontr2 = -1 Then .Subcontr2 = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Subcontratista2")), SC)
                If .Subcontr2 = -1 Then Return "Subcontratista2"
            End If

            CartaDePorteManager.ReasignoTarifaSubcontratistas(SC, myCartaDePorte)

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

            dr.Item("Calidad") = iisNull(dr.Item("Calidad"))
            If dr.Item("Calidad") <> "NO_VALIDAR" And dr.Item("Calidad") <> "" And Not NoValidarColumnas.Contains("Calidad") Then
                .CalidadDe = BuscaIdCalidadPreciso(RTrim(iisNull(dr.Item("Calidad"))), SC)
                If .CalidadDe = -1 Then .CalidadDe = BuscaIdCalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Calidad")), SC)
                If .CalidadDe = -1 Then Return "Calidad"
            End If




            .ClienteAcondicionador = Nothing

            .Patente = iisNull(dr.Item("Patente"))
            .Acoplado = iisNull(dr.Item("Acoplado"))


            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            'Persistencia de las pesadas
            '//////////////////////////////////////////////////////////////////////////////

            ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9095

            actualizar(.NetoPto, dr.Item("NetoProc"))

            actualizar(.TaraPto, dr.Item("TaraProc"))
            actualizar(.BrutoPto, dr.Item("BrutoProc"))



            '.NetoPto = IIf( StringToDecimal(iisNull(dr.Item("NetoProc"))) 

            actualizar(.BrutoFinal, dr.Item("column12"))
            actualizar(.TaraFinal, dr.Item("column13"))
            actualizar(.NetoFinalAntesDeRestarMermas, dr.Item("column14"))




            If StringToDecimal(iisNull(dr.Item("column15"))) > 0 Then
                actualizar(.Humedad, dr.Item("column15"))
            End If

            If StringToDecimal(iisNull(dr.Item("column16"))) > 0 Then
                actualizar(.HumedadDesnormalizada, dr.Item("column16"))
            End If

            If .HumedadDesnormalizada = 0 And .Humedad <> 0 And .IdArticulo > 0 Then
                Dim porcentajemerma = CartaDePorteManager.BuscaMermaSegunHumedadArticulo(SC, .IdArticulo, .Humedad)
                .HumedadDesnormalizada = porcentajemerma / 100 * .NetoFinalAntesDeRestarMermas
            End If




            '.Merma = 0 'la piso, por si ya se importó antes

            If Val(dr.Item("Auxiliar5").ToString) > 0 Then
                If .Merma = 0 Then
                    .Merma = Val(dr.Item("Auxiliar5").ToString)
                End If
            End If



            actualizar(.NetoFinalDespuesDeRestadasMermas, dr.Item("column17"))
            If .NetoFinalDespuesDeRestadasMermas = 0 Then
                'recalcular()
                .NetoFinalDespuesDeRestadasMermas = .NetoFinalAntesDeRestarMermas - .HumedadDesnormalizada
            Else
                'que pasa si lo que viene en el excel es distinto de lo calculado?
            End If


            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////

            If Val(iisNull(dr.Item("column20"))) > 0 Then .CEE = Val(iisNull(dr.Item("column20")))

            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////


            actualizar(.FechaDeCarga, dr.Item("column18"))
            actualizar(.FechaVencimiento, (dr.Item("column19")))









            'PEGATINA PLAYA PEREZ: (POSICION)
            '•	Cuando hacemos la pegatina de Playa Perez , Posición pega los KILOS de procedencia en 
            '           la solapa de descarga, lo tiene que pegar en la primer solapa en KILOS NETOS de procedencia.
            '•	Pega la fecha de descarga y no LA TIENE QUE PEGAR (segunda solapa), porque cuando se genera la posición si esta esa fecha puesta no sale.

            ' no actualizar fechadescarga si es posicion
            'con el chkAyer tambien debo modificar la fecha de arribo???
            Try

                actualizar(.FechaDescarga,
                           iisValidSqlDate(TextoAFecha(
                                                    iisNull(dr.Item("FechaDescarga"),
                                                        IIf(.NetoFinalAntesDeRestarMermas > 0,
                                                            IIf(chkAyer.Checked,
                                                                DateAdd(DateInterval.Day, -1, Today),
                                                                Today) _
                                                            , Nothing)))))  'si la fechadescarga está en null, me fijo si hay NetoFinalAntesDeRestarMermas

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try






            'If iisNull(.FechaArribo, #12:00:00 AM#) = #12:00:00 AM# Then
            Try
                actualizar(.FechaArribo, IIf(chkAyer.Checked, DateAdd(DateInterval.Day, -1, Today), txtFechaArribo.Text))

            Catch ex As Exception
                ErrHandler2.WriteError(ex)

            End Try
            'End If
            '.Merma = StringToDecimal(dr.Item("column16")) 'este es el otras mermas


            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////



            actualizar(.Observaciones, dr.Item("column25"))

            If .NetoFinalDespuesDeRestadasMermas <> .NetoFinalAntesDeRestarMermas - .HumedadDesnormalizada And iisNull(dr.Item("column17"), 0) <> 0 Then
                .Observaciones &= " (AVISO: renglon importado con incoherencias entre la merma y los netos -->  Neto importado: " & .NetoFinalDespuesDeRestadasMermas & "     Neto calculado:" & .NetoFinalAntesDeRestarMermas - .HumedadDesnormalizada & " =" & .NetoFinalAntesDeRestarMermas & "-" & .HumedadDesnormalizada & "   )"
            End If


            If Val(iisNull(dr.Item("CTG")).Replace(".", "")) > 0 Then .CTG = Val(iisNull(dr.Item("CTG")).Replace(".", ""))

            actualizar(.TarifaTransportista, dr.Item("TarifaTransportista"))
            actualizar(.KmARecorrer, dr.Item("KmARecorrer"))



            .PuntoVenta = cmbPuntoVenta.SelectedValue ' Val(iisNull(EmpleadoManager.GetItem(SC, session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado, 1))

            actualizar(.Cosecha, (Year(.FechaArribo) - 1) & "/" & Right(Year(.FechaArribo), 2))



            .Exporta = (dr.Item("Exporta").ToString() = "SI")



            'sector del confeccionó



            Dim ms As String
            If CartaDePorteManager.IsValid(SC, myCartaDePorte, ms) Then
                '                Try


                Try
                    'EntidadManager.LogPronto(HFSC.Value, id, "CartaPorte Anulacion de posiciones ", Session(SESSIONPRONTO_UserName))

                    'loguear el formato usado   y el nombre del archivo importado
                    Dim nombre = Session("NombreArchivoSubido")
                    Dim formato = FormatoDelArchivo(nombre, cmbFormato)
                    Dim s = " F:" + formato.ToString + " " + nombre


                    EntidadManager.Tarea(SC, "Log_InsertarRegistro", "IMPORT",
                                              .Id, 0, Now, 0, "Tabla : CartaPorte", "", Session(SESSIONPRONTO_UserName),
                                             s, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value,
                                            DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value,
                                            DBNull.Value, DBNull.Value, DBNull.Value)



                    'GetStoreProcedure(SC, enumSPs.Log_InsertarRegistro, IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
                    '                          CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario)

                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                If CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName)) = -1 Then
                    Debug.Print("No se pudo grabar el renglon n° " & myCartaDePorte.NumeroCartaDePorte)
                    ErrHandler2.WriteError("Error al grabar CDP importada")
                Else
                    'poner url hacia el ABM
                    'Response.Redirect(String.Format("CartaDePorte.aspx?Id={0}", IdCartaDePorte.ToString))

                    'Dim hl As WebControls.HyperLink = CType(r.Cells(getGridIDcolbyHeader("Ir a", gvExcel)).Controls(1), WebControls.HyperLink)
                    'hl.NavigateUrl = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)
                    dr.Item("URLgenerada") = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)

                End If

            Else
                Dim sError = "Error al validar CDP importada: " & myCartaDePorte.NumeroCartaDePorte & " " & ms
                ErrHandler2.WriteError(sError)
                txtLogErrores.Visible = True
                If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
                txtLogErrores.Text &= sError & vbCrLf
            End If

        End With

        txtLogErrores.Visible = True

        Return 0
    End Function


    Private Shared Function EsOTROS(ByVal s As String) _
        As Boolean

        ' AndAlso prevents evaluation of the second Boolean 
        ' expression if the string is so short that an error 
        ' would occur. 
        If (s = "OTROS") Then
            Return True
        Else
            Return False
        End If
    End Function

    '////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////

    Shared Sub actualizar(ByRef Destino As Date, ByVal OrigenDataRowItem As Object)

        'todas estas volteretas para no pisar si ya hay dato 

        'If Destino = 0 Then

        Dim temp As Object = iisValidSqlDate(TextoAFecha(iisNull(OrigenDataRowItem)))
        If Not temp Is Nothing Then
            Destino = temp
        End If


        'End If

    End Sub




    Shared Sub actualizar(ByRef Destino As Double, ByVal OrigenDataRowItem As Object)

        'todas estas volteretas para no pisar si ya hay dato 

        'If Destino = 0 Then

        Dim temp As Double = StringToDecimal(iisNull(OrigenDataRowItem))
        If temp <> 0 Then
            Destino = temp
        End If


        'End If

    End Sub



    Shared Sub actualizar(ByRef Destino As String, ByVal OrigenDataRowItem As Object)

        'todas estas volteretas para no pisar si ya hay dato 

        'If Destino = 0 Then

        Dim temp As String = iisNull(OrigenDataRowItem)
        If temp <> "" Then
            Destino = temp
        End If


        'End If

    End Sub

    '////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////

    Shared Sub AsignarContratistasSegunDestino(ByVal dr As DataRow, SC As String)
        With dr
            Dim iddest = BuscaIdWilliamsDestinoPreciso(.Item("Destino"), SC)

            If iddest <> -1 Then
                If iisNull(.Item("Subcontratista1"), "") = "" Then
                    Dim idcli1 = EntidadManager.ExecDinamico(SC, "select * from WilliamsDestinos where IdWilliamsDestino=" & iddest).Rows(0).Item("Subcontratista1")
                    If IsNumeric(idcli1) Then
                        .Item("Subcontratista1") = EntidadManager.GetItem(SC, "Clientes", idcli1).Item("RazonSocial")
                    End If
                End If


                If iisNull(.Item("Subcontratista2"), "") = "" Then
                    Dim idcli2 = EntidadManager.ExecDinamico(SC, "select * from WilliamsDestinos where IdWilliamsDestino=" & iddest).Rows(0).Item("Subcontratista2")
                    If IsNumeric(idcli2) Then
                        .Item("Subcontratista2") = EntidadManager.GetItem(SC, "Clientes", idcli2).Item("RazonSocial")
                    End If
                End If

            End If
        End With
    End Sub




    Public Shared Function FormatoDelArchivo(ByVal sNombreArchivoImportado As String,
                                             cmbFormato As System.Web.UI.WebControls.DropDownList) As FormatosDeExcel
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

        'if (cmbFormato Is Nothing) Then FormatosDeExcel.Autodetectar()

        If cmbFormato.SelectedIndex <> FormatosDeExcel.Autodetectar Then
            Return [Enum].Parse(GetType(FormatosDeExcel), cmbFormato.SelectedItem.Value.ToString)
        End If





        If InStr(sNombreArchivoImportado.ToString.ToUpper, ".TXT") > 0 Then
            If InStr(sNombreArchivoImportado.ToString.ToUpper, "DESCAR") = 0 Then
                cmbFormato.SelectedIndex = FormatosDeExcel.PuertoACA
            Else
                cmbFormato.SelectedIndex = FormatosDeExcel.Reyser
            End If
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, ".RTF") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.Nidera
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "BUNGE") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.BungeRamallo
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "PAMPA") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.MuellePampa
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "TIMBUES") > 0 Or InStr(sNombreArchivoImportado.ToString.ToUpper, "LDC") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.LDCPlantaTimbues
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "VICENT") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.VICENTIN
        End If


        Return cmbFormato.SelectedIndex


        'http://stackoverflow.com/questions/1061228/c-sharp-explicit-cast-string-to-enum
        'http://stackoverflow.com/questions/424366/c-sharp-string-enums
        'return (T)Enum.Parse(typeof(T), str)

        'If cmbFormato.SelectedValue = "PuertoACA" Then 'formato CSV
        '    Return PuertoACA
        'ElseIf cmbFormato.SelectedValue = "AdmServPortuarios" Then

        '    Return -1

        'ElseIf cmbFormato.SelectedValue = "Toepfer Transito" Or InStr(nombre.ToUpper, "TRANSITO") Then

        '    ds = GetExcel(DIRFTP + nombre, 3) 'hoja 3

        'ElseIf InStr(nombre.ToUpper, "TOEPFER") Then

        '    ds = GetExcel(DIRFTP + nombre, 1)

        'ElseIf cmbFormato.SelectedValue = "Cargill" Or InStr(nombre.ToUpper, "CARGILL") Then

        '    ds = GetExcel(DIRFTP + nombre, 1) 'hoja 1

        'Else

        '    ds = GetExcel(DIRFTP + nombre)

        'End If
    End Function



    Public Shared Function TraerExcelDeBase(SC As String, ByRef m_IdMaestro As Integer) As Data.DataTable


        'Dim dtBase = ExcelImportadorManager.TraerMetadata(SC)
        Dim dtBase As Data.DataTable

        Try
            dtBase = ExcelImportadorManager.TraerMetadataPorIdMaestro(SC, m_IdMaestro)
        Catch ex As Exception
            ErrHandler2.WriteError("Problemas con IdMaestro? Quizas no pude importar filas. " & ex.ToString)
            'esta explotando porque no encuentra el idmaestro? por qué?
            '-en el unico lugar donde se asigna el IdMaestro es al final de FormatearExcel. Quizas 
            'no llega a ejecutarse porque no se pudieron importar filas
        End Try




        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        'OPTIMIZAR
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        'METODO 1: formateo dtExcel y le copio dtBase

        'Dim dtExcel = TablaFormato()

        'For Each drBase As DataRow In dtBase.Rows

        '    Dim drExcel = dtExcel.NewRow()

        '    For c As Integer = 0 To dtExcel.Columns.Count - 1
        '        Try
        '            drExcel(c) = drBase("Excel" & (c + 1))
        '        Catch ex As Exception
        '        End Try
        '    Next


        '    drExcel("IdExcelImportador") = drBase("IdExcelImportador")

        '    dtExcel.Rows.Add(drExcel)
        'Next


        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        'Metodo 2: modifico directamente dtBase, para que no tarde tanto
        Dim dtExcel = dtBase

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////




        'Pongo los nombres de columna que figuran serializados en Observaciones

        'Dim nombres = Split(dtBase.Rows(0).Item("Observaciones"), "|")
        ''For c As Integer = 0 To dtExcel.Columns.Count - 1
        ''    dtExcel.Columns(c).ColumnName = "col" & c
        ''Next

        'For c As Integer = 0 To nombres.Length - 2
        '    Try
        '        dtExcel.Columns("Excel" & (c + 1)).ColumnName = nombres(c)
        '    Catch ex As Exception

        '    End Try
        'Next

        'For c As Integer = 0 To 50 ' (dtExcel.Columns.Count - 1)
        '    If Left(dtExcel.Columns(c).ColumnName, 5) = "Excel" Then dtExcel.Columns.RemoveAt(c)
        'Next



        Return dtExcel
    End Function

End Class



Public Class ExcelImportadorManager

    Const Tabla = "ExcelImportador"
    Const IdTabla = "IdExcelImportador"

    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx










    Private Shared Function HermanarLeyendaConColumna_aCadena(ByVal s As String, Optional ByVal sNombreArchivoImportado As String = "", Optional ByVal LetraColumna As Integer = -1, Optional ByVal formato As LogicaImportador.FormatosDeExcel = Nothing) As String
        s = Trim(s)

        Dim excep = ExcepcionHermanado(s, sNombreArchivoImportado, LetraColumna, formato)
        If excep <> enumColumnasDeGrillaFinal._Desconocido Then
            Return excep.ToString
        End If

        Select Case s
            Case "PRODUCTO", "PROD.", "MERC.", "MER", "GRANO", "MERCADERIA", "PROD", "GRANOESPECIE"
                Return "Producto"

            Case "VENDEDOR", "CARGADOR", "TITULAR DE CARTA DE PORTE", "TITULAR CP", "TITULAR", "TITULAR_CP"
                Return "Titular" 'fijate que si está "remitente" solito, se usa Titular -Quién lo usa así?????

            Case "CUENTA ORDEN 1", "1º CTA./ORDEN", "1º CTA./ORD.", "CY O 1", "C Y O 1", "CYO 1", "C/ORDEN 1", "C/O 1", "INTERMEDIARIO"
                Return "Intermediario"

            Case "CUENTA ORDEN 2", "2º CTA./ORDEN", "2º CTA./ORD.", "CY O 2", "C Y O 2", "CYO 2", "C/ORDEN 2", "C/O 2", "REMITENTE COMERCIAL", "REMIT COMERC", "RTE. COMERCIAL", "RTE.COMERCIAL", "R.COMERCIAL", "REMIT COMERCIAL", "RTE_COMERCIAL", "REMITENTE"
                'fijate que si está "remitente" solito, se usa Titular -Quién lo usa así?????
                Return "RComercial"


            Case "CORREDOR"
                Return "Corredor"

            Case "ENTREGADOR", "REPRESENTANTE", "ENTREG"
                Return "EntregadorFiltrarPorWilliams" 'el entregador es el mismísimo Williams

            Case "DESTINATARIO", "EXPORTADOR", "EXPORT.", "COMPRADOR", "EXP", "EXP.", "DEST."
                Return "Comprador"





            Case "CARTA PORTE", "C/PORTE", "C. PORTE", "C.PORTE", "C. P.", "CP.", "CCPP", "CC PP", "CARTA DE PORTE", "CP", "C PORTE", "NROCP", "BARRACP"



                Return "NumeroCDP"


                '///////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////
                'columnas del excel del Flexicapture
            Case "COLUMNAADICIONAL"
                Return "Auxiliar4"
            Case "LOCALIDAD2"
                Return "Auxiliar3"
            Case "DESTINOCUIT"
                Return "Auxiliar2"
                '///////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////




            Case "PROCEDENCIA", "PROCED", "PROCENDECIA", "PROCED.", "LOCALIDAD", "PROC", "PROC.", "LOCALIDAD_ORIGEN", "LOCALIDAD1"


                Return "Procedencia"


            Case "DESTINO", "DETINO"
                Return "Destino"

            Case "SUBCONTRATISTAS"

                Return "Subcontratistas"

            Case "CALIDAD", "CALID."
                Return "Calidad"





            Case "CONTRATO"
                'no lo estas importando.....


            Case "TURNO"
                'return  
            Case "PATENTE", "PAT CHASIS", "PTE.", "PATE", "CHASIS", "CAMIÓN"

                Return "Patente"
            Case "ACOPLADO", "ACOPL", "PAT.ACOP."

                Return "Acoplado"


                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '   Pesajes en la procedencia/origen (ficha de posicion)
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////

            Case "NETO PROC", "KG", "KG. PROC.", "KG,PROC", "KG P",
                    "KGS", "KGS ORIGEN", "NETO_PROC", "PESONETO"                '"KGS." qué va a ser? Neto proc o Neto Pto???

                'conflicto "PROC": lo usa "Las Palmas" para "Procedencia"
                Return "NetoProc"


            Case "PESOBRUTO", "BRUTO PROC"
                Return "BrutoProc"

            Case "PESOTARA", "TARA PROC"
                Return "TaraProc"

                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '   Pesajes en el destino/puerto (se ven en la ficha de descarga)
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////

            Case "BRUTO PTO", "BRUTO", "BRUTO BUNGE", "BRUTO_DEST", "PESOBRUTODESCARGA"

                Return "column12"
            Case "TARA PTO", "TARA", "TARA BUNGE", "TARA_DEST", "PESOTARADESCARGA"
                Return "column13"
            Case "NETO PTO", "NETO", "KG. DESC.", "KGS.", "KG.DESC", "DESC.", "NETO BUNGE", "DESC", "NETO_DEST", "PESONETODESCARGA"

                Return "column14"

                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                'mermas y neto total final
                '/////////////////////////////////////////////////////////////////////////

            Case "HUMEDAD", "GDO/HUM", "HUM" ',  porcentaje de humedad
                Return "column15"
            Case "MERMA", "MERMA Y/O REBAJAS", "MMA/H", "MMA", "MERMA_KG" 'merma por humedad
                Return "column16"

            Case "OTRASMERMAS"
                Return "Auxiliar5" '"OtrasMermas"

            Case "NETO FINAL", "FINAL", "PESONETOFINAL" '  "NETO_DEST" <- este ya lo estoy usando en descarga

                Return "column17"


                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////

            Case "F. DE DESCARGA", "FECHA"
                Return "FechaDescarga"

            Case "F. DE CARGA", "FEC.CARGA", "FECHA_CARGA", "FECHACARGA"
                Return "column18"

            Case "FECHA VTO.", "FEC.VTO.", "FECHA_VENCIMIENTO", "FECHAVENCIMIENTO"
                Return "column19"






            Case "C.E.E", "C.E.E NRO", "NRO.CEE", "NRO. CEE", "CEE"
                Return "column20"
            Case "TRANSPORTISTA", "TRANSP.", "TRANSPORTE"
                Return "column21"
            Case "CUIT TRANS"
                Return "column22"
            Case "CHOFER", "NOMBRE CHOFER"
                Return "column23"
            Case "CUIT CHOFER"
                Return "column24"
            Case "OBSERVACIONES.", "OBSERVACIONES", "OBSERVACION", "OBSERV.", "MER/REB", "ANÁLISIS"
                Return "column25"



            Case "NRO. CTG", "CTG"
                Return "CTG"
            Case "KM", "KMARECORRER"
                Return "KmARecorrer"
            Case "TAR.FLETE", "TARIFA"
                Return "TarifaTransportista"

            Case "EXPORTA"
                Return "Exporta"
            Case "SUBNUMERODEFACTURACION"
                Return "SubnumeroDeFacturacion"

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




    Public Enum enumColumnasDeGrillaFinal As Integer
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


        Auxiliar4
        Auxiliar3
        Auxiliar2


        BrutoProc
        TaraProc
        Auxiliar6
        Auxiliar7
        Auxiliar8
        Auxiliar9
        Auxiliar1

        ' -tengo q agregar estos renglones en un orden especial???

        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"
        'Tenés que agregar el campo en la tabla "ExcelImportador"


        _Desconocido
    End Enum



    Shared Function HermanarLeyendaConColumna(ByVal s As String, Optional ByVal sNombreArchivoImportado As String = "", Optional ByVal LetraColumna As Integer = -1, Optional ByVal formato As LogicaImportador.FormatosDeExcel = Nothing) As String
        Dim sRet As String = HermanarLeyendaConColumna_aCadena(s, sNombreArchivoImportado, LetraColumna, formato)

        If sRet = "" Then sRet = "_Desconocido" 'trucheo. arreglar

        Dim enumEntidad As enumColumnasDeGrillaFinal = [Enum].Parse(GetType(enumColumnasDeGrillaFinal), sRet)

        Dim reconversion As String = enumEntidad.ToString
        If reconversion = "_Desconocido" Then reconversion = "" 'trucheo. arreglar


        Return reconversion
    End Function





    Shared Function RenglonTitulos(ByRef dtOrigen As Data.DataTable, ByVal nombre As String, ByVal fa As LogicaImportador.FormatosDeExcel) As Integer
        Dim renglonDeTitulos As Integer = -1
        Dim row As DataRow


        'busco el renglon (desde ABAJO para ARRIBA!!) con los titulos para despues hacer el macheo
        For j = dtOrigen.Rows.Count - 1 To 0 Step -1
            row = dtOrigen.Rows(j)
            If row.Item("column1").ToString.ToUpper = "PRODUCTO" _
            Or row.Item("column1").ToString.ToUpper = "ENTREGADOR" _
            Or row.Item("column1").ToString.ToUpper = "EXPORT." _
            Or row.Item("column1").ToString.ToUpper = "PROCENDECIA." _
            Or row.Item("column1").ToString.ToUpper = "MER" _
            Or row.Item("column1").ToString.ToUpper = "MERCADERIA" _
            Or row.Item("column1").ToString.ToUpper = "CARGADOR" _
            Or row.Item("column1").ToString.ToUpper = "F. DE CARGA" _
            Or row.Item("column2").ToString.ToUpper = "VENDEDOR" _
            Or row.Item("column2").ToString.ToUpper = "GRANO" _
            Or row.Item("column2").ToString.ToUpper = "TURNO" Then
                renglonDeTitulos = j
            End If
        Next



        Try
            If renglonDeTitulos = -1 Then
                'probar siendo mas flexible, solo en los primeros 3 renglones
                For j = Min(2, dtOrigen.Rows.Count - 1) To 0 Step -1
                    row = dtOrigen.Rows(j)
                    Dim s = row.Item("column1").ToString.ToUpper
                    If HermanarLeyendaConColumna(s, nombre, , fa) <> "" Then
                        renglonDeTitulos = j
                    End If
                Next


                If renglonDeTitulos = -1 Then
                    'probar en la segunda columna
                    For j = Min(5, dtOrigen.Rows.Count - 1) To 0 Step -1
                        row = dtOrigen.Rows(j)
                        Dim s = row.Item("column2").ToString.ToUpper
                        If HermanarLeyendaConColumna(s, nombre, , fa) <> "" Then
                            renglonDeTitulos = j
                        End If
                    Next
                End If


                'Stop
                If renglonDeTitulos = -1 Then

                    ErrHandler2.WriteError("No se encontró el renglon de titulos. Renglones totales:" & dtOrigen.Rows.Count)


                    If Debugger.IsAttached() Then Stop

                    Return -1 'me rindo
                End If
            End If



        Catch ex As Exception
            ErrHandler2.WriteError("No se encontró el renglon de titulos. Renglones totales:" & dtOrigen.Rows.Count)
            If Debugger.IsAttached() Then Stop

            Return -1 'me rindo
        End Try


        Return renglonDeTitulos
    End Function



    Shared Function ExcepcionHermanado(ByVal s As String, ByVal sNombreArchivoImportado As String, ByVal LetraColumna As Integer, ByVal FormatoDelArchivo As LogicaImportador.FormatosDeExcel) As enumColumnasDeGrillaFinal
        'Consulta 5784
        '        Bunge
        'VENDEDOR es Destinatario (generalmente es Titular)
        'NETO es Neto proc (generalmente es Neto Pto)

        '        Timbues
        'KGS. es Neto Proc (generalmente es Neto Pto)




        'If cmbFormato.SelectedValue = "Toepfer Transito" Then

        s = s.ToUpper.Trim

        Select Case FormatoDelArchivo
            Case BungeRamallo
                'cargador ----> titular
                'vendedor ----> remitcomer
                'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11790
                'CUANDO HAY CARGADOR Y VENDEDOR -> TITULAR, INTERMEDIARIO
                'CUANDO HAY CARGADOR, VENDEDOR Y C/ORDEN -> TITULAR, REMITENTE E INTERMEDIARIO

                'los reacomodo en FormatearColumnasDeCalidadesRamallo()
                If s = "CARGADOR" Then
                    Return enumColumnasDeGrillaFinal.Titular 'en lugar de vendedor/titular
                ElseIf s = "VENDEDOR" Then
                    Return enumColumnasDeGrillaFinal.Intermediario 'en lugar de intermediario
                ElseIf s = "C/ORDEN 1" Then
                    Return enumColumnasDeGrillaFinal.RComercial 'en lugar de intermediario
                ElseIf s = "NETO" Then
                    'en bunge muelle pampa usa "neto" para el netoproc
                    Return enumColumnasDeGrillaFinal.NetoProc
                ElseIf s = "RUBROS" Then
                    Return enumColumnasDeGrillaFinal.column15
                ElseIf LetraColumna = 19 Then '"U" Then
                    'Return enumColumnasDeGrillaFinal.column25
                End If
            Case MuellePampa, Terminal6, NobleLima
                If s = "NETO" Then
                    'en bunge muelle pampa usa "neto" para el netoproc
                    Return enumColumnasDeGrillaFinal.NetoProc
                End If
            Case LDCPlantaTimbues, LDCGralLagos
                If s = "KGS." Then
                    Return enumColumnasDeGrillaFinal.NetoProc
                ElseIf s = "PROC" Then
                    Return enumColumnasDeGrillaFinal.NetoProc
                ElseIf LetraColumna = 13 Then ' "N" Then
                    'columna N en timbues (columna sin titulo) es OBSERVACIONES
                    Return enumColumnasDeGrillaFinal.column25
                End If
            Case VICENTIN

                If s = "DESC" Or s = "KILOS" Then
                    Return enumColumnasDeGrillaFinal.NetoProc
                End If
            Case VICENTIN_ExcepcionTagRemitenteConflictivo

                If s = "REMITENTE" Then
                    Return enumColumnasDeGrillaFinal.Titular
                End If
                If s = "REMITENTE COMERCIAL" Then
                    Return enumColumnasDeGrillaFinal.RComercial
                End If

            Case Renova
                If s = "FECHA" Then
                    Return enumColumnasDeGrillaFinal.column18
                End If
                If s = "NETO" Then
                    Return enumColumnasDeGrillaFinal.NetoProc
                End If
                If s = "ACOPLADO" Then
                    Return enumColumnasDeGrillaFinal.column24 'no te sirve poner _desconocido:  HermanarLeyenda() en ese caso se fija qué pasa. Lo mando entonces a una columna sin consecuencias (CUIT CHOFER)
                End If
                If s = "PATENTE" Then
                    Return enumColumnasDeGrillaFinal.column24
                End If


        End Select





        Return enumColumnasDeGrillaFinal._Desconocido
    End Function



    'conversion extraña de rtf a texto http://stackoverflow.com/questions/595865/get-plain-text-from-an-rtf-text
    Public Shared Function ConvertRtfToText(rtf As String) As String
        Using rtb = New System.Windows.Forms.RichTextBox()
            rtb.Rtf = rtf
            Return rtb.Text
        End Using
    End Function




    Public Shared Function NideraToDataset(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()














        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>

        'Entregador Merc.   Destinatario                     Corredor   Planta     Car.Port Cant.Original   Descr. Cta y Orden 1             Descr. Cta y Orden 2            Descr. Cargador
        'WILLIAMS E  MAIZ    NIDERA SOCIEDAD ANONIMA          BLDSA      ONCATIVO   36364381    29.000,000   MANZOTTI CEREALES S.A                                            CENTRO DE COMERCIALIZACION DE
        'WILLIAMS E  MAIZ    NIDERA SOCIEDAD ANONIMA          BLDSA      ONCATIVO   36364384    31.430,000   MANZOTTI CEREALES S.A                                            CENTRO DE COMERCIALIZACION DE

        'Entregador                     1
        'Merc.                          2   
        'Destinatario                   3    
        'Corredor                       4    
        'Planta                         5
        ' Car.Port                      6
        'Cant.Original                  7
        ' Descr. Cta y Orden 1          8 
        ' Descr. Cta y Orden 2          9 
        '  Descr. Cargador              10


        'dr(43) = "OBSERVACIONES"

        'dr(0) = "Prefijo Cp"
        dr(6) = "CARTA PORTE"
        'dr(2) = "Nro Vagon"
        'dr(3) = "Cuit Entregador"
        'dr(4) = "Razon Social Entregador"
        'dr(5) = "Cuit Corredor"

        dr(1) = "OBSERVACIONES"
        dr(10) = "CARGADOR"
        'dr(6) = "CUIT"
        dr(9) = "INTERMEDIARIO"
        'dr(8) = "CUIT"
        dr(8) = "REMITENTE COMERCIAL"
        'dr(10) = "CUIT"
        dr(4) = "CORREDOR"

        dr(3) = "DESTINATARIO"
        dr(2) = "PRODUCTO"

        dr(5) = "PROCEDENCIA"
        'dr(5) = "PATENTE"
        'dr(33) = "ACOPLADO"
        'dr(1) = "CONTRATO"
        'dr(33) = "OBSERVACIONES"


        'dr(27) = "BRUTO PROC"
        'dr(28) = "TARA PROC"
        dr(7) = "NETO PROC"

        'dr(25) = "Kilos Netos Procedencia"
        'dr(27) = "Patente"
        'dr(28) = "TRANSPORTISTA"
        'dr(29) = "TRANSPCUIT"

        'dr(32) = "F. DE CARGA"
        ''dr(33) = "Observacion"
        'dr(39) = "F. DE DESCARGA"
        ''dr(40) = "Calidad"
        'dr(40) = "CALIDAD"
        ''dr(41) = "Hora Salida"
        'dr(42) = "BRUTO PTO"
        'dr(43) = "TARA PTO"
        ''dr() = "MERMA"
        'dr(37) = "NETO PTO"

        'dr(44) = "RECIBO"


        ''dr(2) = "VAGON"
        'dr(30) = "TURNO"
        ''dr(4) = "CTG"


        dt.Rows.Add(dr)


        Dim rtf As String = FileIO.FileSystem.ReadAllText(pFileName)
        Dim txt As String = ConvertRtfToText(rtf)
        Dim arraytxt As String() = txt.Split(Environment.NewLine.ToCharArray())

        'http://stackoverflow.com/questions/1500194/c-looping-through-lines-of-multiline-string


        'datos en los primeros renglones
        Dim articulo As String
        Try
            articulo = arraytxt(0).Substring(1, 1)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



        'Reader.SetFieldWidths(5, 10, 11, -1)


        'Entregador Merc.   Destinatario                     Corredor   Planta     Car.Port Cant.Original   Descr. Cta y Orden 1             Descr. Cta y Orden 2            Descr. Cargador
        'WILLIAMS E  MAIZ    NIDERA SOCIEDAD ANONIMA          BLDSA      ONCATIVO   36364381    29.000,000   MANZOTTI CEREALES S.A                                            CENTRO DE COMERCIALIZACION DE
        'WILLIAMS E  MAIZ    NIDERA SOCIEDAD ANONIMA          BLDSA      ONCATIVO   36364384    31.430,000   MANZOTTI CEREALES S.A                                            CENTRO DE COMERCIALIZACION DE

        'Entregador 
        'Merc.   
        'Destinatario                     
        'Corredor   
        'Planta    
        ' Car.Port 
        'Cant.Original  
        ' Descr. Cta y Orden 1            
        ' Descr. Cta y Orden 2          
        '  Descr. Cargador



        For n = 12 To arraytxt.Count - 1
            Dim r As String = arraytxt(n)

            dr = dt.NewRow()
            'For i As Integer = 0 To currentRow.Length - 1
            '    dr(i) = currentRow(i)
            'Next

            dr(1) = Trim(Mid(r, 1, 14))
            dr(2) = Trim(Mid(r, 15, 8))
            dr(3) = Trim(Mid(r, 23, 33))
            dr(4) = Trim(Mid(r, 56, 11))
            dr(5) = Trim(Mid(r, 67, 11))
            dr(6) = Trim(Mid(r, 78, 12))

            'Cant.Original  
            dr(7) = Mid(r, 90, 13).Replace(".", "").Replace(",", ".")

            dr(8) = Trim(Mid(r, 103, 33))
            dr(9) = Trim(Mid(r, 136, 32))
            dr(10) = Trim(Mid(r, 168, 29))




            dt.Rows.Add(dr)


        Next





        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////




        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds




    End Function


    Shared Function actua(ByRef d As Object, ByRef o As Object) As Boolean
        Try

            If o Is Nothing Then Return False
            If o.ToString = "" Then Return False
            If o.ToString = If(d, "").ToString Then Return False

            d = o


            Return True
        Catch ex As Exception
            Return False
        End Try

    End Function









    Public Shared Function UrenportExcelToDataset(ByVal pFileName As String, SC As String) As Data.DataSet

        'loguear apertura del excel q puede fallar
        Dim ds As DataSet
        Try
            If pFileName.ToUpper.Contains("URENPORT") Then 'es html

                ds = New DataSet()
                ds.Tables.Add(FuncionesGenericasCSharp.GetExcel5_HTML_AgilityPack(pFileName))
            Else
                ds = GetExcel2_ODBC(pFileName).DataSet                'ds = GetExcel(pFileName, 1)
            End If


        Catch ex As Exception
            ErrHandler2.WriteError("Error al abrir el excel. " + pFileName + "   " + ex.ToString)

            Throw
        End Try

        'y usando getexcel2 habria menos problemas (q no usa interop)?

        'Microsoft does not currently recommend, and does not support, Automation of Microsoft Office applications from any unattended, non-interactive client application or component (including ASP, ASP.NET, DCOM, and NT Services), because Office may exhibit unstable behavior and/or deadlock when Office is run in this environment."


        'FuncionesGenericasCSharp.GetDataTableFromExcel()

        'No puedo hacer un getexcel3 que use el eeplus?



        Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))

        db.Configuration.AutoDetectChangesEnabled = True



        'le hago algun tratamiento a los cuits
        For Each r In ds.Tables(0).Rows

            Try
                'If Val(r(1)) = 0 Then Continue For

                'r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))


                'r(29) = r(29).Replace(".", "").Replace(",", ".")

                'If r(4) = "" Then
                '    r(4) = "DIRECTO"
                'End If



                'r(40) = CodigoCalidad(Val(r(40)))

                'Select Case r(38)
                '    Case "1"
                '        r(38) = "NO"
                '    Case "2"
                '        r(38) = "SI"
                '    Case "3"
                '        r(38) = "NO"
                '    Case Else

                'End Select




                'loguear cual está importando  -cada renglon???? me la pasaria logeando.....

                Dim cpnumero As Long = Val(r(0))

                If cpnumero < 500000000 Then Continue For


                'Dim myCartaDePorte As CartaDePorte = CartaDePorteManager.GetItemPorNumero(SC, cpnumero, 0, 0)

                Dim myCartaDePorte As Models.CartasDePorte =
                                (From c In db.CartasDePortes Where c.NumeroCartaDePorte = cpnumero
                                 Order By c.FechaAnulacion Descending
                                 Select c).FirstOrDefault()



                If myCartaDePorte Is Nothing Then myCartaDePorte = New Models.CartasDePorte()

                If myCartaDePorte.SubnumeroVagon Is Nothing Then myCartaDePorte.SubnumeroVagon = 0
                If myCartaDePorte.SubnumeroDeFacturacion Is Nothing Then myCartaDePorte.SubnumeroDeFacturacion = 0
                If myCartaDePorte.NumeroCartaEnTextoParaBusqueda Is Nothing Then myCartaDePorte.NumeroCartaEnTextoParaBusqueda = cpnumero.ToString

                Dim log = ""



                For Each c In ds.Tables(0).Columns
                    If IsDBNull(r(c)) Then
                        Try
                            r(c) = ""
                        Catch ex As Exception
                            Try
                                r(c) = 0
                            Catch ex2 As Exception
                                'ErrHandler2.WriteError("Error al limpiar la tabla " + ex2.ToString())
                            End Try
                        End Try
                    End If

                Next



                With myCartaDePorte



                    If .SituacionAntesDeEditarManualmente = 1 And .Situacion = 0 And BuscarSituacionId(r(2)) = 1 Then
                        '+ Si se modifica manualmente una carta de porte cambiando el estado de "Demorado" a "Autorizado", 
                        ' la situación de la carta de porte no deberá volver a "Demorado" si se vuelve a importar la información y vuelve a venir como demorado

                    ElseIf .SituacionAntesDeEditarManualmente = 5 And .Situacion = 6 And BuscarSituacionId(r(2)) = 5 Then
                        '+ Si se modifica manualmente una carta de porte cambiando el estado de "Rechazado" a "Desviado", 
                        ' la situación de la carta de porte no deberá volver a "Rechazado" si se vuelve a importar la información y vuelve a venir como demorado

                    ElseIf .Situacion = 0 Then
                        'correccion: ahora prohibo la actualizacion de autorizadas aun si son automaticas
                        'http://consultas.bdlconsultores.com.ar/Admin/verConsultas1.php?recordid=32327

                    Else

                        '+ Si la carta de porte fue editada manualmente no volver a importar los datos de la carta de porte.
                        ' Seguir importando los datos correspondientes a la situación del camion (Situación / Observaciones)
                        'correccion: ahora prohibo la actualizacion de autorizadas aun si son automaticas

                        Dim temp = .Situacion

                        If actua(.Situacion, BuscarSituacionId(r(2))) Then log += "Situacion; "
                        If If(.Situacion, -1) = -1 Then
                            If actua(.Situacion, BuscarSituacionId(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, r(2)))) Then log += "Situacion; "
                        End If


                        If actua(.ObservacionesSituacion, r(35)) Then log += "ObservacionesSituacion; "

                        .FechaActualizacionAutomatica = DateTime.Now
                    End If








                    'http://consultas.bdlconsultores.com.ar/AdminTest/template/desarrollo/Consulta.php?IdReclamo=37950&SinMenu=1
                    'no pisar si fue editada manual o pasó la ocr (o sea, si tiene una imagen adjunta)
                    '-no puedo comparar contra FechaActualizacionAutomatica porque esa se actualiza aunque no pise el resto de los datos.
                    ' (If(.FechaModificacion, DateTime.MinValue) > If(.FechaActualizacionAutomatica, DateTime.MinValue).AddSeconds(60))
                    Dim bEditadaManual As Boolean = .IdUsuarioModifico IsNot Nothing _
                                                    Or .PathImagen <> "" Or .PathImagen2 <> ""




                    If (Not bEditadaManual) Then

                        'y si fue importada con una pegatina? no estoy seguro de que se salte este IF en ese caso. se me hace un lio -hagamos un parche feo:
                        If If(.Observaciones, "") = "" Then .Observaciones = r(35)
                        'actua(.Observaciones, r(35))





                        Try
                            .FechaArribo = DateTime.Parse(iisValidSqlDate(Left(r(3), 10), DateTime.Now))
                        Catch ex As Exception

                        End Try
                        If .FechaArribo < #1/1/1980# Then .FechaArribo = DateTime.Today


                        .FechaModificacion = DateTime.Now

                        If actua(.Turno, r(1)) Then log += "Turno; "


                        If actua(.IdArticulo, BuscaIdArticuloPreciso(r(5), SC)) Then log += "Articulo; "
                        If .IdArticulo = -1 Then
                            If actua(.IdArticulo, BuscaIdArticuloPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, r(5)), SC)) Then log += "Articulo; "
                        End If
                        If .IdArticulo <= 0 Then .IdArticulo = Nothing



                        If actua(.Vendedor, BuscarClientePorCUIT(r(7), SC, r(6))) Then log += "Titular; "
                        If .Vendedor <= 0 Then .Vendedor = Nothing
                        'qué hacemos acá? loguearlo nada mas? no puedo darlo de alta si se lo banca? -pero si ya lo estoy intentando!

                        'r(6) = NombreCliente(SC, .Vendedor)


                        If actua(.CuentaOrden1, BuscarClientePorCUIT(r(9), SC, r(8))) Then log += "Intermediario; "
                        If .CuentaOrden1 <= 0 Then .CuentaOrden1 = Nothing
                        '.CuentaOrden1 = BuscarClientePorCUIT(r(9), SC, r(8))
                        'r(8) = NombreCliente(SC, .CuentaOrden1) 'actualizo el datatable solo en caso de que se procese con "usuario interactivo"...

                        If actua(.CuentaOrden2, BuscarClientePorCUIT(r(11), SC, r(10))) Then log += "Rem Comercial; "
                        If .CuentaOrden2 <= 0 Then .CuentaOrden2 = Nothing
                        '.CuentaOrden2 = BuscarClientePorCUIT(r(11), SC, r(10))
                        'r(10) = NombreCliente(SC, .CuentaOrden2)

                        If actua(.Corredor, BuscarVendedorPorCUIT(r(13), SC, r(12))) Then log += "Corredor; "
                        If .Corredor <= 0 Then .Corredor = Nothing
                        '.Corredor = BuscarVendedorPorCUIT(r(13), SC, r(12))
                        'r(12) = NombreCliente(SC, .Corredor)

                        If actua(.Entregador, BuscarClientePorCUIT(r(15), SC, r(14))) Then log += "Destinatario; "
                        If .Entregador <= 0 Then .Entregador = Nothing
                        '.Entregador = BuscarClientePorCUIT(r(15), SC, r(14))
                        'r(14) = NombreCliente(SC, .Entregador)


                        If actua(.IdClienteEntregador, BuscaIdClientePreciso(r(18), SC)) Then log += "Entregador; "
                        If .IdClienteEntregador <= 0 Then
                            If actua(.IdClienteEntregador, BuscaIdClientePreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, r(18)), SC)) Then
                                log += "Entregador; "
                            Else
                                .IdClienteEntregador = Nothing
                            End If
                        Else

                        End If
                        'Y en este caso?


                        'http://consultas.bdlconsultores.com.ar/AdminTest/template/desarrollo/Consulta.php?IdReclamo=37950&SinMenu=1
                        If If(.IdClienteEntregador, 0) <> 12454 And If(.IdClienteEntregador, 0) <> 0 Then
                            '.Exporta = "SI"   'removido por antireclamo 46885
                        End If




                        If actua(.Destino, BuscaIdWilliamsDestinoPreciso(r(16), SC)) Then log += "Destino; "
                        If .Destino <= 0 Then
                            'primero busco la equivalencia con excepcion prefijada
                            If actua(.Destino, BuscaIdWilliamsDestinoPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, "DESTINO|" + Val(r(17)).ToString), SC)) Then
                                log += "Destino; "
                            End If
                        End If
                        If .Destino <= 0 Then
                            If actua(.Destino, BuscaIdWilliamsDestinoPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, "DESTINO|" + r(16)), SC)) Then
                                log += "Destino; "
                            End If
                        End If
                        If .Destino <= 0 Then
                            If actua(.Destino, BuscaIdWilliamsDestinoPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, r(16)), SC)) Then log += "Destino; "
                        End If
                        If .Destino <= 0 Then .Destino = Nothing
                        If If(NombreDestino(SC, .Destino), "").Trim.ToUpper = "ACA SAN LORENZO" Then
                            Continue For
                        End If

                        '.Destino = BuscaIdWilliamsDestinoPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, r(16)), SC)





                        If actua(.IdTransportista, BuscarTransportistaPorCUIT(r(21), SC, r(20))) Then log += "Transportista; "
                        If .IdTransportista <= 0 Then .IdTransportista = Nothing
                        '.IdTransportista = BuscarTransportistaPorCUIT(r(21), SC, r(20))
                        If actua(.IdChofer, BuscarChoferPorCUIT(r(23), SC, r(22))) Then log += "Chofer; "
                        If .IdChofer <= 0 Then .IdChofer = Nothing
                        '.IdChofer = BuscarChoferPorCUIT(r(23), SC, r(22))



                        Dim proc = BuscaIdLocalidadPreciso(r(24), SC)
                        If proc = -1 Then
                            proc = BuscaIdLocalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, r(24)), SC)
                        End If
                        If proc = -1 Then
                            Try
                                Dim l = New ProntoMVC.Data.Models.Localidad()
                                l.Nombre = r(24)
                                db.Localidades.Add(l)
                                db.SaveChanges()
                                proc = l.IdLocalidad
                            Catch ex As Exception
                                proc = -1
                                ErrHandler2.WriteError(ex)
                            End Try
                        End If
                        If actua(.Procedencia, proc) Then log += "Procedencia; "
                        If .Procedencia <= 0 Then .Procedencia = Nothing




                        If actua(.BrutoPto, Decimal.Parse(Val(r(25)))) Then log += "BrutoPto; "
                        '.BrutoPto = Val(r(25))
                        If actua(.TaraPto, Decimal.Parse(Val(r(26)))) Then log += "TaraPto; "
                        '.TaraPto = Val(r(26))
                        If actua(.NetoPto, Decimal.Parse(Val(r(27)))) Then log += "NetoPto; "
                        '.NetoPto = Val(r(27))

                        If actua(.BrutoFinal, Decimal.Parse(Val(r(29)))) Then log += "BrutoFinal; "
                        '.BrutoFinal = Val(r(29))
                        If actua(.TaraFinal, Decimal.Parse(Val(r(30)))) Then log += "TaraFinal; "
                        '.TaraFinal = Val(r(30))

                        'If actua(.NetoFinalAntesDeRestarMermas, Val(r(31))) Then log += "NetoFinal; "
                        If actua(.NetoFinal, Decimal.Parse(Val(r(31)))) Then log += "NetoFinal; "
                        '.NetoFinalAntesDeRestarMermas = Val(r(31))

                        If actua(.Merma, Decimal.Parse(Val(r(32)))) Then log += "Merma; "
                        '.Merma = Val(r(32))
                        'If actua(.NetoFinalDespuesDeRestadasMermas, Val(r(33))) Then log += "NetoFinalMenosMermas; "
                        If actua(.NetoProc, Decimal.Parse(Val(r(33)))) Then log += "NetoFinalMenosMermas; "
                        '.NetoFinalDespuesDeRestadasMermas = Val(r(33))



                        Dim cal = BuscaIdCalidadPreciso(Trim(r(34)), SC)
                        If cal = -1 Then cal = BuscaIdCalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, Trim(r(34))), SC)
                        If cal <> -1 Then
                            If actua(.CalidadDe, cal) Then log += "Calidad; "
                        End If
                        If .CalidadDe <= 0 Then .CalidadDe = Nothing
                        '.CalidadDe = BuscaIdCalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, r(34)), SC)

                        .Calidad = ""



                        If actua(.Contrato, Val(r(36))) Then log += "Contrato; "
                        '.Contrato = r(36)
                        If actua(.CEE, Val(r(37))) Then log += "CEE; "
                        '.CEE = r(37)
                        If actua(.CTG, Integer.Parse(Val(r(38)))) Then log += "CTG; "
                        '.CTG = Val(r(38))

                        Try
                            'If If(.FechaDescarga, DateTime.MinValue) = DateTime.MinValue Then .FechaDescarga = .FechaArribo 'corregir: estoy truchando esto para poder incluir las q no fueron descargadas en el filtro de fecha que está ahora en la jqgrid de situacion
                            Try
                                If r(28) <> "" Then
                                    If actua(.FechaDescarga, DateTime.Parse(iisValidSqlDate(Left(r(28), 10)))) Then log += "FechaDescarga; "
                                End If
                            Catch ex3 As Exception
                                If actua(.FechaDescarga, DateTime.Parse(iisValidSqlDate(Left(r(28), 10)))) Then log += "FechaDescarga; "
                            End Try

                            '.FechaDescarga = iisValidSqlDate(r(28))
                            Try
                                If r(39) <> "" Then
                                    If actua(.FechaDeCarga, DateTime.Parse(iisValidSqlDate(Left(r(39), 10)))) Then log += "Fecha Carga; "
                                End If
                            Catch ex2 As Exception
                                If actua(.FechaDeCarga, DateTime.Parse(iisValidSqlDate(Left(r(39), 10)))) Then log += "Fecha Carga; "
                            End Try
                            '.FechaDeCarga = iisValidSqlDate(r(39))

                            If r(40) <> "" Then
                                If actua(.FechaVencimiento, DateTime.Parse(iisValidSqlDate(Left(r(40), 10)))) Then log += "Fecha Vencimiento; "
                            End If
                        Catch ex As Exception

                        End Try
                        If .FechaDescarga < #1/1/1980# Then .FechaDescarga = DateTime.Today
                        If .FechaDeCarga < #1/1/1980# Then .FechaDeCarga = DateTime.Today
                        If .FechaVencimiento < #1/1/1980# Then .FechaVencimiento = DateTime.Today
                        .FechaIngreso = .FechaDeCarga


                        '.FechaVencimiento = iisValidSqlDate(r(40))

                        .Patente = r(41)
                        .Acoplado = r(42)





                        .PuntoVenta = 2 'por decreto http://consultas.bdlconsultores.com.ar/Admin/verConsultas1.php?recordid=32327
                        'Try
                        '    If .Destino > 0 Then
                        '        .PuntoVenta = db.WilliamsDestinos.Find(.Destino).PuntoVenta
                        '    Else
                        '        .PuntoVenta = 1
                        '    End If
                        'Catch ex As Exception
                        '    .PuntoVenta = 1
                        'End Try


                        .Cosecha = "1617"



                        'hay banda de campos q dejo en NULL y los sincros explotan despues
                        .Humedad = 0
                        .NobleGrado = 0
                        .NobleExtranos = 0
                        .NRecibo = 0





                        .SituacionLog = Left(log, 299)
                    End If


                End With


                'Dim ms As String = ""
                'CartaDePorteManager.Save(SC, myCartaDePorte, 1, "", , ms)
                'Console.Write(ms)

                If myCartaDePorte.IdCartaDePorte <= 0 Then
                    myCartaDePorte.NumeroCartaDePorte = cpnumero
                    myCartaDePorte.SubnumeroVagon = 0
                    myCartaDePorte.SubnumeroDeFacturacion = 0
                    myCartaDePorte.NumeroCartaEnTextoParaBusqueda = cpnumero.ToString
                    db.CartasDePortes.Add(myCartaDePorte)
                Else
                    'si es un update no hace falta tocar nada
                End If

                'http://stackoverflow.com/questions/21272763/entity-framework-performance-issue-savechanges-is-very-slow
                'http://stackoverflow.com/questions/5940225/fastest-way-of-inserting-in-entity-framework

                db.SaveChanges()



                EntidadManager.Tarea(SC, "Log_InsertarRegistro", "IMPUR",
                                  myCartaDePorte.IdCartaDePorte, 0, DateTime.Now, 0, "", "", "SERVICIO",
                                 DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value,
                                DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value,
                                DBNull.Value, DBNull.Value, DBNull.Value)



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

                ErrHandler2.WriteError("Error en la grabacion " + sb.ToString())

                'Log(

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

        Next

        'db.SaveChanges()


        Return ds
    End Function






    Public Shared Situaciones() As String = {"Autorizado", "Demorado", "Posicion", "Descargado", "A Descargar", "Rechazado", "Desviado", "CP p/cambiar", "Sin Cupo", "Calado"}

    Public Shared Function BuscarSituacionId(sit As String) As Integer
        Try
            Dim index As Integer = Array.FindIndex(Situaciones, Function(s) s.Trim.ToLower = sit.Trim.ToLower)

            Return index
        Catch ex As Exception
            Return -1
        End Try

    End Function









    Public Shared Function BungeRamalloDescargaTextoToDataset(ByVal pFileName As String, SC As String) As Data.DataSet


        '7:41 (hace 13 minutos)

        '        para(mí, soporte)
        'System.ArgumentNullException: Argument cannot be Nothing. Parameter name: path at Microsoft.VisualBasic.FileIO.TextFieldParser.InitializeFromPath(String path, Encoding defaultEncoding, Boolean detectEncoding) at Microsoft.VisualBasic.FileIO.TextFieldParser..ctor(String path) at ExcelImportadorManager.ReyserToDataset(String pFileName) at CartasDePorteImportador.FormatearExcelImportado(String nombre) at CartasDePorteImportador.btnVistaPrevia_Click(Object sender, EventArgs e) STACKTRACE: at Microsoft.VisualBasic.FileIO.TextFieldParser.InitializeFromPath(String path, Encoding defaultEncoding, Boolean detectEncoding) at Microsoft.VisualBasic.FileIO.TextFieldParser..ctor(String path) at ExcelImportadorManager.ReyserToDataset(String pFileName) at CartasDePorteImportador.FormatearExcelImportado(String nombre) at CartasDePorteImportador.btnVistaPrevia_Click(Object sender, EventArgs e)



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()




        'dr(0) = "Prefijo Cp"
        dr(1) = "CARTA PORTE"
        dr(2) = "CARGADOR"
        dr(4) = "CORREDOR"
        dr(6) = "DESTINATARIO"
        dr(8) = "PRODUCTO"

        dr(14) = "PROCEDENCIA"
        dr(18) = "F. DE DESCARGA"

        dr(20) = "VAGON"
        dr(21) = "F. DE CARGA"

        dr(22) = "PATENTE"

        dr(23) = "NETO PROC"
        dr(24) = "BRUTO PROC"
        dr(25) = "BRUTO PTO"
        dr(26) = "TARA PROC"
        dr(27) = "TARA PTO"
        dr(28) = "NETO PTO"


        dr(29) = "HUMEDAD"
        'en 30 va el porcentaje de merma equivalente de la medicion de humedad
        dr(31) = "MERMA"
        'la columna 32 (33 en el excel) es la merma total, o sea la 31+33
        dr(33) = "OTRASMERMAS"




        dr(42) = "CALIDAD"
        dr(43) = "REMITENTE COMERCIAL"  'intercambiado con la pos del intermediario en la consulta 36711
        dr(45) = "INTERMEDIARIO"

        dr(49) = "CEE"


        dr(56) = "TRANSPCUIT"
        dr(57) = "TRANSPORTISTA"
        dr(58) = "CHOFER"


        dr(61) = "ACOPLADO" 'le agrego una columna por la columna adicional que me crea el doble renglon
        dr(62) = "FECHAVENCIMIENTO"



        'dr(42) = "Bruto Descarga"
        'dr(43) = "Tara Descarga"
        'dr() = "MERMA"


        'dr(27) = "BRUTO PROC"
        'dr(28) = "TARA PROC"



        'dr(2) = "Nro Vagon"
        'dr(3) = "Cuit Entregador"
        'dr(4) = "Razon Social Entregador"
        'dr(5) = "Cuit Corredor"

        'dr(6) = "CUIT"
        'dr(8) = "CUIT"

        'dr(43) = "OBSERVACIONES"


        'dr(10) = "CUIT"

        'dr(20) = "DESTINATARIOCUIT"

        'dr(6) = "Razon Social Corredor"
        'dr(7) = "Cuit Destinatario"
        'dr(8) = "Razon Social Destinatario"
        'dr(9) = "Cuit Titular"
        'dr(10) = "Razon Social Titular"
        'dr(11) = "Nro Planta Oncca Titular"
        'dr(12) = "Descripcion Planta Titular"
        'dr(13) = "Cuit Intermediario"
        'dr(14) = "Razon Social Intermediario"
        'dr(15) = "Nro Planta Oncca Intermediario"
        'dr(16) = "Descripcion Planta Intermediario"
        'dr(17) = "Cuit Remitente C."
        'dr(18) = "Razon Social  Remitente C."
        'dr(19) = "Nro Planta Oncca Remitente C."
        'dr(20) = "Descripcion Planta Remitente C."
        'dr(21) = "Cod Oncca Cereal"
        'dr(22) = "Descrip. Oncca"
        'dr(23) = "Cod Oncca Procedencia"
        'dr(24) = "Descrip. Procedencia"

        'dr(24) = "CHOFERCUIT"

        'dr(33) = "ACOPLADO"
        'dr(26) = "CONTRATO"
        'dr(33) = "OBSERVACIONES"



        'dr(25) = "Kilos Netos Procedencia"
        'dr(27) = "Patente"

        'dr(28) = "Cuit Transportista"
        'dr(29) = "Razon Social Transportista"
        'dr(30) = "Turno"
        'dr(31) = "Estado"
        'dr(33) = "Observacion"
        'dr(34) = "Hora Entrada"
        'dr(35) = "Cod Puerto"
        'dr(36) = "Medio"
        'dr(37) = "Kilos Netos Descargados"
        'dr(38) = "Tipo"
        'dr(39) = "Fecha Descarga"
        'dr(41) = "Hora Salida"

        'dr(44) = "RECIBO"


        'dr(1) = "CARTA PORTE"
        'dr(30) = "TURNO"
        'dr(4) = "CTG"


        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=13119
        'dr(38) = "EXPORTA"
        'dr(50) = "SUBNUMERODEFACTURACION"

        dt.Rows.Add(dr)



        'to do
        'no guardar datos de descarga



        '        0005;54520954 (numero de cp);
        'ARAMBURU HNOS AGROPECUARIA SA (Titular)                     
        ';30648082408(cuit titular);
        'GRANAR S.A.C.Y.F. (corredor)                            
        '     ;30528981700(cuit corredor);
        'BUNGE ARGENTINA S.A.  (destinatario)                            
        ';30700869918(cuit destinatario);
        '        SOJA(product)
        ' ;023;BUNGE ARGENTINA S.A.;
        '30700869918;WILLIAMS ENTREGAS S.A.                
        '     ;30707386076;9 DE JULIO (BS.AS.)(procedencia)                       
        '        ;0000030;000101;000001;05/07/2016;(fecha de descarga)    
        '        ;CAMION;04/07/2016 (fecha de carga) ;ESY835(pat camion)    ;000029380(kg neto proce);000044800(kg Bruto);000044600(bruto descar);000015420(Tara proce);000015310(tara descar);000029290(neto descar);15,00(humedad);02,55;0000747;0000747(merma humedad? no se pq esta dos veces);0000000;04/07/2016 ;1909;1136;Sergio (nombre del chofer)                                            ;0056;          ;GRANEL    ;N;CONDICIONAL(calidad)         ;ILLINOIS S.A.(Intermediario)                                     ;30709162094;QUEBRACHITO GRANOS SA (remitente)                            ;30696426127(cuit remitente);                                                  ;00000000000;86248882908556 (cee);0;0;0000000000;0000023405;58;0;30648082408 (cuit transportista);ARAMBURU HNOS AGROPECUARIA SA (transportista)                    ;RILGENMAN (nombre chofer)                      
        '                   ;23236808629(cuit chofer);00000501,95;CYU363    
        ' ;10/08/2016;(fecha vencimiento)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)
            'REYSER VA SEPARADO CON TABS!
            'REYSER VA SEPARADO CON TABS!
            'REYSER VA SEPARADO CON TABS!
            'REYSER VA SEPARADO CON TABS!


            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {";"}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try

                    Dim l = MyReader.ReadFields().ToList
                    'leo 2 renglones seguidos (así es este formato) -dan marcha atrás con esto http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=23529
                    'l.AddRange(MyReader.ReadFields().ToList)

                    currentRow = l.ToArray


                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler2.WriteError("Line " & ex.ToString & " is invalid.  Skipping")
                End Try
            End While
        End Using


        For Each r In dt.Rows

            Try
                If Val(r(1)) = 0 Then Continue For

                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))


                r(29) = r(29).Replace(".", "").Replace(",", ".")

                If r(4) = "" Then
                    r(4) = "DIRECTO"
                End If



                'consulta 36711
                'Cuando solo viene completo el campo 44 y no el 46, entonces el que viene en el 44 es el remitente comercial.
                'Si vienen los dos completos, el 44 es el intermediario y el 46 el remitente comercial.
                If r(45) <> "" And r(43) <> "" Then
                    Dim temp = r(43)
                    r(43) = r(45)
                    r(45) = temp
                End If






                'calidad
                'http://consultas.bdlconsultores.com.ar/Admin/verConsultas1.php?recordid=25040
                '  Si hay "otras mermas"  tiene que poner FUERA DE BASE
                'Si no hay otras mermas, pero hay merma humedad, poner CONFORME

                If Val(dr(32)) > 0 Then
                    dr(42) = BuscaIdCalidadPreciso("FUERA DE BASE", SC)
                ElseIf Val(dr(30)) > 0 Then
                    dr(42) = BuscaIdCalidadPreciso("CONFORME", SC)
                End If




                'r(40) = CodigoCalidad(Val(r(40)))

                'Select Case r(38)
                '    Case "1"
                '        r(38) = "NO"
                '    Case "2"
                '        r(38) = "SI"
                '    Case "3"
                '        r(38) = "NO"
                '    Case Else

                'End Select
            Catch ex As Exception

            End Try

        Next




        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        'duplico renglones con tipo de exportacion especial

        'lo que necesitamos es que si viene código 2 ,que pegue duplicada. 
        '(Original con el tilde de exportación y la duplicada sin el tilde es de entrega)
        'otra posibilidad si no se puede hacer la anterior es que pegue como entrega solamente.

        Dim dtcopias = dt.Clone

        Dim sourceRow As DataRow

        For Each r As DataRow In dt.Rows
            If Not IsDBNull(r(38)) Then
                If r(38) = "SI" Then

                    sourceRow = r
                    r(38) = "NO"


                    Dim desRow As DataRow = dtcopias.NewRow
                    desRow.ItemArray = sourceRow.ItemArray.Clone
                    desRow(50) = "1" 'segundo subnumero de facturacion
                    desRow(38) = "SI"
                    dtcopias.Rows.Add(desRow)
                End If
            End If
        Next

        For Each r In dtcopias.Rows
            Dim desRow As DataRow = dt.NewRow
            desRow.ItemArray = r.ItemArray.Clone
            dt.Rows.Add(desRow)
        Next



        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////







        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds





        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


    End Function


    Public Shared Function ReyserToDataset(ByVal pFileName As String) As Data.DataSet


        '7:41 (hace 13 minutos)

        '        para(mí, soporte)
        'System.ArgumentNullException: Argument cannot be Nothing. Parameter name: path at Microsoft.VisualBasic.FileIO.TextFieldParser.InitializeFromPath(String path, Encoding defaultEncoding, Boolean detectEncoding) at Microsoft.VisualBasic.FileIO.TextFieldParser..ctor(String path) at ExcelImportadorManager.ReyserToDataset(String pFileName) at CartasDePorteImportador.FormatearExcelImportado(String nombre) at CartasDePorteImportador.btnVistaPrevia_Click(Object sender, EventArgs e) STACKTRACE: at Microsoft.VisualBasic.FileIO.TextFieldParser.InitializeFromPath(String path, Encoding defaultEncoding, Boolean detectEncoding) at Microsoft.VisualBasic.FileIO.TextFieldParser..ctor(String path) at ExcelImportadorManager.ReyserToDataset(String pFileName) at CartasDePorteImportador.FormatearExcelImportado(String nombre) at CartasDePorteImportador.btnVistaPrevia_Click(Object sender, EventArgs e)



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()







        'REYSER VA SEPARADO CON TABS!
        'REYSER VA SEPARADO CON TABS!
        'REYSER VA SEPARADO CON TABS!
        'REYSER VA SEPARADO CON TABS!
        'REYSER VA SEPARADO CON TABS!







        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>

        dr(43) = "OBSERVACIONES"

        'dr(0) = "Prefijo Cp"
        dr(1) = "CARTA PORTE"
        'dr(2) = "Nro Vagon"
        'dr(3) = "Cuit Entregador"
        'dr(4) = "Razon Social Entregador"
        'dr(5) = "Cuit Corredor"

        dr(10) = "CARGADOR"
        'dr(6) = "CUIT"
        dr(14) = "INTERMEDIARIO"
        'dr(8) = "CUIT"
        dr(18) = "REMITENTE COMERCIAL"
        'dr(10) = "CUIT"
        dr(6) = "CORREDOR"

        dr(8) = "DESTINATARIO"
        'dr(20) = "DESTINATARIOCUIT"

        'dr(6) = "Razon Social Corredor"
        'dr(7) = "Cuit Destinatario"
        'dr(8) = "Razon Social Destinatario"
        'dr(9) = "Cuit Titular"
        'dr(10) = "Razon Social Titular"
        'dr(11) = "Nro Planta Oncca Titular"
        'dr(12) = "Descripcion Planta Titular"
        'dr(13) = "Cuit Intermediario"
        'dr(14) = "Razon Social Intermediario"
        'dr(15) = "Nro Planta Oncca Intermediario"
        'dr(16) = "Descripcion Planta Intermediario"
        'dr(17) = "Cuit Remitente C."
        'dr(18) = "Razon Social  Remitente C."
        'dr(19) = "Nro Planta Oncca Remitente C."
        'dr(20) = "Descripcion Planta Remitente C."
        'dr(21) = "Cod Oncca Cereal"
        'dr(22) = "Descrip. Oncca"
        'dr(23) = "Cod Oncca Procedencia"
        'dr(24) = "Descrip. Procedencia"

        'dr(23) = "CHOFER"
        'dr(24) = "CHOFERCUIT"
        dr(22) = "PRODUCTO"

        dr(24) = "PROCEDENCIA"
        dr(27) = "PATENTE"
        'dr(33) = "ACOPLADO"
        dr(26) = "CONTRATO"
        dr(33) = "OBSERVACIONES"


        'dr(27) = "BRUTO PROC"
        'dr(28) = "TARA PROC"
        dr(25) = "NETO PROC"

        'dr(25) = "Kilos Netos Procedencia"
        'dr(27) = "Patente"
        dr(28) = "TRANSPORTISTA"
        dr(29) = "TRANSPCUIT"

        'dr(28) = "Cuit Transportista"
        'dr(29) = "Razon Social Transportista"
        'dr(30) = "Turno"
        'dr(31) = "Estado"
        dr(32) = "F. DE CARGA"
        'dr(33) = "Observacion"
        'dr(34) = "Hora Entrada"
        'dr(35) = "Cod Puerto"
        'dr(36) = "Medio"
        'dr(37) = "Kilos Netos Descargados"
        'dr(38) = "Tipo"
        'dr(39) = "Fecha Descarga"
        dr(39) = "F. DE DESCARGA"
        'dr(40) = "Calidad"
        dr(40) = "CALIDAD"
        'dr(41) = "Hora Salida"
        'dr(42) = "Bruto Descarga"
        'dr(43) = "Tara Descarga"
        dr(42) = "BRUTO PTO"
        dr(43) = "TARA PTO"
        'dr() = "MERMA"
        dr(37) = "NETO PTO"

        dr(44) = "RECIBO"


        dr(1) = "CARTA PORTE"
        'dr(2) = "VAGON"
        dr(30) = "TURNO"
        'dr(4) = "CTG"


        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=13119
        dr(38) = "EXPORTA"
        dr(50) = "SUBNUMERODEFACTURACION"

        dt.Rows.Add(dr)



        'to do
        'no guardar datos de descarga



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)
            'REYSER VA SEPARADO CON TABS!
            'REYSER VA SEPARADO CON TABS!
            'REYSER VA SEPARADO CON TABS!
            'REYSER VA SEPARADO CON TABS!

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {vbTab} 'REYSER VA SEPARADO CON TABS!

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler2.WriteError("Line " & ex.ToString & " is invalid.  Skipping")
                End Try
            End While
        End Using


        For Each r In dt.Rows

            Try
                If Val(r(1)) = 0 Then Continue For

                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))



                r(40) = CodigoCalidad(Val(r(40)))

                Select Case r(38)
                    Case "1"
                        r(38) = "NO"
                    Case "2"
                        r(38) = "SI"
                    Case "3"
                        r(38) = "NO"
                    Case Else

                End Select
            Catch ex As Exception

            End Try

        Next




        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        'duplico renglones con tipo de exportacion especial

        'lo que necesitamos es que si viene código 2 ,que pegue duplicada. 
        '(Original con el tilde de exportación y la duplicada sin el tilde es de entrega)
        'otra posibilidad si no se puede hacer la anterior es que pegue como entrega solamente.

        Dim dtcopias = dt.Clone

        Dim sourceRow As DataRow

        For Each r As DataRow In dt.Rows
            If Not IsDBNull(r(38)) Then
                If r(38) = "SI" Then

                    sourceRow = r
                    r(38) = "NO"


                    Dim desRow As DataRow = dtcopias.NewRow
                    desRow.ItemArray = sourceRow.ItemArray.Clone
                    desRow(50) = "1" 'segundo subnumero de facturacion
                    desRow(38) = "SI"
                    dtcopias.Rows.Add(desRow)
                End If
            End If
        Next

        For Each r In dtcopias.Rows
            Dim desRow As DataRow = dt.NewRow
            desRow.ItemArray = r.ItemArray.Clone
            dt.Rows.Add(desRow)
        Next



        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////







        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds





        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


    End Function

    Public Shared Function Unidad6ToDataset_CUITTIT_CUITCORR_EstadoPosicion_NoEsDescarga_SeparadoConPuntoYComa(ByVal pFileName As String) As Data.DataSet





        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()


        'nos estan delirando con los formatos
        'en uno nos mandan separado con puntocoma y en otro con tab
        'en uno el numero de carta porte esta en la columna n2 (empieza con prefijo/nrocarta) ,  y en otro en la columna n22 (empieza con cuit titular/cuit corredor)



        'este es el formato original de Reyser. De aca salen los de Unidad6
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultasCumplidos1.php?recordid=9305


        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        'formato para cerealnet.  usando "playa perez"???? usando formato reyser????
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultasCumplidos1.php?recordid=9308
        'fijate que en tu funcion Unidad6ToDatasetVersionAnteriorConTabs
        '//////////////////////////////////////////////
        'ejemplo:
        '5;31063160;0;30707386076;WILLIAMS ENTREGA S.A.;30539435589;GRIMALDI GRASSI S.A.;30697312028;ADM ARGENTINA S.A.;30708023635;CIGRA CAMPOS S.A;0;;30691576511;PROFERTIL S.A.;0;;30640872566;COMMODITIES S.A.;0;;19;MAIZ;4437;DIEGO DE ALVEAR;29920;3602;WHC142;27235772081;AGUERO SONIA;00000229;4;22/04/2013;;0000;19;30691576511;PROFERTIL S.A.;0;;1;29900;23/04/2013;5;0014;42960;13060;000000;0;00.00;00.00;21/04/2013;0000;00000000;;;;;;;;;;;;01/01/1900;;;;;;;;;;;01/01/1900;;;;;;NO;0;;0
        '5;31651086;0;30707386076;WILLIAMS ENTREGA S.A.;30539435589;GRIMALDI GRASSI S.A.;30710179987;MULTIGRAIN ARGENTINA S.A;30711045909;DEMARCHI JORGE JAVIER Y OTROS;0;;30707060871;GRUPO CKOOS S.R.L.;0;;30646328450;SYNGENTA AGRO S.A.;0;;22;SORGO GRANIFERO;8609;LAS PEÑAS SUD;30500;220829;GNO175;20256561345;BIANCO EDUARDO;00000775;4;22/04/2013;;0000;19;30646328450;SYNGENTA AGRO S.A.;0;;1;29960;23/04/2013;5;0037;44260;14300;000000;0;00.00;00.00;21/04/2013;0000;00000000;;;;;;;;;;;;01/01/1900;;;;;;;;;;;01/01/1900;;;;;;NO;0;;0
        '//////////////////////////////////////////////
        'otro ejemplo:
        '5	29490128	0	30707386076	WILLIAMS ENTREGA S.A.	11111111111	DIRECTO	30697312028	ADM ARGENTINA S.A.	30604954130	GRANERO S.R.L.	0		00000000000		0		00000000000		0		19	MAIZ	19281	VICTORIA	30240	013012952	SDJ179	20129905647	GONZALEZ JUAN CARLOS	00002738	4	06/02/2013			19	1	30160	1	06/02/2013	3		44940	14780	000000	151	00.00	00.00	06/02/2013	0000	00000000	00000000	0000	0	0	00000000000		00000		00000000000	00000000	01/01/1900	00000000000				0.00	0.00	00000	00		0	01/01/1900						NO	0	000000000000	0
        '5	29490124	0	30707386076	WILLIAMS ENTREGA S.A.	11111111111	DIRECTO	30697312028	ADM ARGENTINA S.A.	30604954130	GRANERO S.R.L.	0		00000000000		0		00000000000		0		19	MAIZ	19281	VICTORIA	29800	013012952	ECF682	30710565976	BENEDETTI E.	00002734	4	06/02/2013			19	1	29780	1	06/02/2013	5		44960	15180	000000	0	00.00	00.00	05/02/2013	0000	00000000	00000000	0000	0	0	00000000000		00000		00000000000	00000000	01/01/1900	00000000000				0.00	0.00	00000	00		0	01/01/1900						NO	0	000000000000	0
        '5	29495846	0	30707386076	WILLIAMS ENTREGA S.A.	30703605105	FUTURO Y OPCIONES CON. S.A.	30697312028	ADM ARGENTINA S.A.	20017339991	RAY, JOSE DOMINGO	0		00000000000		0		30537721274	TOMAS HNOS.	0		15	TRIGO PAN	10978	PEHUAJO	31280	033036793	RII796	30709049093	AGROLOGISTICA SRL	00009710	4	06/02/2013			19	1	31180	1	06/02/2013	3		44600	13420	000000	156	00.00	00.00	01/02/2013	0000	00000000	00000000	0000	0	0	00000000000		00000		00000000000	00000000	01/01/1900	00000000000				0.00	0.00	00000	00		0	01/01/1900						NO	0	000000000000	0


        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        'y cual es el ejmplo que usaste acá?????
        ' http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultasCumplidos1.php?recordid=9837
        'sería lo de playa perez
        'pero el de la 9308 tambien era de playa perez
        '30511512073;11111111111;30711160163;6419;19;19;30707386076;;MARIA ELENA SOC EN COM POR ACCIONES;;28/03/2013;00/00/0000;;0000;0;no;30340;0;0;0;Camión;30524090;000000;0;;; ;Descargó;00000354;MARIA ELENA SOC EN COM POR ACCIONES;DIRECTO;CHS DE ARGENTINA SA;;Maiz;GENERAL VILLEGAS;;1;30511512073;no;0;5;00000000000;;30511355040;SUCESION DE ANTONIO MORENO S A C A I F E;00000000000; ;30511512073;0;0;0;0;00000000000;00000; ;00000;;00000;;4500;56;369
        '30511512073;11111111111;30711160163;6419;19;19;30707386076;;MARIA ELENA SOC EN COM POR ACCIONES;;28/03/2013;00/00/0000;;0000;0;no;30380;0;0;0;Camión;30524094;000000;0;;; ;Descargó;00000404;MARIA ELENA SOC EN COM POR ACCIONES;DIRECTO;CHS DE ARGENTINA SA;;Maiz;GENERAL VILLEGAS;;1;30511512073;no;0;5;00000000000;;30511355040;SUCESION DE ANTONIO MORENO S A C A I F E;00000000000; ;30511512073;0;0;0;0;00000000000;00000; ;00000;;00000;;4500;56;369
        '30511512073;11111111111;30711160163;6419;19;19;30707386076;;MARIA ELENA SOC EN COM POR ACCIONES;;28/03/2013;00/00/0000;;0000;0;no;30520;0;0;0;Camión;30524092;000000;0;;; ;Descargó;00000405;MARIA ELENA SOC EN COM POR ACCIONES;DIRECTO;CHS DE ARGENTINA SA;;Maiz;GENERAL VILLEGAS;;1;30511512073;no;0;5;00000000000;;30511355040;SUCESION DE ANTONIO MORENO S A C A I F E;00000000000; ;30511512073;0;0;0;0;00000000000;00000; ;00000;;00000;;4500;56;369





        '0:      cuit_titular()
        'dr(0) = "CARGADOR" 'ya sé que lo repetís abajo. Este está para que sepa encontrar el renglon de titulos
        '1:      CUIT_corre()
        '2:      cuit_destinatario()
        '3:      cod_procedencia()
        '4:      cod_puerto()
        '5:      cod(mercaderia)
        '6:      cuit(entregador)
        '7:      contrato()
        dr(26) = "CONTRATO"
        '8	razon social titular
        '9:      fecha(descarga)
        dr(9) = "F. DE DESCARGA"
        '10:     fecha(entrada)
        dr(10) = "F. DE CARGA"
        '11:     fecha_emision()
        '12:     hora(salida)
        '13:     hora(entrada)
        '14:     kilos_merma()
        '15:     no()


        '16:     kgs(procedencia)
        dr(16) = "NETO PROC"        'dr(19) = "NETO PROC"
        '17:     bruto()
        dr(17) = "BRUTO PTO"
        '18:     tara()
        dr(18) = "TARA PTO"
        '19:     kgs(neto)
        dr(19) = "NETO PTO"        ' dr(16) = "NETO PTO"   no, este  es NETOPROC



        '20:     medio(camion / vagon)
        '21	Nro de carta
        dr(21) = "CARTA PORTE"
        '22:     Nro(Recibo)
        dr(22) = "RECIBO"
        '23:     Nro(vagon)
        dr(23) = "VAGON"
        '24:     observacion()
        dr(24) = "OBSERVACIONES"
        '25:     patente()
        dr(25) = "PATENTE"
        '26:     ' '
        '27:     Descargó() '  
        '28:     turno()
        dr(30) = "TURNO"
        '29	razon social titular
        dr(29) = "CARGADOR"

        '30	razon social corredor
        dr(30) = "CORREDOR"


        '31	razon social destin
        dr(31) = "DESTINATARIO"
        '32:     nombre_puerto()
        '33:     descripcion(mercaderia)
        dr(33) = "PRODUCTO"
        '34:     nombre_proce()
        dr(34) = "PROCEDENCIA"
        '35:     cosecha()
        '36:     '1'
        '37:     cuit_titular()
        '38:     'no'
        '39:     calidad()


        'dr(39) = "CALIDAD"
        dr(39) = "NADANADANADA"
        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=13585
        'Andres, como lo de playa Pérez es posición , NO DESCARGAS , que no pegue ninguna calidad cuando se sube la pegatina de UNIDAD6 PLAYA PEREZ


        '40:     prefijo(cp)
        '41:     cuit_intermediario()
        '42	razon social interm
        dr(42) = "INTERMEDIARIO"
        '43:     cuit_remitente(comercial)
        '44	razon social remitente comercial
        dr(44) = "REMITENTE COMERCIAL"
        '45:     '00000000000'
        '46:     ' '
        '47:     cuit(titular)
        '48:     '0'
        '49:     '0'
        '50:     '0'
        '51:     '0'
        '52:     cuit_transp()
        'dr() = "TRANSPORTISTA"
        dr(52) = "TRANSPCUIT"
        '53:     nro_planta_titular()
        '54:     descripcion_planta_titular()
        '55:     nro_planta_intermediario()
        '56:     descrip_planta_intermediario()
        '57:     nro_planta_remitente_comercial()
        '58:     descripcion_planta_remitente()
        '59:     cod_remi()
        '60:     cod_corre()
        '61:     cod_destin()



        '   Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>





        'pero este es "posicion"? -Sí!

        '    PEGATINA PLAYA PEREZ: (POSICION)
        '•	Cuando hacemos la pegatina de Playa Perez , Posición pega los KILOS de procedencia en 
        '           la solapa de descarga, lo tiene que pegar en la primer solapa en KILOS NETOS de procedencia.
        '•	Pega la fecha de descarga y no LA TIENE QUE PEGAR (segunda solapa), porque cuando se genera la posición si esta esa fecha puesta no sale.


        'fecha descarga deberia quedar null. -y cómo hacemos con los kilos?




        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {";"}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler2.WriteError("Line " & ex.ToString & " is invalid.  Skipping")
                End Try
            End While
        End Using


        For Each r In dt.Rows
            'transformar columna de calidad
            '1 = CO; 2 = CC; 3 = G1; 4 = G2; 5 = G3; 6 = FE
            Try

                If Val(r(1)) = 0 Then Continue For

                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))

                Dim c = CodigoCalidad(Val(r(40)))
                'r(40) = c
                r(39) = c


            Catch ex As Exception

            End Try


        Next



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds





        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


    End Function


    Public Shared Function Unidad6CalidadesToDataset(ByVal pFileName As String, SC As String, cmbPuntoVenta As Integer, ByRef txtLogErrores As String, txtFechaArribo As DateTime, glbIdUsuario As Integer, UserName As String) As Data.DataSet
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()














        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>


        '        Archivo(Anali.txt)
        'Prefijo Cp	numeric(4)
        'Nro CP	numeric(8)
        'Nro Recibo	numeric(8)
        'Nro Rubro Analisis	numeric(3)
        'Nro Vagon	numeric(6)
        'Kilos Merma	numeric(6)
        'Porcentaje Humedad	numeric(3,2)
        'Porcentaje Merma	numeric(3,2)
        'Cantidad Analisis	numeric(6)



        dr(0) = "PREFIJO"
        dr(1) = "CARTA PORTE"
        dr(2) = "RECIBO"
        dr(3) = "RUBRO"
        dr(4) = "VAGON"
        dr(5) = "MERMA"
        dr(6) = "PROCENTAJEHUMEDAD"
        dr(7) = "PORCENTAJEMERMA"
        dr(8) = "CANTIDAD"



        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {";"}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler2.WriteError("Line " & ex.ToString & " is invalid.  Skipping")
                End Try
            End While
        End Using





        '        Archivo(Anali.txt)
        'Prefijo Cp	numeric(4)
        'Nro CP	numeric(8)
        'Nro Recibo	numeric(8)
        'Nro Rubro Analisis	numeric(3)
        'Nro Vagon	numeric(6)
        'Kilos Merma	numeric(6)
        'Porcentaje Humedad	numeric(3,2)
        'Porcentaje Merma	numeric(3,2)
        'Cantidad Analisis	numeric(6)
        'Fecha	date

        Dim c = 0
        For Each r In dt.Rows

            Try
                If Val(r(1)) = 0 Then Continue For
                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))


                'el separado por tabs
                Dim numeroCarta As Long = r(1)   '  Val(Replace(r(0), "-", ""))
                Dim vagon As Long = 0 ' Val(r(4)) 'por ahora, las cdp importadas tendran subnumero 0

                Dim Rubro As Long = r(2)
                Dim kilosmerma As Double = Val(r(4))
                Dim porcentajehum As Double = Val(r(5))
                Dim analisis As Double = r(6)





                Dim cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, -1)
                If cdp.Id = -1 Then
                    cdp.NumeroCartaDePorte = numeroCarta
                    cdp.SubnumeroVagon = vagon
                End If


                With cdp
                    Select Case Rubro
                        Case 1 'dañado
                            cdp.NobleDaniados = analisis
                        Case 2
                            '                http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=23519
                            '                Bueno, después de hablar con la gente del sistema y la gente que carga los datos en el puerto se llegó a la conclusión de que viene mal cargado de origen y va a seguir viniendo asi.

                            'Por lo que dicen, siempre mandan todas las mermas juntas en un solo campo, sean por el motivo que sean.

                            'Solución propuesta por Williams:
                            'Si hay porcentaje de Humedad informado -> calcular la merma según la tabla de humedad y poner eso en merma por humedad. En Otras Mermas, poner la diferencia entre el total informado y esta merma calculada
                            'Si no hay porcentaje de Humedad informado -> enviar a Otras Mermas el numero informado

                            Dim kiloshumedad As Double = 0
                            If porcentajehum > 0 Then
                                Dim porcentajemerma = CartaDePorteManager.BuscaMermaSegunHumedadArticulo(SC, cdp.IdArticulo, porcentajehum)
                                kiloshumedad = porcentajemerma / 100 * cdp.NetoFinalDespuesDeRestadasMermas
                            End If

                            cdp.Humedad = porcentajehum
                            cdp.HumedadDesnormalizada = kiloshumedad
                            cdp.Merma = kilosmerma - kiloshumedad




                        Case 3
                            .NobleHectolitrico = analisis
                        Case 4
                            .NobleExtranos = analisis
                        Case 5
                            .NobleQuebrados = analisis
                        Case 7
                            .NoblePicados = analisis
                        Case 8
                            .CalidadPuntaSombreada = analisis
                        Case 9
                            .NobleNegros = analisis
                        Case 10
                            .NobleObjetables = analisis
                        Case 14
                            .NobleAmohosados = analisis
                        Case 15
                            .CalidadMermaChamico = analisis
                        Case 16
                            .NobleCarbon = analisis
                        Case 18
                            .Fumigada = analisis
                        Case 28
                            .CalidadTierra = analisis
                        Case 30
                            .NoblePanzaBlanca = analisis
                        Case 34
                            .NobleQuebrados = analisis
                        Case 39
                            .NobleVerdes = analisis
                        Case 40
                            .CalidadMermaChamico = analisis
                        Case 68
                            .NobleMGrasa = analisis

                        Case Else
                            If False Then txtLogErrores &= "No se pudo importar rubro " & Rubro & vbCrLf

                            Continue For
                    End Select

                    c += 1


                    LogicaImportador.actualizar(.FechaArribo, txtFechaArribo)
                End With


                Try
                    Dim ms As String
                    Dim valid = CartaDePorteManager.IsValid(SC, cdp, ms)
                    ', IdUsuario As Integer, UserName As String
                    'If CartaDePorteManager.Save(SC, cdp, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName)) = -1 Then
                    If CartaDePorteManager.Save(SC, cdp, glbIdUsuario, UserName) = -1 Then
                        txtLogErrores &= "No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf
                        Debug.Print("No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf)
                        ErrHandler2.WriteError("Error al grabar CDP importada")
                        txtLogErrores &= ms
                    Else
                        'dr.Item("URLgenerada") = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)
                    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    txtLogErrores &= "No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf
                    txtLogErrores &= ex.ToString

                End Try
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                txtLogErrores &= ex.ToString
            End Try

        Next







        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)

        'panelEquivalencias.Visible = True
        'MsgBoxAjax(Me, "Análisis Unidad6 importación terminada") ' . Analisis importados " & c)
        txtLogErrores = "Análisis Unidad6 importación terminada." & vbCrLf & txtLogErrores
        'txtLogErrores.Visible = True


        Return ds

    End Function



    Public Shared Function CodigoCalidad(cal As Long) As String
        'transformar columna de calidad
        '1 = CO; 2 = CC; 3 = G1; 4 = G2; 5 = G3; 6 = FE

        'aca tenemos el problema de la 9877  
        'DARI, CARGILL SIGUE IGUAL. LAS CALIDADES DE MAIZ, ME LAS SIGUE PEGANDO MAL, C/C COMO GRADO 3 Y GRADO 1 COMO C/C.
        ' ellos esperarian 2 = G1   y 5=CC

        '            [01:30:42 p.m.] andres gurisatti: De: Diego Magnaterra [mailto:diegom@cerealnet.com] 
        'Enviado el: miércoles, 24 de abril de 2013 13:06
        'Para:       Andrés(Gurisatti)
        'Asunto:     Re() : Sincronismo(Cargill)

        'Hola Andres la tabla de calidad es la siguiente
        '1:          CONFORME(CO)
        '2 GRADO 1 G1
        '3 GRADO 2 G2
        '4 GRADO 3 G3
        '5:          CONDICIONAL(CC)
        '6 FUERA DE ESTANDAR FE
        'Perdona si te la pase mal la otra vez





        Select Case cal
            Case 1
                Return "CO"
            Case 2
                Return "G1"
            Case 3
                Return "G2"
            Case 4
                Return "G3"
            Case 5
                Return "CC"
            Case 6
                Return "FE"
            Case Else
                Return "  "
        End Select
        Return "  "
    End Function




    Public Shared Function ReyserCalidadesToDataset(ByVal pFileName As String, SC As String, cmbPuntoVenta As Integer, ByRef txtLogErrores As String, txtFechaArribo As DateTime, glbIdUsuario As Integer, UserName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()














        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>


        '        Archivo(Anali.txt)
        'Prefijo Cp	numeric(4)
        'Nro CP	numeric(8)
        'Nro Recibo	numeric(8)
        'Nro Rubro Analisis	numeric(3)
        'Nro Vagon	numeric(6)
        'Kilos Merma	numeric(6)
        'Porcentaje Humedad	numeric(3,2)
        'Porcentaje Merma	numeric(3,2)
        'Cantidad Analisis	numeric(6)



        dr(0) = "PREFIJO"
        dr(1) = "CARTA PORTE"
        dr(2) = "RECIBO"
        dr(3) = "RUBRO"
        dr(4) = "VAGON"
        dr(5) = "MERMA"
        dr(6) = "PROCENTAJEHUMEDAD"
        dr(7) = "PORCENTAJEMERMA"
        dr(8) = "CANTIDAD"



        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {vbTab}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler2.WriteError("Line " & ex.ToString & " is invalid.  Skipping")
                End Try
            End While
        End Using





        '        Archivo(Anali.txt)
        'Prefijo Cp	numeric(4)
        'Nro CP	numeric(8)
        'Nro Recibo	numeric(8)
        'Nro Rubro Analisis	numeric(3)
        '4 Nro Vagon	numeric(6)   
        '5 Kilos Merma	numeric(6)
        '6 Porcentaje Humedad	numeric(3,2)
        '7 Porcentaje Merma	numeric(3,2)
        '8 Cantidad Analisis	numeric(6)
        'Fecha	date

        Dim c = 0
        For Each r In dt.Rows

            Try
                If Val(r(1)) = 0 Then Continue For
                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))

                Dim numeroCarta As Long = r(1)   '  Val(Replace(r(0), "-", ""))
                Dim vagon As Long = Val(r(4)) 'por ahora, las cdp importadas tendran subnumero 0  -noooo, pone -1 !!
                Dim Rubro As Long = r(3)

                Dim kilosmerma As Double = Val(r(5))
                Dim porcentajehum As Double = Val(r(6))
                'Dim porcentajemerm As Double = Val(r(6)

                Dim analisis As Double = r(7)

                Dim cdp As CartaDePorte
                Try
                    cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, 0)
                Catch ex As Exception
                    cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon, -1)
                End Try


                If cdp.Id = -1 Then
                    cdp.NumeroCartaDePorte = numeroCarta
                    cdp.SubnumeroVagon = vagon

                    cdp.SubnumeroDeFacturacion = 0
                End If

                cdp.PuntoVenta = cmbPuntoVenta



                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '                http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=23519
                '                Bueno, después de hablar con la gente del sistema y la gente que carga los datos en el puerto se llegó a la conclusión de que viene mal cargado de origen y va a seguir viniendo asi.

                'Por lo que dicen, siempre mandan todas las mermas juntas en un solo campo, sean por el motivo que sean.

                'Solución propuesta por Williams:
                'Si hay porcentaje de Humedad informado -> calcular la merma según la tabla de humedad y poner eso en merma por humedad. En Otras Mermas, poner la diferencia entre el total informado y esta merma calculada
                'Si no hay porcentaje de Humedad informado -> enviar a Otras Mermas el numero informado



                Dim kiloshumedad As Long = 0
                If Rubro = 2 And porcentajehum > 0 Then
                    Dim porcentajemerma = CartaDePorteManager.BuscaMermaSegunHumedadArticulo(SC, cdp.IdArticulo, porcentajehum)
                    kiloshumedad = porcentajemerma / 100 * cdp.NetoFinalAntesDeRestarMermas
                    cdp.Humedad = porcentajehum
                    cdp.HumedadDesnormalizada = kiloshumedad
                End If

                If kilosmerma > 0 And Rubro = 2 Then
                    cdp.Merma = kilosmerma - kiloshumedad
                ElseIf kilosmerma > 0 And Rubro <> 2 Then
                    cdp.Merma = kilosmerma - cdp.HumedadDesnormalizada 'seria bueno acá restar el  cdp.HumedadDesnormalizada ??
                End If


                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





                With cdp
                    Select Case Rubro
                        Case 1 'dañado
                            cdp.NobleDaniados = analisis
                        Case 2

                            cdp.Humedad = porcentajehum

                        Case 3
                            .NobleHectolitrico = analisis
                        Case 4
                            .NobleExtranos = analisis
                        Case 5
                            .NobleQuebrados = analisis
                        Case 7
                            .NoblePicados = analisis



                            '	1	DAÑADO                        	DÑ 
                            '	2	HUMEDAD                       	HD 
                            '	3	PESO HECTOLITRICO             	PH 
                            '	4	MATERIA EXTRAÑA               	C/E 
                            '	5	QUEBRADO.                     	QB 
                            '	6	PARTIDO                       	PAR 
                            '	7	PICADO                        	PIC 


                        Case 8
                            .CalidadPuntaSombreada = analisis
                        Case 9
                            .NobleNegros = analisis
                        Case 10
                            .NobleObjetables = analisis


                            '	8	PUNTA SOMBREADO               	PS 
                            '	9	PUNTA NEGRA                   	PN 
                            '	10	OLORES OBJETABLES             	OL 
                            '	11	SEMILLAS DE TREBOL            	STR 
                            '	12	TIPO	TIP 


                            '	13	COLOR            	COL 
                            '	14	GRANOS AMOHOSADOS            	MH 
                        Case 14
                            .NobleAmohosados = analisis
                            '	15	CHAMICO                       	CHA 
                        Case 15
                            .CalidadMermaChamico = analisis
                            '	16	GRANOS CON CARBON             	GC  
                        Case 16
                            .NobleCarbon = analisis
                            '	17	REVOLCADO TIERRA              	REV 
                            '	18	FUMIGACION PART               	F/P 
                        Case 18
                            .Fumigada = analisis
                            '	19	FUMIGACION CINTA              	F/C 
                            '	24	TEMPERATURA                   	TP 
                            '	25	PROTEINAS                     	PRT 
                            '	26	FONDO                         	FDO 
                            '	27	MERMA CONVENIDA               	MC 
                            '	28	TIERRA                        	TIE

                        Case 27
                            'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=22167
                            cdp.HumedadDesnormalizada = kilosmerma
                        Case 28
                            .CalidadTierra = analisis

                            '	29	AVERIA                        	AVE 
                            '	30	PANZA BLANCA                  	PBA 
                        Case 30
                            .NoblePanzaBlanca = analisis
                            '	31	MERMA TOTAL                   	MT

                            '	32	CUERPOS EXTRAÑOS      	C.E

                            '	33	TOTAL DAÑADOS	TD

                            '	34	QUEBRADOS Y/O CHUZOS	CHU 
                        Case 34
                            .NobleQuebrados = analisis
                            '	38	ARDIDO                        	ARD 
                            '	39	GRANOS VERDES                 	GV
                        Case 39
                            .NobleVerdes = analisis
                            '	40	Humedad y chamicos	H/C 
                        Case 40
                            .CalidadMermaChamico = analisis
                            '	41	P.H. grado y tipo (trigo)	G/T

                            '	42	Grado y color (sorgo)	G/C
                            '	43	Grado tipo y color (ma¡z)	GTC
                            '	44	Análisis completo	A.C
                            '	45	Granos Ardidos y/o Dañados	A/D
                            '	46	Gastos Secada	G.S.
                            '	47	Merma x chamicos	MCH
                            '	48	SILO	SIL
                            '	49	Merma Volatil	MV

                            '	50	Acidez s/Materia Grasa	AMG
                            '	51	Aflatoxinas 	AFL
                            '	52	Arbitraje Otras Causas Calidad Inferior	CAL
                            '	53	Ardidos y Dañados por Calor	ADC
                            '	54	Brotados	BRO

                            '	55	Coloreados y/o con Estrias Roja	CER
                            '	56	Contenido Proteico	C/P
                            '	57	Cornezuelo	COR
                            '	58	Descascarado y Roto	D/R
                            '	59	Enyesados o Muertos	E/M
                            '	60	Esclerotos	ESC
                            '	61	Excremento de Roedores	EXC

                            '	62	Falling Number	FN
                            '	63	Granos Helados	GH
                            '	64	Granos Negros	GN
                            '	65	Granos Otro Color	OCO
                            '	66	Granos Sueltos	GS

                            '	67	Manchados y/o Coloreados	M/C
                            '	68	Materia Grasa S.S.S.	MG
                        Case 68
                            .NobleMGrasa = analisis
                            '	70	Otro Tipo	OT
                            '	71	Quebrados y/o Chuzos	Q/C
                            '	72	Quebrados y/o Partidos	Q/P

                            '	73	Rendimiento de Granos Enteros	EGE

                            '	74	Rendimiento de Granos Quebrados	RGQ
                            '	75	Rendimiento sobre zaranda 6.25 mm	Z62
                            '	76	Rendimiento sobre zaranda 7.5 mm	Z75
                            '	77	Sedimento	SED
                            '	78	Semillas de Bejuco y/o Porotillo	B/P
                            '	79	Total Dañados	TDÑ
                            '	80	Verde Intenso	VIN
                            '	81	GRADO	GRA
                            '	85	Insectos vivos 	INS.V
                            '	502	Granos clorados 	G.CLO
                        Case Else
                            'If False Then txtLogErrores &= "No se pudo importar rubro " & Rubro & vbCrLf
                            'Continue For
                    End Select

                    c += 1


                    LogicaImportador.actualizar(.FechaArribo, txtFechaArribo)
                End With





                'ahhh esta importacion la haces de otra manera.....


                Try
                    Dim ms As String
                    Dim valid = CartaDePorteManager.IsValid(SC, cdp, ms)
                    If InStr(ms, "A.C.A") Then
                        'si se queja porque le falta el acopio, le asigno un default
                        cdp.EnumSyngentaDivision = "OTROS"
                        valid = CartaDePorteManager.IsValid(SC, cdp, ms)
                    End If

                    If CartaDePorteManager.Save(SC, cdp, glbIdUsuario, UserName) = -1 Then
                        txtLogErrores &= "No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf
                        Debug.Print("No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf)
                        ErrHandler2.WriteError("Error al grabar CDP importada")
                        txtLogErrores &= ms
                    Else
                        'dr.Item("URLgenerada") = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)
                    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    txtLogErrores &= "No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf
                    txtLogErrores &= ex.ToString

                End Try
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                txtLogErrores &= ex.ToString
            End Try

        Next







        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)

        'panelEquivalencias.Visible = True
        'MsgBoxAjax(Me, "Análisis Reyser importación terminada") ' . Analisis importados " & c)
        txtLogErrores = "Análisis Reyser importación terminada." & vbCrLf & txtLogErrores
        'txtLogErrores.Visible = True


        Return ds

    End Function



    Public Shared Function Unidad6ToDatasetVersionAnteriorConTabsPlayaPerez_PREFIJO_NROCARTA(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()









        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>

        dr(43) = "OBSERVACIONES"

        'dr(0) = "Prefijo Cp"
        dr(1) = "CARTA PORTE"
        'dr(2) = "Nro Vagon"
        'dr(3) = "Cuit Entregador"
        'dr(4) = "Razon Social Entregador"
        'dr(5) = "Cuit Corredor"

        dr(10) = "CARGADOR"
        'dr(6) = "CUIT"
        dr(14) = "INTERMEDIARIO"
        'dr(8) = "CUIT"
        dr(18) = "REMITENTE COMERCIAL"
        'dr(10) = "CUIT"
        dr(6) = "CORREDOR"

        dr(8) = "DESTINATARIO"
        'dr(20) = "DESTINATARIOCUIT"

        'dr(6) = "Razon Social Corredor"
        'dr(7) = "Cuit Destinatario"
        'dr(8) = "Razon Social Destinatario"
        'dr(9) = "Cuit Titular"
        'dr(10) = "Razon Social Titular"
        'dr(11) = "Nro Planta Oncca Titular"
        'dr(12) = "Descripcion Planta Titular"
        'dr(13) = "Cuit Intermediario"
        'dr(14) = "Razon Social Intermediario"
        'dr(15) = "Nro Planta Oncca Intermediario"
        'dr(16) = "Descripcion Planta Intermediario"
        'dr(17) = "Cuit Remitente C."
        'dr(18) = "Razon Social  Remitente C."
        'dr(19) = "Nro Planta Oncca Remitente C."
        'dr(20) = "Descripcion Planta Remitente C."
        'dr(21) = "Cod Oncca Cereal"
        'dr(22) = "Descrip. Oncca"
        'dr(23) = "Cod Oncca Procedencia"
        'dr(24) = "Descrip. Procedencia"

        'dr(23) = "CHOFER"
        'dr(24) = "CHOFERCUIT"
        dr(22) = "PRODUCTO"

        'problema con esto, porque no viene siempre con la descripcion
        ' U/6 NO LO TERMINE DE PEGAR, MIRA EL PRINT, NO ME PONIA EL PRODUCTO, (NO PUEDO PONERLE CUALQUIERA SIN SABER) INTERMEDIARIO ME 
        'PONE LA FECHA, REMITENTE UN NUMERO, PROCEDENCIA 0000??
        ' https://mail.google.com/mail/u/0/#inbox/13e3c383c5433feb

        dr(24) = "PROCEDENCIA"
        dr(27) = "PATENTE"
        'dr(33) = "ACOPLADO"
        dr(26) = "CONTRATO"
        dr(33) = "OBSERVACIONES"


        'dr(27) = "BRUTO PROC"
        'dr(28) = "TARA PROC"
        dr(25) = "NETO PROC"

        'dr(25) = "Kilos Netos Procedencia"
        'dr(27) = "Patente"
        dr(28) = "TRANSPORTISTA"
        dr(29) = "TRANSPCUIT"
        'dr(28) = "Cuit Transportista"
        'dr(29) = "Razon Social Transportista"
        'dr(30) = "Turno"
        'dr(31) = "Estado"
        dr(32) = "F. DE CARGA"
        'dr(33) = "Observacion"
        'dr(34) = "Hora Entrada"
        'dr(35) = "Cod Puerto"
        'dr(36) = "Medio"
        'dr(37) = "Kilos Netos Descargados"
        'dr(38) = "Tipo"
        'dr(39) = "Fecha Descarga"
        dr(39) = "F. DE DESCARGA"
        'dr(40) = "Calidad"
        dr(40) = "CALIDAD"
        'dr(41) = "Hora Salida"
        'dr(42) = "Bruto Descarga"
        'dr(43) = "Tara Descarga"
        dr(42) = "BRUTO PTO"
        dr(43) = "TARA PTO"
        'dr() = "MERMA"
        dr(37) = "NETO PTO"

        dr(44) = "RECIBO"


        dr(1) = "CARTA PORTE"
        'dr(2) = "VAGON"
        dr(30) = "TURNO"
        'dr(4) = "CTG"


        dt.Rows.Add(dr)





        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {vbTab, ";"}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler2.WriteError("Line " & ex.ToString & " is invalid.  Skipping")
                End Try
            End While
        End Using


        For Each r In dt.Rows
            'transformar columna de calidad
            '1 = CO; 2 = CC; 3 = G1; 4 = G2; 5 = G3; 6 = FE
            Try

                If Val(r(1)) = 0 Then Continue For

                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))

                r(40) = CodigoCalidad(Val(r(40)))


            Catch ex As Exception

            End Try


        Next



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds





        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


    End Function



    'Public Shared Function GetExcel4(ByVal filePath As String, Optional ByVal workSheetName As String = "") As DataTable



    '    Dim stream As FileStream = File.Open(filePath, FileMode.Open, FileAccess.Read)

    '    '1. Reading from a binary Excel file ('97-2003 format; *.xls)
    '    Dim excelReader As Excel.IExcelDataReader = Excel.ExcelReaderFactory.CreateBinaryReader(stream)

    '    '2. Reading from a OpenXml Excel file (2007 format; *.xlsx)
    '    'Dim excelReader As Excel.IExcelDataReader = ExcelReaderFactory.CreateOpenXmlReader(stream)

    '    '3. DataSet - The result of each spreadsheet will be created in the result.Tables
    '    Dim result As DataSet = excelReader.AsDataSet()

    '    ''4. DataSet - Create column names from first row
    '    'excelReader.IsFirstRowAsColumnNames = True
    '    'Dim result As DataSet = excelReader.AsDataSet()

    '    ''5. Data Reader methods
    '    'While excelReader.Read()
    '    '    'excelReader.GetInt32(0);
    '    'End While

    '    '6. Free resources (IExcelDataReader is IDisposable)
    '    excelReader.Close()


    'End Function





    Public Shared Function GetExcel2_ODBC(ByVal fileName As String, Optional ByVal workSheetName As String = "") As DataTable


        ''https://stackoverflow.com/questions/3469368/how-to-handle-accessviolationexception
        '            In .NET 4.0, the runtime handles certain exceptions raised as Windows Structured Error Handling (SEH) errors as indicators 
        '            of Corrupted State. These Corrupted State Exceptions (CSE) are Not allowed to be caught by your standard managed code. I won't get
        '            into the why's or how's here


        'Application: ProntoAgente.exe
        '        Framework Version: v4.0.30319
        'Description: The Process was terminated due to an unhandled exception.
        'Exception Info: System.AccessViolationException
        'Stack:
        '        at System.Data.OleDb.DataSourceWrapper.InitializeAndCreateSession(System.Data.OleDb.OleDbConnectionString, System.Data.OleDb.SessionWrapper ByRef)
        '   at System.Data.OleDb.OleDbConnectionInternal..ctor(System.Data.OleDb.OleDbConnectionString, System.Data.OleDb.OleDbConnection)
        '   at System.Data.OleDb.OleDbConnectionFactory.CreateConnection(System.Data.Common.DbConnectionOptions, System.Data.Common.DbConnectionPoolKey, System.Object, System.Data.ProviderBase.DbConnectionPool, System.Data.Common.DbConnection)
        '   at System.Data.ProviderBase.DbConnectionFactory.CreateConnection(System.Data.Common.DbConnectionOptions, System.Data.Common.DbConnectionPoolKey, System.Object, System.Data.ProviderBase.DbConnectionPool, System.Data.Common.DbConnection, System.Data.Common.DbConnectionOptions)
        '   at System.Data.ProviderBase.DbConnectionFactory.CreateNonPooledConnection(System.Data.Common.DbConnection, System.Data.ProviderBase.DbConnectionPoolGroup, System.Data.Common.DbConnectionOptions)
        '   at System.Data.ProviderBase.DbConnectionFactory.TryGetConnection(System.Data.Common.DbConnection, System.Threading.Tasks.TaskCompletionSource`1<System.Data.ProviderBase.DbConnectionInternal>, System.Data.Common.DbConnectionOptions, System.Data.ProviderBase.DbConnectionInternal ByRef)
        '   at System.Data.ProviderBase.DbConnectionClosed.TryOpenConnection(System.Data.Common.DbConnection, System.Data.ProviderBase.DbConnectionFactory, System.Threading.Tasks.TaskCompletionSource`1<System.Data.ProviderBase.DbConnectionInternal>, System.Data.Common.DbConnectionOptions)
        '   at System.Data.ProviderBase.DbConnectionInternal.OpenConnection(System.Data.Common.DbConnection, System.Data.ProviderBase.DbConnectionFactory)
        '   at System.Data.OleDb.OleDbConnection.Open()
        '   at ExcelImportadorManager.GetExcel2_ODBC(System.String, System.String)
        '   at ExcelImportadorManager.UrenportExcelToDataset(System.String, System.String)
        '   at ExcelImportadorManager.FormatearExcelImportadoEnDLL(Int32 ByRef, System.String, FormatosDeExcel, System.String, Int32, System.String ByRef, System.String, Int32, System.String)
        '   at ProntoWindowsService.Service1.TandaPegatinas(System.String, System.String, System.String)
        '   at ProntoWindowsService.Service1.DoWorkSoloPegatinas()
        '   at System.Threading.ThreadHelper.ThreadStart_Context(System.Object)
        '   at System.Threading.ExecutionContext.RunInternal(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object, Boolean)
        '   at System.Threading.ExecutionContext.Run(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object, Boolean)
        '   at System.Threading.ExecutionContext.Run(System.Threading.ExecutionContext, System.Threading.ContextCallback, System.Object)
        '   at System.Threading.ThreadHelper.ThreadStart()







        'http://stackoverflow.com/questions/9943065/the-microsoft-ace-oledb-12-0-provider-is-not-registered-on-the-local-machine
        'http://stackoverflow.com/questions/9943065/the-microsoft-ace-oledb-12-0-provider-is-not-registered-on-the-local-machine
        'http://stackoverflow.com/questions/9943065/the-microsoft-ace-oledb-12-0-provider-is-not-registered-on-the-local-machine

        'http://stackoverflow.com/questions/15828/reading-excel-files-from-c-sharp
        'Dim connectionString As String = String.Format("Provider=Microsoft.Jet.OLEDB.4.0; data source={0}; Extended Properties=Excel 8.0;", fileName)

        'http://social.msdn.microsoft.com/Forums/es/vbes/thread/b62c5037-0695-445b-97ba-f573073ea840
        Dim connectionString As String = String.Format("Provider=Microsoft.ACE.OLEDB.12.0; data source={0}; Extended Properties=Excel 12.0;", fileName)


        'Dim connectionString As String = String.Format("Provider=Microsoft.Jet.OLEDB.4.0; data source={0}; Extended Properties=""Excel 8.0;HDR=YES;""", fileName)


        Using conn = New OleDbConnection(connectionString)

            Try
                conn.Open()

                '        // es precisamente así:
                '/*
                ' * http://stackoverflow.com/questions/1139390/excel-external-table-is-not-in-the-expected-format
                ' * Just add my case. My xls file was created by a data export function from a website, the file extention is xls, 
                'it can be normally opened by MS Excel 2003. But both Microsoft.Jet.OLEDB.4.0 and Microsoft.ACE.OLEDB.12.0 got 
                '    an "External table is not in the expected format" exception.
                '        Finally, the problem is, just as the exception said, "it's not in the expected format". Though 
                '    it() 's extention name is xls, but when I open it with a text editor, it is actually a well-formed html file, 
                'all data are in a <table>, each <tr> is a row and each <td> is a cell. Then I think I can parse it in a html way.
                '*/

                ErrHandler2.WriteError("Leyo bien con Microsoft.ACE.OLEDB")
            Catch ex As System.Data.OleDb.OleDbException


                'si tira ""External table is not in the expected format." typically occurs when trying to use an Excel 2007 file with a connection string that uses: Microsoft.Jet.OLEDB.4.0 and Extended Properties=Excel 8.0"
                '"External table is not in the expected format." typically occurs when trying to use an Excel 2007 file with 
                'a Connection string that uses: Microsoft.Jet.OLEDB0.4.0 And Extended Properties=Excel 8.0

                ErrHandler2.WriteError("Falló con Microsoft.ACE.OLEDB. Pruebo con Microsoft.Jet.OLEDB")

                'http://stackoverflow.com/questions/1139390/excel-external-table-is-not-in-the-expected-format
                Dim connectionString2 As String = String.Format("Provider=Microsoft.Jet.OLEDB.4.0; data source={0}; Extended Properties=""Excel 8.0;HDR=YES;""", fileName)

                'conn = New OleDbConnection(connectionString2) 'no hagas esta asignacion. creá OTRA variable. creo 
                '                                               q explota AccessViolationException por eso -explotó acá? o explotó en la primera llamada? porque este 
                '                                               catch captura otra excepcion
                'conn.Open()

                Dim conn2 = New OleDbConnection(connectionString2)
                conn2.Open()

                ErrHandler2.WriteError("Leyo bien con Microsoft.Jet.OLEDB")

                Return Nothing
                'Throw
            End Try





            If workSheetName = "" Then
                Dim dtSchema = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, New Object() {Nothing, Nothing, Nothing, "TABLE"})
                workSheetName = dtSchema.Rows(0)("TABLE_NAME")
                workSheetName = workSheetName.Replace("$", "").Replace("'", "")
            End If





            'Connection = new OleDbConnection(string.Format((Spreadsheet.EndsWith(".xlsx") ?
            '          "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0}; Extended Properties=Excel 12.0;" :
            '          "Provider=Microsoft.Jet.OLEDB.4.0; data source={0}; Extended Properties=Excel 8.0;"), Spreadsheet));



            Try


                Dim adapter = New Data.OleDb.OleDbDataAdapter("SELECT * FROM [" & workSheetName & "$]", conn)
                Dim ds As DataSet = New DataSet()

                adapter.Fill(ds, "anyNameHere")

                Dim data = ds.Tables("anyNameHere")
                Return data
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                MandarMailDeError("error getExcel2. Existe esa hoja? Si es el 'OleDbException Unspecified error', REINICIÁ el IIS, parece que es por eso.   Es por usar impersonation?  Uso Jet o ACE?????   archivo:" & fileName & "," & workSheetName & "                " & ex.ToString)
                'error al hacer el fill? Uso Jet o ACE?????






                'My(experience)  In production servers the OleDb components loaded on 
                'ASP.NET worker process seems to missfunction ocassionally. Restarting the IIS the problem will go away.
                '---------------------------------------------------

                '        Error Message : System.Data.OleDb.OleDbException()
                'Unspecified error
                '   at System.Data.OleDb.OleDbConnectionInternal..ctor(OleDbConnectionString constr, OleDbConnection connection)
                '   at System.Data.OleDb.OleDbConnectionFactory.CreateConnection(DbConnectionOptions options, Object poolGroupProviderInfo, DbConnectionPool pool, DbConnection owningObject)



                'My(experience)  In production servers the OleDb components loaded on 
                'ASP.NET worker process seems to missfunction ocassionally. Restarting the IIS the problem will go away.
                '---------------------------------------------------

                'Efectivamente! reinicie el iis y ahora anda. Pero es tambien porque antes ya habia cambiado el impersonate a false???
                'http://forums.asp.net/t/314899.aspx?System+Data+OleDb+OleDbException+Unspecified+error
                'solved. this has to do with impersonation. in web.config, i set impersonate back to false and it works. i read 
                'in another article on this forum that because when .net reads an excel file, it creats a temp folder to store the data
                ', and that temp folder can only be access by the ASPNET account. so if you impersonate as another user on the computer / network and 
                '    tried to use ASPNET to read the data in the excel file, you will not be able to.
                '---------------------------------------------------

                '            i think the point here is that the asp.net user are not able to create files
                'in the temporary folder!
                'you can go to the temp folder ( ex. Document settings\servername\aspnet\)
                'and there on the temp folder give the full right access for the asp.net
                'user. i hope this may solve the problem
                '--------------------------
                'Changing (actually inserting) the <identity impersonate="false" /> has fixed it.
                '------------------------------------



                Throw
            End Try


        End Using



    End Function




    Public Shared Function GetExcel(ByVal fileName As String, Optional ByVal SheetNumero As Integer = 1) As DataSet
        'traido de http://www.devcurry.com/2009/07/import-excel-data-into-aspnet-gridview_06.html


        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml



        Dim oXL As Excel.Application
        Dim oWB As Excel.Workbook
        Dim oSheet As Excel.Worksheet
        Dim oRng As Excel.Range
        Dim oWBs As Excel.Workbooks

        Try

            '  creat a Application object
            'http://stackoverflow.com/questions/2483659/interop-type-cannot-be-embedded  'no está el nodo References en VB (sí en C#), así que uso la segunda opcion
            oXL = New Excel.Application()
            'oXL = New Excel.ApplicationClass()


            '   get   WorkBook  object
            oWBs = oXL.Workbooks


            Try
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                oWB = oWBs.Open(fileName, Missing.Value, Missing.Value,
    Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value,
    Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value,
    Missing.Value, Excel.XlCorruptLoad.xlExtractData)

                'http://stackoverflow.com/questions/9062823/exception-when-opening-excel-file-in-c-sharp-using-interop?noredirect=1&lq=1


            Catch ex As Exception

                'problemas al abrir T6

                ' http://www.made4dotnet.com/Default.aspx?tabid=141&aid=15
                'http://stackoverflow.com/questions/493178/excel-programming-exception-from-hresult-0x800a03ec-at-microsoft-office-inter


                '  Otro  problema mas con T6!!!!!!!
                'importacion de excel de Terminal6 hace tildar el sitio. Office automation, macros.....  
                '-Había un vinculo a "Camiones demorados.xls". Era eso? -es que eso lo revisa por la seguridad...  -Podes reemplazar el GetExcel????




                'If Exception=HRESULT: 0x800A03EC 

                '        Try
                '            SetNewCurrentCulture()
                '            oWB = oWBs.Open(fileName, Missing.Value, Missing.Value, _
                'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
                'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
                'Missing.Value, Missing.Value)

                '        Catch ex2 As Exception
                '            Throw
                '        Finally
                '            ResetCurrentCulture()
                '        End Try

                ErrHandler2.WriteError(fileName + "  No pudo extraer el excel. INCREIBLE: en 2008, en el directorio  C:\Windows\SysWOW64\config\systemprofile\ hay que crear una carpeta Desktop!!!!!!!!!!!!!!!!!!!!!  " + ex.ToString)


            End Try

            'dejé de usar .Sheets
            oSheet = CType(oWB.Worksheets(SheetNumero), Microsoft.Office.Interop.Excel.Worksheet)
            '   get   WorkSheet object
            'Try
            '    'dejé de usar .Sheets 'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
            '    oSheet = CType(oWB.Sheets(SheetNumero), Microsoft.Office.Interop.Excel.Worksheet)
            'Catch ex As Exception
            '    'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
            '    oSheet = CType(oWB.Worksheets(SheetNumero), Microsoft.Office.Interop.Excel.Worksheet)
            'End Try


            Dim dt As New Data.DataTable("dtExcel")

            '  creo las columnas
            For j As Integer = 1 To MAXCOLS
                dt.Columns.Add("column" & j,
                               System.Type.GetType("System.String"))
            Next j


            Dim ds As New DataSet()
            ds.Tables.Add(dt)
            Dim dr As DataRow

            Const MAXFILASEXCEL = 500

            Dim sb As New StringBuilder()
            Dim iValue As Integer = IIf(oSheet.UsedRange.Cells.Rows.Count > MAXFILASEXCEL, MAXFILASEXCEL, oSheet.UsedRange.Cells.Rows.Count)
            If iValue = MAXFILASEXCEL Then
                ' Throw New Exception("Limite de renglones importables del Excel")
                ErrHandler2.WriteError("Limite de renglones importables del Excel")
            End If



            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '  get data in cell
            'copio los datos nomás
            For i As Integer = 1 To iValue
                dr = ds.Tables("dtExcel").NewRow()

                For j As Integer = 1 To MAXCOLS

                    'traigo la celda y la pongo en una variable Range (no sé por qué)
                    oRng = CType(oSheet.Cells(i, j), Microsoft.Office.Interop.Excel.Range)



                    'Range.Text << Formatted value - datatype is always "string"
                    'Range.Value << actual datatype ex: double, datetime etc
                    'Range.Value2 << actual datatype. slightly different than "Value" property.

                    If IsNumeric(oRng.Value) Then 'me fijo si es numerica, por el asuntillo de la coma
                        dr("column" & j) = oRng.Value
                    Else

                        Dim strValue As String = oRng.Text.ToString() 'acá como la convertís a string, estás trayendo la coma...
                        dr("column" & j) = Left(strValue, 50)
                    End If



                Next j

                ds.Tables("dtExcel").Rows.Add(dr)
            Next i
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////


            Return ds


        Catch ex As Exception
            ErrHandler2.WriteError("No pudo extraer el excel. " + ex.ToString)
            Return Nothing


            '            1. In DCOMCNFG, right click on the My Computer and select properties.
            '2. Choose the COM Securities tab
            '3. In Access Permissions, click "Edit Defaults" and add Network Service to it and give it "Allow local access" permission. Do the same for <Machine_name>
            '  \Users.
            '  4. In launch and Activation Permissions, click "Edit Defaults" and add Network Service to it and give it "Local launch" and "Local Activation" permission. Do the same for <Machine_name>
            '    \Users
            '   Press OK and thats it. i can run my application now
        Finally
            Try
                'The service (excel.exe) will continue to run
                If Not oWB Is Nothing Then oWB.Close(False)
                NAR(oWB)
                oWBs.Close()
                NAR(oWBs)
                'quit and dispose app
                oXL.Quit()
                NAR(oXL)
                'VERY IMPORTANT
                GC.Collect()

                'Dispose()  'este me arruinaba todo, me hacia aparecer el cartelote del Prerender
            Catch ex As Exception
                ErrHandler2.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
            End Try
        End Try
    End Function








    Public Shared Function FormatearExcelImportadoEnDLL(ByRef m_IdMaestro As Integer, archivoExcel As String, cmbFormato As System.Web.UI.WebControls.DropDownList,
                                                        SC As String,
         cmbPuntoVenta As System.Web.UI.WebControls.DropDownList, txtLogErrores As System.Web.UI.WebControls.TextBox, txtFechaArribo As System.Web.UI.WebControls.TextBox, glbIdUsuario As Integer, UserName As String) As Integer







        FormatearExcelImportadoEnDLL(m_IdMaestro, archivoExcel, LogicaImportador.FormatoDelArchivo(archivoExcel, cmbFormato), SC, cmbPuntoVenta.SelectedValue, txtLogErrores.Text, txtFechaArribo.Text, glbIdUsuario, UserName)


    End Function




    Public Shared Function FormatearExcelImportadoEnDLL(ByRef m_IdMaestro As Integer, archivoExcel As String, Formato As LogicaImportador.FormatosDeExcel,
                                                     SC As String,
      cmbPuntoVenta As Integer, ByRef txtLogErrores As String, txtFechaArribo As String, glbIdUsuario As Integer, UserName As String) As Integer

        'FormatearExcelImportadoEnDLL()

        Dim ds As DataSet




        'http://stackoverflow.com/questions/938291/import-csv-file-into-c
        'http://stackoverflow.com/questions/938291/import-csv-file-into-c


        'Identificar el formato

        Select Case Formato
            Case Nidera

                ds = NideraToDataset(archivoExcel)

            Case CerealnetToepfer
                ds = ReyserToDataset(archivoExcel)
            Case Reyser
                ds = ReyserToDataset(archivoExcel)

            Case ReyserCargillPosicion
                ds = ReyserToDataset(archivoExcel)
                'to do
            Case Reyser2
                ds = ReyserToDataset(archivoExcel)

            Case ReyserAnalisis
                ds = ReyserCalidadesToDataset(archivoExcel, SC, cmbPuntoVenta, txtLogErrores, txtFechaArribo, glbIdUsuario, UserName)

                '/////////////////////
            Case Unidad6
                ds = Unidad6ToDataset_CUITTIT_CUITCORR_EstadoPosicion_NoEsDescarga_SeparadoConPuntoYComa(archivoExcel)

            Case Unidad6Prefijo_NroCarta
                ds = Unidad6ToDatasetVersionAnteriorConTabsPlayaPerez_PREFIJO_NROCARTA(archivoExcel)

            Case Unidad6Analisis
                ds = Unidad6CalidadesToDataset(archivoExcel, SC, cmbPuntoVenta, txtLogErrores, txtFechaArribo, glbIdUsuario, UserName)



            Case BungeRamalloDescargaTexto
                ds = BungeRamalloDescargaTextoToDataset(archivoExcel, SC)


            Case PuertoACA
                'formato CSV
                ds = LogicaImportador.PuertoACAToDataset(archivoExcel)
                'TODO: no muestra la vista previa si usa el formato de PuertoACA 


            Case AdmServPortuarios
                Return -1

            Case ToepferPtoElTransito
                ds = GetExcel(archivoExcel, 3) 'hoja 3

            Case Toepfer
                ds = GetExcel(archivoExcel, 1)

            Case CargillPlantaQuebracho, CargillPtaAlvear
                ds = GetExcel(archivoExcel, 1) 'hoja 1


            Case Urenport
                ds = UrenportExcelToDataset(archivoExcel, SC)
                Return ds.Tables(0).Rows.Count

            Case Else
                ds = GetExcel(archivoExcel)


        End Select


        If ds Is Nothing Then Return -1



        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////


        Dim dtOrigen = ds.Tables(0)

        Dim dtDestino As Data.DataTable = TablaFormato(SC)

        Dim row As DataRow




        'busco el renglon de titulos

        Dim renglonDeTitulos As Integer
        If Formato = Unidad6 Then
            renglonDeTitulos = 0 'la pegatina de Unidad6 no tiene renglon de títulos
        Else
            renglonDeTitulos = RenglonTitulos(dtOrigen, archivoExcel, Formato)
        End If




        'Debug.Assert(renglonDeTitulos >= 0, "No se encontró el renglon de titulos de columnas")

        'creo espacio para los renglones
        For i = 1 To dtOrigen.Rows.Count
            dtDestino.Rows.Add(dtDestino.NewRow)
        Next



        '        Log Entry
        '02/25/2016 00:49:39
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:No se encontró el renglon de titulos. Renglones totales:49
        '        __________________________()

        '        Log Entry
        '02/25/2016 00:49:39
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:System.IndexOutOfRangeException
        'There is no row at position -1.
        '   at System.Data.RBTree`1.GetNodeByIndex(Int32 userIndex)
        '   at System.Data.DataRowCollection.get_Item(Int32 index)
        '   at ExcelImportadorManager.FormatearExcelImportadoEnDLL(Int32& m_IdMaestro, String archivoExcel, FormatosDeExcel Formato, String SC, Int32 cmbPuntoVenta, String& txtLogErrores, String txtFechaArribo, Int32 glbIdUsuario, String UserName) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\ManagerDebug\CartaDePorteManager.vb:line 25869
        '   at CartasDePorteImportador.FormatearExcelImportado(String nombre)
        '   at CartasDePorteImportador.btnVistaPrevia_Click(Object sender, EventArgs e)
        '        System.Data()
        '        ________________()


        If renglonDeTitulos = -1 Then
            Throw New Exception("No se encontró el renglon de titulos. Falta elegir el formato del archivo?")
        ElseIf renglonDeTitulos > dtOrigen.Rows.Count - 1 Then
            Throw New Exception("No se encontró el renglon de titulos. Falta elegir el formato del archivo?")
        End If

        row = dtOrigen.Rows(renglonDeTitulos)




        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        ' EXCEPCIONES preHermanado

        ExcepcionTerminal6_UnirColumnasConPatente(dtOrigen, renglonDeTitulos)


        FormatearColumnasFlexicapture(dtOrigen)


        'excepcion BUNGE / RAMALLO: calidades en minicolumnas improvisadas para cada renglon
        '-pero esto no tiene que estar en postproduccion, sino en preproduccion
        If Formato = BungeRamallo Or Formato = Unidad6Prefijo_NroCarta Then
            FormatearColumnasDeCalidadesRamallo(dtOrigen)
            'FormatearColumnasDeCalidadesRamallo()
        End If




        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////
        'HERMANADO
        'matchear las columnas en los renglones normales
        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////

        Dim errorEncabezadoTag As String = ""

        Dim f = Formato

        For i = dtOrigen.Columns.Count - 1 To 0 Step -1

            Dim col = row.Item(i).ToString.ToUpper
            Dim coldest = HermanarLeyendaConColumna(col, archivoExcel, i, f)
            If coldest <> "" Then

                For r = 0 To dtOrigen.Rows.Count - 1
                    dtDestino.Rows(r).Item(coldest) = dtOrigen.Rows(r).Item(i)
                    'Debug.Print(dtOrigen.Rows(r).Item(i), dtDestino.Rows(r).Item(coldest))
                Next

                'CopyColumns(dtOrigen, dtOrigen.Columns(i).ColumnName, dtDestino, coldest)
                'dtDestino(HermanarLeyendaConColumna(col)) = dtOrigen.Columns(col)

            Else
                errorEncabezadoTag &= "[" & col & "]"
            End If
        Next



        If errorEncabezadoTag <> "" Then
            ErrHandler2.WriteError("Los encabezados de columna " & errorEncabezadoTag & " no son reconocidos. " &
                                  "Cambielos por los estándar. Ya ha sido enviado un mail notificando la incongruencia.")
        End If



        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        'Traigo los que se repiten en el encabezado
        'GUARDA!!! si lo haces despues de los renglones, podes llegar a pisar una columna que esté 
        'suelta y tambien en columnas
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////


        Dim fa = Formato

        For j = renglonDeTitulos - 1 To 0 Step -1
            row = dtOrigen.Rows(j)
            Debug.Print(row.Item("column1").ToString.ToUpper) 'Producto - >columna 1
            Dim col = Trim(row.Item("column1").ToString.ToUpper)

            Dim coldest = HermanarLeyendaConColumna(col, , , fa) 'cómo hago con el caso de "subcontratistas", que tiene 2 columnas de destino?

            If coldest = "Subcontratistas" Then

                For i = renglonDeTitulos + 1 To dtOrigen.Rows.Count - 1 'lo copio en todas las filas
                    If IsNull(dtDestino.Rows(i).Item("Subcontratista1")) Then
                        dtDestino.Rows(i).Item("Subcontratista1") = row.Item("column2").ToString 'Titular -> columna 2
                        dtDestino.Rows(i).Item("Subcontratista2") = row.Item("column2").ToString 'Titular -> columna 2
                    End If
                Next i

            Else

                If coldest <> "" Then

                    For i = renglonDeTitulos + 1 To dtOrigen.Rows.Count - 1 'lo copio en todas las filas
                        If IsNull(dtDestino.Rows(i).Item(coldest)) Then
                            dtDestino.Rows(i).Item(coldest) = row.Item("column2").ToString 'Titular -> columna 2
                        End If
                    Next i

                End If

            End If

        Next

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'EXCEPCIONES post produccion
        'Copia de celdas vacias con lo que dice la celda superior
        'Intuyo que todo procesamiento es mejor que venga despues del hermanado, y no antes.
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        'Excepcion de un caso raro...
        If InStr(archivoExcel.ToUpper, "BUNGE") Or
           InStr(archivoExcel.ToUpper, "CARGILL") Then
            RellenarCeldaVaciaConCeldaSuperior(dtDestino)
        End If


        Select Case Formato

            Case BungeRamallo
                'remapeos de clientes
                ReasignoTitularCOrdenETC(dtDestino)

            Case Nidera
                'remapeos de clientes
                ReasignoTitularCOrdenETC_Nidera(dtDestino)

            Case Reyser 'incluir las demás de cargill?  http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13568
                ReasignoExportacion_CerealnetParaCargill(dtDestino)
            Case Reyser2 'incluir las demás de cargill?  http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13568
                ReasignoExportacion_CerealnetParaReyser(dtDestino)
            Case Unidad6 'posicion, playa perez
                ReasignoExportacion_Unidad6PlayaPerez(dtDestino)

            Case CerealnetToepfer
                ReasignoExportacion_CerealnetParaToepfer(dtDestino)

            Case ReyserCargillPosicion
                DejarSoloDatosDePosicion(dtDestino)


            Case Else

        End Select



        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////

        'saco renglones sin numero de carta de porte
        Dim renglonesOriginales = dtDestino.Rows.Count


        For j = dtDestino.Rows.Count - 1 To 0 Step -1
            row = dtDestino.Rows(j)

            If Not IsDBNull(row.Item("Auxiliar4")) Then
                If row.Item("Auxiliar4").ToString() <> "" And row.Item("Auxiliar4").ToString() <> "ColumnaAdicional" Then
                    Continue For
                End If
            End If

            If IsDBNull(row.Item("NumeroCDP")) Then
                dtDestino.Rows.Remove(row)
                Continue For
            End If

            If Not IsNumeric(Replace(row.Item("NumeroCDP"), "-", "")) Then
                dtDestino.Rows.Remove(row)
            End If
        Next


        If dtDestino.Rows.Count = 0 Then
            ErrHandler2.WriteError("renglones antes de revisar numero de cartadeporte:" & renglonesOriginales & " Renglones despues:" & dtDestino.Rows.Count)

            If Debugger.IsAttached Then Stop
        End If
        'Debug.Assert(dtDestino.Rows.Count > 0, "Importacion vacía")




        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        'saco renglones que son de los colegas de Williams (excepto para NobleLima)

        Dim renglonesAntesDeFiltrarPorWilliams = dtDestino.Rows.Count

        If Formato <> NobleLima And Formato <> Renova Then

            For j = dtDestino.Rows.Count - 1 To 0 Step -1
                row = dtDestino.Rows(j)

                If IsDBNull(row.Item("EntregadorFiltrarPorWilliams")) Then
                    Continue For
                End If

                If row.Item("EntregadorFiltrarPorWilliams") = "" Then
                    Continue For
                End If

                If Not InStr(row.Item("EntregadorFiltrarPorWilliams").ToString.ToUpper, "WILLIAMS") > 0 And
                    row.Item("EntregadorFiltrarPorWilliams").ToString.ToUpper <> "WE" Then
                    dtDestino.Rows.Remove(row)
                End If
            Next
        End If


        If dtDestino.Rows.Count = 0 Then
            ErrHandler2.WriteError("Filtrando renglones de colegas.  renglones antes de revisar numero de cartadeporte:" & renglonesAntesDeFiltrarPorWilliams & " Renglones despues:" & dtDestino.Rows.Count)

            If Debugger.IsAttached Then Stop
            'MsgBoxAjax(Me, "No se pudieron importar filas")
        End If


        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////


        'DatatableToViewstate(dtOrigen)




        Randomize()
        m_IdMaestro = Int(Rnd() * 200000) 'Guid.NewGuid().ToString())


        ExecDinamico(SC, String.Format("DELETE  ExcelImportador  WHERE {1}={0}", m_IdMaestro, "IdTanda"))
        '      ExcelImportadorManager.Delete(SC, m_IdMaestro)
        verificarQueNoSeRepiteElIdMaestro()




        Try
            GrabaExcelEnBase(dtDestino, SC, m_IdMaestro)

        Catch ex As Exception
            ErrHandler2.WriteError("Error al llamar GrabaExcelEnBase")
            ErrHandler2.WriteAndRaiseError(ex)
        End Try

        Return dtDestino.Rows.Count
        'gvExcel.DataSource = dtOrigen
        'gvExcel.DataBind()

        'gvClientes.DataSource = ds
        'gvClientes.DataBind()

    End Function



    Public Shared Function GrabaExcelEnBase(ByVal dtExcel As Data.DataTable, SC As String, ByRef m_IdMaestro As Integer) As Integer

        'Dim dtBase = ExcelImportadorManager.TraerMetadataPorIdMaestro(SC, -1) ' m_IdMaestro


        'Dim nombres(dtExcel.Columns.Count) As String
        'For c = 0 To dtExcel.Columns.Count - 1
        '    nombres(c) = dtExcel.Columns(c).ColumnName
        'Next
        'Dim snombres As String = Join(nombres, "|")


        For Each drExcel As DataRow In dtExcel.Rows

            '    Dim drBase = dtBase.NewRow()

            '    drBase("IdTanda") = m_IdMaestro
            '    drBase("Observaciones") = snombres
            drExcel("IdTanda") = m_IdMaestro

            '    For c As Integer = 0 To dtExcel.Columns.Count - 1
            '        drBase("Excel" & (c + 1)) = Left(iisNull(drExcel(c)), 50)
            '    Next


            '    dtBase.Rows.Add(drBase)
        Next


        ExcelImportadorManager.Insert(SC, dtExcel) 'En el bulk, del maestro solo hago insert. Del detalle sí hago update

        'todo: limpiar con este
        'ExcelImportadorManager.BorrarRegistrosViejos()
    End Function


    Public Shared Sub verificarQueNoSeRepiteElIdMaestro()

    End Sub

    Public Shared Sub FormatearColumnasDeCalidadesRamallo(ByRef dt As Data.DataTable)


        'excepcion BUNGE / RAMALLO: calidades en minicolumnas improvisadas para cada renglon
        '-pero esto no tiene que estar en postproduccion, sino en preproduccion

        '        HUMEDAD()
        'MERMA X HUMEDAD
        '        OTRAS(MERMAS)
        '        OBSERVACIONES()

        'tener en cuenta que en la columna de merma del exel el primer numero es la MERMA X HUMEDAD / las otras 2 sumadas van en OTRAS MERMAS
        '        ssss()






        'en efecto, estás harcodeando el numero de columna....

        Dim columnamerma As Integer = 16 '15
        Dim colHumedad As Integer = 17 ' 16
        Dim colRubros As Integer = 21 '17
        'no tengo manera de saber donde empiezan los rubros/calidades: en la nueva vienen en la columna "V", antes 


        For c = 0 To dt.Columns.Count - 1 'empiezo en 2 para no pisar los encabezados... .no sé en qué renglon vendran
            Dim nomb = dt.Rows(1).Item(c).ToString.ToUpper.Trim   'dt.Columns(c).ColumnName.ToUpper.Trim

            'If nomb = "MMA" Then columnamerma = c
            If nomb = "HUM" Then
                colHumedad = c
            End If

            'If nomb = "HUM" Then colRubros = c
        Next





        dt.Columns.Add("MERMAXHUMEDAD")
        dt.Rows(0).Item("MERMAXHUMEDAD") = "MERMA"
        dt.Rows(1).Item("MERMAXHUMEDAD") = "MERMA"

        dt.Columns.Add("OBSERVACIONES")
        dt.Rows(0).Item("OBSERVACIONES") = "OBSERVACIONES"
        dt.Rows(1).Item("OBSERVACIONES") = "OBSERVACIONES"

        dt.Columns.Add("OTRASMERMAS")
        dt.Rows(0).Item("OTRASMERMAS") = "OTRASMERMAS"
        dt.Rows(1).Item("OTRASMERMAS") = "OTRASMERMAS"

        'ahora, los de Bunge no juntan más en la columna de mermas (usando una "/") las distintas mermas. ahora solo ponen
        'un numero en esa columna, y la merma de los rubros la ponen en una columna adyacente a cada rubro.


        Dim mermaxhumedad As Long
        Dim otrasmermas As Long

        For r = 2 To dt.Rows.Count - 1 'empiezo en 2 para no pisar los encabezados... .no sé en qué renglon vendran

            Dim dr As DataRow = dt.Rows(r)


            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'este era el metodo para cuando nos daban las calidades ensanguchadas en una columna

            Dim celdamerma As String = dr.Item(columnamerma)
            Try
                mermaxhumedad = 0
                otrasmermas = 0
                Dim mermas() = Split(celdamerma, "/")
                If mermas.Length > 0 Then mermaxhumedad = Val(mermas(0))
                If mermas.Length > 1 Then
                    otrasmermas = Val(mermas(1))
                End If
                If mermas.Length > 2 Then
                    otrasmermas = Val(mermas(1)) + Val(mermas(2))
                End If
                dr.Item(columnamerma) = mermaxhumedad
                'tengo que agregar otra columna en el importador para las "otras mermas"
                dr.Item("MERMAXHUMEDAD") = mermaxhumedad
                dr.Item("OTRASMERMAS") = otrasmermas
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try



            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'este es el nuevo metodo, donde las calidades tienen 2 columnas cada una (la primera su nombre y %, la segunda su merma)




            Dim obs As String = ""
            Dim otrasmermascalc As Long = 0
            For c = colRubros To colRubros + 10 Step 2

                Try
                    obs &= dr.Item(c).ToString & " "
                    '                    http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9841
                    '                    Lo que debe ir en observaciones es la concatenación de las tres columnas de rubros, por ejemplo:

                    'HUM 14,50	C.Ex. 01,50	Rev 00,50
                Catch ex As Exception

                End Try

                Try


                    Dim celda As String = dr.Item(c)
                    Dim pos As Integer = InStr(celda.ToUpper, "HUM ") '    DyR  / Gr.Amoh / Rev / C.Ex.
                    If pos > 0 Then
                        Dim calidad As Double = Val(Mid(celda, pos + 3).Replace(",", "."))

                        ' dr.Item("HUMEDAD") = calidad
                        dr.Item(colHumedad) = calidad

                        'todo bien
                        'salvo que no se trae el "15.00" de la humedad -quizás ya hay una columna con el encabezado "humedad"
                    Else
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10066
                        '* Cuando el registro tiene solamente otras mermas (por ejemplo tiene un numero en MMA y en Rubros
                        ' dice \"C.Ex. 09,00\") los kg de merma, que vienen en MMA deben ir a otras mermas y están yendo a Mermas Por Humedad
                        otrasmermascalc += Val(dr.Item(c + 1))
                    End If



                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try

            Next

            If otrasmermascalc > 0 Then
                dr.Item("OTRASMERMAS") = otrasmermascalc
            End If




            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10066
            '* Cuando el registro tiene solamente otras mermas (por ejemplo tiene un numero en MMA y en Rubros
            ' dice \"C.Ex. 09,00\") los kg de merma, que vienen en MMA deben ir a otras mermas y están yendo a Mermas Por Humedad
            If dr.Item(colHumedad) = "" And otrasmermas = 0 Then
                dr.Item(columnamerma) = 0
                dr.Item("MERMAXHUMEDAD") = 0
                dr.Item("OTRASMERMAS") = mermaxhumedad
            End If



            dr.Item("OBSERVACIONES") = Left(obs, 49)








        Next



        'tengo que borrar los títulos "MMA" porque si no, los toma en la mermas por humedad cuando saliendo de esta funcion hace el hermanado
        For c = colRubros To colRubros + 10
            dt.Rows(1).Item(c) = ""
        Next



    End Sub

    Public Shared Sub FormatearColumnasFlexicapture(ByRef dt As Data.DataTable)

        Try

            If (dt.Rows(0).Item(0) = "BarraCP") Then 'es del flexicapture


                For r = 1 To dt.Rows.Count - 1

                    dt.Rows(r).Item(9) = dt.Rows(r).Item(7) 'copiar BarraCEE en CEE
                Next
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub

    Public Shared Sub RellenarCeldaVaciaConCeldaSuperior(ByRef dt As Data.DataTable)
        For r = 0 To dt.Rows.Count - 2

            'voy iterando desde el renglon de arriba hasta abajo, arrastrando hacia abajo los valores

            If IsDBNull(dt.Rows(r).Item("NumeroCDP")) Then
                Continue For 'en caso de que no haya numero de CDP, voy al siguiente renglon
            End If

            For c = 0 To dt.Columns.Count - 1 'me paseo por todas las columnas ....
                If dt.Columns(c).ColumnName = "NumeroCDP" Then Continue For '... salvo la de CDP


                If iisNull(dt.Rows(r + 1).Item(c)) = """" Then
                    'si la celda esta vacía o tiene una comilla doble ("), le pego la de arriba
                    Debug.Print(dt.Columns(c).ColumnName)
                    If dt.Columns(c).ColumnName = "column15" Then
                        Debug.Print(dt.Rows(r).Item(c))
                        If Debugger.IsAttached Then Stop 'columna de humedad
                    End If

                    dt.Rows(r + 1).Item(c) = dt.Rows(r).Item(c)
                End If
            Next

        Next
    End Sub



    Public Shared Sub ReasignoTitularCOrdenETC(ByRef dt As Data.DataTable)


        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11790
        'cargador ----> titular
        'vendedor ----> remitcomer	14/3/2014		
        'Mariano	andy, tengo en el codigo especificamente para Bunge este mapeo
        '"CARGADOR" ----> Intermediario 
        '"C/ORDEN 1" -----> RComercial
        'q hacemos con eso?	14/3/2014		
        'Andres	Debería quedar asi:

        'CUANDO HAY CARGADOR Y VENDEDOR -> TITULAR, INTERMEDIARIO
        'CUANDO HAY CARGADOR, VENDEDOR Y C/ORDEN -> TITULAR, REMITENTE E INTERMEDIARIO
        'Si viene solo Vendedor (ni Cargador ni Cuenta Orden 1), ponerlo como Titular. Intermediario y Rte Comercial deben quedar vacios.



        '////////////////////////////////////////////////////////////////////////////////////////////////////////////



        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=13427
        '        Paso a detallar como tendría que pegar la posición y la descarga de bunge ramallo, ya que últimamente no esta pegando como corresponde.
        '        CARGADOR: Para nosotros es TITULAR, (pero cuando esta vació en la planilla, el titular seria el vendedor) 
        '        VENDEDOR: Para nosotros REMITENTE, (pero cuando el cargador esta vació, EL VENDEDOR, seria el TITULAR; en el caso que haya cargador y vendedor, seria, cargador =TITULAR, vendedor= REMITENTE) 
        '        C/ ORDEN 1: Para nosotros seria el INTERMEDIARIO

        'CALIDAD:
        '        HUMEDAD: en el caso de que tenga, tendría que pegarla en el cuadradito donde dice HUMEDAD, tire o no tire merma, las tiene que pegar si o si.
        '        MERMA POR HUMEDAD: iría pegada en el cuadratiro de al lado de la humedad 
        '        MERMAS POR OTRAS COSAS: TENDRÍA QUE PEGARLA EN EL CUADRADITO DE OTRAS MERMAS

        '        SI TIENE HUMEDAD Y CUERPO EXTRAÑO (EJEMPLO) LAS MERMAS TENDRÍAN QUE IR PEGADAS AMBAS EN SU LUGAR CORRESPONDIENTE.






        For r = 0 To dt.Rows.Count - 2

            'voy iterando desde el renglon de arriba hasta abajo, arrastrando hacia abajo los valores

            Dim dr = dt.Rows(r)

            Dim cargador, vendedor, corden1 As String

            cargador = dr.Item("Titular").ToString.Trim
            vendedor = dr.Item("Intermediario").ToString.Trim
            corden1 = dr.Item("RComercial").ToString.Trim

            Dim titular, intermediario, remitente As String


            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11790

            If corden1 <> "" And vendedor <> "" And cargador <> "" Then
                'CUANDO HAY CARGADOR, VENDEDOR Y C/ORDEN -> TITULAR, REMITENTE E INTERMEDIARIO
                titular = cargador
                intermediario = corden1
                remitente = vendedor
            ElseIf corden1 = "" And vendedor <> "" And cargador <> "" Then
                'CUANDO HAY CARGADOR Y VENDEDOR -> TITULAR, RTE COMERCIAL
                titular = cargador
                intermediario = ""
                remitente = vendedor
            ElseIf corden1 = "" And vendedor <> "" And cargador = "" Then
                'Si viene solo Vendedor (ni Cargador ni Cuenta Orden 1), ponerlo como Titular. Intermediario y Rte Comercial deben quedar vacios.
                titular = vendedor
                intermediario = ""
                remitente = ""
            Else
                'si viene solo el cargador, es el titular
                titular = cargador
                intermediario = ""
                remitente = ""
            End If

            If False Then
                titular = IIf(dr.Item("Titular").ToString.Trim = "", dr.Item("Intermediario").ToString, dr.Item("Titular").ToString)
                intermediario = IIf(dr.Item("RComercial").ToString.Trim = "" And dr.Item("Titular").ToString.Trim <> "", dr.Item("Intermediario").ToString, dr.Item("RComercial").ToString)
                remitente = IIf(dr.Item("RComercial").ToString.Trim = "", "", dr.Item("Intermediario").ToString)
            End If

            dr.Item("Titular") = titular
            dr.Item("Intermediario") = intermediario
            dr.Item("RComercial") = remitente





        Next
    End Sub


    Public Shared Sub DejarSoloDatosDePosicion(ByRef dt As Data.DataTable)


        'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=17734

        For r = 0 To dt.Rows.Count - 1

            Dim dr = dt.Rows(r)

            dr.Item(enumColumnasDeGrillaFinal.column17.ToString()) = "0"
            dr.Item(enumColumnasDeGrillaFinal.column14.ToString()) = "0"
        Next



    End Sub


    Public Shared Sub ReasignoExportacion_CerealnetParaToepfer(ByRef dt As Data.DataTable)


        'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14830

        '            ANDRES, BUENAS TARDES
        'TE PASO LOS ARCHIVOS QUE IMPORTAMOS DE REYSER GRAL LAGOS, EL ARCHIVO QUE IMPORTAMOS ES EL POSI19.TXT PARA LA POSICION Y PARA LA DESCARGA ES EL DESACAR19.TXT.
        'ES EL MISMO SISTEMA QUE CARGILL PTA ALVEAR. NO HAY QUE MODIFICAR NADA SOLAMENTE LOS PUNTOS QUE TE ACLARO A CONTINUACION.


        'AHORA BIEN HAY QUE MODIFICAR LO SIGUIENTE.

        '* TODO LO QUE ES DESTINATARIO LDC ARGENTINA , TIENE QUE PEGAR SIN EL TILDE DE EXPORTACION (ES ENTREGA)

        '* Y LOS SIGUIENTES DESTINATARIOS LOS TIENE QUE PEGAR CON EL TILDE DE EXPORTACION: (SOLAMENTE LOS DE ESTA LISTA)

        '            AMAGGI EXPORT
        '            MULTIGRAIN ARG
        '            CURCIJA SA
        'LOS GROBO AGROP
        '            ANDREOLI SA
        'E-GRAIN SA
        '            BASF ARG
        '            CRESUD SA
        'DIAZ & FORTI
        '            ILLINOIS()
        'QUEBRACHITO GRANOS SA
        'FONDOMONTE SOUTH AMERICA SA

        'AGUARDO TU COMENTARIO Y LO NECESITAMOS CON URGENCIA
        '            SALUDOS()



        For r = 0 To dt.Rows.Count - 1

            Dim dr = dt.Rows(r)

            Dim destinatario = dr.Item(enumColumnasDeGrillaFinal.Comprador.ToString()).ToString.Trim
            Dim destino = dr.Item(enumColumnasDeGrillaFinal.Destino.ToString()).ToString.Trim.ToUpper


            If destinatario.Contains("AMAGGI EXPORT") _
                Or destinatario.Contains("MULTIGRAIN") _
                Or destinatario.Contains("CURCIJA") _
                Or destinatario.Contains("LOS GROBO AGROP") _
                Or destinatario.Contains("ANDREOLI SA") _
                Or destinatario.Contains("E-GRAIN") _
                Or destinatario.Contains("BASF ARG") _
                Or destinatario.Contains("CRESUD") _
                Or destinatario.Contains("DIAZ & FORTI") _
                Or destinatario.Contains("ILLINOIS") _
                Or destinatario.Contains("QUEBRACHITO GRANOS") _
                Or destinatario.Contains("FONDOMONTE SOUTH AMERICA SA") _
                Or destinatario.Contains("LDC ARG") _
                Or destinatario.Contains("CHS ARGENTINA") _
                Or destinatario.Contains("TOMAS HNOS") _
                Then
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI"
            Else
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            End If


            '* TODO LO QUE ES DESTINATARIO LDC ARGENTINA , TIENE QUE PEGAR SIN EL TILDE DE EXPORTACION (ES ENTREGA)

            If destinatario.Contains("ALFRED C TOEPFER") Then
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            End If



            '            	Buenas noches, los archivos de LDC los estamos importando con, texto reyser (archivo Descar19) y texto ReyserAnalisis (archivo Anali19). y Para Toepfer usamos, texto Toepfer (archivo Descar19) y texto ReyserAnalisis (archivo Anali19.

            'La forma para que interprete el sistema seria:
            '* Cuando viene Destinatario CHS con Destino General Lagos (Tiene que pegar la descarga)
            '* Cuando viene Destinatario CHS con Destino Arroyo Toepfer ( No tiene que pegar la descarga)
            '* Cuando viene Destinatario CHS con Destino Punta Alvear ( No tiene que pegar la descarga)
            '* Cuando viene Destinatario CHS con Destino Rosario ( No tiene que pegar la descarga)

            'TE AGREGO UN DATO MAS , CUANDO ES DESTINATARIO CHS , NO TIENE QUE PEGAR EL CAMION
            If destinatario.Contains("CHS") And Not destino.Contains("GENERAL LAGOS") Then
                dr.Item("NumeroCDP") = ""
            End If





        Next



    End Sub


    Public Shared Sub ExcepcionTerminal6_UnirColumnasConPatente(ByRef dt As Data.DataTable, ByVal renglontitulos As Integer)
        Try
            Dim PATEcol = -1, NTEcol As Integer

            For c = 0 To dt.Columns.Count - 1 'me paseo por todas las columnas ....
                If iisNull(dt.Rows(renglontitulos).Item(c), "") = "Pate" Then
                    PATEcol = c
                    NTEcol = c + 1
                    Exit For
                End If
            Next

            If PATEcol = -1 Then Exit Sub

            For Each r In dt.Rows
                r.item(PATEcol) &= r.item(NTEcol)
            Next

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try
    End Sub


    Public Shared Sub ReasignoExportacion_CerealnetParaReyser(ByRef dt As Data.DataTable)


        'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14830

        '            ANDRES, BUENAS TARDES
        'TE PASO LOS ARCHIVOS QUE IMPORTAMOS DE REYSER GRAL LAGOS, EL ARCHIVO QUE IMPORTAMOS ES EL POSI19.TXT PARA LA POSICION Y PARA LA DESCARGA ES EL DESACAR19.TXT.
        'ES EL MISMO SISTEMA QUE CARGILL PTA ALVEAR. NO HAY QUE MODIFICAR NADA SOLAMENTE LOS PUNTOS QUE TE ACLARO A CONTINUACION.


        'AHORA BIEN HAY QUE MODIFICAR LO SIGUIENTE.

        '* TODO LO QUE ES DESTINATARIO LDC ARGENTINA , TIENE QUE PEGAR SIN EL TILDE DE EXPORTACION (ES ENTREGA)

        '* Y LOS SIGUIENTES DESTINATARIOS LOS TIENE QUE PEGAR CON EL TILDE DE EXPORTACION: (SOLAMENTE LOS DE ESTA LISTA)

        '            AMAGGI EXPORT
        '            MULTIGRAIN ARG
        '            CURCIJA SA
        'LOS GROBO AGROP
        '            ANDREOLI SA
        'E-GRAIN SA
        '            BASF ARG
        '            CRESUD SA
        'DIAZ & FORTI
        '            ILLINOIS()
        'QUEBRACHITO GRANOS SA
        'FONDOMONTE SOUTH AMERICA SA

        'AGUARDO TU COMENTARIO Y LO NECESITAMOS CON URGENCIA
        '            SALUDOS()



        For r = 0 To dt.Rows.Count - 1

            Dim dr = dt.Rows(r)

            Dim destinatario = dr.Item(enumColumnasDeGrillaFinal.Comprador.ToString()).ToString.Trim
            Dim destino = dr.Item(enumColumnasDeGrillaFinal.Destino.ToString()).ToString.Trim.ToUpper


            If destinatario.Contains("AMAGGI EXPORT") _
                Or destinatario.Contains("MULTIGRAIN") _
                Or destinatario.Contains("CURCIJA") _
                Or destinatario.Contains("LOS GROBO AGROP") _
                Or destinatario.Contains("E-GRAIN") _
                Or destinatario.Contains("BASF ARG") _
                Or destinatario.Contains("CRESUD") _
                Or destinatario.Contains("DIAZ & FORTI") _
                Or destinatario.Contains("ILLINOIS") _
                Or destinatario.Contains("QUEBRACHITO GRANOS") _
                Or destinatario.Contains("ILLINOIS") _
                Or destinatario.Contains("FONDOMONTE SOUTH AMERICA SA") _
                Then
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI"
            Else
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            End If


            '* TODO LO QUE ES DESTINATARIO LDC ARGENTINA , TIENE QUE PEGAR SIN EL TILDE DE EXPORTACION (ES ENTREGA)

            If destinatario.Contains("LDC ARGENTINA") Then
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            End If

            'TE AGREGO UN DATO MAS , CUANDO ES DESTINATARIO CHS , NO TIENE QUE PEGAR EL CAMION
            If destinatario.Contains("CHS") And Not destino.Contains("GENERAL LAGOS") Then
                dr.Item("NumeroCDP") = ""
            End If

        Next



    End Sub


    Public Shared Sub ReasignoExportacion_CerealnetParaCargill(ByRef dt As Data.DataTable)
        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13055


        '        Cuando el destinatario no sea Cargill, automáticamente que le ponga el tilde de exportación.
        'Ejemplo LDC (adjunto archivos para que pruebes)

        '* El tilde de exportación tiene que ir en la original cuando no es destinatario Cargill : EJ LDC (ver archivos)

        '* No completa los datos de la solapa descarga , queda vacío y tiene que completar todo.

        '* cuando duplica una ccpp tiene que ser igual a la original sin el tilde de exportación. 

        'TODO ESTO ES PARA LA DESCARGA , LOS ARCHIVOS SON DESCAR19.TXT Y ANALI19.TXT



        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13568

        'Andres , vamos con lo mas importante te paso los clientes que cuando vienen como 
        'DESTINATARIO tienen que llevar el tilde de exportacon : LDC ARGENTINA , MULTIGRAIN ARG, AMAGGI AR, CHS , LOS GROBO


        For r = 0 To dt.Rows.Count - 1

            Dim dr = dt.Rows(r)

            Dim destinatario = dr.Item(enumColumnasDeGrillaFinal.Comprador.ToString()).ToString.Trim
            Dim destino = dr.Item(enumColumnasDeGrillaFinal.Destino.ToString()).ToString.Trim.ToUpper

            'If destinatario = "CARGILL S.A.C.I." Then
            '    dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            'Else
            '    dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI"
            'End If


            If destinatario.Contains("LDC ARGENTINA") _
                Or destinatario.Contains("MULTIGRAIN") _
                Or destinatario.Contains("AMAGGI") _
                Or destinatario.Contains("CHS") _
                Or destinatario.Contains("LOS GROBO") _
                Then
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI"
            Else
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            End If


            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13568
            'Andres buenas tardes, hay algo que nunca te avisamos, 
            '    Todo lo que venga de CHS en cargill (como exportación - destinatario), 
            '    no lo tiene que pegar en la pegatina, (solo tiene que pegar cuando también vamos por entrega). favor de hacerlo urgente...

            If destinatario.Contains("CHS") And dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI" And Not destino.Contains("GENERAL LAGOS") Then
                dr.Item("NumeroCDP") = ""
            End If



        Next



    End Sub


    Public Shared Sub ReasignoExportacion_Unidad6PlayaPerez(ByRef dt As Data.DataTable)


        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13418

        'Andres, la posición la está pegando bien, lo que faltaría es lo mismo que te pedimos para Cargill, es lo siguiente.

        'Cuando el destinatario es ADM , lo tiene que pegar como entrega normal.

        'Cuando el destinatario no es ADM, tiene que pegarlo siempre con el tilde de exportación.

        'Cuando el destinario es CHS , no tiene que pegar nada .

        For r = 0 To dt.Rows.Count - 1

            Dim dr = dt.Rows(r)

            Dim destinatario = dr.Item(enumColumnasDeGrillaFinal.Comprador.ToString()).ToString.Trim.ToUpper
            Dim destino = dr.Item(enumColumnasDeGrillaFinal.Destino.ToString()).ToString.Trim.ToUpper

            'Dim destinatario As String = dr.Item("column18").ToString.Trim ' dr.Item("Destinatario").ToString.Trim

            If destinatario.Contains("ADM") Or destinatario.Contains("TRADING SUR") Or destinatario.Contains("CIA. ARGENTINA DE GRANOS") Then
                dr.Item("Exporta") = "NO"
            ElseIf destinatario.Contains("MULTIGRAIN") Or destinatario.Contains("AMAGGI") Or destinatario.Contains("LDC") Or
                    destinatario.Contains("ANDREOLI") Or destinatario.Contains("BTG") Then
                dr.Item("Exporta") = "SI"
            Else
                dr.Item("Exporta") = "NO"
            End If



            If destinatario.Contains("CHS") And dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI" And Not destino.Contains("GENERAL LAGOS") Then
                dr.Item("NumeroCDP") = ""
            End If

        Next



        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13585
        '        Andres, ahí pudimos probar la pegatina de Playa Perez (Adjunto archivo).
        'Pega perfecto salvo:

        'Destinatario ADM tiene que pegar sin tilde de exportación y lo pega con tilde,
        'Destinatario Trading Sur tiene que pegar sin tilde de exportación y pega con tilde,
        'Destinatario Cia Arg de Granos tiene que pegar sin tilde de exportación,

        'Destinatario Multigrain tiene que pegar con tilde de exportación y lo pega sin tilde,
        'Destinatario Amaggi Tiene que pegar con tilde de exportación,
        'Destinatario LDC lo tiene que pegar con tilde de exportación. 

        'Destinatario CHS no lo tiene que pegar y lo pega.


        'ANDRES, NECESITAMOS QUE CUANDO VENGA DESTINATARIO : ANDREOLI SA Y BTG PACTUAL , SIEMPRE LO PEGUE CON TILDE.
        'AGUARDAMOS()

    End Sub




    Public Shared Sub ReasignoTitularCOrdenETC_Nidera(ByRef dt As Data.DataTable)


        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11790
        '     Si están los 3 datos (o Cta/Ord 1 y Cargador):
        'CTA ORD 1 : Titular
        'CTA ORD 2 : Intermediario
        'Cargador: Rte(Comercial)

        '----------------------------

        'Si esta solo el cargador:

        'Cargador: Titular()

        '////////////////////////////////////////////////////////////////////////////////////////////////////////////


        For r = 0 To dt.Rows.Count - 2

            'voy iterando desde el renglon de arriba hasta abajo, arrastrando hacia abajo los valores

            Dim dr = dt.Rows(r)

            Dim cargador, vendedor, corden1, corden2 As String

            cargador = dr.Item("Titular").ToString.Trim
            corden2 = dr.Item("Intermediario").ToString.Trim
            corden1 = dr.Item("RComercial").ToString.Trim

            Dim titular, intermediario, remitente As String


            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11919

            If corden1 <> "" And corden2 <> "" And cargador <> "" Then
                '     Si están los 3 datos (o Cta/Ord 1 y Cargador):
                'CTA ORD 1 : Titular
                'CTA ORD 2 : Intermediario
                'Cargador: Rte(Comercial)
                titular = corden1
                intermediario = corden2
                remitente = cargador
            ElseIf corden1 <> "" And cargador <> "" Then
                '(o Cta/Ord 1 y Cargador):
                'CTA ORD 1 : Titular
                'CTA ORD 2 : Intermediario
                'Cargador: Rte(Comercial)
                titular = corden1
                intermediario = corden2
                remitente = cargador
            Else
                'si viene solo el cargador, es el titular
                titular = cargador
                intermediario = ""
                remitente = ""
            End If


            dr.Item("Titular") = titular
            dr.Item("Intermediario") = intermediario
            dr.Item("RComercial") = remitente





        Next
    End Sub





    Public Shared Function TablaFormato(SC As String) As Data.DataTable
        Dim dt As New System.Data.DataTable("dtExcel")
        'dt.Columns.Add("Estado", System.Type.GetType("System.String")) 'para el check
        'dt.Columns.Add("check1", System.Type.GetType("System.String")) 'para el check
        'dt.Columns.Add("URLgenerada", System.Type.GetType("System.String")) 'para el check

        'dt.Columns.Add("IdTitular", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdIntermediario", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdRComercial", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdCorredor", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdDestinatario", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdChofer", System.Type.GetType("System.Int32")) 'para el color de validacion

        'dt.Columns.Add("Producto", System.Type.GetType("System.String"))
        'dt.Columns.Add("Titular", System.Type.GetType("System.String"))
        'dt.Columns.Add("Intermediario", System.Type.GetType("System.String"))
        'dt.Columns.Add("RComercial", System.Type.GetType("System.String"))
        'dt.Columns.Add("Corredor", System.Type.GetType("System.String"))

        'dt.Columns.Add("Procedencia", System.Type.GetType("System.String"))
        'dt.Columns.Add("NumeroCDP", System.Type.GetType("System.String"))
        'dt.Columns.Add("Patente", System.Type.GetType("System.String"))
        'dt.Columns.Add("Acoplado", System.Type.GetType("System.String"))
        'dt.Columns.Add("NetoProc", System.Type.GetType("System.String"))
        'dt.Columns.Add("Calidad", System.Type.GetType("System.String"))

        'dt.Columns.Add("column12", System.Type.GetType("System.String"))
        'dt.Columns.Add("column13", System.Type.GetType("System.String"))
        'dt.Columns.Add("column14", System.Type.GetType("System.String"))
        'dt.Columns.Add("column15", System.Type.GetType("System.String"))
        'dt.Columns.Add("column16", System.Type.GetType("System.String"))
        'dt.Columns.Add("column17", System.Type.GetType("System.String"))
        'dt.Columns.Add("column18", System.Type.GetType("System.String"))
        'dt.Columns.Add("column19", System.Type.GetType("System.String"))
        'dt.Columns.Add("column20", System.Type.GetType("System.String"))
        'dt.Columns.Add("column21", System.Type.GetType("System.String"))
        'dt.Columns.Add("column22", System.Type.GetType("System.String"))
        'dt.Columns.Add("column23", System.Type.GetType("System.String"))
        'dt.Columns.Add("column24", System.Type.GetType("System.String"))
        'dt.Columns.Add("column25", System.Type.GetType("System.String"))


        'dt.Columns.Add("Comprador") 'por si no esta macheada y hay que porlotanto crearla
        'dt.Columns.Add("Destino") 'por si no esta macheada y hay que porlotanto crearla
        'dt.Columns.Add("Subcontratista1") 'por si no esta macheada y hay que porlotanto crearla
        'dt.Columns.Add("Subcontratista2") 'por si no esta macheada y hay que porlotanto crearla
        'dt.Columns.Add("FechaDescarga")
        'dt.Columns.Add("Hora")


        'dt.Columns.Add("IdExcelImportador", System.Type.GetType("System.Int32"))



        Return ExcelImportadorManager.TraerMetadataPorIdMaestro(SC, -1)


        'Dim db As DemoProntoEntities = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))

        'db.exce()
        'ddddddd()
        Dim x As ProntoMVC.Data.Models.ExcelImportador
        'x.



    End Function



    Public Shared Function TraerMetadataPorIdMaestro(ByVal SC As String, Optional ByVal id As Integer = -1) As Data.DataTable
        If id = -1 Then
            Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
        Else
            Return ExecDinamico(SC, "select * from " & Tabla & " where " & "IdTanda" & "=" & id)
        End If
    End Function


    Public Shared Function TraerMetadataPorIdDetalle(ByVal SC As String, Optional ByVal id As Integer = -1) As Data.DataTable
        If id = -1 Then
            Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
        Else
            Return ExecDinamico(SC, "select * from " & Tabla & " where " & IdTabla & "=" & id)
        End If
    End Function

    Public Shared Function Insert(ByVal SC As String, ByVal dt As Data.DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)

        Dim myConnection = New SqlConnection(Encriptar(SC))
        myConnection.Open()

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)

        Try
            adapterForTable1.Update(dt)
        Catch ex As Exception
            ErrHandler2.WriteError("ExcelImportadorManager.Insert()  " & ex.ToString)
            'Stop
            Throw
        End Try



        'Dim r = ExecDinamico(SC, "SELECT TOP 1 idListaPrecios from  " & Tabla & " order by idListaPrecios DESC")
        'Return r.Rows(0).Item(0)

    End Function





    Public Shared Function Fetch(ByVal SC As String) As Data.DataTable

        'Return EntidadManager.ExecDinamico(SC, Tabla & "_TT") 

        'el Trasnportistas_TT esta usando INNER JOIN
        Dim s = "Select " &
     "Transportistas.IdTransportista, " &
     "Transportistas.RazonSocial,  " &
     "Transportistas.Direccion,  " &
     "Localidades.Nombre AS [Localidad],  " &
     "Transportistas.CodigoPostal,  " &
     "Provincias.Nombre AS [Provincia],  " &
     "Paises.Descripcion AS [Pais],  " &
     "Transportistas.Telefono,  " &
     "Transportistas.Fax,  " &
     "Transportistas.Email,  " &
     "Transportistas.Cuit,  " &
     "DescripcionIva.Descripcion AS [Condicion IVA],  " &
     "Transportistas.Contacto, " &
     "Transportistas.Horario, " &
        "    Transportistas.Celular " &
        "    FROM Transportistas " &
     "LEFT JOIN DescripcionIva ON Transportistas.IdCodigoIva = DescripcionIva.IdCodigoIva  " &
     "LEFT JOIN Localidades ON Transportistas.IdLocalidad = Localidades.IdLocalidad  " &
     "LEFT JOIN Provincias ON Transportistas.IdProvincia = Provincias.IdProvincia " &
     "LEFT JOIN Paises ON Transportistas.IdPais = Paises.IdPais " &
        "ORDER BY Transportistas.RazonSocial "

        Return EntidadManager.ExecDinamico(SC, s)


    End Function


    Public Shared Function Update(ByVal SC As String, ByVal dt As Data.DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)



        Dim myConnection = New SqlConnection(Encriptar(SC))
        myConnection.Open()

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
        'si te tira error acá, ojito con estar usando el dataset q usaste para el 
        'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
        adapterForTable1.Update(dt)

    End Function


    Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
        '// Write your own Delete statement blocks. 
        ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
    End Function

End Class

