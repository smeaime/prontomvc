
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



'Namespace Pronto.ERP.Bll




Public Class LogicaFacturacion
    Public Const IDEMBARQUES = -2

    Public Shared ReadOnly Property MAXRENGLONES As Integer
        Get
            Return ConfigurationManager.AppSettings("RenglonesFactura")
        End Get
    End Property






    Shared Function CartasConEntregadorExternoLINQ(SC As String) As IQueryable(Of CartasDePorte)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        Dim q =
            (From i In db.CartasDePortes Where If(i.IdFacturaImputada, 0) = 0 And If(i.IdClienteEntregador, 12454) <> 12454 And i.IdClienteEntregador <> 5822)


        Return q
    End Function


    Shared Sub CorrectorParcheSubnumeroFacturacion(SC As String, ByRef mensajes As String)

        '-creo q traba todo -creo q no es esto! -igual por las dudas lo cancelo
        Return


        'http://stackoverflow.com/questions/2334712/update-from-select-using-sql-server
        '--el update se va a ir haciendo parcialmente
        Dim s As String =
    "          " &
    "        Update CartasDePorte  " &
    "set SubNumeroDefacturacion =    " &
    "(  " &
    "	select max(SubNumeroDefacturacion) from cartasdeporte as Q2   " &
    "		where    " &
    "			Q2.NumeroCartaDePorte=NumeroCartaDePorte AND   " &
    "			Q2.NumeroSubFijo=NumeroSubFijo AND   " &
    "			Q2.SubNumeroVagon=SubNumeroVagon  " &
    "			and Anulada<>'SI'  " &
    ")+1  " &
    "select Q.NumeroCartaDePorte,Q.NumeroSubFijo,Q.SubNumeroVagon  " &
    "from  cartasdeporte as Q  " &
    "inner join    " &
    "(  " &
    "select NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon  " &
    "from cartasdeporte  " &
    "where Anulada<>'SI'  " &
    "group by NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon  " &
    "having     COUNT(NumeroCartaDePorte) > 1  " &
    ") as REPES on REPES.NumeroCartaDePorte=Q.NumeroCartaDePorte AND REPES.NumeroSubFijo=Q.NumeroSubFijo AND       " &
    "REPES.SubNumeroVagon=Q.SubNumeroVagon  " &
    "where SubNumeroDefacturacion =-1"

        If False Then
            ExecDinamico(SC, s, 200)
        End If


        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        'usando cursor:



        '        DECLARE @employee_id INT 
        'DECLARE @getemployee_id CURSOR 

        'SET @getemployee_id = CURSOR FOR 
        '  select IdCartaDePorte from CartasDePorte
        '	where SubnumeroDeFacturacion =11


        'OPEN @getemployee_id
        'FETCH NEXT FROM @getemployee_ID 
        'INTO @employee_ID 



        'WHILE @@FETCH_STATUS = 0 
        'BEGIN 
        '    PRINT @employee_ID 

        '    update CartasDePorte
        '    set SubnumeroDeFacturacion=0
        '  	where IdCartaDePorte =@employee_ID

        '    FETCH NEXT FROM @getemployee_ID 
        '    INTO @employee_id 
        '                End




        'CLOSE @getemployee_ID 
        'DEALLOCATE @getemployee_ID



        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////





        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        'busco todas las cartas con copia sin incluir originales, a ver cuales solo tienen 1 carta en el grupo, lo que quiere decir que está mal
        'el subnumero de facturacion debería poder ser -1 tambien!!!
        '-nono... a las que tienen copia le pongo 0 en el original... no?

        'Esto corrige las que estásn solas y deben ponerse como originales
        'NO CORRIGE las que están mal duplicadas como 0 y -1 en el SubnumeroDeFacturacion
        Dim q2 = (From cdp In db.CartasDePortes
                  Where If(cdp.SubnumeroDeFacturacion, 0) >= 0 _
               And If(cdp.IdFacturaImputada, 0) = 0 And cdp.Anulada <> "SI"
                  Group cdp By
                  numerocartadeporte = cdp.NumeroCartaDePorte,
                  subnumerovagon = cdp.SubnumeroVagon
              Into g = Group
                  Select New With {
                  .numerocartadeporte = numerocartadeporte,
                  .subnumerovagon = subnumerovagon,
                  .CantCartas = g.Count,
                  .IdCartaDePorte = g.Sum(Function(x) x.IdCartaDePorte)
              }).Where(Function(i) i.CantCartas = 1).Select(Function(i) i.IdCartaDePorte).Distinct().ToList.Take(100)



        ErrHandler2.WriteError("CorrectorParcheSubnumeroFacturacion 1ra etapa:  " & q2.Count)


        Try

            'si habia un -1 y un 1, solo toma en cuenta el 1, intenta arreglarlo 
            'poniendole -1, no puede, y termina poniendole -2, y te queda un -1 y un -2, que 
            ' es lo que pasó en http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11785
            '-y por qué no incluías las que tienen -1? -porque esas supuestamente estan sueltas, sin copia!

            'Esto corrige las que estásn solas y deben ponerse como originales
            'NO CORRIGE las que están mal duplicadas como 0 y -1 en el SubnumeroDeFacturacion

            For Each cdp In q2
                Dim ccc = db.CartasDePortes.Where(Function(x) x.IdCartaDePorte = cdp).FirstOrDefault()
                ccc.SubnumeroDeFacturacion = 0
                'ccc.SubnumeroDeFacturacion = -1
                Try
                    db.SubmitChanges()
                Catch ex As Exception

                    'System.Data.SqlClient.SqlException: Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert 
                    'duplicate key in object 'CartasDePorte'. The statement has been terminated. at 
                    'System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection) at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection) at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateOb

                    'pensá que el subnumerodefacturacion forma parte del UNIQUE, y al cambiarlo quizas pisas a alguien...
                    '-no debería! si..
                    '-y si ya había una carta con -1 en subnumerofacturacion????????? 
                    '-claro... entonces no aparece en el q2... y sería la original de la que estás corrigiendo acá... entonces tendrías que ponerle =1.
                    'ccc.SubnumeroDeFacturacion = -2
                    MandarMailDeError("Se intentará emparchar. Error en CorrectorSubnumeroFacturacion: Carta Porte " & ccc.IdCartaDePorte & " numero " &
                                    ccc.NumeroCartaDePorte & " " & ccc.SubnumeroVagon & " " & ex.ToString)
                    ErrHandler2.WriteError(ex.ToString)
                    If False Then
                        Dim ccorig = db.CartasDePortes.Where(Function(x) x.NumeroCartaDePorte = ccc.NumeroCartaDePorte And x.SubnumeroVagon = ccc.SubnumeroVagon And x.SubnumeroDeFacturacion = -1).FirstOrDefault()
                        ccorig.SubnumeroDeFacturacion = 0
                    End If
                    ccc.SubnumeroDeFacturacion = 1
                    Try
                        db.SubmitChanges()
                    Catch ex2 As Exception
                        MandarMailDeError("Falló el parche")
                        ErrHandler2.WriteError(ex.ToString)
                    End Try

                End Try




            Next
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
        End Try

        db = Nothing



        If True Then
            'Esto corrige las que están mal duplicadas como 0 y -1 en el SubnumeroDeFacturacion

            '-anda mal y es ineficiente
            'ok, pero por qué anda mal? va bajando el contador del corrector?
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)
            'el tema era el unique que no incluía la FechaAnulacion (ni U_numerorestringido, ni el index del superbuscador)


            db = New LinqCartasPorteDataContext(Encriptar(SC))


            Dim q10 = (From cdp In db.CartasDePortes
                       Where (If(cdp.SubnumeroDeFacturacion, 0) = 0 Or If(cdp.SubnumeroDeFacturacion, 0) = -1) _
                    And cdp.Anulada <> "SI"
                       Group cdp By
                       numerocartadeporte = cdp.NumeroCartaDePorte,
                       subnumerovagon = cdp.SubnumeroVagon
                   Into g = Group
                       Select New With {
                       .numerocartadeporte = numerocartadeporte,
                       .subnumerovagon = subnumerovagon,
                       .CantCartas = g.Count
                   }).Where(Function(i) i.CantCartas > 2).Distinct()
            ErrHandler2.WriteError("Fuera de 2da etapa: faltan " & q10.Count)



            Dim q3 = (From cdp In db.CartasDePortes
                      Where (If(cdp.SubnumeroDeFacturacion, 0) = 0 Or If(cdp.SubnumeroDeFacturacion, 0) = -1) _
                   And cdp.Anulada <> "SI"
                      Group cdp By
                      numerocartadeporte = cdp.NumeroCartaDePorte,
                      subnumerovagon = cdp.SubnumeroVagon
                  Into g = Group
                      Select New With {
                      .numerocartadeporte = numerocartadeporte,
                      .subnumerovagon = subnumerovagon,
                      .CantCartas = g.Count
                  }).Where(Function(i) i.CantCartas = 2).Distinct()
            'y si hay mas de 2? -hay problemas... como con la 546818635, de la que hay 1,0 y -1. como el where solo filtra 2, pasan al 
            'for, y este le asigna un "1" a una, subnumero que ya existe... -no puede ser! si hago un if de un count nuevecito!!! y le asigna un
            '10 al subnumerodefac!!!



            'select NumeroCartaDePorte from CartasDePorte
            'where (SubnumeroDeFacturacion=0 or  
            'SubnumeroDeFacturacion=-1 or SubnumeroDeFacturacion is null )  And Anulada <> 'SI'
            'group by NumeroCartaDePorte,subnumerovagon
            'having COUNT (NumeroCartaDePorte)>1



            ErrHandler2.WriteError("Corrector: faltan " & q3.Count)

            Dim q4 = q3.ToList.Take(100)

            For Each cdp In q4
                Dim ccc = db.CartasDePortes.Where(Function(x) x.NumeroCartaDePorte = cdp.numerocartadeporte And x.SubnumeroVagon = cdp.subnumerovagon And x.Anulada <> "SI").AsEnumerable
                If ccc.Count > 2 Then
                    Dim a = ccc.Where(Function(x) x.SubnumeroDeFacturacion = -1).FirstOrDefault
                    a.SubnumeroDeFacturacion = 10
                Else

                    If ccc(0).SubnumeroDeFacturacion = -1 Then ccc(0).SubnumeroDeFacturacion = 1
                    If ccc(1).SubnumeroDeFacturacion = -1 Then ccc(1).SubnumeroDeFacturacion = 1
                End If


            Next

            Try
                db.SubmitChanges()
            Catch ex As Exception

                MandarMailDeError("Falló el parche 2da etapa " + ex.ToString) ' + cdp.numerocartadeporte.ToString + " " + cdp.subnumerovagon.ToString + " " + ex.ToString)
                ErrHandler2.WriteError(ex.ToString)

            End Try
        End If


        If False Then

            'falta buscar las que quedaron sin un original!!!

            Dim q5 = (From cdp In db.CartasDePortes
                      Where If(cdp.SubnumeroDeFacturacion, 0) >= 0 _
                   And If(cdp.IdFacturaImputada, 0) = 0
                      Group cdp By
                      numerocartadeporte = cdp.NumeroCartaDePorte,
                      subnumerovagon = cdp.SubnumeroVagon
                  Into g = Group
                      Select New With {
                      .numerocartadeporte = numerocartadeporte,
                      .subnumerovagon = subnumerovagon,
                      .CantCartas = g.Count,
                      .IdCartaDePorte = g.Sum(Function(x) x.IdCartaDePorte)
                  }).Select(Function(i) i.IdCartaDePorte).Distinct().ToList.Take(100)

            ErrHandler2.WriteError("Corrector2: faltan " & q5.Count)


            Dim a5 = From x In q5 Order By x Select CStr(x)

            ErrHandler2.WriteError(vbCrLf & Join(a5.ToArray, vbCrLf))
        End If


    End Sub


    Shared Function CartasConCopiaPendiente(q As IQueryable(Of ProntoMVC.Data.Models.CartasDePorte), ByRef mensajes As String, SC As String
                                                ) _
    As List(Of ProntoMVC.Data.Models.CartasDePorte) ' este se queda con los pendientes, para mostrar en informe

        'como puedo saber cuales estan duplicadas?






        If False Then
            Dim rows = (From i In q
                        Where If(i.SubnumeroDeFacturacion, -1) >= 0 And
                         If(i.IdFacturaImputada, 0) = 0 And
                         i.IdClienteAFacturarle Is Nothing)
        End If

        If q Is Nothing Then Return Nothing

        ' Dim db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))
        '        Dim db As New LinqCartasPorteDataContext(Encriptar(SC) ) sssss
        'db.CommandTimeout = 3 * 60


        Dim q4 As List(Of ProntoMVC.Data.Models.CartasDePorte) = (From i As ProntoMVC.Data.Models.CartasDePorte In q
                                                                  Where If(i.ConDuplicados, 0) > 0 And
                                                                   If(i.IdFacturaImputada, 0) = 0 And
                                                                   i.IdClienteAFacturarle Is Nothing Select i).ToList


        Return q4






        'Dim q2 = (From cdp In db.CartasDePortes _
        '    Group cdp By _
        '        numerocartadeporte = cdp.NumeroCartaDePorte, _
        '        subnumerovagon = cdp.SubnumeroVagon _
        '    Into g = Group _
        '    Select New With { _
        '        .numerocartadeporte = numerocartadeporte, _
        '        .subnumerovagon = subnumerovagon, _
        '        .CantCartas = g.Count, _
        '        .Cartas = g.ToList()
        '    }).Where(Function(i) i.CantCartas > 1)


        'Dim q3 = q2.SelectMany(Function(x) x.Cartas) _
        '        .Where(Function(x) If(x.IdFacturaImputada, 0) = 0 And x.Anulada <> "SI").Take(1000)



        ' Return q3.ToList

    End Function

    'Shared Sub CartasConCopiaPendiente(ByRef dt As DataTable, ByRef mensajes As String) 'este se queda con los pendientes, para mostrar en informe
    '    Dim rows = (From i In dt.AsEnumerable _
    '              Where If(IsNull(i("SubnumeroDeFacturacion")), 0, i("SubnumeroDeFacturacion")) >= 0 And _
    '                   IsNull(i("IdClienteAFacturarle")) _
    '          )
    '    If rows.Any() Then dt = rows.CopyToDataTable() Else dt = dt.Clone


    'End Sub

    Shared Sub FiltrarCartasConCopiaPendiente(ByRef dt As DataTable, ByRef mensajes As String) 'este se queda con los NO pendientes
        'http://stackoverflow.com/questions/656167/hitting-the-2100-parameter-limit-sql-server-when-using-contains

        'hacer que se llame al CorrectorSubnumeroFacturacion() 
        Try

            Dim l = (From i In dt.AsEnumerable
                     Where If(IsNull(i("ConDuplicados")), 0, CInt(i("ConDuplicados"))) > 0 And
                     If(IsNull(i("IdClienteAFacturarle")), 0, CInt(i("IdClienteAFacturarle"))) <= 0
                     Select New With {
                         .IdCartaDePorte = CLng(If(i("IdCartaDePorte"), 0)),
                         .NumeroCartaDePorte = CLng(If(i("NumeroCartaDePorte"), 0)),
                         .SubnumeroVagon = If(IsNull(i("SubnumeroVagon")), 0, CInt(i("SubnumeroVagon"))),
                         .SubnumeroDeFacturacion = If(IsNull(i("SubnumeroDeFacturacion")), 0, CInt(i("SubnumeroDeFacturacion"))),
                         .ConDuplicados = If(IsNull(i("ConDuplicados")), 0, CInt(i("ConDuplicados")))
                                  }
        ).ToList


            Dim rows = (From i In dt.AsEnumerable
                        Where Not (If(IsNull(i("ConDuplicados")), 0, i("ConDuplicados")) > 0 And
                                If(IsNull(i("IdClienteAFacturarle")), 0, CInt(i("IdClienteAFacturarle"))) <= 0
                                )
                    )
            If rows.Any() Then dt = rows.CopyToDataTable() Else dt = dt.Clone




            'Dim q = ConsultasLinq.CartasConCopiaSinAsignarLINQ(HFSC.Value)
            'q = q.Where(Function(c) l.Contains(c.IdCartaDePorte)).ToList()

            '

            'si se está mostrando mal, llamá al corrector
            If False Then
                'LogicaFacturacion.CorrectorSubnumeroFacturacion(hfcs.va)
            End If



            Dim o = (From i In l Select (
            "<a href=""CartaDePorte.aspx?Id=" & i.IdCartaDePorte.ToString() & """ target=""_blank"">" & i.NumeroCartaDePorte.ToString() & " " & i.SubnumeroVagon.ToString() & " /" & i.SubnumeroDeFacturacion.ToString() & "</a> "
                )).ToList.Take(500)

            If o.Count > 0 Then
                mensajes &= "<br/> Cartas con copia pendiente de asignar (maximo 500)  <br/> " & Join(o.ToArray(), " <br/>")
            End If

        Catch ex As Exception
            MandarMailDeError("Error en FiltrarCartasConCopiaPendiente. " & ex.ToString)
        End Try


    End Sub


    Shared Function TodasLasQueNoSonEntregadorWilliamsYavisarEnMensaje(SC As String) As IQueryable(Of CartasDePorte)
        Try

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


            Dim q =
                (From i In db.CartasDePortes Where If(i.SubnumeroDeFacturacion, 0) >= 0 And i.IdClienteAFacturarle Is Nothing _
                 And If(i.IdFacturaImputada, 0) = 0 And i.Anulada <> "SI")


            'efectivamente, no respeto ningun filtro... y parece que no basta conque el subnumero sea mayor 
            '    que cero para asegurarme de que sea una con duplicados
            '-ok, pero para lo primero, la culpa no es de esta funcion sino de quienes la llaman
            'Y si devuelvo un iqueriable, no debería recibir el db como parametro? -no parece haber problema con eso: http://stackoverflow.com/questions/534690/linq-to-sql-return-anonymous-type


            Return q
        Catch ex As Exception
            MandarMailDeError("Error en TodasLasQueNoSonEntregadorWilliamsYavisarEnMensaje. " & ex.ToString)
        End Try

    End Function

    Shared Sub FiltrarLasQueYaTienenClienteAQuienFacturarle(ByRef dt As DataTable, ByRef mensajes As String)

        'a menos que sea el mismo que me quieran asignar.......

        dt = DataTableWHERE(dt, "IdClienteAFacturarle is NULL or IdClienteAFacturarle<=0 or IdClienteAFacturarle=IdFacturarselaA")
        Dim dt2 = DataTableWHERE(dt, "NOT (IdClienteAFacturarle is NULL or IdClienteAFacturarle<=0 or IdClienteAFacturarle=IdFacturarselaA)")
        If (dt2.Rows.Count > 0) Then mensajes &= " <br/> Cartas con Cliente a Facturar ya asignado <br/>" & dt2.Rows.Count & " <br/>"

    End Sub


    Shared Sub FiltrarLasQueNoSonEntregadorWilliamsYavisarEnMensaje(ByRef dt As DataTable, ByRef mensajes As String)

        Try

            Dim l = (From i In dt.AsEnumerable
                     Where If(IsNull(i("SubnumeroDeFacturacion")), 0, i("SubnumeroDeFacturacion")) <= 0 And
                     If(IsNull(i("IdClienteEntregador")), 12454, i("IdClienteEntregador")) <> 12454 _
                   And If(IsNull(i("IdClienteEntregador")), 12454, i("IdClienteEntregador")) <> 5822
                     Select New With {
                         .IdCartaDePorte = CLng(i("IdCartaDePorte")),
                         .NumeroCartaDePorte = CLng(i("NumeroCartaDePorte")),
                         .SubnumeroVagon = CInt(i("SubnumeroVagon"))
                                  }
        ).ToList


            Dim rows = From i In dt.AsEnumerable
                       Where Not (If(IsNull(i("IdClienteEntregador")), 12454, i("IdClienteEntregador")) <> 12454 _
                      And If(IsNull(i("IdClienteEntregador")), 12454, i("IdClienteEntregador")) <> 5822)


            If rows.Any() Then dt = rows.CopyToDataTable() Else dt = dt.Clone




            'Dim q = ConsultasLinq.CartasConEntregadorExternoLINQ(HFSC.Value)
            'q = q.Where(Function(c) If(c.SubnumeroDeFacturacion, 0) <= 0 And l.Contains(c.IdCartaDePorte)).ToList


            Dim o = (From i In l
                     Select (
            "<a href=""CartaDePorte.aspx?Id=" & i.IdCartaDePorte & """ target=""_blank"">" & i.NumeroCartaDePorte.ToString() & " " & i.SubnumeroVagon.ToString() & "</a> "
                )).ToList

            If o.Count > 0 Then
                mensajes &= " <br/> Cartas con Entregador externo <br/>" & Join(o.ToArray(), " <br/>")
            End If

            'For Each x In q
            '    Dim r = (From i In dt.AsEnumerable Where CInt(i("IdCartaDePorte")) = x.)
            '    dt.Rows.Remove(r)
            'Next






            'CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
            '                    "", "", "", 1, 0, _
            '                    estadofiltro, "", idVendedor, idCorredor, _
            '                    idDestinatario, idIntermediario, _
            '                    idRComercial, idArticulo, idProcedencia, idDestino, _
            '                                                      IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
            '                     Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
            '                    Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
            '                     cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, True, txtContrato.Text, , idClienteAuxiliar)
        Catch ex As Exception
            MandarMailDeError("Error en FiltrarLasQueNoSonEntregadorWilliamsYavisarEnMensaje. " & ex.ToString)

        End Try


    End Sub




    Shared Function RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal(ByVal sesionId As Integer, ByRef dtCartas As DataTable,
                                                 ByRef dtRenglonesManuales As DataTable, ByVal hfsc As String) As DataTable

        'Return Nothing


        Dim dtGastosAdmin As DataTable

        If IsNothing(dtCartas) Then Return Nothing

        Dim IdArticuloGastoAdministrativo = GetIdArticuloParaCambioDeCartaPorte(hfsc)

        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526





        Dim ids As Integer = sesionId


        Dim db As New LinqCartasPorteDataContext(Encriptar(hfsc))

        'no sé si agrupar tambien por ClienteSeparado....          ' , ClienteSeparado = i("ClienteSeparado") Into Group
        Dim GastoAdmin = From i In db.wTempCartasPorteFacturacionAutomaticas
                         Where i.IdSesion = ids And i.AgregaItemDeGastosAdministrativos = "SI"
                         Group By i.IdFacturarselaA, i.FacturarselaA Into Group
                         Select IdFacturarselaA, FacturarselaA, cantidadGastosAdministrativos = Group.Count


        Dim aaGastoAdmin = From i In db.wTempCartasPorteFacturacionAutomaticas Where i.AgregaItemDeGastosAdministrativos = "SI"



        If dtRenglonesManuales Is Nothing Then dtRenglonesManuales = dtCartas.Clone
        dtGastosAdmin = dtCartas.Clone


        For Each r In GastoAdmin

            If EsClienteExcluidoDeGastosAdmin(db, r.IdFacturarselaA) Then Continue For


            Dim PrecioArticuloGastoAdministrativo = ListaPreciosManager.Tarifa(hfsc, r.IdFacturarselaA, IdArticuloGastoAdministrativo)
            '¿http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526


            'y si ya existen? -borralos todos 'dtRenglonesManuales = DataTableWHERE(dtRenglonesManuales, "Producto<>" & IdArticuloGastoAdministrativo)
            'dtRenglonesManuales.Rows.Find("Id )



            Dim match = dtRenglonesManuales.Select("IdFacturarselaA=" & r.IdFacturarselaA & " AND  IdArticulo=" & IdArticuloGastoAdministrativo)
            Dim nr As DataRow

            If match.Count > 0 Then
                nr = match(0)
            Else
                nr = dtRenglonesManuales.NewRow
            End If

            nr.Item("FacturarselaA") = r.FacturarselaA
            nr.Item("IdFacturarselaA") = r.IdFacturarselaA
            nr.Item("TarifaFacturada") = PrecioArticuloGastoAdministrativo
            nr.Item("KgNetos") = r.cantidadGastosAdministrativos
            nr.Item("Producto") = NombreArticulo(hfsc, IdArticuloGastoAdministrativo)
            nr.Item("IdArticulo") = IdArticuloGastoAdministrativo


            If match.Count > 0 Then
                '
                Dim newRow = dtGastosAdmin.NewRow()
                newRow.ItemArray = nr.ItemArray
                dtGastosAdmin.Rows.Add(newRow)
            Else
                'dtRenglonesManuales.Rows.Add(nr)


                Dim newRow = dtGastosAdmin.NewRow()
                newRow.ItemArray = nr.ItemArray
                dtGastosAdmin.Rows.Add(newRow)
            End If

        Next



        Return dtGastosAdmin

    End Function







    Shared Function RecalcGastosAdminDeCambioDeCarta(ByRef dtCartas As DataTable,
                                                 ByRef dtRenglonesManuales As DataTable, ByVal hfsc As String) As DataTable

        'Return Nothing

        Dim dtGastosAdmin As DataTable

        If IsNothing(dtCartas) Then Return Nothing

        Dim IdArticuloGastoAdministrativo = GetIdArticuloParaCambioDeCartaPorte(hfsc)

        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526




        'no sé si agrupar tambien por ClienteSeparado....          ' , ClienteSeparado = i("ClienteSeparado") Into Group
        Dim GastoAdmin = From i In dtCartas.AsEnumerable
                         Where iisNull(i("AgregaItemDeGastosAdministrativos"), "NO") = "SI"
                         Group By IdFacturarselaA = i("IdFacturarselaA"), FacturarselaA = i("FacturarselaA") Into Group
                         Select IdFacturarselaA, FacturarselaA, cantidadGastosAdministrativos = Group.Count



        If dtRenglonesManuales Is Nothing Then dtRenglonesManuales = dtCartas.Clone
        dtGastosAdmin = dtCartas.Clone

        For Each r In GastoAdmin

            If EsClienteExcluidoDeGastosAdmin(hfsc, r.IdFacturarselaA) Then Continue For

            Dim PrecioArticuloGastoAdministrativo = ListaPreciosManager.Tarifa(hfsc, r.IdFacturarselaA, IdArticuloGastoAdministrativo)
            '¿http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526


            'y si ya existen? -borralos todos 'dtRenglonesManuales = DataTableWHERE(dtRenglonesManuales, "Producto<>" & IdArticuloGastoAdministrativo)
            'dtRenglonesManuales.Rows.Find("Id )



            Dim match = dtRenglonesManuales.Select("IdFacturarselaA=" & r.IdFacturarselaA & " AND  IdArticulo=" & IdArticuloGastoAdministrativo)
            Dim nr As DataRow

            If match.Count > 0 Then
                nr = match(0)
            Else
                nr = dtRenglonesManuales.NewRow
            End If

            nr.Item("FacturarselaA") = r.FacturarselaA
            nr.Item("IdFacturarselaA") = r.IdFacturarselaA
            nr.Item("TarifaFacturada") = PrecioArticuloGastoAdministrativo
            nr.Item("KgNetos") = r.cantidadGastosAdministrativos
            nr.Item("Producto") = NombreArticulo(hfsc, IdArticuloGastoAdministrativo)
            nr.Item("IdArticulo") = IdArticuloGastoAdministrativo


            If match.Count > 0 Then
                '
                Dim newRow = dtGastosAdmin.NewRow()
                newRow.ItemArray = nr.ItemArray
                dtGastosAdmin.Rows.Add(newRow)
            Else
                'dtRenglonesManuales.Rows.Add(nr)


                Dim newRow = dtGastosAdmin.NewRow()
                newRow.ItemArray = nr.ItemArray
                dtGastosAdmin.Rows.Add(newRow)
            End If

        Next



        Return dtGastosAdmin

    End Function


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Shared Sub ExcluirDeGastosAdministrativos(ByRef lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal sc As String)

        '        En el formulario de cliente agregar un parámetro que indique a qué clientes no se les debe cobrar gastos administrativos.

        'En la facturación, si el cliente tiene esta marca, no tener en cuenta si en las Cartas de Porte está marcado el tilde de gastos administrativos y nunca facturarlo

        '        http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13219

        'EsClienteExcluidoDeGastosAdmin()
        'Por ahora lo hago en la facturacion. resolverlo en el paso 2
    End Sub

    Shared Function EsClienteExcluidoDeGastosAdmin(SC As String, idcliente As Integer) As Boolean
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim q = (From i In db.DetalleClientes Where i.IdCliente = idcliente _
                                            And i.Acciones = "UsaGastosAdmin" _
                                            And i.Contacto = "NO"
                                                ).SingleOrDefault

        If q Is Nothing Then Return False

        Return True
    End Function

    Shared Function EsClienteExcluidoDeGastosAdmin(db As LinqCartasPorteDataContext, idcliente As Integer) As Boolean

        Dim q = (From i In db.DetalleClientes Where i.IdCliente = idcliente _
                                            And i.Acciones = "UsaGastosAdmin" _
                                            And i.Contacto = "NO"
                                                ).SingleOrDefault

        If q Is Nothing Then Return False

        Return True
    End Function
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Shared Function ListadoManualConTablaTemporal(
                    ByVal sc As String, ByVal sLista As String, ByVal sWHEREadicional As String, ByVal optFacturarA As Long,
                    ByVal txtFacturarATerceros As String, ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String,
                    ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String,
                    ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, ByVal txtBuscar As String,
                    ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, ByVal optDivisionSyngenta As String,
                    ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, ByVal cmbPuntoVenta As String, ByVal sesionId As String,
                    ByVal startRowIndex As Long, ByVal maximumRows As Long, ByVal txtClienteAuxiliar As String, ByRef ms As String, ByVal txtFacturarA As String, sesionIdposta As String) As DataTable

        Dim dt As DataTable

        If False Then
            'dt = EntidadManager.ExecDinamico(sc, SQL_ListaDeCDPsFiltradas2(" AND IdCartaDePorte IN (" & sLista & ") ", optFacturarA, _
            '                        txtFacturarATerceros, sc, _
            '                        txtTitular, txtCorredor, txtDestinatario, _
            '                        txtIntermediario, txtRcomercial, txt_AC_Articulo, txtProcedencia, txtDestino, txtBuscar, cmbCriterioWHERE, _
            '                        cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, cmbPuntoVenta, , txtClienteAuxiliar))
            'Debug.Print(dt.Rows.Count)
            'Return dt

        End If





        Try
            EntidadManager.ExecDinamico(sc, " IF object_id('tempdb..#TEMPTAB') IS NOT NULL    BEGIN     DROP TABLE #TEMPTAB    END")
        Catch ex As Exception
            ErrHandler2.WriteError("explota el drop table. guarda!, porque tarda mucho tiempo en revisar esto!!!")
        End Try


        Dim sInsertEnTablaTemporal As String


        'http://stackoverflow.com/questions/1009008/temporary-tables-in-linq-anyone-see-a-problem-with-this


        sInsertEnTablaTemporal = "create table #temptab (IdCarta int primary key not null)    " & vbCrLf

        If False Then
            ' metodo 1 
            'http://stackoverflow.com/q/5375997/60485
            Dim sa = "insert into  #temptab  (IdCarta) values (" & iisNull(sLista, "-99").ToString().Replace(",", "); insert into  #temptab  (IdCarta) values (") & ");" 'esto no se puede hacer en SQL2000

            'EntidadManager.ExecDinamico(sc, "insert into  #temptab  (IdCarta) values " & sa)

            sInsertEnTablaTemporal &= "  " & sa & vbCrLf
        ElseIf False Then
            ' metodo 2
            '            Dim li = ListaDeCDPTildadosEnEl1erPaso()

            'For Each i As Long In tildadosEnPrimerPaso
            '    sInsertEnTablaTemporal &= "insert into  #temptab  (IdCarta) values (" & i & ")" & vbCrLf
            'Next

            EntidadManager.ExecDinamico(sc, sInsertEnTablaTemporal)

        End If


        'Dim sJoinTablaTemporal = "" '" INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta"










        Dim sJoinTablaTemporal As String
        Dim s As String

        If False Then
            'sJoinTablaTemporal = SQL_ListaDeCDPsFiltradas2("", _
            '                                         optFacturarA, txtFacturarATerceros, HFSC, txtTitular, txtCorredor, txtDestinatario, _
            '                                         txtIntermediario, txtRcomercial, txt_AC_Articulo, txtProcedencia, txtDestino, txtBuscar, _
            '                                         cmbCriterioWHERE, cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, cmbPuntoVenta, _
            '                                         " JOIN #temptab as TEMPORAL ON (CDP.IdCartaDePorte = TEMPORAL.IdCarta)  ", txtClienteAuxiliar)
            's = sInsertEnTablaTemporal & sJoinTablaTemporal
        Else


            sJoinTablaTemporal = CartaDePorteManager.SQL_ListaDeCDPsFiltradas2("",
                                             optFacturarA, txtFacturarATerceros, HFSC, txtTitular, txtCorredor, txtDestinatario,
                                             txtIntermediario, txtRcomercial, txt_AC_Articulo, txtProcedencia, txtDestino, txtBuscar,
                                             cmbCriterioWHERE, cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta, cmbPuntoVenta,
                                              " JOIN wGrillaPersistencia as TEMPORAL ON (CDP.IdCartaDePorte = TEMPORAL.IdRenglon) " &
                                              "             AND TEMPORAL.Sesion=" & _c(sesionIdposta), txtClienteAuxiliar, txtFacturarA)



            s = sJoinTablaTemporal

        End If






        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////paginado sin usar ROW_NUMBER (que no está en sql2000)
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////

        Dim s0, s1, s2, s30, s3, s4 As String

        s0 = "DECLARE @first_id bigint" & vbCrLf 'le puse bigint porque numerocartadeporte es bigint

        ' Get the first employeeID for our page of records 
        s1 = "SET ROWCOUNT " & startRowIndex & vbCrLf

        s2 = "SELECT @first_id = NumeroCartaDePorte  FROM (" + sJoinTablaTemporal + ") as A ORDER BY  NumeroCartaDePorte ASC, FacturarselaA ASC " & vbCrLf '+ " ORDER BY IdCartaDePorte DESC"



        '-- Now, set the row count to MaximumRows and get
        '-- all records >= @first_id
        s30 = "SET ROWCOUNT " & maximumRows & vbCrLf


        'llamo otra vez al select, esta
        s3 = "SELECT * FROM (" + sJoinTablaTemporal + ") as A " &
         "WHERE NumeroCartaDePorte >= @first_id " + " ORDER BY  NumeroCartaDePorte ASC, FacturarselaA ASC " & vbCrLf '+


        'pero y si no quiero ordenar por idcartadeporte?????
        'pero y si no quiero ordenar por idcartadeporte?????
        'pero y si no quiero ordenar por idcartadeporte?????
        'pero y si no quiero ordenar por idcartadeporte?????
        'bueno, tenes que usar como índice a lo que estes usando como orden dentro del select principal (en este caso, 
        ' estas ordenando en SQL_ListaDeCDPsFiltradas por: ORDER BY NumeroCartaDePorte ASC, FacturarselaA ASC 


        s4 = "SET ROWCOUNT 0" & vbCrLf


        's = s0 & s1 & s2 + s30 + s3 + s4
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////



        Try



            'http://support.microsoft.com/kb/288095
            'Se produce un desbordamiento de pila cuando ejecuta una consulta que contenga un gran número de argumentos dentro de un IN o una cláusula NOT IN en SQL Server


            'generarTablaParaModosNoAutomaticos()

            Debug.Print(s)
            dt = EntidadManager.ExecDinamico(sc, s, 200)






            '///////////////////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////////////////
            'filtradores
            'Dim ms As String = ""

            If True Then
                SoloMostrarElOriginalDeLosDuplicados(dt, ms)
                FiltrarCartasConCopiaPendiente(dt, ms)
                FiltrarLasQueNoSonEntregadorWilliamsYavisarEnMensaje(dt, ms)
                FiltrarLasQueYaTienenClienteAQuienFacturarle(dt, ms)
            End If



            '///////////////////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////////////////


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Throw
        End Try






        'hago el filtro
        Try
            EntidadManager.ExecDinamico(sc, "IF object_id('tempdb..#TEMPTAB') IS NOT NULL    BEGIN     DROP TABLE #TEMPTAB    END")

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



        Return dt

    End Function

    Shared Sub PreProcesos(ByRef lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult),
                       SC As String, desde As String, hasta As String,
                       puntoVenta As String, ByRef slinks As Object)

        '* Los Movimientos que sean Embarques (solo los embarques) se facturarán como una Carta de Porte más. 
        'Tomar el cereal, la cantidad de Kg y el Destinatario para facturar.

        ErrHandler2.WriteError("entro a Preprocesos " & lista.Count())



        AgregarEmbarques(lista, SC, desde, hasta, -1, puntoVenta)

        ErrHandler2.WriteError("despues de AgregarEmbarques" & lista.Count())
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////

        'RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal(lista, SC, dt, dtViewstateRenglonesManuales)


        ExcluirDeGastosAdministrativos(lista, SC)
        ErrHandler2.WriteError("despues de ExcluirDeGastosAdministrativos" & lista.Count())

        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////




        'verificar que no haya bloqueados por cobranzas
        'If True Then
        '    'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14168
        '    'Precisan agregar una marca en el formulario de clientes para poder bloquear la carga de estos 
        '    'en las cartas de porte debido a un conflicto de cobranzas.
        '    'Este tilde deberán verlo solo algunos usuarios (activaremos a los de cobranzas).
        '    'Luego, cuando quieran usarlo en una carta de porte el sistema tiene que dar un mensaje de advertencia diciendo 
        '    'que el usuario no se puede utilizar y que tiene que ponerse en contacto con el sector de cobranzas.
        '    'La carta de porte no se puede grabar si tiene un cliente en esta condición.


        '    Dim sClientesCobranzas As String
        '    If UsaClientesQueEstanBloqueadosPorCobranzas(SC, myCartaDePorte, sClientesCobranzas) Then
        '        MS &= "Cliente bloqueado. Ponerse en contacto con el sector de cobranzas (" & sClientesCobranzas & ") "
        '        MS &= vbCrLf   'return false
        '    End If
        'End If








        '* Nueva función en Facturación Automática: "Facturarle al Corredor". Agregar un tilde en los clientes con ese nombre. En el Automático, las Cartas de Porte que corresponda facturarle a estos clientes se le facturarán al Corredor de cada Carta de Porte
        ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor(lista, SC)
        ErrHandler2.WriteError("despues de ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor" & lista.Count())


        'hay que hacer un update de la lista por si se derivó a un corredor?

        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////




        'Para la facturación automática, de haber cartas de porte Agro y cartas de Porte Seeds, armar dos facturas separadas.
        'Como las cartas de porte duplicadas solamente se pueden facturar mediante la facturación automática, entran en el automático. Para que no se pase la facturación separada, armar dos facturas distintas automaticamente.

        Try
            CasosSyngenta_y_Acopios(lista, SC)
            ErrHandler2.WriteError("despues de CasosSyngenta_y_Acopios" & lista.Count())

        Catch ex As Exception
            ErrHandler2.WriteError("CasosSyngenta_y_Acopios")
            ErrHandler2.WriteError(ex)
        End Try

        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////







        'Dim slinks As String
        lista = LinksDeCartasConflictivasDelAutomatico(lista, slinks, SC)

        slinks &= VerificarClientesFacturables(lista)

        'ViewState("sLinks") = slinks




    End Sub

    Shared Sub PostProcesos(ByRef lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult),
                                    optFacturarA As String, agruparArticulosPor As String, sc As String)


        ErrHandler2.WriteError("entro en PostProcesos " & lista.Count())

        EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado(lista, sc)
        ErrHandler2.WriteError("despues de EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado " & lista.Count())

        EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones(lista, optFacturarA, agruparArticulosPor, sc, "")
        ErrHandler2.WriteError("despues de EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones " & lista.Count())

        SepararAcopiosLDCyACA(lista, sc)
        ErrHandler2.WriteError("despues de SepararAcopiosLDCyACA " & lista.Count())

        PostProcesoFacturacion_ReglaExportadores(lista, sc)
        ErrHandler2.WriteError("despues de PostProcesoFacturacion_ReglaExportadores " & lista.Count())

    End Sub



    Shared Sub generarTablaParaModosNoAutomaticos(ByVal sc As String,
                                             ByRef pag As Object,
                                        ByRef sesionId As Object,
                                           ByVal sLista As String,
                                              ByVal sWHEREadicional As String, ByVal optFacturarA As Long,
                    ByVal txtFacturarATerceros As String, ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String,
                    ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String,
                    ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, ByVal txtBuscar As String,
                    ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, ByVal optDivisionSyngenta As String, ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, ByVal cmbPuntoVenta As String,
                      ByVal startRowIndex As Long, ByVal maximumRows As Long, ByVal txtclienteauxiliar As String, ByRef sErrores As String, txtFacturarA As String, agruparArticulosPor As String, ByRef filas As Object, ByRef slinks As Object, sesionIdposta As String)


        Try



            Dim tildadosEnPrimerPaso As String() = Split(sLista, ",")
            ' = 
            'Dim a = Array.ConvertAll(Of String, Decimal)(tildadosEnPrimerPaso, Convert.ToDecimal) ' ViewState("ListaIDsLongs")       'ListaDeCDPTildadosEnEl1erPaso()
            Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = tildadosEnPrimerPaso.Select(Function(itemID) CInt(IIf(IsNumeric(itemID), itemID, -1))).ToList

            Dim lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult)

            Dim dtAutomatico As DataTable

            Dim db As New LinqCartasPorteDataContext(Encriptar(sc))





            'lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica(CInt(cmbPuntoVenta.Text)) _
            '          Where cdp.SubnumeroDeFacturacion > 0 And tildadosEnPrimerPasoLongs.Contains(CLng(iisNull(cdp.IdCartaOriginal, -1))) _
            '          ).ToList

            Dim dtNoAutomatico As DataTable = ListadoManualConTablaTemporal(sc, sLista, "", optFacturarA,
                                                    txtFacturarATerceros, HFSC, txtTitular, txtCorredor,
                                                    txtDestinatario, txtIntermediario, txtRcomercial, txt_AC_Articulo,
                                                    txtProcedencia, txtDestino, txtBuscar, cmbCriterioWHERE,
                                                    cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta,
                                                    cmbPuntoVenta, sesionId, 0, 1012012, txtclienteauxiliar, sErrores, txtFacturarA, sesionIdposta)






            lista = (From cdp In dtNoAutomatico.AsEnumerable
                     Where tildadosEnPrimerPasoLongs.Contains(If(cdp("IdCartaDePorte"), -1)) _
                       Or (iisNull(cdp("SubnumeroDeFacturacion"), 0) > 0)
                     Select New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult With {
                     .ColumnaTilde = CInt(iisNull(cdp("ColumnaTilde"), 0)),
                     .IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte"))),
                     .IdArticulo = CInt(iisNull(cdp("IdArticulo"))),
                     .NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"), 0),
                     .SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon"), 0)),
                     .SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0)),
                     .FechaArribo = CDate(iisNull(cdp("FechaArribo"), Today)),
                     .FechaDescarga = CDate(iisNull(cdp("FechaDescarga"), Today)),
                     .FacturarselaA = CStr(iisNull(cdp("FacturarselaA"))),
                     .IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA"), -1)),
                     .Confirmado = iisNull(cdp("Confirmado")),
                     .IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1)),
                     .CUIT = CStr(iisNull(cdp("CUIT"))),
                     .ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado"))),
                     .TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0)),
                     .Producto = CStr(iisNull(cdp("Producto"))),
                     .KgNetos = CDec(iisNull(cdp("KgNetos"))),
                     .IdCorredor = CInt(iisNull(cdp("IdCorredor"), -1)),
                     .IdTitular = CInt(iisNull(cdp("IdTitular"), -1)),
                     .IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1)),
                     .IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1)),
                     .IdDestinatario = CInt(iisNull(cdp("IdDestinatario"), -1)),
                     .Titular = CStr(iisNull(cdp("Titular"))),
                     .Intermediario = CStr(iisNull(cdp("Intermediario"))),
                     .R__Comercial = CStr(iisNull(cdp("R. Comercial"))),
                     .Corredor = CStr(iisNull(cdp("Corredor "))),
                     .Destinatario = CStr(iisNull(cdp("Destinatario"))),
                     .DestinoDesc = CStr(iisNull(cdp("DestinoDesc"))),
                     .Procedcia_ = CStr(iisNull(cdp("Procedcia."))),
                     .IdDestino = CInt(iisNull(cdp("IdDestino"), -1)),
                     .AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos")))
                 }
                          ).ToList




            'tengo q incluir los explicitos duplicados porque solo tengo el ID de los originales para filtrar. Lo filtro luego, viendo si está el original de ellos



            ''agrego a la lista de tildes los duplicados explicitos
            ''quitar los duplicados explicitos sin original
            'Dim duplicadosexplicitos = From cdp In lista Where cdp.SubnumeroDeFacturacion > 0 Select cdp.NumeroCartaDePorte
            ''      Join cdpjoin In lista On cdp.NumeroCartaDePorte Equals cdpjoin.NumeroCartaDePorte

            'Dim duplicadosexplicitosIncluidos = From cdp In lista _
            '                                  Where duplicadosexplicitos.Contains(cdp.NumeroCartaDePorte) _
            '                                        And Not cdp.SubnumeroDeFacturacion > 0 _
            '                                        Select cdp.IdCartaDePorte


            'lista = (From cdp In lista _
            '          Where tildadosEnPrimerPasoLongs.Contains(CLng(iisNull(cdp.IdCartaDePorte, -1))) _
            '                Or cdp.SubnumeroDeFacturacion > 0 And  _
            '          ).ToList








            '¿como hacer la union de la consulta de titular, y el filtro de cartas problematicas, así queda el skiptake al final

            Debug.Print(lista.Count)



            'ejecutar inmediatamente LINQ usando la conversion a .ToList()
            'http://blogs.msdn.com/b/charlie/archive/2007/12/09/deferred-execution.aspx
            Dim IdsEnElAutomatico = (From i In lista Select i.IdCartaDePorte).ToList
            Debug.Print(IdsEnElAutomatico.ToString)




            ReasignarParaElTitularALasCartasSinClienteAutomaticoEncontrado(lista, sesionId, sesionIdposta, tildadosEnPrimerPasoLongs, False, IdsEnElAutomatico, sc)


            'como agregar las cartas sin automatico posible? haces un filtro de lo que vino con las Id tildadas en el primer paso, antes de filtrar por repetido. Si no vino nada, es que no hay automatico.
            Dim IdcartasSinAutomaticoEncontrado = (From i In tildadosEnPrimerPasoLongs Select id = CStr(i)
                                                   Where Not IdsEnElAutomatico.Contains(CLng(id))).ToArray


            ErrHandler2.WriteError("Cartas sin automatico encontrado (pero este es el modo no automatico!!!)" & IdcartasSinAutomaticoEncontrado.Count)


            If IdcartasSinAutomaticoEncontrado.Count > 0 Then

                Dim sWhere = " AND IdCartaDePorte IN (" & Join(IdcartasSinAutomaticoEncontrado, ",") & ")"
                '///////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////

                Dim dtForzadasAlTitular = SQLSTRING_FacturacionCartas_por_Titular(sWhere, sc, sesionIdposta)


                For Each cdp In dtForzadasAlTitular.Rows
                    Dim x As New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult
                    With x
                        .ColumnaTilde = CInt(cdp("ColumnaTilde"))
                        .IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte")))
                        .IdArticulo = CInt(iisNull(cdp("IdArticulo")))
                        .NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"))
                        Try
                            .SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon")))
                        Catch ex As Exception
                            'raro
                            ErrHandler2.WriteError(ex)
                        End Try

                        .SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0))



                        .FechaArribo = CDate(iisNull(cdp("FechaArribo"), Today))
                        .FechaDescarga = CDate(iisNull(cdp("FechaDescarga"), Today))



                        .FacturarselaA = CStr(iisNull(cdp("FacturarselaA")))
                        .IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA")))
                        .Confirmado = iisNull(cdp("Confirmado"))
                        .IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1))
                        .CUIT = CStr(iisNull(cdp("CUIT")))
                        .ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado")))
                        .TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0))
                        .Producto = CStr(iisNull(cdp("Producto")))
                        .KgNetos = CDec(iisNull(cdp("KgNetos")))
                        .IdCorredor = CInt(iisNull(cdp("IdCorredor")))
                        .IdTitular = CInt(iisNull(cdp("IdTitular")))
                        .IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1))
                        .IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1))
                        .IdDestinatario = CInt(iisNull(cdp("IdDestinatario")))
                        .Titular = CStr(iisNull(cdp("Titular")))
                        .Intermediario = CStr(iisNull(cdp("Intermediario")))
                        .R__Comercial = CStr(iisNull(cdp("R. Comercial")))
                        .Corredor = CStr(iisNull(cdp("Corredor ")))
                        .Destinatario = CStr(iisNull(cdp("Destinatario")))
                        .DestinoDesc = CStr(iisNull(cdp("DestinoDesc")))
                        .Procedcia_ = CStr(iisNull(cdp("Procedcia.")))
                        .IdDestino = CInt(iisNull(cdp("IdDestino")))
                        .AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos")))
                        lista.Add(x)
                    End With
                Next

            End If



            'consulta 8413
            '        * Ordenar alfabeticamente por la columna "Facturarle a"
            '       * Poner las que tienen tarifa en 0 al principio

            'Dim unionAutomaticoConTitularesDefault = (From i In lista).Union( _
            '                From cdp In dtForzadasAlTitular.AsEnumerable _
            '                Select _
            '                ColumnaTilde = CInt(cdp("ColumnaTilde")), _
            '                IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte"))), _
            '                IdArticulo = CInt(iisNull(cdp("IdArticulo"))), _
            '                NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte")), _
            '                SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon"))), _
            '                SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"))), _
            '                FechaArribo = CDate(iisNull(cdp("FechaArribo"))), _
            '                FechaDescarga = CDate(iisNull(cdp("FechaDescarga"))), _
            '                FacturarselaA = CDate(iisNull(cdp("FacturarselaA"))), _
            '                IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA"))), _
            '                Confirmado = iisNull(cdp("Confirmado")), _
            '                IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"))), _
            '                CUIT = CStr(iisNull(cdp("CUIT"))), _
            '                ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado"))), _
            '                TarifaFacturada = iisNull(cdp("wTarifaWilliams")), _
            '                Producto = CStr(iisNull(cdp("Producto"))), _
            '                KgNetos = CDec(iisNull(cdp("KgNetos"))), _
            '                IdCorredor = CInt(iisNull(cdp("IdCorredor"))), _
            '                IdTitular = CInt(iisNull(cdp("IdTitular"))), _
            '                IdIntermediario = CInt(iisNull(cdp("IdIntermediario"))), _
            '                IdRComercial = CInt(iisNull(cdp("IdRComercial"))), _
            '                IdDestinatario = CInt(iisNull(cdp("IdDestinatario"))), _
            '                Titular = CStr(iisNull(cdp("Titular"))), _
            '                Intermediario = CStr(iisNull(cdp("Intermediario"))), _
            '                R__Comercial = CStr(iisNull(cdp("R__Comercial"))), _
            '                Corredor_ = CStr(iisNull(cdp("Corredor_"))), _
            '                Destinatario = CStr(iisNull(cdp("Destinatario"))), _
            '                DestinoDesc = CStr(iisNull(cdp("DestinoDesc"))), _
            '                Procedcia_ = CStr(iisNull(cdp("Procedcia_"))), _
            '                IdDestino = CInt(iisNull(cdp("IdDestino"))) _
            '                )



            'dtAutomatico = DataTableUNION(dtAutomatico, dtForzadasAlTitular)


            PreProcesos(lista, sc, txtFechaDesde, txtFechaHasta, cmbPuntoVenta, slinks)

            PostProcesos(lista, optFacturarA, agruparArticulosPor, sc)

            'EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado(lista, sc)
            'EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones(lista, optFacturarA, agruparArticulosPor, sc, "")

            'PostProcesoFacturacion_ReglaExportadores(lista, sc)





            Dim qqqq = lista.Where(Function(x) x.ClienteSeparado <> "").ToList()

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'excluir (del modo no automático) las que tengan facturación explicita 
            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9323
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'Dim copialista As New Generic.List(Of    wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult)(lista)

            'For Each i In copialista
            '    If i.IdFacturarselaA > 0 Then
            '        lista.Find()
            '    End If
            'Next

            'lista = (From i In lista Where Not i.IdClienteAFacturarle > 0).ToList

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'guardo los datos temporales
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            Randomize()
            'ViewState("pagina") =
            pag = 1
            'ViewState("sesionId") =
            sesionId = CInt(Rnd() * 10000)

            Dim c = ExecDinamico(sc, "select count(*) from wTempCartasPorteFacturacionAutomatica")
            If c.Rows(0).Item(0) > 40000 Then
                ExecDinamico(sc, "DELETE wTempCartasPorteFacturacionAutomatica")
            End If


            Dim dt = ExecDinamico(sc, "SELECT * FROM wTempCartasPorteFacturacionAutomatica where 1=0")

            Dim l As New Generic.List(Of wTempCartasPorteFacturacionAutomatica)
            For Each x In lista
                Dim a = New wTempCartasPorteFacturacionAutomatica
                a.IdSesion = sesionId 'ViewState("sesionId")

                a.IdCartaDePorte = x.IdCartaDePorte
                a.IdFacturarselaA = x.IdFacturarselaA
                a.TarifaFacturada = x.TarifaFacturada
                a.ClienteSeparado = x.ClienteSeparado
                a.ColumnaTilde = x.ColumnaTilde
                a.Confirmado = x.Confirmado
                a.Corredor = x.Corredor
                a.Corredor = x.ClienteSeparado
                a.FacturarselaA = Left(iisNull(x.FacturarselaA, ""), 50) 'esto puede traer problemas?
                a.KgNetos = iisNull(x.KgNetos, 0)
                a.DestinoDesc = x.DestinoDesc
                a.NumeroCartaDePorte = iisNull(x.NumeroCartaDePorte, -10)
                a.SubNumeroVagon = x.SubNumeroVagon
                a.SubnumeroDeFacturacion = x.SubnumeroDeFacturacion
                a.FechaArribo = x.FechaArribo
                a.FechaDescarga = x.FechaDescarga
                a.Producto = x.Producto
                a.IdArticulo = x.IdArticulo
                a.IdCodigoIVA = x.IdCodigoIVA
                a.CUIT = x.CUIT
                a.IdDestino = x.IdDestino
                a.Procedcia = x.Procedcia_
                a.Destinatario = x.Destinatario
                a.Titular = Left(x.Titular, 50)
                a.RComercial = x.R__Comercial
                a.IdIntermediario = x.IdIntermediario
                a.IdCorredor = x.IdCorredor
                a.IdTitular = x.IdTitular
                a.IdRComercial = x.IdRComercial
                a.IdIntermediario = x.IdIntermediario
                a.IdRComercial = x.IdRComercial

                a.AgregaItemDeGastosAdministrativos = x.AgregaItemDeGastosAdministrativos

                ' l.Add(a) 'con linq
                dt.Rows.Add(Nothing, a.IdSesion, x.IdCartaDePorte) 'con datatable
            Next


            'se podría usar bulkCopy http://msdn.microsoft.com/en-us/library/system.data.sqlclient.sqlbulkcopy.aspx
            ' db.wTempCartasPorteFacturacionAutomaticas.InsertAllOnSubmit(l)
            ' db.SubmitChanges()


            If False Then 'con el datatable no anduvo mas rapido
                Dim myConnection = New SqlConnection(Encriptar(sc))
                myConnection.Open()
                Dim adapterForTable1 = New SqlDataAdapter("select * from  wTempCartasPorteFacturacionAutomatica ", myConnection)
                Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
                'si te tira error acá, ojito con estar usando el dataset q usaste para el 
                'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
                adapterForTable1.Update(dt)
            End If

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////


            'Dim liston = (From i In lista Select i, IdSesion = ViewState("sesionId")).ToList

            'Dim listaConOrden = (From i In lista Order By (IIf(i.TarifaFacturada = 0, " ", "") & i.FacturarselaA) Ascending).ToList

            For Each r In lista
                r.Titular = Left(r.Titular, 50)
                r.FacturarselaA = Left(r.FacturarselaA, 50)
            Next

            Dim dtlista As DataTable = ToDataTableNull(lista)
            dtlista.Columns.Remove("IdCartaOriginal")

            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "IdSesion"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = sesionId
            End With
            dtlista.Columns.Add(dc)
            'For Each r In dtlista
            '    r("IdSesion") = ViewState("sesionId")
            'Next

            BulkCopy(dtlista, sc)


            'como la query dinamica no trae la tarifa en el caso de a terceros, tengo que refrescarla
            '-podrías hacer el refresco cuando todavía tenes en memoria la tarifa, no?, en lugar de ir a hacer en la base
            If optFacturarA = 4 Then
                'no llega el sesionId....
                RefrescaTarifaTablaTemporal(dtNoAutomatico, sc, optFacturarA, txtFacturarATerceros, Val(sesionId), , , , cmbmodo <> "Entregas")
            End If

            If optFacturarA = 3 Then
                ValidaQueHayaClienteCorredorEquivalente()
            End If





            filas = dtlista.Rows.Count
            'ViewState("filas") = dtlista.Rows.Count

        Catch ex As Exception
            ErrHandler2.WriteError("GenerarTablaparamodosnoautomaticos")
            ErrHandler2.WriteError(ex)
            Throw
        End Try

    End Sub



    Shared Sub ReasignarParaElTitularALasCartasSinClienteAutomaticoEncontrado _
            (ByRef lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult),
              ByRef sesionId As Object,
              sesionIdposta As String, tildadosEnPrimerPasoLongs As List(Of Integer), bNoUsarLista As Boolean,
              IdsEnElAutomatico As List(Of Integer?), SC As String)

        Return

        'como agregar las cartas sin automatico posible? haces un filtro de lo que vino con las Id tildadas en el primer paso, antes de filtrar por repetido. Si no vino nada, es que no hay automatico.
        Dim IdcartasSinAutomaticoEncontrado = (From i In tildadosEnPrimerPasoLongs Select id = CStr(i)
                                               Where Not IdsEnElAutomatico.Contains(CLng(id))).ToArray





        ErrHandler2.WriteError("punto 3. tanda " & sesionId)




        ErrHandler2.WriteError("Cartas sin automatico encontrado " & IdcartasSinAutomaticoEncontrado.Count)



        'TO DO: avisar que no se les encontró automático


        If IdcartasSinAutomaticoEncontrado.Count > 0 And Not bNoUsarLista Then
            Dim sWhere = " AND IdCartaDePorte IN (" & Join(IdcartasSinAutomaticoEncontrado, ",") & ")"

            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////

            'ineficiente
            Dim dtForzadasAlTitular = SQLSTRING_FacturacionCartas_por_Titular(sWhere, SC, sesionIdposta)

            ErrHandler2.WriteError("punto 4. tanda " & sesionId)
            'ineficiente
            For Each cdp In dtForzadasAlTitular.Rows
                Dim x As New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult
                With x
                    .ColumnaTilde = CInt(cdp("ColumnaTilde"))
                    .IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte")))
                    .IdArticulo = CInt(iisNull(cdp("IdArticulo")))
                    .NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"))

                    Try
                        .SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon")))
                    Catch ex As Exception
                        'raro
                        ErrHandler2.WriteError(ex)
                    End Try

                    .SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0))


                    .FechaArribo = CDate(iisNull(cdp("FechaArribo"), Today))
                    .FechaDescarga = CDate(iisNull(cdp("FechaDescarga"), Today))


                    .FacturarselaA = CStr(iisNull(cdp("FacturarselaA")))
                    .IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA")))
                    .Confirmado = iisNull(cdp("Confirmado"))
                    .IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1))
                    .CUIT = CStr(iisNull(cdp("CUIT")))
                    .ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado")))
                    .TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0))
                    .Producto = CStr(iisNull(cdp("Producto")))
                    .KgNetos = CDec(iisNull(cdp("KgNetos")))
                    .IdCorredor = CInt(iisNull(cdp("IdCorredor")))
                    .IdTitular = CInt(iisNull(cdp("IdTitular")))
                    .IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1))
                    .IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1))
                    .IdDestinatario = CInt(iisNull(cdp("IdDestinatario")))
                    .Titular = CStr(iisNull(cdp("Titular")))
                    .Intermediario = CStr(iisNull(cdp("Intermediario")))
                    .R__Comercial = CStr(iisNull(cdp("R. Comercial")))
                    .Corredor = CStr(iisNull(cdp("Corredor ")))
                    .Destinatario = CStr(iisNull(cdp("Destinatario")))
                    .DestinoDesc = CStr(iisNull(cdp("DestinoDesc")))
                    .Procedcia_ = CStr(iisNull(cdp("Procedcia.")))
                    .IdDestino = CInt(iisNull(cdp("IdDestino")))
                    .AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos")))
                    lista.Add(x)
                End With
            Next
        End If



    End Sub



    Public Shared Function ValidaCobranzas(ByRef tablaEditadaDeFacturasParaGenerar As DataTable, ByRef sError As String) As Boolean


        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        ' acá ya llegan las cartas tildadas filtradas desde la funcion Validar2doPaso
        '-sí, pero cómo reviso las tildes de los buques???? Y ESTAS chamuyando: acá hago la primera consulta 
        '               sobre db.wTempCartasPorteFacturacionAutomaticas, y no sobre la tablaEditadaDeFacturasParaGenerar!!!
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////


        '//'    'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14168
        '    //'    'Precisan agregar una marca en el formulario de clientes para poder bloquear la carga de estos
        '    //'    'en las cartas de porte debido a un conflicto de cobranzas.
        '    //'    'Este tilde deberán verlo solo algunos usuarios(activaremos a los de cobranzas).
        '    //'    'Luego, cuando quieran usarlo en una carta de porte el sistema tiene que dar un mensaje de advertencia diciendo
        '    //'    'que el usuario no se puede utilizar y que tiene que ponerse en contacto con el sector de cobranzas.
        '    //'    'La carta de porte no se puede grabar si tiene un cliente en esta condición.


        '    //'    Dim sClientesCobranzas As String
        '    //'    If UsaClientesQueEstanBloqueadosPorCobranzas(SC, myCartaDePorte, sClientesCobranzas) Then
        '    //'        MS &= "Cliente bloqueado. Ponerse en contacto con el sector de cobranzas (" & sClientesCobranzas & ") "
        '    //'        MS &= vbCrLf   'return false
        '    //'    End If


        Return True




        Dim clientesfacturados As New List(Of Integer)


        For i As Integer = 0 To tablaEditadaDeFacturasParaGenerar.Rows.Count - 1
            clientesfacturados = tablaEditadaDeFacturasParaGenerar.Rows(i).Item("TarifaFacturada")


            'verificariamos el titular o aquel al que se le factura?



            'If UsaClientesQueEstanBloqueadosPorCobranzas(SC, myCartaDePorte, sClientesCobranzas) Then

        Next





        'If myCartaDePorte.Titular > 0 AndAlso (From i In db.DetalleClientesContactos
        '                                       Where i.IdCliente = myCartaDePorte.Titular
        '                                           And i.Acciones = "DeshabilitadoPorCobranzas" _
        '                                           And i.Contacto = "NO"
        '                                        ).Any Then
        '    MS += " El Titular esta deshabilitado por cobranzas "
        'End If





        Return True

    End Function


    Shared Function ValidaQueHayaClienteCorredorEquivalente() As Boolean

        'adasd()
        'en los casos que se pone facturar a corredor
    End Function

    Shared Function GridCheckboxPersistenciaBulk(ByVal sc As String, ByVal sesionIdentificador As String, l As List(Of Integer))



        If l.Count = 0 And False Then Throw New Exception("No hay cartas seleccionadas")

        'Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        Dim a As wGrillaPersistencia


        ExecDinamico(sc, "delete wGrillaPersistencia where Sesion='" & sesionIdentificador & "'") 'cómo refrescar?


        Dim dt = ExecDinamico(sc, "SELECT * from  wGrillaPersistencia where 1=0")



        For Each i In l
            Dim r = dt.NewRow
            r("IdRenglon") = i
            r("Sesion") = sesionIdentificador
            r("Tilde") = True
            dt.Rows.Add(r)
        Next

        Using destinationConnection As SqlConnection = New SqlConnection(Encriptar(sc))
            destinationConnection.Open()

            ' Set up the bulk copy object. 
            ' The column positions in the source data reader 
            ' match the column positions in the destination table, 
            ' so there is no need to map columns.
            Using bulkCopy As SqlBulkCopy = New SqlBulkCopy(destinationConnection)
                bulkCopy.DestinationTableName = "dbo.wGrillaPersistencia"

                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdRenglon", "IdRenglon"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Sesion", "Sesion"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Tilde", "Tilde"))

                Try
                    ' Write from the source to the destination.
                    bulkCopy.WriteToServer(dt)
                Catch ex As Exception
                    Console.WriteLine(ex.ToString)  'que no te confunda el orden de los colid. Por ejemplo, Titular era el 11. Es decir, depende del datatable. No?
                    ErrHandler2.WriteError(ex)
                    Throw
                End Try

            End Using
        End Using


    End Function

    Shared Sub generarTabla(ByVal SC As String,
                        ByRef pag As Object,
                        ByRef sesionId As Object,
                        ByVal iPageSize As Long,
                        ByVal puntoVenta As Integer, ByVal desde As DateTime, ByVal hasta As DateTime,
                        ByVal sLista As String, bNoUsarLista As Boolean,
                        optFacturarA As Long, agruparArticulosPor As String, ByRef filas As Object,
                        ByRef slinks As Object, sesionIdposta As String)

        ErrHandler2.WriteError("entrando en generar tabla. tanda " & sesionId.ToString)

        Try
            Dim tildadosEnPrimerPaso As String() = Split(sLista, ",")
            Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer)
            'If sLista Is Nothing Then
            '    tildadosEnPrimerPaso = Nothing
            '    tildadosEnPrimerPasoLongs = Nothing
            'End If
            'Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = ViewState("ListaIDsLongs")       'ListaDeCDPTildadosEnEl1erPaso()
            tildadosEnPrimerPasoLongs = tildadosEnPrimerPaso.Select(Function(itemID) CInt(IIf(IsNumeric(itemID), itemID, -1))).ToList

            Dim lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult)

            Dim dtAutomatico As DataTable

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))





            If False Then
                'como antes ocultaba los hijos en el primer paso, en el segundo los incluia dependiendo del padre original
                lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia(CInt(puntoVenta), sesionIdposta)
                         Where tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaDePorte, -1)) _
                           Or (cdp.SubnumeroDeFacturacion > 0 And tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaOriginal, -1)))
                      ).ToList
            Else
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9281
                'ahora solo incluyo lo que se tildó explícitamente en el primer paso
                If bNoUsarLista Then
                    lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia(CInt(puntoVenta), sesionIdposta)
                             Where If(cdp.IdCartaOriginal, -1) <= 0
                      ).ToList
                Else
                    lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia(CInt(puntoVenta), sesionIdposta)
                             Where tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaDePorte, -1)) _
                         And If(cdp.IdCartaOriginal, -1) <= 0
                        ).ToList
                End If

            End If


            'tengo q incluir los explicitos duplicados porque solo tengo el ID de los originales para filtrar. Lo filtro luego, viendo si está el original de ellos



            ''agrego a la lista de tildes los duplicados explicitos
            ''quitar los duplicados explicitos sin original
            'Dim duplicadosexplicitos = From cdp In lista Where cdp.SubnumeroDeFacturacion > 0 Select cdp.NumeroCartaDePorte
            ''      Join cdpjoin In lista On cdp.NumeroCartaDePorte Equals cdpjoin.NumeroCartaDePorte

            'Dim duplicadosexplicitosIncluidos = From cdp In lista _
            '                                  Where duplicadosexplicitos.Contains(cdp.NumeroCartaDePorte) _
            '                                        And Not cdp.SubnumeroDeFacturacion > 0 _
            '                                        Select cdp.IdCartaDePorte


            'lista = (From cdp In lista _
            '          Where tildadosEnPrimerPasoLongs.Contains(CLng(iisNull(cdp.IdCartaDePorte, -1))) _
            '                Or cdp.SubnumeroDeFacturacion > 0 And  _
            '          ).ToList








            '¿como hacer la union de la consulta de titular, y el filtro de cartas problematicas, así queda el skiptake al final

            Debug.Print(lista.Count)



            ErrHandler2.WriteError("punto 2. tanda " & sesionId)

            'ejecutar inmediatamente LINQ usando la conversion a .ToList()
            'http://blogs.msdn.com/b/charlie/archive/2007/12/09/deferred-execution.aspx
            Dim IdsEnElAutomatico = (From i In lista Select i.IdCartaDePorte).ToList
            Debug.Print(IdsEnElAutomatico.ToString)



            ReasignarParaElTitularALasCartasSinClienteAutomaticoEncontrado(lista, sesionId, sesionIdposta, tildadosEnPrimerPasoLongs, bNoUsarLista, IdsEnElAutomatico, SC)



            'como agregar las cartas sin automatico posible? haces un filtro de lo que vino con las Id tildadas en el primer paso, antes de filtrar por repetido. Si no vino nada, es que no hay automatico.
            Dim IdcartasSinAutomaticoEncontrado = (From i In tildadosEnPrimerPasoLongs Select id = CStr(i)
                                                   Where Not IdsEnElAutomatico.Contains(CLng(id))).ToArray





            ErrHandler2.WriteError("punto 3. tanda " & sesionId)




            ErrHandler2.WriteError("Cartas sin automatico encontrado " & IdcartasSinAutomaticoEncontrado.Count)



            'TO DO: avisar que no se les encontró automático


            If IdcartasSinAutomaticoEncontrado.Count > 0 And Not bNoUsarLista Then
                Dim sWhere = " AND IdCartaDePorte IN (" & Join(IdcartasSinAutomaticoEncontrado, ",") & ")"

                '///////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////

                'ineficiente
                Dim dtForzadasAlTitular = SQLSTRING_FacturacionCartas_por_Titular(sWhere, SC, sesionIdposta)

                ErrHandler2.WriteError("punto 4. tanda " & sesionId)
                'ineficiente
                For Each cdp In dtForzadasAlTitular.Rows
                    Dim x As New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult
                    With x
                        .ColumnaTilde = CInt(cdp("ColumnaTilde"))
                        .IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte")))
                        .IdArticulo = CInt(iisNull(cdp("IdArticulo")))
                        .NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"))

                        Try
                            .SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon")))
                        Catch ex As Exception
                            'raro
                            ErrHandler2.WriteError(ex)
                        End Try

                        .SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0))


                        '                        buenosaires@ williamsentregas.com.ar
                        'Archivos adjuntos10:43 (hace 7 minutos)

                        '                        para(mí, soporte)

                        'Hubo un error!

                        '_
                        'URL:	/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados
                        'User:                   dberzoni()
                        '                        Exception Type : System.InvalidCastException()
                        'Message:	Conversion from string "" to type 'Date' is not valid.
                        'Stack Trace:	at Microsoft.VisualBasic.CompilerServices.Conversions.ToDate(String Value)
                        'at Microsoft.VisualBasic.CompilerServices.Conversions.ToDate(Object Value)
                        'TO DO 

                        .FechaArribo = CDate(iisNull(cdp("FechaArribo"), Today))
                        .FechaDescarga = CDate(iisNull(cdp("FechaDescarga"), Today))



                        .FacturarselaA = CStr(iisNull(cdp("FacturarselaA")))
                        .IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA")))
                        .Confirmado = iisNull(cdp("Confirmado"))
                        .IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1))
                        .CUIT = CStr(iisNull(cdp("CUIT")))
                        .ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado")))
                        .TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0))
                        .Producto = CStr(iisNull(cdp("Producto")))
                        .KgNetos = CDec(iisNull(cdp("KgNetos")))
                        .IdCorredor = CInt(iisNull(cdp("IdCorredor")))
                        .IdTitular = CInt(iisNull(cdp("IdTitular")))
                        .IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1))
                        .IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1))
                        .IdDestinatario = CInt(iisNull(cdp("IdDestinatario")))
                        .Titular = CStr(iisNull(cdp("Titular")))
                        .Intermediario = CStr(iisNull(cdp("Intermediario")))
                        .R__Comercial = CStr(iisNull(cdp("R. Comercial")))
                        .Corredor = CStr(iisNull(cdp("Corredor ")))
                        .Destinatario = CStr(iisNull(cdp("Destinatario")))
                        .DestinoDesc = CStr(iisNull(cdp("DestinoDesc")))
                        .Procedcia_ = CStr(iisNull(cdp("Procedcia.")))
                        .IdDestino = CInt(iisNull(cdp("IdDestino")))
                        .AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos")))
                        lista.Add(x)
                    End With
                Next
            End If




            'consulta 8413
            '        * Ordenar alfabeticamente por la columna "Facturarle a"
            '       * Poner las que tienen tarifa en 0 al principio

            'Dim unionAutomaticoConTitularesDefault = (From i In lista).Union( _
            '                From cdp In dtForzadasAlTitular.AsEnumerable _
            '                Select _
            '                ColumnaTilde = CInt(cdp("ColumnaTilde")), _
            '                IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte"))), _
            '                IdArticulo = CInt(iisNull(cdp("IdArticulo"))), _
            '                NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte")), _
            '                SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon"))), _
            '                SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"))), _
            '                FechaArribo = CDate(iisNull(cdp("FechaArribo"))), _
            '                FechaDescarga = CDate(iisNull(cdp("FechaDescarga"))), _
            '                FacturarselaA = CDate(iisNull(cdp("FacturarselaA"))), _
            '                IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA"))), _
            '                Confirmado = iisNull(cdp("Confirmado")), _
            '                IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"))), _
            '                CUIT = CStr(iisNull(cdp("CUIT"))), _
            '                ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado"))), _
            '                TarifaFacturada = iisNull(cdp("wTarifaWilliams")), _
            '                Producto = CStr(iisNull(cdp("Producto"))), _
            '                KgNetos = CDec(iisNull(cdp("KgNetos"))), _
            '                IdCorredor = CInt(iisNull(cdp("IdCorredor"))), _
            '                IdTitular = CInt(iisNull(cdp("IdTitular"))), _
            '                IdIntermediario = CInt(iisNull(cdp("IdIntermediario"))), _
            '                IdRComercial = CInt(iisNull(cdp("IdRComercial"))), _
            '                IdDestinatario = CInt(iisNull(cdp("IdDestinatario"))), _
            '                Titular = CStr(iisNull(cdp("Titular"))), _
            '                Intermediario = CStr(iisNull(cdp("Intermediario"))), _
            '                R__Comercial = CStr(iisNull(cdp("R__Comercial"))), _
            '                Corredor_ = CStr(iisNull(cdp("Corredor_"))), _
            '                Destinatario = CStr(iisNull(cdp("Destinatario"))), _
            '                DestinoDesc = CStr(iisNull(cdp("DestinoDesc"))), _
            '                Procedcia_ = CStr(iisNull(cdp("Procedcia_"))), _
            '                IdDestino = CInt(iisNull(cdp("IdDestino"))) _
            '                )



            'dtAutomatico = DataTableUNION(dtAutomatico, dtForzadasAlTitular)



            '///////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////

            ErrHandler2.WriteError("punto 5. tanda " & sesionId)




            PreProcesos(lista, SC, desde, hasta, puntoVenta, slinks)


            PostProcesos(lista, optFacturarA, agruparArticulosPor, SC)

            'EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado(lista, SC)
            'PostProcesoFacturacion_ReglaExportadores(lista, SC)




            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'guardo los datos temporales
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////

            ErrHandler2.WriteError("punto 6. tanda " & sesionId)
            Randomize()
            pag = 1
            sesionId = CInt(Rnd() * 10000)


            Dim c = ExecDinamico(SC, "select count(*) from wTempCartasPorteFacturacionAutomatica")
            If c.Rows(0).Item(0) > 40000 Then
                ExecDinamico(SC, "DELETE wTempCartasPorteFacturacionAutomatica")
            End If


            Dim dt = ExecDinamico(SC, "SELECT * FROM wTempCartasPorteFacturacionAutomatica where 1=0")

            Dim l As New Generic.List(Of wTempCartasPorteFacturacionAutomatica)
            For Each x In lista
                Dim a = New wTempCartasPorteFacturacionAutomatica
                a.IdSesion = sesionId

                a.IdCartaDePorte = x.IdCartaDePorte
                a.IdFacturarselaA = x.IdFacturarselaA
                a.TarifaFacturada = x.TarifaFacturada
                a.ClienteSeparado = x.ClienteSeparado
                a.ColumnaTilde = x.ColumnaTilde
                a.Confirmado = x.Confirmado
                a.Corredor = x.Corredor
                a.Corredor = x.ClienteSeparado
                a.FacturarselaA = Left(iisNull(x.FacturarselaA, ""), 50) 'esto puede traer problemas?
                a.KgNetos = iisNull(x.KgNetos, 0)
                a.DestinoDesc = x.DestinoDesc
                a.NumeroCartaDePorte = iisNull(x.NumeroCartaDePorte, -10)
                a.SubNumeroVagon = x.SubNumeroVagon
                a.SubnumeroDeFacturacion = x.SubnumeroDeFacturacion
                a.FechaArribo = x.FechaArribo
                a.FechaDescarga = x.FechaDescarga
                a.Producto = x.Producto
                a.IdArticulo = x.IdArticulo
                a.IdCodigoIVA = x.IdCodigoIVA
                a.CUIT = x.CUIT
                a.IdDestino = x.IdDestino
                a.Procedcia = x.Procedcia_
                a.Destinatario = x.Destinatario
                a.Titular = Left(x.Titular, 50)
                a.RComercial = x.R__Comercial
                a.IdIntermediario = x.IdIntermediario
                a.IdCorredor = x.IdCorredor
                a.IdTitular = x.IdTitular
                a.IdRComercial = x.IdRComercial
                a.IdIntermediario = x.IdIntermediario
                a.IdRComercial = x.IdRComercial

                a.AgregaItemDeGastosAdministrativos = x.AgregaItemDeGastosAdministrativos

                ' l.Add(a) 'con linq
                dt.Rows.Add(Nothing, a.IdSesion, x.IdCartaDePorte) 'con datatable
            Next


            'se podría usar bulkCopy http://msdn.microsoft.com/en-us/library/system.data.sqlclient.sqlbulkcopy.aspx
            ' db.wTempCartasPorteFacturacionAutomaticas.InsertAllOnSubmit(l)
            ' db.SubmitChanges()


            If False Then 'con el datatable no anduvo mas rapido
                Dim myConnection = New SqlConnection(Encriptar(SC))
                myConnection.Open()
                Dim adapterForTable1 = New SqlDataAdapter("select * from  wTempCartasPorteFacturacionAutomatica ", myConnection)
                Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
                'si te tira error acá, ojito con estar usando el dataset q usaste para el 
                'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
                adapterForTable1.Update(dt)
            End If

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////


            'Dim liston = (From i In lista Select i, IdSesion = ViewState("sesionId")).ToList

            'Dim listaConOrden = (From i In lista Order By (IIf(i.TarifaFacturada = 0, " ", "") & i.FacturarselaA) Ascending).ToList

            For Each r In lista
                r.Titular = Left(r.Titular, 50)
                r.FacturarselaA = Left(r.FacturarselaA, 50)
            Next

            Dim dtlista As DataTable = ToDataTableNull(lista)
            dtlista.Columns.Remove("IdCartaOriginal")

            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "IdSesion"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = sesionId ' ViewState("sesionId")
            End With
            dtlista.Columns.Add(dc)
            'For Each r In dtlista
            '    r("IdSesion") = ViewState("sesionId")
            'Next

            ErrHandler2.WriteError("punto 7. tanda " & sesionId)

            BulkCopy(dtlista, SC)


            filas = dtlista.Rows.Count


            ErrHandler2.WriteError("salgo. tanda " & sesionId)

        Catch ex As Exception
            ErrHandler2.WriteError("generarTabla")
            ErrHandler2.WriteError(ex)
            Throw
        End Try

    End Sub


    Shared Function GetDatatableAsignacionAutomatica(ByVal SC As String, ByRef pag As Object,
                                                 ByRef sesionId As Object,
                                                 ByVal iPageSize As Long, ByVal puntoVenta As Integer,
                                                 ByVal desde As Date, ByVal hasta As Date,
                                                 ByRef sErrores As String, AgruparArticulosPor As String, ByRef filas As Object,
                                                 ByRef slinks As Object, sesionIdposta As String) As DataTable



        Return GetDatatableAsignacionAutomatica(SC, pag, sesionId, iPageSize, puntoVenta, desde, hasta,
                                                  "", "", 1,
                                                "", SC, "", "",
                                                "", "", "", "",
                                                "", "", "", "", "", "", 0, 0, "", sErrores, "", AgruparArticulosPor, filas, slinks, sesionIdposta)


    End Function

    Shared Function GetDatatableAsignacionAutomatica(ByVal SC As String,
                                                 ByRef pag As Object,
                                                 ByRef sesionId As Object,
                                                 ByVal iPageSize As Long,
                    ByVal puntoVenta As Integer, ByVal desde As Date, ByVal hasta As Date,
                    ByVal sLista As String, ByVal sWHEREadicional As String, ByVal optFacturarA As Long,
                    ByVal txtFacturarATerceros As String, ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String,
                    ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String,
                    ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, ByVal txtBuscar As String,
                    ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, ByVal optDivisionSyngenta As String,
                      ByVal startRowIndex As Long, ByVal maximumRows As Long, ByVal txtPopClienteAuxiliar As String, ByRef sErrores As String,
                          txtFacturarA As String, agruparArticulosPor As String, ByRef filas As Object, ByRef slinks As Object, sesionIdposta As String) As DataTable

        'Si una Carta de Porte no tiene ningún cliente que tenga marcado en que si aparece en 
        'esa posición se le debe facturar, entonces se le facturará al 

        ErrHandler2.WriteError("entrando en GetDatatableAsignacionAutomatica . tanda " & sesionId)


        '        por qué puede ser que no haya sesionId???


        '        Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:en donde explota? no encuentra un cliente tercero, entonces explota

        '        Log Entry
        '01/30/2015 16:41:23
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:entrando en GetDatatableAsignacionAutomatica . tanda 



        Try


            'Dim pag As Integer = Val(ViewState("pagina"))
            If pag <= 0 Then pag = 1


            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            sesionId = Val(sesionId)
            Dim ids As Integer = sesionId ' Val(ViewState("sesionId"))
            If sesionId <= 0 Then
                If optFacturarA = 5 Then
                    generarTabla(SC, pag, sesionId, iPageSize, puntoVenta, desde, hasta,
                             sLista, False, optFacturarA, agruparArticulosPor, filas, slinks, sesionIdposta)
                Else
                    generarTablaParaModosNoAutomaticos(SC, pag, sesionId, sLista, "", optFacturarA,
                                                    txtFacturarATerceros, HFSC, txtTitular, txtCorredor,
                                                    txtDestinatario, txtIntermediario, txtRcomercial, txt_AC_Articulo,
                                                    txtProcedencia, txtDestino, txtBuscar, cmbCriterioWHERE,
                                                    cmbmodo, optDivisionSyngenta, desde, hasta,
                                                     puntoVenta, startRowIndex, maximumRows, txtPopClienteAuxiliar, sErrores,
                                                      txtFacturarA, agruparArticulosPor, filas, slinks, sesionIdposta)
                End If
                'sesionId = ViewState("sesionId")
                ids = sesionId
            End If



            ErrHandler2.WriteError("punto 2 en GetDatatableAsignacionAutomatica . tanda " & sesionId)


            Dim dtlistaAuto As DataTable

            'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
            'db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))
            Using db As New LinqCartasPorteDataContext(Encriptar(SC))

                Dim o = (From i In db.wTempCartasPorteFacturacionAutomaticas
                         Where i.IdSesion = ids
                         Order By CStr(IIf(i.TarifaFacturada = 0, " ", "")) & CStr(i.FacturarselaA) & CStr(i.NumeroCartaDePorte.ToString) Ascending
                         Select i.ColumnaTilde, i.IdCartaDePorte, i.IdArticulo, i.NumeroCartaDePorte, i.SubNumeroVagon, i.SubnumeroDeFacturacion,
                             i.FechaArribo, i.FechaDescarga, i.FacturarselaA, i.IdFacturarselaA, i.Confirmado, i.IdCodigoIVA,
                             i.CUIT, i.ClienteSeparado, i.TarifaFacturada, i.Producto, i.KgNetos, i.IdCorredor, i.IdTitular,
                             i.IdIntermediario, i.IdRComercial,
                             idDestinatario = 0, i.Titular, Intermediario = "", i.RComercial, i.Corredor, i.Destinatario,
                             i.DestinoDesc, i.Procedcia, i.IdDestino, i.IdTempCartasPorteFacturacionAutomatica, i.AgregaItemDeGastosAdministrativos
                         Skip (pag - 1) * iPageSize Take iPageSize
                    ).ToList



                'RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal()


                ErrHandler2.WriteError("punto 3 en GetDatatableAsignacionAutomatica . tanda " & sesionId)

                dtlistaAuto = ToDataTableNull(o)
                dtlistaAuto.Columns.Remove("IdTempCartasPorteFacturacionAutomatica") 'parece q tengo q incluirla en LINQ porque sql2000 llora si no incluyo el ID al usa Skip
                'dtlistaAuto.Columns.Remove("IdSesion")
            End Using


            ErrHandler2.WriteError("punto 4 en GetDatatableAsignacionAutomatica . tanda " & sesionId)

            Return dtlistaAuto


            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
        Catch ex As Exception
            ErrHandler2.WriteError("explota en GetDatatableAsignacionAutomatica")
            Throw

        End Try



    End Function


    '/////////////////////////////////////////////////////////////////////////////////////////////////


    'http://stackoverflow.com/a/9405173/1054200 la idea era usar el truco de los genericos, y terminé haciendo una grasada
    ' http://www.elguille.info/net/revistas/dotnetmania/pdf/dotnetmania_8.pdf
    Public Shared Function ToDataTableNull(Of T)(ByVal data As Generic.IList(Of T)) As DataTable


        Dim props As System.ComponentModel.PropertyDescriptorCollection = System.ComponentModel.TypeDescriptor.GetProperties(GetType(T))
        Dim table As New DataTable()
        For i As Integer = 0 To props.Count - 1
            Dim prop As System.ComponentModel.PropertyDescriptor = props(i)
            table.Columns.Add(prop.Name, If(Nullable.GetUnderlyingType(prop.PropertyType), prop.PropertyType))
        Next
        Dim values As Object() = New Object(props.Count - 1) {}
        For Each item As T In data
            For i As Integer = 0 To values.Length - 1
                values(i) = If(props(i).GetValue(item), DBNull.Value)
            Next
            table.Rows.Add(values)
        Next
        Return table
    End Function


    '/////////////////////////////////////////////////////////////////////////////////////////////////


    Shared Function GetIQueryableAsignacionAutomatica(ByVal SC As String,
                                                 ByRef pag As Object,
                                                 ByRef sesionId As Object,
                                ByVal iPageSize As Long, ByVal puntoVenta As Integer, ByVal desde As Date, ByVal hasta As Date,
                   ByVal sLista As String, ByVal sWHEREadicional As String, ByVal optFacturarA As Long,
                   ByVal txtFacturarATerceros As String, ByVal HFSC As String, ByVal txtTitular As String, ByVal txtCorredor As String,
                   ByVal txtDestinatario As String, ByVal txtIntermediario As String, ByVal txtRcomercial As String,
                   ByVal txt_AC_Articulo As String, ByVal txtProcedencia As String, ByVal txtDestino As String, ByVal txtBuscar As String,
                   ByVal cmbCriterioWHERE As String, ByVal cmbmodo As String, ByVal optDivisionSyngenta As String, ByVal txtFechaDesde As String, ByVal txtFechaHasta As String, ByVal cmbPuntoVenta As String,
                    ByVal startRowIndex As Long, ByVal maximumRows As Long, ByVal txtPopClienteAuxiliar As String, ByRef sErrores As String, txtFacturarA As String, ByRef filas As Object, ByRef slinks As Object _
                    , bNoUsarLista As Boolean,
                     referenciaDB As LinqCartasPorteDataContext _
                        , agruparArticulosPor As String, sesionIdposta As String
                    ) As IQueryable(Of wTempCartasPorteFacturacionAutomatica)

        'Si una Carta de Porte no tiene ningún cliente que tenga marcado en que si aparece en 
        'esa posición se le debe facturar, entonces se le facturará al 


        Try


            'Dim pag As Integer = Val(ViewState("pagina"))
            If pag <= 0 Then pag = 1


            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

            Dim ids As Integer = sesionId ' Val(ViewState("sesionId"))
            If sesionId <= 0 Then
                If optFacturarA = 5 Then
                    generarTabla(SC, pag, sesionId, iPageSize, puntoVenta, desde, hasta, sLista, bNoUsarLista, optFacturarA, agruparArticulosPor, filas, slinks, sesionIdposta)
                Else
                    generarTablaParaModosNoAutomaticos(SC, pag, sesionId, sLista, "", optFacturarA,
                                                    txtFacturarATerceros, HFSC, txtTitular, txtCorredor,
                                                    txtDestinatario, txtIntermediario, txtRcomercial, txt_AC_Articulo,
                                                    txtProcedencia, txtDestino, txtBuscar, cmbCriterioWHERE,
                                                    cmbmodo, optDivisionSyngenta, txtFechaDesde, txtFechaHasta,
                                                    cmbPuntoVenta, startRowIndex, maximumRows, txtPopClienteAuxiliar, sErrores, txtFacturarA, agruparArticulosPor, filas, slinks, sesionIdposta)
                End If
                'ids = ViewState("sesionId")
            End If

            Dim db As New LinqCartasPorteDataContext
            If referenciaDB Is Nothing Then
                db = New LinqCartasPorteDataContext(Encriptar(SC))
            Else
                db = referenciaDB
            End If


            Dim o As IQueryable(Of wTempCartasPorteFacturacionAutomatica) = (From i In db.wTempCartasPorteFacturacionAutomaticas
                                                                             Where i.IdSesion = ids
                                                                             Order By CStr(IIf(i.TarifaFacturada = 0, " ", "")) & CStr(i.FacturarselaA) & CStr(i.NumeroCartaDePorte.ToString) Ascending
                                                                             Select i
                                                                             Skip (pag - 1) * iPageSize Take iPageSize
                )

            If referenciaDB Is Nothing Then db = Nothing

            'RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal()



            Return o


            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
        Catch ex As Exception
            ErrHandler2.WriteError("explota en GetDatatableAsignacionAutomatica")
            Throw

        End Try

    End Function



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Shared Sub ActualizarCampoClienteSeparador(ByRef dt As DataTable, ByVal SeSeparaPorCorredor_O_porTitular As Boolean, ByVal sc As String, Optional sesion As Integer = -1)

        'TODO: funcion ineficiente
        '-es porque las llamadas a EsteCorredor...() son ineficientes...

        'por qué necesito esta funcion??? efectivamente, me pisa lo que emparché en CasoSyngenta() y EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado()
        'por qué necesito esta funcion???

        Dim r = 0
        Dim total = dt.Rows.Count
        ErrHandler2.WriteError("ActualizarCampoClienteSeparador " & total & " filas")

        Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", sc)

        Dim flag = SeSeparaPorCorredor_O_porTitular





        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        Dim oo = (From i In db.wTempCartasPorteFacturacionAutomaticas
                  Join c In db.linqClientes On i.IdFacturarselaA Equals c.IdCliente
                  Where i.IdSesion = sesion
                  Select If(i.IdCartaDePorte, -1)
           ).ToList
        '                Select i.IdCartaDePorte, c.RazonSocial, c.ExpresionRegularNoAgruparFacturasConEstosVendedores _

        Dim u = oo.Distinct()
        If u.Count <> oo.Count Then
            MandarMailDeError("da distinta la agrupacion en ActualizarCampoClienteSeparador. Ver cómo agrupar")

        End If

        Dim o = u.ToDictionary(Function(x) x, Function(x) x.ToString())
        'Dim o = u.ToDictionary(Function(x) x.IdCartaDePorte, Function(x) x.ExpresionRegularNoAgruparFacturasConEstosVendedores)



        'por qué necesito esta funcion??? efectivamente, me pisa lo que emparché en CasoSyngenta() y EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado()

        For Each row In dt.Rows
            If row("ClienteSeparado").ToString.Contains("montomax") Then Continue For
            If row("ClienteSeparado").ToString.Contains("renglones maximos") Then Continue For
            If row("ClienteSeparado").ToString.Contains("acopiosepara") Then Continue For

            row("ClienteSeparado") = 0

            If row("IdFacturarselaA") = idSyngentaAGRO Then Continue For 'conflictos con CasoSyngenta()

            If sesion <> -1 Then
                If o.Item(row("IdCartaDePorte")) = "" Then
                    'el valor de .ExpresionRegularNoAgruparFacturasConEstosVendedores es "" 

                    Continue For
                Else
                    Debug.Print(o.Item(row("IdCartaDePorte")))
                End If
            End If



            If flag Then

                'separando por corredores
                row("ClienteSeparado") = CartaDePorteManager.EsteCorredorSeleFacturaAlClientePorSeparadoId(row("IdFacturarselaA"), iisNull(row("IdCorredor"), -1), sc)

            Else
                'si le facturo al corredor, separo por titulares

                'row("ClienteSeparado") = CartaDePorteManager.EsteTitularSeleFacturaAlCorredorPorSeparadoId(iisNull(row("idCartadePorte"), -1), sc.Value)
                row("ClienteSeparado") = CartaDePorteManager.EsteClienteSeleFacturaAlCorredorPorSeparadoId(iisNull(row("IdTitular"), -1), iisNull(row("IdCorredor"), -1), sc)
            End If

            r = r + 1
        Next

    End Sub


    Shared Sub CasosSyngenta_y_Acopios(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)


        'Para la facturación automática, de haber cartas de porte Agro y cartas de Porte Seeds, armar dos facturas separadas.
        'Como las cartas de porte duplicadas solamente se pueden facturar mediante la facturación automática, entran en el automático.
        ' Para que no se pase la facturación separada, armar dos facturas distintas automaticamente.


        'A nombre de AGRO las dos?    -SOLO DOS????
        '-si las dos facturas van a ser a nombre de agro, cómo le aviso a GenerarLoteFacturas_NUEVO() que , sin usar el truco del corredor, 2 que tienen 
        'el mismo idFacturarselaA  salen en 2 facturas distintas???
        '-muy facil chavalín: con el ClienteSeparado

        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'la datatable "tablaEditadaDeFacturasParaGenerar" se está quedando sin el dato de ClienteSeparado que viene en la datatable "dtf"!!!!!!!!
        'Dim tablaEditadaDeFacturasParaGenerar As DataTable = DataTableUNION(dtf, dtItemsManuales)  
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO
        'BUG BUG en GenerarLoteFacturas_NUEVO


        'te lo pisa ActualizarCampoClienteSeparador(). tenes que verlo tambien ahí
        'te lo pisa ActualizarCampoClienteSeparador(). tenes que verlo tambien ahí
        'te lo pisa ActualizarCampoClienteSeparador(). tenes que verlo tambien ahí
        'te lo pisa ActualizarCampoClienteSeparador(). tenes que verlo tambien ahí



        '        dddddd()


        '        Log Entry
        '01/30/2015 16:41:16
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.InvalidOperationException
        'Sequence contains no elements
        '   at System.Data.Linq.SqlClient.SqlProvider.Execute(Expression query, QueryInfo queryInfo, IObjectReaderFactory factory, Object[] parentArgs, Object[] userArgs, ICompiledSubQuery[] subQueries, Object lastResult)
        '   at System.Data.Linq.SqlClient.SqlProvider.ExecuteAll(Expression query, QueryInfo[] queryInfos, IObjectReaderFactory factory, Object[] userArguments, ICompiledSubQuery[] subQueries)
        '   at System.Data.Linq.SqlClient.SqlProvider.System.Data.Linq.Provider.IProvider.Execute(Expression query)
        '   at System.Data.Linq.DataQuery`1.System.Linq.IQueryProvider.Execute[S](Expression expression)
        '   at System.Linq.Queryable.First[TSource](IQueryable`1 source)
        '   at LogicaFacturacion.CasosSyngenta_y_Acopios(List`1& listaDeCartasPorteAFacturar, String SC)
        '   at LogicaFacturacion.PreProcesos(List`1 lista, String SC, String desde, String hasta, String puntoVenta, Object& slinks)
        '   at LogicaFacturacion.generarTabla(String SC, Object& pag, Object& sesionId, Int64 iPageSize, Int32 puntoVenta, DateTime desde, DateTime hasta, String sLista, Boolean bNoUsarLista, Int64 optFacturarA, String agruparArticulosPor, Object& filas, Object& slinks, String sesionIdposta)
        '        System.Data.Linq()






        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim a As linqCliente

        Try
            Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC)
            Dim idSyngentaSEEDS = BuscaIdClientePreciso("NO USAR !!!SYNGENTA SEEDS S.A.", SC)
            Dim idLDC = 2775 ' ldc argentina? 'BuscaIdClientePreciso("LDC SEMILLAS", SC)
            Dim idA_C_A = 10 'BuscaIdClientePreciso("A.C.A", SC)

            Dim q = (From i In listaDeCartasPorteAFacturar
                     Where i.IdFacturarselaA = idSyngentaAGRO Or i.IdFacturarselaA = idLDC Or i.IdFacturarselaA = idA_C_A
                     Select i.IdCartaDePorte, i.IdFacturarselaA)

            For Each c In q


                Dim cartamapeada = (From x In db.CartasDePortes Where x.IdCartaDePorte = c.IdCartaDePorte).FirstOrDefault

                If cartamapeada Is Nothing Then
                    ErrHandler2WriteErrorLogPronto("casossyngenta_y_acopios: no encontró la carta " & c.IdCartaDePorte, SC, Membership.GetUser.UserName)
                    Continue For
                End If

                Dim tiposyng As String = cartamapeada.EnumSyngentaDivision

                Dim lambdaTemp = c
                Dim carta = listaDeCartasPorteAFacturar.Find(Function(o) o.IdCartaDePorte = lambdaTemp.IdCartaDePorte)

                If c.IdFacturarselaA = idSyngentaAGRO Then
                    If tiposyng = "Seeds" Then
                        carta.ClienteSeparado = idSyngentaSEEDS
                    Else
                        carta.ClienteSeparado = idSyngentaAGRO
                    End If
                Else

                    'revisar agrupadores de acopio

                    'Dim acopioseparado As Integer? = If(If(If(If(If(cartamapeada.AcopioFacturarleA, cartamapeada.Acopio1), cartamapeada.Acopio2), cartamapeada.Acopio3), cartamapeada.Acopio4), cartamapeada.Acopio5)

                    If False Then 'desactivar por ahora la separacion por acopio


                        Dim acopioseparado As Integer? = cartamapeada.AcopioFacturarleA
                        If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio1
                        If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio2
                        If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio3
                        If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio4
                        If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio5
                        If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio6

                        If If(acopioseparado, 0) > 0 Then carta.ClienteSeparado = "acopiosepara " & acopioseparado
                    End If
                End If

            Next

        Catch ex As OutOfMemoryException
            ErrHandler2.WriteError("Problema de linq en CasosSyngenta!!!!!")
            Throw
        Catch ex As Exception
            ErrHandler2.WriteError("CasosSyngenta")
            Throw
        End Try


        'CasosAcopio(listaDeCartasPorteAFacturar, SC, db)






    End Sub

    Shared Sub CasosAcopio(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String, db As LinqCartasPorteDataContext)
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////
        'refrescar ClienteSeparado con el acopio correspondiente
        '//////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////

        Dim cartas = From i In listaDeCartasPorteAFacturar Select i.IdCartaDePorte
        Dim q = db.CartasDePortes.Where(Function(x) cartas.Contains(x.IdCartaDePorte))
        Dim acopioseparado = q.Select(Function(x) If(If(If(If(If(If(x.AcopioFacturarleA, x.Acopio1), x.Acopio2), x.Acopio3), x.Acopio4), x.Acopio5), x.Acopio6))

        'carta.ClienteSeparado = "acopiosepara " & acopioseparado

    End Sub




    Shared Sub PostProcesoFacturacion_ReglaExportadores(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)
        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13223
        'Identificar a los clientes que son exportadores clientes de Williams con una marca en el formulario de clientes.
        'Si una carta de porte donde uno de estos clientes aparece como Destinatario, Intermediario o Rte Comercial se duplica y 
        'una copia es de entrega y una de exportación, en la copia de exportación el campo "Facturar a" debe completarse con el cliente en cuestión.
        'lo que no entiendo es el caso de uso
        'la duplican en el momento... y ahí no le ponen a quién se factura? No era obligatorio?

        ' La magia quedaría así: el usuario llena la carta, y pone grabar...
        'Si la carta usa un cliente exportador en Destinatario, Intermediario o Rte Comercial,
        'entonces te hago de prepo una duplicacion de la carta
        'La que queda como exportacion, tendrá el A Facturar con el dichoso cliente exportador
        'Y la otra carta, la local, quedará para que le rellenen el A Facturar, por las fuerzas superiores

        '-ok, así que lo solucionás en la carta, no en la facturacion. Joya Nano.

        'For Each x In listaDeCartasPorteAFacturar

        '    x.SubnumeroDeFacturacion>
        '        x.
        '    x.FacturarselaA
        'Next

        'Esto no debería hacerse cuando se hace la duplicancion

        'ssss()
    End Sub


    Shared Sub SepararAcopiosLDCyACA(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)

        Return

        'esto es porque para syngenta querrían separar 
        'Buen día Andrés, como te adelanté por teléfono, necesito que en el caso del cliente Syngenta, Agro y Seeds, 
        '    cada factura corte en $ 8.000 final. Ësto podré tenerlo para esta facturación?
        'Aguardo(respuesta.Gracias)
        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=12878

        '-recordemos que para facturar, agrupo por [IdFacturarselaA , ClienteSeparado]

        'revisá el metodo CasosSyngenta()

        'no me pisará ActualizarCampoClienteSeparador()?

        Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC)
        Dim idSyngentaSEEDS = BuscaIdClientePreciso("NO USAR !!!SYNGENTA SEEDS S.A.", SC)

        Dim montomax As Decimal
        Try
            montomax = ParametroManager.TraerValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try
        If montomax = 0 Then
            ParametroManager.GuardarValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte", "150")
            montomax = ParametroManager.TraerValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte")
        End If



        Dim clientescontrolados As New List(Of Integer)
        'clientescontrolados.Add(idSyngentaAGRO)
        'clientescontrolados.Add(idSyngentaSEEDS)
        'clientescontrolados.Add(2871) ' grobo



        Dim q = (From i In listaDeCartasPorteAFacturar
                 Group By i.IdFacturarselaA, i.ClienteSeparado
             Into g = Group
                 Select New With {
                 IdFacturarselaA,
                 ClienteSeparado,
                 .Monto = g.Sum(Function(x) x.KgNetos * x.TarifaFacturada / 1000 * 1.21)
             }
        ).ToList()

        Dim q2 = q.Where(Function(x) x.Monto > montomax And (clientescontrolados.Contains(x.IdFacturarselaA) Or True)).ToList()




        'Dim l As String = iisNull(EntidadManager.ExecDinamico(SC, "SELECT ExpresionRegularNoAgruparFacturasConEstosVendedores FROM Clientes WHERE IdCliente=" & IdClienteEquivalenteAlCorredor).Rows(0).Item(0), "")
        'ParametroManager.GuardarValorParametro2(SC, "MontoMaximoCartaPorteClientes", "SYNGENTA AGRO S.A.|SYNGENTA SEEDS S.A.")
        Dim l As String = ParametroManager.TraerValorParametro2(SC, "MontoMaximoCartaPorteClientes").ToString()

        Dim a() As String = Split(l, "|")

        For Each s In a
            If s = "" Then Continue For
            Dim idcliente As Long = BuscaIdClientePreciso(s, SC)
            clientescontrolados.Add(idcliente)
        Next



        'se debe ejecutar despues del filtro de cartas conflictivas
        Dim total As Decimal = 0
        Dim reasignador As Integer = 0
        Dim ClienteSeparadoanterior As String
        listaDeCartasPorteAFacturar = listaDeCartasPorteAFacturar.OrderBy(Function(x) x.FacturarselaA).ThenBy(Function(x) x.ClienteSeparado).ToList()
        For n = 0 To listaDeCartasPorteAFacturar.Count - 1
            Dim x = listaDeCartasPorteAFacturar(n)
            Dim xant = listaDeCartasPorteAFacturar(IIf(n > 0, n - 1, 0))


            If x.ClienteSeparado <> ClienteSeparadoanterior Or x.IdFacturarselaA <> xant.IdFacturarselaA Then
                total = 0
            End If

            total += x.KgNetos * x.TarifaFacturada / 1000 * 1.21

            If total > montomax And clientescontrolados.Contains(x.IdFacturarselaA) Then
                reasignador += 1
                total = x.KgNetos * x.TarifaFacturada / 1000 * 1.21 'reinicia el total
            End If

            ClienteSeparadoanterior = x.ClienteSeparado

            If reasignador > 0 And clientescontrolados.Contains(x.IdFacturarselaA) Then
                x.ClienteSeparado = (reasignador).ToString() + "° montomaximo" + " " + x.ClienteSeparado + "" 'le reasigno un clienteseparador de fantasía, ya que no tengo un tempIdFacturaAgenerar"
            End If
        Next

    End Sub


    Shared Sub EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)
        'esto es porque para syngenta querrían separar 
        'Buen día Andrés, como te adelanté por teléfono, necesito que en el caso del cliente Syngenta, Agro y Seeds, 
        '    cada factura corte en $ 8.000 final. Ësto podré tenerlo para esta facturación?
        'Aguardo(respuesta.Gracias)
        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=12878

        '-recordemos que para facturar, agrupo por [IdFacturarselaA , ClienteSeparado]

        'revisá el metodo CasosSyngenta()

        'no me pisará ActualizarCampoClienteSeparador()?

        Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC)
        Dim idSyngentaSEEDS = BuscaIdClientePreciso("NO USAR !!!SYNGENTA SEEDS S.A.", SC)

        Dim montomax As Decimal
        Try
            montomax = ParametroManager.TraerValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try
        If montomax = 0 Then
            ParametroManager.GuardarValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte", "150")
            montomax = ParametroManager.TraerValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte")
        End If



        Dim clientescontrolados As New List(Of Integer)
        'clientescontrolados.Add(idSyngentaAGRO)
        'clientescontrolados.Add(idSyngentaSEEDS)
        'clientescontrolados.Add(2871) ' grobo



        Dim q = (From i In listaDeCartasPorteAFacturar
                 Group By i.IdFacturarselaA, i.ClienteSeparado
             Into g = Group
                 Select New With {
                 IdFacturarselaA,
                 ClienteSeparado,
                 .Monto = g.Sum(Function(x) x.KgNetos * x.TarifaFacturada / 1000 * 1.21)
             }
        ).ToList()

        Dim q2 = q.Where(Function(x) x.Monto > montomax And (clientescontrolados.Contains(x.IdFacturarselaA) Or True)).ToList()




        'Dim l As String = iisNull(EntidadManager.ExecDinamico(SC, "SELECT ExpresionRegularNoAgruparFacturasConEstosVendedores FROM Clientes WHERE IdCliente=" & IdClienteEquivalenteAlCorredor).Rows(0).Item(0), "")
        'ParametroManager.GuardarValorParametro2(SC, "MontoMaximoCartaPorteClientes", "SYNGENTA AGRO S.A.|SYNGENTA SEEDS S.A.")
        Dim l As String = ParametroManager.TraerValorParametro2(SC, "MontoMaximoCartaPorteClientes").ToString()

        Dim a() As String = Split(l, "|")

        For Each s In a
            If s = "" Then Continue For
            Dim idcliente As Long = BuscaIdClientePreciso(s, SC)
            clientescontrolados.Add(idcliente)
        Next



        'se debe ejecutar despues del filtro de cartas conflictivas
        Dim total As Decimal = 0
        Dim reasignador As Integer = 0
        Dim ClienteSeparadoanterior As String = ""
        listaDeCartasPorteAFacturar = listaDeCartasPorteAFacturar.OrderBy(Function(x) x.FacturarselaA).ThenBy(Function(x) x.ClienteSeparado).ToList()
        For n = 0 To listaDeCartasPorteAFacturar.Count - 1
            Dim x = listaDeCartasPorteAFacturar(n)
            Dim xant = listaDeCartasPorteAFacturar(IIf(n > 0, n - 1, 0))


            '/////////////////////////////////////////////////////////////////////
            If x.ClienteSeparado = "-1" Then x.ClienteSeparado = ""
            '////////////////////////////////////////////////////////////////////////


            If (x.ClienteSeparado <> ClienteSeparadoanterior And x.ClienteSeparado <> x.IdFacturarselaA.ToString) Or x.IdFacturarselaA <> xant.IdFacturarselaA Then
                total = 0
            End If

            total += x.KgNetos * x.TarifaFacturada / 1000 * 1.21

            If total > montomax And clientescontrolados.Contains(x.IdFacturarselaA) Then
                reasignador += 1
                total = x.KgNetos * x.TarifaFacturada / 1000 * 1.21 'reinicia el total
            End If

            ClienteSeparadoanterior = x.ClienteSeparado

            If reasignador > 0 And clientescontrolados.Contains(x.IdFacturarselaA) Then
                x.ClienteSeparado = (reasignador).ToString() + "° montomaximo" + " " + x.ClienteSeparado + "" 'le reasigno un clienteseparador de fantasía, ya que no tengo un tempIdFacturaAgenerar"
            End If
        Next


        'no me pisará ActualizarCampoClienteSeparador()?

    End Sub


    Shared Sub EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones _
        (ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult),
          ByVal optFacturarA As Integer, ByVal agruparArticulosPor As String, ByVal SC As String,
                                        ByVal sBusqueda As String)



        '-recordemos que para facturar, agrupo por [IdFacturarselaA , ClienteSeparado]


        Dim clientescontrolados As New List(Of Integer)
        'clientescontrolados.Add(idSyngentaAGRO)
        'clientescontrolados.Add(idSyngentaSEEDS)
        'clientescontrolados.Add(2871) ' grobo


        Dim q = (From i In listaDeCartasPorteAFacturar
                 Group By i.IdFacturarselaA, i.ClienteSeparado
             Into g = Group
                 Select New With {
                 IdFacturarselaA,
                 ClienteSeparado
             }
        ).ToList()

        'Dim q2 = q.Where(Function(x) x.Monto > montomax And (clientescontrolados.Contains(x.IdFacturarselaA) Or True)).ToList()



        'Dim a() As String = Split(l, "|")

        'For Each s In a
        '    If s = "" Then Continue For
        '    Dim idcliente As Long = BuscaIdClientePreciso(s, SC)
        '    clientescontrolados.Add(idcliente)
        'Next

        'Dim lotecito = (From i In tablaEditadaDeFacturasParaGenerarComoLista _
        '            Where i.FacturarselaA = cli And i.ClienteSeparado = clisep _
        '         ).ToList

        Dim reasignador As Integer = 1



        For Each owhere In q

            Dim cli = owhere.IdFacturarselaA
            Dim clisep = owhere.ClienteSeparado





            Dim lotecito As List(Of CartaDePorte) = (From c In listaDeCartasPorteAFacturar
                                                     Where c.IdFacturarselaA = cli And c.ClienteSeparado = clisep
                                                     Select New CartaDePorte With {
                                                     .IdArticulo = If(c.IdArticulo, -1) _
                                                      , .Destino = If(c.IdDestino, -1),
                                                .Titular = If(c.IdTitular, -1),
                                            .Entregador = If(c.IdDestinatario, -1),
                                            .NetoFinalIncluyendoMermas = c.KgNetos,
                                        .TarifaCobradaAlCliente = c.TarifaFacturada
                                                 }
                 ).ToList

            Dim grupo As IEnumerable(Of grup) = AgruparItemsDeLaFactura(lotecito, optFacturarA, agruparArticulosPor, SC, sBusqueda)
            grupo.ToList()

            If grupo.Count > MAXRENGLONES Then
                For n = MAXRENGLONES To grupo.Count - 1
                    'marco esas cartas como de otra agrupacion

                    Dim g = grupo(n)

                    Dim carts = From c In listaDeCartasPorteAFacturar
                                Where (g.IdArticulo = -1 Or c.IdArticulo = g.IdArticulo) _
                                And (g.Destino = -1 Or c.IdDestino = g.Destino) _
                                And (g.Entregador = -1 Or c.IdDestinatario = g.Entregador) _
                                And (g.Titular = -1 Or c.IdTitular = g.Titular)



                    For Each cdp In carts

                        'Dim c As wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult = listaDeCartasPorteAFacturar.Where(Function(x) x.IdCartaDePorte = cdp.Id).FirstOrDefault
                        Dim c As wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult = cdp
                        c.ClienteSeparado = (reasignador).ToString() + "° renglones maximos" + " " + c.ClienteSeparado + "" 'le reasigno un clienteseparador de fantasía, ya que no tengo un tempIdFacturaAgenerar"

                    Next
                Next
            End If


        Next



    End Sub
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Shared Sub ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor(ByRef listaDeCartasPorteAFacturar As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal SC As String)

        Return 'se separa el corredor desde EsteCorredorSeleFacturaAlClientePorSeparadoId(). Esta funcion por ahora no sirve mas

        'todo
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim a As linqCliente

        Try
            Dim sss = (From i In listaDeCartasPorteAFacturar Select i.IdCartaDePorte, i.IdFacturarselaA).ToList

            Dim CartasAFacturarleAlCorredor = (From i In sss
                                               Join c In db.linqClientes On c.IdCliente Equals i.IdFacturarselaA
                                               Where c.SeLeDerivaSuFacturaAlCorredorDeLaCarta = "SI"
                                               Select i.IdCartaDePorte, i.IdFacturarselaA).ToList ', c.SeLeDerivaSuFacturaAlCorredorDeLaCarta

            For Each c In CartasAFacturarleAlCorredor
                Dim lambdaTemp = c
                Dim carta = listaDeCartasPorteAFacturar.Find(Function(o) o.IdCartaDePorte = lambdaTemp.IdCartaDePorte)
                carta.IdFacturarselaA = CartaDePorteManager.IdClienteEquivalenteDelIdVendedor(carta.IdCorredor, SC)
                carta.FacturarselaA = NombreCliente(SC, carta.IdFacturarselaA)


                'habría que refrescar tambien la tarifa? 
                carta.TarifaFacturada = iisNull(db.wTarifaWilliams(carta.IdFacturarselaA, carta.IdArticulo, carta.IdDestino, 0, carta.KgNetos), 0)

                'agregarlo a la lista de corredores que se le separa a este cliente????

                'pero de qué manera la paga? aparece en el encabezado, o el truco de pronto????
                '-pero eso se hace poniendolo en el "separar a corredor".... qué diferencia hay en esta funcionalidad?????

                'sería una extension del "separar estos corredores". Es decir, un check que diga "SEPARARLE TODOS"
                '-Creo que esa es la posta
            Next

        Catch ex As OutOfMemoryException
            ErrHandler2.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler2.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler2.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler2.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler2.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler2.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler2.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            ErrHandler2.WriteError("Problema de linq en ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor!!!!!")
            Throw
        Catch ex As Exception
            ErrHandler2.WriteError("ReasignarAquellosQueSeLeFacturanForzosamenteAlCorredor")
            Throw
        End Try


    End Sub

    Public Shared Function ListaEmbarques(ByVal sc As String, ByVal FechaDesde As Date, ByVal FechaHasta As Date, Optional ByVal idTitular As Integer = -1, Optional ByVal pventa As Integer = 0, Optional ByVal idQueContenga As Integer = -1)
        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        ' Dim q = From i In db.CartasPorteMovimientos
        Dim embarques = From i In db.CartasPorteMovimientos
                        Join c In db.linqClientes On c.IdCliente Equals i.IdExportadorOrigen
                        Where (
                          i.Tipo = 4 _
                          And If(i.Anulada, "NO") <> "SI" _
                          And (i.IdStock Is Nothing Or i.IdStock = pventa Or i.IdStock = 0 Or pventa = 0) _
                          And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta _
                          And (i.IdExportadorOrigen = idTitular Or idTitular = -1) _
                          And (idQueContenga = -1 Or i.IdExportadorOrigen = idQueContenga Or i.IdExportadorDestino = idQueContenga) _
                          And (i.IdFacturaImputada <= 0 Or i.IdFacturaImputada Is Nothing) _
                          And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta
                     )
                        Select i.IdCDPMovimiento, Producto = NombreArticulo(sc, i.IdArticulo), i.Cantidad, c.RazonSocial,
                            i.IdArticulo, i.FechaIngreso, i.IdExportadorOrigen, i.Puerto, i.Vapor

        Return embarques
    End Function


    Public Shared Function ListaEmbarquesQueryable(ByVal sc As String, ByVal FechaDesde As Date, ByVal FechaHasta As Date, Optional ByVal idTitular As Integer = -1, Optional ByVal pventa As Integer = 0,
                                               Optional ByVal idQueContenga As Integer = -1, Optional db2 As DemoProntoEntities = Nothing) As IQueryable(Of Models.CartasPorteMovimiento)
        'Dim db As New LinqCartasPorteDataContext(Encriptar(sc))


        Dim db As DemoProntoEntities

        If db2 Is Nothing Then
            db = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sc)))
        Else
            db = db2
        End If




        ' Dim q = From i In db.CartasPorteMovimientos
        Dim embarques = From i In db.CartasPorteMovimientos
                        Join c In db.Clientes On c.IdCliente Equals i.IdExportadorOrigen
                        Where (
                            i.Tipo = 4 _
                            And If(i.Anulada, "NO") <> "SI" _
                            And i.FechaIngreso >= FechaDesde And i.FechaIngreso <= FechaHasta _
                            And (i.IdExportadorOrigen = idTitular Or idTitular = -1) _
                            And (i.IdStock Is Nothing Or i.IdStock = pventa Or i.IdStock = 0 Or pventa = 0) _
                            And (idQueContenga = -1 Or i.IdExportadorOrigen = idQueContenga Or i.IdExportadorDestino = idQueContenga)
                       )
                        Select i

        '                                And (i.IdFacturaImputada <= 0 Or i.IdFacturaImputada Is Nothing) _






        Return embarques
    End Function




    Shared Sub AgregarEmbarques(ByRef lista As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByVal sc As String, ByVal FechaDesde As Date, ByVal FechaHasta As Date, Optional ByVal idTitular As Integer = -1, Optional ByVal pventa As Integer = 0)
        '* Los Movimientos que sean Embarques (solo los embarques) se facturarán como una Carta de Porte más. 
        'Tomar el cereal, la cantidad de Kg y el Destinatario para facturar.


        'todo
        Try

            Dim embarques = ListaEmbarques(sc, FechaDesde, FechaHasta, idTitular, pventa)

            Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

            For Each i In embarques
                Dim a As New wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult

                'If lista.Count>0 then a=lista(0).

                a.IdCartaOriginal = i.IdCDPMovimiento 'uso IdCartaOriginal al boleo (obviamente, no es una cartaporte)
                a.SubNumeroVagon = i.IdCDPMovimiento

                a.IdFacturarselaA = i.IdExportadorOrigen
                a.IdArticulo = i.IdArticulo
                a.Producto = NombreArticulo(sc, i.IdArticulo)
                a.KgNetos = i.Cantidad

                a.IdDestino = i.Puerto
                a.DestinoDesc = NombreDestino(sc, i.Puerto)

                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
                a.Corredor = i.Vapor 'es un texto
                a.NumeroCartaDePorte = Val(i.Vapor)  ' -1


                'a.FacturarselaA &="-EMBARQUE- "
                a.FacturarselaA &= NombreCliente(sc, i.IdExportadorOrigen)


                Const kTarifaEmbarque = 2


                a.TarifaFacturada = iisNull(db.wTarifaWilliams(a.IdFacturarselaA, a.IdArticulo, iisNull(i.Puerto, 0), kTarifaEmbarque, a.KgNetos), 0)
                'todo: tengo q usar la tarifa de embarques
                'acá tambien tengo que safar de alguna manera


                'ListaPreciosManager.GetPrecioPor()
                a.FechaArribo = i.FechaIngreso


                With a

                    .FechaDescarga = i.FechaIngreso
                    .IdCartaDePorte = i.IdCDPMovimiento * -1 'IDEMBARQUES
                    .IdCodigoIVA = 0



                    .IdCartaOriginal = -1

                    a.AgregaItemDeGastosAdministrativos = "NO"
                    .ClienteSeparado = ""
                    '.ColumnaTilde = ""
                    .Confirmado = ""
                    '.Corredor = ""
                    .CUIT = ""
                    .Destinatario = ""
                    '.DestinoDesc = ""

                End With



                lista.Add(a)
            Next

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


    End Sub


    Shared Sub BulkCopy(ByVal dt As DataTable, ByVal sc As String)
        Using destinationConnection As SqlConnection = New SqlConnection(Encriptar(sc))
            destinationConnection.Open()

            ' Set up the bulk copy object. 
            ' The column positions in the source data reader 
            ' match the column positions in the destination table, 
            ' so there is no need to map columns.
            Using bulkCopy As SqlBulkCopy = New SqlBulkCopy(destinationConnection)
                bulkCopy.DestinationTableName = "dbo.wTempCartasPorteFacturacionAutomatica"

                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdCartaDePorte", "IdCartaDePorte"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdSesion", "IdSesion"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdFacturarselaA", "IdFacturarselaA"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("FacturarselaA", "FacturarselaA"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("TarifaFacturada", "TarifaFacturada"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("ClienteSeparado", "ClienteSeparado"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("ColumnaTilde", "ColumnaTilde"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Confirmado", "Confirmado"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Corredor", "Corredor"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("DestinoDesc", "DestinoDesc"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("KgNetos", "KgNetos"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("NumeroCartaDePorte", "NumeroCartaDePorte"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("SubNumeroVagon", "SubNumeroVagon"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("SubnumeroDeFacturacion", "SubnumeroDeFacturacion"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("FechaArribo", "FechaArribo"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("FechaDescarga", "FechaDescarga"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Producto", "Producto"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdArticulo", "IdArticulo"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdDestino", "IdDestino"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("CUIT", "CUIT"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdCodigoIVA", "IdCodigoIVA"))
                'bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Procedcia_", "Procedcia"))
                'bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Destinatario", "Destinatario"))
                ''bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("R__Comercial", "RComercial"))
                'bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Intermediario", "Intermediario"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdCorredor", "IdCorredor"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdTitular", "IdTitular"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdRComercial", "IdRComercial"))
                'bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdIntermediario", "IdIntermediario"))

                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("AgregaItemDeGastosAdministrativos", "AgregaItemDeGastosAdministrativos"))

                Try
                    ' Write from the source to the destination.
                    bulkCopy.WriteToServer(dt)
                Catch ex As Exception
                    Console.WriteLine(ex.ToString)  'que no te confunda el orden de los colid. Por ejemplo, Titular era el 11. Es decir, depende del datatable. No?
                    ErrHandler2.WriteError(ex)
                    Throw
                End Try

            End Using
        End Using
    End Sub


    Shared Sub SoloMostrarElOriginalDeLosDuplicados(ByRef dt As DataTable, ByRef ms As String)
        '
        'todo: hacer esto
        '
    End Sub


    Shared Function GetIdArticuloParaCambioDeCartaPorte(ByVal sc As String) As Long
        Return BuscaIdArticuloPreciso("CAMBIO DE CARTA DE PORTE", sc)
    End Function



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Shared Function LinksDeCartasConflictivasDelAutomatico(ByVal l As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult), ByRef sLinks As String, ByVal sc As String) As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult)

        'Filtra las conflictivas, y tambien las muestra en un texto.



        Dim cartasrepetidas = (From i In l
                               Group By Id = i.IdCartaDePorte,
                                            Numero = i.NumeroCartaDePorte,
                                    SubnumeroVagon = i.SubNumeroVagon,
                                    SubNumeroFacturacion = i.SubnumeroDeFacturacion
                               Into Group
                               Where iisNull(SubNumeroFacturacion, 0) < 1 _
                                    And Group.Count() > 1 _
                                    And Id <> IDEMBARQUES
                               Select Id).ToList ' new with {.id = Id , .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim sErr As String

        ' Debug.Print(dt.Rows.Count)
        Debug.Print(cartasrepetidas.Count)



        sErr = "TOTAL " & cartasrepetidas.Count & " <br/> "



        Dim LasNoRepetidas = (From i In l Where Not cartasrepetidas.Contains(i.IdCartaDePorte) Order By i.NumeroCartaDePorte, i.FacturarselaA).ToList



        sLinks = "" 'ya no hago sLinks=sErr, ahora uso MostrarConflictivasEnPaginaAparte
        Return LasNoRepetidas
    End Function

    Shared Function MostrarConflictivasEnPaginaAparte(ByVal l As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult),
                                                  ByVal sc As String) As String

        'http://msdn.microsoft.com/en-us/vstudio/bb737926#grpbysum
        'http://msdn.microsoft.com/en-us/vstudio/bb737926#grpbysum

        '        'se queda sin memoria...
        '        URL:	/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados
        'User:   sgomez()
        '        Exception(Type) : System.OutOfMemoryException()
        'Message:	Exception of type 'System.OutOfMemoryException' was thrown.
        'Stack Trace:	 at System.String.ConcatArray(String[] values, Int32 totalLength)
        'at System.String.Concat(String[] values)
        'at LogicaFacturacion.MostrarConflictivasEnPaginaAparte(List`1 l, String sc)


        ErrHandler2.WriteError("punto 1 en MostrarConflictivasEnPaginaAparte .")

        Dim cartasrepetidasaa = (From i In l
                                 Group By Id = i.IdCartaDePorte,
                                              Numero = i.NumeroCartaDePorte,
                                      SubnumeroVagon = i.SubNumeroVagon,
                                      SubNumeroFacturacion = i.SubnumeroDeFacturacion
                                 Into Group
                                 Where iisNull(SubNumeroFacturacion, 0) < 1 _
                                      And Group.Count() > 1 _
                                      And Id <> IDEMBARQUES
                                 Select Id, link = Group.SelectMany(Function(x) x.FacturarselaA)
            ).ToList ' new with {.id = Id , .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim sErr As String

        Dim cartasrepetidaso = cartasrepetidasaa.Select(Function(x) x.Id).ToList

        sErr = "TOTAL " & cartasrepetidaso.Distinct.Count & " (se muestran las primeras 200) <br/> "

        Dim cartasrepetidas = cartasrepetidaso.Take(200).ToList

        If True Then
            ErrHandler2.WriteError("punto 2 en MostrarConflictivasEnPaginaAparte .")

            Dim cartasconflic = (From i In l
                                 Where cartasrepetidas.Contains(i.IdCartaDePorte)
                                 Select i.IdCartaDePorte, i.NumeroCartaDePorte, i.SubNumeroVagon, i.IdFacturarselaA, i.FacturarselaA
                                 Order By NumeroCartaDePorte, SubNumeroVagon, IdFacturarselaA Ascending).ToList





            Dim ultimoid As Long


            ErrHandler2.WriteError("punto 3 en MostrarConflictivasEnPaginaAparte .")

            Dim linksconflic As String

            If False Then

                If cartasconflic.Count > 0 Then
                    'linksconflic = cartasconflic.SelectMany(Function(dr) "<br/> <a href=""CartaDePorte.aspx?Id=" & """ target=""_blank""> </a>   ")
                    linksconflic = Join(cartasconflic.Select(Function(dr) "<br/> <a href=""CartaDePorte.aspx?Id=" & If(dr.IdCartaDePorte, 0).ToString & """ target=""_blank"">" & dr.NumeroCartaDePorte.ToString & " " & If(dr.SubNumeroVagon, 0).ToString & "</a>   ").ToList.Take(500).ToArray)
                End If

                sErr &= linksconflic


            Else  'ineficiente
                For Each dr In cartasconflic

                    If ultimoid <> dr.IdCartaDePorte Then
                        sErr &= "<br/> <a href=""CartaDePorte.aspx?Id=" & dr.IdCartaDePorte & """ target=""_blank"">" & dr.NumeroCartaDePorte & " " & dr.SubNumeroVagon & "</a>   "
                        's &= "<a href=""Cliente.aspx?Id=" & dr.id & """ target=""_blank"">" & dr.Numero & " " & dr.SubnumeroVagon & "</a>; "

                    End If
                    ultimoid = dr.IdCartaDePorte


                    'sErr &= " ("
                    sErr &= "<a href=""Cliente.aspx?Id=" & dr.IdFacturarselaA & """ target=""_blank""> &nbsp; " & dr.FacturarselaA & "   </a> "
                    'sErr &= " )"

                Next
            End If


            ErrHandler2.WriteError("punto 4 en MostrarConflictivasEnPaginaAparte . " & l.Count & " " & cartasrepetidasaa.Count & " " & cartasrepetidaso.Count & " " & cartasrepetidas.Count & " " & cartasconflic.Count)

        End If








        Return sErr
    End Function


    'Shared Function LinksDeCartasConflictivas(ByRef dt As DataTable, ByRef sLinks As String) As String


    '    Return "" 'solo se buscan las repetidas del automatico, no del manual. -El manual no tiene conflictivas?



    '    'IdFacturarselaA = CLng(iisNull(i("IdFacturarselaA"), 0)), _

    '    'Dim renglonesdistintas=

    '    Dim cartasrepetidas = From i In dt.AsEnumerable() _
    '            Group By Id = CLng(iisNull(i("IdCartaDePorte"), 0)), _
    '                             Numero = i("NumeroCartaDePorte"), _
    '                     SubnumeroVagon = i("SubnumeroVagon"), _
    '                     SubNumeroFacturacion = i("SubNumeroDeFacturacion") _
    '                Into Group _
    '            Where iisNull(SubNumeroFacturacion, 0) = 0 _
    '                     And Group.Count() > 1 _
    '                     And Id <> IDEMBARQUES _
    '            Select New With {.id = Id, .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}


    '    Dim s As String

    '    Debug.Print(dt.Rows.Count)
    '    Debug.Print(cartasrepetidas.Count)


    '    For Each dr In cartasrepetidas
    '        s &= "<a href=""CartaDePorte.aspx?Id=" & dr.id & """ target=""_blank"">" & dr.Numero & " " & dr.SubnumeroVagon & "</a>; "

    '        Dim numero = dr.Numero
    '        Dim vagon = dr.SubnumeroVagon

    '        Dim cartas = From i In dt.AsEnumerable() _
    '                     Where numero = i("NumeroCartaDePorte") And vagon = i("SubnumeroVagon") _
    '                     Select i("IdFacturarselaA")

    '        s &= "clientes ("
    '        For Each c In cartas

    '            s &= c
    '        Next


    '        's &= "<a href=""Cliente.aspx?Id=" & dr.id & """ target=""_blank"">" & dr.Numero & " " & dr.SubnumeroVagon & "</a>; "
    '    Next


    '    Dim IdCartasRepetidas = From o In cartasrepetidas Select Str(o.id) 'si no lo convierto en string, me llora el Join

    '    If IdCartasRepetidas.Count > 0 Then
    '        'dt = dt.Select("IdCartaDePorte NOT IN (" & String.Join(",", IdCartasRepetidas.ToArray) & ")")

    '        dt = DataTableWHERE(dt, "IdCartaDePorte NOT IN (" & String.Join(",", IdCartasRepetidas.ToArray) & ")")
    '    End If




    '    'Dim q2 = From i In dt.AsEnumerable() _
    '    'Where(Not IdCartasRepetidas.Contains(CLng(i("IdCartaDePorte"))))
    '    '        'dt = q2.todatatable
    '    '       dt = q2.CopyToDataTable()



    '    Return s
    'End Function

    Shared Function LinksDeCartasConflictivasDelAutomaticoSobreElTempDirecto(ByVal l As Generic.List(Of wTempCartasPorteFacturacionAutomatica), ByRef sLinks As String, ByVal sc As String) As Generic.List(Of wTempCartasPorteFacturacionAutomatica)

        'Filtra las conflictivas, y tambien las muestra en un texto.

        Err.Raise("No podes... en la tabla temporal solo quedan las que son válidas")

        Dim cartasrepetidas = (From i In l
                               Group By Id = i.IdCartaDePorte,
                                            Numero = i.NumeroCartaDePorte,
                                    SubnumeroVagon = i.SubNumeroVagon,
                                    SubNumeroFacturacion = i.SubnumeroDeFacturacion
                               Into Group
                               Where iisNull(SubNumeroFacturacion, 0) < 1 _
                                    And Group.Count() > 1 _
                                    And Id <> IDEMBARQUES
                               Select Id).ToList ' new with {.id = Id , .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim sErr As String

        ' Debug.Print(dt.Rows.Count)
        Debug.Print(cartasrepetidas.Count)



        sErr = "TOTAL " & cartasrepetidas.Count & " <br/> "



        Dim LasNoRepetidas = (From i In l Where Not cartasrepetidas.Contains(i.IdCartaDePorte) Order By i.NumeroCartaDePorte, i.FacturarselaA).ToList



        sLinks = "" ' sErr
        Return LasNoRepetidas
    End Function

    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Function TraerSubconjuntoDeRepetidosAutomaticos(ByVal dt As DataTable) As IEnumerable

        Dim q = From i In dt.AsEnumerable()
                Group By Numero = i("NumeroCartaDePorte"),
                     IdFacturarselaAExplicito = i("IdFacturarselaA") Into Group
                Where IdFacturarselaAExplicito <= 0 _
                     And Group.Count() > 1
                Select New With {.Numero = Numero, .Count = Group.Count()}

        Return q 'como devuelve un anonimous type, despues no le puedo llamar el contain
    End Function


    Function TraerSubconjuntoDeRepetidosAutomaticosYtambienDuplicadosExplicitos(ByVal dt As DataTable) As IEnumerable

        Dim q = From i In dt.AsEnumerable()
                Group By Numero = i("NumeroCartaDePorte"),
                     IdFacturarselaAExplicito = i("IdFacturarselaA") Into Group
                Where IdFacturarselaAExplicito <= 0 _
                     And Group.Count() > 1
                Select New With {.Numero = Numero, .Count = Group.Count()}

        Return q
    End Function




    Shared Function GenerarDatatableDelPreviewDeFacturacion(ByRef dt As DataTable, ByVal sc As String) As DataTable
        'me quedo con dos tablas, la segunda es la que tiene los corredores separados
        'Dim tablaEditadaDeFacturasParaGenerarFiltradaPorCorredoresSeparados = tablaEditadaDeFacturasParaGenerar.Clone

        'En los archivos de Vista Resumida y Vista Detallada, poner las columnas Tarifa,	KgDescargados y Total en formato número

        Dim q = From i In dt.AsEnumerable()
                Group By
                Titular = i("FacturarselaA"), Destino = i("DestinoDesc"),
                Articulo = i("Producto"), Tarifa = i("TarifaFacturada"),
                SeSepara = i("ClienteSeparado")
            Into Group
                Select New With {.Factura = "", .Cliente = Titular,
                             .IdClienteSeparado = SeSepara,
                             .ClienteSeparado = IIf(EntidadManager.NombreCliente(sc, SeSepara) = "", SeSepara, EntidadManager.NombreCliente(sc, SeSepara)),
                            .CantidadCDPs = Group.Count(), Destino, Articulo,
                            .Tarifa = CDec(Tarifa),
                            .KgDescargados = Group.Sum(Function(i) i.Field(Of Decimal)("KgNetos")),
                            .Total = Group.Sum(Function(i) CDec(i.Field(Of Decimal)("KgNetos") * i.Field(Of Decimal)("TarifaFacturada") / 1000D))
            }


        'parar aca y ver el valor de la columna Total
        '(PASO 3) Excel detallado y resumido despues de facturación -> No muestra los totales (precios)
        'eso iria en una última columna, que sí esta saliendo en los excel antes de la facturacion



        'EsteCorredorSeleFacturaAlTitularPorSeparadoId(i("idCartadePorte"))



        ' cómo separar de ahí las de corredor escpecífico?


        'separar corredores
        'If Not (optFacturarA.SelectedValue = 1 And EsteCorredorSeleFacturaAlTitularPorSeparado(ocdp)) Then








        'DataTableGROUPBY("IdArticulo, Destino, Titular", ".NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinal / 1000), _
        '                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinal / 1000 * i.TarifaCobradaAlCliente)", dt)
        Dim ret = q.ToDataTable()
        ret.Columns.Add("Por destino?", GetType(System.String))
        Return ret
    End Function





    Sub MandarMailsDelPaso2(ByVal dt As DataTable)
        Dim whereClientes = DataTableDISTINCT(dt, "Cliente")
        For Each i In whereClientes.Rows

            'MandaEmail()

        Next



    End Sub







    Public Const _DEBUG_FACTURACION_PRECIOS As Boolean = False






    'Shared Sub GenerarLoteFacturas(ByRef grilla As DataTable, ByVal SC As String, ByRef ViewState As StateBag, ByVal optFacturarA As Long, ByRef gvFacturasGeneradas As GridView, ByVal txtFacturarATerceros As String, ByVal SeEstaSeparandoPorCorredor As Boolean, ByRef Session As HttpSessionState, ByVal PuntoVenta As Integer, ByVal dtViewstateRenglonesManuales As DataTable, ByVal agruparArticulosPor As String, ByVal txtBuscar As String, ByVal txtTarifaGastoAdministrativo As String, ByRef errLog As String, ByVal txtCorredor As String, ByVal chkPagaCorredor As Boolean)

    '    Dim idFactura As Long
    '    Dim ultimo = 0
    '    Dim primera = 0
    '    Dim ultima = 0




    '    Dim tTemp, tHoraEmpieza, tHoraTermina As Date
    '    tHoraEmpieza = Now

    '    '/////////////////////////////////////////////////////////////////////////////
    '    'Acá hago un DISTINCT (en el ToTable) para saber las distintas facturas que tengo que armar
    '    '/////////////////////////////////////////////////////////////////////////////

    '    ErrHandler2.WriteError("Separo las facturas que se generan en el lote." & Now.ToString)

    '    Dim dtf = grilla.Copy ' dtDatasourcePaso2.Copy
    '    'If optFacturarA >= 4 Then
    '    '    RefrescaTarifaTablaTemporal(dtf, SC, optFacturarA, txtFacturarATerceros)
    '    'End If




    '    If dtf.Rows.Count < 1 Then

    '        ErrHandler2.WriteError("No hay cartas seleccionadas para facturar")

    '        Throw New Exception("No hay cartas seleccionadas para facturar")


    '        Exit Sub
    '    End If

    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    'TODO: como agrupar en facturas los items agregados manualmente
    '    'Por cada renglon de dtViewstateRenglonesManuales
    '    '    filtrar la tabla de cartas, ordenando de manera ascendiente el IdclienteSeparado (primero los vacios)
    '    '    tomar el primero IdClienteSeparado que aparezca, y asignarselo al renglon
    '    Dim dtItemsManuales = dtViewstateRenglonesManuales.Copy
    '    For Each r In dtItemsManuales.Rows


    '        Dim strwhere = "FacturarselaA=" & _c(r("FacturarselaA"))
    '        Dim dtLotecito = ProntoFuncionesGenerales.DataTableWHERE(dtf, strwhere)

    '        'Dim q = From i In dtLotecito _
    '        '        Order By i.("IdClienteSeparado") Ascending
    '        '        Select top 1 

    '        ActualizarCampoClienteSeparador(dtLotecito, SeEstaSeparandoPorCorredor, SC)
    '        Try

    '            Dim dtlotecitoordenado = DataTableORDER(dtLotecito, "ClienteSeparado DESC").Item(0)

    '            r("IdFacturarselaA") = dtlotecitoordenado("IdFacturarselaA")
    '            r("ClienteSeparado") = dtlotecitoordenado("ClienteSeparado")
    '            r("IdTitular") = dtlotecitoordenado("IdTitular") 'a proposito le meto Idtitular=Clienteseparado, para que no me vuelva a separar al llamar de nuevo a acutalizarcampoclienteseparador
    '            r("IdCorredor") = dtlotecitoordenado("IdCorredor") 'a proposito le meto IdCorredor=Clienteseparado, para que no me vuelva a separar al llamar de nuevo a acutalizarcampoclienteseparador
    '        Catch ex As Exception
    '            ErrHandler2.WriteError("Hay un renglon agregado que se le facturaría a un cliente que no está en la generacion. " & ex.ToString)
    '            'MsgBoxAjax(Me, "Hay un renglon agregado que se le facturaría a un cliente que no está en la generacion")
    '            'Return
    '        End Try

    '    Next
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////
    '    '//////////////////////////////////////////////////////////////////


    '    Dim tablaEditadaDeFacturasParaGenerar As DataTable = DataTableUNION(dtf, dtItemsManuales)  'esta es la grilla, incluye las manuales
    '    ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, SC) 'TODO: ineficiente

    '    Dim dt = GenerarDatatableDelPreviewDeFacturacion(tablaEditadaDeFacturasParaGenerar, SC)
    '    Dim dtwhere = ProntoFuncionesGenerales.DataTableDISTINCT(dt, New String() {"Factura", "Cliente", "IdClienteSeparado"})





    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////

    '    ErrHandler2.WriteError("Empiezo a facturar en serio." & Now.ToString)

    '    Dim n = 0
    '    tTemp = Now






    '    For Each owhere As DataRow In dtwhere.Rows

    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////PASO 1        (Lote 14s, Compronto 7s, Imputacion 2s)
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////

    '        n = n + 1
    '        Debug.Print("lote " & n & "/" & dtwhere.Rows.Count & " " & Now.ToString)

    '        'chupo la agrupacion del datatable y lo pongo en una List (porque antes lo hacía así, y la
    '        'funcion que genera las facturas usa una List )
    '        Dim idClienteAfacturarle As Long = iisNull(BuscaIdClientePreciso(owhere("Cliente"), SC), -1)

    '        If idClienteAfacturarle = -1 Then
    '            'verificar que no sea por el largo del nombre
    '            If Len(owhere("Cliente").ToString) = 50 Then
    '                Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCliente FROM Clientes WHERE RazonSocial like '" & Replace(owhere("Cliente"), "'", "''") & "%'")
    '                If ds.Rows.Count < 1 Then
    '                    ErrHandler2.WriteError("No se encuentra el cliente " & owhere("Cliente"))
    '                    Continue For
    '                End If
    '                idClienteAfacturarle = ds.Rows(0).Item("IdCliente")
    '            Else
    '                ErrHandler2.WriteError("No se encuentra el cliente " & owhere("Cliente"))
    '                Continue For
    '            End If
    '        End If
    '        'If idClienteAfacturarle <> owhere("IdCliente") - 1 Then
    '        ' 'error
    '        ' End If

    '        Dim lote As New System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte)
    '        Dim listEmbarques As New System.Collections.Generic.List(Of DataRow)
    '        Dim strwhere = "FacturarselaA=" & _c(owhere("Cliente")) & " AND [ClienteSeparado]=" & _c(owhere("IdClienteSeparado"))
    '        'para filtrar las que no tienen el corredor separado, no puedo poner filtrar por vacío, hombre
    '        'justamente porque en Corredor hay datos!
    '        'la solucion es agregarle al tablaEditadaDeFacturasParaGenerar la columna con la separacion del corredor...




    '        Dim dtRenglonesAgregados As DataTable = tablaEditadaDeFacturasParaGenerar.Clone 'copio SOLAMENTE la estructura



    '        Dim dtLotecito = ProntoFuncionesGenerales.DataTableWHERE(tablaEditadaDeFacturasParaGenerar, strwhere)
    '        Dim n2tot = dtLotecito.Rows.Count
    '        Dim n2 = 0


    '        For Each i As DataRow In dtLotecito.Rows
    '            n2 = n2 + 1
    '            Debug.Print("                   lote " & n & "/" & dtwhere.Rows.Count & " cdp " & n2 & "/" & n2tot & " " & Now.ToString)


    '            If iisNull(i("idCartaDePorte"), 0) > 0 Then 'es un renglon agregado a mano? 


    '                'TODO: es este FOR el que hace ineficiente la facturacion
    '                'qué es lo molesto? El GetItem o el SavePrecioPorCliente?

    '                Dim stopWatch As New Stopwatch()
    '                ' Get the elapsed time as a TimeSpan value.
    '                'Dim ts As TimeSpan = stopWatch.Elapsed

    '                stopWatch.Start()
    '                Dim ocdp As Pronto.ERP.BO.CartaDePorte = CartaDePorteManager.GetItem(SC, i("idCartaDePorte"))
    '                stopWatch.Stop()
    '                Debug.Print("GetItem " & stopWatch.Elapsed.Milliseconds)


    '                If ocdp.IdFacturaImputada > 0 Then
    '                    If optFacturarA = 5 Then
    '                        'facturacion automatica
    '                        'MODIFICACION: ya no permitir la duplicacion automatica de cartas
    '                        'ocdp = CartaDePorteManager.DuplicarCartaporteConOtroSubnumeroDeFacturacion(sc, ocdp)
    '                        Dim sErr = "Esta carta ya está imputada. No se permite la duplicación automatica de cartas. " & ocdp.Id & " " & ocdp.NumeroCartaDePorte & " " & ocdp.SubnumeroVagon & " " & ocdp.SubnumeroDeFacturacion
    '                        'Err.Raise(64646, , sErr)
    '                        ErrHandler2.WriteError(sErr)
    '                        Continue For
    '                    Else
    '                        'tiene q haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica
    '                        Err.Raise(64646, , "Esta carta ya está imputada. Tiene que haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica", "Tiene que haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica")
    '                    End If
    '                End If


    '                ocdp.TarifaCobradaAlCliente = iisNull(i("TarifaFacturada"), 0)


    '                If False Then 'voy a sacarlo, qué tanto!
    '                    If Not _DEBUG_FACTURACION_PRECIOS Then
    '                        stopWatch.Start()



    '                        'ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, ocdp.TarifaCobradaAlCliente)

    '                        'cómo se acá si el precio no lo traje de un destino, y al pisar el generico, estoy jodiendolo? -serian pocos los casos, no?
    '                        'ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, ocdp.TarifaCobradaAlCliente)
    '                        ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.TarifaCobradaAlCliente)
    '                        stopWatch.Stop()
    '                        Debug.Print("SavePrecioPorCliente " & stopWatch.Elapsed.Milliseconds)
    '                    End If
    '                End If




    '                lote.Add(ocdp)
    '            Else
    '                'renglon agregado a mano o embarque

    '                If iisNull(i("IdCartaDePorte"), 0) = IDEMBARQUES Then
    '                    listEmbarques.Add(i)
    '                Else
    '                    dtRenglonesAgregados.ImportRow(i)
    '                End If
    '            End If

    '        Next


    '        Debug.Print("1 - Lote armado en " & DateDiff(DateInterval.Second, tTemp, Now))
    '        tTemp = Now


    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////PASO 2
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        'Debug.Print("Creando Factura " & Now.ToString)


    '        'creo la factura
    '        '-¿Cómo verifico que no se haya imputado la carta en los lotecitos anteriores?
    '        '-Ya se está haciendo arriba, en la llamada a CrearleAlaCartaporteUnSubnumeroParaFacturarselo

    '        idFactura = CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta, dtRenglonesAgregados, SC, Session, optFacturarA, agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor, txtCorredor, chkPagaCorredor, listEmbarques)

    '        Debug.Print("2- ComPronto llamado en " & DateDiff(DateInterval.Second, tTemp, Now))
    '        tTemp = Now




    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////PASO 3
    '        '/////////////////////////////////////////////////////////////////////////////////
    '        '/////////////////////////////////////////////////////////////////////////////////


    '        'control de primera y ultima y errores
    '        If primera = 0 And idFactura <> -1 Then primera = idFactura

    '        If idFactura > 0 Then
    '            'se facturó bien

    '            ultima = idFactura

    '            'hago las imputaciones
    '            For Each o In lote
    '                'TODO: la imputacion tambien es ineficiente, porque llama para grabar a la cdp, que a su vez revisa clientes, etc
    '                'Debug.Print("               imputo " & Now.ToString)

    '                If True Then
    '                    'If InStr(o.FacturarselaA, "<EMBARQUE>") = 0 Then
    '                    CartaDePorteManager.ImputoLaCDP(o, idFactura, SC, Session(SESSIONPRONTO_UserName))
    '                Else
    '                    'y si es un embarque? -pero los embarques no estan en la coleccion lote !!!!!!
    '                End If

    '            Next

    '            For Each o In listEmbarques
    '                'CartaDePorteManager.ImputoElEmbarque(o("NumeroCartaDePorte"), idFactura, SC, Session(SESSIONPRONTO_UserName))
    '            Next

    '        Else
    '            Try
    '                'hubo un error al generar la factura de este lote
    '                errLog &= "No se pudo crear la factura para " & _
    '                "<a href=""Cliente.aspx?Id=" & idClienteAfacturarle & """ target=""_blank"">" & NombreCliente(SC, idClienteAfacturarle) & "</a>; " & _
    '                " verificar IVA y CUIT, o que la carta no estuviese imputada anteriormente; Verificar que no " & _
    '                " se haya disparado el error 'listacdp vacia' o no haya otro cliente con el mismo nombre" & vbCrLf
    '            Catch ex As Exception
    '                ErrHandler2.WriteError(ex)
    '            End Try
    '            ErrHandler2.WriteError(errLog)
    '        End If


    '        'limpio el lote -no te conviene hacer un new en cada iteracion?
    '        lote.Clear()


    '        Debug.Print("3- Imputacion y limpieza en " & DateDiff(DateInterval.Second, tTemp, Now))
    '        tTemp = Now
    '    Next


    '    Debug.Print("Fin " & Now.ToString)



    '    'está grabando las lineas agregadas?





    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    'Despues de facturar, muestro la grilla de generadas y mensajes de error
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////

    '    ' FacturaManager.GetItemComPronto(sc, primera, False).Numero
    '    '& FacturaManager.GetItemComPronto(sc, ultima, False).Numero
    '    If primera = 0 Then
    '        ErrHandler2.WriteError("No se han podido generar facturas")
    '        Throw New Exception("No se han podido generar facturas")

    '    End If


    '    Dim s = "SELECT 'Factura.aspx?Id='+ cast(idFactura as varchar) as URLgenerada,tipoabc,puntoventa, " & _
    '            "NumeroFactura as [NumeroFactura],clientes.RazonSocial  FROM Facturas " & _
    '            "JOIN Clientes on Facturas.Idcliente=Clientes.Idcliente   WHERE idFactura between " & primera & " AND " & ultima


    '    gvFacturasGeneradas.DataSource = EntidadManager.ExecDinamico(SC, s)
    '    gvFacturasGeneradas.DataBind()



    '    Try
    '        ViewState("PrimeraIdFacturaGenerada") = primera
    '        ViewState("UltimaIdFacturaGenerada") = ultima

    '        primera = iisNull(EntidadManager.ExecDinamico(SC, _
    '                                                         "SELECT NumeroFactura FROM Facturas WHERE idFactura= " & primera).Rows(0).Item("NumeroFactura"), 1)
    '        ultima = iisNull(EntidadManager.ExecDinamico(SC, _
    '                                                         "SELECT NumeroFactura FROM Facturas WHERE idFactura= " & ultima).Rows(0).Item("NumeroFactura"), 1)



    '        tHoraTermina = Now
    '        ErrHandler2.WriteError("Fin facturacion." & primera & " " & ultima & "  Tiempo usado: " & DateDiff(DateInterval.Second, tHoraEmpieza, tHoraTermina) & " segundos. ")





    '    Catch ex As Exception
    '        ErrHandler2.WriteError("Error al buscar facturas generadas. " & ex.ToString)
    '    End Try

    '    'lblMensaje.Text = errLog ' "Creadas facturas de la " & primera & " a la " & ultima & ". Facturacion terminada"

    'End Sub


    Shared Function VerificarQueNoHayaCambiadoElLoteDesdeQueSeCreoLaFacturacion(lista As Generic.List(Of Integer), SC As String, ByRef sErr As String) As Boolean
        '  Verificar si esta anulada, que no haya cambiado el estado de las cartas desde que generé el lote, 
        'porque ya no cargo individualmente cada carta
        'lo ideal quizas es verificar que la fecha de modificacion no haya cambiado desde la fecha del 
        'Me conformo con que ninguna carta esté anulada o imputada

        Try

            Using db = New LinqCartasPorteDataContext(Encriptar(SC))

                Dim l = (From i In db.CartasDePortes
                         Where lista.Contains(i.IdCartaDePorte) _
                     And (i.IdFacturaImputada > 0 _
                     Or i.Anulada = "SI")
                         Select CStr(i.NumeroCartaDePorte)
                               ).ToArray
                'And i.FechaModificacion _


                If l.Count > 0 Then
                    sErr = "Hay cartas que dejaron de ser facturables (" & Join(l, ",") & ") en estos minutos mientras editabas la grilla. Quitales el tilde o volvé al primer paso"
                    Return False
                Else
                    sErr = ""
                End If

            End Using
        Catch ex As Exception

            'http://stackoverflow.com/questions/656167/hitting-the-2100-parameter-limit-sql-server-when-using-contains
            '            The incoming tabular data stream (TDS) remote procedure call (RPC) protocol stream is incorre...
            'Hitting the 2100 parameter limit



            MandarMailDeError("Error en VerificarQueNoHayaCambiadoElLoteDesdeQueSeCreoLaFacturacion. Revisar si es el de 'severe error' o el de 'transport level'.       Tamaño de lista: " & lista.Count & "   " & ex.ToString)
            'A severe error occurred on the current command.  The results, if any, should be discarded.????

            'tambien tira el de "A transport-level error has occurred when receiving results from the server"

        End Try


        Return True


        '        Log(Entry)
        '03/07/2014 16:34:43
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.Data.SqlClient.SqlException
        'A severe error occurred on the current command.  The results, if any, should be discarded.
        'A severe error occurred on the current command.  The results, if any, should be discarded.
        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
        '        at(System.Data.SqlClient.SqlDataReader.ConsumeMetaData())
        '        at(System.Data.SqlClient.SqlDataReader.get_MetaData())
        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
        '   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior, String method)
        '   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
        '        at(System.Data.Common.DbCommand.ExecuteReader())
        '   at System.Data.Linq.SqlClient.SqlProvider.Execute(Expression query, QueryInfo queryInfo, IObjectReaderFactory factory, Object[] parentArgs, Object[] userArgs, ICompiledSubQuery[] subQueries, Object lastResult)
        '   at System.Data.Linq.SqlClient.SqlProvider.ExecuteAll(Expression query, QueryInfo[] queryInfos, IObjectReaderFactory factory, Object[] userArguments, ICompiledSubQuery[] subQueries)
        '   at System.Data.Linq.SqlClient.SqlProvider.System.Data.Linq.Provider.IProvider.Execute(Expression query)
        '   at System.Data.Linq.DataQuery`1.System.Collections.Generic.IEnumerable<T>.GetEnumerator()
        '   at System.Linq.Buffer`1..ctor(IEnumerable`1 source)
        '   at System.Linq.Enumerable.ToArray[TSource](IEnumerable`1 source)
        '   at LogicaFacturacion.VerificarQueNoHayaCambiadoElLoteDesdeQueSeCreoLaFacturacion(List`1 lista, String SC, String& sErr)
        '   at LogicaFacturacion.GenerarLoteFacturas_NUEVO(DataTable& grilla, String SC, StateBag& ViewState, Int64 optFacturarA, GridView& gvFacturasGeneradas, String txtFacturarATerceros, Boolean SeEstaSeparandoPorCorredor, HttpSessionState& Session, Int32 PuntoVenta, DataTable dtViewstateRenglonesManuales, String agruparArticulosPor, String txtBuscar, String txtTarifaGastoAdministrativo, String& errLog, String txtCorredor, Boolean chkPagaCorredor)
        '   at CDPFacturacion.btnGenerarFacturas_Click(Object sender, EventArgs e)
        '.Net SqlClient Data Provider


    End Function


    Shared Sub GenerarLoteFacturas_NUEVO(ByRef grilla As DataTable, ByVal SC As String,
                                     ByVal optFacturarA As Long,
                                     ByRef gvFacturasGeneradas As GridView,
                                     ByVal SeEstaSeparandoPorCorredor As Boolean,
                                     ByRef Session As System.Web.SessionState.HttpSessionState,
                                     ByVal PuntoVenta As Integer, ByVal dtViewstateRenglonesManuales As DataTable,
                                     ByVal agruparArticulosPor As String, ByVal txtBuscar As String,
                                     ByVal txtTarifaGastoAdministrativo As String, ByRef errLog As String,
                                     ByVal txtCorredor As String, ByVal chkPagaCorredor As Boolean,
                                     numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object,
                                     ByRef UltimaIdFacturaGenerada As Object, idClienteObservaciones As Long)

        Dim idFactura As Long
        Dim ultimo = 0
        Dim primera = 0
        Dim ultima = 0




        Dim tTemp, tHoraEmpieza, tHoraTermina As Date
        tHoraEmpieza = Now

        '/////////////////////////////////////////////////////////////////////////////
        'Acá hago un DISTINCT (en el ToTable) para saber las distintas facturas que tengo que armar
        '/////////////////////////////////////////////////////////////////////////////

        ErrHandler2.WriteError("Separo las facturas que se generan en el lote." & Now.ToString)

        Dim dtf = grilla.Copy ' dtDatasourcePaso2.Copy
        'If optFacturarA >= 4 Then
        '    RefrescaTarifaTablaTemporal(dtf, SC, optFacturarA, txtFacturarATerceros)
        'End If




        If dtf.Rows.Count < 1 Then

            ErrHandler2.WriteError("No hay cartas seleccionadas para facturar")

            Throw New Exception("No hay cartas seleccionadas para facturar")


            Exit Sub
        End If




        Dim tablaEditadaDeFacturasParaGenerar As DataTable

        If dtViewstateRenglonesManuales IsNot Nothing Then

            '//////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////
            'TODO: como agrupar en facturas los items agregados manualmente
            'Por cada renglon de dtViewstateRenglonesManuales
            '    filtrar la tabla de cartas, ordenando de manera ascendiente el IdclienteSeparado (primero los vacios)
            '    tomar el primero IdClienteSeparado que aparezca, y asignarselo al renglon
            Dim dtItemsManuales = dtViewstateRenglonesManuales.Copy
            For Each r In dtItemsManuales.Rows


                Dim strwhere = "FacturarselaA=" & _c(r("FacturarselaA"))
                Dim dtLotecito = ProntoFuncionesGenerales.DataTableWHERE(dtf, strwhere)

                'Dim q = From i In dtLotecito _
                '        Order By i.("IdClienteSeparado") Ascending
                '        Select top 1 

                ActualizarCampoClienteSeparador(dtLotecito, SeEstaSeparandoPorCorredor, SC)
                Try

                    Dim dtlotecitoordenado = DataTableORDER(dtLotecito, "ClienteSeparado DESC").Item(0)

                    r("IdFacturarselaA") = dtlotecitoordenado("IdFacturarselaA")
                    r("ClienteSeparado") = dtlotecitoordenado("ClienteSeparado")
                    r("IdTitular") = dtlotecitoordenado("IdTitular") 'a proposito le meto Idtitular=Clienteseparado, para que no me vuelva a separar al llamar de nuevo a acutalizarcampoclienteseparador
                    r("IdCorredor") = dtlotecitoordenado("IdCorredor") 'a proposito le meto IdCorredor=Clienteseparado, para que no me vuelva a separar al llamar de nuevo a acutalizarcampoclienteseparador
                Catch ex As Exception
                    ErrHandler2.WriteError("Hay un renglon agregado que se le facturaría a un cliente que no está en la generacion. " & ex.ToString)
                    'MsgBoxAjax(Me, "Hay un renglon agregado que se le facturaría a un cliente que no está en la generacion")
                    'Return
                End Try

            Next
            '//////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////

            'la datatable "tablaEditadaDeFacturasParaGenerar" se está quedando sin el dato de ClienteSeparado que viene en la datatable "dtf"!!!!!!!!
            '-naboooooo es ActualizarCampoClienteSeparador el que te lo refresca!!!!

            tablaEditadaDeFacturasParaGenerar = DataTableUNION(dtf, dtItemsManuales)
            'Dim tablaEditadaDeFacturasParaGenerar As DataTable = dtf.Copy()  'esta es la grilla, incluye las manuales

            ' Dim tablaEditadaDeFacturasParaGenerar alguna manera de hacerlo tipado y en una lista???


        Else
            tablaEditadaDeFacturasParaGenerar = dtf

        End If



        ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, SC) 'TODO: ineficiente


        Dim dt = GenerarDatatableDelPreviewDeFacturacion(tablaEditadaDeFacturasParaGenerar, SC) 'aca ya separo los lotes por cliente a facturar -por qué me los separa si estoy usando "a terceros"?


        'Dim dtwhere = ProntoFuncionesGenerales.DataTableDISTINCT(dt, New String() {"Factura", "Cliente", "IdClienteSeparado"})

        Dim dtwhere = (From i In dt.AsEnumerable
                       Select Factura = CInt(Val(i("Factura").ToString)),
                             Cliente = i("Cliente").ToString,
                             IdCliente = Convert.ToInt32(iisNull(BuscaIdClientePreciso(i("Cliente").ToString, SC), -1)),
                             IdClienteSeparado = i("IdClienteSeparado").ToString()
                        ).Distinct.ToList


        ' IdClienteSeparado = Convert.ToInt32(Val(i("IdClienteSeparado"))) _
        ' IdClienteSeparado = Convert.ToInt32(Val(       System.Text.RegularExpressions.Regex.Replace(i("IdClienteSeparado"), "[^0-9]", ""))


        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////

        ErrHandler2.WriteError("Empiezo a facturar en serio." & Now.ToString)

        Dim n = 0
        tTemp = Now


        'Try

        Dim tablaEditadaDeFacturasParaGenerarComoLista = (From i In tablaEditadaDeFacturasParaGenerar.AsEnumerable
                                                          Select
                                                              FacturarselaA = i("FacturarselaA").ToString,
                                                              ClienteSeparado = CStr(i("ClienteSeparado")),
                                                              idCartaDePorte = CInt(iisNull(i("idCartaDePorte"), -1)),
                                                              NumeroCartaDePorte = CLng(iisNull(i("NumeroCartaDePorte"), -1)),
                                                              TarifaFacturada = CDbl(i("TarifaFacturada")),
                                                              FechaDescarga = CDate(iisNull(i("FechaDescarga"), Today)),
                                                              Destino = CInt(iisNull(i("IdDestino"), -1)),
                                                              IdArticulo = CInt(iisNull(i("IdArticulo"), BuscaIdArticuloPreciso(i.Item("Producto"), SC))),
                                                              NetoFinal = CInt(iisNull(i("KgNetos"), -1)),
                                                              Titular = CInt(iisNull(i("IdTitular"), -1)),
                                                              CuentaOrden1 = CInt(iisNull(i("IdIntermediario"), -1)),
                                                              CuentaOrden2 = CInt(iisNull(i("IdRComercial"), -1)),
                                                              Corredor = CInt(iisNull(i("IdCorredor"), -1)),
                                                              Entregador = CInt(iisNull(i("IdDestinatario"), -1)),
                                                              AgregaItemDeGastosAdministrativos = CStr(iisNull(i("AgregaItemDeGastosAdministrativos")))
                                ).ToList


        'Catch ex As Exception
        ' ErrHandler2.WriteError("Explota el tablaEditadaDeFacturasParaGenerarComoLista")
        ' throw
        ' End Try







        '.ColumnaTilde = CInt(cdp("ColumnaTilde"))
        '.IdCartaDePorte = CInt(iisNull(cdp("IdCartaDePorte")))
        '.IdArticulo = CInt(iisNull(cdp("IdArticulo")))
        '.NumeroCartaDePorte = iisNull(cdp("NumeroCartaDePorte"))
        '.SubNumeroVagon = CInt(iisNull(cdp("SubNumeroVagon")))
        '.SubnumeroDeFacturacion = CInt(iisNull(cdp("SubnumeroDeFacturacion"), 0))
        '.FechaArribo = CDate(iisNull(cdp("FechaArribo")))
        '.FechaDescarga = CDate(iisNull(cdp("FechaDescarga")))
        '.FacturarselaA = CStr(iisNull(cdp("FacturarselaA")))
        '.IdFacturarselaA = CInt(iisNull(cdp("IdFacturarselaA")))
        '.Confirmado = iisNull(cdp("Confirmado"))
        '.IdCodigoIVA = CInt(iisNull(cdp("IdCodigoIVA"), -1))
        '.CUIT = CStr(iisNull(cdp("CUIT")))
        '.ClienteSeparado = CStr(iisNull(cdp("ClienteSeparado")))
        '.TarifaFacturada = CDec(iisNull(cdp("TarifaFacturada"), 0))
        '.Producto = CStr(iisNull(cdp("Producto")))
        '.KgNetos = CDec(iisNull(cdp("KgNetos")))
        '.IdCorredor = CInt(iisNull(cdp("IdCorredor")))
        '.IdTitular = CInt(iisNull(cdp("IdTitular")))
        '.IdIntermediario = CInt(iisNull(cdp("IdIntermediario"), -1))
        '.IdRComercial = CInt(iisNull(cdp("IdRComercial"), -1))
        '.IdDestinatario = CInt(iisNull(cdp("IdDestinatario")))
        '.Titular = CStr(iisNull(cdp("Titular")))
        '.Intermediario = CStr(iisNull(cdp("Intermediario")))
        '.R__Comercial = CStr(iisNull(cdp("R. Comercial")))
        '.Corredor = CStr(iisNull(cdp("Corredor ")))
        '.Destinatario = CStr(iisNull(cdp("Destinatario")))
        '.DestinoDesc = CStr(iisNull(cdp("DestinoDesc")))
        '.Procedcia_ = CStr(iisNull(cdp("Procedcia.")))
        '.IdDestino = CInt(iisNull(cdp("IdDestino")))
        '.AgregaItemDeGastosAdministrativos = CStr(iisNull(cdp("AgregaItemDeGastosAdministrativos")))

        Dim l = tablaEditadaDeFacturasParaGenerarComoLista.Select(Function(x) x.idCartaDePorte).ToList
        Dim ss As String
        If Not VerificarQueNoHayaCambiadoElLoteDesdeQueSeCreoLaFacturacion(l, SC, ss) Then
            Throw New Exception(ss)
            Return
        End If



        Dim TOPEFACTURAS As Integer = ConfigurationManager.AppSettings("Debug_TopeFacturasCartaPorte")  ' = 20000 'BuscarClaveINI("TopeFacturasCartaPorte")


        Dim db = New LinqCartasPorteDataContext(Encriptar(SC))


        For Each owhere In dtwhere


            If n >= TOPEFACTURAS Then
                errLog &= "Se llegó al máximo de " & n & " facturas  <br/>" & vbCrLf

                Exit For
            End If

            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////PASO 1        (Lote 14s, Compronto 7s, Imputacion 2s)
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

            n = n + 1
            Debug.Print("lote " & n & "/" & dtwhere.Count & " " & Now.ToString)

            'chupo la agrupacion del datatable y lo pongo en una List (porque antes lo hacía así, y la
            'funcion que genera las facturas usa una List )
            Dim idClienteAfacturarle As Long = owhere.IdCliente

            If idClienteAfacturarle = -1 Then
                'verificar que no sea por el largo del nombre
                If Len(owhere.Cliente.ToString) = 50 Then
                    Dim ds = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 IdCliente FROM Clientes WHERE RazonSocial like '" & Replace(owhere.Cliente, "'", "''") & "%'")
                    If ds.Rows.Count < 1 Then
                        ErrHandler2.WriteError("No se encuentra el cliente " & owhere.Cliente)
                        Continue For
                    End If
                    idClienteAfacturarle = ds.Rows(0).Item("IdCliente")
                Else
                    ErrHandler2.WriteError("No se encuentra el cliente " & owhere.Cliente)
                    Continue For
                End If
            End If
            'If idClienteAfacturarle <> owhere("IdCliente") - 1 Then
            ' 'error
            ' End If

            Dim lote As New System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte)
            Dim listEmbarques As New System.Collections.Generic.List(Of DataRow)
            'Dim strwhere = "FacturarselaA=" & _c(owhere.Cliente) & " AND [ClienteSeparado]=" & _c(owhere.IdClienteSeparado)

            'para filtrar las que no tienen el corredor separado, no puedo poner filtrar por vacío, hombre
            'justamente porque en Corredor hay datos!
            'la solucion es agregarle al tablaEditadaDeFacturasParaGenerar la columna con la separacion del corredor...




            Dim dtRenglonesAgregados As DataTable = tablaEditadaDeFacturasParaGenerar.Clone 'copio SOLAMENTE la estructura
            'Dim dtRenglonesAgregados As DataTable = Nothing


            'Dim dtLotecito = ProntoFuncionesGenerales.DataTableWHERE(tablaEditadaDeFacturasParaGenerar, strwhere)
            Dim cli = owhere.Cliente
            Dim clisep = owhere.IdClienteSeparado
            Dim dtlotecito = (From i In tablaEditadaDeFacturasParaGenerarComoLista
                              Where i.FacturarselaA = cli And i.ClienteSeparado = clisep
                         ).ToList


            Dim n2tot = dtlotecito.Count
            Dim n2 = 0


            Dim bucleWatch As New Stopwatch()


            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10460


            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=12913
            'como hago para crear el tope de renglones?
            '-igual que haces para el tope de monto!!!
            'resolverlo en EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones()
            If False Then
                'For Each i In dtlotecito
                '    Dim q = AgruparItemsDeLaFactura(lote, optFacturarA, agruparArticulosPor, SC, txtBuscar)

                '    Dim renglons As Integer = 0
                '    For Each o In q
                '        renglons += 1 'como es un Enumerable, tengo que iterar, no tengo un metodo Count()
                '    Next
                '    If renglons > MAXRENGLONES Then
                '        Dim s2 = "La factura para " & idClienteAfacturarle.ToString() & " tiene " & renglons.ToString() & " renglones y el máximo es " & MAXRENGLONES.ToString()
                '        ErrHandler2.WriteAndRaiseError(s2)
                '        'Throw New Exception(s2)
                '        ' Return -12
                '    End If
                'Next
            End If


            For Each i In dtlotecito
                bucleWatch.Stop()
                'Debug.Print("Bucle " & bucleWatch.Elapsed.Milliseconds)
                bucleWatch.Reset()
                bucleWatch.Start()

                n2 = n2 + 1
                'Debug.Print("                   lote " & n & "/" & dtwhere.Count & " cdp " & n2 & "/" & n2tot & " " & Now.ToString)



                If iisNull(i.idCartaDePorte, 0) > 0 Then 'es un renglon agregado a mano? 


                    'TODO: es este FOR el que hace ineficiente la facturacion
                    'qué es lo molesto? El GetItem o el SavePrecioPorCliente?

                    Dim stopWatch As New Stopwatch()
                    ' Get the elapsed time as a TimeSpan value.
                    'Dim ts As TimeSpan = stopWatch.Elapsed

                    stopWatch.Start()

                    Dim ocdp As Pronto.ERP.BO.CartaDePorte
                    If False Then
                        ocdp = CartaDePorteManager.GetItem(SC, i.idCartaDePorte)
                    Else
                        'hago un truco: en lugar de llamar al ineficiente Getitem, le paso yo los datos a mano 
                        ocdp = New CartaDePorte
                        With ocdp
                            .Id = i.idCartaDePorte

                            .Destino = i.Destino
                            .IdArticulo = i.IdArticulo
                            .NetoFinalIncluyendoMermas = i.NetoFinal
                            .AgregaItemDeGastosAdministrativos = (i.AgregaItemDeGastosAdministrativos.ToString = "SI")

                            .FechaDescarga = i.FechaDescarga

                            .Titular = i.Titular
                            .CuentaOrden1 = i.CuentaOrden1
                            .CuentaOrden2 = i.CuentaOrden2
                            .Corredor = i.Corredor
                            .Entregador = i.Entregador


                            .TarifaCobradaAlCliente = iisNull(i.TarifaFacturada, 0)
                        End With
                    End If





                    stopWatch.Stop()
                    ' Debug.Print("GetItem " & stopWatch.Elapsed.Milliseconds)


                    If ocdp.IdFacturaImputada > 0 Then
                        If optFacturarA = 5 Then
                            'facturacion automatica
                            'MODIFICACION: ya no permitir la duplicacion automatica de cartas
                            'ocdp = CartaDePorteManager.DuplicarCartaporteConOtroSubnumeroDeFacturacion(sc, ocdp)
                            Dim sErr = "Esta carta ya está imputada. No se permite la duplicación automatica de cartas. " & ocdp.Id & " " & ocdp.NumeroCartaDePorte & " " & ocdp.SubnumeroVagon & " " & ocdp.SubnumeroDeFacturacion
                            'Err.Raise(64646, , sErr)
                            ErrHandler2.WriteError(sErr)
                            Continue For
                        Else
                            'tiene q haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica
                            Err.Raise(64646, , "Esta carta ya está imputada. Tiene que haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica", "Tiene que haber algun error. Solo debería haber cartasporte sin facturar si no se usó la facturacion automatica")
                        End If
                    End If



                    If False Then 'voy a sacarlo, qué tanto!

                        If Not _DEBUG_FACTURACION_PRECIOS Then
                            stopWatch.Start()



                            'ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, ocdp.TarifaCobradaAlCliente)

                            'cómo se acá si el precio no lo traje de un destino, y al pisar el generico, estoy jodiendolo? -serian pocos los casos, no?
                            '-y es necesario refrescarlo acá???
                            'ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, ocdp.TarifaCobradaAlCliente)

                            ListaPreciosManager.SavePrecioPorCliente(SC, idClienteAfacturarle, ocdp.IdArticulo, ocdp.TarifaCobradaAlCliente)
                            stopWatch.Stop()
                            Debug.Print("SavePrecioPorCliente " & stopWatch.Elapsed.Milliseconds)
                        End If
                    End If





                    lote.Add(ocdp) 'ojo que es una carta que no tiene todos los datos
                Else
                    'renglon agregado a mano o embarque

                    '/////////////////////////////////////////////////////////////////////////////////
                    'reemplazar este pedazo de codigo para que deje de usar el tablaEditadaDeFacturasParaGenerar y 
                    'use el tablaEditadaDeFacturasParaGenerarComoLista
                    '/////////////////////////////////////////////////////////////////////////////////

                    If iisNull(i.idCartaDePorte, 0) < -1 Then '= IDEMBARQUES Then
                        'es un embarque
                        Try

                            Dim strwhere = "IdCartaDePorte <-1 AND SubNumeroVagon=" & (i.idCartaDePorte * -1) & " And FacturarselaA = " & _c(owhere.Cliente) & " And [ClienteSeparado] = " & _c(owhere.IdClienteSeparado)
                            Dim dtbuque = DataTableWHERE(tablaEditadaDeFacturasParaGenerar, strwhere)
                            If dtbuque.Rows.Count <> 1 Then
                                ErrHandler2.WriteAndRaiseError("Se repite un buque")
                            Else

                                Dim r As DataRow = dtbuque.Rows(0)


                                'como pudo agregarlo dos veces? es un bug que está sucediendo

                                If listEmbarques.Contains(r) Then
                                    ErrHandler2.WriteAndRaiseError("Se repite un buque")
                                Else
                                    listEmbarques.Add(r)
                                End If
                            End If


                        Catch ex As Exception
                            ErrHandler2.WriteError("No se pudo incrustar el renglon de buque")
                            ErrHandler2.WriteAndRaiseError(ex)
                        End Try

                    Else
                        'es un renglon agregado a mano
                        Try
                            Dim strwhere = "IdCartaDePorte IS NULL AND FacturarselaA=" & _c(owhere.Cliente) &
                                        " AND [ClienteSeparado]=" & _c(owhere.IdClienteSeparado) &
                                        " AND KgNetos= " & i.NetoFinal & " AND  TarifaFacturada= " & i.TarifaFacturada &
                                        " AND Producto='" & NombreArticulo(SC, i.IdArticulo) & "'"


                            Dim dtaa = DataTableWHERE(tablaEditadaDeFacturasParaGenerar, strwhere)
                            'es capaz de traer dos veces el mismo, porque un "CAMBIO CARTA PORTE" y un
                            '  "GASTOS ANALISIS" pueden tener el mismo FacturarselaA y  FacturarselaA
                            '-pero no tengo el articulo en el "oWhere"!!!!
                            'pero lo tenes en el dtaa, no? -no! Tengo el IdArticulo en -1!!!!
                            '-y cómo sabés entonces qué artículo facturar despues?????


                            If dtaa.Rows.Count > 1 Then
                                ErrHandler2.WriteAndRaiseError("No se pudo incrustar el renglon manual. Más de un renglon cumple el filtro. " & strwhere)
                            ElseIf dtaa.Rows.Count < 1 Then


                                'si hay acopios (por ejemplo, el renglon dice en ClienteSeparado="acopiosepara 7") no tengo manera de
                                'saber a qué agrupamiento le corresponde el item manual........

                                ErrHandler2.WriteAndRaiseError("No se pudo incrustar el renglon manual. Ningún renglon cumple el filtro. " & strwhere)
                            End If

                            Dim r As DataRow = dtaa.Rows(0)
                            dtRenglonesAgregados.ImportRow(r)


                        Catch ex As Exception
                            ErrHandler2.WriteError("No se pudo incrustar el renglon manual")
                            ErrHandler2.WriteAndRaiseError(ex)
                        End Try
                    End If
                End If

            Next


            Debug.Print("1 - Lote armado en " & DateDiff(DateInterval.Second, tTemp, Now))
            tTemp = Now









            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////PASO 2
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            'Debug.Print("Creando Factura " & Now.ToString)


            'creo la factura
            '-¿Cómo verifico que no se haya imputado la carta en los lotecitos anteriores?
            '-Ya se está haciendo arriba, en la llamada a CrearleAlaCartaporteUnSubnumeroParaFacturarselo

            'como puedo averiguar cuantos renglones tendrá la factura? -tantos renglones como agrupamientos devuelva AgruparItemsDeLaFactura()


            Dim imputaciones As IEnumerable(Of grup)


            Try
                idFactura = CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta, dtRenglonesAgregados, SC, Session, optFacturarA,
                                         agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
                                         txtCorredor, chkPagaCorredor, listEmbarques, imputaciones, idClienteObservaciones)

            Catch ex As AccessViolationException
                'http://stackoverflow.com/questions/5842985/attempted-to-read-or-write-protected-memory-error-when-accessing-com-component
                MandarMailDeError("AccessViolationException. Está todo compilado para x86???")
                Throw
            Catch ex As Exception
                Throw
            End Try

            Debug.Print("2- ComPronto llamado en " & DateDiff(DateInterval.Second, tTemp, Now))
            tTemp = Now




            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////PASO 3
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

            'el asunto es que si una se pasa, debería parar toda la facturacion, y no saltarse solo esa factura
            If idFactura = -12 Then
                errLog &= "No se pudo crear la factura para " &
            "<a href=""Cliente.aspx?Id=" & idClienteAfacturarle & """ target=""_blank"">" & NombreCliente(SC, idClienteAfacturarle) & "</a>; " &
            " Excede el máximo de renglones <br/>"
            End If


            If idFactura = -99 Then
                errLog &= "No se pudo crear la factura para " &
         "<a href=""Cliente.aspx?Id=" & idClienteAfacturarle & """ target=""_blank"">" & NombreCliente(SC, idClienteAfacturarle) & "</a>; " &
         " Excede el máximo de renglones <br/>"
                'La factura quizas se generó por la mitad!!!!
                'te descajeta la numeracion
                'el compronto alcanza a armar la factura, pero no crea el subdiario
            End If



            'control de primera y ultima y errores
            If primera = 0 And idFactura <> -1 Then primera = idFactura

            If idFactura > 0 Then
                'se facturó bien

                ultima = idFactura

                'hago las imputaciones
                Try


                    For Each o In lote
                        'TODO: la imputacion tambien es ineficiente, porque llama para grabar a la cdp, que a su vez revisa clientes, etc
                        'Debug.Print("               imputo " & Now.ToString)

                        If True Then
                            'If InStr(o.FacturarselaA, "<EMBARQUE>") = 0 Then
                            CartaDePorteManager.ImputoLaCDP(o, idFactura, SC, Session(SESSIONPRONTO_UserName), imputaciones)
                        Else
                            'y si es un embarque? -pero los embarques no estan en la coleccion lote !!!!!!
                        End If


                    Next


                    Dim imp = imputaciones.Count
                    For n = 0 To listEmbarques.Count - 1
                        Dim o As DataRow = listEmbarques(n)
                        Dim renglonimputado = imp + n
                        CartaDePorteManager.ImputoElEmbarque(o("SubnumeroVagon"), idFactura, SC, Session(SESSIONPRONTO_UserName), renglonimputado)
                    Next


                    EntidadManager.LogPronto(SC, idFactura, "Factura De CartasPorte: id" & idFactura & " " & optFacturarA & " AGR:" & agruparArticulosPor & " busc:" & txtBuscar, Session(SESSIONPRONTO_UserName))


                Catch ex As Exception

                    'si esto falla, anular la ultima factura y cortar el proceso
                    'anular factura idfactura
                    MandarMailDeError(ex)

                    'y por que no la anuló? me mandó el mail bien (del timeout) del 22 de junio a las 15:42

                    Dim myFactura As Pronto.ERP.BO.Factura = FacturaManager.GetItem(SC, idFactura)

                    If Not Debugger.IsAttached Then
                        FacturaManager.AnularFactura(SC, myFactura, Session(SESSIONPRONTO_glbIdUsuario))

                        'terminar lote
                        Throw
                    End If
                End Try


            Else
                Try
                    'hubo un error al generar la factura de este lote
                    errLog &= "No se pudo crear la factura para " &
                "<a href=""Cliente.aspx?Id=" & idClienteAfacturarle & """ target=""_blank"">" & NombreCliente(SC, idClienteAfacturarle) & "</a>; " &
                " verificar IVA y CUIT, o que la carta no estuviese imputada anteriormente; Verificar que no " &
                " se haya disparado el error 'listacdp vacia' o no haya otro cliente con el mismo nombre <br/>" & vbCrLf
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    MandarMailDeError(ex)
                End Try
                ErrHandler2.WriteError(errLog)
            End If


            'limpio el lote -no te conviene hacer un new en cada iteracion?
            lote.Clear()


            Debug.Print("3- Imputacion y limpieza en " & DateDiff(DateInterval.Second, tTemp, Now))
            tTemp = Now
        Next


        Debug.Print("Fin " & Now.ToString)



        'está grabando las lineas agregadas?





        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        'Despues de facturar, muestro la grilla de generadas y mensajes de error
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////

        ' FacturaManager.GetItemComPronto(sc, primera, False).Numero
        '& FacturaManager.GetItemComPronto(sc, ultima, False).Numero
        If primera = 0 Then
            ErrHandler2.WriteError("No se han podido generar facturas. " & vbCrLf & errLog)
            Throw New Exception("No se han podido generar facturas. " & vbCrLf & errLog)

        End If



        Dim s = "SELECT 'Factura.aspx?Id='+ cast(idFactura as varchar) as URLgenerada,tipoabc,puntoventa, " &
            " NumeroFactura as [NumeroFactura],clientes.RazonSocial, " &
            " ImporteTotal, ImporteIva1,IVANoDiscriminado , RetencionIBrutos1,RetencionIBrutos2,RetencionIBrutos3,clientes.IdCodigoIVA,clientes.IBcondicion,NumeroCertificadoPercepcionIIBB   " &
            " FROM Facturas " &
            " JOIN Clientes on Facturas.Idcliente=Clientes.Idcliente   WHERE idFactura between " & primera & " AND " & ultima &
            " ORDER BY idFactura  "

        gvFacturasGeneradas.DataSource = EntidadManager.ExecDinamico(SC, s)
        gvFacturasGeneradas.DataBind()



        Try
            PrimeraIdFacturaGenerada = primera
            UltimaIdFacturaGenerada = ultima

            primera = iisNull(EntidadManager.ExecDinamico(SC,
                                                         "SELECT NumeroFactura FROM Facturas WHERE idFactura= " & primera).Rows(0).Item("NumeroFactura"), 1)
            ultima = iisNull(EntidadManager.ExecDinamico(SC,
                                                         "SELECT NumeroFactura FROM Facturas WHERE idFactura= " & ultima).Rows(0).Item("NumeroFactura"), 1)



            tHoraTermina = Now
            ErrHandler2.WriteError("Fin facturacion." & primera & " " & ultima & "  Tiempo usado: " & DateDiff(DateInterval.Second, tHoraEmpieza, tHoraTermina) & " segundos. ")


            MarcarFacturasConOrdenDeCompra(Val(numeroOrdenCompra), PrimeraIdFacturaGenerada, UltimaIdFacturaGenerada, SC)



        Catch ex As Exception
            ErrHandler2.WriteError("Error al buscar facturas generadas. " & ex.ToString)
            MandarMailDeError(ex)

        End Try

        'lblMensaje.Text = errLog ' "Creadas facturas de la " & primera & " a la " & ultima & ". Facturacion terminada"

    End Sub

    Shared Function MarcarFacturasConOrdenDeCompra(numeroorden As Long, idfactpri As Long, idfactult As Long, SC As String)

        Try

            Dim s = "UPDATE    Facturas  SET numeroordencompraexterna=" & numeroorden.ToString() & "   WHERE idFactura>= " & idfactpri.ToString() & "  AND    idFactura <= " & idfactult.ToString()
            ErrHandler2.WriteError(s)
            If numeroorden > 0 Then

                EntidadManager.ExecDinamico(SC, s)
            End If

        Catch ex As Exception
            MandarMailDeError(ex)
        End Try


    End Function






    Const SEPAR = ";"




    Public Class grup
        Public cartas As System.Collections.Generic.IEnumerable(Of Pronto.ERP.BO.CartaDePorte)
        Public IdArticulo As Integer
        Public Entregador As Integer
        Public Titular As Integer
        Public Destino As Integer
        Public ObservacionItem As String
        Public NetoFinal As Double
        Public total As Double
    End Class




    Shared Function AgruparItemsDeLaFactura(ByRef oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte),
                                        ByVal optFacturarA As Integer, ByVal agruparArticulosPor As String, ByVal SC As String,
                                        ByVal sBusqueda As String) As List(Of grup) 'Generic.List(Of Object) 'grup)

        'Dim q 'As Generic.List(Of Object) 'grup) 
        Dim q As Generic.IEnumerable(Of grup)
        'lo pasé acá para poder meter lo del agrupamiento de titular. Pero pierdo 
        'el tipado anónimo (despues) Tuve que abortar, no me acuerdo por qué




        'TITULAR:
        '                 agrupar por Destinatario + Destino

        'DESTINATARIO:
        '                 agrupar por Titular + Destino

        'CORREDOR:
        '                 agrupar por Destino + Titular + Destinatario

        'A TERCERO default: 
        '                 agrupar por Destino + Destinatario 

        'A TERCERO con EXPORTA='SI': 
        '                 agrupar por Destino

        'A TERCERO excepcion loca: 
        '                 agrupar por Destino + Titular



        '-qué pasa si hay acopios????? -eso agrupa en distintas facturas, no en items de la misma factura


        '        Log Entry
        '09/18/2014 09:22:42
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. 
        '    Error Message:Error en la llamada a CreaFacturaCOMpronto. System.InvalidCastException: Unable to cast object of 
        '        type 'WhereSelectEnumerableIterator`2[VB$AnonymousType_49`3[System.Int32,System.Int32,System.Collections.Generic.IEnumerable`1[Pronto.ERP.BO.CartaDePorte]],VB$AnonymousType_50`6[System.Collections.Generic.IEnumerable`1[Pronto.ERP.BO.CartaDePorte],System.Int32,System.Int32,System.String,System.Double,System.Double]]'
        ' to type 'System.Collections.Generic.List`1[System.Object]'.
        '   at LogicaFacturacion.AgruparItemsDeLaFactura(List`1& oListaCDP, Int32 optFacturarA, String agruparArticulosPor, 
        '       String SC, String sBusqueda)
        '   at LogicaFacturacion.CreaFacturaCOMpronto(List`1 oListaCDP, Int64 IdClienteAFacturarle, Int64 puntoVentaWilliams, 
        '       DataTable dtRenglonesManuales, String SC, HttpSessionState Session, Int32 optFacturarA, String agruparArticulosPor, 
        '       String txtBuscar, String txtTarifaGastoAdministrativo, Boolean SeSeparaPorCorredor, String txtCorredor, Boolean 
        '       chkPagaCorredor, List`1 listEmbarques)



        'como hacer para marcar a con qué grupo se imputó cada carta????
        '-usar el Group



        If optFacturarA >= 4 And agruparArticulosPor = "Destino" Then
            'si es modo Exporta y A terceros, agrupo solo por IdArticulo y Destino

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                Group i By i.IdArticulo, i.Destino Into Group
                Select New grup With {
                        .cartas = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = -1, .Titular = -1,
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino),
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000),
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente)
                             }

        ElseIf optFacturarA >= 4 And agruparArticulosPor = "Destino+Destinatario" Then


            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                Group i By i.IdArticulo, i.Destino, i.Entregador Into Group
                Select New grup With {.cartas = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = -1,
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                     & SEPAR & NombreCliente(SC, Entregador),
                                     .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000),
                                    .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente)
                             }

        ElseIf optFacturarA >= 4 And agruparArticulosPor = "Destino+Titular" Then

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                Group i By i.IdArticulo, i.Destino, i.Titular Into Group
                Select New With {.cartas = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = -1, .Titular = Titular,
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                                 & SEPAR & NombreCliente(SC, Titular),
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000),
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente)
                             }


        ElseIf optFacturarA = 3 And agruparArticulosPor = "Destino+RComercial/Interm+Destinat(CANJE)" Then
            'se le factura al corredor agrupando por el CANJE
            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8530
            'No está funcionando la impresión del Canje cuando se elije un Intermediario/RteComercial en \"Que Contenga\" y CANJE en \"Agrupar Renglones de Cereales por\"


            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                Group i By i.IdArticulo, i.Destino, i.CuentaOrden1, i.CuentaOrden2, i.Entregador Into Group
                Select New grup With {.cartas = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = -1,
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                        & SEPAR & sBusqueda _
                                        & SEPAR & NombreCliente(SC, Entregador) & Space(80) & "    __" & CuentaOrden1 & " " & CuentaOrden2,
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000),
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente)
                             }

        ElseIf optFacturarA <> 3 And agruparArticulosPor = "Destino+RComercial/Interm+Destinat(CANJE)" Then
            'se le factura NO al corredor agrupando por el CANJE
            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8530
            'todo: No está funcionando la impresión del Canje cuando se elije un Intermediario/RteComercial en \"Que Contenga\" y CANJE en \"Agrupar Renglones de Cereales por\"


            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                Group i By i.IdArticulo, i.Destino, i.CuentaOrden1, i.CuentaOrden2, i.Entregador Into Group
                Select New grup With {.cartas = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = -1,
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                        & SEPAR & sBusqueda _
                                        & SEPAR & NombreCliente(SC, Entregador) & Space(80) & "    __" & CuentaOrden1 & " " & CuentaOrden2,
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000),
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente)
                             }


        ElseIf optFacturarA = 3 Then
            'se le factura al corredor

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                Group i By i.IdArticulo, i.Destino, i.Titular, i.Entregador Into Group
                Select New grup With {.cartas = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = Titular,
                                .ObservacionItem = TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino) _
                                        & SEPAR & NombreCliente(SC, Titular) _
                                        & SEPAR & NombreCliente(SC, Entregador),
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000),
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente)
                             }



        ElseIf optFacturarA = 2 Then
            'se le factura al destinatario, quitar al titular del agrupamiento

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                Group i By i.IdArticulo, i.Titular, i.Destino Into Group
                Select New grup With {.cartas = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = -1, .Titular = Titular,
                                .ObservacionItem = NombreCliente(SC, Titular) _
                                        & SEPAR & TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino),
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000),
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente)
                             }

        ElseIf optFacturarA = 1 Then
            'se le factura al titular

            q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                Group i By i.IdArticulo, i.Entregador, i.Destino Into Group
                Select New grup With {.cartas = Group, .IdArticulo = IdArticulo, .Destino = Destino, .Entregador = Entregador, .Titular = -1,
                                      .ObservacionItem = NombreCliente(SC, Entregador) _
                                                    & SEPAR & TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", Destino),
                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000),
                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinalIncluyendoMermas / 1000 * i.TarifaCobradaAlCliente)
                             }
            '                                   , .cartas = Group.Select(Function(c) c.Id) _

        Else
            Err.Raise(333, "", "No se pudo identificar el criterio de agrupación")
        End If



        'Dim q = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP _
        '            Group i By i.IdArticulo, i.Destino, i.Titular, i.Entregador Into Group _
        '            Select New With {Group, IdArticulo, Destino, Titular, Entregador, _
        '                                .NetoFinal = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinal / 1000), _
        '                                .total = Group.Sum(Function(i As Pronto.ERP.BO.CartaDePorte) i.NetoFinal / 1000 * i.TarifaCobradaAlCliente) _
        '                             }

        'acá se puede empezar a hacer la imputacion a nivel item



        Return q.ToList()
    End Function



    Shared Function VerificadorDeSeparadorEnClientesContraCorredores(ByVal SC As String)

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim q = From c In db.linqClientes Where c.ExpresionRegularNoAgruparFacturasConEstosVendedores IsNot Nothing
                Select c.ExpresionRegularNoAgruparFacturasConEstosVendedores

        Dim errores As String = ""
        For Each i In q

            'Si hay mas de un cliente/corredor que use esa razon social, tirar alarma

            Dim a() As String = Split(i, "|")

            'pero cómo sé si es solo un cliente o es un cliente/corredor?????? porque no hay manera de saberlo si no es con la regla de usar el mismo nombre, no hay redundancia para revisar
            '-solo revisá que no haya más de un cliente con ese nombre, y que no haya más de un corredor con ese nombre

            'Dim corredor As String = EntidadManager.GetItem(SC, "Vendedores", oCDP.Corredor).Item("Nombre")



            For Each s In a
                If s = "" Then Continue For

                Dim qclis = (From c In db.linqClientes Where c.RazonSocial = s).DefaultIfEmpty



                Dim qcorr = (From c In db.linqCorredors Where c.Nombre = s).DefaultIfEmpty

                If (qclis.Count = 1 And qcorr.Count = 1) Or
                (qclis.Count = 1 And qcorr.Count = 0) Or
                (qclis.Count = 0 And qcorr.Count = 1) Then
                    'OK()
                Else
                    'Error 
                    errores += s + " - Como cliente: " + qclis.Count.ToString + ".  Como corredor: " + qcorr.Count.ToString + ". VerificadorDeSeparadorEnClientesContraCorredores" + vbCrLf
                End If

            Next


        Next


        If errores <> "" Then ErrHandler2.WriteAndRaiseError(errores)
    End Function


    'Shared Function ActualizarCampoClienteSeparador(q As IQueryable(Of wTempCartasPorteFacturacionAutomatica), ByVal SeSeparaPorCorredor_O_porTitular As Boolean, ByVal sc As String)

    '    'Dim db As New LinqCartasPorteDataContext(Encriptar(sc))
    '    'Dim o = (From i In q _
    '    '        Join 
    '    '        join vendedor   nombrecliente   ExpresionRegularNoAgruparFacturasConEstosVendedores



    '    ''sss()
    'End Function

    Const IdAcopioAgro = 1
    Const IdAcopioSeeds = 2


    Shared Function LeyendaAcopio(idfactura As Integer, SC As String) As String

        '        Log Entry
        '12/09/2014 15:38:31
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=66871. Error Message:System.InvalidOperationException
        'Nullable object must have a value.
        '   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
        '   at LogicaFacturacion._Lambda$__167(CartasDePorte c)
        '   at System.Collections.Generic.List`1.FindIndex(Int32 startIndex, Int32 count, Predicate`1 match)
        '   at LogicaFacturacion.LeyendaSyngenta(Int64 idfactura, String SC)
        '   at CartaDePorteManager.FacturaXML_DOCX_Williams(String document, Factura oFac, String SC)
        '   at CartaDePorteManager.ImprimirFacturaElectronica(Int32 IdFactura, Boolean bMostrarPDF, String SC)
        '   at FacturaABM.LinkImprimirXMLFactElectronica_Click(Object sender, EventArgs e)
        '        mscorlib()


        '()




        '        Log Entry
        '04/13/2015 10:20:20
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=69458. Error Message:System.NotSupportedException
        'Constructed arrays are only supported for Contains.
        '   at System.Data.Linq.SqlClient.QueryConverter.CoerceToSequence(SqlNode node)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitSelectMany(Expression sequence, LambdaExpression colSelector, LambdaExpression resultSelector)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitSequenceOperatorCall(MethodCallExpression mc)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitMethodCall(MethodCallExpression mc)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitInner(Expression node)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitDistinct(Expression sequence)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitSequenceOperatorCall(MethodCallExpression mc)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitMethodCall(MethodCallExpression mc)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitInner(Expression node)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitAggregate(Expression sequence, LambdaExpression lambda, SqlNodeType aggType, Type returnType)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitSequenceOperatorCall(MethodCallExpression mc)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitMethodCall(MethodCallExpression mc)
        '   at System.Data.Linq.SqlClient.QueryConverter.VisitInner(Expression node)
        '   at System.Data.Linq.SqlClient.QueryConverter.ConvertOuter(Expression node)
        '   at System.Data.Linq.SqlClient.SqlProvider.BuildQuery(Expression query, SqlNodeAnnotations annotations)
        '   at System.Data.Linq.SqlClient.SqlProvider.System.Data.Linq.Provider.IProvider.Execute(Expression query)
        '   at System.Data.Linq.DataQuery`1.System.Linq.IQueryProvider.Execute[S](Expression expression)
        '   at System.Linq.Queryable.Count[TSource](IQueryable`1 source)
        '   at LogicaFacturacion.LeyendaAcopio(Int64 idfactura, String SC)
        '   at CartaDePorteManager.FacturaXML_DOCX_Williams(String document, Factura oFac, String SC)
        '        System.Data.Linq()
        '        __________________________()


        'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim db = New ProntoMVC.Data.Models.DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))


        Dim oListaCDP = db.CartasDePortes.Where(Function(x) x.IdFacturaImputada = idfactura).ToList
        Dim oFac = db.Facturas.Where(Function(x) x.IdFactura = idfactura).FirstOrDefault()


        Dim acopios = (From x In oListaCDP
                       Select New With {
                    .Acopio1 = CInt(IIf(x.AcopioFacturarleA > 0, x.AcopioFacturarleA, If(x.Acopio1, 0))),
                    .Acopio2 = CInt(IIf(x.AcopioFacturarleA > 0, x.AcopioFacturarleA, If(x.Acopio2, 0))),
                    .Acopio3 = CInt(IIf(x.AcopioFacturarleA > 0, x.AcopioFacturarleA, If(x.Acopio3, 0))),
                    .Acopio4 = CInt(IIf(x.AcopioFacturarleA > 0, x.AcopioFacturarleA, If(x.Acopio4, 0))),
                    .Acopio5 = CInt(IIf(x.AcopioFacturarleA > 0, x.AcopioFacturarleA, If(x.Acopio5, 0))),
                    .Acopio6 = CInt(IIf(x.AcopioFacturarleA > 0, x.AcopioFacturarleA, If(x.Acopio6, 0)))
                    }).ToList

        'caso 2: había acopios de distintos clientes (ACA PEHUAJO en factura de LDC). Usar solamente los del cliente facturado
        Dim acopiosdelcliente = db.CartasPorteAcopios.Where(Function(x) x.IdCliente = oFac.IdCliente).Select(Function(x) x.IdAcopio).ToList

        Dim ccc As List(Of Integer) = acopios.SelectMany(Function(x) _
                                                     {x.Acopio1, x.Acopio2, x.Acopio3, x.Acopio4, x.Acopio5, x.Acopio6}
                        ).Where(Function(x) x <> 0 And acopiosdelcliente.Contains(x)).Distinct.ToList



        'Dim acopioseparado As Integer? = cartamapeada.AcopioFacturarleA
        'If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio1
        'If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio2
        'If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio3
        'If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio4
        'If If(acopioseparado, 0) = 0 Then acopioseparado = cartamapeada.Acopio5

        'If If(acopioseparado, 0) > 0 Then carta.ClienteSeparado = "acopiosepara " & nombreacopio(acopioseparado)

        'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14851


        Dim s = ""




        'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=22255
        'caso 1: si es LDC y elevacion (o sea exportacion), NO mostrar "ACOPIO OTROS" (pero sí los demás)
        'caso 2: había acopios de distintos clientes (ACA PEHUAJO en factura de LDC). Usar solamente los del cliente facturado

        If ccc.Count > 1 Then
            'Return vbCrLf + "Acopios id" + nombreacopio(acopios(0), SC)
            s = "ACOPIO " & nombreacopio(ccc(0), SC)

            Dim id As Integer = ccc(0)
            Dim o = db.CartasPorteAcopios.Where(Function(x) x.IdAcopio = id).FirstOrDefault

        ElseIf ccc.Count = 1 Then
            s = "ACOPIO " & nombreacopio(ccc(0), SC)
            'Return ""
        End If



        Dim EsExportacion As Boolean = oListaCDP.Exists(Function(x) x.Exporta = "SI")
        EsExportacion = LogicaFacturacion.EsDeExportacion(oFac.IdFactura, SC)


        If oFac.IdCliente = 2775 And EsExportacion And s = "ACOPIO OTROS" Then
            'caso 1: si es LDC y elevacion (o sea exportacion), NO mostrar "ACOPIO OTROS" (pero sí los demás)
            s = ""
        End If




        ' esto se lo paso al OBSITEM
        ' If oFac.IdCliente = 2775 And EsDeExportacion(idfactura, SC) Then s = "ELEVACION " & s

        Return s

    End Function


    Public Shared Function EsDeExportacion(idfactura As Integer, SC As String) As Boolean



        Try

            Dim db = New ProntoMVC.Data.Models.DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

            Dim oListaCDP = db.CartasDePortes.Where(Function(x) x.IdFacturaImputada = idfactura)
            Dim oFac = db.Facturas.Where(Function(x) x.IdFactura = idfactura).FirstOrDefault() 'explota aca con la 79074. q tiene esa factura de particular?

            Dim expo = From x In oListaCDP
                       Where x.Exporta = "SI"


            Return expo.Count > 0
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Try
                ErrHandler2.WriteError(ex.InnerException.ToString)
                ErrHandler2.WriteError(idfactura.ToString)
            Catch ex2 As Exception
            End Try


            Return False
        End Try

    End Function


    Shared Function nombreacopio(idacopio As Integer, SC As String) As String

        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim o = db.CartasPorteAcopios1.Where(Function(x) x.IdAcopio = idacopio).First

        Return o.Descripcion
    End Function



    Shared Function LeyendaSyngenta(idfactura As Integer, SC As String) As String

        '        Log Entry
        '12/09/2014 15:38:31
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=66871. Error Message:System.InvalidOperationException
        'Nullable object must have a value.
        '   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
        '   at LogicaFacturacion._Lambda$__167(CartasDePorte c)
        '   at System.Collections.Generic.List`1.FindIndex(Int32 startIndex, Int32 count, Predicate`1 match)
        '   at LogicaFacturacion.LeyendaSyngenta(Int64 idfactura, String SC)
        '   at CartaDePorteManager.FacturaXML_DOCX_Williams(String document, Factura oFac, String SC)
        '   at CartaDePorteManager.ImprimirFacturaElectronica(Int32 IdFactura, Boolean bMostrarPDF, String SC)
        '   at FacturaABM.LinkImprimirXMLFactElectronica_Click(Object sender, EventArgs e)
        '        mscorlib()


        '()


        Try
            Dim db = New ProntoMVC.Data.Models.DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

            'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

            Dim oListaCDP = db.CartasDePortes.Where(Function(x) x.IdFacturaImputada = idfactura).ToList()
            Dim oFac = db.Facturas.Where(Function(x) x.IdFactura = idfactura).FirstOrDefault() 'explota acá


            Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC)


            'LeyendaSyngenta(oListaCDP, oFac.IdCliente, SC)

            If oFac.IdCliente = idSyngentaAGRO Then

                If oListaCDP.Exists(Function(c) If(c.Acopio1, -1) = IdAcopioAgro Or If(c.Acopio2, -1) = IdAcopioAgro Or If(c.Acopio3, -1) = IdAcopioAgro Or If(c.Acopio4, -1) = IdAcopioAgro _
                                    Or If(c.Acopio5, -1) = IdAcopioAgro Or If(c.Acopio6, -1) = IdAcopioAgro) Then

                    'quienautoriza()
                    ErrHandler2.WriteError("LeyendaSyngenta Agro")

                    Dim quienautoriza = ClienteManager.GetItem(SC, oFac.IdCliente).AutorizacionSyngenta
                    'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=13903
                    'http://consultas.bdlconsultores.com.ar/Admin/verConsultas1.php?recordid=24963
                    Return vbCrLf + quienautoriza
                    Return vbCrLf + "División AGRO – Andreas Bluhm"
                    Return vbCrLf + "Syngenta División Agro. Autoriza: " & IIf(quienautoriza = "", "[vacío]", quienautoriza)

                ElseIf oListaCDP.Exists(Function(xc) If(xc.Acopio1, -1) = IdAcopioSeeds Or If(xc.Acopio2, -1) = IdAcopioSeeds Or If(xc.Acopio3, -1) = IdAcopioSeeds Or If(xc.Acopio4, -1) = IdAcopioSeeds Or If(xc.Acopio5, -1) = IdAcopioSeeds Or If(xc.Acopio6, -1) = IdAcopioSeeds) Then

                    ErrHandler2.WriteError("LeyendaSyngenta Seeds")

                    'quienautoriza()
                    Dim quienautoriza = ClienteManager.GetItem(SC, oFac.IdCliente).AutorizacionSyngenta
                    'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=13903
                    'http://consultas.bdlconsultores.com.ar/Admin/verConsultas1.php?recordid=24963
                    Return vbCrLf + quienautoriza
                    Return vbCrLf + "División AGRO – Andreas Bluhm"
                    Return vbCrLf + "Syngenta División Seeds. Autoriza: " & IIf(quienautoriza = "", "[vacío]", quienautoriza)
                Else
                    Dim quienautoriza = ClienteManager.GetItem(SC, oFac.IdCliente).AutorizacionSyngenta
                    'http://consultas.bdlconsultores.com.ar/Admin/verConsultas1.php?recordid=24963
                    Return vbCrLf + quienautoriza
                    Return vbCrLf + "División AGRO – Andreas Bluhm"
                End If


                'ErrHandler2.WriteError("LeyendaSyngenta Nada")
                Return ""


            End If
        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            Try
                ErrHandler2.WriteError(ex.InnerException.ToString)
                ErrHandler2.WriteError(idfactura.ToString)
            Catch ex2 As Exception
            End Try


            Return ""

        End Try

    End Function

    Shared Function LeyendaSyngenta(ByRef oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte), ByVal IdClienteAFacturarle As Long, SC As String) As String


        Dim idSyngentaAGRO = BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC)


        If IdClienteAFacturarle = idSyngentaAGRO Then
            If oListaCDP.Exists(Function(c) c.Acopio1 = IdAcopioAgro Or c.Acopio2 = IdAcopioAgro Or c.Acopio3 = IdAcopioAgro Or c.Acopio4 = IdAcopioAgro Or c.Acopio5 = IdAcopioAgro Or c.Acopio6 = IdAcopioAgro) Then
                ErrHandler2.WriteError("LeyendaSyngenta Agro")
                'quienautoriza()
                Dim quienautoriza = ClienteManager.GetItem(SC, IdClienteAFacturarle).AutorizacionSyngenta


                'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=13903}
                'http://consultas.bdlconsultores.com.ar/Admin/verConsultas1.php?recordid=24963

                Return vbCrLf + quienautoriza
                Return vbCrLf + "División AGRO – Andreas Bluhm"
                Return vbCrLf + "Syngenta División Agro. Autoriza: " & quienautoriza



            ElseIf oListaCDP.Exists(Function(c) c.Acopio1 = IdAcopioSeeds Or c.Acopio2 = IdAcopioSeeds Or c.Acopio3 = IdAcopioSeeds Or c.Acopio4 = IdAcopioSeeds Or c.Acopio5 = IdAcopioSeeds Or c.Acopio6 = IdAcopioSeeds) Then
                ErrHandler2.WriteError("LeyendaSyngenta Seeds")
                'quienautoriza()
                Dim quienautoriza = ClienteManager.GetItem(SC, IdClienteAFacturarle).AutorizacionSyngenta
                'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=13903
                'http://consultas.bdlconsultores.com.ar/Admin/verConsultas1.php?recordid=24963
                Return vbCrLf + quienautoriza
                Return vbCrLf + "División AGRO – Andreas Bluhm"
                Return vbCrLf + "Syngenta División Seeds. Autoriza: " & quienautoriza

            End If

        End If


        'ErrHandler2.WriteError("LeyendaSyngenta Nada")
        Return ""

    End Function







    Shared Function CreaFacturaPuntoNET(ByVal oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte),
                                     ByVal IdClienteAFacturarle As Long, ByVal sucursalWilliams As Long,
                                     ByVal dtRenglonesManuales As DataTable, ByVal SC As String,
                                     ByVal Session As System.Web.SessionState.HttpSessionState, ByVal optFacturarA As Integer,
                                     ByVal agruparArticulosPor As String, ByVal txtBuscar As String,
                                     ByVal txtTarifaGastoAdministrativo As String,
                                     ByVal SeSeparaPorCorredor As Boolean, ByVal txtCorredor As String,
                                     ByVal chkPagaCorredor As Boolean,
                                     ByVal listEmbarques As System.Collections.Generic.List(Of DataRow),
                                    ByRef ImputacionDevuelta As IEnumerable(Of grup),
                                    IdClienteObservaciones As Integer
) As Integer



        ''Revisar tambien en
        '' Pronto el Utilidades->"Generacion de Facturas a partir de Ordenes de Compra automaticas",
        '' (se llama con frmConsulta2 Id = 74) -Eso es un informe!! No genera nada
        ''y cómo hace para imprimirlas. Tambien Utilidades->"Prefacturacion"
        '' se llama con GeneracionDeFacturasDesdeOrdenesCompraAutomaticas() -Ese llama a frmExcel1.GenerarFacturasAutomaticas

        ''EDU!!!! 
        ''si te paras en el principal (visualizando facturas), marcas las facturas que quieras, 
        ''boton derecho imprimir (o mandar a pantalla), emite masivamente las facturas.
        ''en el frmprincipal esta la funcion EmitirFacturas


        'Dim oAp
        'Dim oFac 'As ComPronto.Factura 
        ''Dim oRs As ADODB.Recordset
        'Dim oRsAux As ADODB.Recordset
        'Dim oRsErrores As ADODB.Recordset
        'Dim mArchivo As String, mTipo As String, mLetra As String, mCliente As String, mCorredor As String, mCuit As String
        'Dim mCuitCorredor As String, mCAI As String, mComprobante As String
        'Dim fl As Integer, mContador As Integer, mIdMonedaPesos As Integer ', mvarPuntoVenta As Integer
        'Dim mIdTipoComprobante As Integer, mIdCodigoIva As Integer
        'Dim mIdArticuloParaImportacionFacturas As Long, mNumero As Long, mIdCliente As Long
        'Dim mIdConceptoParaImportacionNDNC As Long, mNumeroCliente As Long, mIdCuenta As Long
        'Dim mSubtotal As Double, mIVA As Double, mTotal As Double
        'Dim mTasa As Single, mCotizacionDolar As Single
        'Dim mFecha As Date, mFechaCAI As Date
        'Dim mOk As Boolean, mConProblemas As Boolean
        'Dim mAux1
        Dim idFacturaCreada As Integer



        ''estaba hablando con claudio recien, Williams factura con un solo punto 
        ''de venta (con un solo talonario), precisaríamos que todo se facture como talonario 1 y que el 
        ''punto de venta de las CdP facturadas se refleje en el campo Centro de Costo de la 
        ''factura (daríamos de alta los 4 centros de costo)



        'Dim usuario As Integer = 1
        'If Session IsNot Nothing Then usuario = Session(SESSIONPRONTO_glbIdUsuario)


        'Dim tTemp As Date = Now

        'Try

        '    If (oListaCDP Is Nothing Or oListaCDP.Count < 1) And
        '        (dtRenglonesManuales Is Nothing Or dtRenglonesManuales.Rows.Count < 1) And
        '        (listEmbarques Is Nothing Or listEmbarques.Count < 1) Then
        '        ErrHandler2.WriteError("oListaCDP vacía")
        '        Return -1
        '    End If


        '    mLetra = LetraSegunTipoIVA(ClienteManager.GetItem(SC, IdClienteAFacturarle).IdCodigoIva)



        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '/////////////////////////LIOS CON LOS PUNTOS DE VENTA    /////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
        '    Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC,
        '                                "PuntosVenta",
        '                                "PuntoVenta=" & numeropuntoVenta & " AND Letra='" &
        '                                mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
        '    Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////////////////////////////////////



        '    'oAp = ClaseMigrar.CrearAppCompronto(SC)



        '    If IdClienteAFacturarle <= 0 Then Return -1




        '    Dim params = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginalClase(SC)
        '    'ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal()


        '    mIdMonedaPesos = params.p(ParametroManager.ePmOrg.IdMoneda)  'IIf(IsNull(oRs.Fields("IdMoneda").Value), 1, oRs.Fields("IdMoneda").Value)
        '    mIdCuenta = params.p(ParametroManager.ePmOrg.IdCuentaDeudoresVarios)  'IIf(IsNull(oRs.Fields("IdCuentaDeudoresVarios").Value), 0, oRs.Fields("IdCuentaDeudoresVarios").Value)


        '    If mIdCuenta = 0 Then
        '        ErrHandler2.WriteError("No definio en parametros la cuenta contable deudores varios")
        '        Return -1
        '    End If




        '    mAux1 = ParametroManager.TraerValorParametro2(SC, "IdArticuloParaImportacionFacturas")
        '    mIdArticuloParaImportacionFacturas = IIf(IsNull(mAux1), 0, mAux1)
        '    mAux1 = ParametroManager.TraerValorParametro2(SC, "IdConceptoParaImportacionNDNC")
        '    mIdConceptoParaImportacionNDNC = IIf(IsNull(mAux1), 0, mAux1)

        '    If mIdArticuloParaImportacionFacturas = 0 Then
        '        ErrHandler2.WriteError("No definio en parametros el articulo generico para importar las facturas")
        '        Return -1
        '    End If



        '    oRsAux = oAp.Facturas.TraerFiltrado("_PorNumeroComprobante", ArrayVB6(mLetra, IdPuntoVenta, mNumero.ToString))
        '    If oRsAux.RecordCount > 0 Then
        '        AgregarMensajeProcesoPresto(oRsErrores, "La factura " & mComprobante & " ya existe, no se generará")
        '        mConProblemas = True
        '    End If
        '    oRsAux.Close()


        '    mTasa = iisNull(ParametroManager.ParametroOriginal(SC, "Iva1"), 0)
        '    mCAI = CAIsegunPuntoVenta(mLetra, numeropuntoVenta, SC)






        '    If Not mConProblemas Then
        '        oFac = oAp.Facturas.Item(-1)
        '        With oFac

        '            'Try
        '            '    .Guardar() 'para ver si genera un type mismatch
        '            'Catch ex As Exception
        '            '    ErrHandler2.WriteError("Primer Guardar trucho. " & ex.ToString)
        '            'End Try


        '            With .Registro
        '                '.Fields("TipoABC").Value = mLetra 'ahora se encarga CalculaFactura
        '                '.Fields("PuntoVenta").Value = mvarPuntoVenta 'definir esto


        '                '.Fields("NumeroFactura").Value = mNumero

        '                .Fields("IdCliente").Value = IdClienteAFacturarle 'oCDP.Vendedor ' mIdCliente
        '                .Fields("FechaFactura").Value = Today ' mFecha
        '                .Fields("ConvenioMultilateral").Value = "NO"
        '                .Fields("CotizacionDolar").Value = Cotizacion(SC, Today, mIdMonedaPesos)  ' mCotizacionDolar 'Esta linea tira error "division por 0" si lo dejo en 0
        '                .Fields("RetencionIBrutos3").Value = 0
        '                .Fields("PorcentajeIBrutos3").Value = 0
        '                .Fields("PorcentajeIva1").Value = mTasa
        '                .Fields("PorcentajeIva2").Value = 0
        '                .Fields("IVANoDiscriminado").Value = 0



        '                'depende de la condicion de venta del cliente
        '                'hay una tablita de condiciones
        '                'se llama "Conciciones Compra"
        '                'que tiene la cantidad de dias CantidadDias
        '                Dim idcondicion As Integer = 4
        '                Try

        '                    Dim dtcondiciones As DataTable = EntidadManager.ExecDinamico(SC, "SELECT IdCondicionVenta FROM Clientes WHERE idCliente= " & IdClienteAFacturarle)

        '                    'había un idcondicion que no existia como id en la tabla (estaban usando la id=15) -claro, explotaba la linea de CantidadDias!

        '                    idcondicion = iisNull(dtcondiciones.Rows(0).Item("IdCondicionVenta"), 1)
        '                    .Fields("IdCondicionVenta").Value = idcondicion
        '                Catch ex As Exception
        '                    ErrHandler2.WriteError("Problema con la IdCondicionVenta?    " & IdClienteAFacturarle & " " & ex.ToString)
        '                    'Throw no rompas la facturacion
        '                End Try

        '                Dim dias As Integer = 0
        '                Try


        '                    dias = iisNull(EntidadManager.ExecDinamico(SC, "SELECT CantidadDias1 FROM  [Condiciones Compra]  WHERE idCondicionCompra=" & idcondicion).Rows(0).Item(0), 0)
        '                Catch ex As Exception
        '                    ErrHandler2.WriteError("Problema con  CantidadDias1?    " & idcondicion & " " & ex.ToString)
        '                    'Throw no rompas la facturacion
        '                End Try





        '                .Fields("FechaVencimiento").Value = DateAdd(DateInterval.Day, dias, Today) ' mFecha 



        '                .Fields("IdMoneda").Value = mIdMonedaPesos
        '                .Fields("CotizacionMoneda").Value = 1
        '                .Fields("CotizacionDolar").Value = Cotizacion(SC)
        '                .Fields("PorcentajeBonificacion").Value = 0
        '                '.Fields("OtrasPercepciones1").Value = 1 ' 0     'Esta linea tira error
        '                .Fields("OtrasPercepciones1Desc").Value = ""
        '                '.Fields("OtrasPercepciones2").Value = 1 ' 0    'Esta linea tira error
        '                .Fields("OtrasPercepciones2Desc").Value = ""


        '                '//////////////////////////////////////////////////////////////////////////
        '                '//////////////////////////////////////////////////////////////////////////
        '                '//////////////////////////////////////////////////////////////////////////
        '                'estaba hablando con claudio recien, Williams factura con un solo punto 
        '                'de venta (con un solo talonario), precisaríamos que todo se facture como talonario 1 y que el 
        '                'punto de venta de las CdP facturadas se refleje en el campo Centro de Costo de la 
        '                'factura (daríamos de alta los 4 centros de costo)
        '                Try
        '                    '                            Mariano(Scalella)
        '                    '                            las a y las b salen con el mismo talonario??
        '                    '                            Andrés(dice)
        '                    'no hacen facturas b
        '                    'si tienen que hacer las haran por pronto

        '                    .Fields("IdPuntoVenta").Value = IdPuntoVenta 'debiera ser 1...


        '                    '6:                          BUENOS(AIRES)
        '                    '7:                          COMERCIAL()
        '                    '8:                          SAN(LORENZO)
        '                    '9:                          ARROYO(SECO)
        '                    '10:                         BAHIA(BLANCA)


        '                    .Fields("IdObra").Value = IdObra

        '                Catch ex As Exception
        '                    ErrHandler2.WriteError("Problema al poner el punto de venta/centro de costo")
        '                End Try
        '                '//////////////////////////////////////////////////////////////////////////
        '                '//////////////////////////////////////////////////////////////////////////
        '                '//////////////////////////////////////////////////////////////////////////
        '                '//////////////////////////////////////////////////////////////////////////




        '                '.Fields("IdCorredorObservaciones").Value = IdCorredorObservaciones
        '                Dim idcliobs = TodasLasCartasTienenElMismoClienteObsConCircuitoEspecial(SC, oListaCDP)
        '                If idcliobs > 0 Then
        '                    .Fields("IdClienteObservaciones").Value = idcliobs
        '                    'tengo acceso a este campo con compronto?
        '                End If



        '                .Fields("NumeroCAI").Value = Val(mCAI)
        '                .Fields("FechaVencimientoCAI").Value = mFechaCAI



        '                .Fields("IdUsuarioIngreso").Value = usuario

        '                .Fields("FechaIngreso").Value = Today
        '                .Fields("IdCodigoIva").Value = mIdCodigoIva   'este no lo estas asignando (ahora)... Igual, la factura graba
        '                '.Fields("PercepcionIVA").Value = 1 ' 0   'Esta linea tira error
        '                .Fields("PorcentajePercepcionIVA").Value = 0



        '                'http://consultas.bdlconsultores.com.ar/AdminTest/template/desarrollo/Consulta.php?IdReclamo=29472&SinMenu=1
        '                'Al generar la factura, completar el campo IdTipoNegocioVentas completar de la siguiente manera:
        '                'Elevacion: 1                         'Entrega: 3                         'Buque: 9
        '                Dim tiponegocio As Integer = 3

        '                Try

        '                    If listEmbarques.Count > 0 Then
        '                        tiponegocio = 9 '                         'Elevacion: 1   'Entrega: 3  'Buque: 9
        '                    ElseIf oListaCDP(0).Exporta Then
        '                        tiponegocio = 1
        '                    Else
        '                        tiponegocio = 3
        '                    End If
        '                    .Fields("IdTipoNegocioVentas").Value = tiponegocio    'Elevacion: 1   'Entrega: 3  'Buque: 9
        '                Catch ex As Exception
        '                    ErrHandler2.WriteError("Falla la marca de IdTipoNegocioVentas. " + ex.ToString())
        '                End Try




        '            End With



        '            Debug.Print("        ComPronto paso 1 listo " & DateDiff(DateInterval.Second, tTemp, Now))
        '            tTemp = Now


        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////////////

        '            FormatearFacturaSegunSeSepareONoSeparador_Leyenda_Corredor_Separador(oListaCDP, oFac, IdClienteAFacturarle, SeSeparaPorCorredor, SC, txtCorredor, chkPagaCorredor)





        '            Debug.Print("        ComPronto paso 2 listo " & DateDiff(DateInterval.Second, tTemp, Now))
        '            tTemp = Now




        '            '//////////////////////////////////////
        '            '//////////////////////////////////////
        '            '//////////////////////////////////////
        '            '//////////////////////////////////////



        '            'Mostrar el período de facturación (Con la leyenda \\\" Período de Facturación: Fecha1raCdp - FechaUltimaCdp )
        '            Dim fecha = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
        '                        Select i.FechaDescarga Order By FechaDescarga


        '            'como poner lo de la leyenda de Syngenta?
        '            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13009
        '            oFac.Registro.Fields("Observaciones").Value += LeyendaSyngenta(oListaCDP, IdClienteAFacturarle, SC)


        '            If listEmbarques.Count > 0 Then
        '                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
        '                oFac.Registro.Fields("Observaciones").Value += vbCrLf & "Periodo " + CDate(listEmbarques(0).Item("FechaDescarga")).ToString("MMMM")
        '            Else
        '                oFac.Registro.Fields("Observaciones").Value += vbCrLf & "Periodo entre " + fecha(0) + " y " + fecha(fecha.Count - 1)
        '            End If




        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////

        '            'me guardo a quién se eligió facturar y cómo se agrupó

        '            Dim agrupIndex As Integer
        '            Select Case agruparArticulosPor
        '                Case "Destino"
        '                    agrupIndex = 1
        '                Case "Destino+Destinatario"
        '                    agrupIndex = 2
        '                Case "Destino+Titular"
        '                    agrupIndex = 3
        '                Case "Destino+RComercial/Interm+Destinat(CANJE)"
        '                    agrupIndex = 4
        '                Case Else
        '                    agrupIndex = 99
        '            End Select

        '            oFac.Registro.Fields("NumeroExpedienteCertificacionObra").Value = CInt(optFacturarA & "00" & agrupIndex)

        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            'agrupo las cdps que tengan el mismo articulo destino y cliente -no agrupes mas por titular, solo por destinatario
        '            'TODO: Facturación: tomar kg neto (sin mermas) y no el final
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////


        '            'ver esta funcion. dependiendo de q.count....
        '            ImputacionDevuelta = AgruparItemsDeLaFactura(oListaCDP, optFacturarA, agruparArticulosPor, SC, txtBuscar)

        '            'como hago para que el imputador revise esto?


        '            Dim renglons As Integer = 0
        '            For Each o In ImputacionDevuelta
        '                renglons += 1 'como es un Enumerable, tengo que iterar, no tengo un metodo Count()
        '            Next

        '            'el asunto es que si una se pasa, debería parar toda la facturacion, y no saltarse solo esa factura

        '            If renglons > MAXRENGLONES Then
        '                'ErrHandler2.WriteError("No definio en parametros la cuenta contable deudores varios")

        '                'si tiro una excepcion acá, la captura el try de esta funcion
        '                Dim s2 = "La factura para " & IdClienteAFacturarle.ToString() & " tiene " & renglons.ToString() & " renglones y el máximo es " & MAXRENGLONES.ToString()
        '                ErrHandler2.WriteError(s2)
        '                'Throw New Exception(s2)
        '                Return -12
        '            End If








        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            'creo los items
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////


        '            For Each o In ImputacionDevuelta

        '                With .DetFacturas.Item(-1)
        '                    With .Registro

        '                        .Fields("IdArticulo").Value = o.IdArticulo 'mIdArticuloParaImportacionFacturas
        '                        .Fields("Cantidad").Value = o.NetoFinal '/ 1000 '1


        '                        .Fields("PrecioUnitario").Value = o.total / o.NetoFinal 'o.Tarifa 'tarifa(IdClienteAFacturarle, o.IdArticulo)

        '                        If (.Fields("PrecioUnitario").Value = 0) Then Throw New Exception("El item de la factura tiene tarifa 0.    " & .Fields("IdArticulo").Value & " " & .Fields("Cantidad").Value)


        '                        .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value 'mTotal - mIVA


        '                        .Fields("Costo").Value = 0
        '                        .Fields("Bonificacion").Value = 0
        '                        .Fields("OrigenDescripcion").Value = 1





        '                        '//////////////////////////////////////////////////////////////////////////
        '                        '//////////////////////////////////////////////////////////////////////////
        '                        '//////////////////////////////////////////////////////////////////////////
        '                        '//////////////////////////////////////////////////////////////////////////
        '                        'Consulta 6206
        '                        'Cuando se factura a Titular, que quede: 
        '                        'Cereal(-Destinatario - destino)
        '                        'Y cuando se factura al corredor, que en la misma linea (renglon), salga impreso : 
        '                        'Cereal - Destinatario - Destino - Cliente.


        '                        'saco la procedencia, porque quieren agrupar solo por articulo, destino, vendedor
        '                        'Dim proc = EntidadManager.TablaSelect(sc, "Nombre", "Localidades", "IdLocalidad", o.Procedencia)

        '                        'Dim destino = EntidadManager.TablaSelect(sc, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", o.Destino)

        '                        '.Fields("Observaciones").Value = "   " & proc & "    " & destino '& " " & destinatario '& "   " & " CDP:" & o.NumeroCartaDePorte



        '                        .Fields("Observaciones").Value = o.ObservacionItem

        '                        'por qué no pongo el armado de Observaciones cuando genero por LINQ el "q"?
        '                        'If optFacturarA.SelectedValue = 3 Then
        '                        '    'si facturé al corredor de la cdp, que aparezca el nombre del titular
        '                        '    Dim titular = EntidadManager.NombreCliente(sc, o.Titular)
        '                        '    Dim destinatario = EntidadManager.NombreCliente(sc, o.Entregador)
        '                        '    .Fields("Observaciones").Value = "   " & destino & " " & titular & " " & destinatario & " "
        '                        'ElseIf optFacturarA.SelectedValue = 4 And cmbModo.Text = "Exporta" Then
        '                        '    .Fields("Observaciones").Value = "   " & destino
        '                        'ElseIf optFacturarA.SelectedValue = 4 Then
        '                        '    'a terceros
        '                        '    Dim titular = EntidadManager.NombreCliente(sc, o.Titular)
        '                        '    .Fields("Observaciones").Value = "   " & titular & " " & destino
        '                        'Else
        '                        '    'guarda, si es el caso 2 (destinatario) no va a venir el titular -por? Ademas, no tiene sentido agrupar por destinatario si se le factura al destinatario!!!
        '                        '    Dim destinatario = EntidadManager.NombreCliente(sc, o.Entregador)
        '                        '    .Fields("Observaciones").Value = "   " & destinatario & " " & destino '& " " & destinatario '& "   " & " CDP:" & o.NumeroCartaDePorte
        '                        'End If

        '                        '//////////////////////////////////////////////////////////////////////////
        '                        '//////////////////////////////////////////////////////////////////////////
        '                        '//////////////////////////////////////////////////////////////////////////
        '                        '//////////////////////////////////////////////////////////////////////////




        '                        'del calculo del total del item y de la factura, se encarga CalculaFacturaSimplificado
        '                        'mTotal += .Fields("Cantidad").Value * .Fields("PrecioUnitario").Value
        '                        'buscarel iva del articulo en su tabla
        '                        'mIVA+=

        '                    End With
        '                    .Modificado = True

        '                End With
        '            Next
        '            Debug.Print("        ComPronto paso 3 listo " & DateDiff(DateInterval.Second, tTemp, Now))
        '            tTemp = Now



        '            '//////////////////////////////////////////
        '            '//////////////////////////////////////////
        '            '//////////////////////////////////////////

        '            '//////////////////////////////////////////
        '            '/////////////////////////////////////
        '            '//////////////////////////////////////////





        '            For Each dr In listEmbarques


        '                With .DetFacturas.Item(-1)
        '                    With .Registro
        '                        'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
        '                        'Debug.Print(dr.item("IdArticulo"))


        '                        .Fields("IdArticulo").Value = BuscaIdArticuloPreciso(dr.Item("Producto"), SC) 'mIdArticuloParaImportacionFacturas
        '                        .Fields("Cantidad").Value = dr.Item("KgNetos") / 1000 'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales

        '                        If (dr.Item("TarifaFacturada") = 0) Then Throw New Exception("El item de la factura tiene tarifa 0.    " & .Fields("IdArticulo").Value & " " & .Fields("Cantidad").Value)

        '                        .Fields("PrecioUnitario").Value = dr.Item("TarifaFacturada")
        '                        .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value
        '                        .Fields("Costo").Value = 0
        '                        .Fields("Bonificacion").Value = 0
        '                        .Fields("OrigenDescripcion").Value = 1


        '                        '////////////////////////////////////////////////////////////////
        '                        '////////////////////////////////////////////////////////////////
        '                        '////////////////////////////////////////////////////////////////
        '                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
        '                        'En el primero imprimir la leyenda \"ATENCION BUQUE\"
        '                        'En el segundo: Nombre del Buque - Cereal - Puerto

        '                        Dim obsEmbarque As String = "BUQUE " & dr.Item("Corredor") & SEPAR & "  " & dr.Item("DestinoDesc")


        '                        .Fields("Observaciones").Value = obsEmbarque
        '                        '////////////////////////////////////////////////////////////////
        '                        '////////////////////////////////////////////////////////////////
        '                        '////////////////////////////////////////////////////////////////
        '                        '////////////////////////////////////////////////////////////////


        '                    End With
        '                    .Modificado = True

        '                End With
        '            Next




        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////




        '            If Not dtRenglonesManuales Is Nothing Then

        '                Dim K_idartcambio As Integer = GetIdArticuloParaCambioDeCartaPorte(SC)

        '                For Each dr As DataRow In dtRenglonesManuales.Rows

        '                    With .DetFacturas.Item(-1)
        '                        With .Registro
        '                            'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
        '                            'Debug.Print(dr.item("IdArticulo"))
        '                            .Fields("IdArticulo").Value = BuscaIdArticuloPreciso(dr.Item("Producto"), SC) 'mIdArticuloParaImportacionFacturas

        '                            'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales


        '                            Dim tarif As Double
        '                            If .Fields("IdArticulo").Value = K_idartcambio Or InStr(dr.Item("Producto"), "ANALISIS") > 0 Or
        '                             InStr(dr.Item("Producto"), "RETIRO DE DOCUMENTACION") > 0 Or
        '                            InStr(dr.Item("Producto"), "FLETE") > 0 Then


        '                                'si es un "cambio de carta porte", no dividir por mil. 
        '                                'Es decir, la "Tarifa" en los renglones normales es por "Tonelada", y en estos es por "Unidad".
        '                                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11379
        '                                'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11577

        '                                .Fields("Cantidad").Value = dr.Item("KgNetos")
        '                                tarif = dr.Item("TarifaFacturada")

        '                            Else

        '                                'si es un articulo común (un grano) hay que divdir la cantidad


        '                                .Fields("Cantidad").Value = dr.Item("KgNetos") / 1000
        '                                tarif = dr.Item("TarifaFacturada") '/ 1000
        '                            End If


        '                            If (tarif = 0) Then Throw New Exception("El item de la factura tiene tarifa 0.    " & .Fields("IdArticulo").Value & " " & .Fields("Cantidad").Value)


        '                            .Fields("PrecioUnitario").Value = tarif
        '                            .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value





        '                            .Fields("Costo").Value = 0
        '                            .Fields("Bonificacion").Value = 0
        '                            .Fields("OrigenDescripcion").Value = 1
        '                            .Fields("Observaciones").Value = ""
        '                        End With
        '                        .Modificado = True

        '                    End With
        '                Next
        '            End If



        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            'agregar renglon de "Gastos administrativos"
        '            '////////////////////////////////////////////////////////////////////////////
        '            '////////////////////////////////////////////////////////////////////////////
        '            Dim IdArticuloGastoAdministrativo = BuscaIdArticuloPreciso("CAMBIO DE CARTA DE PORTE", SC)

        '            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526

        '            If IdArticuloGastoAdministrativo > 0 Then

        '                Dim cantidadGastosAdministrativos = 0

        '                If Not EsClienteExcluidoDeGastosAdmin(SC, IdClienteAFacturarle) Then

        '                    For Each cdp In oListaCDP
        '                        If cdp.AgregaItemDeGastosAdministrativos Then cantidadGastosAdministrativos += 1
        '                    Next
        '                End If


        '                If cantidadGastosAdministrativos > 0 Then


        '                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526
        '                    Dim PrecioArticuloGastoAdministrativo As Double = ListaPreciosManager.Tarifa(SC, IdClienteAFacturarle, IdArticuloGastoAdministrativo)
        '                    If PrecioArticuloGastoAdministrativo = 0 Then
        '                        PrecioArticuloGastoAdministrativo = StringToDecimal(txtTarifaGastoAdministrativo)
        '                        'PrecioArticuloGastoAdministrativo = ListaPreciosManager.Tarifa(sc, IdClienteAFacturarle, IdArticuloGastoAdministrativo)
        '                    End If
        '                    If PrecioArticuloGastoAdministrativo = 0 Then
        '                        'tanto la lista de precios como el default estan en 0
        '                        EntidadManager.ErrHandler2WriteErrorLogPronto("No se pudo asignar la tarifa de gasto administrativo para " & IdClienteAFacturarle, SC, "")
        '                    End If


        '                    'Solicitan que la tarifa del artículo Cambio de Carta de Porte la tome siempre de la Lista de Precios de 
        '                    'cada cliente y que la pida en los casos en que la Carta de Porte tiene el tilde y el 
        '                    'cliente al que se le facturará no tiene elegida una tarifa.
        '                    '-ah, o sea que no habrá mas default, no?


        '                    With .DetFacturas.Item(-1)
        '                        With .Registro
        '                            'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
        '                            'Debug.Print(dr.item("IdArticulo"))
        '                            .Fields("IdArticulo").Value = IdArticuloGastoAdministrativo
        '                            .Fields("Cantidad").Value = cantidadGastosAdministrativos 'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales
        '                            .Fields("PrecioUnitario").Value = PrecioArticuloGastoAdministrativo
        '                            .Fields("PrecioUnitarioTotal").Value = PrecioArticuloGastoAdministrativo


        '                            .Fields("Costo").Value = 0
        '                            .Fields("Bonificacion").Value = 0
        '                            .Fields("OrigenDescripcion").Value = 1
        '                            .Fields("Observaciones").Value = "GASTOS ADMINISTRATIVOS" '"POR GASTOS ADMINISTRATIVOS"
        '                        End With
        '                        .Modificado = True

        '                    End With
        '                End If

        '            End If



        '            '//////////////////////////////////////////
        '            '//////////////////////////////////////////
        '            '//////////////////////////////////////////



        '            'CalculaFactura(oFac)
        '            Try
        '                CalculaFacturaSimplificado(oFac, SC, Session, numeropuntoVenta, IdPuntoVenta) 'recien ahi se asigna la letra de la factura...
        '            Catch ex As Exception
        '                ErrHandler2.WriteError("Error en CalculaFacturaSimplificado. " & ex.ToString)
        '                MandarMailDeError(ex)
        '                Return -1
        '            End Try




        '            With .Registro

        '                .Fields("ImporteIva2").Value = 0
        '                .Fields("ImporteBonificacion").Value = 0

        '                If False Then
        '                    .Fields("RetencionIBrutos1").Value = 0
        '                    .Fields("PorcentajeIBrutos1").Value = 0
        '                    .Fields("RetencionIBrutos2").Value = 0
        '                    .Fields("PorcentajeIBrutos2").Value = 0
        '                End If

        '            End With





        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            ' Defino el punto de venta
        '            ' Talonario=Punto de venta + Letra + Tipo de Comprobante (factura, NC, ND)


        '            'Traigo el IdPuntoVenta
        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            '///////////////////////////////////////////////////////////////////////////////////////

        '            'de qué obra es el usuario?

        '            Dim mvarNumeracionUnica = False
        '            'If parametros.Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True 

        '            'If mvarNumeracionUnica And oFac.Registro.Fields("TipoABC").Value <> "E" Then
        '            '    oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(sc, "PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra", ArrayVB6(puntoVenta, oFac.Registro.Fields("TipoABC").Value)))

        '            'Else
        '            '    'oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(sc, "PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra", ArrayVB6(puntoVenta, oFac.Registro.Fields("TipoABC").Value)))
        '            'End If


        '            ''If oRs.RecordCount = 1 Then 
        '            ''verificar que es de tipocomprobante=Factura
        '            'oRs.MoveFirst()

        '            'mvarPuntoVenta = oRs.Fields(0).Value


        '            IdPuntoVenta = EntidadManager.TablaSelectId(SC, "PuntosVenta", "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & oFac.Registro.Fields("TipoABC").Value & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)

        '            oFac.Registro.Fields("IdPuntoVenta").Value = IdPuntoVenta


        '            If IdPuntoVenta = 0 Then
        '                ErrHandler2.WriteError("No hay talonario de facturas para el punto de venta " & numeropuntoVenta & " Letra " & oFac.Registro.Fields("TipoABC").Value)
        '                Return -1
        '            End If

        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            'Aplico el IdPuntoVenta



        '            Dim oPto 'As ComPronto.PuntoVenta 
        '            oPto = oAp.PuntosVenta.Item(IdPuntoVenta)
        '            With oPto.Registro
        '                Dim n = .Fields("ProximoNumero").Value
        '                oFac.Registro.Fields("NumeroFactura").Value = n
        '                oFac.Registro.Fields("PuntoVenta").Value = numeropuntoVenta

        '                .Fields("ProximoNumero").Value = n + 1
        '            End With
        '            oPto.Guardar()
        '            oPto = Nothing

        '            For i = -100 To (-100 - (oFac.DetFacturas.Count - 1)) Step -1
        '                With oFac.DetFacturas.Item(i).Registro
        '                    'estos datos recien los tengo cuando termina
        '                    .Fields("NumeroFactura").Value = mNumero
        '                    .Fields("TipoABC").Value = mLetra
        '                    .Fields("PuntoVenta").Value = IdPuntoVenta
        '                End With
        '            Next

        '            'End If
        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            '///////////////////////////////////////////////////////////////////////////////////////
        '            '///////////////////////////////////////////////////////////////////////////////////////

        '            Debug.Print("        ComPronto paso 4 listo " & DateDiff(DateInterval.Second, tTemp, Now))
        '            tTemp = Now


        '            Dim idfac = TraerUltimaIdFacturaCreada(SC)


        '            Try

        '                Select Case .Guardar()
        '                    Case ICompMTSManager.MisEstados.Correcto
        '                    Case ICompMTSManager.MisEstados.ModificadoPorOtro
        '                        'MsgBox("El Regsitro ha sido modificado")
        '                        ErrHandler2.WriteError("El Regsitro ha sido modificado")
        '                        Return -1
        '                    Case ICompMTSManager.MisEstados.NoExiste
        '                        'MsgBox("El registro ha sido eliminado")
        '                        ErrHandler2.WriteError("El registro ha sido eliminado")
        '                        Return -1
        '                    Case ICompMTSManager.MisEstados.ErrorDeDatos
        '                        'MsgBox("Error de ingreso de datos")
        '                        ErrHandler2.WriteError("Error de ingreso de datos")
        '                        Return -1
        '                End Select

        '            Catch ex As Exception
        '                'ver si aumento el idfactura
        '                Dim idfac2 = TraerUltimaIdFacturaCreada(SC)


        '                Dim s As String = idfac.ToString & " " & idfac2.ToString & "Explosión al llamar a Compronto.Factura.Guardar(). Ojo porque si se generó pero no se manda a imprimir les rompe la numeración!!! " &
        '                    " La factura quizas queda por la mitad y no genera el subdiario (eso es un problema del ComPronto).  Si es Type Mismatch se puede dar tanto " &
        '                    " cuando se rompe la compatibilidad del COM, como cuando se rompe la compatibilidad del " &
        '                    " recordset/storeproc/tabla (y esto es lo mas probable, ya que está pasando en el guardar() )" &
        '                    " [verificar que desde Pronto se puede dar de alta esta misma factura con el " &
        '                    " mismo cliente. Si sigue el error, verificar que están corridos los storeprocs de " &
        '                    " Pronto actualizados]     Si es 'Application uses a value of the wrong type' puede ser el tipo o " &
        '                    " un overflow del tipo, una cadena muy larga. Queda algún tipo de rastro en el log sql de Pronto? -no vas a" &
        '                    " encontrar mucha informacion ahí. Hay que correr el Profiler mientras facturás y ver cual es la ultima llamada antes de Log_InsertarRegistro. " &
        '                    " Puede ser la actualizacion de la entidad Cliente, " &
        '                    " así que por Pronto hay que intentar facturarle al mismo cliente Y TAMBIEN ver si se puede editar y grabar el formulario de cliente. " &
        '                    "-Por qué fue que tuvimos un problema así en Capen? Qué era lo que tenía el Clientes_M, mal el largo de un campo? " &
        '                                    ex.ToString
        '                ErrHandler2.WriteError(s)
        '                MandarMailDeError(s)

        '                Return -1  'si la factura se creó, no puedo devolver lo mismo que en los otros casos

        '            End Try

        '        End With
        '        idFacturaCreada = oFac.Registro.Fields(0).Value


        '        '///////////////////////////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////////////////////////
        '        'esto es codigo que se ejecuta en el boton aceptar (cmd_Click index 0) del frmFacturas 
        '        '///////////////////////////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////////////////////////

        '        'aumentar numerador IIBB 

        '        Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


        '        If oFac.Registro.Fields("RetencionIBrutos1").Value > 0 Then

        '            Dim cli = db.Clientes.Find(IdClienteAFacturarle)
        '            Dim ibcond = db.IBCondiciones.Find(cli.IdIBCondicionPorDefecto)
        '            Dim mIdProvinciaIIBB = ibcond.IdProvincia
        '            Dim oPrv As Models.Provincia = db.Provincias.Find(mIdProvinciaIIBB)

        '            Dim mNum = oPrv.ProximoNumeroCertificadoPercepcionIIBB
        '            oPrv.ProximoNumeroCertificadoPercepcionIIBB = mNum + 1

        '            db.SaveChanges()
        '        End If


        '        'If dcfields(4).Enabled And Check1(0).Value = 1 Then
        '        '    Dim oPrv As ComPronto.Provincia
        '        '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", origen.Registro.Fields("IdIBCondicion").Value)
        '        '    If oRs.RecordCount > 0 Then
        '        '        If Not IsNull(oRs.Fields("IdProvincia").Value) Then
        '        '            oPrv = db.Provincias.Find(  oRs.Fields("IdProvincia").Value))
        '        '            With oPrv.Registro
        '        '                mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
        '        '                origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = mNum
        '        '                .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value = mNum + 1
        '        '            End With

        '        '            db.SaveChanges()
        '        '        End If
        '        '    End If
        '        'End If


        '        '///////////////////////////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////////////////////////
        '        '///////////////////////////////////////////////////////////////////////

        '        oFac = Nothing






        '        Try
        '            EntidadManager.LogPronto(SC, idFacturaCreada, "Factura por ProntoWeb", usuario)
        '        Catch ex As Exception
        '            ErrHandler2.WriteError(ex)
        '        End Try


        '    Else
        '        'este comentario lo puse ya en un if anterior
        '        'AgregarMensajeProcesoPresto(oRsErrores, "La factura " & mComprobante & " ya existe, no se generará")
        '    End If

        'Catch ex As Exception

        '    ErrHandler2.WriteError("Error en la llamada a CreaFacturaCOMpronto. " & ex.ToString)
        '    MandarMailDeError(ex)
        'End Try

        'Debug.Print("        ComPronto paso 5 listo " & DateDiff(DateInterval.Second, tTemp, Now))
        'tTemp = Now


        Return idFacturaCreada

    End Function










    Shared Function CreaFacturaCOMpronto(ByVal oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte),
                                     ByVal IdClienteAFacturarle As Long, ByVal sucursalWilliams As Long,
                                     ByVal dtRenglonesManuales As DataTable, ByVal SC As String,
                                     ByVal Session As System.Web.SessionState.HttpSessionState, ByVal optFacturarA As Integer,
                                     ByVal agruparArticulosPor As String, ByVal txtBuscar As String,
                                     ByVal txtTarifaGastoAdministrativo As String,
                                     ByVal SeSeparaPorCorredor As Boolean, ByVal txtCorredor As String,
                                     ByVal chkPagaCorredor As Boolean,
                                     ByVal listEmbarques As System.Collections.Generic.List(Of DataRow),
                                    ByRef ImputacionDevuelta As IEnumerable(Of grup),
                                    IdClienteObservaciones As Integer
) As Integer
        'Revisar tambien en
        ' Pronto el Utilidades->"Generacion de Facturas a partir de Ordenes de Compra automaticas",
        ' (se llama con frmConsulta2 Id = 74) -Eso es un informe!! No genera nada
        'y cómo hace para imprimirlas. Tambien Utilidades->"Prefacturacion"
        ' se llama con GeneracionDeFacturasDesdeOrdenesCompraAutomaticas() -Ese llama a frmExcel1.GenerarFacturasAutomaticas

        'EDU!!!! 
        'si te paras en el principal (visualizando facturas), marcas las facturas que quieras, 
        'boton derecho imprimir (o mandar a pantalla), emite masivamente las facturas.
        'en el frmprincipal esta la funcion EmitirFacturas


        Dim oAp
        Dim oFac 'As ComPronto.Factura 
        Dim oDeb 'As ComPronto.NotaDebito 
        Dim oCre 'As ComPronto.NotaCredito 
        Dim oCli 'As ComPronto.Cliente 
        Dim oVen 'As ComPronto.Vendedor 
        Dim oRs As ADODB.Recordset
        Dim oRsAux As ADODB.Recordset
        Dim oRsErrores As ADODB.Recordset
        Dim mArchivo As String, mTipo As String, mLetra As String, mCliente As String, mCorredor As String, mCuit As String
        Dim mCuitCorredor As String, mCAI As String, mComprobante As String
        Dim fl As Integer, mContador As Integer, mIdMonedaPesos As Integer ', mvarPuntoVenta As Integer
        Dim mIdTipoComprobante As Integer, mIdCodigoIva As Integer
        Dim mIdArticuloParaImportacionFacturas As Long, mNumero As Long, mIdCliente As Long
        Dim mIdConceptoParaImportacionNDNC As Long, mNumeroCliente As Long, mIdCuenta As Long
        Dim mSubtotal As Double, mIVA As Double, mTotal As Double
        Dim mTasa As Single, mCotizacionDolar As Single
        Dim mFecha As Date, mFechaCAI As Date
        Dim mOk As Boolean, mConProblemas As Boolean
        Dim mAux1
        Dim idFacturaCreada As Integer



        'estaba hablando con claudio recien, Williams factura con un solo punto 
        'de venta (con un solo talonario), precisaríamos que todo se facture como talonario 1 y que el 
        'punto de venta de las CdP facturadas se refleje en el campo Centro de Costo de la 
        'factura (daríamos de alta los 4 centros de costo)


        Dim usuario As Integer = 1
        If Session IsNot Nothing Then usuario = Session(SESSIONPRONTO_glbIdUsuario)


        Dim tTemp As Date = Now

        Try

            If (oListaCDP Is Nothing Or oListaCDP.Count < 1) And
                (dtRenglonesManuales Is Nothing Or dtRenglonesManuales.Rows.Count < 1) And
                (listEmbarques Is Nothing Or listEmbarques.Count < 1) Then
                ErrHandler2.WriteError("oListaCDP vacía")
                Return -1
            End If


            mLetra = LetraSegunTipoIVA(ClienteManager.GetItem(SC, IdClienteAFacturarle).IdCodigoIva)



            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////LIOS CON LOS PUNTOS DE VENTA    /////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
            Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC,
                                        "PuntosVenta",
                                        "PuntoVenta=" & numeropuntoVenta & " AND Letra='" &
                                        mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
            Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////



            oAp = ClaseMigrar.CrearAppCompronto(SC)



            If IdClienteAFacturarle <= 0 Then Return -1







            oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
            mIdMonedaPesos = IIf(IsNull(oRs.Fields("IdMoneda").Value), 1, oRs.Fields("IdMoneda").Value)
            mIdCuenta = IIf(IsNull(oRs.Fields("IdCuentaDeudoresVarios").Value), 0, oRs.Fields("IdCuentaDeudoresVarios").Value)
            oRs.Close()

            If mIdCuenta = 0 Then
                ErrHandler2.WriteError("No definio en parametros la cuenta contable deudores varios")
                Return -1
            End If




            mAux1 = ParametroManager.TraerValorParametro2(SC, "IdArticuloParaImportacionFacturas")
            mIdArticuloParaImportacionFacturas = IIf(IsNull(mAux1), 0, mAux1)
            mAux1 = ParametroManager.TraerValorParametro2(SC, "IdConceptoParaImportacionNDNC")
            mIdConceptoParaImportacionNDNC = IIf(IsNull(mAux1), 0, mAux1)

            If mIdArticuloParaImportacionFacturas = 0 Then
                ErrHandler2.WriteError("No definio en parametros el articulo generico para importar las facturas")
                Return -1
            End If



            oRsAux = oAp.Facturas.TraerFiltrado("_PorNumeroComprobante", ArrayVB6(mLetra, IdPuntoVenta, mNumero.ToString))
            If oRsAux.RecordCount > 0 Then
                AgregarMensajeProcesoPresto(oRsErrores, "La factura " & mComprobante & " ya existe, no se generará")
                mConProblemas = True
            End If
            oRsAux.Close()


            mTasa = iisNull(ParametroManager.ParametroOriginal(SC, "Iva1"), 0)
            mCAI = CAIsegunPuntoVenta(mLetra, numeropuntoVenta, SC)




            If Not mConProblemas Then
                oFac = oAp.Facturas.Item(-1)
                With oFac

                    'Try
                    '    .Guardar() 'para ver si genera un type mismatch
                    'Catch ex As Exception
                    '    ErrHandler2.WriteError("Primer Guardar trucho. " & ex.ToString)
                    'End Try


                    With .Registro
                        '.Fields("TipoABC").Value = mLetra 'ahora se encarga CalculaFactura
                        '.Fields("PuntoVenta").Value = mvarPuntoVenta 'definir esto


                        '.Fields("NumeroFactura").Value = mNumero

                        .Fields("IdCliente").Value = IdClienteAFacturarle 'oCDP.Vendedor ' mIdCliente
                        .Fields("FechaFactura").Value = Today ' mFecha
                        .Fields("ConvenioMultilateral").Value = "NO"
                        .Fields("CotizacionDolar").Value = Cotizacion(SC, Today, mIdMonedaPesos)  ' mCotizacionDolar 'Esta linea tira error "division por 0" si lo dejo en 0
                        .Fields("RetencionIBrutos3").Value = 0
                        .Fields("PorcentajeIBrutos3").Value = 0
                        .Fields("PorcentajeIva1").Value = mTasa
                        .Fields("PorcentajeIva2").Value = 0
                        .Fields("IVANoDiscriminado").Value = 0



                        'depende de la condicion de venta del cliente
                        'hay una tablita de condiciones
                        'se llama "Conciciones Compra"
                        'que tiene la cantidad de dias CantidadDias
                        Dim idcondicion As Integer = 4
                        Try

                            Dim dtcondiciones As DataTable = EntidadManager.ExecDinamico(SC, "SELECT IdCondicionVenta FROM Clientes WHERE idCliente= " & IdClienteAFacturarle)

                            'había un idcondicion que no existia como id en la tabla (estaban usando la id=15) -claro, explotaba la linea de CantidadDias!

                            idcondicion = iisNull(dtcondiciones.Rows(0).Item("IdCondicionVenta"), 1)
                            .Fields("IdCondicionVenta").Value = idcondicion
                        Catch ex As Exception
                            ErrHandler2.WriteError("Problema con la IdCondicionVenta?    " & IdClienteAFacturarle & " " & ex.ToString)
                            'Throw no rompas la facturacion
                        End Try

                        Dim dias As Integer = 0
                        Try


                            dias = iisNull(EntidadManager.ExecDinamico(SC, "SELECT CantidadDias1 FROM  [Condiciones Compra]  WHERE idCondicionCompra=" & idcondicion).Rows(0).Item(0), 0)
                        Catch ex As Exception
                            ErrHandler2.WriteError("Problema con  CantidadDias1?    " & idcondicion & " " & ex.ToString)
                            'Throw no rompas la facturacion
                        End Try





                        .Fields("FechaVencimiento").Value = DateAdd(DateInterval.Day, dias, Today) ' mFecha 



                        .Fields("IdMoneda").Value = mIdMonedaPesos
                        .Fields("CotizacionMoneda").Value = 1
                        .Fields("CotizacionDolar").Value = Cotizacion(SC)
                        .Fields("PorcentajeBonificacion").Value = 0
                        '.Fields("OtrasPercepciones1").Value = 1 ' 0     'Esta linea tira error
                        .Fields("OtrasPercepciones1Desc").Value = ""
                        '.Fields("OtrasPercepciones2").Value = 1 ' 0    'Esta linea tira error
                        .Fields("OtrasPercepciones2Desc").Value = ""


                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////
                        'estaba hablando con claudio recien, Williams factura con un solo punto 
                        'de venta (con un solo talonario), precisaríamos que todo se facture como talonario 1 y que el 
                        'punto de venta de las CdP facturadas se refleje en el campo Centro de Costo de la 
                        'factura (daríamos de alta los 4 centros de costo)
                        Try
                            '                            Mariano(Scalella)
                            '                            las a y las b salen con el mismo talonario??
                            '                            Andrés(dice)
                            'no hacen facturas b
                            'si tienen que hacer las haran por pronto

                            .Fields("IdPuntoVenta").Value = IdPuntoVenta 'debiera ser 1...


                            '6:                          BUENOS(AIRES)
                            '7:                          COMERCIAL()
                            '8:                          SAN(LORENZO)
                            '9:                          ARROYO(SECO)
                            '10:                         BAHIA(BLANCA)


                            .Fields("IdObra").Value = IdObra

                        Catch ex As Exception
                            ErrHandler2.WriteError("Problema al poner el punto de venta/centro de costo")
                        End Try
                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////
                        '//////////////////////////////////////////////////////////////////////////




                        '.Fields("IdCorredorObservaciones").Value = IdCorredorObservaciones
                        Dim idcliobs = TodasLasCartasTienenElMismoClienteObsConCircuitoEspecial(SC, oListaCDP)
                        If idcliobs > 0 Then
                            .Fields("IdClienteObservaciones").Value = idcliobs
                            'tengo acceso a este campo con compronto?
                        End If



                        .Fields("NumeroCAI").Value = Val(mCAI)
                        .Fields("FechaVencimientoCAI").Value = mFechaCAI



                        .Fields("IdUsuarioIngreso").Value = usuario

                        .Fields("FechaIngreso").Value = Today
                        .Fields("IdCodigoIva").Value = mIdCodigoIva   'este no lo estas asignando (ahora)... Igual, la factura graba
                        '.Fields("PercepcionIVA").Value = 1 ' 0   'Esta linea tira error
                        .Fields("PorcentajePercepcionIVA").Value = 0



                        'http://consultas.bdlconsultores.com.ar/AdminTest/template/desarrollo/Consulta.php?IdReclamo=29472&SinMenu=1
                        'Al generar la factura, completar el campo IdTipoNegocioVentas completar de la siguiente manera:
                        'Elevacion: 1                         'Entrega: 3                         'Buque: 9
                        Dim tiponegocio As Integer = 3

                        Try

                            If listEmbarques.Count > 0 Then
                                tiponegocio = 9 '                         'Elevacion: 1   'Entrega: 3  'Buque: 9
                            ElseIf oListaCDP(0).Exporta Then
                                tiponegocio = 1
                            Else
                                tiponegocio = 3
                            End If
                            .Fields("IdTipoNegocioVentas").Value = tiponegocio    'Elevacion: 1   'Entrega: 3  'Buque: 9
                        Catch ex As Exception
                            ErrHandler2.WriteError("Falla la marca de IdTipoNegocioVentas. " + ex.ToString())
                        End Try




                    End With



                    Debug.Print("        ComPronto paso 1 listo " & DateDiff(DateInterval.Second, tTemp, Now))
                    tTemp = Now


                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////

                    FormatearFacturaSegunSeSepareONoSeparador_Leyenda_Corredor_Separador(oListaCDP, oFac, IdClienteAFacturarle, SeSeparaPorCorredor, SC, txtCorredor, chkPagaCorredor)





                    Debug.Print("        ComPronto paso 2 listo " & DateDiff(DateInterval.Second, tTemp, Now))
                    tTemp = Now




                    '//////////////////////////////////////
                    '//////////////////////////////////////
                    '//////////////////////////////////////
                    '//////////////////////////////////////



                    'Mostrar el período de facturación (Con la leyenda \\\" Período de Facturación: Fecha1raCdp - FechaUltimaCdp )
                    Dim fecha = From i As Pronto.ERP.BO.CartaDePorte In oListaCDP
                                Select i.FechaDescarga Order By FechaDescarga


                    'como poner lo de la leyenda de Syngenta?
                    'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13009
                    oFac.Registro.Fields("Observaciones").Value += LeyendaSyngenta(oListaCDP, IdClienteAFacturarle, SC)


                    If listEmbarques.Count > 0 Then
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
                        oFac.Registro.Fields("Observaciones").Value += vbCrLf & "Periodo " + CDate(listEmbarques(0).Item("FechaDescarga")).ToString("MMMM")
                    Else
                        oFac.Registro.Fields("Observaciones").Value += vbCrLf & "Periodo entre " + fecha(0) + " y " + fecha(fecha.Count - 1)
                    End If




                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////

                    'me guardo a quién se eligió facturar y cómo se agrupó

                    Dim agrupIndex As Integer
                    Select Case agruparArticulosPor
                        Case "Destino"
                            agrupIndex = 1
                        Case "Destino+Destinatario"
                            agrupIndex = 2
                        Case "Destino+Titular"
                            agrupIndex = 3
                        Case "Destino+RComercial/Interm+Destinat(CANJE)"
                            agrupIndex = 4
                        Case Else
                            agrupIndex = 99
                    End Select

                    oFac.Registro.Fields("NumeroExpedienteCertificacionObra").Value = CInt(optFacturarA & "00" & agrupIndex)

                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'agrupo las cdps que tengan el mismo articulo destino y cliente -no agrupes mas por titular, solo por destinatario
                    'TODO: Facturación: tomar kg neto (sin mermas) y no el final
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////


                    'ver esta funcion. dependiendo de q.count....
                    ImputacionDevuelta = AgruparItemsDeLaFactura(oListaCDP, optFacturarA, agruparArticulosPor, SC, txtBuscar)

                    'como hago para que el imputador revise esto?


                    Dim renglons As Integer = 0
                    For Each o In ImputacionDevuelta
                        renglons += 1 'como es un Enumerable, tengo que iterar, no tengo un metodo Count()
                    Next



                    Dim cantidadGastosAdministrativos = 0

                    If Not EsClienteExcluidoDeGastosAdmin(SC, IdClienteAFacturarle) Then

                        For Each cdp In oListaCDP
                            If cdp.AgregaItemDeGastosAdministrativos Then cantidadGastosAdministrativos += 1
                        Next
                    End If



                    'el asunto es que si una se pasa, debería parar toda la facturacion, y no saltarse solo esa factura

                    If (renglons + IIf(cantidadGastosAdministrativos > 0, 1, 0) + dtRenglonesManuales.Rows.Count + listEmbarques.Count) > MAXRENGLONES Then
                        'tomar en cuenta embarques y manuales

                        'si tiro una excepcion acá, la captura el try de esta funcion
                        Dim s2 = "La factura para " & IdClienteAFacturarle.ToString() & " tiene " & renglons.ToString() & " renglones y el máximo es " & MAXRENGLONES.ToString()
                        ErrHandler2.WriteError(s2)
                        'Throw New Exception(s2)
                        Return -12
                    End If








                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'creo los items
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////


                    For Each o In ImputacionDevuelta

                        With .DetFacturas.Item(-1)
                            With .Registro

                                .Fields("IdArticulo").Value = o.IdArticulo 'mIdArticuloParaImportacionFacturas
                                .Fields("Cantidad").Value = o.NetoFinal '/ 1000 '1


                                .Fields("PrecioUnitario").Value = o.total / o.NetoFinal 'o.Tarifa 'tarifa(IdClienteAFacturarle, o.IdArticulo)

                                If (.Fields("PrecioUnitario").Value = 0) Then
                                    If Not Debugger.IsAttached Then Throw New Exception("El item de la factura tiene tarifa 0.    " & .Fields("IdArticulo").Value & " " & .Fields("Cantidad").Value)
                                End If


                                .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value 'mTotal - mIVA


                                .Fields("Costo").Value = 0
                                .Fields("Bonificacion").Value = 0
                                .Fields("OrigenDescripcion").Value = 1


                                .Fields("PorcentajeIva").Value = mTasa  'deberia estar usando el de cada articulo, por ahora uso el iva general  http://consultas.bdlconsultores.com.ar/Admin/VerConsultas1.php?recordid=46968
                                .Fields("ImporteIva").Value = o.total * mTasa / 100



                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                'Consulta 6206
                                'Cuando se factura a Titular, que quede: 
                                'Cereal(-Destinatario - destino)
                                'Y cuando se factura al corredor, que en la misma linea (renglon), salga impreso : 
                                'Cereal - Destinatario - Destino - Cliente.


                                'saco la procedencia, porque quieren agrupar solo por articulo, destino, vendedor
                                'Dim proc = EntidadManager.TablaSelect(sc, "Nombre", "Localidades", "IdLocalidad", o.Procedencia)

                                'Dim destino = EntidadManager.TablaSelect(sc, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", o.Destino)

                                '.Fields("Observaciones").Value = "   " & proc & "    " & destino '& " " & destinatario '& "   " & " CDP:" & o.NumeroCartaDePorte



                                .Fields("Observaciones").Value = o.ObservacionItem

                                'por qué no pongo el armado de Observaciones cuando genero por LINQ el "q"?
                                'If optFacturarA.SelectedValue = 3 Then
                                '    'si facturé al corredor de la cdp, que aparezca el nombre del titular
                                '    Dim titular = EntidadManager.NombreCliente(sc, o.Titular)
                                '    Dim destinatario = EntidadManager.NombreCliente(sc, o.Entregador)
                                '    .Fields("Observaciones").Value = "   " & destino & " " & titular & " " & destinatario & " "
                                'ElseIf optFacturarA.SelectedValue = 4 And cmbModo.Text = "Exporta" Then
                                '    .Fields("Observaciones").Value = "   " & destino
                                'ElseIf optFacturarA.SelectedValue = 4 Then
                                '    'a terceros
                                '    Dim titular = EntidadManager.NombreCliente(sc, o.Titular)
                                '    .Fields("Observaciones").Value = "   " & titular & " " & destino
                                'Else
                                '    'guarda, si es el caso 2 (destinatario) no va a venir el titular -por? Ademas, no tiene sentido agrupar por destinatario si se le factura al destinatario!!!
                                '    Dim destinatario = EntidadManager.NombreCliente(sc, o.Entregador)
                                '    .Fields("Observaciones").Value = "   " & destinatario & " " & destino '& " " & destinatario '& "   " & " CDP:" & o.NumeroCartaDePorte
                                'End If

                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////




                                'del calculo del total del item y de la factura, se encarga CalculaFacturaSimplificado
                                'mTotal += .Fields("Cantidad").Value * .Fields("PrecioUnitario").Value
                                'buscarel iva del articulo en su tabla
                                'mIVA+=

                            End With
                            .Modificado = True

                        End With
                    Next
                    Debug.Print("        ComPronto paso 3 listo " & DateDiff(DateInterval.Second, tTemp, Now))
                    tTemp = Now



                    '//////////////////////////////////////////
                    '//////////////////////////////////////////
                    '//////////////////////////////////////////

                    '//////////////////////////////////////////
                    '/////////////////////////////////////
                    '//////////////////////////////////////////



                    For Each dr In listEmbarques


                        With .DetFacturas.Item(-1)
                            With .Registro
                                'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
                                'Debug.Print(dr.item("IdArticulo"))


                                .Fields("IdArticulo").Value = BuscaIdArticuloPreciso(dr.Item("Producto"), SC) 'mIdArticuloParaImportacionFacturas
                                .Fields("Cantidad").Value = dr.Item("KgNetos") / 1000 'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales

                                If (dr.Item("TarifaFacturada") = 0) Then Throw New Exception("El item de la factura tiene tarifa 0.    " & .Fields("IdArticulo").Value & " " & .Fields("Cantidad").Value)

                                .Fields("PrecioUnitario").Value = dr.Item("TarifaFacturada")
                                .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value
                                .Fields("Costo").Value = 0
                                .Fields("Bonificacion").Value = 0
                                .Fields("OrigenDescripcion").Value = 1



                                .Fields("PorcentajeIva").Value = mTasa  'deberia estar usando el de cada articulo, por ahora uso el iva general  http://consultas.bdlconsultores.com.ar/Admin/VerConsultas1.php?recordid=46968
                                .Fields("ImporteIva").Value = Math.Round(.Fields("Cantidad").Value * (.Fields("PrecioUnitario").Value), 2) * mTasa / 100


                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////
                                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8946
                                'En el primero imprimir la leyenda \"ATENCION BUQUE\"
                                'En el segundo: Nombre del Buque - Cereal - Puerto

                                Dim obsEmbarque As String = "BUQUE " & dr.Item("Corredor") & SEPAR & "  " & dr.Item("DestinoDesc")


                                .Fields("Observaciones").Value = obsEmbarque
                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////////////


                            End With
                            .Modificado = True

                        End With
                    Next




                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////




                    If Not dtRenglonesManuales Is Nothing Then

                        Dim K_idartcambio As Integer = GetIdArticuloParaCambioDeCartaPorte(SC)

                        For Each dr As DataRow In dtRenglonesManuales.Rows

                            With .DetFacturas.Item(-1)
                                With .Registro
                                    'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
                                    'Debug.Print(dr.item("IdArticulo"))
                                    .Fields("IdArticulo").Value = BuscaIdArticuloPreciso(dr.Item("Producto"), SC) 'mIdArticuloParaImportacionFacturas

                                    'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales


                                    Dim tarif As Double
                                    If .Fields("IdArticulo").Value = K_idartcambio Or InStr(dr.Item("Producto"), "ANALISIS") > 0 Or
                                         InStr(dr.Item("Producto"), "RETIRO DE DOCUMENTACION") > 0 Or
                                        InStr(dr.Item("Producto"), "FLETE") > 0 Then


                                        'si es un "cambio de carta porte", no dividir por mil. 
                                        'Es decir, la "Tarifa" en los renglones normales es por "Tonelada", y en estos es por "Unidad".
                                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11379
                                        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11577

                                        .Fields("Cantidad").Value = dr.Item("KgNetos")
                                        tarif = dr.Item("TarifaFacturada")

                                    Else

                                        'si es un articulo común (un grano) hay que divdir la cantidad


                                        .Fields("Cantidad").Value = dr.Item("KgNetos") / 1000
                                        tarif = dr.Item("TarifaFacturada") '/ 1000
                                    End If


                                    If (tarif = 0) Then Throw New Exception("El item de la factura tiene tarifa 0.    " & .Fields("IdArticulo").Value & " " & .Fields("Cantidad").Value)


                                    .Fields("PrecioUnitario").Value = tarif
                                    .Fields("PrecioUnitarioTotal").Value = .Fields("PrecioUnitario").Value


                                    .Fields("PorcentajeIva").Value = mTasa  'deberia estar usando el de cada articulo, por ahora uso el iva general  http://consultas.bdlconsultores.com.ar/Admin/VerConsultas1.php?recordid=46968
                                    .Fields("ImporteIva").Value = Math.Round(.Fields("Cantidad").Value * (.Fields("PrecioUnitario").Value), 2) * mTasa / 100



                                    .Fields("Costo").Value = 0
                                    .Fields("Bonificacion").Value = 0
                                    .Fields("OrigenDescripcion").Value = 1
                                    .Fields("Observaciones").Value = ""
                                End With
                                .Modificado = True

                            End With
                        Next
                    End If



                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'agregar renglon de "Gastos administrativos"
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    Dim IdArticuloGastoAdministrativo = BuscaIdArticuloPreciso("CAMBIO DE CARTA DE PORTE", SC)

                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526

                    If IdArticuloGastoAdministrativo > 0 Then



                        If cantidadGastosAdministrativos > 0 Then


                            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8526
                            Dim PrecioArticuloGastoAdministrativo As Double = ListaPreciosManager.Tarifa(SC, IdClienteAFacturarle, IdArticuloGastoAdministrativo)
                            If PrecioArticuloGastoAdministrativo = 0 Then
                                PrecioArticuloGastoAdministrativo = StringToDecimal(txtTarifaGastoAdministrativo)
                                'PrecioArticuloGastoAdministrativo = ListaPreciosManager.Tarifa(sc, IdClienteAFacturarle, IdArticuloGastoAdministrativo)
                            End If
                            If PrecioArticuloGastoAdministrativo = 0 Then
                                'tanto la lista de precios como el default estan en 0
                                EntidadManager.ErrHandler2WriteErrorLogPronto("No se pudo asignar la tarifa de gasto administrativo para " & IdClienteAFacturarle, SC, "")
                            End If


                            'Solicitan que la tarifa del artículo Cambio de Carta de Porte la tome siempre de la Lista de Precios de 
                            'cada cliente y que la pida en los casos en que la Carta de Porte tiene el tilde y el 
                            'cliente al que se le facturará no tiene elegida una tarifa.
                            '-ah, o sea que no habrá mas default, no?


                            With .DetFacturas.Item(-1)
                                With .Registro
                                    'If iisNull(dr.item("IdArticulo")) = "" Then Continue For
                                    'Debug.Print(dr.item("IdArticulo"))
                                    .Fields("IdArticulo").Value = IdArticuloGastoAdministrativo
                                    .Fields("Cantidad").Value = cantidadGastosAdministrativos 'le pasé la división por mil a la tarifa porque acá hacen un truco, y en el Pronto solo tengo 2 decimales
                                    .Fields("PrecioUnitario").Value = PrecioArticuloGastoAdministrativo
                                    .Fields("PrecioUnitarioTotal").Value = PrecioArticuloGastoAdministrativo


                                    .Fields("PorcentajeIva").Value = mTasa  'deberia estar usando el de cada articulo, por ahora uso el iva general  http://consultas.bdlconsultores.com.ar/Admin/VerConsultas1.php?recordid=46968
                                    .Fields("ImporteIva").Value = Math.Round(.Fields("Cantidad").Value * (.Fields("PrecioUnitario").Value), 2) * mTasa / 100


                                    .Fields("Costo").Value = 0
                                    .Fields("Bonificacion").Value = 0
                                    .Fields("OrigenDescripcion").Value = 1
                                    .Fields("Observaciones").Value = "GASTOS ADMINISTRATIVOS" '"POR GASTOS ADMINISTRATIVOS"
                                End With
                                .Modificado = True

                            End With
                        End If

                    End If



                    '//////////////////////////////////////////
                    '//////////////////////////////////////////
                    '//////////////////////////////////////////



                    'CalculaFactura(oFac)
                    Try
                        CalculaFacturaSimplificado(oFac, SC, Session, numeropuntoVenta, IdPuntoVenta) 'recien ahi se asigna la letra de la factura...
                    Catch ex As Exception
                        ErrHandler2.WriteError("Error en CalculaFacturaSimplificado. " & ex.ToString)
                        MandarMailDeError(ex)
                        Return -1
                    End Try




                    With .Registro

                        .Fields("ImporteIva2").Value = 0
                        .Fields("ImporteBonificacion").Value = 0

                        If False Then
                            .Fields("RetencionIBrutos1").Value = 0
                            .Fields("PorcentajeIBrutos1").Value = 0
                            .Fields("RetencionIBrutos2").Value = 0
                            .Fields("PorcentajeIBrutos2").Value = 0
                        End If

                    End With





                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    ' Defino el punto de venta
                    ' Talonario=Punto de venta + Letra + Tipo de Comprobante (factura, NC, ND)


                    'Traigo el IdPuntoVenta
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////

                    'de qué obra es el usuario?

                    Dim mvarNumeracionUnica = False
                    'If parametros.Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True 

                    'If mvarNumeracionUnica And oFac.Registro.Fields("TipoABC").Value <> "E" Then
                    '    oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(sc, "PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra", ArrayVB6(puntoVenta, oFac.Registro.Fields("TipoABC").Value)))

                    'Else
                    '    'oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(sc, "PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra", ArrayVB6(puntoVenta, oFac.Registro.Fields("TipoABC").Value)))
                    'End If


                    ''If oRs.RecordCount = 1 Then 
                    ''verificar que es de tipocomprobante=Factura
                    'oRs.MoveFirst()

                    'mvarPuntoVenta = oRs.Fields(0).Value


                    IdPuntoVenta = EntidadManager.TablaSelectId(SC, "PuntosVenta", "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & oFac.Registro.Fields("TipoABC").Value & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)

                    oFac.Registro.Fields("IdPuntoVenta").Value = IdPuntoVenta


                    If IdPuntoVenta = 0 Then
                        ErrHandler2.WriteError("No hay talonario de facturas para el punto de venta " & numeropuntoVenta & " Letra " & oFac.Registro.Fields("TipoABC").Value)
                        Return -1
                    End If

                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    'Aplico el IdPuntoVenta



                    Dim oPto 'As ComPronto.PuntoVenta 
                    oPto = oAp.PuntosVenta.Item(IdPuntoVenta)
                    With oPto.Registro
                        Dim n = .Fields("ProximoNumero").Value
                        oFac.Registro.Fields("NumeroFactura").Value = n
                        oFac.Registro.Fields("PuntoVenta").Value = numeropuntoVenta

                        .Fields("ProximoNumero").Value = n + 1
                    End With
                    oPto.Guardar()
                    oPto = Nothing



                    For i = -100 To (-100 - (oFac.DetFacturas.Count - 1)) Step -1
                        With oFac.DetFacturas.Item(i).Registro
                            'estos datos recien los tengo cuando termina
                            'acá hay rollo http: //consultas.bdlconsultores.com.ar/Admin/VerConsultas1.php?recordid=46968
                            .Fields("NumeroFactura").Value = mNumero
                            .Fields("TipoABC").Value = mLetra
                            .Fields("PuntoVenta").Value = IdPuntoVenta
                        End With
                    Next

                    'End If
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////

                    Debug.Print("        ComPronto paso 4 listo " & DateDiff(DateInterval.Second, tTemp, Now))
                    tTemp = Now


                    Dim idfac = TraerUltimaIdFacturaCreada(SC)


                    Try

                        Select Case .Guardar()
                            Case ICompMTSManager.MisEstados.Correcto
                            Case ICompMTSManager.MisEstados.ModificadoPorOtro
                                'MsgBox("El Regsitro ha sido modificado")
                                ErrHandler2.WriteError("El Regsitro ha sido modificado")
                                Return -1
                            Case ICompMTSManager.MisEstados.NoExiste
                                'MsgBox("El registro ha sido eliminado")
                                ErrHandler2.WriteError("El registro ha sido eliminado")
                                Return -1
                            Case ICompMTSManager.MisEstados.ErrorDeDatos
                                'MsgBox("Error de ingreso de datos")
                                ErrHandler2.WriteError("Error de ingreso de datos")
                                Return -1
                        End Select

                    Catch ex As Exception
                        'ver si aumento el idfactura
                        Dim idfac2 = TraerUltimaIdFacturaCreada(SC)


                        Dim s As String = idfac.ToString & " " & idfac2.ToString & "Explosión al llamar a Compronto.Factura.Guardar(). Ojo porque si se generó pero no se manda a imprimir les rompe la numeración!!! " &
                            " La factura quizas queda por la mitad y no genera el subdiario (eso es un problema del ComPronto).  Si es Type Mismatch se puede dar tanto " &
                            " cuando se rompe la compatibilidad del COM, como cuando se rompe la compatibilidad del " &
                            " recordset/storeproc/tabla (y esto es lo mas probable, ya que está pasando en el guardar() )" &
                            " [verificar que desde Pronto se puede dar de alta esta misma factura con el " &
                            " mismo cliente. Si sigue el error, verificar que están corridos los storeprocs de " &
                            " Pronto actualizados]     Si es 'Application uses a value of the wrong type' puede ser el tipo o " &
                            " un overflow del tipo, una cadena muy larga. Queda algún tipo de rastro en el log sql de Pronto? -no vas a" &
                            " encontrar mucha informacion ahí. Hay que correr el Profiler mientras facturás y ver cual es la ultima llamada antes de Log_InsertarRegistro. " &
                            " Puede ser la actualizacion de la entidad Cliente, " &
                            " así que por Pronto hay que intentar facturarle al mismo cliente Y TAMBIEN ver si se puede editar y grabar el formulario de cliente. " &
                            "-Por qué fue que tuvimos un problema así en Capen? Qué era lo que tenía el Clientes_M, mal el largo de un campo? " &
                                            ex.ToString
                        ErrHandler2.WriteError(s)
                        MandarMailDeError(s)

                        Return -1  'si la factura se creó, no puedo devolver lo mismo que en los otros casos

                    End Try

                End With
                idFacturaCreada = oFac.Registro.Fields(0).Value


                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                'esto es codigo que se ejecuta en el boton aceptar (cmd_Click index 0) del frmFacturas 
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////

                'aumentar numerador IIBB 

                Dim db As ProntoMVC.Data.Models.DemoProntoEntities = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC)))


                If oFac.Registro.Fields("RetencionIBrutos1").Value > 0 Then

                    Dim cli = db.Clientes.Find(IdClienteAFacturarle)
                    Dim ibcond = db.IBCondiciones.Find(cli.IdIBCondicionPorDefecto)
                    Dim mIdProvinciaIIBB = ibcond.IdProvincia
                    Dim oPrv As Models.Provincia = db.Provincias.Find(mIdProvinciaIIBB)

                    Dim mNum = oPrv.ProximoNumeroCertificadoPercepcionIIBB
                    oPrv.ProximoNumeroCertificadoPercepcionIIBB = mNum + 1

                    db.SaveChanges()
                End If


                'If dcfields(4).Enabled And Check1(0).Value = 1 Then
                '    Dim oPrv As ComPronto.Provincia
                '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", origen.Registro.Fields("IdIBCondicion").Value)
                '    If oRs.RecordCount > 0 Then
                '        If Not IsNull(oRs.Fields("IdProvincia").Value) Then
                '            oPrv = db.Provincias.Find(  oRs.Fields("IdProvincia").Value))
                '            With oPrv.Registro
                '                mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
                '                origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = mNum
                '                .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value = mNum + 1
                '            End With

                '            db.SaveChanges()
                '        End If
                '    End If
                'End If


                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////

                oFac = Nothing






                Try
                    EntidadManager.LogPronto(SC, idFacturaCreada, "Factura por ProntoWeb", usuario)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


            Else
                'este comentario lo puse ya en un if anterior
                'AgregarMensajeProcesoPresto(oRsErrores, "La factura " & mComprobante & " ya existe, no se generará")
            End If

        Catch ex As Exception

            ErrHandler2.WriteError("Error en la llamada a CreaFacturaCOMpronto. " & ex.ToString)
            MandarMailDeError(ex)
        End Try

        Debug.Print("        ComPronto paso 5 listo " & DateDiff(DateInterval.Second, tTemp, Now))
        tTemp = Now


        Return idFacturaCreada

    End Function

    Shared Function TodasLasCartasTienenElMismoClienteObsConCircuitoEspecial(SC As String, ByVal oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte)) As Integer
        '        http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=13928

        '* Agregar una marca en la tabla de clientes para indicar cuales tienen que entrar por este circuito
        '* En facturación cuando filtren con el campo Cliente Observaciones algún cliente que tiene la marca del punto anterior, ponerle el id del cliente en cuestión a todas las facturas que se creen en un campo nuevo en la cabeza de las facturas (IdClienteObservaciones)




        Dim db = New ProntoMVC.Data.Models.DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

        Dim cartas = oListaCDP.Select(Function(x) x.Id).ToList


        Dim q = (From x In db.CartasDePortes
                 From c In db.DetalleClientesContactos Where c.IdCliente = x.IdClienteAuxiliar And c.Acciones = "EsClienteObservacionesFacturadoComoCorredor"
                 Where cartas.Contains(x.IdCartaDePorte)
                 Select c
            ).Distinct.ToList

        If q.Count = 1 Then
            If q(0).Contacto = "SI" Then Return q(0).IdCliente
        End If

        Return 0

    End Function



    Shared Function TraerUltimaIdFacturaCreada(SC As String) As Long

        Dim id As Long
        Try
            id = EntidadManager.ExecDinamico(SC, "SELECT MAX(IdFactura) FROM Facturas").Rows(0).Item(0)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        Return id
    End Function

    Shared Sub RefrescaTarifaTablaTemporal(ByRef dt As DataTable, ByVal sc As String, ByVal optFacturarA As Integer, ByVal sClienteTercero As String, ByVal sesionId As Long, Optional ByVal idClienteAfacturarle As Long = -1, Optional ByVal IdArticulo As Long = -1, Optional ByVal tarif As Double = 0, Optional ByVal exporta As Boolean = False)

        'Return

        If optFacturarA = 4 Then 'opcion a terceros
            idClienteAfacturarle = BuscaIdClientePreciso(sClienteTercero, sc)
        End If



        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        Dim ids As Integer = sesionId
        If ids > 0 Then



            Dim o As Generic.List(Of wTempCartasPorteFacturacionAutomatica) =
            (From i As wTempCartasPorteFacturacionAutomatica In db.wTempCartasPorteFacturacionAutomaticas
             Where i.IdSesion = ids And
                (i.IdFacturarselaA = idClienteAfacturarle Or idClienteAfacturarle = -1) And
                (i.IdArticulo = IdArticulo Or IdArticulo = -1)).ToList



            Try

                'como safamos aca? me tendria que traer el campo "exporta" desde la tabla temporal, que no lo tiene
                'safo desde otro lado?



                For Each x In o
                    'x.TarifaFacturada = dr.Item("TarifaFacturada")
                    'todo: 8528
                    If If(x.IdCartaDePorte, 0) < 0 Then
                        'es un embarque
                        x.TarifaFacturada = If(db.wTarifaWilliams(x.IdFacturarselaA, x.IdArticulo, x.IdDestino, 2, 0), 0)
                    ElseIf exporta Then
                        x.TarifaFacturada = If(db.wTarifaWilliams(x.IdFacturarselaA, x.IdArticulo, x.IdDestino, 1, 0), 0)
                    Else
                        x.TarifaFacturada = If(db.wTarifaWilliams(x.IdFacturarselaA, x.IdArticulo, x.IdDestino, 0, 0), 0)
                    End If
                Next






                db.SubmitChanges()
            Catch ex As Exception

                ErrHandler2.WriteError(ex)
                Throw
            End Try


        End If




        If False And optFacturarA = 4 Then 'opcion a terceros
            Try

                Dim IdFacturarselaA = BuscaIdClientePreciso(sClienteTercero, sc)

                Dim q = From i In dt.AsEnumerable
                        Group By IdFac = i("IdFacturarselaA"),
                             IdArti = i("IdArticulo"),
                             IdDestin = iisNull(i("IdDestino"), 0)
                        Into Group
                        Select New With {
                            .IdFac = IdFac, .IdArticulo = IdArti, .IdDestino = IdDestin,
                           .Tarif = iisNull(db.wTarifaWilliams(IdFac, IdArti, IdDestin, 0, 0), 0)
                            }



                Dim d = q.ToDataTable 'no tarda demasiado



                Dim total = 0
                For Each tarifrow In d.Rows

                    If optFacturarA = 5 Then IdFacturarselaA = tarifrow.Item("IdFac")
                    Dim idart = tarifrow.Item("IdArticulo")
                    Dim iddest = tarifrow.Item("IdDestino")
                    Dim tarifa = tarifrow.Item("Tarif")


                    Dim drcol As DataRow() = dt.Select("IdFacturarselaA=" & IdFacturarselaA & " AND IdArticulo= " & idart & " AND IdDestino=" & iddest)
                    total += drcol.Count
                    For Each r In drcol
                        r.Item("TarifaFacturada") = tarifa
                    Next

                Next





            Catch ex As Exception
                ErrHandler2.WriteError("Error al actualizar la tarifa. " & ex.ToString)
            End Try

        End If


    End Sub

    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////


    Shared Function DataTableWHERE_ClientesNoHabilitados(ByVal dt As DataTable) As DataTable
        Return DataTableWHERE(dt, " CUIT is NULL OR CUIT='' OR NOT (IdCodigoIVA=1 OR IdCodigoIVA=2 OR IdCodigoIVA=9) ")
    End Function

    Shared Function DataTableWHERE_ClientesHabilitados(ByVal dt As DataTable) As DataTable
        Return DataTableWHERE(dt, " NOT isnull(CUIT,'')='' AND (IdCodigoIVA=1 OR IdCodigoIVA=2 OR IdCodigoIVA=9) ")
    End Function



    Shared Function VerificarClientesFacturables(ByRef dtGrillaPasada As DataTable, ByVal sc As String, ByVal ListaIDs As String, ByVal txtFacturarATerceros As String, ByVal optFacturarA As Integer) As String


        Dim s As String = ""


        Dim dtgrilla As DataTable

        If True Then
            dtgrilla = dtGrillaPasada 'esto esta mal. tenes q revisar el datasource entero, sin paginar


        Else
            'If optFacturarA = 5 Then
            '    'TODO: truco para que traiga TODAS las filas, sin paginar
            '    dtgrilla = GetDatatableAsignacionAutomatica(sc, ViewState, 999999, cmbPuntoVenta.Text)
            'Else
            '    dtgrilla = dtGrillaPasada 'esta es la grilla, incluye las manuales
            'End If

            'If optFacturarA.SelectedValue = 5 Then
            '    dtgrilla = GetDatatableAsignacionAutomatica(HFSC.Value, ViewState, GridView2.PageSize, cmbPuntoVenta.Text)
            '    'Dim sLinks = LinksDeCartasConflictivas(dtgrilla)
            '    'If sLinks <> "" Then s &= vbCrLf & "Cartas con conflicto en el automático: " & sLinks
            'Else
            '    dtgrilla = EntidadManager.ExecDinamico(sc, SQL_ListaDeCDPsFiltradas(" AND IdCartaDePorte IN (" & ListaIDs & ") ", _
            '            optFacturarA.SelectedValue, txtFacturarATerceros.Text, HFSC.Value, txtTitular.Text, txtCorredor.Text, _
            '            txtDestinatario.Text, txtIntermediario.Text, txtRcomercial.Text, txt_AC_Articulo.Text, txtProcedencia.Text, 
            '            txtDestino.Text, txtBuscar.Text, cmbCriterioWHERE.SelectedValue, cmbModo.Text, optDivisionSyngenta.SelectedValue, 
            '            txtFechaDesde.Text, txtFechaHasta.Text, cmbPuntoVenta.Text))
            'End If

        End If



        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '- Clientes provisorios: no tienen Cuit o algún otro dato necesario para facturar.

        Dim dt As DataTable

        'cuando facturo a terceros, a veces muestra como provisorio un cliente que no lo es, probablemente
        'porque en realidad el que es provisorio es el titular de la cdp, o algo así
        'SQL_ListaDeCDPsFiltradas la tiene dificil para pasarme el dato, así que lo resuelvo de manera poco elegante por acá
        If optFacturarA = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros, sc)
            Dim facturarselaA = "'" & txtFacturarATerceros & "'"
            dt = EntidadManager.ExecDinamico(sc,
                            "SELECT IdCodigoIVA,CUIT," & facturarselaA & " as FacturarselaA FROM CLIENTES where IdCliente=" & IdFacturarselaA)

            dt = DataTableWHERE_ClientesNoHabilitados(dt)
        Else
            'dt = DataTableWHERE(dtgrilla, "NOT (NOT CUIT is NULL AND IdCodigoIVA>0) ")
            dt = DataTableWHERE_ClientesNoHabilitados(dtgrilla)
        End If

        Try
            'no trae el IdFacturarselaA si es "a Terceros"

            dt = DataTableDISTINCT(dt, "IdFacturarselaA", "FacturarselaA")

            Dim l As New Generic.List(Of String)


            Dim sSinCUIT As String = ""
            For Each dr In dt.Rows
                'l.Add(dr.Columns("FacturarselaA"))

                'agregarlos como links
                sSinCUIT &= "<a href=""Cliente.aspx?Id=" & dr("IdFacturarselaA") & """ target=""_blank"">" & dr("FacturarselaA") & "</a>; "
            Next

            If sSinCUIT <> "" Then s &= vbCrLf & "Sin CUIT/sin confirmar/CAI vencido/Facturas 'B': " & sSinCUIT

        Catch ex As Exception
            'no trae el IdFacturarselaA si es "a Terceros"
            ErrHandler2.WriteError("Ojo, no trae el IdFacturarselaA si es a Terceros")
            ErrHandler2.WriteError(ex)
        End Try



        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '- Corredores: si no están en la tabla de clientes se llega al segundo paso y al facturar a corredor quedan vacías las casillas de Facturar a.

        Dim sCorredores As String = ""
        If optFacturarA = 3 Then
            Dim dtCorr = DataTableWHERE(dtgrilla, "ISNULL(FacturarselaA,'')=''")
            dtCorr = DataTableDISTINCT(dtCorr, "Corredor ")

            Dim l2 As New Generic.List(Of String)
            For Each dr In dtCorr.Rows
                'l.Add(dr.Columns("FacturarselaA"))
                sCorredores &= dr("Corredor ") & "; "
            Next

        End If

        If sCorredores <> "" Then s &= vbCrLf & "Corredores sin cliente asociado: " & sCorredores

        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////
        'Kg en 0: a veces no se está calculando en el abm de Cartas de Porte el KgNeto final. 
        '(o sea, tiene peso de Descarga, y aparece para facturar. Pero no está el neto final)
        'Cuando esto pasa se debe controlar, de otra manera se hará una factura por 0 pesos.

        Dim sKilosEnCero As String = ""
        Dim dt0 = DataTableWHERE(dtgrilla, "isnull(KgNetos,0)=0")
        For Each dr In dt0.Rows
            'l.Add(dr.Columns("FacturarselaA"))
            sKilosEnCero &= dr("NumeroCartaDePorte") & "; "
        Next

        If sKilosEnCero <> "" Then s &= vbCrLf & "Descargas sin neto final: " & sKilosEnCero
        '/////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////

        Return s
    End Function


    Shared Function VerificarClientesFacturables(ByVal l As Generic.List(Of wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistenciaResult))

        'Filtra las conflictivas, y tambien las muestra en un texto.



        Dim cartasrepetidas = (From i In l
                               Group By Id = i.IdCartaDePorte,
                                            Numero = i.NumeroCartaDePorte,
                                    SubnumeroVagon = i.SubNumeroVagon,
                                    SubNumeroFacturacion = i.SubnumeroDeFacturacion
                               Into Group
                               Where iisNull(SubNumeroFacturacion, 0) = 0 _
                                    And Group.Count() > 1
                               Select New With {.id = Id, .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim s As String
    End Function

    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////






    Shared Sub CalculaFacturaSimplificado(ByRef oFac As Object, ByVal sc As String, ByRef session As System.Web.SessionState.HttpSessionState, puntoventa As Long, IdPuntoVenta As Long) 'As ComPronto.Factura )
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        'Codigo del CalculaFactura que esta en la gui del pronto (frmFactura)
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        Dim i As Integer, mIdProvinciaIIBB As Integer
        Dim mNumeroCertificadoPercepcionIIBB As Long
        Dim t0 As Double, t1 As Double, t2 As Double, t3 As Double, mParteDolar As Double
        Dim mPartePesos As Double, mBonificacion As Double, mKilos As Double
        Dim mPrecioUnitario As Double, mCantidad As Double, mTopeIIBB As Double
        Dim mFecha1 As Date

        Dim mTotal As Double
        Dim mvarImporteBonificacion, mvarNetoGravado, mvarPorcentajeBonificacion, mvarSubTotal, mvarCotizacion, mvarDecimales
        Dim mvarTipoABC, mvarIVANoDiscriminado, mvarPartePesos, txtPorcentajeIva2



        Dim usuario As Integer = 1
        If session IsNot Nothing Then usuario = session(SESSIONPRONTO_glbIdUsuario)

        Dim totIVA As Double = 0



        Dim cli As ClienteNuevo = ClienteManager.GetItem(sc, oFac.Registro.Fields("IdCliente").Value)
        Dim mvarTipoIVA = cli.IdCodigoIva

        If mvarTipoIVA = 0 Then
            ErrHandler2.WriteAndRaiseError("No se encuentra el IdCodigoIVA para el cliente " & oFac.Registro.Fields("IdCliente").Value)
        End If

        mvarTipoABC = LetraSegunTipoIVA(mvarTipoIVA)


        For i = -100 To (-100 - (oFac.DetFacturas.Count - 1)) Step -1

            Dim item 'As ComPronto.DetFactura  
            item = oFac.DetFacturas.Item(i)



            With item.Registro
                If Not item.Eliminado Then

                    '////////////////////////////////////////////////
                    'este pedazo está traido del DetFacturas
                    Dim mAlicuotaIVA_Material = IIf(IsNull(ArticuloManager.GetItem(sc, .Fields("idArticulo").Value).AlicuotaIVA), 0, ArticuloManager.GetItem(sc, .Fields("idArticulo").Value).AlicuotaIVA)
                    If iisNull(mAlicuotaIVA_Material, 0) = 0 Then
                        Throw New Exception("El artículo " & .Fields("idArticulo").Value & " tiene IVA en 0")
                        'errlog& = MsgBoxAjax(Me, "El artículo " & .Fields("idArticulo").Value & " tiene IVA en 0")
                    End If
                    Dim PorcentajeBonificacionOC = 0 ' IIf(IsNull(.Fields("PorcentajeBonificacionOC").Value), 0, .Fields("PorcentajeBonificacionOC").Value)

                    Dim mvarPrecio = IIf(IsNull(.Fields("PrecioUnitario").Value), 0, .Fields("PrecioUnitario").Value)
                    Dim mPorcB = 0 'IIf(IsNull(.Fields("PorcentajeBonificacion").Value), 0, .Fields("PorcentajeBonificacion").Value)



                    'ah ah ah, acá hará 0.21 x 0.56(el precio de uno de los granos), y cagaste.
                    Dim viejoiva As Double = mvarPrecio * mAlicuotaIVA_Material / 100





                    'bueno, acá empieza el show del redondeo
                    'http://msdn.microsoft.com/es-es/library/system.midpointrounding%28v=vs.110%29.aspx
                    '                    This code example produces the following results:
                    ' 3.4 = Math.Round( 3.45, 1)
                    '-3.4 = Math.Round(-3.45, 1)

                    ' 3.4 = Math.Round( 3.45, 1, MidpointRounding.ToEven)
                    ' 3.5 = Math.Round( 3.45, 1, MidpointRounding.AwayFromZero)

                    '-3.4 = Math.Round(-3.45, 1, MidpointRounding.ToEven)
                    '-3.5 = Math.Round(-3.45, 1, MidpointRounding.AwayFromZero)

                    'yo estoy facturando con ToEven, aparentemente
                    'El que usa por default Excel es el bancario (AwayFromZero). 
                    'Lo mismo el abm web y el abm de pronto (muestran el subtotal sumando como excel)




                    'la facturacion hace cant * precio =                       316.225  --->316.22   ESTA MAL
                    'en excel y el abm de pronto y el de web                            --->316.23


                    Dim cant_X_precio_redondeado = Math.Round(.Fields("Cantidad").Value * (mvarPrecio), 2, MidpointRounding.AwayFromZero)
                    mvarSubTotal += cant_X_precio_redondeado

                    If False Then
                        ErrHandler2.WriteError("cant*precio " & cant_X_precio_redondeado & " mvarSubTotal " & mvarSubTotal & " = + " & .Fields("Cantidad").Value & " *  " & mvarPrecio & "redond  * " & mAlicuotaIVA_Material & "/ 100")
                    End If


                    Dim iva As Double = Math.Round(.Fields("Cantidad").Value * (mvarPrecio), 2) * mAlicuotaIVA_Material / 100

                    'el total es el total, no importa que discrimine
                    mTotal += .Fields("Cantidad").Value * (mvarPrecio + iva)


                    '
                    If mvarTipoABC = "B" And mvarTipoIVA <> 8 And
                      EntidadManager.BuscarClaveINI("Ordenes de compra iva incluido", sc, usuario) <> "SI" Then
                        'acá hace "la magia" de encajarle el iva en el precio del item (recordá que 
                        'no discriminar el iva es solo un tema de presentacion)
                        mvarPrecio = mvarPrecio + iva
                    End If

                    totIVA += iva 'Math.Round(iva * .Fields("Cantidad").Value, 2)   esto no lo debo hacer así, por lo
                    'menos para que me cierre: debo tomar el importe total del item ya redondeado, y a ese tomarle el iva.



                    .Fields("PrecioUnitario").Value = mvarPrecio
                    .Fields("PrecioUnitarioTotal").Value = mvarPrecio
                    .Fields("Bonificacion").Value = mPorcB


                    '.Fields("OrigenDescripcion").Value = .Fields("OrigenDescripcion").Value
                    '.Fields("TipoCancelacion").Value = .Fields("TipoCancelacion").Value
                    '.Fields("Costo").Value = .Fields("CostoPPP").Value

                    '////////////////////////////////////////////////////



                End If
            End With
        Next





        mvarImporteBonificacion = Math.Round(mvarSubTotal * mvarPorcentajeBonificacion / 100, 2)
        mvarNetoGravado = mvarSubTotal - mvarImporteBonificacion


        With oFac.Registro
            .Fields("RetencionIBrutos1").Value = 0
            .Fields("PorcentajeIBrutos1").Value = 0
            .Fields("RetencionIBrutos2").Value = 0
            .Fields("PorcentajeIBrutos2").Value = 0
        End With






        Dim scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sc))
        Dim db = New DemoProntoEntities(scEF)






        Dim mvarIBrutos As Double = 0
        If True Then
            Try
                Dim puntoventapercepcion = ExecDinamico(sc, "Select AgentePercepcionIIBB from PuntosVenta  where  IdPuntoVenta=" & IdPuntoVenta)
                mvarIBrutos = PercepcionIngresosBrutos(oFac, sc, session, cli, mvarNetoGravado,
                                                    "SI" = db.Parametros.First().PercepcionIIBB,
                                                    "SI" = iisNull(puntoventapercepcion.Rows(0).Item("AgentePercepcionIIBB"), "NO")) '(puntoventa = 2 Or puntoventa = 3))
            Catch ex As Exception
                ErrHandler2.WriteError("Error al calcular ingresos brutos. " & ex.ToString)
            End Try
        End If


        'If mvarEsAgenteRetencionIVA = "NO" And mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA Then
        '    mvarPercepcionIVA = Math.Round(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
        'End If


        'If mvarNumeracionUnica And mvarTipoABC <> "E" Then
        '    oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC))
        'Else
        '    oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC))
        'End If


        'mvarTotalFactura = mvarNetoGravado + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 + mvarIBrutos3 + mvarPercepcionIVA + _
        '         Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text)



        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        If False Then

            ErrHandler2.WriteError("mTotal       " & mTotal)
            ErrHandler2.WriteError("mvarSubTotal " & mvarSubTotal)
            ErrHandler2.WriteError("mvarIBrutos  " & mvarIBrutos)
            ErrHandler2.WriteError("totIVA       " & totIVA)
            ErrHandler2.WriteError("ImporteTotal " & Math.Round(mvarSubTotal + mvarIBrutos + Math.Round(totIVA, 2), 2))
        End If



        'agregado por mi para reasignar las cosas de la GUI falsa al objeto
        Try


            With oFac.Registro

                .Fields("TipoABC").Value = mvarTipoABC




                .Fields("ImporteTotal").Value = Math.Round(mvarSubTotal + mvarIBrutos + Math.Round(totIVA, 2), 2)   ' Math.Round(mTotal, 2)

                If mvarTipoABC = "B" And mvarTipoIVA <> 8 And
                  EntidadManager.BuscarClaveINI("Ordenes de compra iva incluido", sc, usuario) <> "SI" Then
                    .Fields("IVANoDiscriminado").Value = Math.Round(totIVA, 2) ' totIVA
                    .Fields("ImporteIva1").Value = 0
                Else
                    .Fields("ImporteIva1").Value = Math.Round(totIVA, 2)
                End If

                .Fields("IdCodigoIva").Value = mvarTipoIVA





            End With


        Catch ex As Exception
            ErrHandler2.WriteAndRaiseError("Error al calcular totales. " & ex.ToString)
        End Try


    End Sub






    Private Shared Function PercepcionIngresosBrutos(ByRef oFac As Object, ByVal sc As String, ByRef session As System.Web.SessionState.HttpSessionState, cli As ClienteNuevo, mvarNetoGravado As Double, Parametros_EsAgenteDePercepcionIIBB As Boolean, Pventa_AgentePercepcionIIBB As Boolean) As Double

        '//////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        'Codigo del CalculaFactura que esta en la gui del pronto (frmFactura)
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////



        Dim mNumeroCertificadoPercepcionIIBB
        Dim mvarIBrutos, mvarIBrutos2, mvarIBrutos3 As Decimal
        Dim mvarPorcentajeIBrutos, mvarPorcentajeIBrutos2, mvarPorcentajeIBrutos3 As Decimal
        Dim mvarMultilateral As String
        Dim mIdProvinciaIIBB, mIdProvinciaIIBBbasico

        Dim mAlicuotaDirecta
        Dim mFechaFinVigenciaIBDirecto, mFechaInicioVigenciaIBDirectoCapital, mFechaFinVigenciaIBDirectoCapital, mFechaInicioVigenciaIBDirecto
        Dim mvarIBCondicion, mFecha1, mAlicuotaDirectaCapital



        Dim fechafactura = Now
        Dim clicatiibb As Integer = cli.IBCondicion '.IdIBCondicionPorDefecto
        Dim facturaTieneCheckCategoria1 = True

        mAlicuotaDirecta = cli.PorcentajeIBDirecto
        mFechaInicioVigenciaIBDirecto = cli.FechaInicioVigenciaIBDirecto
        mFechaFinVigenciaIBDirecto = cli.FechaFinVigenciaIBDirecto
        mAlicuotaDirectaCapital = cli.PorcentajeIBDirectoCapital
        mFechaInicioVigenciaIBDirectoCapital = cli.FechaInicioVigenciaIBDirectoCapital
        mFechaFinVigenciaIBDirectoCapital = cli.FechaFinVigenciaIBDirectoCapital




        'los montos que importan son los campos "RetencionIBrutos1" / "2" / "3" 
        'no confundirse con el monto por "Otras Percepciones", que van en los campos "OtrasPercepciones1" y "OtrasPercepciones2" y "OtrasPercepciones3"
        With oFac.Registro
            .Fields("RetencionIBrutos1").Value = iisNull(mvarIBrutos, 0)  ' es importante que el campo "IdIBCondicion" esté marcado
            .Fields("PorcentajeIBrutos1").Value = iisNull(mvarPorcentajeIBrutos, 0)
            .Fields("RetencionIBrutos2").Value = iisNull(mvarIBrutos2, 0) ' es importante que el campo "IdIBCondicion2" esté marcado
            .Fields("PorcentajeIBrutos2").Value = iisNull(mvarPorcentajeIBrutos2, 0) '
            .Fields("RetencionIBrutos3").Value = iisNull(mvarIBrutos3, 0) ' ' es importante que el campo "IdIBCondicion3" esté marcado
            .Fields("PorcentajeIBrutos3").Value = iisNull(mvarPorcentajeIBrutos3, 0) '
        End With

        If Not Parametros_EsAgenteDePercepcionIIBB Then Exit Function
        If Not Pventa_AgentePercepcionIIBB Then Exit Function


        mvarIBCondicion = cli.IBCondicion



        '        If dcfields(4).Enabled And Check1(0).Value = 1 And IsNumeric(dcfields(4).BoundText) Then
        '            oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(4).BoundText)

        If clicatiibb = 2 Or clicatiibb = 3 Or clicatiibb = 5 Then

            'importantisimo
            'importantisimo
            'importantisimo
            Dim oRs = TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, cli.IdIBCondicionPorDefecto)
            If oRs.RecordCount > 0 Then
                oFac.Registro.Fields("IdIBCondicion").Value = cli.IdIBCondicionPorDefecto  'o "IdIBCondicion2" o "IdIBCondicion3"
                Dim mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                mIdProvinciaIIBBbasico = mIdProvinciaIIBB
                Dim mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
                mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Now, oRs.Fields("FechaVigencia").Value)
                Dim mCodigoProvincia = ""


                Dim oRs1 = TraerFiltradoVB6(sc, enumSPs.Provincias_TX_PorId, mIdProvinciaRealIIBB)
                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
                oRs1.Close()
                If mCodigoProvincia = "902" And fechafactura >= mFechaInicioVigenciaIBDirecto And fechafactura <= mFechaFinVigenciaIBDirecto Then
                    If mvarNetoGravado > mTopeIIBB Then
                        mvarPorcentajeIBrutos = mAlicuotaDirecta
                    End If

                ElseIf mCodigoProvincia = "901" And fechafactura >= mFechaInicioVigenciaIBDirectoCapital And fechafactura <= mFechaFinVigenciaIBDirectoCapital Then
                    If mvarNetoGravado > mTopeIIBB Then


                        mvarPorcentajeIBrutos = mAlicuotaDirectaCapital
                    End If
                Else
                    If mvarNetoGravado > mTopeIIBB And fechafactura >= mFecha1 Then
                        If mvarIBCondicion = 2 Then
                            mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                            mvarMultilateral = "SI"
                        Else
                            mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                        End If
                    End If
                End If

                mvarIBrutos = Math.Round(mvarNetoGravado * mvarPorcentajeIBrutos / 100, 2) 'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
            End If
            oRs.Close()

        End If

        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        If clicatiibb = 2 Or clicatiibb = 3 Or clicatiibb = 5 Then
            Dim oRs = TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, cli.IdIBCondicionPorDefecto2)
            If oRs.RecordCount > 0 Then
                oFac.Registro.Fields("IdIBCondicion2").Value = cli.IdIBCondicionPorDefecto2  'o "IdIBCondicion2" o "IdIBCondicion3"
                Dim mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                Dim mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
                mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Now, oRs.Fields("FechaVigencia").Value)
                Dim mCodigoProvincia = ""


                Dim oRs1 = TraerFiltradoVB6(sc, enumSPs.Provincias_TX_PorId, mIdProvinciaRealIIBB)
                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
                oRs1.Close()
                If mCodigoProvincia = "902" And fechafactura >= mFechaInicioVigenciaIBDirecto And fechafactura <= mFechaFinVigenciaIBDirecto Then
                    If mvarNetoGravado > mTopeIIBB Then

                        mvarPorcentajeIBrutos2 = mAlicuotaDirecta
                    End If

                ElseIf mCodigoProvincia = "901" And fechafactura >= mFechaInicioVigenciaIBDirectoCapital And fechafactura <= mFechaFinVigenciaIBDirectoCapital Then
                    If mvarNetoGravado > mTopeIIBB Then
                        mvarPorcentajeIBrutos2 = mAlicuotaDirectaCapital
                    End If
                Else
                    If mvarNetoGravado > mTopeIIBB And fechafactura >= mFecha1 Then
                        If mvarIBCondicion = 2 Then
                            mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                            mvarMultilateral = "SI"
                        Else
                            mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                        End If
                    End If
                End If

                mvarIBrutos2 = Math.Round(mvarNetoGravado * mvarPorcentajeIBrutos2 / 100, 2) 'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
            End If
            oRs.Close()
        End If


        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        If clicatiibb = 2 Or clicatiibb = 3 Or clicatiibb = 5 Then

            Dim oRs = TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, cli.IdIBCondicionPorDefecto3)
            If oRs.RecordCount > 0 Then
                oFac.Registro.Fields("IdIBCondicion3").Value = cli.IdIBCondicionPorDefecto3  'o "IdIBCondicion2" o "IdIBCondicion3"
                Dim mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                Dim mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
                mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Now, oRs.Fields("FechaVigencia").Value)
                Dim mCodigoProvincia = ""


                Dim oRs1 = TraerFiltradoVB6(sc, enumSPs.Provincias_TX_PorId, mIdProvinciaRealIIBB)
                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
                oRs1.Close()
                If mCodigoProvincia = "902" And fechafactura >= mFechaInicioVigenciaIBDirecto And fechafactura <= mFechaFinVigenciaIBDirecto Then
                    If mvarNetoGravado > mTopeIIBB Then
                        mvarPorcentajeIBrutos3 = mAlicuotaDirecta
                    End If
                ElseIf mCodigoProvincia = "901" And fechafactura >= mFechaInicioVigenciaIBDirectoCapital And fechafactura <= mFechaFinVigenciaIBDirectoCapital Then
                    If mvarNetoGravado > mTopeIIBB Then
                        mvarPorcentajeIBrutos3 = mAlicuotaDirectaCapital
                    End If
                Else
                    If mvarNetoGravado > mTopeIIBB And fechafactura >= mFecha1 Then
                        If mvarIBCondicion = 2 Then
                            mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                            mvarMultilateral = "SI"
                        Else
                            mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                        End If
                    End If
                End If

                mvarIBrutos3 = Math.Round(mvarNetoGravado * mvarPorcentajeIBrutos3 / 100, 2) 'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
            End If
            oRs.Close()



        End If



        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////

        'mIdProvinciaIIBB viene vacio... es nullable? -es que depende... lo levantas con el IdProvincia, despues 
        'de levantar la   TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, cli.IdIBCondicionPorDefecto-XXXXX )
        '-por qué voy a buscar las tres diferentes IdIBCondicionPorDefecto???????
        'EDU USA SOLO LA PRIMERA PROVINCIA, LO PODES VER EN EL CalculaFactura()

        If mvarIBrutos <> 0 Then
            Dim oRs2 = TraerFiltradoVB6(sc, enumSPs.Provincias_TX_PorId, mIdProvinciaIIBBbasico)
            If oRs2.RecordCount > 0 Then
                mNumeroCertificadoPercepcionIIBB = IIf(IsNull(oRs2.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, oRs2.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
            End If
            oFac.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = iisNull(mNumeroCertificadoPercepcionIIBB, 0)
            oRs2.Close()
        End If




        With oFac.Registro

            .Fields("RetencionIBrutos1").Value = iisNull(mvarIBrutos, 0)  ' es importante que el campo "IdIBCondicion" esté marcado
            .Fields("PorcentajeIBrutos1").Value = iisNull(mvarPorcentajeIBrutos, 0)
            .Fields("RetencionIBrutos2").Value = iisNull(mvarIBrutos2, 0) ' es importante que el campo "IdIBCondicion2" esté marcado
            .Fields("PorcentajeIBrutos2").Value = iisNull(mvarPorcentajeIBrutos2, 0) '
            .Fields("ConvenioMultilateral").Value = iisNull(mvarMultilateral, "NO")
            .Fields("RetencionIBrutos3").Value = iisNull(mvarIBrutos3, 0) ' ' es importante que el campo "IdIBCondicion3" esté marcado
            .Fields("PorcentajeIBrutos3").Value = iisNull(mvarPorcentajeIBrutos3, 0) '


            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            Try

                'el numerador de certificado es por provincia
                Dim dt = ExecDinamico(sc, "SELECT ProximoNumeroCertificadoPercepcionIIBB from provincias where IdProvincia=" & mIdProvinciaIIBB)
                Dim numcertif As Long
                If dt.Rows.Count > 0 Then numcertif = iisNull(dt.Rows(0).Item(0), 1)

                If False Then 'ahora esto lo hago despues de que se creó la factura, en CreaFacturaCOMpronto
                    ExecDinamico(sc, "UPDATE  provincias set ProximoNumeroCertificadoPercepcionIIBB= " & numcertif + 1 & " where IdProvincia=" & mIdProvinciaIIBB)
                End If

                .Fields("NumeroCertificadoPercepcionIIBB").Value = numcertif
            Catch ex As Exception
                ErrHandler2WriteErrorLogPronto(ex.ToString, sc, "")
            End Try

            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////
        End With

        Return mvarIBrutos



        'If dcfields(5).Enabled And Check1(1).Value = 1 And IsNumeric(dcfields(5).BoundText) Then
        '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(5).BoundText)
        '    If oRs.RecordCount > 0 Then
        '        mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
        '        mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
        '        mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
        '        mCodigoProvincia = ""
        '        oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
        '        If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
        '        oRs1.Close()
        '        If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
        '            mvarPorcentajeIBrutos2 = mAlicuotaDirecta
        '        ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
        '            mvarPorcentajeIBrutos2 = mAlicuotaDirectaCapital
        '        Else
        '            If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
        '                If mvarIBCondicion = 2 Then
        '                    mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
        '                    mvarMultilateral = "SI"
        '                Else
        '                    mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
        '                End If
        '            End If
        '        End If
        '        mvarIBrutos2 = Round(mvarNetoGravado * mvarPorcentajeIBrutos2 / 100, 2)  'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)
        '    End If
        '    oRs.Close()
        '    oRs = Nothing
        'End If





        'If dcfields(6).Enabled And Check1(2).Value = 1 And IsNumeric(dcfields(6).BoundText) Then
        '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(6).BoundText)
        '    If oRs.RecordCount > 0 Then
        '        mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
        '        mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
        '        mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
        '        mCodigoProvincia = ""
        '        oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
        '        If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
        '        oRs1.Close()
        '        If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
        '            mvarPorcentajeIBrutos3 = mAlicuotaDirecta
        '        ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
        '            mvarPorcentajeIBrutos3 = mAlicuotaDirectaCapital
        '        Else
        '            If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
        '                If mvarIBCondicion = 2 Then
        '                    mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
        '                    mvarMultilateral = "SI"
        '                Else
        '                    mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
        '                End If
        '            End If
        '        End If
        '        mvarIBrutos3 = Round(mvarNetoGravado * mvarPorcentajeIBrutos3 / 100, 2)  'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)
        '    End If
        '    oRs.Close()
        '    oRs = Nothing
        'End If



    End Function




    'Private Sub CalculaFactura()

    '    Dim oRs As ADOR.Recordset
    '    Dim oRs1 As ADOR.Recordset
    '    Dim oL As ListItem
    '    Dim i As Integer, mIdProvinciaIIBB As Integer, mIdProvinciaRealIIBB As Integer
    '    Dim mNumeroCertificadoPercepcionIIBB As Long
    '    Dim mParteDolar As Double, mPartePesos As Double, mKilos As Double, mBonificacion As Double, mPrecioUnitario As Double, mCantidad As Double, mTopeIIBB As Double
    '    Dim mPorcentajeIva As Double, mImporteIVA As Double, mAuxD1 As Double, mAuxD2 As Double, mAuxD3 As Double
    '    Dim mCodigoProvincia As String, mPuntoVentaActivo As String
    '    Dim mvarAplicarIVANoDiscriminado As Boolean
    '    Dim mFecha1 As Date

    '    mvarSubTotal = 0
    '    mvarIBrutos = 0
    '    mvarIBrutos2 = 0
    '    mvarIBrutos3 = 0
    '    mvarPorcentajeIBrutos = 0
    '    mvarPorcentajeIBrutos2 = 0
    '    mvarPorcentajeIBrutos3 = 0
    '    mvar_IBrutos_Cap = 0
    '    mvar_IBrutos_BsAs = 0
    '    mvar_IBrutos_BsAsM = 0
    '    mvarMultilateral = "NO"
    '    mvarIVA1 = 0
    '    mvarIVA2 = 0
    '    mvarTotalFactura = 0
    '    mvarParteDolares = 0
    '    mvarPartePesos = 0
    '    mvarImporteBonificacion = 0
    '    mvarNetoGravado = 0
    '    mvarPorcentajeBonificacion = 0
    '    mvarIVANoDiscriminado = 0
    '    mIdProvinciaIIBB = 0
    '    mNumeroCertificadoPercepcionIIBB = 0
    '    mvarPercepcionIVA = 0
    '    mvarAjusteIVA = 0
    '    mPuntoVentaActivo = ""

    '    If IsNumeric(txtPorcentajeBonificacion.Text) Then mvarPorcentajeBonificacion = Val(txtPorcentajeBonificacion.Text)

    '    If glbIdCodigoIva = 1 Then
    '        If mvarTipoIVA = 1 Or mvarTipoIVA = 2 Then
    '            mvarAplicarIVANoDiscriminado = False
    '        ElseIf mvarTipoIVA = 3 Or mvarTipoIVA = 8 Or mvarTipoIVA = 9 Then
    '            mvarAplicarIVANoDiscriminado = False
    '        Else
    '            mvarAplicarIVANoDiscriminado = True
    '        End If
    '    Else
    '        mvarAplicarIVANoDiscriminado = False
    '    End If



    '    For Each oL In Lista.ListItems
    '        With origen.DetFacturas.Item(oL.Tag)
    '            If Not .Eliminado Then
    '                mPrecioUnitario = IIf(IsNull(.Registro.Fields("PrecioUnitario").Value), 0, .Registro.Fields("PrecioUnitario").Value)
    '                mCantidad = IIf(IsNull(.Registro.Fields("Cantidad").Value), 0, .Registro.Fields("Cantidad").Value)
    '                mBonificacion = IIf(IsNull(.Registro.Fields("Bonificacion").Value), 0, .Registro.Fields("Bonificacion").Value)
    '                mPorcentajeIva = IIf(IsNull(.Registro.Fields("PorcentajeIva").Value), 0, .Registro.Fields("PorcentajeIva").Value)

    '                If mvarTipoIVA = 3 Or mvarTipoIVA = 8 Or mvarTipoIVA = 9 Then mPorcentajeIva = 0
    '                mAuxD1 = Round(mCantidad * mPrecioUnitario * (1 - mBonificacion / 100) + 0.0001, 2)
    '                mAuxD2 = mAuxD1 - Round(mAuxD1 * mvarPorcentajeBonificacion / 100, 2)

    '                If Not mvarAplicarIVANoDiscriminado Then
    '                    mImporteIVA = Round(mAuxD2 * mPorcentajeIva / 100, 4)
    '                Else
    '                    mImporteIVA = Round(mAuxD2 - (mAuxD2 / (1 + (mPorcentajeIva / 100))), 4)
    '                End If

    '                .Registro.Fields("PorcentajeIVA").Value = mPorcentajeIva
    '                .Registro.Fields("ImporteIVA").Value = mImporteIVA

    '                oL.SubItems(10) = "" & mPorcentajeIva
    '                oL.SubItems(11) = "" & Format(mImporteIVA, "#,##0.00")

    '                mvarIVA1 = mvarIVA1 + mImporteIVA
    '                mvarSubTotal = mvarSubTotal + mAuxD1
    '            End If
    '        End With
    '    Next


    '    If mvarId > 0 Then
    '        With origen.Registro
    '            mvarTipoABC = IIf(IsNull(.Fields("TipoABC").Value), "", .Fields("TipoABC").Value)
    '            mvarPuntoVenta = IIf(IsNull(.Fields("PuntoVenta").Value), mvarPuntoVentaDefault, .Fields("PuntoVenta").Value)
    '            mvarTotalFactura = .Fields("ImporteTotal").Value
    '            mvarIVA1 = IIf(IsNull(.Fields("ImporteIva1").Value), 0, .Fields("ImporteIva1").Value)
    '            mvarIVA2 = IIf(IsNull(.Fields("ImporteIva2").Value), 0, .Fields("ImporteIva2").Value)
    '            mvarIVANoDiscriminado = IIf(IsNull(.Fields("IVANoDiscriminado").Value), 0, .Fields("IVANoDiscriminado").Value)
    '            mvarIBrutos = IIf(IsNull(.Fields("RetencionIBrutos1").Value), 0, .Fields("RetencionIBrutos1").Value)
    '            mvarPorcentajeIBrutos = IIf(IsNull(.Fields("PorcentajeIBrutos1").Value), 0, .Fields("PorcentajeIBrutos1").Value)
    '            mvarIBrutos2 = IIf(IsNull(.Fields("RetencionIBrutos2").Value), 0, .Fields("RetencionIBrutos2").Value)
    '            mvarPorcentajeIBrutos2 = IIf(IsNull(.Fields("PorcentajeIBrutos2").Value), 0, .Fields("PorcentajeIBrutos2").Value)
    '            mvarMultilateral = IIf(IsNull(.Fields("ConvenioMultilateral").Value), 0, .Fields("ConvenioMultilateral").Value)
    '            mvarIBrutos3 = IIf(IsNull(.Fields("RetencionIBrutos3").Value), 0, .Fields("RetencionIBrutos3").Value)
    '            mvarPorcentajeIBrutos3 = IIf(IsNull(.Fields("PorcentajeIBrutos3").Value), 0, .Fields("PorcentajeIBrutos3").Value)
    '            mvarParteDolares = IIf(IsNull(.Fields("ImporteParteEnDolares").Value), 0, .Fields("ImporteParteEnDolares").Value)
    '            mvarPartePesos = IIf(IsNull(.Fields("ImporteParteEnPesos").Value), 0, .Fields("ImporteParteEnPesos").Value)
    '            mvarImporteBonificacion = IIf(IsNull(.Fields("ImporteBonificacion").Value), 0, .Fields("ImporteBonificacion").Value)
    '            mvarPorcentajeBonificacion = IIf(IsNull(.Fields("PorcentajeBonificacion").Value), 0, .Fields("PorcentajeBonificacion").Value)
    '            mvarPercepcionIVA = IIf(IsNull(.Fields("PercepcionIVA").Value), 0, .Fields("PercepcionIVA").Value)
    '            mvarAjusteIVA = IIf(IsNull(.Fields("AjusteIVA").Value), 0, .Fields("AjusteIVA").Value)
    '        End With
    '    Else
    '        mvarImporteBonificacion = Round(mvarSubTotal * mvarPorcentajeBonificacion / 100, 2)
    '        mvarNetoGravado = mvarSubTotal - mvarImporteBonificacion
    '        mPuntoVentaActivo = "SI"

    '        '      If mvarIBrutosC = "S" And mvarPorc_IBrutos_Cap <> 0 And mvarNetoGravado > mvarTope_IBrutos_Cap Then
    '        '         mvar_IBrutos_Cap = Round(mvarPorc_IBrutos_Cap * mvarNetoGravado / 100, mvarDecimales)
    '        '      End If
    '        '
    '        '      If mvarIBrutosB = "S" Then
    '        '         If mvarMultilateral = "S" Then
    '        '            If mvarPorc_IBrutos_BsAs <> 0 And mvarNetoGravado > mvarTope_IBrutos_BsAs Then
    '        '               mvar_IBrutos_BsAs = Round(mvarPorc_IBrutos_BsAs * mvarNetoGravado / 100, mvarDecimales)
    '        '            End If
    '        '         Else
    '        '            If mvarPorc_IBrutos_BsAsM <> 0 And mvarNetoGravado > mvarTope_IBrutos_BsAsM Then
    '        '               mvar_IBrutos_BsAsM = Round(mvarPorc_IBrutos_BsAsM * mvarNetoGravado / 100, mvarDecimales)
    '        '            End If
    '        '         End If
    '        '      End If

    '        If glbIdCodigoIva = 1 Then
    '            Select Case mvarTipoIVA
    '                Case 1
    '                    'mvarIVA1 = Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
    '                    mvarTipoABC = "A"
    '                Case 2
    '                    'mvarIVA1 = Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
    '                    mvarIVA2 = Round(mvarNetoGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
    '                    mvarTipoABC = "A"
    '                Case 3
    '                    mvarTipoABC = "E"
    '                Case 8
    '                    mvarTipoABC = "B"
    '                Case 9
    '                    mvarTipoABC = "A"
    '                Case Else
    '                    'mvarIVANoDiscriminado = Round(mvarNetoGravado - (mvarNetoGravado / (1 + (Val(txtPorcentajeIva1.Text) / 100))), mvarDecimales)
    '                    mvarIVANoDiscriminado = mvarIVA1
    '                    mvarIVA1 = 0
    '                    mvarTipoABC = "B"
    '            End Select
    '        Else
    '            mvarTipoABC = "C"
    '        End If
    '        If mvarTipoABC = "A" And glbModalidadFacturacionAPrueba Then mvarTipoABC = "M"





    '        origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = Null
    '        If dcfields(4).Enabled And Check1(0).Value = 1 And IsNumeric(dcfields(4).BoundText) Then
    '            oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(4).BoundText)
    '            If oRs.RecordCount > 0 Then
    '                mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
    '                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
    '                mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
    '        mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Date, oRs.Fields("FechaVigencia").Value)
    '                mCodigoProvincia = ""
    '                oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
    '                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
    '                oRs1.Close()
    '                If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
    '                    mvarPorcentajeIBrutos = mAlicuotaDirecta
    '                ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
    '                    mvarPorcentajeIBrutos = mAlicuotaDirectaCapital
    '                Else
    '                    If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
    '                        If mvarIBCondicion = 2 Then
    '                            mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
    '                            mvarMultilateral = "SI"
    '                        Else
    '                            mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
    '                        End If
    '                    End If
    '                End If
    '                mvarIBrutos = Round(mvarNetoGravado * mvarPorcentajeIBrutos / 100, 2) 'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
    '            End If
    '            oRs.Close()
    '            If mvarIBrutos <> 0 Then
    '                oRs = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaIIBB)
    '                If oRs.RecordCount > 0 Then
    '                    mNumeroCertificadoPercepcionIIBB = IIf(IsNull(oRs.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, oRs.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
    '                End If
    '                oRs.Close()
    '                origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = mNumeroCertificadoPercepcionIIBB
    '            End If
    '            oRs = Nothing
    '        End If


    '        If dcfields(5).Enabled And Check1(1).Value = 1 And IsNumeric(dcfields(5).BoundText) Then
    '            oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(5).BoundText)
    '            If oRs.RecordCount > 0 Then
    '                mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
    '                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
    '                mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
    '                mCodigoProvincia = ""
    '                oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
    '                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
    '                oRs1.Close()
    '                If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
    '                    mvarPorcentajeIBrutos2 = mAlicuotaDirecta
    '                ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
    '                    mvarPorcentajeIBrutos2 = mAlicuotaDirectaCapital
    '                Else
    '                    If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
    '                        If mvarIBCondicion = 2 Then
    '                            mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
    '                            mvarMultilateral = "SI"
    '                        Else
    '                            mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
    '                        End If
    '                    End If
    '                End If
    '                mvarIBrutos2 = Round(mvarNetoGravado * mvarPorcentajeIBrutos2 / 100, 2)  'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)
    '            End If
    '            oRs.Close()
    '            oRs = Nothing
    '        End If

    '        If dcfields(6).Enabled And Check1(2).Value = 1 And IsNumeric(dcfields(6).BoundText) Then
    '            oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(6).BoundText)
    '            If oRs.RecordCount > 0 Then
    '                mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
    '                mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
    '                mIdProvinciaRealIIBB = IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value)
    '                mCodigoProvincia = ""
    '                oRs1 = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaRealIIBB)
    '                If oRs1.RecordCount > 0 Then mCodigoProvincia = IIf(IsNull(oRs1.Fields("InformacionAuxiliar").Value), "", oRs1.Fields("InformacionAuxiliar").Value)
    '                oRs1.Close()
    '                If mCodigoProvincia = "902" And DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
    '                    mvarPorcentajeIBrutos3 = mAlicuotaDirecta
    '                ElseIf mCodigoProvincia = "901" And DTFields(0).Value >= mFechaInicioVigenciaIBDirectoCapital And DTFields(0).Value <= mFechaFinVigenciaIBDirectoCapital Then
    '                    mvarPorcentajeIBrutos3 = mAlicuotaDirectaCapital
    '                Else
    '                    If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
    '                        If mvarIBCondicion = 2 Then
    '                            mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
    '                            mvarMultilateral = "SI"
    '                        Else
    '                            mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
    '                        End If
    '                    End If
    '                End If
    '                mvarIBrutos3 = Round(mvarNetoGravado * mvarPorcentajeIBrutos3 / 100, 2)  'Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)
    '            End If
    '            oRs.Close()
    '            oRs = Nothing
    '        End If

    '        If mvarEsAgenteRetencionIVA = "NO" And mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA Then
    '            mvarPercepcionIVA = Round(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
    '        End If

    '        mvarPuntoVenta = 0
    '        If IsNumeric(dcfields(10).BoundText) Then mvarPuntoVenta = dcfields(10).BoundText
    '        If mvarNumeracionUnica And mvarTipoABC <> "E" Then
    '            oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC, mPuntoVentaActivo))
    '        Else
    '            oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC, mPuntoVentaActivo))
    '        End If
    '        If oRs.RecordCount = 1 Then
    '            oRs.MoveFirst()
    '            mvarPuntoVenta = oRs.Fields(0).Value
    '            If mvarId <= 0 Then
    '                origen.Registro.Fields("NumeroFactura").Value = oRs.Fields("ProximoNumero").Value
    '                txtNumeroFactura.Text = oRs.Fields("ProximoNumero").Value
    '            End If
    '        End If
    '        dcfields(10).RowSource = oRs
    '        dcfields(10).BoundText = mvarPuntoVenta
    '        oRs = Nothing

    '        If Len(dcfields(10).Text) = 0 Then
    '            origen.Registro.Fields("NumeroFactura").Value = Null
    '            txtNumeroFactura.Text = ""
    '        Else
    '            If mvarId <= 0 Then
    '                oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", mvarPuntoVenta)
    '                If oRs.RecordCount > 0 Then mvarAgentePercepcionIIBBPuntoVenta = IIf(IsNull(oRs.Fields("AgentePercepcionIIBB").Value), "", oRs.Fields("AgentePercepcionIIBB").Value)
    '                oRs.Close()
    '            End If
    '        End If

    '        mvarAjusteIVA = Val(txtTotal(12).Text)
    '        mvarTotalFactura = mvarNetoGravado + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 + mvarIBrutos3 + mvarPercepcionIVA + Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text) + mvarAjusteIVA
    '    End If

    '    If mvarTipoABC = "E" Then
    '        If Not cmd(3).Enabled Then cmd(3).Enabled = True
    '        lblLabels(14).Visible = True
    '        Combo1(0).Visible = True
    '        Frame3.Visible = True
    '    Else
    '        If cmd(3).Enabled Then cmd(3).Enabled = False
    '        lblLabels(14).Visible = False
    '        Combo1(0).Visible = False
    '        Frame3.Visible = False
    '    End If
    '    lblLetra.Caption = mvarTipoABC

    '    txtTotal(3).Text = Format(mvarSubTotal, "#,##0.00")
    '    txtTotal(9).Text = Format(mvarImporteBonificacion, "#,##0.00")
    '    txtTotal(4).Text = Format(mvarIVA1, "#,##0.00")
    '    txtTotal(5).Text = Format(mvarIBrutos + mvarIBrutos2 + mvarIBrutos3, "#,##0.00")
    '    txtTotal(11).Text = Format(mvarPercepcionIVA, "#,##0.00")
    '    txtTotal(8).Text = Format(mvarTotalFactura, "#,##0.00")

    '    MostrarTotales()

    '    oRs = Nothing
    '    oRs1 = Nothing

    'End Sub




    Public Shared Sub AgregarMensajeProcesoPresto(ByRef oRsErrores As ADODB.Recordset, ByVal Mensaje As String)

        'oRsErrores.AddNew()
        'oRsErrores.Fields(0).Value = 0
        'oRsErrores.Fields(1).Value = Mensaje
        'oRsErrores.Update()

    End Sub


    Shared Function CAIsegunPuntoVenta(ByVal Letra As String, ByVal puntoVenta As Long, ByVal SC As String) As String
        Try

            Dim mvarPuntoVenta = EntidadManager.TablaSelectId(SC, "PuntosVenta", "PuntoVenta=" & puntoVenta & " AND Letra='" & Letra & "'")

            Dim mvarCAI_v, mvarFechaCAI_v As String

            '"SELECT NumeroCAI_C_A from PuntosVenta where
            'oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(10).BoundText)
            Select Case Letra
                Case "A"
                    mvarCAI_v = "NumeroCAI_F_A"
                    mvarFechaCAI_v = "FechaCAI_F_A"
                Case "B"
                    mvarCAI_v = "NumeroCAI_F_B"
                    mvarFechaCAI_v = "FechaCAI_F_B"
                Case "E"
                    mvarCAI_v = "NumeroCAI_F_E"
                    mvarFechaCAI_v = "FechaCAI_F_E"
            End Select

            CAIsegunPuntoVenta = EntidadManager.TablaSelect(SC, mvarCAI_v, "PuntosVenta", "IdPuntoVenta", mvarPuntoVenta)
            Return CAIsegunPuntoVenta

        Catch ex As Exception
            ErrHandler2.WriteError("No se encontró el CAI para PuntoVenta=" & puntoVenta & " AND Letra='" & Letra & "'")
            Return ""
        End Try


        'mvarCAI = ""
        'mvarFechaCAI = DateSerial(2000, 1, 1)
        'If Len(mvarCAI_v) > 0 Then
        '    If Not IsNull(oRs.Fields(mvarCAI_v).Value) Then mvarCAI = oRs.Fields(mvarCAI_v).Value
        '    If Not IsNull(oRs.Fields(mvarFechaCAI_v).Value) Then mvarFechaCAI = oRs.Fields(mvarFechaCAI_v).Value
        'End If
        'mWS = IIf(IsNull(oRs.Fields("WebService").Value), "", oRs.Fields("WebService").Value)
        'mModoTest = IIf(IsNull(oRs.Fields("WebServiceModoTest").Value), "", oRs.Fields("WebServiceModoTest").Value)
        'oRs.Close()
        'oRs = Nothing
        'If Len(mvarCAI_v) > 0 And DTFields(0).Value > mvarFechaCAI Then
        '    MsgBox("El CAI vencio el " & mvarFechaCAI & ", no puede grabar el comprobante", vbExclamation)
        '    Exit Function
        'End If
    End Function

    Shared Function LetraSegunTipoIVA(ByVal mvarTipoIVA As Long) As String
        Dim mvarTipoABC As String
        'If Session("glbIdCodigoIva") = 1 Then
        If True Then
            Select Case mvarTipoIVA
                Case 1
                    'acá calcula el iva usando el neto total. por qué no lo hace por item como corresponde?
                    'mvarIVA1 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                    'mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                    mvarTipoABC = "A"
                Case 2
                    'acá calcula el iva usando el neto total. por qué no lo hace por item como corresponde?
                    'mvarIVA1 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                    'mvarIVA2 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
                    'mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales) + _
                    'Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
                    mvarTipoABC = "A"
                Case 3
                    mvarTipoABC = "E"
                Case 8
                    mvarTipoABC = "B"
                Case 9
                    mvarTipoABC = "A"
                Case Else
                    'mvarIVANoDiscriminado = Math.Round(mvarNetoGravado - (mvarNetoGravado / (1 + (Val(txtPorcentajeIva1.Text) / 100))), mvarDecimales)
                    mvarTipoABC = "B"
            End Select
        Else
            mvarTipoABC = "C"
        End If

        Return mvarTipoABC
    End Function


    Shared Sub FormatearFacturaSegunSeSepareONoSeparador_Leyenda_Corredor_Separador(ByRef oListaCDP As System.Collections.Generic.List(Of Pronto.ERP.BO.CartaDePorte), ByRef oFac As Object, ByRef IdClienteAFacturarle As Long, ByVal SeSeparaPorCorredor As Boolean, ByVal sc As String, ByVal txtCorredor As String, ByVal chkPagaCorredor As Boolean)
        Dim listaPresentesEnEstaFactura As New Generic.List(Of String)


        For Each i In oListaCDP
            If False Then
                If Not _DEBUG_FACTURACION_PRECIOS Then
                    CartaDePorteManager.ActualizarPrecioFacturado(sc, i.Id, i.TarifaCobradaAlCliente) 'esto es cualquiera...
                End If
            End If

            If SeSeparaPorCorredor Then
                listaPresentesEnEstaFactura.Add(EntidadManager.NombreVendedor(sc, i.Corredor)) 'observaciones del encabezado
            Else
                listaPresentesEnEstaFactura.Add(EntidadManager.NombreCliente(sc, i.Titular)) 'observaciones del encabezado
            End If

        Next

        'hago un distinct
        Dim strPresentesEnEstaFactura = Join(listaPresentesEnEstaFactura.Distinct.ToArray, ", ")

        '//////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////

        'If chkMostrarCorredoresApartadosEnObservaciones.checked Then
        'If Not (optFacturarA.SelectedValue = 3 And txtCorredor.Text = "") Then
        'Consulta 8081
        'Si le facturan al titular, el strPresentesEnEstaFactura tiene corredores. Lo muestro si solo hay uno, y si es separado
        'solo mostrarlo si está separado al corredor, o si se eligió explicitamente el corredor como filtro


        Dim flagForzar = False
        Dim VariosCorredores = False

        If txtCorredor <> "" Then            'filtraron por corredor explicitamente, así que lo muestro
            flagForzar = True
            VariosCorredores = False
        ElseIf strPresentesEnEstaFactura <> "" And listaPresentesEnEstaFactura.Distinct.Count <= 1 And strPresentesEnEstaFactura <> "varios" Then
            'capo, si NO está separando por corredor, listaPresentesEnEstaFactura tiene los titulares
            ' http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11500
            VariosCorredores = False

            'confirmo que el unico corredor presente esté separado             '-guarda, en ALABERN, FABREGA & CIA S.A. hay una coma, y pensó q eran varios corredores....
            If CartaDePorteManager.EsteCorredorSeleFacturaAlClientePorSeparadoId(IdClienteAFacturarle, oListaCDP(0).Corredor, sc) > 0 Then
                flagForzar = True
            End If
        Else
            'mas de un corredor, no se imprime la obsevacion
            VariosCorredores = True
        End If



        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '        http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8531
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultasCumplidos1.php?recordid=10392
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11500
        'https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=56385


        '        Hay inconvenientes con la impresión del corredor en la factura (y grabación del mismo en la factura para el Pronto):

        '*      En facturas confeccionadas con el automático se imprime el Corredor para Clientes que no tienen al Corredor en el 
        '  campo \"Separar a\" (EJ: 2-46652;3-22564;4-595;4-647;1-23010;3-22939;2-46779)
        '   al cliente "BEN TEVI" se le facturó, y en esa factura dice corredor "ZENI", y el cliente tiene vacío el "separar a"

        '
        '*      Aparentemente sucede lo mismo con la facturación manual (sin que el Cliente tenga al Corredor en \"Separar a\" ni 
        '  tampoco se haya elegido un Corredor en el paso 1) No me dieron ejemplos de este tema
        '
        '*      También comentan que sucede lo contrario: en casos que el Cliente tiene un Corredor en el campo \"Separar a\" la 
        'factura se separa pero no sale impreso.

        'Este tema es importante porque que en la factura aparezca el corredor implica que esta se debe cobrar al mismo y deben 
        'tener registro de cuales son.
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        'todo:
        'que pasa cuando se imprime manualmente, y la separacion es implicita? creo recordar que era una excepcion.... o
        'por lo menos había excepciones, no sé si esta... quiero decir, que era un matete


        LogPronto(sc, -1, "FactWilliamsObs " & flagForzar & " " & VariosCorredores & " " & SeSeparaPorCorredor & "  " & chkPagaCorredor & "  " & strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle & " - " & txtCorredor, "")



        Dim idvend As Integer



        'chkpagacorredor esta siempre prendido. O sea que el corredor puede no haber sido filtrador explicitado, ni estar como separado en la configuracion del cliente, y 
        'con tener un nombre distinto que el cliente, ya aparece en las observaciones!


        If flagForzar Then ' Or (SeSeparaPorCorredor And chkPagaCorredor And Not VariosCorredores) Then
            'solo un detalle, no hay que aclarar nunca en el encabezado si se está separando a un titular,
            ' en todo caso ellos elegiran que en el detalle se imprima el titular en cada renglon

            If strPresentesEnEstaFactura <> NombreCliente(sc, IdClienteAFacturarle) Then
                'solo pongo el corredor cuando es uno solo


                'si lo haces así, basta conque haya un solo corredor en la factura que no sea el mismo cliente, para que aparezca en la observacion
                'pero tambien hay que verificar que esté separado en la configuracion



                If SeSeparaPorCorredor Then

                    oFac.Registro.Fields("Observaciones").Value = IIf(SeSeparaPorCorredor, "Corredor: ", "Titular: ") + strPresentesEnEstaFactura
                Else
                    'facturada a corredores, separada a titulares

                    'Factura Williams Separada por titular: True False  True  0  ALFA GRAIN S.R.L. para cliente 4883
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10392
                    'andy, por lo del corredor: cuando se elige facturar a corredores (o a terceros y este es corredor), se separa por titular. y es por esto q no aparece la observacion


                    LogPronto(sc, -1, "Factura Williams Separada por titular: " & flagForzar & " " &
                          SeSeparaPorCorredor & "  " & chkPagaCorredor & "  " & idvend & "  " &
                          strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle, "")
                End If


                'pero q paso entonces con el tema de la http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8997 ???
                'factura: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=39013
                'había más de un corredor???

            Else
                LogPronto(sc, -1, "Factura Williams sin corredor en obs. regla 2" & flagForzar & " " & SeSeparaPorCorredor & "  " & chkPagaCorredor & "  " & idvend & "  " & strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle, "")
            End If

            idvend = BuscaIdVendedorPreciso(strPresentesEnEstaFactura, sc)
            oFac.Registro.Fields("IdVendedor").Value = idvend

            LogPronto(sc, -1, "IdVendedor usado en factura Williams " & idvend & strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle, "")


        Else

            LogPronto(sc, -1, "Factura Williams sin corredor en obs. regla 2" & flagForzar & " " & SeSeparaPorCorredor & "  " & chkPagaCorredor & "  " & idvend & "  " & strPresentesEnEstaFactura & " para cliente " & IdClienteAFacturarle, "")

        End If

    End Sub


    Shared Function SQLSTRING_FacturacionCartas_por_Titular(ByVal sWHEREadicional As String, ByVal sc As String, sesionid As String) As DataTable

        '///////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////
        'agregar automatico por campo "Titular"
        '///////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////







        Dim strSQL =
"        SELECT DISTINCT 0 as ColumnaTilde " &
",IdCartaDePorte, CDP.IdArticulo,       " &
"        NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion, FechaArribo, FechaDescarga, " &
" CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA " &
"             		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA " &
" 		  ,CLIVEN.CUIT,           '' as ClienteSeparado , " &
" 		 dbo.wTarifaWilliams(CLIVEN.idcliente,CDP.IdArticulo,CDP.Destino, case when isnull(Exporta,'NO')='SI' then 1 else 0 end,0) as TarifaFacturada    " &
"        ,Articulos.Descripcion as  Producto, " &
"        NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,            " &
" 		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,    " &
" 		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],     " &
" 		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " &
" 		 ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino, CDP.AgregaItemDeGastosAdministrativos " &
"   from CartasDePorte CDP " &
" inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion='" & sesionid & "'" &
"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " &
"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios " &
"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " &
"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " &
"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " &
"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " &
"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " &
"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " &
"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " &
"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " &
"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " &
"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " &
"   where isnull(CDP.IdClienteAFacturarle,-1) <= 0 "




        strSQL += sWHEREadicional




        Try
            Dim dt = EntidadManager.ExecDinamico(sc, strSQL)
            Return dt

        Catch ex As Exception
            'se estaria quejando porque en el IN (123123,4444,......) hay una banda de ids
            MandarMailDeError(" Falta un indice en wGrillaPersistencia. Lo volaron en alguna actualizacion??. O se estaria quejando porque en el IN (123123,4444,......) hay una banda de ids   " + ex.ToString)


            Throw

            '        http://stackoverflow.com/questions/7804201/sql-server-query-processor-ran-out-of-internal-resources

            '        /ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados
            'User:       factsl()
            '            Exception(Type) : System.Data.SqlClient.SqlException()
            'Message:	Internal Query Processor Error: The query processor ran out of stack space during query optimization.
            'Stack Trace:	 at Microsoft.VisualBasic.CompilerServices.Symbols.Container.InvokeMethod(Method TargetProcedure, Object[] Arguments, Boolean[] CopyBack, BindingFlags Flags)
            'at Microsoft.VisualBasic.CompilerServices.NewLateBinding.CallMethod(Container BaseReference, String MethodName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, BindingFlags InvocationFlags, Boolean ReportErrors, ResolutionFailure& Failure)
            'at Microsoft.VisualBasic.CompilerServices.NewLateBinding.LateCall(Object Instance, Type Type, String MemberName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, Boolean IgnoreReturn)
            'at Pronto.ERP.Dal.GeneralDB.ExecDinamico(String SC, String comandoSQLdinamico, Int32 timeoutSegundos) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 300
            'at Pronto.ERP.Bll.EntidadManager.ExecDinamico(String SC, String sComandoDinamico, Int32 timeoutSegundos) in C:\Backup\BDL\BussinessLogic\EntidadManager.vb:line 358
            'at LogicaFacturacion.SQLSTRING_FacturacionCartas_por_Titular(String sWHEREadicional, String sc, String sesionid)
            'at LogicaFacturacion.generarTablaParaModosNoAutomaticos(String sc, StateBag ViewState, String sLista, String sWHEREadicional, Int64 optFacturarA, String txtFacturarATerceros, String HFSC, String txtTitular, String txtCorredor, String txtDestinatario, String txtIntermediario, String txtRcomercial, String txt_AC_Articulo, String txtProcedencia, String txtDestino, String txtBuscar, String cmbCriterioWHERE, String cmbmodo, String optDivisionSyngenta, String txtFechaDesde, String txtFechaHasta, String cmbPuntoVenta, String sesionId, Int64 startRowIndex, Int64 maximumRows, String txtclienteauxiliar, String& sErrores)

        End Try


    End Function









    '    Shared Function ListaUsandoAsignacionAutomatica(Optional ByVal sWHEREadicional As String = "") As String

    '        'sin cliente automatico
    '        'Si una Carta de Porte no tiene ningún cliente que tenga marcado en que si aparece en 
    '        'esa posición se le debe facturar, entonces se le facturará al 
    '        'Titular (De cualquier manera mostrar una advertencia de que se está tomando el Titular porque no hay otro cliente definido)

    '        '        'mas de un cliente posible
    '        'Si una Carta de Porte tiene más de un cliente que están en una posición en la cuál se le debe 
    '        'facturar, entonces advertir y preguntar a quién se factura. Si se debe facturar a más de un 
    '        'cliente, se deben seguir los pasos para crear copias de la Carta de Porte.

    '        '        'duplicada con cliente explicito. Qué hacer si en estos casos tambien hay un juego de cliente?
    '        'Si una Carta de Porte está duplicada porque se debe facturar a más de 
    '        'un cliente, aparecerá tantas veces como copias haya y cada una se facturará 
    '        'a nombre del cliente elegido en ellas. Mostrar el subnúmero. (Ver más abajo)



    '        Dim strSQL = "select distinct * from (  "

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "Titular"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////


    '        strSQL &= _
    '"        SELECT DISTINCT 0 as ColumnaTilde " & _
    '",IdCartaDePorte, CDP.IdArticulo,       " & _
    '"        NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion, FechaArribo, FechaDescarga, " & _
    '" CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA " & _
    '"             		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA " & _
    '" 		  ,CLIVEN.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0.0 as TarifaFacturada    " & _
    ' "        ,Articulos.Descripcion as  Producto, " & _
    '  "        NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,            " & _
    '" 		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,    " & _
    '" 		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],     " & _
    '" 		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '" 		 ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    '"   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '"   where CLIVEN.SeLeFacturaCartaPorteComoTitular='SI' " & _
    '           "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 " & _
    '           " and isnull(IdFacturaImputada,0)<=0 "



    '        ' strSQL += sWHEREadicional


    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "Intermediario (CLICO1)"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////


    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '        "   NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLICO1.razonsocial as FacturarselaA,  CLICO1.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLICO1.Confirmado,'NO') as Confirmado,           CLICO1.IdCodigoIVA " & _
    '"   		  ,CLICO1.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '        "   ,Articulos.Descripcion as  Producto, " & _
    '         "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,     CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,           " & _
    '   "   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '   "   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '   "   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '                   "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO1.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    '"   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '                "   where CLICO1.SeLeFacturaCartaPorteComoIntermediario='SI'" & _
    '        "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 "




    '        'strSQL += sWHEREadicional

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "RemComercial (CLICO2)"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////


    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '"   NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLICO2.razonsocial as FacturarselaA,  CLICO2.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLICO2.Confirmado,'NO') as Confirmado,           CLICO2.IdCodigoIVA " & _
    '"   		  ,CLICO2.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,            " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO2.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    ' "   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '       "   where CLICO2.SeLeFacturaCartaPorteComoRemComercial='SI'" & _
    '        "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 " & _
    '           " and isnull(IdFacturaImputada,0)<=0 "





    '        ' strSQL += sWHEREadicional

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "Destinatario"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////

    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '"   NumeroCartaDePorte, SubNumeroVagon  ,CDP.SubnumeroDeFacturacion , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA " & _
    '"   		  ,CLIENT.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIENT.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    '"   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '        "   where CLIENT.SeLeFacturaCartaPorteComoDestinatario='SI'" & _
    '        "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 " & _
    '           " and isnull(IdFacturaImputada,0)<=0 "





    '        '        strSQL += sWHEREadicional

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar automatico por campo "Corredor"
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////

    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '"   NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLICORCLI.razonsocial as FacturarselaA,  CLICORCLI.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLICORCLI.Confirmado,'NO') as Confirmado,           CLICORCLI.IdCodigoIVA " & _
    '"   		  ,CLICORCLI.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,  CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,              " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICORCLI.idListaPrecios = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    ' "   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '       "   where CLICORCLI.SeLeFacturaCartaPorteComoCorredor='SI'" & _
    '        "   and isnull(CDP.IdClienteAFacturarle,-1) <= 0 " & _
    '           " and isnull(IdFacturaImputada,0)<=0 "






    '        'strSQL += sWHEREadicional

    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar los duplicados con cliente facturable explícito   -por qué esta dos veces? 
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////

    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,IdCartaDePorte, CDP.IdArticulo, " & _
    '"   NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , FechaArribo,        FechaDescarga  ,   " & _
    '"   CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA " & _
    '"   		  ,CLIENT.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,      CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,          " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDP.IdClienteAFacturarle = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    ' "   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '       "   where CDP.IdClienteAFacturarle > 0 "

    '        'strSQL += sWHEREadicional



    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        'agregar los duplicados con cliente facturable explícito   -por qué esta dos veces?
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////
    '        '///////////////////////////////////////////////////////////////////////////////////////////

    '        strSQL += _
    '"           union " & _
    '"   SELECT DISTINCT 0 as ColumnaTilde " & _
    '"   ,CDPduplicadas.IdCartaDePorte, CDP.IdArticulo, " & _
    '"   CDP.NumeroCartaDePorte, CDP.SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , CDP.FechaArribo,        CDP.FechaDescarga  ,   " & _
    '"   CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA " & _
    '"   	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA " & _
    '"   		  ,CLIENT.CUIT,           '' as ClienteSeparado , " & _
    '" 		 0 as TarifaFacturada    " & _
    '"   ,Articulos.Descripcion as  Producto, " & _
    ' "   CDP.NetoFinal  as  KgNetos , CDP.Corredor as IdCorredor, CDP.Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,       " & _
    '"   CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,   " & _
    '"   CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],    " & _
    '"   CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc " & _
    '           "   ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino " & _
    '"   from CartasDePorte CDP " & _
    '"   LEFT OUTER JOIN CartasDePorte CDPduplicadas ON CDP.NumeroCartaDePorte = CDPduplicadas.NumeroCartaDePorte and  CDP.SubNumeroVagon = CDPduplicadas.SubNumeroVagon and CDPduplicadas.SubnumeroDeFacturacion>0 " & _
    '"   LEFT OUTER JOIN Clientes CLIENT ON CDPduplicadas.IdClienteAFacturarle = CLIENT.IdCliente  " & _
    '"   LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios " & _
    '"   LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  " & _
    '"   LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  " & _
    '"   LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  " & _
    '"   LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  " & _
    '"   LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  " & _
    '"   LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  " & _
    '"   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  " & _
    '"   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  " & _
    '"   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  " & _
    '"   INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta " & _
    '"   where CDP.IdClienteAFacturarle > 0 "

    '        'strSQL += sWHEREadicional.Replace("IdCartaDePorte", "CDP.IdCartaDePorte")













    '        'TODO: como hacer un distinct de cartaporte-clientefacturado, despues de hacer el union? -pero por qué se repite el renglon, o
    '        'mejor dicho, qué tienen de distinto los repetidos? -El destino, la tarifa






    '        strSQL &= "    )  as CDP "



    '        If False Then
    '            strSQL += "WHERE 1=1 " & sWHEREadicional.Replace("IdCartaDePorte", "CDP.IdCartaDePorte")
    '        Else
    '            'strSQL += " INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta"
    '        End If


    '        Return strSQL






    '        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
    '        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
    '        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
    '        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
    '        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
    '        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
    '        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
    '        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
    '        'Dim idCuentaOrden1 = BuscaIdClientePreciso( txttxtDestinatario.Text, HFSC.Value)
    '        'Dim idCuentaOrden2 = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)



    '        Dim strWHERE As String = "    WHERE 1=1 "




    '        Dim QueContenga = txtBuscar.Text
    '        If QueContenga <> "" Then
    '            Dim idVendedorQueContiene = BuscaIdClientePreciso(QueContenga, HFSC.Value)
    '            Dim idCorredorQueContiene = BuscaIdVendedorPreciso(QueContenga, HFSC.Value)

    '            If idVendedorQueContiene <> -1 Or idCorredorQueContiene <> -1 Then

    '                strWHERE += "  " & _
    '                 "           AND (CDP.Vendedor = " & idVendedorQueContiene & _
    '                "           OR CDP.CuentaOrden1 = " & idVendedorQueContiene & _
    '                "           OR CDP.CuentaOrden2 = " & idVendedorQueContiene & _
    '                "             OR CDP.Entregador=" & idVendedorQueContiene & ")"



    '                'strWHERE += "  " & _
    '                ' "           AND (CDP.Vendedor = " & idVendedorQueContiene & _
    '                '"           OR CDP.CuentaOrden1 = " & idVendedorQueContiene & _
    '                '"           OR CDP.CuentaOrden2 = " & idVendedorQueContiene & _
    '                '"             OR CDP.Corredor=" & idCorredorQueContiene & _
    '                '"             OR CDP.Entregador=" & idVendedorQueContiene & ")"
    '            End If
    '        End If




    '        If cmbCriterioWHERE.SelectedValue = "todos" Then
    '            strWHERE += iisIdValido(idVendedor, "           AND CDP.Vendedor = " & idVendedor, "") & _
    '                            iisIdValido(idIntermediario, "             AND CDP.CuentaOrden1=" & idIntermediario, "") & _
    '                            iisIdValido(idRComercial, "             AND CDP.CuentaOrden2=" & idRComercial, "") & _
    '                            iisIdValido(idDestinatario, "             AND  CDP.Entregador=" & idDestinatario, "") & _
    '                            iisIdValido(idCorredor, "             AND  CDP.Corredor=" & idCorredor, "")
    '        Else
    '            Dim s = " AND (1=0 " & _
    '                             iisIdValido(idVendedor, "           OR CDP.Vendedor = " & idVendedor, "") & _
    '                            iisIdValido(idIntermediario, "             OR CDP.CuentaOrden1=" & idIntermediario, "") & _
    '                            iisIdValido(idRComercial, "             OR CDP.CuentaOrden2=" & idRComercial, "") & _
    '                            iisIdValido(idDestinatario, "             OR  CDP.Entregador=" & idDestinatario, "") & _
    '                            iisIdValido(idCorredor, "             OR  CDP.Corredor=" & idCorredor, "") & _
    '                               "  )  "

    '            If s <> " AND (1=0   )  " Then strWHERE += s
    '        End If

    '        strWHERE += iisIdValido(idCorredor, "             AND CDP.Corredor=" & idCorredor, "")
    '        strWHERE += iisIdValido(idArticulo, "           AND CDP.IdArticulo=" & idArticulo, "")
    '        strWHERE += iisIdValido(idProcedencia, "             AND CDP.Procedencia=" & idProcedencia, "")
    '        strWHERE += iisIdValido(idDestino, "             AND CDP.Destino=" & idDestino, "")







    '        If cmbModo.Text = "Local" Then
    '            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='NO'  "
    '        ElseIf cmbModo.Text = "Export" Then
    '            strWHERE += "  AND ISNULL(CDP.Exporta,'NO')='SI'  "
    '        End If



    '        strWHERE += " and isnull(CDP.EnumSyngentaDivision,'Agro')='" & optDivisionSyngenta.SelectedValue & "'"



    '        strWHERE += "    AND    NetoProc>0 AND ( (isnull(FechaDescarga,FechaArribo) Between '" & iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#) & "' AND '" & iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#) & "')  )  " & _
    '    "         AND (isnull(CDP.PuntoVenta," & cmbPuntoVenta.Text & ")=" & cmbPuntoVenta.Text & " OR CDP.PuntoVenta = 0)" & _
    '   "  AND ISNULL(IdFacturaImputada,-1)<=0 " & _
    '   "  "


    '        'iisIdValido(.Item("CuentaOrden2"), "         AND CDP.CuentaOrden2=" & .Item("CuentaOrden2"), "") & _

    '        strWHERE += sWHEREadicional
    '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "CDP.")


    '        'http://www.sqlteam.com/forums/topic.asp?TOPIC_ID=71950


    '        'strWHERE += " ORDER BY  " & facturarselaA & " ASC,NumeroCartaDePorte ASC " 'este explotaba en "a terceros", porque ponía ORDER 'PIRULO' ASC
    '        strWHERE += " ORDER BY  NumeroCartaDePorte ASC, FacturarselaA ASC "

    '        strSQL += strWHERE
    '        Debug.Print(strWHERE)

    '        Return strSQL

    '    End Function








    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    Public Shared Function PreviewDetalladoDeLaGeneracionEnPaso2(optFacturarA As Integer, txtFacturarATerceros As String, SC As String,
                                                   EsteUsuarioPuedeVerTarifa As Boolean, ViewState As Object, txtFechaDesde As String, txtFechaHasta As String,
                                                   fListaIDs As String, SessionID As String, cmbPuntoVenta As Integer, cmbAgruparArticulosPor As String,
                                                   SeEstaSeparandoPorCorredor As Boolean) As String

        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Empiezo")


        If optFacturarA = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros, SC)

            If IdFacturarselaA = -1 Then
                ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                Throw New Exception("Elija un cliente como tercero a facturarle")
                'MsgBoxAjax(Me, "Elija un cliente como tercero a facturarle")
                'Return
            End If
        End If



        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////

        'Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = ViewState("ListaIDsLongs")
        'Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
        '        Dim q = (From r In db.CartasDePortes _
        '               Where tildadosEnPrimerPasoLongs.Contains(r.IdCartaDePorte) _
        '               Select r.IdCartaDePorte, r.AgregaItemDeGastosAdministrativos).ToList

        Dim oo As DataTable

        Try
            Dim l = fListaIDs
            oo = ExecDinamico(SC, "select IdCartaDePorte,AgregaItemDeGastosAdministrativos  " &
                          " from CartasDePorte where AgregaItemDeGastosAdministrativos ='SI' AND  idCartaDePorte IN (-10," & IIf(l = "", "-10", l) & ")") ' , timeoutSegundos:=100)

        Catch ex As Exception
            'http://stackoverflow.com/questions/3641931/optimize-oracle-sql-with-large-in-clause
            'Create an index that covers 'field' and 'value'.
            'Place those IN values in a temp table and join on it.

            ErrHandler2WriteErrorLogPronto("Al llamar a esta a veces da timeout", SC, "")
            ErrHandler2.WriteAndRaiseError(ex)
        End Try




        Dim q = (From r In oo
                 Select IdCartaDePorte = CInt(iisNull(r("IdCartaDePorte"), -1)), AgregaItemDeGastosAdministrativos = CStr(iisNull(r("AgregaItemDeGastosAdministrativos"), ""))).ToList



        Dim output As String

        Dim sErr As String

        Dim tablaEditadaDeFacturasParaGenerar As DataTable

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta, #1/1/2100#)


        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2()  Levanto las cartas de la tanda")

        ViewState("pagina") = 1
        tablaEditadaDeFacturasParaGenerar = LogicaFacturacion.GetDatatableAsignacionAutomatica(SC, ViewState("pagina"), ViewState("sesionId"),
                                                                         999999, cmbPuntoVenta, fechadesde, fechahasta, sErr,
                                                                         cmbAgruparArticulosPor, ViewState("filas"),
                                                                         ViewState("slinks"), SessionID)



        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        'creo que es esto lo que tarda banda -Este tarda un poco, pero es el paso siguiente el que te mata! (el "Actualizo la tarifa")

        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Llamo a ActualizarCampoClienteSeparador")

        LogicaFacturacion.ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, SC, ViewState("sesionId"))




        '        Log Entry
        '05/02/2017 09:59:43
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message: PreviewDetalladoDeLaGeneracionEnPaso2()  Levanto las cartas de la tanda

        '        Log Entry
        '05/02/2017 09:59:44
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message: PreviewDetalladoDeLaGeneracionEnPaso2() Llamo a ActualizarCampoClienteSeparador

        '        Log Entry
        '05/02/2017 10:00:51
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message: PreviewDetalladoDeLaGeneracionEnPaso2() Actualizo la tarifa

        '        Log Entry
        '05/02/2017 10:09:47
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message: PreviewDetalladoDeLaGeneracionEnPaso2() Convierto a Excel

        '        Log Entry
        '05/02/2017 10:09:49
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message: PreviewDetalladoDeLaGeneracionEnPaso2() Se descarga



        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////


        Dim dt = tablaEditadaDeFacturasParaGenerar



        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Actualizo la tarifa")


        Dim IBNumInscrip As Dictionary(Of Integer, String)

        Using db As New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))
            IBNumInscrip = (From c In db.Clientes
                            Select c.IdCliente, c.IBNumeroInscripcion).ToDictionary(Function(x) x.IdCliente, Function(y) y.IBNumeroInscripcion)

        End Using

        dt.Columns.Add("Total", Type.GetType("System.Decimal"))
        dt.Columns.Add("NroIIBB", Type.GetType("System.String"))

        For Each row In dt.Rows
            row("Total") = row("KgNetos") * iisNull(row("TarifaFacturada"), 0) / 1000D

            Dim id As Integer = iisNull(row("IdCartaDePorte"), -1)
            Dim f = q.Find(Function(o) o.IdCartaDePorte = id)
            If Not IsNothing(f) Then
                If iisNull(f.AgregaItemDeGastosAdministrativos) = "SI" Then
                    row("FacturarselaA") = " <<CON COSTO ADMIN>> " & row("FacturarselaA")
                End If
            End If



            Try
                Dim ibnum As String
                IBNumInscrip.TryGetValue(row("IdFacturarselaA"), ibnum)
                row("NroIIBB") = ibnum
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


        Next



        'saco estas columnas que molestan en la presentacion
        'dt.Columns.Remove("Factura")
        'dt.Columns.Remove("idcorredorseparado")
        dt.Columns.Remove("ColumnaTilde")
        dt.Columns.Remove("IdCartaDePorte")
        dt.Columns.Remove("IdArticulo")
        dt.Columns.Remove("IdFacturarselaA")
        dt.Columns.Remove("IdDestino")
        dt.Columns.Remove("Confirmado")
        dt.Columns.Remove("IdCodigoIVA")
        dt.Columns.Remove("ClienteSeparado")

        If Not EsteUsuarioPuedeVerTarifa Then
            dt.Columns.Remove("TarifaFacturada")
            dt.Columns.Remove("Total")
        End If




        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////



        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////
        'Por ultimo, dejo que baje el excel completo sin filtrar
        '/////////////////////////////////////
        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Convierto a Excel")
        output = DataTableToExcel(dt)



        '        Log Entry
        '04/27/2017 15:10:49
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message: PreviewDetalladoDeLaGeneracionEnPaso2() Convierto a Excel
        '        __________________________()

        '        Log Entry
        '04/27/2017 15:10:49
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.IO.IOException
        'El archivo ya está abierto.
        '   at Microsoft.VisualBasic.FileSystem.FileOpen(Int32 FileNumber, String FileName, OpenMode Mode, OpenAccess Access, OpenShare Share, Int32 RecordLength)
        '   at LogicaFacturacion.DataTableToExcel(DataTable pDataTable, String titulo) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 8587
        '   at LogicaFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2(Int32 optFacturarA, String txtFacturarATerceros, String SC, Boolean EsteUsuarioPuedeVerTarifa, Object ViewState, String txtFechaDesde, String txtFechaHasta, String fListaIDs, String SessionID, Int32 cmbPuntoVenta, String cmbAgruparArticulosPor, Boolean SeEstaSeparandoPorCorredor) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 8571
        '        at CDPFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2()
        '   at CDPFacturacion.lnkVistaDetallada_Click(Object sender, EventArgs e)
        '   at System.Web.UI.WebControls.LinkButton.OnClick(EventArgs e)
        '   at System.Web.UI.WebControls.LinkButton.RaisePostBackEvent(String eventArgument)
        '   at System.Web.UI.WebControls.LinkButton.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
        '   at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
        '   at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
        '   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
        '        Microsoft.VisualBasic()
        '        __________________________()



        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Se descarga")








        Return output

    End Function



    Public Shared Function DataTableToExcel(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "") As String




        Dim vFileName As String = Path.GetTempFileName()
        'Dim vFileName As String = "c:\archivo.txt"



        Dim nF = FreeFile()
        Try

            FileOpen(nF, vFileName, OpenMode.Output)
        Catch ex As Exception
            '            Log Entry
            '04/27/2017 15:10:49
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.IO.IOException
            'El archivo ya está abierto.
            '   at Microsoft.VisualBasic.FileSystem.FileOpen(Int32 FileNumber, String FileName, OpenMode Mode, OpenAccess Access, OpenShare Share, Int32 RecordLength)
            '   at LogicaFacturacion.DataTableToExcel(DataTable pDataTable, String titulo) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 8587
            '   at LogicaFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2(Int32 optFacturarA, String txtFacturarATerceros, String SC, Boolean EsteUsuarioPuedeVerTarifa, Object ViewState, String txtFechaDesde, String txtFechaHasta, String fListaIDs, String SessionID, Int32 cmbPuntoVenta, String cmbAgruparArticulosPor, Boolean SeEstaSeparandoPorCorredor) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 8571

            ErrHandler2.WriteError("el problema de fileopen?")

            Throw
        End Try



        Dim sb As String = ""
        Dim dc As DataColumn
        For Each dc In pDataTable.Columns
            sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
        Next
        PrintLine(nF, sb)
        Dim i As Integer = 0
        Dim dr As DataRow
        For Each dr In pDataTable.Rows
            i = 0 : sb = ""
            For Each dc In pDataTable.Columns
                If Not IsDBNull(dr(i)) Then
                    Try
                        If IsNumeric(dr(i)) Then
                            sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        Else
                            sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        End If
                    Catch x As Exception
                        sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    End Try
                Else
                    sb &= Microsoft.VisualBasic.ControlChars.Tab
                End If
                i += 1
            Next
            PrintLine(nF, sb)
        Next


        FileClose(nF)



        Return TextToExcel(vFileName, titulo)
    End Function



    Public Shared Function TextToExcel(ByVal pFileName As String, Optional ByVal titulo As String = "") As String
        'Apartar estas funciones que usen Interop..... usar Open XML SDK
        'http://stackoverflow.com/questions/1405201/so-net-doesnt-have-built-in-office-functionality
        'http://stackoverflow.com/questions/1405201/so-net-doesnt-have-built-in-office-functionality
        'http://stackoverflow.com/questions/1405201/so-net-doesnt-have-built-in-office-functionality


        'EEPLUS
        'EEPLUS
        'http://epplus.codeplex.com/releases/view/67324
        'I'd view EPPlus as a ticking time bomb in your code if you're reading user-supplied files.....
        '-y si grabo como xlsx?
        'EEPLUS
        'EEPLUS



        Dim vFormato As Excel.XlRangeAutoFormat
        Dim Exc As Excel.Application = CreateObject("Excel.Application")
        Exc.Visible = False
        Exc.DisplayAlerts = False

        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        'importa el archivo de texto
        'Guarda con la configuracion regional. Si en el servidor está usando la coma (despues
        'de todo, no se usa el pronto en el servidor), lo importa mal
        'http://answers.yahoo.com/question/index?qid=20080917051138AAxit8S
        'http://msdn.microsoft.com/en-us/library/aa195814(office.11).aspx
        'http://www.newsgrupos.com/microsoft-public-es-excel/304517-problemas-con-comas-y-puntos-al-guardar-de-excel-un-archivo-txtmediante-vb.html

        Exc.Workbooks.OpenText(pFileName, , , , Excel.XlTextQualifier.xlTextQualifierNone, , True, , , , , , , , ".", ",")

        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////



        Dim Wb As Excel.Workbook = Exc.ActiveWorkbook
        Dim Ws As Excel.Worksheet = CType(Wb.ActiveSheet, Excel.Worksheet)


        'Se le indica el formato al que queremos exportarlo
        Dim valor As Integer = 10

        If valor > -1 Then
            Select Case (valor)
                Case 10 : vFormato = Excel.XlRangeAutoFormat.xlRangeAutoFormatClassic1
            End Select
            Ws.Range(Ws.Cells(1, 1), Ws.Cells(Ws.UsedRange.Rows.Count, Ws.UsedRange.Columns.Count)).AutoFormat(vFormato) 'le hace autoformato

            'insertar totales
            Dim filas = Ws.UsedRange.Rows.Count
            Ws.Cells(filas + 1, "F") = "TOTAL:"
            Ws.Cells(filas + 1, "G") = Exc.WorksheetFunction.Sum(Ws.Range("G2:G" & filas))
            Ws.Cells(filas + 1, "H") = Exc.WorksheetFunction.Sum(Ws.Range("H2:H" & filas))


            '/////////////////////////////////
            'muevo la planilla formateada para tener un espacio arriba
            Ws.Range(Ws.Cells(1, 1), Ws.Cells(filas + 2, Ws.UsedRange.Columns.Count)).Cut(Ws.Cells(10, 1))

            '/////////////////////////////////
            'poner tambien el filtro que se usó para hacer el informe
            Ws.Cells(7, 1) = titulo

            '/////////////////////////////////
            'insertar la imagen 
            'System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/Williams.bmp")  
            'Ws.Pictures.Insert("~/Imagenes/Williams.bmp")

            'todo: reparar esto
            'Dim imag = Ws.Pictures.Insert(Server.MapPath("~/Imagenes/Williams.bmp"))
            'imag.Left = 1
            'imag.top = 1


            '/////////////////////////////////
            'insertar link
            Dim rg As Excel.Range = Ws.Cells(3, 8)
            'rg.hip()
            'rg.Hyperlinks(1).Address = "www.williamsentregas.com.ar"
            'rg.Hyperlinks(1).TextToDisplay=
            Ws.Hyperlinks.Add(rg, "http:\\www.williamsentregas.com.ar", , , "Visite: www.williamsentregas.com.ar y vea toda su información en linea!")
            'Ws.Cells(3, "K") = "=HYPERLINK(" & Chr(34) & "www.williamsentregas.com.ar " & Chr(34) & ", ""Visite: www.williamsentregas.com.ar y vea toda su información en linea!"" )"








            '/////////////////////////////////
            '/////////////////////////////////

            'Usando un GUID
            'pFileName = System.IO.Path.GetTempPath() + Guid.NewGuid().ToString() + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Usando la hora
            pFileName = System.IO.Path.GetTempPath() + "WilliamsEntregas " + Now.ToString("ddMMMyyyy_HHmmss") + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            '/////////////////////////////////

            'pFileName = Path.GetTempFileName  'tambien puede ser .GetRandomFileName
            'pFileName = Path.GetTempFileName.Replace("tmp", "xls")
            'problemas con el acceso del proceso al archivo? http://www.eggheadcafe.com/software/aspnet/34067727/file-cannot-be-accessed-b.aspx
            'pFileName = "C:\Archivo.xls"
            'File.Delete(pFileName) 'si no borro, va a aparecer el cartelote de sobreescribir. entonces necesito el .DisplayAlerts = False

            Exc.ActiveWorkbook.SaveAs(pFileName, Excel.XlTextQualifier.xlTextQualifierNone - 1, )
        End If


        'Exc.Quit()
        'Wb = Nothing
        'Exc = Nothing

        If Not Wb Is Nothing Then Wb.Close(False)
        NAR(Wb)
        'Wbs.Close()
        'NAR(Wbs)
        'quit and dispose app
        Exc.Quit()
        NAR(Exc)

        Ws = Nothing


        GC.Collect()
        'If valor > -1 Then
        '    Dim p As System.Diagnostics.Process = New System.Diagnostics.Process
        '    p.EnableRaisingEvents = False
        '    'System.Diagnostics.Process.Start(pFileName) 'para qué hace esto?
        'End If
        Return pFileName
    End Function



End Class



'End Namespace