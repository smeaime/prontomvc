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


'Imports CartaDePorteManager
Imports CDPMailFiltrosManager2
'
Imports LogicaImportador.FormatosDeExcel

Imports ProntoMVC.Data.Models

'Namespace Pronto.ERP.Bll


<DataObjectAttribute()> _
<Transaction(TransactionOption.Required)> _
Public Class FertilizanteManager
    Inherits ServicedComponent


    Public Shared Function GetItemPorNumero(ByVal SC As String, ByVal NumeroCartaDePorte As Long) As FertilizantesCupos

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



        Dim db As New DemoProntoEntities(Encriptar(SC))



        Dim familia = (From e In db.FertilizantesCupos _
                                      Where e.Numero.GetValueOrDefault = NumeroCartaDePorte _
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
            'ErrHandler.WriteAndRaiseError("Ya existe una carta con ese número y vagon: " & NumeroCartaDePorte & " " & SubNumeroVagon & ".  Puede ser una con otro Subnumero de facturacion ")




            '            __________________________()

            '            Log(Entry)
            '04/11/2013 17:45:34
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=-1. Error Message:System.Exception
            'Application-defined or object-defined error.
            '   at Microsoft.VisualBasic.ErrObject.Raise(Int32 Number, Object Source, Object Description, Object HelpFile, Object HelpContext)
            '   at ErrHandler.WriteAndRaiseError(String errorMessage) in E:\Backup\BDL\ProntoWeb\BusinessObject\ErrHandler.vb:line 120
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

    <DataObjectMethod(DataObjectMethodType.Update, True)> _
    Public Shared Function Save(ByVal SC As String, ByVal cupoFertilizante As ProntoMVC.Data.Models.FertilizantesCupos, ByVal IdUsuario As Integer, ByVal NombreUsuario As String, Optional ByVal bCopiarDuplicados As Boolean = True) As Integer
        Dim CartaDePorteId As Integer

        'Dim myTransactionScope As TransactionScope = New TransactionScope
        Try


            Dim ms As String
            If Not IsValid(SC, cupoFertilizante, ms) Then
                ErrHandler.WriteError(ms)
                Return -1
            End If




            With cupoFertilizante
                Dim db As New DemoProntoEntities(Encriptar(SC))



                If .IdFertilizanteCupo <= 0 Then
                    .FechaIngreso = Now
                    .IdUsuarioIngreso = IdUsuario
                    db.FertilizantesCupos.Add(cupoFertilizante)
                Else

                    '.FechaModificacion = Now
                    '.IdUsuarioModifico = IdUsuario
                    UpdateColecciones(cupoFertilizante, db)

                End If

                db.SaveChanges()



                'myCartaDePorte.FechaTimeStamp = TraerUltimoTimeStamp(SC, CartaDePorteId) 'si está haciendo un duplicado, el id del objeto es -1
                ' myCartaDePorte.Id = CartaDePorteId

            End With


        Catch ex As Exception
            'ContextUtil.SetAbort()
            ErrHandler.WriteError(ex)
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



    Shared Function ExcepcionHermanado(ByVal s As String, ByVal sNombreArchivoImportado As String, ByVal LetraColumna As Integer, ByVal FormatoDelArchivo As LogicaImportador.FormatosDeExcel) As enumColumnasDeGrillaFinalFertilizantes
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
                    Return enumColumnasDeGrillaFinalFertilizantes.Titular 'en lugar de vendedor/titular
                ElseIf s = "VENDEDOR" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.Intermediario 'en lugar de intermediario
                ElseIf s = "C/ORDEN 1" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.RComercial 'en lugar de intermediario
                ElseIf s = "NETO" Then
                    'en bunge muelle pampa usa "neto" para el netoproc
                    Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
                ElseIf s = "RUBROS" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.column15
                ElseIf LetraColumna = 19 Then '"U" Then
                    'Return enumColumnasDeGrillaFinalFertilizantes.column25
                End If
            Case MuellePampa, Terminal6, NobleLima
                If s = "NETO" Then
                    'en bunge muelle pampa usa "neto" para el netoproc
                    Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
                End If
            Case LDCPlantaTimbues, LDCGralLagos
                If s = "KGS." Then
                    Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
                ElseIf s = "PROC" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
                ElseIf LetraColumna = 13 Then ' "N" Then
                    'columna N en timbues (columna sin titulo) es OBSERVACIONES
                    Return enumColumnasDeGrillaFinalFertilizantes.column25
                End If
            Case VICENTIN

                If s = "DESC" Or s = "KILOS" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
                End If
            Case VICENTIN_ExcepcionTagRemitenteConflictivo

                If s = "REMITENTE" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.Titular
                End If
                If s = "REMITENTE COMERCIAL" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.RComercial
                End If

            Case Renova
                If s = "FECHA" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.column18
                End If
                If s = "NETO" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.NetoProc
                End If
                If s = "ACOPLADO" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.column24 'no te sirve poner _desconocido:  HermanarLeyenda() en ese caso se fija qué pasa. Lo mando entonces a una columna sin consecuencias (CUIT CHOFER)
                End If
                If s = "PATENTE" Then
                    Return enumColumnasDeGrillaFinalFertilizantes.column24
                End If


        End Select





        Return enumColumnasDeGrillaFinalFertilizantes._Desconocido
    End Function


    Shared Function HermanarLeyendaConColumna(ByVal s As String, Optional ByVal sNombreArchivoImportado As String = "", Optional ByVal LetraColumna As Integer = -1, Optional ByVal formato As LogicaImportador.FormatosDeExcel = Nothing) As String
        Dim sRet As String = HermanarLeyendaConColumna_aCadena(s, sNombreArchivoImportado, LetraColumna, formato)

        If sRet = "" Then sRet = "_Desconocido" 'trucheo. arreglar

        Dim enumEntidad As enumColumnasDeGrillaFinalFertilizantes = [Enum].Parse(GetType(enumColumnasDeGrillaFinalFertilizantes), sRet)

        Dim reconversion As String = enumEntidad.ToString
        If reconversion = "_Desconocido" Then reconversion = "" 'trucheo. arreglar


        Return reconversion
    End Function

    Private Shared Function HermanarLeyendaConColumna_aCadena(ByVal s As String, Optional ByVal sNombreArchivoImportado As String = "", Optional ByVal LetraColumna As Integer = -1, Optional ByVal formato As LogicaImportador.FormatosDeExcel = Nothing) As String
        s = Trim(s)

        Dim excep = ExcepcionHermanado(s, sNombreArchivoImportado, LetraColumna, formato)
        If excep <> enumColumnasDeGrillaFinalFertilizantes._Desconocido Then
            Return excep.ToString
        End If

        Select Case s
            Case "PRODUCTO", "PROD.", "MERC.", "MER", "GRANO", "MERCADERIA", "PROD"
                Return "Producto"

            Case "SUBNUMERODEFACTURACION"
                Return "SubnumeroDeFacturacion"

            Case "Nº CUPO"
                Return "NumeroCDP"



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

            'If .NumeroCartaDePorte > 1999999999 Then ' > Int32.MaxValue Then
            '    ms = "El número de CDP debe ser menor que 2.000.000.000"
            '    Return False
            'End If

            'If EsUnoDeLosClientesExportador(SC, myCartaDePorte) And .SubnumeroDeFacturacion < 0 Then
            '    sWarnings &= "Se usará automáticamente un duplicado para facturarle al cliente exportador" & vbCrLf
            'End If
        End With


        Return True
    End Function

End Class



