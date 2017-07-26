Imports System.Net.Mail
Imports System.Data.Linq
Imports System.Linq
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports ADODB
'Imports Microsoft.Office
Imports System.Xml
Imports System.Xml.XPath
Imports System.Xml.Xsl
Imports System.IO

Imports System.Web.UI

Public Module ProntoFuncionesGeneralesCOMPRONTO

    Public Const wrdFormatDocument As Object = 0 '(save word .DOC in default format)




    Function ArrayVB6(ByVal ParamArray args() As Object) As Object()
        'De esta manera, me ahorro reemplazar parentesis por llaves "New Object() { ..... }"
        Return args
    End Function




    Function Encriptar(ByVal SC As String) As String
        Dim x As New dsEncrypt
        x.KeyString = ("EDS")
        'Encriptar = x.Encrypt("Provider=SQLOLEDB.1;Persist Security Info=False;" + SC) 'esto era para el caso especial de compronto. pero no lo uses mas, porque sino estropeas las encriptaciones que no son de ese caso!
        Encriptar = x.Encrypt(SC)
    End Function

End Module


Public Enum EnumPRONTO_SiNo
    NO
    SI
End Enum


Public Module ProntoConversion
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////

    'Conversion entre capas
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////




    '///////////////////////////////////////////////////////////
    'BASE SQL hacia OBJETO .NET
    '///////////////////////////////////////////////////////////

    Function SQLtoNET(ByVal tipoSQL As ADODB.Field) As Object
        Select Case tipoSQL.Type
            Case adodb.DataTypeEnum.adDBTimeStamp
                Return iisValidSqlDate(tipoSQL.Value)
            Case adodb.DataTypeEnum.adInteger, adodb.DataTypeEnum.adUnsignedTinyInt, adodb.DataTypeEnum.adUnsignedInt
                If Left(tipoSQL.Name, 2).ToUpper = "ID" Then 'es un foreign key (ID)
                    Return iisNull(tipoSQL.Value, 0)
                Else
                    Return iisNull(tipoSQL.Value, Nothing) 'es un numero cualquiera
                End If
            Case adodb.DataTypeEnum.adChar, adodb.DataTypeEnum.adVarChar
                'Return iisNull(tipoSQL.Value, "")
                Return iisNull(tipoSQL.Value, Nothing)
            Case Else
                Return iisNull(tipoSQL.Value, Nothing)
        End Select
    End Function

    Sub SQLtoNET(ByRef oDest As Object, ByVal sCampo As String, ByVal myDataRecord As IDataRecord)
        sCampo = Replace(sCampo, "@", "")
        Try
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal(sCampo)) Then
                oDest = myDataRecord.GetValue(myDataRecord.GetOrdinal(sCampo))
            End If
        Catch ex As Exception
            ErrHandler.WriteError(ex)
            'if ex=IndexOutOfRangeException
        End Try
    End Sub

    ''' <summary>
    ''' Para cargar de un store (le paso el parametro con la @ solamente porque estoy copiando el codigo del NETtoSQL)
    ''' </summary>
    ''' <param name="myDataRecord"></param>
    ''' <param name="sCampo"></param>
    ''' <param name="oDest"></param>
    ''' <remarks></remarks>
    Sub SQLtoNET(ByVal myDataRecord As IDataRecord, ByVal sCampo As String, ByRef oDest As Object)
        sCampo = Replace(sCampo, "@", "")


        If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal(sCampo)) Then

            Dim s = myDataRecord.GetValue(myDataRecord.GetOrdinal(sCampo))

            If Not oDest Is Nothing AndAlso oDest.GetType().IsEnum() Then
                'transformo el dato de tipo string de sql, en un enum en .NET, usando el mismo 
                'nombre de las constantes del enum
                'http://stackoverflow.com/questions/852141/parse-a-string-to-an-enum-value-in-vb-net
                'oDest = DirectCast([Enum].Parse(oDest.GetType(), s), oDest.GetType())
                oDest = [Enum].Parse(oDest.GetType(), s)

            Else
                oDest = s
            End If

        End If
    End Sub

    '///////////////////////////////////////////////////////////
    'OBJETO .NET hacia BASE SQL
    '///////////////////////////////////////////////////////////

    Sub NETtoSQL(ByRef sqlComando As SqlCommand, ByVal sParametro As String)
        NETtoSQL(sqlComando, sParametro, DBNull.Value) 'mirá que le está mandando null
    End Sub

    Sub NETtoSQL(ByRef oObjetoNET As Object, ByVal sParametro As String, ByRef sqlComando As SqlCommand)
        NETtoSQL(sqlComando, sParametro, oObjetoNET)
    End Sub

    Sub NETtoSQL(ByRef sqlComando As SqlCommand, ByVal sParametro As String, ByRef oObjetoNET As Object, Optional ByVal bForzarForeignKey As Boolean = False)
        '///////////////////////////////////////////////////////////////////////////////////////////////
        'Esta funcion se reduce a devolver DBNull cuando la variable no tiene valor explicito asignado
        '///////////////////////////////////////////////////////////////////////////////////////////////

        Dim valor As Object

        'If oObjetoNET = Nothing Then
        If IsNothing(oObjetoNET) Then
            valor = System.DBNull.Value
        Else

            If bForzarForeignKey Or (Left(sParametro, 3) = "@Id" And IsNumeric(oObjetoNET)) Then
                'Si sospecho que es un campo de ID, uso IdNull
                valor = IdNull(oObjetoNET)
            Else
                Try
                    Select Case oObjetoNET.GetType.Name
                        'Case "Int32", "Int64", "Decimal", "Double", "Single", Is = "Byte"
                        'Case "Boolean"

                        Case "Date", "DateTime"
                            valor = fechaNETtoSQL(oObjetoNET, System.DBNull.Value)

                        Case Else
                            If oObjetoNET.GetType.IsEnum Then
                                valor = oObjetoNET.ToString
                            Else
                                valor = iisNull(oObjetoNET, System.DBNull.Value)
                            End If

                    End Select
                Catch ex As Exception
                    valor = iisNull(oObjetoNET, System.DBNull.Value)
                End Try

            End If
        End If

        sqlComando.Parameters.AddWithValue(sParametro, valor)

    End Sub

    Function NETtoSQL(ByRef tipoNET As Object) As Object
        '///////////////////////////////////////////////////////////////////////////////////////////////
        'Esta funcion se reduce a devolver DBNull cuando la variable no tiene valor explicito asignado
        '///////////////////////////////////////////////////////////////////////////////////////////////

        'no hay manera de saber el nombre de la variable (mas alla de que es un escandalo querer saberlo)
        'If Left(tipoNET.get, 2) = "Id" And IsNumeric(tipoNET) Then
        '    'Si sospecho que es un campo de ID, uso IdNull
        '    Return IdNull(tipoNET)
        'End If

        Select Case tipoNET.GetType.Name
            'Case "Int32", "Int64", "Decimal", "Double", "Single", Is = "Byte"
            'Case "Boolean"

            Case "Date"
                Return fechaNETtoSQL(tipoNET, System.DBNull.Value)

            Case Else
                Return iisNull(tipoNET, System.DBNull.Value)
        End Select


    End Function



    ''' <summary>
    ''' No te preocupés, que devuelve DBNull en lugar de Nothing
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <param name="Y"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function fechaNETtoSQL(ByVal Fecha As Object, Optional ByVal Y As Object = Nothing) As Object
        'If fehca < sqldatetime.minvalue Then
        If IsNothing(Y) Then Y = DBNull.Value

        If Not IsDate(Fecha) Then Return Y
        If Fecha = #1/1/1753# Then Return Y
        If Fecha = Nothing Then Return Y

        If Fecha < #1/1/1753# Then
            fechaNETtoSQL = #1/1/1753#
        ElseIf Fecha > #12/31/9999 11:59:59 PM# Then
            fechaNETtoSQL = #12/31/9999 11:59:59 PM#
        Else
            fechaNETtoSQL = Fecha
        End If
    End Function


    Public Function IdNull(ByVal Id As Long)
        If Id <= 0 Then
            Return System.DBNull.Value
        Else
            Return Id
        End If
    End Function



End Module




Public Module ProntoFuncionesGenerales




    Public Function SqlCommand(ByVal enumStoreProc As enumSPs, ByVal conn As SqlConnection) As System.Data.SqlClient.SqlCommand
        Dim oCommand As New System.Data.SqlClient.SqlCommand(enumStoreProc, conn)
        Return oCommand
    End Function




    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////


    Sub GuardarArchivoSecuencial(ByVal NombreArchivo As String, ByVal Contenido As Object)

        Dim nArch As Integer
        Dim mVuelta As Short

        On Error GoTo Mal

        nArch = FreeFile()
        mVuelta = 1
Seguir:
        'UPGRADE_WARNING: Couldn't resolve default property of object NombreArchivo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        FileOpen(nArch, NombreArchivo, OpenMode.Output)
        PrintLine(nArch, Contenido)
        FileClose((nArch))

        Exit Sub

Mal:
        If Err.Number = 70 And mVuelta < 30 Then
            'Sleep(1000)
            mVuelta = mVuelta + 1
            Resume Seguir
            GoTo Seguir
        Else
            MsgBox(Err.Description)
        End If


    End Sub

    Function LeerArchivoSecuencial(ByVal NombreArchivo As String) As String


        Dim mChar As Object
        Dim nArch As Integer
        nArch = FreeFile()
        'UPGRADE_WARNING: Couldn't resolve default property of object NombreArchivo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        FileOpen(nArch, NombreArchivo, OpenMode.Input)
        'UPGRADE_WARNING: Couldn't resolve default property of object mChar. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        mChar = ""
        Do While Not EOF(nArch)
            'UPGRADE_WARNING: Couldn't resolve default property of object mChar. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            mChar = mChar + InputString(nArch, 1)
        Loop
        FileClose((nArch))

        'UPGRADE_WARNING: Couldn't resolve default property of object mChar. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        'UPGRADE_WARNING: Couldn't resolve default property of object LeerArchivoSecuencial. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        LeerArchivoSecuencial = mChar


    End Function

    Function LeerArchivoSecuencial1(ByVal NombreArchivo As String) As String

        Dim s As String
        Dim nArch As Integer
        nArch = FreeFile()



        'UPGRADE_WARNING: Couldn't resolve default property of object NombreArchivo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        FileOpen(nArch, NombreArchivo, OpenMode.Binary)
        s = New String(Chr(0), LOF(nArch))
        'UPGRADE_WARNING: Get was upgraded to FileGet and has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
        FileGet(nArch, s, 1)
        FileClose((nArch))
        'UPGRADE_WARNING: Couldn't resolve default property of object LeerArchivoSecuencial1. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        LeerArchivoSecuencial1 = s



    End Function



    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////


    



    Public Function BuscarUnRegistroPorCampo(ByVal oRs As adodb.Recordset, _
                                          ByVal Campo As String, _
                                          ByVal ValorCampo As Object, _
                                          ByVal CampoNoNulo As String) As Long

        Dim mResultado As Long

        mResultado = 0

        On Error GoTo Salida

        With oRs
            If .Fields.Count > 0 Then
                If .RecordCount > 0 Then
                    .MoveFirst()
                    Do While Not .EOF
                        If .Fields(Campo).Value = ValorCampo Then
                            If Len(CampoNoNulo) > 0 Then
                                If Not IsNull(.Fields(CampoNoNulo).Value) Then
                                    mResultado = .AbsolutePosition
                                End If
                            Else
                                mResultado = .AbsolutePosition
                            End If
                            Exit Do
                        End If
                        .MoveNext()
                    Loop
                    .MoveFirst()
                End If
            End If
        End With

Salida:

        BuscarUnRegistroPorCampo = mResultado

    End Function

    Function CopiarRs(ByVal oRsOrigen As adodb.Recordset) As adodb.Recordset

        Dim oFld As adodb.Field
        Dim oRsDest As adodb.Recordset

        oRsDest = CreateObject("adodb.Recordset")

        With oRsDest
            For Each oFld In oRsOrigen.Fields
                .Fields.Append(oFld.Name, oFld.Type, oFld.DefinedSize, oFld.Attributes)
                .Fields.Item(oFld.Name).Precision = oFld.Precision
                .Fields.Item(oFld.Name).NumericScale = oFld.NumericScale
            Next
            .Open()
            .AddNew()
        End With

        CopiarRs = oRsDest
        oRsDest = Nothing

    End Function




    '///////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////

    Function DataTableWHERE(ByVal dt As Data.DataTable, ByVal sWHERE As String) As Data.DataTable
        'Qué operadores puedo usar en el WHERE? http://msdn.microsoft.com/es-es/library/system.data.datacolumn.expression(v=VS.80).aspx
        'between no se puede usar
        Dim dr() As DataRow = dt.Select(sWHERE)
        Dim dt2 = dt.Clone
        For Each r As DataRow In dr
            dt2.ImportRow(r)
        Next
        Return dt2
    End Function

    Public Function DataTableGROUPBY(ByVal i_sGroupByColumn As String, ByVal i_sAggregateColumn As String, ByVal i_dSourceTable As DataTable) As DataTable
        ''es para una sola columna, y está usando COUNT para el aggregate

        ''http://codecorner.galanter.net/2009/12/17/grouping-ado-net-datatable-using-linq/
        ''tiene que estar la referencia a system.data.linq
        'Dim aQuery = From row In i_dSourceTable Group By Group1 = row(i_sGroupByColumn) _
        '             Into Group Select Group1, Aggr = Group.Count(Function(row) row(i_sAggregateColumn))


        ''Dim q = From i In tablaEditadaDeFacturasParaGenerar.AsEnumerable() _
        ''        Group By IdArticulo = i("Producto"), Destino = i("IdDestino"), Titular = i("Titular") _
        ''        Into Group _
        ''        Select New With {Group, IdArticulo, Destino, Titular, _
        ''            .NetoFinal = Group.Sum(Function(i) i("KgNetos") / 1000), _
        ''            .total = Group.Sum(Function(i) i("KgNetos") / 1000 * i("TarifaFacturada")) _
        ''        }


        'Return aQuery.toDataTable
    End Function

    Public Sub DataTableForzarRowstateEnAdded(ByRef dt As Data.DataTable)
        'http://www.devx.com/tips/Tip/39112
        For Each dr As DataRow In dt.Rows
            'fuerzo el estado del datarow a ADDED
            dr.AcceptChanges()
            dr.SetAdded()
        Next
    End Sub

    Public Function DataTableDISTINCT(ByVal tablaOrigen As Data.DataTable, ByVal ParamArray columnas() As String) As Data.DataTable
        'Llamada: Dim dtwhere = Distinto(tablaEditadaDeFacturasParaGenerar, New String() {"FacturarselaA", "Corredor"})

        '/////////////////////////////////////////////////////////////////////////////
        'Acá hago un DISTINCT (en el ToTable) para saber los distintos lotes que tengo que armar

        Dim vista As Data.DataView = tablaOrigen.DefaultView
        Return vista.ToTable(True, columnas)
    End Function

    Public Function DataTableUNION(ByVal First As DataTable, ByVal Second As DataTable) As DataTable
        '//Result table
        Dim table As DataTable = New DataTable("Union")
        '//Build new columns

        Dim newcolumns(First.Columns.Count) As DataColumn

        For i As Integer = 0 To First.Columns.Count - 1
            newcolumns(i) = New DataColumn(First.Columns(i).ColumnName, First.Columns(i).DataType)
        Next
        '//add new columns to result table
        table.Columns.AddRange(newcolumns)
        table.BeginLoadData()
        '//Load data from first table

        For Each row As DataRow In First.Rows
            table.LoadDataRow(row.ItemArray, True)
        Next

        '//Load data from second table
        For Each row As DataRow In Second.Rows

            table.LoadDataRow(row.ItemArray, True)
        Next
        table.EndLoadData()

        Return table

    End Function


    Function DataTableORDER(ByVal tablaOrigen As Data.DataTable, ByVal sORDER As String) As DataView

        Dim b As Data.DataView = New DataView(tablaOrigen)
        b.Sort = sORDER
        Return b

    End Function








    ''' <summary>
    ''' Agrega caracteres de escape SQL a un string
    ''' </summary>
    ''' <param name="s"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Function _c(ByVal s As Object) As String
        Return "'" & s.ToString & "'"
    End Function

    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////
    'fechas
    '////////////////////////////////////////////////////////////////////

    Function PrimerDiaDelMesAnterior() As DateTime
        GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))
    End Function

    Function GetFirstDayInMonth(ByVal origDt As DateTime) As DateTime
        Dim dtRet = New DateTime(origDt.Year, origDt.Month, 1, 0, 0, 0)
        Return dtRet
    End Function

    Function GetLastDayInMonth(ByVal origDt As DateTime) As DateTime
        Dim dtRet = New DateTime(origDt.Year, origDt.Month, 1).AddMonths(1).AddDays(-1)
        Return dtRet
    End Function


    'formateos

    Function formateaFecha(ByVal s As Object) As String
        'devuelve en la fecha con el nombre del mes
        'pinta que si llego con un Date en lugar de DateTime, no le gusta
        If s Is Nothing Then Return s
        Try
            Return s.ToString("ddMMMyyyy")
        Catch ex As Exception
            Return s
        End Try
    End Function

    Function TextoAFecha(ByVal Fecha As String) As Date
        'Fecha.pa()
        'DateTime.Parse()
        'DateTime.TryParse()

        'Acá, en lugar de usar un Globalization ingles como en lo de la coma, uso una referencia a
        'la fecha española
        If Fecha = "" Then Return Nothing
        Try
            TextoAFecha = DateTime.Parse(Fecha, System.Globalization.CultureInfo.CreateSpecificCulture("es-AR"))
        Catch ex As Exception
            Return Nothing
        End Try


        'If DateTime.TryParseExact(Fecha, "dd/mm/yy", , , TextoAFecha) Then
        '    Return TextoAFecha
        'End If

        'Try
        '    Return Decimal.Parse(s, System.Globalization.)
        'Catch ex As Exception
        '    Return Decimal.Parse(s)
        'End Try


    End Function

    Function FechaChica(ByVal Fecha As DateTime) As String
        Return Format(Fecha, "dd/MM/yyyy")
    End Function

    Function FechaANSI(ByVal Fecha As DateTime) As String
        Return Fecha.ToString("yyyyMMdd")
    End Function

    Function Fecha_ddMMyyyy(ByVal Fecha As DateTime) As String
        Return Fecha.ToString("ddMMyyyy")
    End Function

    Function FechaCompletaANSI(ByVal Fecha As DateTime) As String
        Return Fecha.ToString("yyyyMMdd hh:mm:ss")
    End Function

    Public Function FechaANSI2(ByVal Fecha As DateTime, ByVal FFH As String)
        'Conversion de la fecha del sistema a fecha ANSI en formato ‘yyyymmdd hh:mm:ss’
        'Dado que las fechas se ingresan igual que los string, devuelve un valor string
        'porque .net no reconoce formato de fecha ANSI, o al menos yo no lo encontré XD.
        'http://skrdz.wordpress.com/2009/12/03/fechas-ansi-para-sql-server/
        Dim ANSI As String = ""
        Dim FANSI As String = ""
        Dim FHANSI As String = ""
        Dim Año As String
        Dim MesI As Integer
        Dim Mes As String
        Dim DíaI As Integer
        Dim Día As String
        Dim Hora As String
        Dim Minuto As String
        Dim Segundo As String
        Try
            Año = CStr(Fecha.Year)
            MesI = CInt(Fecha.Month)
            DíaI = CInt(Fecha.Day)
            If MesI < 10 Then
                Mes = "0″ & CStr(MesI)"
            Else
                Mes = CStr(MesI)
            End If
            If DíaI < 10 Then
                Día = "0″ & CStr(DíaI)"
            Else
                Día = DíaI
            End If
            Hora = Fecha.Hour
            Minuto = Fecha.Minute
            Segundo = Fecha.Second
            FANSI = Año & Mes & Día
            FHANSI = Año & Mes & Día & " " & Hora & ":" & Minuto & ":" & Segundo
            If FFH = "F" Then
                ANSI = FANSI
            ElseIf FFH = "FH" Then
                ANSI = FHANSI
            End If
            Return ANSI
        Catch ex As Exception
            ANSI = ex.ToString
            Return ANSI
        End Try
    End Function



    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////

    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////

    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////



    Function TimestampToLong(ByVal timeStamp() As Byte) As Long
        Dim l As Long

        'BitConverter.ToInt64()


        Return l
    End Function


    Function IsPrintable(ByVal c As Char) As Boolean
        If c.CompareTo(Chr(31)) >= 0 AndAlso c.CompareTo(Chr(127)) < 0 Then
            Return True
        Else
            Return False
        End If
    End Function



    'por qué en estas funciones usas "Object"? -Porque no sé, justamente, si me pasan lo que espero. Vos fumá

    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////

    'conversiones ADO 
    'http://support.microsoft.com/default.aspx?scid=kb;en-us;316337

    Public Function RecordSet_To_DataTable(ByVal rs As ADODB.Recordset) As DataTable
        Return RecordSet_2_DataTable(rs)
    End Function

    Public Function RecordSet_2_DataTable(ByVal rs As ADODB.Recordset) As DataTable

        Dim myDA As New OleDb.OleDbDataAdapter()
        Dim myDS As New DataSet("MyTable")
        myDA.Fill(myDS, rs, "MyTable")
        Return myDS.Tables(0)

    End Function

    Function DataRow_To_DataTable(ByVal dr As DataRow) As DataTable
        Dim dt As New DataTable
        dt.ImportRow(dr)
        Return dt
    End Function


    'http://www.codeproject.com/KB/database/DataTableToRecordset.aspx

    Public Function DataTable_To_Recordset(ByVal inTable As DataTable) As ADODB.Recordset
        Return ConvertToRecordset(inTable)
    End Function

    Public Function ConvertToRecordset(ByVal inDataSet As DataSet) As ADODB.Recordset
        Return ConvertToRecordset(inDataSet.Tables(0))
    End Function

    Public Function ConvertToRecordset(ByVal inTable As DataTable) As ADODB.Recordset

        Dim result As ADODB.Recordset = New ADODB.Recordset
        result.CursorLocation = ADODB.CursorLocationEnum.adUseClient

        Dim resultFields As ADODB.Fields = result.Fields
        Dim inColumns As System.Data.DataColumnCollection = inTable.Columns

        For Each inColumn As DataColumn In inColumns
            resultFields.Append(inColumn.ColumnName, TranslateType(inColumn.DataType), _
                                inColumn.MaxLength, _
                                IIf(inColumn.AllowDBNull, ADODB.FieldAttributeEnum.adFldIsNullable, ADODB.FieldAttributeEnum.adFldUnspecified), _
                                Nothing)
        Next

        result.Open(System.Reflection.Missing.Value, System.Reflection.Missing.Value, ADODB.CursorTypeEnum.adOpenStatic, ADODB.LockTypeEnum.adLockOptimistic, 0)

        For Each dr As DataRow In inTable.Rows

            result.AddNew(System.Reflection.Missing.Value, System.Reflection.Missing.Value)

            For columnIndex As Integer = 0 To inColumns.Count - 1

                resultFields(columnIndex).Value = dr(columnIndex)
            Next
        Next

        If result.RecordCount > 0 Then result.MoveFirst()

        Return result
    End Function

    Private Function TranslateType(ByVal columnType As Type) As ADODB.DataTypeEnum

        Select Case columnType.UnderlyingSystemType.ToString()
            Case "System.Boolean"
                Return ADODB.DataTypeEnum.adBoolean

            Case "System.Byte"
                Return ADODB.DataTypeEnum.adUnsignedTinyInt

            Case "System.Char"
                Return ADODB.DataTypeEnum.adChar

            Case "System.DateTime"
                Return ADODB.DataTypeEnum.adDate

            Case "System.Decimal"
                Return ADODB.DataTypeEnum.adCurrency

            Case "System.Double"
                Return ADODB.DataTypeEnum.adDouble

            Case "System.Int16"
                Return ADODB.DataTypeEnum.adSmallInt

            Case "System.Int32"
                Return ADODB.DataTypeEnum.adInteger

            Case "System.Int64"
                Return ADODB.DataTypeEnum.adBigInt

            Case "System.SByte"
                Return ADODB.DataTypeEnum.adTinyInt

            Case "System.Single"
                Return ADODB.DataTypeEnum.adSingle

            Case "System.UInt16"
                Return ADODB.DataTypeEnum.adUnsignedSmallInt

            Case "System.UInt32"
                Return ADODB.DataTypeEnum.adUnsignedInt

            Case "System.UInt64"
                Return ADODB.DataTypeEnum.adUnsignedBigInt

            Case "System.String"
                Return ADODB.DataTypeEnum.adVarChar

            Case Else
                Return ADODB.DataTypeEnum.adVarChar
        End Select
    End Function

    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////






    ''' <summary>
    ''' Devuelve nothing si la fecha no es valida para SQL
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <param name="Y"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    ''' 


    Public Function iisValidSqlDate(ByVal Fecha As Object, Optional ByVal Y As Object = Nothing) As Object
        'If fehca < sqldatetime.minvalue Then

        If Not IsDate(Fecha) Then Return Y
        If Fecha = Nothing Then Return Y

        If Fecha < #1/1/1753# Then
            iisValidSqlDate = #1/1/1753#
        ElseIf Fecha > #12/31/9999 11:59:59 PM# Then
            iisValidSqlDate = #12/31/9999 11:59:59 PM#
        Else
            iisValidSqlDate = Fecha
        End If
    End Function

    'Public Function iisZeroThenNull(ByVal Numero As Long) As Object
    '    If Numero = 0 Then
    '        Return System.DBNull.Value
    '    Else
    '        Return Numero
    '    End If
    'End Function



    Public Function iisNumeric(ByVal Numero As Object, Optional ByVal Y As Object = Nothing) As Object

        If Not IsNumeric(Numero) Then Return Y

        Return Numero
    End Function


    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="d"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function DecimalToString(ByVal d As Decimal) As String
        'taría bueno overloadear todos los decimal con un metodo directo... O mejor aún, renombrar uno que ya existe....
        Return d.ToString(System.Globalization.CultureInfo.InvariantCulture)
    End Function

    Function IsNull(ByVal x As Object) As Boolean 'reemplazo de la vieja isnull
        Return IsDBNull(x)
    End Function


    Public Function stod(ByVal s As String) As Decimal 'alias de StringToDecimal
        Return StringToDecimal(s)
    End Function

    Public Function StringToDecimal(ByVal s As String) As Decimal
        If s = "" Then
            Return 0
        End If
        s = Replace(s, "$", "")
        's = Replace(s, ",", ".")
        'acá puede llegar un 46.548.65  !!!!!
        If Not IsNumeric(s) Then
            Return 0
        End If

        'Esta operación lo que hace es obtener una referencia a la "instancia cultural de todos los idiomas" la cual se basa en la referencia cultural inglesa, que como saben maneja el punto como el separador de decimales,y por tanto lo que estamos logrando es ignorar la configuración regional!!
        Try
            Return Decimal.Parse(s, System.Globalization.CultureInfo.InvariantCulture)
        Catch ex As Exception
            Return Decimal.Parse(s)
        End Try



    End Function

    Public Function FF2(ByVal s As Double) As String
        Return String.Format("{0:F2}", s)
    End Function

    Public Function FormatVB6(ByVal s As Double, ByVal Style As String) As String
        Return Format(CSng(s), Style)
    End Function

    Public Function iisNull(ByVal X As Object, Optional ByVal Y As Object = "") As Object
        'Esta funcion es de cuando no tenia idea... y debería revisar si ahora la tengo

        'On Error Resume Next
        If X Is Nothing Then Return Y

        Try
            If X.GetType.Name = "Int32" Or X.GetType.Name = "Int64" Or X.GetType.Name = "Decimal" _
            Or X.GetType.Name = "UInt32" Or X.GetType.Name = "UInt64" _
            Or X.GetType.Name = "Double" Or X.GetType.Name = "Single" Or X.GetType.Name = "Byte" Then
                If X Is Nothing Then
                    iisNull = Y
                ElseIf X = 0 Then
                    'esto en qué casos lo uso?????
                    iisNull = X 'Y
                Else
                    iisNull = X
                End If
            ElseIf (X.GetType.Name = "String") Then
                'X.ToString.IsNullOrEmpty()
                'If Valor Is DBNull.Value Then

                If X Is Nothing Or X = "" Then
                    iisNull = Y
                Else
                    iisNull = X
                End If
            ElseIf (X.GetType.Name = "Boolean") Then
                'X.ToString.IsNullOrEmpty()
                'If Valor Is DBNull.Value Then
                If X Is Nothing Then
                    iisNull = Y
                Else
                    iisNull = X
                End If
            ElseIf (X.GetType.Name = "DateTime") Then
                If X Is Nothing Then
                    iisNull = Y
                Else
                    iisNull = X
                End If
            Else
                Try
                    If IsDBNull(X) Then
                        iisNull = Y
                    ElseIf X Is Nothing Or X = "" Then
                        iisNull = Y
                    Else
                        iisNull = X
                    End If
                Catch e As System.Exception
                    iisNull = Nothing
                End Try
            End If
        Catch e As System.Exception
            Return Y
        End Try
    End Function


    Public Function MandaEmailSimple(ByVal Para As String, ByVal Asunto As String, ByVal Cuerpo As String, ByVal De As String, ByVal SmtpServer As String, ByVal SmtpUser As String, ByVal SmtpPass As String, Optional ByVal sStringGenerarAdjunto As String = "", Optional ByVal SmtpPort As Long = 587, Optional ByVal EnableSSL As Integer = 1, Optional ByVal CCO As String = "", Optional ByVal img As String = "") As Boolean
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        'mando mail al comprador
        '/////////////////////////////////////////////////////////////////////////////////

        'metodo usa Imports System.Net.Mail
        'http://weblogs.asp.net/scottgu/archive/2005/12/16/432854.aspx

        'http://lifehacker.com/111166/how-to-use-gmail-as-your-smtp-server

        Para = Para.Replace(";", ",")
        De = De.Replace(";", ",")

        Dim message As New MailMessage(De, Para, Asunto, Cuerpo)

        message.IsBodyHtml = True

        If sStringGenerarAdjunto <> "" Then
            Dim YSOD As Attachment = Net.Mail.Attachment.CreateAttachmentFromString(sStringGenerarAdjunto, "YSOD.htm")
            message.Attachments.Add(YSOD)
        End If

        'Seteo que el server notifique solamente en el error de entrega
        message.Priority = MailPriority.High




        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////



        Dim emailClient As SmtpClient = New SmtpClient(SmtpServer)

        emailClient.Port = SmtpPort

        'Si se solicitó SSL, lo activo
        If EnableSSL = 1 Then
            emailClient.EnableSsl = True
            'Bypass de validación de certificado (para problemas con servidores de SMTP con SSL con certificados que no validan en nuestra máquina)
            System.Net.ServicePointManager.ServerCertificateValidationCallback = New System.Net.Security.RemoteCertificateValidationCallback(AddressOf ValidarCertificado)
        End If
        ''Cargo las credenciales si hacen falta
        'If Not String.IsNullOrEmpty(SSLuser) Then
        '    Dim credenciales As New System.Net.NetworkCredential(SSLuser, SSLpass)
        '    oSMTP.Credentials = credenciales
        'End If

        emailClient.EnableSsl = True
        emailClient.Credentials = New System.Net.NetworkCredential(SmtpUser, SmtpPass)





        'Try
        emailClient.Send(message)





        Return True
    End Function

    Public Function EnviarEmail(ByVal Para As String, ByVal Asunto As String, ByVal Cuerpo As String, ByVal De As String, ByVal SmtpServer As String, ByVal SmtpUser As String, ByVal SmtpPass As String, Optional ByVal sFileNameAdjunto As String = "", Optional ByVal SmtpPort As Long = 587, Optional ByVal EnableSSL As Integer = 1, Optional ByVal CCO As String = "", Optional ByVal img As String = "") As Boolean
        Return MandaEmail(Para, Asunto, Cuerpo, De, SmtpServer, SmtpUser, SmtpPass, sFileNameAdjunto, SmtpPort, EnableSSL, CCO, img)
    End Function

    Public Function MandaEmail(ByVal Para As String, ByVal Asunto As String, ByVal Cuerpo As String, ByVal De As String, ByVal SmtpServer As String, ByVal SmtpUser As String, ByVal SmtpPass As String, Optional ByVal sFileNameAdjunto As String = "", Optional ByVal SmtpPort As Long = 587, Optional ByVal EnableSSL As Integer = 1, Optional ByVal CCO As String = "", Optional ByVal img As String = "") As Boolean
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        'mando mail al comprador
        '/////////////////////////////////////////////////////////////////////////////////

        'metodo usa Imports System.Net.Mail
        'http://weblogs.asp.net/scottgu/archive/2005/12/16/432854.aspx

        'http://lifehacker.com/111166/how-to-use-gmail-as-your-smtp-server



        'If De = "" Then De = "ProntoWebMail@gmail.com"
        'If SmtpServer = "" Then SmtpServer = "smtp.gmail.com"
        'If SmtpUser = "" Then SmtpUser = "ProntoWebMail"
        'If SmtpPass = "" Then SmtpPass = ConfigurationSettings.AppSettings("SmtpPass") '"50TriplesdJQ"

        Para = Para.Replace(";", ",")
        De = De.Replace(";", ",")


        Dim message As New MailMessage(De, Para, Asunto, Cuerpo)
        If sFileNameAdjunto <> "" Then message.Attachments.Add(New Attachment(sFileNameAdjunto))
        'Seteo que el server notifique solamente en el error de entrega
        message.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure
        message.Priority = MailPriority.High


        If CCO <> "" Then
            'http://www.seesharpdot.net/?p=209
            'http://forums.asp.net/t/1394642.aspx

            message.Headers.Add("Disposition-Notification-To", CCO)
            message.Bcc.Add(New MailAddress(CCO, CCO)) 'copia oculta
            message.ReplyTo = New MailAddress(CCO)
            'message.ReplyTo.a.ReplyToList.Add(New MailAddress(mailReplyToAddress)) 'este esta recien en .NET 4

            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

            'aviso de retorno http://msdn.microsoft.com/en-us/vbasic/bb630227.aspx
            'Add a custom header named Disposition-Notification-To and specify the
            'read recept address
            'message.Headers.Add("Disposition-Notification-To", "returnreceipt@return.com")

            'message.Headers.Add("Disposition-Notification-To", CCO) 'en williams, le mando el aviso al CCO
        Else
            message.Headers.Add("Disposition-Notification-To", De)

        End If




        'message.DeliveryNotificationOptions = DeliveryNotificationOptions.OnSuccess '7 ' DeliveryNotificationOptions.OnFailure | _
        '                                        DeliveryNotificationOptions.OnSuccess | _
        'DeliveryNotificationOptions.Delay() 'arriba pusiste onfailure!!!


        If img <> "" Then
            'Encajo una "imagen" para hacer el truco del mail de respuesta al leerse
            'Dim imgLink As New LinkedResource(img)
            Dim htmlView As AlternateView = AlternateView.CreateAlternateViewFromString(img, Nothing, "text/html")
            'htmlView.LinkedResources.Add(img)
            message.AlternateViews.Add(htmlView)
        End If


        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////



        Dim emailClient As SmtpClient = New SmtpClient(SmtpServer)

        emailClient.Port = SmtpPort

        'Si se solicitó SSL, lo activo
        If EnableSSL = 1 Then
            emailClient.EnableSsl = True
            'Bypass de validación de certificado (para problemas con servidores de SMTP con SSL con certificados que no validan en nuestra máquina)
            System.Net.ServicePointManager.ServerCertificateValidationCallback = New System.Net.Security.RemoteCertificateValidationCallback(AddressOf ValidarCertificado)
        End If
        ''Cargo las credenciales si hacen falta
        'If Not String.IsNullOrEmpty(SSLuser) Then
        '    Dim credenciales As New System.Net.NetworkCredential(SSLuser, SSLpass)
        '    oSMTP.Credentials = credenciales
        'End If

        emailClient.EnableSsl = True
        emailClient.Credentials = New System.Net.NetworkCredential(SmtpUser, SmtpPass)





        'Try
        emailClient.Send(message)




        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        'The remote certificate is invalid according to the validation procedure“.
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        'http://varionet.wordpress.com/category/systemnetmail/






        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        'Problemas con la conexion al servidor SMTP
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////


        'If you have Windows XP SP2 (not sure how it works with SP1), Click CHANGE FIREWALL SETTINGS - click on ADVANCE - 
        ' click on connection you are using for email -on the next page make sure that there is a check mark in front of 
        '    POP3 and SMTP. Done! After hours of changing settings, this worked for me. Good luck to you!

        'Also check off "TLS" under "Use secure connection." ?????
        'http://forums.asp.net/p/1475014/3431732.aspx
        'A connection attempt failed because the connected party did not properly respond after a period of time, 
        'or established connection failed because connected host has failed to respond
        'http://forum.umbraco.org/yaf_postst7439_A-connection-attempt-failed-because.aspx
        '        Are you able to jump on the desktop of the webserver and verify that it is able to successfully 
        'resolve and connect to the below web-service. You can just use IE to navigate to the URL.
        'If you are unable to hit the service successfully from IE then its likely you have a misconfiguration 
        'somewhere.I() 'd suggest first pinging the machine from dos, and veriyfing that DNS etc is setup correctly - checking IIS etc. 
        '            cheers()
        'http://www.TESTDOM.com/interface/webservices/TESTDOM.asmx

        '        You can use localhost as your SMTP server only if you have a SMTP Service installed on the same computer hosting the application.

        'In your case, I do not believe it is trying to connection to localhost (if it is trying to connect 
        'to localhost, the IP should be 127.0.0.1).  Your application is trying to connect to 66.167.125.100 but there's no response from that IP.

        'I tested connecting to this IP from my computer (over port 25) and it is responding.  
        'The most likely cause is that the web server hosting the site does not allow outbound connection to be made

        'If you have Windows XP SP2 (not sure how it works with SP1), Click CHANGE FIREWALL SETTINGS - click on ADVANCE - 
        ' click on connection you are using for email -on the next page make sure that there is a check mark in front of 
        '    POP3 and SMTP. Done! After hours of changing settings, this worked for me. Good luck to you!


        'http://forums.asp.net/p/1274384/2421592.aspx

        '        Please make sure it is able to connect from the production server to the server specified in ASP.NET application. 
        '    Run a ping command from command line prompt to the server's IP address or server name to see the results. 
        '   You should be able to see the results from command prompt which will indicate whether the connection is successful or not.
        'According to your description, the server might locate in the same machine or in the same intranet. 
        'For production enviroment, you might need to have similar deployment. 


        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////

        'LabelError.Text = "Mensaje enviado satisfactoriamente"
        'Catch ex As Exception
        '    ErrHandler.WriteError(ex.Message)
        '    Debug.Print(ex.Message)
        '    'LabelError.Text = "ERROR: " & ex.Message
        '    Return False
        'End Try



        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////

        'metodo outlook
        'http://www.elguille.info/colabora/puntoNET/Emanon_OutlookVB.htm
        'http://www.forosdelweb.com/f29/programacion-con-outlook-vb-net-274661/

        'Try
        '    Dim m_OutLook As Microsoft.Office.Interop.Outlook.Application

        '    Dim objMail As Microsoft.Office.Interop.Outlook.MailItem

        '    m_OutLook = New Microsoft.Office.Interop.Outlook.Application
        '    objMail = m_OutLook.CreateItem(Microsoft.Office.Interop.Outlook.OlItemType.olMailItem)
        '    objMail.To = EmpleadoManager.GetItem(SC, myPresupuesto.IdComprador).Email

        '    objMail.Subject = "Respuesta a Solicitación de Presupuesto"

        '    objMail.Body = "El proveedor " & ProveedorManager.GetItem(SC, myPresupuesto.IdComprador).Nombre1 & " ha respondido a la solicitación de presupuesto " & myPresupuesto.Numero
        '    objMail.Body = objMail.Body & "URL http://localhost:3688/Pronto/ProntoWeb/Presupuesto.aspx?Id=3&Empresa=Marcalba"



        '    objMail.Send()

        '    'MessageBox.Show("Mail Enviado", "Integración con OutLook", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)

        'Catch ex As Exception

        '    '* Si se produce algun Error Notificar al usuario

        '    'MessageBox.Show("Error enviando mail")
        '    Debug.Print(ex.Message)
        'Finally
        '    'm_OutLook = Nothing
        'End Try


        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////

        Return True
    End Function

    Private Function ValidarCertificado(ByVal sender As Object, ByVal certificate As System.Security.Cryptography.X509Certificates.X509Certificate, ByVal chain As System.Security.Cryptography.X509Certificates.X509Chain, ByVal sslPolicyErrors As System.Net.Security.SslPolicyErrors) As Boolean
        'bypass de la validación del certificado (aplicar aquí validación personalizada si fuera el caso)
        Return True
    End Function


    Function SplitRapido(ByVal s As String, ByVal delimiter As String, ByVal indice As Long) As String
        Try
            Dim array() As String = Split(s, delimiter)
            If indice > array.GetUpperBound(0) Then Return Nothing
            Return array(indice)
        Catch ex As Exception
            Return Nothing
        End Try
    End Function

    Function TextoEntre(ByVal s As String, ByVal sub1 As String, ByVal sub2 As String) As String
        Try
            s = Mid(s, InStr(s, sub1) + Len(sub1))
            Return Left(s, InStr(s, sub2) - 1)
        Catch ex As Exception
            Return ""
        End Try
    End Function


    Enum enumObjectType
        StrType = 0
        IntType = 1
        DblType = 2
    End Enum

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="obj"></param>
    ''' <param name="ObjectType"></param>
    ''' <returns></returns>
    ''' <remarks>
    ''' 'http://www.freevbcode.com/ShowCode.Asp?ID=5810
    ''' </remarks>
    Public Function CheckDBNull(ByVal obj As Object, _
    Optional ByVal ObjectType As enumObjectType = enumObjectType.StrType) As Object
        Dim objReturn As Object
        objReturn = obj
        If ObjectType = enumObjectType.StrType And IsDBNull(obj) Then
            objReturn = ""
        ElseIf ObjectType = enumObjectType.IntType And IsDBNull(obj) Then
            objReturn = 0
        ElseIf ObjectType = enumObjectType.DblType And IsDBNull(obj) Then
            objReturn = 0.0
        End If
        Return objReturn
    End Function

    Public Function mkf_validacuit(ByVal mk_p_nro As String) As Boolean
        Dim mk_suma As Integer
        Dim mk_valido As String
        mk_p_nro = mk_p_nro.Replace("-", "")
        If IsNumeric(mk_p_nro) Then
            If mk_p_nro.Length <> 11 Then
                mk_valido = False
            Else
                mk_suma = 0
                mk_suma += CInt(mk_p_nro.Substring(0, 1)) * 5
                mk_suma += CInt(mk_p_nro.Substring(1, 1)) * 4
                mk_suma += CInt(mk_p_nro.Substring(2, 1)) * 3
                mk_suma += CInt(mk_p_nro.Substring(3, 1)) * 2
                mk_suma += CInt(mk_p_nro.Substring(4, 1)) * 7
                mk_suma += CInt(mk_p_nro.Substring(5, 1)) * 6
                mk_suma += CInt(mk_p_nro.Substring(6, 1)) * 5
                mk_suma += CInt(mk_p_nro.Substring(7, 1)) * 4
                mk_suma += CInt(mk_p_nro.Substring(8, 1)) * 3
                mk_suma += CInt(mk_p_nro.Substring(9, 1)) * 2
                mk_suma += CInt(mk_p_nro.Substring(10, 1)) * 1

                If Math.Round(mk_suma / 11, 0) = (mk_suma / 11) Then
                    mk_valido = True
                Else
                    mk_valido = False
                End If
            End If
        Else
            mk_valido = False
        End If
        Return (mk_valido)
    End Function





















    Function VerUsuario() As String

        'Dim sBuffer As String
        'Dim lSize As Long

        'sBuffer = Space$(255)
        'lSize = Len(sBuffer)
        'Call GetUserName(sBuffer, lSize)
        'If lSize > 0 Then
        '    VerUsuario = Left$(sBuffer, lSize)
        'Else
        '    VerUsuario = ""
        'End If

    End Function

    'Sub Sonido(ByVal QueSonido As String)

    '    If auxGetNumDevs > 0 Then ' si tiene placa de sonido
    '        sndPlaySound(QueSonido, SND_ASYNC + SND_NOSTOP + SND_NOWAIT)
    '    Else
    '        Beep()
    '    End If

    'End Sub



    Function ExisteCampo(ByVal oRs As ADODB.Recordset, ByVal campo As String) As Boolean

        Dim fld As Field

        For Each fld In oRs.Fields
            If fld.Name = campo Then
                ExisteCampo = True
                Exit Function
            End If
        Next

        ExisteCampo = False

    End Function

    ' Function LeerArchivo(ByVal NombreArchivo As String) As String

    '     Dim s As String
    '     Dim nArch As Long
    '     nArch = FreeFile
    'Open NombreArchivo For Binary As nArch
    '     s = String$(LOF(nArch), 0)
    'Get nArch, 1, s
    '     Close(nArch)
    '     LeerArchivo = s
    '     s = ""

    ' End Function

    ' Sub GuardarArchivo(ByVal NombreArchivo As String, ByVal Contenido As Object)

    '     Dim nArch As Long
    '     nArch = FreeFile
    'Open NombreArchivo For Binary As nArch
    '     Put(nArch, 1, Contenido)
    '     Close(nArch)

    ' End Sub

    Function Max(ByVal par1 As Object, ByVal par2 As Object) As Object

        If par1 >= par2 Then
            Max = par1
        Else
            Max = par2
        End If

    End Function

    Function Min(ByVal par1 As Object, ByVal par2 As Object) As Object

        If par1 <= par2 Then
            Min = par1
        Else
            Min = par2
        End If

    End Function

    Public Function FormatearArticulo(ByVal Producto As String) As String

        FormatearArticulo = Mid(Producto, 1, 2) & "-" & Mid(Producto, 3, 2) & "-" & Mid(Producto, 5, 4)

    End Function

    Public Function Es_MP(ByVal C_Art As String) As Boolean

        If (C_Art >= "01000000" And C_Art <= "09899999") Or (C_Art >= "09900000" And C_Art <= "09909999") Or (C_Art >= "17000000" And C_Art <= "17999999") Or (C_Art >= "86000000" And C_Art <= "86999999") Then
            Es_MP = True
        Else
            Es_MP = False
        End If

    End Function

    Public Function CopiarUnRegistro(ByVal oRsOri As ADODB.Recordset) As ADODB.Recordset

        Dim Datos As ADODB.Recordset
        Dim i As Integer

        With oRsOri
            Datos = CreateObject("adodb.Recordset")
            For i = 0 To .Fields.Count - 1
                With .Fields(i)
                    Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                    Datos.Fields(.Name).Precision = .Precision
                    Datos.Fields(.Name).NumericScale = .NumericScale
                End With
            Next
            Datos.Open()
            Datos.AddNew()
            For i = 0 To .Fields.Count - 1
                With .Fields(i)
                    Datos.Fields(i).Value = .Value
                End With
            Next
            Datos.Update()
        End With

        CopiarUnRegistro = Datos

    End Function

    Public Function CopiarUnRegistroAlModelo(ByVal oRsModelo As ADODB.Recordset, ByVal oRsFuente As ADODB.Recordset) As ADODB.Recordset

        Dim Datos As ADODB.Recordset
        Dim i, h As Integer

        With oRsModelo
            Datos = CreateObject("adodb.Recordset")
            For i = 0 To .Fields.Count - 1
                With .Fields(i)
                    Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                    Datos.Fields(.Name).Precision = .Precision
                    Datos.Fields(.Name).NumericScale = .NumericScale
                End With
            Next
            Datos.Open()
        End With

        With oRsFuente
            Datos.AddNew()
            For i = 0 To .Fields.Count - 1
                With .Fields(i)
                    For h = 0 To Datos.Fields.Count - 1
                        If Datos.Fields(h).Name = .Name Then
                            Datos.Fields(h).Value = .Value
                            Exit For
                        End If
                    Next
                End With
            Next
            Datos.Update()
        End With

        CopiarUnRegistroAlModelo = Datos

    End Function

    Public Function CopiarEstructura(ByVal oRsOri As ADODB.Recordset) As ADODB.Recordset

        Dim Datos As ADODB.Recordset
        Dim i As Integer

        With oRsOri
            Datos = CreateObject("adodb.Recordset")
            For i = 0 To .Fields.Count - 1
                With .Fields(i)
                    Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                    Datos.Fields(.Name).Precision = .Precision
                    Datos.Fields(.Name).NumericScale = .NumericScale
                End With
            Next
            Datos.Open()
        End With

        CopiarEstructura = Datos

    End Function

    Public Function CopiarEstructuraMasUnRegistroEnBlanco(ByVal oRsOri As ADODB.Recordset) As ADODB.Recordset

        Dim Datos As ADODB.Recordset
        Dim i As Integer

        With oRsOri
            Datos = CreateObject("adodb.Recordset")
            For i = 0 To .Fields.Count - 1
                With .Fields(i)
                    Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                    Datos.Fields(.Name).Precision = .Precision
                    Datos.Fields(.Name).NumericScale = .NumericScale
                End With
            Next
            Datos.Open()
            Datos.AddNew()
            Datos.Update()
        End With

        CopiarEstructuraMasUnRegistroEnBlanco = Datos

    End Function

    Public Function CopiarEstructuraSinAtributos(ByVal oRsOri As ADODB.Recordset) As ADODB.Recordset

        Dim Datos As ADODB.Recordset
        Dim i As Integer

        With oRsOri
            Datos = CreateObject("adodb.Recordset")
            For i = 0 To .Fields.Count - 1
                With .Fields(i)
                    If i = 0 Then
                        Datos.Fields.Append(.Name, .Type, .DefinedSize, 120)
                    Else
                        Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                    End If
                    Datos.Fields(.Name).Precision = .Precision
                    Datos.Fields(.Name).NumericScale = .NumericScale
                End With
            Next
            Datos.Open()
        End With

        CopiarEstructuraSinAtributos = Datos

    End Function

    Public Function CopiarTodosLosRegistros(ByVal oRsOri As ADODB.Recordset) As ADODB.Recordset

        Dim Datos As ADODB.Recordset
        Dim i As Integer

        With oRsOri
            Datos = CreateObject("adodb.Recordset")
            For i = 0 To .Fields.Count - 1
                With .Fields(i)
                    Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                    Datos.Fields(.Name).Precision = .Precision
                    Datos.Fields(.Name).NumericScale = .NumericScale
                End With
            Next
            Datos.Open()
            If .RecordCount > 0 Then
                .MoveFirst()
                Do While Not .EOF
                    Datos.AddNew()
                    For i = 0 To .Fields.Count - 1
                        With .Fields(i)
                            Datos.Fields(i).Value = .Value
                        End With
                    Next
                    Datos.Update()
                    .MoveNext()
                Loop
            End If
        End With

        CopiarTodosLosRegistros = Datos

    End Function

    Public Function ExtraerPrecio(ByVal Cadena As String) As Double

        Dim mPrecio As String
        mPrecio = Mid(Cadena, InStr(1, Cadena, "x") + 1, InStr(1, Cadena, "=") - InStr(1, Cadena, "x") - 2)
        If IsNumeric(mPrecio) Then
            ExtraerPrecio = CDbl(mPrecio)
        Else
            ExtraerPrecio = 0
        End If

    End Function




















    Public Class ReverseIterator
        'Iba a usarlo en los managers para filtrar las listas.
        ''metodo 1: 'borrar marcha atras porque si no cambia el indice!!!!
        'For Each i As Integer In New ReverseIterator(lstBorrar)
        '    Lista.RemoveAt(i) 'al final se trula y se excede del indice
        'Next
        Implements IEnumerable
        ' a low-overhead ArrayList to store references
        Dim items As New ArrayList()
        Sub New(ByVal collection As IEnumerable)
            ' load all the items in the ArrayList, but in reverse order
            Dim o As Object
            For Each o In collection
                items.Insert(0, o)
            Next
        End Sub
        Public Function GetEnumerator() As System.Collections.IEnumerator _
            Implements System.Collections.IEnumerable.GetEnumerator
            ' return the enumerator of the inner ArrayList
            Return items.GetEnumerator()
        End Function
    End Class



    Public Enum enumSPs
        wBusqueda
        wClientes_TTprimerapagina
        wCartasDePorteMovimientos_TT
        wRequerimientos_TTpaginado
        wComprobantesProveedores_TXFecha
        wTransportistas_TX_BusquedaConCUIT
        wChoferes_TX_BusquedaConCUIT
        wVendedores_TX_BusquedaConCUIT
        wClientes_TX_BusquedaConCUIT


        _AlterTable
        _TempBasesConciliacion_BorrarTabla
        _TempBasesConciliacion_InsertarRegistro
        _TempBasesConciliacion_TX_TraerTodo
        _TempCondicionesCompra_A
        _TempCondicionesCompra_BorrarTabla
        _TempCondicionesCompra_Generar
        _TempCondicionesCompra_T
        _TempCuboCostosImportacion_TX_VerificarSiHayRegistros
        _TempCuboIngresoEgresosPorObra_TX_EgresosPorObra
        _TempCuboIngresoEgresosPorObra_TX_ObrasProcesadas
        _TempCuboIngresoEgresosPorObra_TX_VerificarSiHayRegistros
        _TempCuboReservaPresupuestaria_TX_VerificarSiHayRegistros
        _TempCuboVentasEnCuotas_TX_VerificarSiHayRegistros
        _TempCuentasCorrientesAcreedores_A
        _TempCuentasCorrientesAcreedores_BorrarTabla
        _TempCuentasCorrientesAcreedores_Generar
        _TempCuentasCorrientesAcreedores_T
        _TempSAP_TX_CAI
        _TempSAP_TX_Partidas
        _TempSAP_TX_Proveedores
        Acabados_A
        Acabados_E
        Acabados_M
        Acabados_T
        Acabados_TL
        Acabados_TT
        Acabados_TX_TT
        AcoAcabados_A
        AcoAcabados_E
        AcoAcabados_M
        AcoAcabados_T
        AcoAcabados_TT
        AcoAcabados_TX_TT
        AcoAcabados_TXTL
        AcoBiselados_A
        AcoBiselados_E
        AcoBiselados_M
        AcoBiselados_T
        AcoBiselados_TT
        AcoBiselados_TX_TT
        AcoBiselados_TXTL
        AcoCalidades_A
        AcoCalidades_E
        AcoCalidades_M
        AcoCalidades_T
        AcoCalidades_TT
        AcoCalidades_TX_TT
        AcoCalidades_TXTL
        AcoCodigos_A
        AcoCodigos_E
        AcoCodigos_M
        AcoCodigos_T
        AcoCodigos_TT
        AcoCodigos_TX_TT
        AcoCodigos_TXTL
        AcoColores_A
        AcoColores_E
        AcoColores_M
        AcoColores_T
        AcoColores_TT
        AcoColores_TX_TT
        AcoColores_TXTL
        AcoFormas_A
        AcoFormas_E
        AcoFormas_M
        AcoFormas_T
        AcoFormas_TT
        AcoFormas_TX_TT
        AcoFormas_TXTL
        AcoGrados_A
        AcoGrados_E
        AcoGrados_M
        AcoGrados_T
        AcoGrados_TT
        AcoGrados_TX_TT
        AcoGrados_TXTL
        AcoHHItemsDocumentacion_A
        AcoHHItemsDocumentacion_E
        AcoHHItemsDocumentacion_M
        AcoHHItemsDocumentacion_T
        AcoHHItemsDocumentacion_TT
        AcoHHItemsDocumentacion_TX_PorGrupo
        AcoHHItemsDocumentacion_TX_TT
        AcoHHTareas_A
        AcoHHTareas_E
        AcoHHTareas_M
        AcoHHTareas_T
        AcoHHTareas_TT
        AcoHHTareas_TX_TodosLosGrupos
        AcoHHTareas_TX_TT
        AcoMarcas_A
        AcoMarcas_E
        AcoMarcas_M
        AcoMarcas_T
        AcoMarcas_TT
        AcoMarcas_TX_TT
        AcoMarcas_TXTL
        AcoMateriales_A
        AcoMateriales_E
        AcoMateriales_M
        AcoMateriales_T
        AcoMateriales_TT
        AcoMateriales_TX_TT
        AcoMateriales_TXTL
        AcoModelos_A
        AcoModelos_E
        AcoModelos_M
        AcoModelos_T
        AcoModelos_TT
        AcoModelos_TX_TT
        AcoModelos_TXTL
        AcoNormas_A
        AcoNormas_E
        AcoNormas_M
        AcoNormas_T
        AcoNormas_TT
        AcoNormas_TX_TT
        AcoNormas_TXTL
        Acopios_A
        Acopios_ActualizarEstado
        Acopios_BorrarAutorizaciones
        Acopios_E
        Acopios_M
        Acopios_T
        Acopios_TL
        Acopios_TT
        Acopios_TX_Cumplidos
        Acopios_TX_DatosAcopio
        Acopios_TX_DetallesAgrupadosPorComprador
        Acopios_TX_ItemsPorObra
        Acopios_TX_ItemsPorObra1
        Acopios_TX_ParaTransmitir
        Acopios_TX_ParaTransmitir_Todos
        Acopios_TX_Pendientes
        Acopios_TX_Pendientes1
        Acopios_TX_PendientesPorLA
        Acopios_TX_PendientesPorLA1
        Acopios_TX_PorEquipo
        Acopios_TX_PorEquipo_Todo
        Acopios_TX_SetearComoTransmitido
        Acopios_TX_SinControl
        Acopios_TX_SinFechaNecesidad
        Acopios_TX_Sumarizadas
        Acopios_TX_TodasLasRevisiones
        Acopios_TX_TodosLosDetalles
        Acopios_TX_TT
        Acopios_TXItems
        Acopios_TXItems1
        Acopios_TXNombre
        Acopios_TXNro
        Acopios_TXPorObra
        Acopios_TXTLObra
        AcoSchedulers_A
        AcoSchedulers_E
        AcoSchedulers_M
        AcoSchedulers_T
        AcoSchedulers_TT
        AcoSchedulers_TX_TT
        AcoSchedulers_TXTL
        AcoSeries_A
        AcoSeries_E
        AcoSeries_M
        AcoSeries_T
        AcoSeries_TT
        AcoSeries_TX_TT
        AcoSeries_TXTL
        AcoTipos_A
        AcoTipos_E
        AcoTipos_M
        AcoTipos_T
        AcoTipos_TT
        AcoTipos_TX_TT
        AcoTipos_TXTL
        AcoTiposRosca_A
        AcoTiposRosca_E
        AcoTiposRosca_M
        AcoTiposRosca_T
        AcoTiposRosca_TT
        AcoTiposRosca_TX_TT
        AcoTiposRosca_TXTL
        AcoTratamientos_A
        AcoTratamientos_E
        AcoTratamientos_M
        AcoTratamientos_T
        AcoTratamientos_TT
        AcoTratamientos_TX_TT
        AcoTratamientos_TXTL
        ActividadesProveedores_A
        ActividadesProveedores_E
        ActividadesProveedores_M
        ActividadesProveedores_T
        ActividadesProveedores_TL
        ActividadesProveedores_TT
        ActividadesProveedores_TX_TT
        AjustesStock_A
        AjustesStock_ActualizarDetalles
        AjustesStock_E
        AjustesStock_M
        AjustesStock_T
        AjustesStock_TT
        AjustesStock_TX_PorIdOrigen
        AjustesStock_TX_PorIdOrigenDetalle
        AjustesStock_TX_PorMarbete
        AjustesStock_TX_Todos
        AjustesStock_TX_TT
        AjustesStock_TXAnio
        AjustesStock_TXFecha
        AjustesStock_TXMes
        AjustesStockSAT_A
        AjustesStockSAT_ActualizarDetalles
        AjustesStockSAT_M
        AjustesStockSAT_T
        AjustesStockSAT_TX_PorIdOrigen
        AjustesStockSAT_TX_PorIdOrigenDetalle
        AjustesStockSAT_TX_Todos
        AjustesStockSAT_TXAnio
        AjustesStockSAT_TXFecha
        AjustesStockSAT_TXMes
        AlimentacionesElectricas_A
        AlimentacionesElectricas_E
        AlimentacionesElectricas_M
        AlimentacionesElectricas_T
        AlimentacionesElectricas_TL
        AlimentacionesElectricas_TT
        AlimentacionesElectricas_TX_TT
        AnexosEquipos_A
        AnexosEquipos_E
        AnexosEquipos_M
        AnexosEquipos_T
        AnexosEquipos_TL
        AnexosEquipos_TT
        AnexosEquipos_TX_TT
        AniosNorma_A
        AniosNorma_E
        AniosNorma_M
        AniosNorma_T
        AniosNorma_TL
        AniosNorma_TT
        AniosNorma_TX_TT
        AnticiposAlPersonal_A
        AnticiposAlPersonal_BorrarPorIdOrdenPago
        AnticiposAlPersonal_BorrarPorIdRecibo
        AnticiposAlPersonal_E
        AnticiposAlPersonal_M
        AnticiposAlPersonal_T
        AnticiposAlPersonal_TT
        AnticiposAlPersonal_TX_Asiento
        AnticiposAlPersonal_TX_Detallado
        AnticiposAlPersonal_TX_Estructura
        AnticiposAlPersonal_TX_OPago
        AnticiposAlPersonal_TX_Recibo
        AnticiposAlPersonal_TX_Resumido
        AnticiposAlPersonal_TX_Todos
        AnticiposAlPersonal_TXPrimero
        AnticiposAlPersonal_TXPrimeroRecibo
        AnticiposAlPersonalSyJ_A
        AnticiposAlPersonalSyJ_E
        AnticiposAlPersonalSyJ_M
        AnticiposAlPersonalSyJ_T
        AnticiposAlPersonalSyJ_TransferirAnticiposAlSyJ
        AnticiposAlPersonalSyJ_TT
        AnticiposAlPersonalSyJ_TX_Conceptos
        AnticiposAlPersonalSyJ_TX_EmpleadosActivos
        AnticiposAlPersonalSyJ_TX_ParametrosLiquidaciones
        ArchivosATransmitir_TT
        ArchivosATransmitir_TX_PorSistema
        ArchivosATransmitirDestinos_A
        ArchivosATransmitirDestinos_E
        ArchivosATransmitirDestinos_M
        ArchivosATransmitirDestinos_T
        ArchivosATransmitirDestinos_TL
        ArchivosATransmitirDestinos_TT
        ArchivosATransmitirDestinos_TX_Activos
        ArchivosATransmitirDestinos_TX_ActivosPorSistema
        ArchivosATransmitirDestinos_TX_ActivosPorSistemaParaCombo
        ArchivosATransmitirDestinos_TX_Todos
        ArchivosATransmitirDestinos_TX_TT
        ArchivosATransmitirLoteo_A
        ArchivosATransmitirLoteo_E
        ArchivosATransmitirLoteo_M
        ArchivosATransmitirLoteo_T
        ArchivosATransmitirLoteo_TT
        ArchivosATransmitirLoteo_TX_EstadoGeneral
        ArchivosATransmitirLoteo_TX_PorArchivoLote
        ArchivosATransmitirLoteo_TX_UltimoLote
        Articulos_A
        Articulos_BorrarPorIdRubro
        Articulos_C
        Articulos_E
        Articulos_M
        Articulos_RecalcularCostoPPP_PorIdArticulo
        Articulos_RecalcularStock
        Articulos_RegistrarAlicuotaIVA
        Articulos_T
        Articulos_TL
        Articulos_TT
        Articulos_TX_AgrupadoPorFamilia
        Articulos_TX_AgrupadoPorRubro
        Articulos_TX_AgrupadoPorSubrubro
        Articulos_TX_AmortizacionesAFecha
        Articulos_TX_AmortizacionesAFechaPorRevaluo
        Articulos_TX_AmortizacionesAFechaPorRevaluoArticulo
        Articulos_TX_AVL
        Articulos_TX_BD_ProntoMantenimiento
        Articulos_TX_BD_ProntoMantenimientoExiste
        Articulos_TX_BD_ProntoMantenimientoPorId
        Articulos_TX_BD_ProntoMantenimientoPorNumeroInventario
        Articulos_TX_BD_ProntoMantenimientoTodos
        Articulos_TX_Busca
        Articulos_TX_BuscaConFormato
        Articulos_TX_Cardex
        Articulos_TX_Clave
        Articulos_TX_CostosImportacionAAsignar
        Articulos_TX_CostosPorEquipo
        Articulos_TX_DatosConCuenta
        Articulos_TX_EquiposTerceros
        Articulos_TX_HistoriaEquiposInstalados
        Articulos_TX_Inactivos
        Articulos_TX_ListaParaCardex
        Articulos_TX_ModificacionActivoFijo
        Articulos_TX_ModificacionActivoFijo_TT
        Articulos_TX_ParaMantenimiento_ParaCombo
        Articulos_TX_ParaMenu
        Articulos_TX_ParaMenu1
        Articulos_TX_ParaTransmitir
        Articulos_TX_ParaTransmitir_Todos
        Articulos_TX_ParaTransmitirPorIdRubros
        Articulos_TX_ParaTransmitirPRONTO_MANTENIMIENTO
        Articulos_TX_PorCodigo
        Articulos_TX_PorDescripcion
        Articulos_TX_PorDescripcionTipoParaCombo
        Articulos_TX_PorFechaAlta
        Articulos_TX_PorGrupo
        Articulos_TX_PorId
        Articulos_TX_PorIdConDatos
        Articulos_TX_PorIdRubro
        Articulos_TX_PorIdRubroParaCombo
        Articulos_TX_PorIdTipoParaCombo
        Articulos_TX_PorIdTipoParaLista
        Articulos_TX_PorIdTransportista
        Articulos_TX_PorNumeroInventario
        Articulos_TX_PorNumeroInventarioIdTransportista
        Articulos_TX_ProduciblesParaCombo
        Articulos_TX_ResumenRemitosPorRubro
        Articulos_TX_ResumenVentasPorRubro
        Articulos_TX_Resumidos
        Articulos_TX_RevaluosAFechaResumido
        Articulos_TX_SaldosDeStockAFecha
        Articulos_TX_SetearComoTransmitido
        Articulos_TX_Stock
        Articulos_TX_StockDet
        Articulos_TX_StockDetSinPartida
        Articulos_TX_StockPorArticuloPartidaUnidadUbicacionObra
        Articulos_TX_StockPorPartida
        Articulos_TX_StockTotalPorArticulo
        Articulos_TX_TodosParaCostos
        Articulos_TX_TT
        Articulos_TX_UnidadesHabilitadas
        Articulos_TX_ValidarCodigo
        Articulos_TX_ValidarNumeroInventario
        Articulos_TX_xDetLMat
        ArticulosInformacionAdicional_A
        ArticulosInformacionAdicional_E
        ArticulosInformacionAdicional_M
        ArticulosInformacionAdicional_T
        ArticulosInformacionAdicional_TX_PorArticulo
        Asientos_A
        Asientos_BorrarEntreFechas
        Asientos_CambiarNumero
        Asientos_E
        Asientos_Eliminar
        Asientos_EliminarDetalles
        Asientos_EliminarItemChequePagoDiferido
        Asientos_GenerarAsientoChequesDiferidos
        Asientos_M
        Asientos_T
        Asientos_TT
        Asientos_TX_DetallesPorIdAsiento
        Asientos_TX_EntreFechas
        Asientos_TX_PorArchivoImportacion
        Asientos_TX_PorNumero
        Asientos_TX_PorSubdiario
        Asientos_TX_TT
        Asientos_TXAnio
        Asientos_TXAsientosxAnio
        Asientos_TXCod
        Asientos_TXFecha
        Asientos_TXMes
        Asientos_TXMesAnio
        AsignacionesCostos_A
        AsignacionesCostos_E
        AsignacionesCostos_M
        AsignacionesCostos_T
        AsignacionesCostos_TT
        AsignacionesCostos_TX_PorIdCosto
        AsignacionesCostos_TX_TT
        Autorizaciones_A
        Autorizaciones_E
        Autorizaciones_M
        Autorizaciones_T
        Autorizaciones_TT
        Autorizaciones_TX_CantidadAutorizaciones
        Autorizaciones_TX_PorFormulario
        Autorizaciones_TX_PorIdFormulario
        Autorizaciones_TX_TT
        AutorizacionesPorComprobante_A
        AutorizacionesPorComprobante_DarPorVisto
        AutorizacionesPorComprobante_E
        AutorizacionesPorComprobante_Generar
        AutorizacionesPorComprobante_GenerarFirmas
        AutorizacionesPorComprobante_M
        AutorizacionesPorComprobante_T
        AutorizacionesPorComprobante_TT
        AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante
        AutorizacionesPorComprobante_TX_AutorizaPorSector
        AutorizacionesPorComprobante_TX_ComprobantesSinFirmar
        AutorizacionesPorComprobante_TX_DocumentosPorAutoriza
        AutorizacionesPorComprobante_TX_DocumentosPorAutorizaSuplentes
        AutorizacionesPorComprobante_TX_FirmasPendientes
        AutorizacionesPorComprobante_TX_PorIdPedido
        AutorizacionesPorComprobante_TX_PorIdRM
        AutorizacionesPorComprobante_TX_Sectores
        AutorizacionesPorComprobante_TX_SuplenteDelTitular
        BancoChequeras_A
        BancoChequeras_E
        BancoChequeras_M
        BancoChequeras_T
        BancoChequeras_TL
        BancoChequeras_TT
        BancoChequeras_TX_ActivasParaCombo
        BancoChequeras_TX_ActivasPorIdCuentaBancariaParaCombo
        BancoChequeras_TX_Inactivas
        BancoChequeras_TX_PorId
        BancoChequeras_TX_PorIdCuentaBancaria
        BancoChequeras_TX_TT
        Bancos_A
        Bancos_E
        Bancos_M
        Bancos_T
        Bancos_TL
        Bancos_TT
        Bancos_TX_ChequesDiferidosPendientesPorIdBanco
        Bancos_TX_ConCuenta
        Bancos_TX_ConCuenta1
        Bancos_TX_CuentasPorIdBanco
        Bancos_TX_HabilitadosParaCobroCuotas
        Bancos_TX_InformeChequesAnulados
        Bancos_TX_InformeChequesDiferidos
        Bancos_TX_InformeChequesDiferidos1
        Bancos_TX_InformeChequesDiferidosResumen
        Bancos_TX_MonedasParaPosicionFinanciera
        Bancos_TX_Movimientos
        Bancos_TX_MovimientosAnio
        Bancos_TX_MovimientosMes
        Bancos_TX_MovimientosPorCuenta
        Bancos_TX_MovimientosPorCuenta_Viejo
        Bancos_TX_PorCodigo
        Bancos_TX_PorCodigoUnico
        Bancos_TX_PorCuentasBancarias
        Bancos_TX_PorCuentasBancariasIdCuenta
        Bancos_TX_PorCuentasBancariasIdCuentaIdMoneda
        Bancos_TX_PorCuentasBancariasIdMoneda
        Bancos_TX_PorId
        Bancos_TX_PosicionBancariaAFecha
        Bancos_TX_PosicionFinancieraAFecha
        Bancos_TX_PosicionFinancieraAFechaPorIdCuentaBancaria
        Bancos_TX_PosicionFinancieraAFechaPorIdCuentaBancariaEnPesos
        Bancos_TX_Retenciones
        Bancos_TX_SaldosAFecha
        Bancos_TX_TT
        BD_TX_BaseDeDatos
        BD_TX_BasesInstaladas
        BD_TX_Campos
        BD_TX_Host
        BD_TX_Tablas
        Biselados_A
        Biselados_E
        Biselados_M
        Biselados_T
        Biselados_TL
        Biselados_TT
        Biselados_TX_TT
        BZ_Pesadas_A
        BZ_Pesadas_M
        BZ_Pesadas_T
        BZ_Pesadas_TL
        BZ_Pesadas_TT
        BZ_Pesadas_TX_Pendientes
        BZ_Pesadas_TX_TT
        Cajas_A
        Cajas_E
        Cajas_M
        Cajas_T
        Cajas_TL
        Cajas_TT
        Cajas_TX_PorCuentaContable
        Cajas_TX_PorDescripcion
        Cajas_TX_PorId
        Cajas_TX_PorIdCuenta
        Cajas_TX_PorIdCuentaParaCombo
        Cajas_TX_PorIdMoneda
        Cajas_TX_PosicionFinancieraAFecha
        Cajas_TX_PosicionFinancieraAFechaPorIdCaja
        Cajas_TX_PosicionFinancieraAFechaPorIdCajaEnPesos
        Cajas_TX_TodosSF
        Cajas_TX_TT
        Calidades_A
        Calidades_E
        Calidades_M
        Calidades_T
        Calidades_TL
        Calidades_TT
        Calidades_TX_TT
        CalidadesClad_A
        CalidadesClad_E
        CalidadesClad_M
        CalidadesClad_T
        CalidadesClad_TL
        CalidadesClad_TT
        CalidadesClad_TX_TT
        Cargos_A
        Cargos_E
        Cargos_M
        Cargos_T
        Cargos_TL
        Cargos_TT
        Cargos_TX_TT
        CashFlow
        CentrosCosto_A
        CentrosCosto_E
        CentrosCosto_M
        CentrosCosto_T
        CentrosCosto_TL
        CentrosCosto_TT
        CentrosCosto_TX_TT
        CertificacionesObras_A
        CertificacionesObras_ActualizarDetalles
        CertificacionesObras_ActualizarPorNumeroCertificado
        CertificacionesObras_E
        CertificacionesObras_M
        CertificacionesObras_Recalcular
        CertificacionesObras_T
        CertificacionesObras_TT
        CertificacionesObras_TX_DetallePxQ
        CertificacionesObras_TX_EtapasPorNumeroCertificado
        CertificacionesObras_TX_Ordenado
        CertificacionesObras_TX_ParaArbol
        CertificacionesObras_TX_PorNodo
        CertificacionesObras_TX_PorNumeroCertificado
        CertificacionesObras_TX_TT
        Choferes_A
        Choferes_E
        Choferes_M
        Choferes_T
        Choferes_TL
        Choferes_TT
        Choferes_TX_TT
        Clausulas_A
        Clausulas_E
        Clausulas_M
        Clausulas_T
        Clausulas_TL
        Clausulas_TT
        Clausulas_TX_PorId
        Clausulas_TX_TT
        Clientes_A
        Clientes_ActualizarComprobantes
        Clientes_ActualizarDatosIIBB
        Clientes_E
        Clientes_M
        Clientes_T
        Clientes_TL
        Clientes_TT
        Clientes_TX_AConfirmar
        Clientes_TX_AnalisisCobranzaFacturacion
        Clientes_TX_Busca
        Clientes_TX_Busca1
        Clientes_TX_Comprobantes
        Clientes_TX_Comprobantes_Modelo2
        Clientes_TX_Detallado
        Clientes_TX_Entregas
        Clientes_TX_LugaresEntrega
        Clientes_TX_ParaTransmitir
        Clientes_TX_ParaTransmitir_Todos
        Clientes_TX_PercepcionesIIBB
        Clientes_TX_PercepcionesIVA
        Clientes_TX_PorCodigo
        Clientes_TX_PorCodigoCliente
        Clientes_TX_PorCuit
        Clientes_TX_PorId
        Clientes_TX_PorIdConDatos
        Clientes_TX_PorRazonSocial
        Clientes_TX_RankingVentas
        Clientes_TX_RankingVentasCantidades
        Clientes_TX_RankingVentasPorVendedor
        Clientes_TX_ResumenVentas
        Clientes_TX_Resumido
        Clientes_TX_RetencionesGanancias
        Clientes_TX_RetencionesIIBB_Cobranzas
        Clientes_TX_RetencionesIVA
        Clientes_TX_RetencionesSUSS
        Clientes_TX_SetearComoTransmitido
        Clientes_TX_SoloCuit
        Clientes_TX_TT
        Clientes_TX_ValidarCodigo
        Codigos_A
        Codigos_E
        Codigos_M
        Codigos_T
        Codigos_TL
        Codigos_TT
        Codigos_TX_TT
        CodigosUniversales_A
        CodigosUniversales_E
        CodigosUniversales_M
        CodigosUniversales_T
        CodigosUniversales_TL
        CodigosUniversales_TT
        CodigosUniversales_TX_TT
        CoeficientesContables_A
        CoeficientesContables_E
        CoeficientesContables_M
        CoeficientesContables_T
        CoeficientesContables_TT
        CoeficientesContables_TX_TT
        CoeficientesImpositivos_A
        CoeficientesImpositivos_E
        CoeficientesImpositivos_M
        CoeficientesImpositivos_T
        CoeficientesImpositivos_TT
        CoeficientesImpositivos_TX_TT
        Colores_A
        Colores_E
        Colores_M
        Colores_T
        Colores_TL
        Colores_TT
        Colores_TX_TT
        Comparativas_A
        Comparativas_E
        Comparativas_M
        Comparativas_T
        Comparativas_TL
        Comparativas_TT
        Comparativas_TX_ItemsSeleccionados
        Comparativas_TX_PorNumero
        Comparativas_TX_PorPresupuesto
        Comparativas_TX_PorPresupuestoSoloSeleccionados
        Comparativas_TX_TT
        Comparativas_TXAnio
        Comparativas_TXFecha
        Comparativas_TXMes
        Comparativas_TXMesAnio
        ComprobantesProveedores_A
        ComprobantesProveedores_AnularVale
        ComprobantesProveedores_E
        ComprobantesProveedores_EliminarComprobante
        ComprobantesProveedores_EliminarComprobanteAConfirmar
        ComprobantesProveedores_GrabarDestinoPago
        ComprobantesProveedores_GrabarVale
        ComprobantesProveedores_ImputarOPRetencionIVAAplicada
        ComprobantesProveedores_M
        ComprobantesProveedores_T
        ComprobantesProveedores_TT
        ComprobantesProveedores_TX_AConfirmar
        ComprobantesProveedores_TX_AnticiposPorIdPedido
        ComprobantesProveedores_TX_ConAnticipoPorIdComprobanteProveedor
        ComprobantesProveedores_TX_DatosPorIdDetalleRecepcion
        ComprobantesProveedores_TX_DetallePorIdCabecera
        ComprobantesProveedores_TX_DetallePorIdDetalleRecepcion
        ComprobantesProveedores_TX_DetallePorRendicionFF
        ComprobantesProveedores_TX_DistribucionPorIdPedido
        ComprobantesProveedores_TX_PorId
        ComprobantesProveedores_TX_PorIdConDatos
        ComprobantesProveedores_TX_PorIdOrdenPago
        ComprobantesProveedores_TX_PorNumeroComprobante
        ComprobantesProveedores_TX_PorNumeroReferencia
        ComprobantesProveedores_TX_PorPRESTOFactura
        ComprobantesProveedores_TX_ReintegrosDetallados
        ComprobantesProveedores_TX_ResumenPorRendicionFF
        ComprobantesProveedores_TX_RubrosFinancierosAgrupados
        ComprobantesProveedores_TX_Todos
        ComprobantesProveedores_TX_TodosSF_HastaFecha
        ComprobantesProveedores_TX_TotalBSUltimoAño
        ComprobantesProveedores_TX_TT
        ComprobantesProveedores_TX_UltimoComprobantePorIdProveedor
        ComprobantesProveedores_TX_VerificarProveedor
        ComprobantesProveedores_TX_VerificarProveedorNoConfirmado
        ComprobantesProveedores_TXAnio
        ComprobantesProveedores_TXFecha
        ComprobantesProveedores_TXMes
        Conceptos_A
        Conceptos_E
        Conceptos_M
        Conceptos_T
        Conceptos_TL
        Conceptos_TT
        Conceptos_TX_PorGrupo
        Conceptos_TX_PorGrupoParaCombo
        Conceptos_TX_PorIdConDatos
        Conceptos_TX_TT
        Conciliaciones_A
        Conciliaciones_BorrarPorIdValor
        Conciliaciones_E
        Conciliaciones_M
        Conciliaciones_QuitarMarcaAprobacion
        Conciliaciones_T
        Conciliaciones_TT
        Conciliaciones_TX_DetallePorIdValor_ConFormato
        Conciliaciones_TX_NoConciliadosAnterior
        Conciliaciones_TX_SaldoFinalResumenAnterior
        Conciliaciones_TX_SaldosSegunExtractos
        Conciliaciones_TX_TT
        Conciliaciones_TX_ValidarNumeroResumen
        Conciliaciones_TXAnio
        Conciliaciones_TXFecha
        Conciliaciones_TXMes
        CondicionesCompra_A
        CondicionesCompra_E
        CondicionesCompra_M
        CondicionesCompra_T
        CondicionesCompra_TL
        CondicionesCompra_TT
        CondicionesCompra_TX_PorId
        CondicionesCompra_TX_TodosSF
        CondicionesCompra_TX_TT
        Conjuntos_A
        Conjuntos_CalcularCostoConjunto_Todos
        Conjuntos_CalcularCostoConjuntoDesdeComponente
        Conjuntos_E
        Conjuntos_Eliminar
        Conjuntos_M
        Conjuntos_T
        Conjuntos_TT
        Conjuntos_TX_DetallesPorId
        Conjuntos_TX_DetallesPorIdArticulo
        Conjuntos_TX_Finales
        Conjuntos_TX_PorIdArticulo
        Conjuntos_TX_PorIdConDatos
        Conjuntos_TX_Subconjuntos
        Conjuntos_TX_Todos
        Conjuntos_TX_TT
        Consulta_TX_PorSQL
        ConsultaStockCompleto_TX1
        ConsultaStockCompleto_TX2
        ControlCalidad_M
        ControlCalidad_T
        ControlCalidad_TT
        ControlCalidad_TX_Controlados
        ControlCalidad_TX_PorRemito
        ControlCalidad_TX_Todos
        ControlCalidad_TX_TT
        ControlCalidad_TX_Ultimos3Meses
        ControlesCalidad_A
        ControlesCalidad_E
        ControlesCalidad_M
        ControlesCalidad_T
        ControlesCalidad_TL
        ControlesCalidad_TT
        ControlesCalidad_TX_Alfabetico
        ControlesCalidad_TX_PorId
        ControlesCalidad_TX_TT
        CostosImportacion_A
        CostosImportacion_E
        CostosImportacion_M
        CostosImportacion_T
        CostosImportacion_TT
        CostosImportacion_TX_PorArticulo
        CostosImportacion_TX_PorId
        CostosImportacion_TX_TT
        CostosImportacion_TXCos
        CostosPromedios_A
        CostosPromedios_M
        CostosPromedios_TX_DetalladoPorIdArticulo
        CostosPromedios_TX_Estructura
        CostosPromedios_TX_PorArticulo
        CostosPromedios_TX_PorArticuloEnDolares
        CostosPromedios_TX_PorIdDetalleAjusteStock
        CostosPromedios_TX_PorIdDetalleDevolucion
        CostosPromedios_TX_PorIdDetalleOtroIngresoAlmacen
        CostosPromedios_TX_PorIdDetalleRecepcion
        CostosPromedios_TX_PorIdDetalleRemito
        CostosPromedios_TX_PorIdDetalleSalidaMateriales
        CostosPromedios_TX_PorIdDetalleValeSalida
        Cotizaciones_A
        Cotizaciones_E
        Cotizaciones_M
        Cotizaciones_T
        Cotizaciones_TT
        Cotizaciones_TX_ParaTransmitir
        Cotizaciones_TX_PorFechaMoneda
        Cotizaciones_TX_TT
        Cotizaciones_TXAnio
        Cotizaciones_TXFecha
        Cotizaciones_TXMes
        CtasCtesA_A
        CtasCtesA_CrearTransaccion
        CtasCtesA_E
        CtasCtesA_M
        CtasCtesA_ProyeccionEgresosParaCubo
        CtasCtesA_ProyeccionEgresosParaCubo1
        CtasCtesA_ReimputarComprobante
        CtasCtesA_T
        CtasCtesA_TT
        CtasCtesA_TX_ACancelar
        CtasCtesA_TX_BuscarComprobante
        CtasCtesA_TX_DetallePorTipoDeProveedor
        CtasCtesA_TX_DeudaVencida
        CtasCtesA_TX_DeudaVencidaPorMesCalendario
        CtasCtesA_TX_Imputacion
        CtasCtesA_TX_PendientesDeImputacion
        CtasCtesA_TX_PorDetalleOrdenPago
        CtasCtesA_TX_PorIdConSigno
        CtasCtesA_TX_PorNumeroInterno
        CtasCtesA_TX_PorTrsParaCubo
        CtasCtesA_TX_SaldosAFecha
        CtasCtesA_TX_SaldosAFechaDetallado
        CtasCtesA_TX_SaldosEntreFechas
        CtasCtesA_TX_SaldosEntreFechasResumido
        CtasCtesA_TX_Struc
        CtasCtesA_TX_TT
        CtasCtesA_TXParaImputar
        CtasCtesA_TXParaImputar_Dolares
        CtasCtesA_TXParaImputar_Euros
        CtasCtesA_TXPorMayor
        CtasCtesA_TXPorMayor_Dolares
        CtasCtesA_TXPorMayor_Euros
        CtasCtesA_TXPorMayor_OtrasMonedas
        CtasCtesA_TXPorTrs
        CtasCtesA_TXPorTrs_Dolares
        CtasCtesA_TXPorTrs_Euros
        CtasCtesA_TXPorTrs_MonedaOriginal
        CtasCtesA_TXTotal
        CtasCtesA_TXTotal_Dolares
        CtasCtesA_TXTotal_Euros
        CtasCtesD_A
        CtasCtesD_ActualizarComprobantes
        CtasCtesD_CrearTransaccion
        CtasCtesD_E
        CtasCtesD_M
        CtasCtesD_ReimputarComprobante
        CtasCtesD_T
        CtasCtesD_TT
        CtasCtesD_TX_ACancelar
        CtasCtesD_TX_BuscarComprobante
        CtasCtesD_TX_CreditosVencidos
        CtasCtesD_TX_DeudaVencida
        CtasCtesD_TX_Imputacion
        CtasCtesD_TX_ParaGeneracionDePagos
        CtasCtesD_TX_ParaTransmitir
        CtasCtesD_TX_PorDetalleRecibo
        CtasCtesD_TX_PorId
        CtasCtesD_TX_PorIdComprobanteIdCliente
        CtasCtesD_TX_PorIdConSigno
        CtasCtesD_TX_PorIdDetalleNotaCreditoImputaciones
        CtasCtesD_TX_PorIdOrigen
        CtasCtesD_TX_SaldosAFecha
        CtasCtesD_TX_SaldosAFechaDetallado
        CtasCtesD_TX_SetearComoTransmitido
        CtasCtesD_TX_Struc
        CtasCtesD_TX_TT
        CtasCtesD_TXParaImputar
        CtasCtesD_TXParaImputar_Dolares
        CtasCtesD_TXPorMayor
        CtasCtesD_TXPorMayor_Dolares
        CtasCtesD_TXPorMayor_OtrasMonedas
        CtasCtesD_TXPorTrs
        CtasCtesD_TXPorTrs_Dolares
        CtasCtesD_TXPorTrs_MonedaOriginal
        CtasCtesD_TXTotal
        CtasCtesD_TXTotal_Dolares
        Cuantificacion_TL
        CuboComparativas
        CuboCostosImportacion
        CuboDeVentas
        CuboDeVentasDetalladas
        CuboIngresoEgresosPorObra
        CuboIngresoEgresosPorObra1
        CuboIVAPorObra
        CuboPedidos
        CuboPosicionFinanciera
        CuboPresupuestoFinanciero
        CuboPresupuestoFinanciero2
        CuboPresupuestoFinanciero3
        CuboPresupuestoFinancieroTeorico
        CuboPresupuestoFinancieroTeoricoA
        CuboReservaPresupuestaria
        Cubos_TX_ControlarContenidoDeDatos
        CuboSaldosComprobantesPorObraProveedor
        CuboSaldosComprobantesPorObraProveedorA
        CuboStock
        CuboVentasEnCuotas
        Cuentas_A
        Cuentas_Consolidacion
        Cuentas_CuadroGastosPorObra
        Cuentas_CuadroGastosPorObraDetallado
        Cuentas_DistribuirPresupuestoEconomicoPorMatriz
        Cuentas_E
        Cuentas_IncrementarRendicionFF
        Cuentas_M
        Cuentas_T
        Cuentas_TL
        Cuentas_TT
        Cuentas_TX_AsientoAperturaEjercicio
        Cuentas_TX_AsientoCierreEjercicio
        Cuentas_TX_AsientoCierreEjercicio1
        Cuentas_TX_BalanceConApertura
        Cuentas_TX_BalanceConAperturaParaCubo
        Cuentas_TX_BalanceConAperturaResumen
        Cuentas_TX_ConMovimientos
        Cuentas_TX_CuentaCajaBanco
        Cuentas_TX_CuentaParaAjusteSubdiario
        Cuentas_TX_CuentasConsolidacionParaCombo
        Cuentas_TX_CuentasConsolidacionPorCodigo
        Cuentas_TX_CuentasConsolidacionPorIdCuenta
        Cuentas_TX_CuentasDependientesPorIdCuenta
        Cuentas_TX_CuentasGastoPorObraParaCombo
        Cuentas_TX_DesdeHasta
        Cuentas_TX_DesdeHastaConSaldos
        Cuentas_TX_DesdeHastaConSaldosConGastosTotalizados
        Cuentas_TX_EstadoResultados1
        Cuentas_TX_FondosFijos
        Cuentas_TX_MayorPorIdCuentaEntreFechas
        Cuentas_TX_MayorPorIdCuentaEntreFechasSinCIE
        Cuentas_TX_ParaComprobantesProveedores
        Cuentas_TX_ParaTransmitir
        Cuentas_TX_ParaTransmitir_Todos
        Cuentas_TX_PorCodigo
        Cuentas_TX_PorCodigoDescripcionParaCombo
        Cuentas_TX_PorCodigoJerarquia
        Cuentas_TX_PorCodigoSecundario
        Cuentas_TX_PorDescripcionCodigoParaCombo
        Cuentas_TX_PorFechaParaCombo
        Cuentas_TX_PorGrupoParaCombo
        Cuentas_TX_PorGruposParaCombo
        Cuentas_TX_PorId
        Cuentas_TX_PorIdConDatos
        Cuentas_TX_PorIdPorFecha
        Cuentas_TX_PorJerarquia
        Cuentas_TX_PorObraCuentaGasto
        Cuentas_TX_PorObraCuentaMadre
        Cuentas_TX_PorRubrosContables
        Cuentas_TX_PresupuestoEconomico
        Cuentas_TX_PresupuestoEconomicoParaCubo
        Cuentas_TX_PresupuestoEconomicoPorIdCuentaMesAño
        Cuentas_TX_PresupuestoEconomicoPorTipoCuenta
        Cuentas_TX_PresupuestoEconomicoResumidoParaCubo
        Cuentas_TX_PrimerCodigo
        Cuentas_TX_ProximoCodigoLibre
        Cuentas_TX_ResultadoCierreAnterior
        Cuentas_TX_SetearComoTransmitido
        Cuentas_TX_SinCuentasGastosObras
        Cuentas_TX_SinObrasParaCombo
        Cuentas_TX_TT
        Cuentas_TX_TT_PresupuestoEconomico
        Cuentas_TX_UltimoCodigo
        Cuentas_TXCod
        CuentasBancarias_A
        CuentasBancarias_E
        CuentasBancarias_M
        CuentasBancarias_T
        CuentasBancarias_TT
        CuentasBancarias_TX_PorCuenta
        CuentasBancarias_TX_PorId
        CuentasBancarias_TX_PorIdBanco
        CuentasBancarias_TX_PorIdConCuenta
        CuentasBancarias_TX_TodasParaCombo
        CuentasBancarias_TX_TodosSF
        CuentasBancarias_TX_TT
        CuentasEjerciciosContables_A
        CuentasEjerciciosContables_E
        CuentasEjerciciosContables_M
        CuentasEjerciciosContables_T
        CuentasGastos_A
        CuentasGastos_E
        CuentasGastos_M
        CuentasGastos_MarcarComoActiva
        CuentasGastos_T
        CuentasGastos_TL
        CuentasGastos_TT
        CuentasGastos_TX_PorCodigo
        CuentasGastos_TX_PorCodigo2
        CuentasGastos_TX_PorId
        CuentasGastos_TX_PorIdCuentaMadre
        CuentasGastos_TX_TodasActivas
        CuentasGastos_TX_Todos
        CuentasGastos_TX_TT
        DefinicionAnulaciones_A
        DefinicionAnulaciones_M
        DefinicionAnulaciones_T
        DefinicionAnulaciones_TX_PorIdFormulario
        DefinicionArticulos_A
        DefinicionArticulos_E
        DefinicionArticulos_M
        DefinicionArticulos_T
        DefinicionArticulos_TL
        DefinicionArticulos_TT
        DefinicionArticulos_TX_AgrupadoPorRubro
        DefinicionArticulos_TX_Art
        DefinicionArticulos_TX_CamposPorGrupo
        DefinicionArticulos_TX_CamposPorIdRubro
        DefinicionArticulos_TX_Copia
        DefinicionArticulos_TX_Copiar
        DefinicionArticulos_TX_Grupos
        DefinicionArticulos_TX_PorIdRubro
        DefinicionArticulos_TX_PorRubro
        DefinicionArticulos_TX_Seleccion
        DefinicionArticulos_TX_TablaComboPorGrupoCampo
        DefinicionArticulos_TX_TT
        DefinicionesCuadrosContables_AgregarUnRegistro
        DefinicionesCuadrosContables_BorrarAsignacion
        DefinicionesCuadrosContables_Eliminar
        DefinicionesCuadrosContables_TX_DetalladoEntreFechas
        DefinicionesCuadrosContables_TX_Egresos
        DefinicionesCuadrosContables_TX_Ingresos
        DefinicionesCuadrosContables_TX_UnRegistro
        DefinicionesFlujoCaja_A
        DefinicionesFlujoCaja_M
        DefinicionesFlujoCaja_T
        DefinicionesFlujoCaja_TT
        DefinicionesFlujoCaja_TX_ControlDeItems
        DefinicionesFlujoCaja_TX_DetallesPorCodigo
        DefinicionesFlujoCaja_TX_PorCodigo
        DefinicionesFlujoCaja_TX_PresupuestosPorMesAño
        DefinicionesFlujoCaja_TX_TT
        Densidades_A
        Densidades_E
        Densidades_M
        Densidades_T
        Densidades_TL
        Densidades_TT
        Densidades_TX_TT
        Depositos_A
        Depositos_E
        Depositos_M
        Depositos_T
        Depositos_TL
        Depositos_TT
        Depositos_TX_ParaTransmitir
        Depositos_TX_PorIdObraParaCombo
        Depositos_TX_TT
        DepositosBancarios_A
        DepositosBancarios_E
        DepositosBancarios_M
        DepositosBancarios_T
        DepositosBancarios_TT
        DepositosBancarios_TX_DepositosEntreFechasParaExcel
        DepositosBancarios_TX_DetallesPorIdValor
        DepositosBancarios_TX_EntreFechas
        DepositosBancarios_TX_PorId
        DepositosBancarios_TX_TodosSF_HastaFecha
        DepositosBancarios_TX_TT
        DepositosBancarios_TX_Validar
        DepositosBancarios_TXAnio
        DepositosBancarios_TXFecha
        DepositosBancarios_TXMes
        DescripcionIva_T
        DescripcionIva_TL
        DescripcionIva_TT
        DescripcionIva_TX_PorId
        DescripcionIva_TX_TT
        DetAcoAcabados_A
        DetAcoAcabados_E
        DetAcoAcabados_T
        DetAcoAcabados_TT
        DetAcoAcabados_TXDetAco
        DetAcoAcabados_TXPrimero
        DetAcoBiselados_A
        DetAcoBiselados_E
        DetAcoBiselados_T
        DetAcoBiselados_TT
        DetAcoBiselados_TXDetAco
        DetAcoBiselados_TXPrimero
        DetAcoCalidades_A
        DetAcoCalidades_E
        DetAcoCalidades_T
        DetAcoCalidades_TT
        DetAcoCalidades_TXDetAco
        DetAcoCalidades_TXPrimero
        DetAcoCodigos_A
        DetAcoCodigos_E
        DetAcoCodigos_T
        DetAcoCodigos_TT
        DetAcoCodigos_TXDetAco
        DetAcoCodigos_TXPrimero
        DetAcoColores_A
        DetAcoColores_E
        DetAcoColores_T
        DetAcoColores_TT
        DetAcoColores_TXDetColor
        DetAcoColores_TXPrimero
        DetAcoFormas_A
        DetAcoFormas_E
        DetAcoFormas_T
        DetAcoFormas_TT
        DetAcoFormas_TXDetForma
        DetAcoFormas_TXPrimero
        DetAcoGrados_A
        DetAcoGrados_E
        DetAcoGrados_T
        DetAcoGrados_TT
        DetAcoGrados_TXDetAco
        DetAcoGrados_TXPrimero
        DetAcoHHItemsDocumentacion_A
        DetAcoHHItemsDocumentacion_E
        DetAcoHHItemsDocumentacion_T
        DetAcoHHItemsDocumentacion_TT
        DetAcoHHItemsDocumentacion_TXDetHHItemDocumentacion
        DetAcoHHItemsDocumentacion_TXPrimero
        DetAcoHHTareas_A
        DetAcoHHTareas_E
        DetAcoHHTareas_M
        DetAcoHHTareas_T
        DetAcoHHTareas_TT
        DetAcoHHTareas_TX_TodasLasTareas
        DetAcoHHTareas_TXDetHHTarea
        DetAcoMarcas_A
        DetAcoMarcas_E
        DetAcoMarcas_T
        DetAcoMarcas_TT
        DetAcoMarcas_TXDetMarca
        DetAcoMarcas_TXPrimero
        DetAcoMateriales_A
        DetAcoMateriales_E
        DetAcoMateriales_T
        DetAcoMateriales_TT
        DetAcoMateriales_TXDetAco
        DetAcoMateriales_TXPrimero
        DetAcoModelos_A
        DetAcoModelos_E
        DetAcoModelos_T
        DetAcoModelos_TT
        DetAcoModelos_TXDetModelo
        DetAcoModelos_TXPrimero
        DetAcoNormas_A
        DetAcoNormas_E
        DetAcoNormas_T
        DetAcoNormas_TT
        DetAcoNormas_TXDetAco
        DetAcoNormas_TXPrimero
        DetAcopios_A
        DetAcopios_E
        DetAcopios_M
        DetAcopios_T
        DetAcopios_TX_ParaTransmitir
        DetAcopios_TX_ParaTransmitir_Todos
        DetAcopios_TX_SetearComoTransmitido
        DetAcopios_TX_UnItem
        DetAcopios_TXAco
        DetAcopios_TXAcoSF
        DetAcopios_TXPrimero
        DetAcopiosEquipos_A
        DetAcopiosEquipos_E
        DetAcopiosEquipos_M
        DetAcopiosEquipos_T
        DetAcopiosEquipos_TX_ParaTransmitir
        DetAcopiosEquipos_TX_ParaTransmitir_Todos
        DetAcopiosEquipos_TX_SetearComoTransmitido
        DetAcopiosEquipos_TXAcoEqu
        DetAcopiosEquipos_TXPrimero
        DetAcopiosRevisiones_A
        DetAcopiosRevisiones_E
        DetAcopiosRevisiones_M
        DetAcopiosRevisiones_T
        DetAcopiosRevisiones_TX_ParaTransmitir
        DetAcopiosRevisiones_TX_ParaTransmitir_Todos
        DetAcopiosRevisiones_TX_SetearComoTransmitido
        DetAcopiosRevisiones_TXAcoRev
        DetAcopiosRevisiones_TXAcoRevTodos
        DetAcopiosRevisiones_TXPrimero
        DetAcoSchedulers_A
        DetAcoSchedulers_E
        DetAcoSchedulers_T
        DetAcoSchedulers_TT
        DetAcoSchedulers_TXDetAco
        DetAcoSchedulers_TXPrimero
        DetAcoSeries_A
        DetAcoSeries_E
        DetAcoSeries_T
        DetAcoSeries_TT
        DetAcoSeries_TXDetAco
        DetAcoSeries_TXPrimero
        DetAcoTipos_A
        DetAcoTipos_E
        DetAcoTipos_T
        DetAcoTipos_TT
        DetAcoTipos_TXDetAco
        DetAcoTipos_TXPrimero
        DetAcoTiposRosca_A
        DetAcoTiposRosca_E
        DetAcoTiposRosca_T
        DetAcoTiposRosca_TT
        DetAcoTiposRosca_TXDetAco
        DetAcoTiposRosca_TXPrimero
        DetAcoTratamientos_A
        DetAcoTratamientos_E
        DetAcoTratamientos_T
        DetAcoTratamientos_TT
        DetAcoTratamientos_TXDetAco
        DetAcoTratamientos_TXPrimero
        DetAjustesStock_A
        DetAjustesStock_E
        DetAjustesStock_M
        DetAjustesStock_T
        DetAjustesStock_TXAjStk
        DetAjustesStock_TXPrimero
        DetAjustesStockSAT_A
        DetAjustesStockSAT_M
        DetAjustesStockSAT_T
        DetArticulosActivosFijos_A
        DetArticulosActivosFijos_E
        DetArticulosActivosFijos_M
        DetArticulosActivosFijos_T
        DetArticulosActivosFijos_TX_AFijos
        DetArticulosActivosFijos_TXPrimero
        DetArticulosDocumentos_A
        DetArticulosDocumentos_E
        DetArticulosDocumentos_M
        DetArticulosDocumentos_T
        DetArticulosDocumentos_TX_Doc
        DetArticulosDocumentos_TXPrimero
        DetArticulosImagenes_A
        DetArticulosImagenes_E
        DetArticulosImagenes_M
        DetArticulosImagenes_T
        DetArticulosImagenes_TX_Img
        DetArticulosImagenes_TXPrimero
        DetArticulosUnidades_A
        DetArticulosUnidades_E
        DetArticulosUnidades_M
        DetArticulosUnidades_T
        DetArticulosUnidades_TX_ParaTransmitir
        DetArticulosUnidades_TX_Uni
        DetArticulosUnidades_TXPrimero
        DetAsientos_A
        DetAsientos_E
        DetAsientos_M
        DetAsientos_T
        DetAsientos_TT
        DetAsientos_TX_Estructura
        DetAsientos_TX_PorIdDetalleAsiento
        DetAsientos_TX_PorIdValor
        DetAsientos_TX_PorSubdiario
        DetAsientos_TXAsi
        DetAsientos_TXPrimero
        DetAutorizaciones_A
        DetAutorizaciones_E
        DetAutorizaciones_M
        DetAutorizaciones_T
        DetAutorizaciones_TXAut
        DetAutorizaciones_TXPrimero
        DetClientes_A
        DetClientes_E
        DetClientes_M
        DetClientes_T
        DetClientes_TX_TodosSinFormato
        DetClientes_TXDetCli
        DetClientes_TXPrimero
        DetClientesLugaresEntrega_A
        DetClientesLugaresEntrega_E
        DetClientesLugaresEntrega_M
        DetClientesLugaresEntrega_T
        DetClientesLugaresEntrega_TX_TodosSinFormato
        DetClientesLugaresEntrega_TXDet
        DetClientesLugaresEntrega_TXPrimero
        DetComparativas_A
        DetComparativas_E
        DetComparativas_M
        DetComparativas_T
        DetComparativas_TXCom
        DetComprobantesProveedores_A
        DetComprobantesProveedores_E
        DetComprobantesProveedores_M
        DetComprobantesProveedores_T
        DetComprobantesProveedores_TT
        DetComprobantesProveedores_TX_Estructura
        DetComprobantesProveedores_TX_PorIdCabecera
        DetComprobantesProveedores_TXComp
        DetComprobantesProveedores_TXPrimero
        DetComprobantesProveedoresPrv_A
        DetComprobantesProveedoresPrv_E
        DetComprobantesProveedoresPrv_M
        DetComprobantesProveedoresPrv_T
        DetComprobantesProveedoresPrv_TX_Estructura
        DetComprobantesProveedoresPrv_TXComp
        DetComprobantesProveedoresPrv_TXPrimero
        DetConciliaciones_A
        DetConciliaciones_E
        DetConciliaciones_M
        DetConciliaciones_T
        DetConciliaciones_TX_Conciliados
        DetConciliaciones_TX_ConfirmadoPorIdValor
        DetConciliaciones_TX_NoConciliados
        DetConciliaciones_TX_PorIdValorConFormato
        DetConciliaciones_TXConc
        DetConciliaciones_TXPrimero
        DetConciliacionesNoContables_A
        DetConciliacionesNoContables_E
        DetConciliacionesNoContables_M
        DetConciliacionesNoContables_T
        DetConciliacionesNoContables_TX_NoCaducados
        DetConciliacionesNoContables_TX_UltimoResumen
        DetConciliacionesNoContables_TXConc
        DetConciliacionesNoContables_TXPrimero
        DetConjuntos_A
        DetConjuntos_E
        DetConjuntos_M
        DetConjuntos_T
        DetConjuntos_TX_Todos
        DetConjuntos_TXConj
        DetConjuntos_TXPrimero
        DetControlesCalidad_A
        DetControlesCalidad_E
        DetControlesCalidad_GrabarRemitoRechazo
        DetControlesCalidad_M
        DetControlesCalidad_T
        DetControlesCalidad_TX_ConDatos
        DetControlesCalidad_TX_Controlados
        DetControlesCalidad_TXCal
        DetControlesCalidad_TXPrimero
        DetCuentas_A
        DetCuentas_E
        DetCuentas_M
        DetCuentas_T
        DetCuentas_TXDet
        DetCuentas_TXPrimero
        DetDefinicionAnulaciones_A
        DetDefinicionAnulaciones_E
        DetDefinicionAnulaciones_M
        DetDefinicionAnulaciones_T
        DetDefinicionAnulaciones_TXDet
        DetDefinicionAnulaciones_TXPrimero
        DetDefinicionesFlujoCajaCtas_A
        DetDefinicionesFlujoCajaCtas_E
        DetDefinicionesFlujoCajaCtas_M
        DetDefinicionesFlujoCajaCtas_T
        DetDefinicionesFlujoCajaCtas_TXDet
        DetDefinicionesFlujoCajaCtas_TXPrimero
        DetDefinicionesFlujoCajaPresu_A
        DetDefinicionesFlujoCajaPresu_E
        DetDefinicionesFlujoCajaPresu_M
        DetDefinicionesFlujoCajaPresu_T
        DetDefinicionesFlujoCajaPresu_TXDet
        DetDefinicionesFlujoCajaPresu_TXPrimero
        DetDepositosBancarios_A
        DetDepositosBancarios_E
        DetDepositosBancarios_M
        DetDepositosBancarios_T
        DetDepositosBancarios_TT
        DetDepositosBancarios_TX_Estructura
        DetDepositosBancarios_TX_PorIdCabecera
        DetDepositosBancarios_TXDep
        DetDepositosBancarios_TXPrimero
        DetDevoluciones_A
        DetDevoluciones_E
        DetDevoluciones_M
        DetDevoluciones_T
        DetDevoluciones_TT
        DetDevoluciones_TX_ConDatos
        DetDevoluciones_TX_Estructura
        DetDevoluciones_TX_PorIdCabecera
        DetDevoluciones_TXDev
        DetDevoluciones_TXPrimero
        DetDistribucionesObras_A
        DetDistribucionesObras_E
        DetDistribucionesObras_M
        DetDistribucionesObras_T
        DetDistribucionesObras_TXDet
        DetDistribucionesObras_TXPrimero
        DetEmpleados_A
        DetEmpleados_E
        DetEmpleados_M
        DetEmpleados_T
        DetEmpleados_TX_Emp
        DetEmpleados_TXPrimero
        DetEmpleadosJornadas_A
        DetEmpleadosJornadas_E
        DetEmpleadosJornadas_M
        DetEmpleadosJornadas_T
        DetEmpleadosJornadas_TX_EmpJor
        DetEmpleadosJornadas_TXPrimero
        DetEmpleadosSectores_A
        DetEmpleadosSectores_E
        DetEmpleadosSectores_M
        DetEmpleadosSectores_T
        DetEmpleadosSectores_TX_EmpSec
        DetEmpleadosSectores_TXPrimero
        DetEquipos_A
        DetEquipos_E
        DetEquipos_M
        DetEquipos_T
        DetEquipos_TX_ParaTransmitir
        DetEquipos_TX_ParaTransmitir_Todos
        DetEquipos_TX_SetearComoTransmitido
        DetEquipos_TXEquipo
        DetEquipos_TXPrimero
        DetEventosDelSistema_A
        DetEventosDelSistema_E
        DetEventosDelSistema_M
        DetEventosDelSistema_T
        DetEventosDelSistema_TX_PorEvento
        DetEventosDelSistema_TXPrimero
        DetFacturas_A
        DetFacturas_E
        DetFacturas_M
        DetFacturas_T
        DetFacturas_TT
        DetFacturas_TX_ConDatos
        DetFacturas_TX_ConDatosAgrupados
        DetFacturas_TX_Estructura
        DetFacturas_TX_ParaTransmitir
        DetFacturas_TX_PorIdCabecera
        DetFacturas_TX_SetearComoTransmitido
        DetFacturas_TXFac
        DetFacturas_TXPrimero
        DetFacturasClientesPRESTO_A
        DetFacturasClientesPRESTO_E
        DetFacturasClientesPRESTO_M
        DetFacturasClientesPRESTO_T
        DetFacturasClientesPRESTO_TT
        DetFacturasClientesPRESTO_TX_Estructura
        DetFacturasClientesPRESTO_TX_PorIdCabecera
        DetFacturasClientesPRESTO_TXFac
        DetFacturasClientesPRESTO_TXPrimero
        DetFacturasOrdenesCompra_A
        DetFacturasOrdenesCompra_E
        DetFacturasOrdenesCompra_M
        DetFacturasOrdenesCompra_T
        DetFacturasOrdenesCompra_TT
        DetFacturasOrdenesCompra_TX_Estructura
        DetFacturasOrdenesCompra_TXOrdenesCompra
        DetFacturasOrdenesCompra_TXPrimero
        DetFacturasProvincias_A
        DetFacturasProvincias_E
        DetFacturasProvincias_M
        DetFacturasProvincias_T
        DetFacturasProvincias_TX_Estructura
        DetFacturasProvincias_TXFac
        DetFacturasProvincias_TXPrimero
        DetFacturasRemitos_A
        DetFacturasRemitos_E
        DetFacturasRemitos_M
        DetFacturasRemitos_T
        DetFacturasRemitos_TT
        DetFacturasRemitos_TX_Estructura
        DetFacturasRemitos_TX_RemitosUnItemConFormato
        DetFacturasRemitos_TXPrimero
        DetFacturasRemitos_TXRemitos
        DetLMateriales_A
        DetLMateriales_E
        DetLMateriales_M
        DetLMateriales_T
        DetLMateriales_TX_PorLMat
        DetLMateriales_TX_UnItem
        DetLMateriales_TXLMat
        DetLMateriales_TXPrimero
        DetLMaterialesRevisiones_A
        DetLMaterialesRevisiones_E
        DetLMaterialesRevisiones_M
        DetLMaterialesRevisiones_T
        DetLMaterialesRevisiones_TX_Avances
        DetLMaterialesRevisiones_TX_Revisiones
        DetLMaterialesRevisiones_TXAcoRev
        DetLMaterialesRevisiones_TXPrimero
        DetLMaterialesRevisiones_TXPrimeroAvances
        DetNotasCredito_A
        DetNotasCredito_E
        DetNotasCredito_M
        DetNotasCredito_T
        DetNotasCredito_TT
        DetNotasCredito_TX_Estructura
        DetNotasCredito_TX_PorIdCabecera
        DetNotasCredito_TXCre
        DetNotasCredito_TXPrimero
        DetNotasCreditoImp_A
        DetNotasCreditoImp_E
        DetNotasCreditoImp_M
        DetNotasCreditoImp_T
        DetNotasCreditoImp_TT
        DetNotasCreditoImp_TX_Estructura
        DetNotasCreditoImp_TX_PorIdCabecera
        DetNotasCreditoImp_TX_PorIdDetalleNotaCreditoImputaciones
        DetNotasCreditoImp_TXCre
        DetNotasCreditoImp_TXPrimero
        DetNotasCreditoOC_A
        DetNotasCreditoOC_E
        DetNotasCreditoOC_M
        DetNotasCreditoOC_T
        DetNotasCreditoOC_TT
        DetNotasCreditoOC_TX_Estructura
        DetNotasCreditoOC_TX_PorIdNotasCredito
        DetNotasCreditoOC_TXCre
        DetNotasCreditoOC_TXPrimero
        DetNotasCreditoProvincias_A
        DetNotasCreditoProvincias_E
        DetNotasCreditoProvincias_M
        DetNotasCreditoProvincias_T
        DetNotasCreditoProvincias_TX_Estructura
        DetNotasCreditoProvincias_TXCre
        DetNotasCreditoProvincias_TXPrimero
        DetNotasDebito_A
        DetNotasDebito_E
        DetNotasDebito_M
        DetNotasDebito_T
        DetNotasDebito_TT
        DetNotasDebito_TX_Estructura
        DetNotasDebito_TX_PorIdCabecera
        DetNotasDebito_TXDeb
        DetNotasDebito_TXPrimero
        DetNotasDebitoProvincias_A
        DetNotasDebitoProvincias_E
        DetNotasDebitoProvincias_M
        DetNotasDebitoProvincias_T
        DetNotasDebitoProvincias_TX_Estructura
        DetNotasDebitoProvincias_TXDeb
        DetNotasDebitoProvincias_TXPrimero
        DetObrasDestinos_A
        DetObrasDestinos_E
        DetObrasDestinos_M
        DetObrasDestinos_T
        DetObrasDestinos_TX_ParaTransmitir_Todos
        DetObrasDestinos_TX_PorCodigo
        DetObrasDestinos_TXDestinos
        DetObrasDestinos_TXPrimero
        DetObrasEquiposInstalados_A
        DetObrasEquiposInstalados_E
        DetObrasEquiposInstalados_M
        DetObrasEquiposInstalados_T
        DetObrasEquiposInstalados_TX_PorIdObra
        DetObrasEquiposInstalados_TXEquipos
        DetObrasEquiposInstalados_TXPrimero
        DetObrasPolizas_A
        DetObrasPolizas_E
        DetObrasPolizas_M
        DetObrasPolizas_T
        DetObrasPolizas_TX_PorIdObra
        DetObrasPolizas_TXPolizas
        DetObrasPolizas_TXPrimero
        DetObrasRecepciones_A
        DetObrasRecepciones_E
        DetObrasRecepciones_M
        DetObrasRecepciones_T
        DetObrasRecepciones_TX_PorIdObra
        DetObrasRecepciones_TXPrimero
        DetObrasRecepciones_TXRecepciones
        DetObrasSectores_A
        DetObrasSectores_E
        DetObrasSectores_M
        DetObrasSectores_T
        DetObrasSectores_TX_Det
        DetObrasSectores_TXPrimero
        DetOrdenesCompra_A
        DetOrdenesCompra_E
        DetOrdenesCompra_M
        DetOrdenesCompra_T
        DetOrdenesCompra_TX_PorIdDetalleOrdenCompraConDatos
        DetOrdenesCompra_TX_PorIdOrdenPago
        DetOrdenesCompra_TXOCompra
        DetOrdenesCompra_TXPrimero
        DetOrdenesPago_A
        DetOrdenesPago_E
        DetOrdenesPago_M
        DetOrdenesPago_T
        DetOrdenesPago_TT
        DetOrdenesPago_TX_Estructura
        DetOrdenesPago_TX_PorIdDetalleOrdenPago
        DetOrdenesPago_TX_PorIdImputacionOtrasOP
        DetOrdenesPago_TX_PorIdOrdenPago
        DetOrdenesPago_TXOrdenPago
        DetOrdenesPago_TXPrimero
        DetOrdenesPagoCuentas_A
        DetOrdenesPagoCuentas_E
        DetOrdenesPagoCuentas_M
        DetOrdenesPagoCuentas_T
        DetOrdenesPagoCuentas_TT
        DetOrdenesPagoCuentas_TX_Estructura
        DetOrdenesPagoCuentas_TX_PorIdOrdenPago
        DetOrdenesPagoCuentas_TXOrdenPago
        DetOrdenesPagoCuentas_TXPrimero
        DetOrdenesPagoImpuestos_A
        DetOrdenesPagoImpuestos_BorrarPorIdOrdenPago
        DetOrdenesPagoImpuestos_E
        DetOrdenesPagoImpuestos_M
        DetOrdenesPagoImpuestos_T
        DetOrdenesPagoImpuestos_TT
        DetOrdenesPagoImpuestos_TX_Estructura
        DetOrdenesPagoImpuestos_TXOrdenPago
        DetOrdenesPagoImpuestos_TXPrimero
        DetOrdenesPagoRubrosContables_A
        DetOrdenesPagoRubrosContables_BorrarPorIdOrdenPago
        DetOrdenesPagoRubrosContables_E
        DetOrdenesPagoRubrosContables_M
        DetOrdenesPagoRubrosContables_T
        DetOrdenesPagoRubrosContables_TT
        DetOrdenesPagoRubrosContables_TX_Estructura
        DetOrdenesPagoRubrosContables_TX_PorIdOrdenPago
        DetOrdenesPagoRubrosContables_TXOrdenPago
        DetOrdenesPagoRubrosContables_TXPrimero
        DetOrdenesPagoValores_A
        DetOrdenesPagoValores_E
        DetOrdenesPagoValores_M
        DetOrdenesPagoValores_T
        DetOrdenesPagoValores_TT
        DetOrdenesPagoValores_TX_Control
        DetOrdenesPagoValores_TX_Estructura
        DetOrdenesPagoValores_TX_PorIdCabecera
        DetOrdenesPagoValores_TXOrdenPago
        DetOrdenesPagoValores_TXPrimero
        DetOtrosIngresosAlmacen_A
        DetOtrosIngresosAlmacen_E
        DetOtrosIngresosAlmacen_M
        DetOtrosIngresosAlmacen_T
        DetOtrosIngresosAlmacen_TX_DetallesParametrizados
        DetOtrosIngresosAlmacen_TX_Todos
        DetOtrosIngresosAlmacen_TXOtros
        DetOtrosIngresosAlmacen_TXPrimero
        DetOtrosIngresosAlmacenSAT_A
        DetOtrosIngresosAlmacenSAT_M
        DetOtrosIngresosAlmacenSAT_T
        DetOtrosIngresosAlmacenSAT_TXOtros
        DetPatronesGPS_A
        DetPatronesGPS_E
        DetPatronesGPS_M
        DetPatronesGPS_T
        DetPatronesGPS_TX_Det
        DetPatronesGPS_TXPrimero
        DetPedidos_A
        DetPedidos_E
        DetPedidos_M
        DetPedidos_SetearPedidoPresto
        DetPedidos_T
        DetPedidos_TX_BuscarItemAco
        DetPedidos_TX_BuscarItemRM
        DetPedidos_TX_DetallesParametrizados
        DetPedidos_TX_ParaTransmitir
        DetPedidos_TX_ParaTransmitir_Todos
        DetPedidos_TX_SetearComoTransmitido
        DetPedidos_TX_Simplificados
        DetPedidos_TX_T
        DetPedidos_TX_TodosSinPrecios
        DetPedidos_TXPed
        DetPedidos_TXPedSF
        DetPedidos_TXPrimero
        DetPedidosSAT_A
        DetPedidosSAT_M
        DetPedidosSAT_T
        DetPedidosSAT_TXPed
        DetPresupuestos_A
        DetPresupuestos_E
        DetPresupuestos_M
        DetPresupuestos_T
        DetPresupuestos_TX_DetallesParametrizados
        DetPresupuestos_TX_PreSF
        DetPresupuestos_TX_UnItem
        DetPresupuestos_TXPre
        DetPresupuestos_TXPrimero
        DetPresupuestosHHObras_A
        DetPresupuestosHHObras_E
        DetPresupuestosHHObras_M
        DetPresupuestosHHObras_T
        DetPresupuestosHHObras_TX_PorEquipoObra
        DetPresupuestosHHObras_TX_PorObra
        DetPresupuestosHHObras_TX_PorSectorEquipoObra
        DetPresupuestosHHObras_TX_PorSectorObra
        DetPresupuestosHHObras_TXPre
        DetPresupuestosHHObras_TXPrimero
        DetPresupuestosHHObrasPorMes_A
        DetPresupuestosHHObrasPorMes_E
        DetPresupuestosHHObrasPorMes_M
        DetPresupuestosHHObrasPorMes_T
        DetPresupuestosHHObrasPorMes_TX_PorObra
        DetProduccionFichaProcesos_TX_PorIdConDatos
        DetProduccionFichas_A
        DetProduccionFichas_E
        DetProduccionFichas_M
        DetProduccionFichas_T
        DetProduccionFichas_TX_DetallesParametrizados
        DetProduccionFichas_TX_PorIdConDatos
        DetProduccionFichas_TX_Todos
        DetProduccionFichas_TXPrimero
        DetProduccionFichas_TXSal
        DetProduccionFichasProcesos_A
        DetProduccionFichasProcesos_E
        DetProduccionFichasProcesos_M
        DetProduccionFichasProcesos_T
        DetProduccionFichasProcesos_TX_DetallesParametrizados
        DetProduccionFichasProcesos_TX_Todos
        DetProduccionFichasProcesos_TX_Uni
        DetProduccionFichasProcesos_TXPrimero
        DetProduccionOrdenes_A
        DetProduccionOrdenes_E
        DetProduccionOrdenes_M
        DetProduccionOrdenes_T
        DetProduccionOrdenes_TX_DetallesParametrizados
        DetProduccionOrdenes_TX_PorIdConDatos
        DetProduccionOrdenes_TX_PorIdOrdenParaCombo
        DetProduccionOrdenes_TX_Todos
        DetProduccionOrdenes_TXPrimero
        DetProduccionOrdenes_TXSal
        DetProduccionOrdenesProcesos_A
        DetProduccionOrdenesProcesos_E
        DetProduccionOrdenesProcesos_M
        DetProduccionOrdenesProcesos_T
        DetProduccionOrdenesProcesos_TX_DetallesParametrizados
        DetProduccionOrdenesProcesos_TX_PorFechaParaProgramadorDeRecursos
        DetProduccionOrdenesProcesos_TX_PorIdConDatos
        DetProduccionOrdenesProcesos_TX_Todos
        DetProduccionOrdenesProcesos_TX_Uni
        DetProduccionOrdenesProcesos_TXPrimero
        DetProduccionOrdenProcesos_A
        DetProduccionOrdenProcesos_E
        DetProduccionOrdenProcesos_M
        DetProduccionOrdenProcesos_T
        DetProduccionOrdenProcesos_TX_PorIdOrdenParaCombo
        DetProduccionOrdenProcesos_TX_Uni
        DetProduccionOrdenProcesos_TXPrimero
        DetProveedores_A
        DetProveedores_E
        DetProveedores_M
        DetProveedores_T
        DetProveedores_TX_TodosSinFormato
        DetProveedores_TXDetPrv
        DetProveedores_TXPrimero
        DetProveedoresIB_A
        DetProveedoresIB_E
        DetProveedoresIB_M
        DetProveedoresIB_T
        DetProveedoresIB_TX_PorIdProveedorIdIBCondicion
        DetProveedoresIB_TX_TodosSinFormato
        DetProveedoresIB_TXDetPrv
        DetProveedoresIB_TXPrimero
        DetProveedoresRubros_A
        DetProveedoresRubros_E
        DetProveedoresRubros_M
        DetProveedoresRubros_T
        DetProveedoresRubros_TX_TodosSinFormato
        DetProveedoresRubros_TXDetPrv
        DetProveedoresRubros_TXPrimero
        DetRecepciones_A
        DetRecepciones_E
        DetRecepciones_M
        DetRecepciones_T
        DetRecepciones_TX_DetallesParametrizados
        DetRecepciones_TXPrimero
        DetRecepciones_TXRec
        DetRecepcionesSAT_A
        DetRecepcionesSAT_M
        DetRecepcionesSAT_T
        DetRecepcionesSAT_TXRec
        DetRecibos_A
        DetRecibos_E
        DetRecibos_M
        DetRecibos_T
        DetRecibos_TT
        DetRecibos_TX_Estructura
        DetRecibos_TX_ParaTransmitir
        DetRecibos_TX_PorIdDetalleRecibo
        DetRecibos_TX_PorIdRecibo
        DetRecibos_TX_SetearComoTransmitido
        DetRecibos_TXPrimero
        DetRecibos_TXRecibo
        DetRecibosCuentas_A
        DetRecibosCuentas_E
        DetRecibosCuentas_M
        DetRecibosCuentas_T
        DetRecibosCuentas_TT
        DetRecibosCuentas_TX_Estructura
        DetRecibosCuentas_TX_ParaTransmitir
        DetRecibosCuentas_TX_PorIdRecibo
        DetRecibosCuentas_TX_SetearComoTransmitido
        DetRecibosCuentas_TXPrimero
        DetRecibosCuentas_TXRecibo
        DetRecibosRubrosContables_A
        DetRecibosRubrosContables_BorrarPorIdRecibo
        DetRecibosRubrosContables_E
        DetRecibosRubrosContables_M
        DetRecibosRubrosContables_T
        DetRecibosRubrosContables_TT
        DetRecibosRubrosContables_TX_Estructura
        DetRecibosRubrosContables_TX_ParaTransmitir
        DetRecibosRubrosContables_TX_PorIdRecibo
        DetRecibosRubrosContables_TX_SetearComoTransmitido
        DetRecibosRubrosContables_TXPrimero
        DetRecibosRubrosContables_TXRecibo
        DetRecibosValores_A
        DetRecibosValores_E
        DetRecibosValores_M
        DetRecibosValores_T
        DetRecibosValores_TT
        DetRecibosValores_TX_Estructura
        DetRecibosValores_TX_ParaTransmitir
        DetRecibosValores_TX_PorIdCabecera
        DetRecibosValores_TX_SetearComoTransmitido
        DetRecibosValores_TX_ValidarCheque
        DetRecibosValores_TXPrimero
        DetRecibosValores_TXRecibo
        DetRemitos_A
        DetRemitos_E
        DetRemitos_M
        DetRemitos_T
        DetRemitos_TX_ConDatos
        DetRemitos_TX_ConDatosResumido
        DetRemitos_TXPrimero
        DetRemitos_TXRem
        DetRequerimientos_A
        DetRequerimientos_E
        DetRequerimientos_M
        DetRequerimientos_T
        DetRequerimientos_TX_DetallesParametrizados
        DetRequerimientos_TX_ParaTransmitir
        DetRequerimientos_TX_SetearComoTransmitido
        DetRequerimientos_TX_Todos
        DetRequerimientos_TX_TodosConDatos
        DetRequerimientos_TX_UnItem
        DetRequerimientos_TX_UnItemConFormato
        DetRequerimientos_TXPrimero
        DetRequerimientos_TXReq
        DetReservas_A
        DetReservas_E
        DetReservas_M
        DetReservas_T
        DetReservas_TXPrimero
        DetReservas_TXRes
        DetSalidasMateriales_A
        DetSalidasMateriales_AnularConsumos
        DetSalidasMateriales_E
        DetSalidasMateriales_M
        DetSalidasMateriales_T
        DetSalidasMateriales_TX_DetallesParametrizados
        DetSalidasMateriales_TX_Todos
        DetSalidasMateriales_TXPrimero
        DetSalidasMateriales_TXSal
        DetSalidasMaterialesSAT_A
        DetSalidasMaterialesSAT_M
        DetSalidasMaterialesSAT_T
        DetSalidasMaterialesSAT_TXSal
        DetSolicitudesCompra_A
        DetSolicitudesCompra_E
        DetSolicitudesCompra_M
        DetSolicitudesCompra_T
        DetSolicitudesCompra_TX_Datos
        DetSolicitudesCompra_TXPrimero
        DetSolicitudesCompra_TXSol
        DetValesSalida_A
        DetValesSalida_E
        DetValesSalida_M
        DetValesSalida_T
        DetValesSalida_TX_DetallesParametrizados
        DetValesSalida_TX_TodoMasPendientePorIdDetalle
        DetValesSalida_TX_TodosLosItemsConFormato
        DetValesSalida_TX_UnItem
        DetValesSalida_TX_UnItemConFormato
        DetValesSalida_TXPrimero
        DetValesSalida_TXRes
        DetValores_A
        DetValores_E
        DetValores_M
        DetValores_T
        DetValores_TXPrimero
        DetValores_TXVal
        DetValoresCuentas_A
        DetValoresCuentas_BorrarPorIdValor
        DetValoresCuentas_E
        DetValoresCuentas_M
        DetValoresCuentas_T
        DetValoresCuentas_TT
        DetValoresCuentas_TX_Estructura
        DetValoresCuentas_TXPrimero
        DetValoresCuentas_TXValor
        DetValoresProvincias_A
        DetValoresProvincias_BorrarPorIdValor
        DetValoresProvincias_E
        DetValoresProvincias_M
        DetValoresProvincias_T
        DetValoresProvincias_TT
        DetValoresProvincias_TX_Estructura
        DetValoresProvincias_TX_PorIdValor
        DetValoresProvincias_TXPrimero
        DetValoresProvincias_TXValor
        DetValoresRubrosContables_A
        DetValoresRubrosContables_BorrarPorIdValor
        DetValoresRubrosContables_E
        DetValoresRubrosContables_M
        DetValoresRubrosContables_T
        DetValoresRubrosContables_TT
        DetValoresRubrosContables_TX_Estructura
        DetValoresRubrosContables_TX_PorIdValor
        DetValoresRubrosContables_TXPrimero
        DetValoresRubrosContables_TXValor
        DetVentasEnCuotas_A
        DetVentasEnCuotas_E
        DetVentasEnCuotas_M
        DetVentasEnCuotas_T
        DetVentasEnCuotas_TX_PorIdVentaEnCuotas
        DetVentasEnCuotas_TXPrimero
        Devoluciones_A
        Devoluciones_E
        Devoluciones_M
        Devoluciones_T
        Devoluciones_TT
        Devoluciones_TX_EntreFechasParaGeneracionContable
        Devoluciones_TX_PorId
        Devoluciones_TX_TodosSF_HastaFecha
        Devoluciones_TX_TT
        Devoluciones_TXAnio
        Devoluciones_TXCod
        Devoluciones_TXFecha
        Devoluciones_TXMes
        Devoluciones_TXMesAnio
        DiferenciasCambio_A
        DiferenciasCambio_E
        DiferenciasCambio_Eliminar
        DiferenciasCambio_M
        DiferenciasCambio_MarcarComoGenerada
        DiferenciasCambio_T
        DiferenciasCambio_TX_DatosDelComprobantePorCobranza
        DiferenciasCambio_TX_ParaCalculoIndividual
        DiferenciasCambio_TX_ParaCalculoIndividualCobranzas
        DiferenciasCambio_TX_PorCobranzasGeneradas
        DiferenciasCambio_TX_PorCobranzasPendientes
        DiferenciasCambio_TX_PorCobranzasTodas
        DiferenciasCambio_TX_PorPagosGeneradas
        DiferenciasCambio_TX_PorPagosPendientes
        DiferenciasCambio_TX_PorPagosTodos
        DiferenciasCambio_TX_Struc
        DispositivosGPS_A
        DispositivosGPS_E
        DispositivosGPS_M
        DispositivosGPS_T
        DispositivosGPS_TL
        DispositivosGPS_TT
        DispositivosGPS_TX_PorDescripcion
        DispositivosGPS_TX_TT
        DistribucionesObras_A
        DistribucionesObras_E
        DistribucionesObras_M
        DistribucionesObras_T
        DistribucionesObras_TL
        DistribucionesObras_TT
        DistribucionesObras_TX_TT
        dropFK
        Ejercicios_TX_Uno
        EjerciciosContables_A
        EjerciciosContables_E
        EjerciciosContables_M
        EjerciciosContables_T
        EjerciciosContables_TL
        EjerciciosContables_TT
        EjerciciosContables_TX_PorId
        EjerciciosContables_TX_TodosSF
        EjerciciosContables_TX_TT
        EjerciciosContables_TX_Ultimo
        EjerciciosPeriodos_TX_PorEjercicio
        EjerciciosPeriodos_TX_Uno
        Empleados_A
        Empleados_E
        Empleados_M
        Empleados_T
        Empleados_TL
        Empleados_TT
        Empleados_TX_AccesosPorItemArbol
        Empleados_TX_Administradores
        Empleados_TX_AdministradoresMasJefeCompras
        Empleados_TX_ConEventosPendientes
        Empleados_TX_ParaAnularPorFormulario
        Empleados_TX_ParaHH
        Empleados_TX_ParaMensajes
        Empleados_TX_ParaTransmitir_Todos
        Empleados_TX_PorEmpleado
        Empleados_TX_PorEnumeracionIds
        Empleados_TX_PorGruposDelSector
        Empleados_TX_PorId
        Empleados_TX_PorIdSector
        Empleados_TX_PorIdSectorParaHH
        Empleados_TX_PorIdSectorParaHHSinBajas
        Empleados_TX_PorLegajo
        Empleados_TX_PorNombre
        Empleados_TX_PorObraAsignada
        Empleados_TX_PorSector
        Empleados_TX_TLParaHH
        Empleados_TX_TodosLosAccesos
        Empleados_TX_TT
        Empleados_TX_UnUsuario
        Empleados_TX_UsuarioNT
        EmpleadosAccesos_A
        EmpleadosAccesos_Actualizar
        EmpleadosAccesos_ActualizarPorBD
        EmpleadosAccesos_E
        EmpleadosAccesos_InhabilitarAccesosPorNodo
        EmpleadosAccesos_M
        Empresa_M
        Empresa_T
        Empresa_TT
        Empresa_TX_Datos
        Equipos_A
        Equipos_E
        Equipos_M
        Equipos_T
        Equipos_TL
        Equipos_TT
        Equipos_TX_ParaTransmitir
        Equipos_TX_ParaTransmitir_Todos
        Equipos_TX_PorcentajesStandar
        Equipos_TX_PorObra1
        Equipos_TX_PorObraParaCombo
        Equipos_TX_SetearComoTransmitido
        Equipos_TX_TT
        Equipos_TXPlanos
        Equipos_TXPorObra
        EstadoPedidos_A
        EstadoPedidos_M
        EstadoPedidos_T
        EstadoPedidos_TT
        EstadoPedidos_TX_ACancelar
        EstadoPedidos_TX_BuscarComprobante
        EstadoPedidos_TX_Imputacion
        EstadoPedidos_TX_PorNumeroComprobante
        EstadoPedidos_TX_PorNumeroPedido
        EstadoPedidos_TX_Struc
        EstadoPedidos_TX_TT
        EstadoPedidos_TXParaImputar
        EstadoPedidos_TXPorMayor
        EstadoPedidos_TXPorTrs
        EstadoPedidos_TXTotal
        EstadosProveedores_A
        EstadosProveedores_E
        EstadosProveedores_M
        EstadosProveedores_T
        EstadosProveedores_TL
        EstadosProveedores_TT
        EstadosProveedores_TX_TT
        EstadosVentasEnCuotas_TX_ParaCombo
        EventosDelSistema_A
        EventosDelSistema_E
        EventosDelSistema_M
        EventosDelSistema_T
        EventosDelSistema_TL
        EventosDelSistema_TT
        EventosDelSistema_TX_IdEmpleadosPorIdEvento
        EventosDelSistema_TX_TT
        Facturas_A
        Facturas_ActualizarCampos
        Facturas_ActualizarCamposDetalle
        Facturas_ActualizarDatosCAE
        Facturas_ActualizarDetalles
        Facturas_ActualizarIdReciboContado
        Facturas_E
        Facturas_EliminarFacturaAnulada
        Facturas_M
        Facturas_T
        Facturas_TT
        Facturas_TX_DevolucionAnticipo
        Facturas_TX_EntreFechasParaGeneracionContable
        Facturas_TX_FacturasContadoTodas
        Facturas_TX_NCs_RecuperoGastos
        Facturas_TX_OrdenCompraPorIdFactura
        Facturas_TX_ParaDebitoBancario
        Facturas_TX_ParaTransmitir
        Facturas_TX_PorComprobanteCliente
        Facturas_TX_PorId
        Facturas_TX_PorIdConDatos
        Facturas_TX_PorIdOrigen
        Facturas_TX_PorIdOrigenDetalle
        Facturas_TX_PorNumeroComprobante
        Facturas_TX_PorNumeroDesdeHasta
        Facturas_TX_SetearComoTransmitido
        Facturas_TX_TodosSF_HastaFecha
        Facturas_TX_TraerIdObraDesdeIdDetalleFactura
        Facturas_TX_TT
        Facturas_TX_TT_Contado
        Facturas_TX_UltimaPorIdPuntoVenta
        Facturas_TX_UltimoAnteriorAFecha
        Facturas_TXAnio
        Facturas_TXAnio_Contado
        Facturas_TXCod
        Facturas_TXFecha
        Facturas_TXFecha_Contado
        Facturas_TXMes
        Facturas_TXMes_Contado
        Facturas_TXMesAnio
        FacturasClientesPRESTO_A
        FacturasClientesPRESTO_E
        FacturasClientesPRESTO_M
        FacturasClientesPRESTO_T
        FacturasClientesPRESTO_TT
        FacturasClientesPRESTO_TX_PorId
        FacturasClientesPRESTO_TX_TT
        FacturasCompra_A
        FacturasCompra_E
        FacturasCompra_M
        FacturasCompra_T
        FacturasCompra_TX_DetallePorComprobante
        FacturasCompra_TX_DetallePorComprobanteSinFormato
        FacturasCompra_TX_DetallePorDetalleComprobante
        FacturasCompra_TXPrimero
        Familias_A
        Familias_E
        Familias_M
        Familias_T
        Familias_TL
        Familias_TT
        Familias_TX_ParaTransmitir
        Familias_TX_ParaTransmitir_Todos
        Familias_TX_SetearComoTransmitido
        Familias_TX_TT
        Feriados_A
        Feriados_E
        Feriados_M
        Feriados_T
        Feriados_TT
        Feriados_TX_ConsultaFeriado
        Feriados_TX_FeriadosPorMes
        Feriados_TX_TT
        Fletes_A
        Fletes_E
        Fletes_M
        Fletes_T
        Fletes_TL
        Fletes_TT
        Fletes_TX_PorTouch
        Fletes_TX_TT
        FletesPartesDiarios_A
        FletesPartesDiarios_E
        FletesPartesDiarios_M
        FletesPartesDiarios_T
        FletesPartesDiarios_TT
        FletesPartesDiarios_TX_Fecha
        FletesPartesDiarios_TX_TT
        FletesPartesDiarios_TXAnio
        FletesPartesDiarios_TXMes
        FondosFijos_TX_Resumen
        Formas_A
        Formas_E
        Formas_M
        Formas_T
        Formas_TL
        Formas_TT
        Formas_TX_TT
        Formularios_A
        Formularios_E
        Formularios_M
        Formularios_T
        Formularios_TL
        Formularios_TT
        Formularios_TX_TT
        FormulariosTabIndex_Agregar
        FormulariosTabIndex_BorrarRegistrosDeUnFormulario
        FormulariosTabIndex_TX_PorFormulario
        FormulariosTabIndex_TX_PorFormularioControl
        Ganacias_AsignarMinimos
        Ganancias_A
        Ganancias_E
        Ganancias_M
        Ganancias_T
        Ganancias_TT
        Ganancias_TX_Desarrollo
        Ganancias_TX_DesarrolloResumido
        Ganancias_TX_ImpuestoPorIdTipoRetencionGanancia
        Ganancias_TX_RetenidoMes
        Ganancias_TX_TT
        GastosFletes_A
        GastosFletes_E
        GastosFletes_M
        GastosFletes_T
        GastosFletes_TX_Fecha
        GastosFletes_TX_TT
        GastosFletes_TXAnio
        GastosFletes_TXMes
        GetCountRequemientoForEmployee
        GetEmployeeByName
        Grados_A
        Grados_E
        Grados_M
        Grados_T
        Grados_TL
        Grados_TT
        Grados_TX_PorDescripcion
        Grados_TX_TT
        GruposActivosFijos_A
        GruposActivosFijos_E
        GruposActivosFijos_M
        GruposActivosFijos_T
        GruposActivosFijos_TL
        GruposActivosFijos_TT
        GruposActivosFijos_TX_TT
        GruposObras_A
        GruposObras_E
        GruposObras_M
        GruposObras_T
        GruposObras_TL
        GruposObras_TT
        GruposObras_TX_TT
        GruposTareasHH_A
        GruposTareasHH_E
        GruposTareasHH_M
        GruposTareasHH_T
        GruposTareasHH_TL
        GruposTareasHH_TT
        GruposTareasHH_TX_PorObra
        GruposTareasHH_TX_TT
        HaveEmployeeAccess
        HorasJornadas_A
        HorasJornadas_E
        HorasJornadas_M
        HorasJornadas_T
        IBCondiciones_A
        IBCondiciones_E
        IBCondiciones_M
        IBCondiciones_T
        IBCondiciones_TL
        IBCondiciones_TT
        IBCondiciones_TX_AcumuladosPorIdProveedorIdIBCondicion
        IBCondiciones_TX_IdCuentaPorProvincia
        IBCondiciones_TX_PorId
        IBCondiciones_TX_TT
        IGCondiciones_A
        IGCondiciones_E
        IGCondiciones_M
        IGCondiciones_T
        IGCondiciones_TL
        IGCondiciones_TT
        IGCondiciones_TX_PorId
        IGCondiciones_TX_TT
        ImpuestosDirectos_A
        ImpuestosDirectos_E
        ImpuestosDirectos_M
        ImpuestosDirectos_T
        ImpuestosDirectos_TL
        ImpuestosDirectos_TT
        ImpuestosDirectos_TX_PorGrupoConCertificado
        ImpuestosDirectos_TX_PorId
        ImpuestosDirectos_TX_PorTipoParaCombo
        ImpuestosDirectos_TX_TT
        InformeBalance_TX_1
        InformeDeDiario_TX_1
        InformeDeDiario_TX_2
        InformeDeDiario_TX_2_Modelo_IGJ
        InformeDeDiario_TX_2_Modelo2
        InformeDeDiario_TX_2_Modelo3
        InformeDeDiario_TX_2_Modelo4
        InformeDeDiario_TX_2_Resumido
        InformeDeDiario_TX_2_Resumido_Modelo2
        InformeMayorDetallado_TX_1
        InformeMayorResumido_TX_1
        InformesContables_TX_1361
        InformesContables_TX_1361_CabeceraFacturas
        InformesContables_TX_1361_Compras
        InformesContables_TX_1361_DetalleFacturas
        InformesContables_TX_1361_OtrasPercepciones
        InformesContables_TX_1361_Ventas
        InformesContables_TX_ComercioExterior
        InformesContables_TX_IVACompras
        InformesContables_TX_IVACompras_Modelo2
        InformesContables_TX_IVACompras_Modelo3
        InformesContables_TX_IVACompras_Modelo4
        InformesContables_TX_IVACompras_Modelo5
        InformesContables_TX_IVACompras_Modelo6
        InformesContables_TX_IVAComprasDetallado
        InformesContables_TX_IVAVentas
        InformesContables_TX_IVAVentas_Modelo2
        InformesContables_TX_IVAVentas_Modelo3
        InformesContables_TX_IVAVentas_Modelo4
        InformesContables_TX_IVAVentas_Modelo5
        InformesContables_TX_SubdiarioCajaYBancos
        InformesContables_TX_SubdiarioClientes
        InformesContables_TX_SubdiarioCobranzas
        InformesContables_TX_SubdiarioPagos
        InformesContables_TX_SubdiarioProveedores
        InformesContables_TX_T
        InformesContables_TX_Todos
        Inventarios_TL
        ItemsDocumentacion_A
        ItemsDocumentacion_E
        ItemsDocumentacion_M
        ItemsDocumentacion_T
        ItemsDocumentacion_TL
        ItemsDocumentacion_TT
        ItemsDocumentacion_TX_TT
        ItemsPopUpMateriales_A
        ItemsPopUpMateriales_E
        ItemsPopUpMateriales_M
        ItemsPopUpMateriales_T
        ItemsPopUpMateriales_TT
        ItemsPopUpMateriales_TX_CamposConTablas
        ItemsPopUpMateriales_TX_Existente
        ItemsPopUpMateriales_TX_ParaMenu
        ItemsPopUpMateriales_TX_Todos
        ItemsPopUpMateriales_TX_TT
        ItemsProduccion_A
        ItemsProduccion_E
        ItemsProduccion_M
        ItemsProduccion_T
        ItemsProduccion_TL
        ItemsProduccion_TT
        ItemsProduccion_TX_TT
        LecturasGPS_A
        LecturasGPS_E
        LecturasGPS_M
        LecturasGPS_T
        LecturasGPS_TT
        LecturasGPS_TX_Fecha
        LecturasGPS_TX_PorCoincidenciaConPatron
        LecturasGPS_TX_PorFecha
        LecturasGPS_TXAnio
        LecturasGPS_TXMes
        ListasPrecios_A
        ListasPrecios_E
        ListasPrecios_M
        ListasPrecios_T
        ListasPrecios_TL
        ListasPrecios_TT
        ListasPrecios_TX_DetallesPorId
        ListasPrecios_TX_NuevoPrecio
        ListasPrecios_TX_ParaArbol
        ListasPrecios_TX_TT
        ListasPrecios_TX_UltimoPorIdArticulo
        ListasPreciosDetalle_A
        ListasPreciosDetalle_E
        ListasPreciosDetalle_M
        ListasPreciosDetalle_T
        LMateriales_A
        LMateriales_ActualizarDetalles
        LMateriales_CalcularDisponibilidadesPorLM
        LMateriales_CalcularFaltantes
        LMateriales_E
        LMateriales_M
        LMateriales_T
        LMateriales_TL
        LMateriales_TT
        LMateriales_TX_CantidadPorDestinoArticulo
        LMateriales_TX_DesdeDetalle
        LMateriales_TX_DetallesAReservar
        LMateriales_TX_Disponibilidades
        LMateriales_TX_DisponibilidadesCal
        LMateriales_TX_DisponibilidadesPed
        LMateriales_TX_DisponibilidadesPorLM
        LMateriales_TX_DisponibilidadesRec
        LMateriales_TX_DisponibilidadesRes
        LMateriales_TX_DisponibilidadesSal
        LMateriales_TX_DisponibilidadesVal
        LMateriales_TX_Faltantes
        LMateriales_TX_ParaListaPorObra
        LMateriales_TX_PorIdOrigen
        LMateriales_TX_PorIdOrigenDetalle
        LMateriales_TX_PorIdOrigenDetalleRevisiones
        LMateriales_TX_PorLMat
        LMateriales_TX_SaldosPorDestino
        LMateriales_TX_Sumarizadas
        LMateriales_TX_TodasLasRevisiones
        LMateriales_TX_TodasLasRevisiones_AcopiosYLMateriales
        LMateriales_TX_TT
        LMateriales_TXNombre
        LMateriales_TXPorEquipo
        LMateriales_TXPorLAcopio
        Localidades_A
        Localidades_E
        Localidades_M
        Localidades_T
        Localidades_TL
        Localidades_TT
        Localidades_TX_ParaTransmitir
        Localidades_TX_ParaTransmitir_Todos
        Localidades_TX_PorId
        Localidades_TX_PorNombre
        Localidades_TX_SetearComoTransmitido
        Localidades_TX_TT
        Log_InsertarRegistro
        LogImpuestos_A
        LogImpuestos_TX_ConsultaGeneral
        LugaresEntrega_A
        LugaresEntrega_E
        LugaresEntrega_M
        LugaresEntrega_T
        LugaresEntrega_TL
        LugaresEntrega_TT
        LugaresEntrega_TX_PorId
        LugaresEntrega_TX_TT
        Maquinas_TX_PorAreaSectorLineaProcesoMaquina
        Marcas_A
        Marcas_E
        Marcas_M
        Marcas_T
        Marcas_TL
        Marcas_TT
        Marcas_TX_TT
        Materiales_A
        Materiales_E
        Materiales_M
        Materiales_T
        Materiales_TL
        Materiales_TT
        Materiales_TX_TT
        Modelos_A
        Modelos_E
        Modelos_M
        Modelos_T
        Modelos_TL
        Modelos_TT
        Modelos_TX_TT
        Monedas_A
        Monedas_E
        Monedas_M
        Monedas_T
        Monedas_TL
        Monedas_TT
        Monedas_TX_MonedasStandarParaCombo
        Monedas_TX_ParaTransmitir
        Monedas_TX_ParaTransmitir_Todos
        Monedas_TX_PorId
        Monedas_TX_Resto
        Monedas_TX_SetearComoTransmitido
        Monedas_TX_TT
        Monedas_TX_VerificarAbreviatura
        MotivosRechazo_A
        MotivosRechazo_E
        MotivosRechazo_M
        MotivosRechazo_T
        MotivosRechazo_TL
        MotivosRechazo_TT
        MotivosRechazo_TX_TT
        MovimientosFletes_A
        MovimientosFletes_Actualizar
        MovimientosFletes_ActualizarLecturasGPS
        MovimientosFletes_E
        MovimientosFletes_M
        MovimientosFletes_T
        MovimientosFletes_TX_EntreFechasSinFormato
        MovimientosFletes_TX_Fecha
        MovimientosFletes_TX_Liquidacion
        MovimientosFletes_TX_MovimientoAnteriorCarga
        MovimientosFletes_TXAnio
        MovimientosFletes_TXMes
        Normas_A
        Normas_E
        Normas_M
        Normas_T
        Normas_TL
        Normas_TT
        Normas_TX_TT
        NotasCredito_A
        NotasCredito_ActualizarCampos
        NotasCredito_E
        NotasCredito_M
        NotasCredito_T
        NotasCredito_TT
        NotasCredito_TX_EntreFechasParaGeneracionContable
        NotasCredito_TX_NDs_RecuperoGastos
        NotasCredito_TX_PorId
        NotasCredito_TX_PorNumeroComprobante
        NotasCredito_TX_TodosSF_HastaFecha
        NotasCredito_TX_TT
        NotasCredito_TX_UltimaPorIdPuntoVenta
        NotasCredito_TXAnio
        NotasCredito_TXCod
        NotasCredito_TXFecha
        NotasCredito_TXMes
        NotasCredito_TXMesAnio
        NotasDebito_A
        NotasDebito_ActualizarCampos
        NotasDebito_E
        NotasDebito_M
        NotasDebito_T
        NotasDebito_TT
        NotasDebito_TX_EntreFechasParaGeneracionContable
        NotasDebito_TX_PorId
        NotasDebito_TX_PorNumeroComprobante
        NotasDebito_TX_TodosSF_HastaFecha
        NotasDebito_TX_TT
        NotasDebito_TX_UltimaPorIdPuntoVenta
        NotasDebito_TXAnio
        NotasDebito_TXCod
        NotasDebito_TXFecha
        NotasDebito_TXMes
        NotasDebito_TXMesAnio
        NovedadesUsuarios_A
        NovedadesUsuarios_E
        NovedadesUsuarios_GrabarNovedadNueva
        NovedadesUsuarios_M
        NovedadesUsuarios_T
        NovedadesUsuarios_TX_Estructura
        NovedadesUsuarios_TX_PorIdEmpleadoConEventosPendientes
        Obras_A
        Obras_E
        Obras_EliminarCuentasNoUsadasPorIdObra
        Obras_GenerarActivacionCompraMateriales
        Obras_GenerarEstado
        Obras_M
        Obras_T
        Obras_TL
        Obras_TT
        Obras_TX_ActivacionCompra
        Obras_TX_Activas
        Obras_TX_ActivasConDatos
        Obras_TX_ConDetallePolizas
        Obras_TX_ConPolizasVencidas
        Obras_TX_ControlDominioEnObra
        Obras_TX_ControlEquipoEnDominio
        Obras_TX_DatosDeLaObra
        Obras_TX_DatosParaProgramacionHoras
        Obras_TX_DestinosParaComboPorIdObra
        Obras_TX_DestinosParaPresupuesto
        Obras_TX_DetalladosPorEquiposPlanos
        Obras_TX_DetallesParametrizados
        Obras_TX_EquiposInstaladosPorFecha
        Obras_TX_EstadoObras
        Obras_TX_EstadoObras_Acopios
        Obras_TX_EstadoObras_DetalleComprobantesProveedoresAsignados
        Obras_TX_EstadoObras_DetalleFacturasAsignadas
        Obras_TX_EstadoObras_DetallePedidosDesdeAcopio
        Obras_TX_EstadoObras_DetallePedidosDesdeRM
        Obras_TX_EstadoObras_DetallePresupuestosDesdeRM
        Obras_TX_EstadoObras_DetalleRecepcionesDesdeAcopio
        Obras_TX_EstadoObras_DetalleRecepcionesDesdeRM
        Obras_TX_EstadoObras_DetalleSalidasDesdeRM
        Obras_TX_EstadoObras_RM
        Obras_TX_EstadoObrasPorObra
        Obras_TX_Habilitadas
        Obras_TX_HabilitadasExcel
        Obras_TX_Inactivas
        Obras_TX_ItemsDocumentacion
        Obras_TX_ObrasMasOT
        Obras_TX_ObrasMasOTParaCombo
        Obras_TX_ParaInformes
        Obras_TX_ParaPopUp
        Obras_TX_ParaPopUp1
        Obras_TX_ParaTransmitir
        Obras_TX_ParaTransmitir_Todos
        Obras_TX_PolizasPorIdObraConDatos
        Obras_TX_PorId
        Obras_TX_PorIdClienteParaCombo
        Obras_TX_PorIdCuentaFF
        Obras_TX_PorIdObraConDatos
        Obras_TX_PorNumero
        Obras_TX_Presupuesto
        Obras_TX_Presupuesto_OT
        Obras_TX_SetearComoTransmitido
        Obras_TX_TodasActivasParaCombo
        Obras_TX_TodasActivasParaComboConDescripcion
        Obras_TX_TodasParaCombo
        Obras_TX_TodosLosItems
        Obras_TX_TT
        Obras_TX_TT_DetallesParametrizados
        Obras_TX_ValidarParaBaja
        Obras_TXEquipos
        Obras_TXEquiposPorGrupo
        OrdenesCompra_A
        OrdenesCompra_ActualizarEstadoDetalles
        OrdenesCompra_E
        OrdenesCompra_M
        OrdenesCompra_MarcarComoCumplidas
        OrdenesCompra_MarcarParaFacturacionAutomatica
        OrdenesCompra_T
        OrdenesCompra_TT
        OrdenesCompra_TX_DesarrolloPorItem
        OrdenesCompra_TX_DetalladoEntreFechas
        OrdenesCompra_TX_DetallePorId
        OrdenesCompra_TX_DetallePorIdDetalle
        OrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente
        OrdenesCompra_TX_DetallesPendientesDeFacturarPorIdDetalleOrdenCompra
        OrdenesCompra_TX_ItemsApuntadosPorIdOrdenCompra
        OrdenesCompra_TX_ItemsPendientesDeFacturar
        OrdenesCompra_TX_ItemsPendientesDeFacturarPorIdOrdenCompra
        OrdenesCompra_TX_ItemsPendientesDeProducir
        OrdenesCompra_TX_ItemsPendientesDeProducirModuloProduccion
        OrdenesCompra_TX_ItemsPendientesDeRemitir
        OrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente
        OrdenesCompra_TX_ItemsPendientesDeRemitirPorIdClienteParaCombo
        OrdenesCompra_TX_OrdenesAFacturarAutomaticas_DetallesPorIdCliente
        OrdenesCompra_TX_OrdenesAFacturarAutomaticas_PorCliente
        OrdenesCompra_TX_OrdenesAutomaticasPrefacturacion
        OrdenesCompra_TX_PorId
        OrdenesCompra_TX_PorIdClienteTodosParaCredito
        OrdenesCompra_TX_PorIdParaCombo
        OrdenesCompra_TX_RemitosFacturasPorIdDetalleOrdenCompra
        OrdenesCompra_TX_Todas
        OrdenesCompra_TX_TT
        OrdenesCompra_TXAnio
        OrdenesCompra_TXFecha
        OrdenesCompra_TXMes
        OrdenesPago_A
        OrdenesPago_ActualizarDiferenciaBalanceo
        OrdenesPago_ActualizarIdOrdenPagoComplementaria
        OrdenesPago_BorrarValores
        OrdenesPago_ConfirmarAcreditacionFF
        OrdenesPago_E
        OrdenesPago_EliminarOrdenesDePagoAConfirmar
        OrdenesPago_LiberarGastosPorAnulacionOP
        OrdenesPago_M
        OrdenesPago_MarcarComoEnCaja
        OrdenesPago_MarcarComoEntregado
        OrdenesPago_MarcarComoPendiente
        OrdenesPago_T
        OrdenesPago_TT
        OrdenesPago_TX_AConfirmar
        OrdenesPago_TX_AcumuladoParaIIBB
        OrdenesPago_TX_ALaFirma
        OrdenesPago_TX_CajaEgresos
        OrdenesPago_TX_DatosDeLaImputacion
        OrdenesPago_TX_DetallePorRubroContable
        OrdenesPago_TX_EnCaja
        OrdenesPago_TX_EntreFechasParaGeneracionContable
        OrdenesPago_TX_FFPendientesControl
        OrdenesPago_TX_ParaListadoDetallado
        OrdenesPago_TX_PorId
        OrdenesPago_TX_PorIdDetalleOrdenPago
        OrdenesPago_TX_PorNumero
        OrdenesPago_TX_PorNumeroFF
        OrdenesPago_TX_PorNumeroIdObraOrigen
        OrdenesPago_TX_ResumenPorRendicionFF
        OrdenesPago_TX_Todas
        OrdenesPago_TX_TodosSF_HastaFecha
        OrdenesPago_TX_TraerGastosPendientes
        OrdenesPago_TX_TraerGastosPorOrdenPago
        OrdenesPago_TX_TraerGastosPorOrdenPagoParaAnular
        OrdenesPago_TX_TT
        OrdenesPago_TX_ValidarNumero
        OrdenesPago_TX_ValoresEnConciliacionesPorIdOrdenPago
        OrdenesPago_TX_ValoresPorIdOrdenPago
        OrdenesPago_TXAnio
        OrdenesPago_TXCod
        OrdenesPago_TXFecha
        OrdenesPago_TXMes
        OrdenesPago_TXMesAnio
        OrdenesPago_TXOrdenesPagoxAnio
        OrdenesProduccion_TX_ItemsPendientesDeProducir
        OrdenesTrabajo_A
        OrdenesTrabajo_E
        OrdenesTrabajo_M
        OrdenesTrabajo_T
        OrdenesTrabajo_TL
        OrdenesTrabajo_TT
        OrdenesTrabajo_TX_ParaCombo
        OrdenesTrabajo_TX_PorNumero
        OrdenesTrabajo_TX_SegunFechaFinalizacion
        OrdenesTrabajo_TX_TT
        OrdenesTrabajo_TXAnio
        OrdenesTrabajo_TXFecha
        OrdenesTrabajo_TXMes
        Origen_TL
        OtrosIngresosAlmacen_A
        OtrosIngresosAlmacen_ActualizarDetalles
        OtrosIngresosAlmacen_AjustarStockPorAnulacion
        OtrosIngresosAlmacen_E
        OtrosIngresosAlmacen_M
        OtrosIngresosAlmacen_T
        OtrosIngresosAlmacen_TT
        OtrosIngresosAlmacen_TX_DetallesParametrizados
        OtrosIngresosAlmacen_TX_PorId
        OtrosIngresosAlmacen_TX_PorIdOrigen
        OtrosIngresosAlmacen_TX_PorIdOrigenDetalle
        OtrosIngresosAlmacen_TX_Todos
        OtrosIngresosAlmacen_TX_TT
        OtrosIngresosAlmacen_TX_TT_DetallesParametrizados
        OtrosIngresosAlmacen_TXAnio
        OtrosIngresosAlmacen_TXFecha
        OtrosIngresosAlmacen_TXMes
        OtrosIngresosAlmacenSAT_A
        OtrosIngresosAlmacenSAT_ActualizarDetalles
        OtrosIngresosAlmacenSAT_M
        OtrosIngresosAlmacenSAT_T
        OtrosIngresosAlmacenSAT_TX_PorIdOrigen
        OtrosIngresosAlmacenSAT_TX_PorIdOrigenDetalle
        OtrosIngresosAlmacenSAT_TX_Todos
        OtrosIngresosAlmacenSAT_TXAnio
        OtrosIngresosAlmacenSAT_TXFecha
        OtrosIngresosAlmacenSAT_TXMes
        Paises_A
        Paises_E
        Paises_M
        Paises_T
        Paises_TL
        Paises_TT
        Paises_TX_ParaTransmitir
        Paises_TX_ParaTransmitir_Todos
        Paises_TX_PorCodigo
        Paises_TX_PorNombre
        Paises_TX_SetearComoTransmitido
        Paises_TX_TT
        Parametros_M
        Parametros_RegistrarParametros2
        Parametros_T
        Parametros_TT
        Parametros_TX_Parametros2
        Parametros_TX_Parametros2BuscarClave
        Parametros_TX_PorId
        Parametros_TX_PorIdConTimeStamp
        Partidas_TX_ComprobantesDetalladosPorPartida
        PatronesGPS_A
        PatronesGPS_E
        PatronesGPS_M
        PatronesGPS_T
        PatronesGPS_TT
        PatronesGPS_TX_TT
        Pedidos_A
        Pedidos_ActualizarCosto
        Pedidos_ActualizarEstadoPorIdPedido
        Pedidos_AsignarCostoImportacion
        Pedidos_BorrarAsignacionCosto
        Pedidos_E
        Pedidos_M
        Pedidos_RegistrarFechaSalida
        Pedidos_RegistrarImpresion
        Pedidos_SetearPedidoPresto
        Pedidos_T
        Pedidos_TT
        Pedidos_TX_AdjuntosPorPedido
        Pedidos_TX_AnticipoAProveedores
        Pedidos_TX_ComprasTercerosDetalladas
        Pedidos_TX_ComprasTercerosResumidaServicios
        Pedidos_TX_ComprasTercerosResumidaTaller
        Pedidos_TX_CuentasContablesPorIdPedido
        Pedidos_TX_Cumplidos
        Pedidos_TX_DatosPorIdDetalle
        Pedidos_TX_DetallePorNumeroItem
        Pedidos_TX_DetallesParaComprobantesProveedores
        Pedidos_TX_DetallesPedidosRecepcionesLMaterialesPorObra
        Pedidos_TX_DetallesPorId
        Pedidos_TX_DetallesPorIdPedido
        Pedidos_TX_DetallesPorIdPedidoAgrupados
        Pedidos_TX_DetallesPorIdPedidoAgrupadosPorObra
        Pedidos_TX_DetPendientes
        Pedidos_TX_DetPendientesTodos
        Pedidos_TX_DetPendientesTodosVencidos
        Pedidos_TX_EstadoSubcontratos
        Pedidos_TX_Exterior
        Pedidos_TX_HabilitadosParaWeb
        Pedidos_TX_ParaComboAsignacionImportacion
        Pedidos_TX_ParaPasarAPrestoCabeceras
        Pedidos_TX_ParaPasarAPrestoDetalles
        Pedidos_TX_ParaTransmitir
        Pedidos_TX_ParaTransmitir_Todos
        Pedidos_TX_Pendientes
        Pedidos_TX_PendientesParaArbol
        Pedidos_TX_PendientesParaLista
        Pedidos_TX_PendientesPorIdDetallePedido
        Pedidos_TX_PorArticuloRubro
        Pedidos_TX_PorFechaVencimiento
        Pedidos_TX_PorId
        Pedidos_TX_PorIdDetallePedido
        Pedidos_TX_PorIdParaCOMEX
        Pedidos_TX_PorIdParaCOMEXDetalles
        Pedidos_TX_PorItemRequerimiento
        Pedidos_TX_PorNumero
        Pedidos_TX_PorNumeroBis
        Pedidos_TX_PorNumeroSubcontrato
        Pedidos_TX_PorObra
        Pedidos_TX_PorObraParaCombo
        Pedidos_TX_Precios
        Pedidos_TX_RecepcionesPorIdDetallePedido
        Pedidos_TX_RecepcionesPorIdPedido
        Pedidos_TX_RegistroDePedidos
        Pedidos_TX_SetearComoTransmitido
        Pedidos_TX_SubcontratosEntreFecha
        Pedidos_TX_SubcontratosParaCombo
        Pedidos_TX_SubContratosPorAnio
        Pedidos_TX_SubContratosPorMes
        Pedidos_TX_SubcontratosTodos
        Pedidos_TX_SumaItemAco
        Pedidos_TX_SumaItemRM
        Pedidos_TX_TodosConCodigoSAP
        Pedidos_TX_TodosLosDetalles
        Pedidos_TX_TT
        Pedidos_TXAnio
        Pedidos_TXFecha
        Pedidos_TXMes
        PedidosAbiertos_A
        PedidosAbiertos_E
        PedidosAbiertos_M
        PedidosAbiertos_T
        PedidosAbiertos_TL
        PedidosAbiertos_TT
        PedidosAbiertos_TX_Control
        PedidosAbiertos_TX_EstadoPedidos
        PedidosAbiertos_TX_PedidosHijos
        PedidosAbiertos_TX_PorProveedorParaCombo
        PedidosAbiertos_TX_TT
        PedidosSAT_A
        PedidosSAT_ActualizarDetalles
        PedidosSAT_M
        PedidosSAT_T
        PedidosSAT_TT
        PedidosSAT_TX_PorIdOrigen
        PedidosSAT_TX_PorIdOrigenDetalle
        PedidosSAT_TX_PorOrigen
        PedidosSAT_TXAnio
        PedidosSAT_TXFecha
        PedidosSAT_TXMes
        Planos_A
        Planos_E
        Planos_M
        Planos_T
        Planos_TL
        Planos_TT
        Planos_TX_ParaTransmitir
        Planos_TX_ParaTransmitir_Todos
        Planos_TX_SetearComoTransmitido
        Planos_TX_TT
        PlazosEntrega_A
        PlazosEntrega_E
        PlazosEntrega_M
        PlazosEntrega_T
        PlazosEntrega_TL
        PlazosEntrega_TT
        PlazosEntrega_TX_PorId
        PlazosEntrega_TX_TT
        PlazosFijos_A
        PlazosFijos_E
        PlazosFijos_M
        PlazosFijos_T
        PlazosFijos_TL
        PlazosFijos_TT
        PlazosFijos_TX_AVencer
        PlazosFijos_TX_EntreFechasParaGeneracionContable
        PlazosFijos_TX_EstructuraConFormato
        PlazosFijos_TX_ParaPosicionFinancieraAFecha
        PlazosFijos_TX_PorId
        PlazosFijos_TX_TodosSF_HastaFecha_Inicio
        PlazosFijos_TX_TT
        PlazosFijos_TX_Vencidos
        PosicionesImportacion_A
        PosicionesImportacion_E
        PosicionesImportacion_M
        PosicionesImportacion_T
        PosicionesImportacion_TL
        PosicionesImportacion_TT
        PosicionesImportacion_TX_Existente
        PosicionesImportacion_TX_TT
        Presto_SetearMovimientosComoProcesados
        Presto_TX_ParaMDB
        PresupuestoFinanciero_A
        PresupuestoFinanciero_M
        PresupuestoFinanciero_T
        PresupuestoFinanciero_TX_DetalladoPorAño
        PresupuestoFinanciero_TX_DetalladoPorAño_A
        PresupuestoFinanciero_TX_DetallePorRubroContable
        PresupuestoFinanciero_TX_Estructura
        PresupuestoFinanciero_TX_PorAño
        PresupuestoFinanciero_TX_PorIdRubroContable
        PresupuestoFinanciero_TX_PorIdRubroContableAño
        PresupuestoFinanciero_TX_PorIdRubroContableMesAño
        PresupuestoObras_A
        PresupuestoObras_Actualizar
        PresupuestoObras_ActualizarCosto
        PresupuestoObras_ActualizarTeoricos
        PresupuestoObras_ActualizarTotalPresupuesto
        PresupuestoObras_Borrar
        PresupuestoObras_BorrarBase
        PresupuestoObras_BorrarTeoricos
        PresupuestoObras_E
        PresupuestoObras_ImportarHH
        PresupuestoObras_M
        PresupuestoObras_NuevaBase
        PresupuestoObras_T
        PresupuestoObras_TX_Pedidos
        PresupuestoObras_TX_PorDestinoRubro
        PresupuestoObras_TX_PorObra
        PresupuestoObras_TX_PorObraCodigoPresupuesto
        PresupuestoObras_TX_PorObraComparativa
        PresupuestoObras_TX_PorObraComparativa_Detalles
        PresupuestoObras_TX_PorObraConsumos
        PresupuestoObras_TX_PorObraConsumos_Detalles
        PresupuestoObras_TX_PorObraConsumosParaInforme
        PresupuestoObras_TX_PorObraConsumosTeoricos_Detalles
        PresupuestoObras_TX_PorObraConsumosTeoricos_Detalles_T
        PresupuestoObras_TX_PorObraPedidos
        PresupuestoObrasConsumos_A
        PresupuestoObrasConsumos_Actualizar
        PresupuestoObrasConsumos_E
        PresupuestoObrasConsumos_M
        PresupuestoObrasConsumos_T
        PresupuestoObrasNodos_A
        PresupuestoObrasNodos_ActualizarDetalles
        PresupuestoObrasNodos_ArreglaDirectorio
        PresupuestoObrasNodos_CrearPresupuesto
        PresupuestoObrasNodos_E
        PresupuestoObrasNodos_Inicializar
        PresupuestoObrasNodos_M
        PresupuestoObrasNodos_Recalcular
        PresupuestoObrasNodos_T
        PresupuestoObrasNodos_TT
        PresupuestoObrasNodos_TX_Consumos
        PresupuestoObrasNodos_TX_DetallePxQ
        PresupuestoObrasNodos_TX_EtapasImputablesPorObraParaCombo
        PresupuestoObrasNodos_TX_ParaArbol
        PresupuestoObrasNodos_TX_ParaInforme
        PresupuestoObrasNodos_TX_PorCodigoPresupuesto
        PresupuestoObrasNodos_TX_PorItem
        PresupuestoObrasNodos_TX_PorNodo
        PresupuestoObrasNodos_TX_PorNodoPadre
        PresupuestoObrasNodos_TX_PorObraCodigoPresupuesto
        PresupuestoObrasNodos_TX_PorObraComparativa
        PresupuestoObrasNodos_TX_PorObraComparativa_Detalles
        PresupuestoObrasNodos_TX_PorObraConsumos
        PresupuestoObrasNodosConsumos_A
        PresupuestoObrasNodosConsumos_E
        PresupuestoObrasNodosConsumos_M
        PresupuestoObrasNodosConsumos_T
        PresupuestoObrasRubros_A
        PresupuestoObrasRubros_E
        PresupuestoObrasRubros_M
        PresupuestoObrasRubros_T
        PresupuestoObrasRubros_TL
        PresupuestoObrasRubros_TT
        PresupuestoObrasRubros_TX_ParaComboPorTipoConsumo
        PresupuestoObrasRubros_TX_PorDescripcion
        PresupuestoObrasRubros_TX_TT
        Presupuestos_A
        Presupuestos_E
        Presupuestos_M
        Presupuestos_T
        Presupuestos_TT
        Presupuestos_TX_AdjuntosPorPresupuesto
        Presupuestos_TX_BonificacionesPorNumero
        Presupuestos_TX_DatosRMLAPorItem
        Presupuestos_TX_Detalles
        Presupuestos_TX_DetallesPorIdPresupuesto
        Presupuestos_TX_DetallesPorIdPresupuestoAgrupados
        Presupuestos_TX_DetallesPorIdPresupuestoIdComparativa
        Presupuestos_TX_PorId
        Presupuestos_TX_PorNumero
        Presupuestos_TX_PorNumeroBis
        Presupuestos_TX_PorNumeroConDatos
        Presupuestos_TX_TT
        Presupuestos_TXAnio
        Presupuestos_TXFecha
        Presupuestos_TXMes
        Presupuestos_TXMesAnio
        PROD_Maquinas_A
        PROD_Maquinas_E
        PROD_Maquinas_M
        PROD_Maquinas_T
        PROD_Maquinas_TL
        PROD_Maquinas_TT
        PROD_Maquinas_TX_PorIdArticulo
        PROD_Maquinas_TX_TT
        PROD_TiposControlCalidad_A
        PROD_TiposControlCalidad_M
        PROD_TiposControlCalidad_T
        PROD_TiposControlCalidad_TL
        PROD_TiposControlCalidad_TT
        PROD_TiposControlCalidad_TX_TT
        ProduccionAreas_A
        ProduccionAreas_E
        ProduccionAreas_M
        ProduccionAreas_T
        ProduccionAreas_TL
        ProduccionAreas_TT
        ProduccionFicha_TX_DatosPorFicha
        ProduccionFicha_TX_PorIdParaCombo
        ProduccionFichas_A
        ProduccionFichas_ActualizarEstadoRM
        ProduccionFichas_AjustarStockSalidaMaterialesAnulada
        ProduccionFichas_E
        ProduccionFichas_M
        ProduccionFichas_T
        ProduccionFichas_TT
        ProduccionFichas_TX_ArticuloAsociado
        ProduccionFichas_TX_MaterialesPorArticuloAsociadoParaCombo
        ProduccionFichas_TX_PorId
        ProduccionFichas_TX_PorIdConDatos
        ProduccionFichas_TX_PorIdDetalle
        ProduccionFichas_TX_PorIdOrigen
        ProduccionFichas_TX_ProporcionEntreProducidoyMaterial
        ProduccionFichas_TX_TT
        ProduccionLineas_A
        ProduccionLineas_E
        ProduccionLineas_M
        ProduccionLineas_T
        ProduccionLineas_TL
        ProduccionLineas_TT
        ProduccionOrdenes_A
        ProduccionOrdenes_ActualizarEstadoRM
        ProduccionOrdenes_AjustarStockSalidaMaterialesAnulada
        ProduccionOrdenes_AnularAjustarStock
        ProduccionOrdenes_CerrarAjustarStock
        ProduccionOrdenes_E
        ProduccionOrdenes_M
        ProduccionOrdenes_T
        ProduccionOrdenes_TT
        ProduccionOrdenes_TX_AbiertasParaCombo
        ProduccionOrdenes_TX_CostosPorOP
        ProduccionOrdenes_TX_DetalleDeFicha
        ProduccionOrdenes_TX_DetalleProcesosDeFicha
        ProduccionOrdenes_TX_FiltradoPorProceso
        ProduccionOrdenes_TX_PartidasQueLoUsan
        ProduccionOrdenes_TX_PartidasUsadas
        ProduccionOrdenes_TX_PorId
        ProduccionOrdenes_TX_PorIdConDatos
        ProduccionOrdenes_TX_PorIdDetalle
        ProduccionOrdenes_TX_PorIdOrigen
        ProduccionOrdenes_TX_PorProceso
        ProduccionOrdenes_TX_Producidos
        ProduccionOrdenes_TX_SinCerrarParaCombo
        ProduccionOrdenes_TX_SinCerrarParaLista
        ProduccionOrdenes_TX_TienePartesAbiertosAsociados
        ProduccionOrdenes_TX_TieneProcesosObligatoriosSinCumplir
        ProduccionOrdenes_TX_TT
        ProduccionOrdenes_TXAnio
        ProduccionOrdenes_TXFecha
        ProduccionOrdenes_TXMes
        ProduccionParte_TX_ArticulosPorOrdenPorProcesoParaCombo
        ProduccionParte_TX_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock
        ProduccionParte_TX_PartidasDisponiblesPorOrdenProcesoParaCombo
        ProduccionPartes_A
        ProduccionPartes_M
        ProduccionPartes_T
        ProduccionPartes_TL
        ProduccionPartes_TT
        ProduccionPartes_TX_Anio
        ProduccionPartes_TX_FiltradoPorProceso
        ProduccionPartes_TX_Mes
        ProduccionPartes_TX_PorIdOrden
        ProduccionPartes_TX_PorProceso
        ProduccionPartes_TX_ProcesoAnteriorCerrado
        ProduccionPartes_TX_ProcesoAnteriorIniciado
        ProduccionPartes_TX_ProcesoAnteriorObligatorioSinRendir
        ProduccionPartes_TX_ProcesoIdenticoEnMarcha
        ProduccionPartes_TX_ProximoNumeroEsperado
        ProduccionPartes_TX_TotalProducidoporOP
        ProduccionPartes_TX_TT
        ProduccionPartes_TX_UltimoPartePorEmpleado
        ProduccionPartes_TXAnio
        ProduccionPartes_TXFecha
        ProduccionPartes_TXMes
        ProduccionPlanes_A
        ProduccionPlanes_E
        ProduccionPlanes_M
        ProduccionPlanes_T
        ProduccionPlanes_TL
        ProduccionPlanes_TT
        ProduccionPlanes_TX_Periodo
        ProduccionProcesos_A
        ProduccionProcesos_E
        ProduccionProcesos_M
        ProduccionProcesos_T
        ProduccionProcesos_TL
        ProduccionProcesos_TT
        ProduccionProcesos_TX_IncorporanMaterialParaCombo
        ProduccionProcesos_TX_TT
        ProduccionProgRecursos_A
        ProduccionProgRecursos_E
        ProduccionProgRecursos_M
        ProduccionProgRecursos_T
        ProduccionProgRecursos_TL
        ProduccionProgRecursos_TT
        ProduccionSectores_A
        ProduccionSectores_E
        ProduccionSectores_M
        ProduccionSectores_T
        ProduccionSectores_TL
        ProduccionSectores_TT
        ProntoIni_Actualizar
        ProntoIni_Eliminar
        ProntoIni_T
        ProntoIni_TX_PorClave
        ProntoIni_TX_T
        ProntoIni_TX_Todo
        ProntoIniClaves_Actualizar
        ProntoIniClaves_Eliminar
        ProntoIniClaves_T
        ProntoIniClaves_TX_PorClave
        ProntoIniClaves_TX_Todo
        ProntoMantenimiento_TX_OTsPorEquipo
        ProntoMantenimiento_TX_VerificarArticulo
        ProntoWeb_CargaComprobantes
        ProntoWeb_CargaOrdenesPagoEnCaja
        ProntoWeb_CargaTablas
        ProntoWeb_CargaTodosLosUsuarios
        ProntoWeb_CertificadoGanancias_DatosPorIdOrdenPago
        ProntoWeb_CertificadoIIBB_DatosPorIdOrdenPago
        ProntoWeb_CertificadoRetencionIVA_DatosPorIdOrdenPago
        ProntoWeb_CertificadoSUSS_DatosPorIdOrdenPago
        ProntoWeb_DebeHaberSaldo
        ProntoWeb_OrdenesPagoEnCaja
        ProntoWeb_TodosLosUsuarios
        Proveedores_A
        Proveedores_ActualizarDatosIIBB
        Proveedores_BorrarEmbargos
        Proveedores_E
        Proveedores_EstadoInicialImpositivo
        Proveedores_M
        Proveedores_T
        Proveedores_TL
        Proveedores_TT
        Proveedores_TX_AConfirmar
        Proveedores_TX_Busca
        Proveedores_TX_Busca_NormalesYEventualesParaCombo
        Proveedores_TX_Busca1
        Proveedores_TX_CITI
        Proveedores_TX_Comprobantes
        Proveedores_TX_Comprobantes_Modelo2
        Proveedores_TX_ConDatos
        Proveedores_TX_Contactos
        Proveedores_TX_ControlPorCodigoEmpresa
        Proveedores_TX_Emails
        Proveedores_TX_Eventuales
        Proveedores_TX_EventualesParaCombo
        Proveedores_TX_Fax
        Proveedores_TX_NormalesYEventualesParaCombo
        Proveedores_TX_ParaTransmitir
        Proveedores_TX_ParaTransmitir_Todos
        Proveedores_TX_PercepcionesIIBB
        Proveedores_TX_PercepcionesIIBB_SIRCREB
        Proveedores_TX_PercepcionesIVA
        Proveedores_TX_PorCodigo
        Proveedores_TX_PorCodigoEmpresa
        Proveedores_TX_PorCodigoPresto
        Proveedores_TX_PorCodigoSAP
        Proveedores_TX_PorCodigoSAPParaCombo
        Proveedores_TX_PorCuit
        Proveedores_TX_PorCuitNoEventual
        Proveedores_TX_PorCuitParcial
        Proveedores_TX_PorId
        Proveedores_TX_PorRubrosProvistos
        Proveedores_TX_RankingCompras
        Proveedores_TX_ResumenCompras
        Proveedores_TX_Resumido
        Proveedores_TX_RetencionesGanancias
        Proveedores_TX_RetencionesIIBB
        Proveedores_TX_RetencionesIIBB_DatosProveedores
        Proveedores_TX_RetencionesIVA
        Proveedores_TX_SetearComoTransmitido
        Proveedores_TX_SICORE
        Proveedores_TX_SoloCuit
        Proveedores_TX_SUSS
        Proveedores_TX_TodosParaCombo
        Proveedores_TX_TT
        Proveedores_TX_TT_Eventual
        Proveedores_TX_UnRegistroResumen
        Proveedores_TX_ValidarPorCuit
        ProveedoresRubros_A
        ProveedoresRubros_E
        ProveedoresRubros_M
        ProveedoresRubros_T
        ProveedoresRubros_TT
        ProveedoresRubros_TX_TT
        ProveedoresRubros_TXPrimero
        ProveedoresRubros_TXProv
        Provincias_A
        Provincias_E
        Provincias_M
        Provincias_T
        Provincias_TL
        Provincias_TT
        Provincias_TX_ParaTransmitir
        Provincias_TX_ParaTransmitir_Todos
        Provincias_TX_PorId
        Provincias_TX_PorNombre
        Provincias_TX_SetearComoTransmitido
        Provincias_TX_TT
        PuntosVenta_A
        PuntosVenta_E
        PuntosVenta_M
        PuntosVenta_T
        PuntosVenta_TL
        PuntosVenta_TT
        PuntosVenta_TX_Duplicados
        PuntosVenta_TX_PorId
        PuntosVenta_TX_PorIdTipoComprobante
        PuntosVenta_TX_PorIdTipoComprobantePuntoVenta
        PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra
        PuntosVenta_TX_PuntosVentaTodos
        PuntosVenta_TX_TT
        Rangos_A
        Rangos_E
        Rangos_M
        Rangos_T
        Rangos_TL
        Rangos_TT
        Rangos_TX_TT
        Recepciones_A
        Recepciones_ActualizarDetalles
        Recepciones_ActualizarEstadoPedidos
        Recepciones_AjustarStockRecepcionAnulada
        Recepciones_E
        Recepciones_M
        Recepciones_MarcarComoProcesadoCP
        Recepciones_T
        Recepciones_TT
        Recepciones_TX_ComprobantesProveedoresPorIdRecepcion
        Recepciones_TX_DatosPorIdDetalleRecepcion
        Recepciones_TX_DetallesParaBienesDeUso
        Recepciones_TX_DetallesParaComprobantesProveedores
        Recepciones_TX_DetallesPorIdRecepcion
        Recepciones_TX_EntreFechas
        Recepciones_TX_MaterialesRecibidos
        Recepciones_TX_MaterialesRecibidosAprobados
        Recepciones_TX_MaterialesRecibidosDatosTransporte
        Recepciones_TX_PendientesDeComprobante
        Recepciones_TX_PendientesDeComprobanteDetallado
        Recepciones_TX_PendientesPorIdDetalle
        Recepciones_TX_PorId
        Recepciones_TX_PorIdOrigen
        Recepciones_TX_PorIdOrigenDetalle
        Recepciones_TX_PorNumeroInterno
        Recepciones_TX_Todos
        Recepciones_TX_TT
        Recepciones_TX_Ultimos3Meses
        Recepciones_TX_xNro
        Recepciones_TX_xNroLetra
        Recepciones_TXAnio
        Recepciones_TXFecha
        Recepciones_TXMes
        RecepcionesSAT_A
        RecepcionesSAT_ActualizarDetalles
        RecepcionesSAT_M
        RecepcionesSAT_T
        RecepcionesSAT_TT
        RecepcionesSAT_TX_EntreFechas
        RecepcionesSAT_TX_PorIdOrigen
        RecepcionesSAT_TX_PorIdOrigenDetalle
        RecepcionesSAT_TXAnio
        RecepcionesSAT_TXFecha
        RecepcionesSAT_TXMes
        Recibos_A
        Recibos_ActualizarDetalles
        Recibos_E
        Recibos_M
        Recibos_T
        Recibos_TT
        Recibos_TX_AnalisisCobranzas
        Recibos_TX_CajaIngresos
        Recibos_TX_EntreFechasParaGeneracionContable
        Recibos_TX_LoteSublote
        Recibos_TX_ParaTransmitir
        Recibos_TX_PorCobrador
        Recibos_TX_PorEstadoValores
        Recibos_TX_PorId
        Recibos_TX_PorIdOrigen
        Recibos_TX_PorIdOrigenDetalle
        Recibos_TX_PorIdOrigenDetalleCuentas
        Recibos_TX_PorIdOrigenDetalleRubrosContables
        Recibos_TX_PorIdOrigenDetalleValores
        Recibos_TX_PorIdPuntoVenta_Numero
        Recibos_TX_PorServicioCobro
        Recibos_TX_SetearComoTransmitido
        Recibos_TX_TodosSF_HastaFecha
        Recibos_TX_TT
        Recibos_TX_ValoresEnConciliacionesPorIdRecibo
        Recibos_TXAnio
        Recibos_TXCod
        Recibos_TXFecha
        Recibos_TXMes
        Recibos_TXMesAnio
        Recibos_TXRecibosxAnio
        Relaciones_A
        Relaciones_E
        Relaciones_M
        Relaciones_T
        Relaciones_TL
        Relaciones_TT
        Relaciones_TX_TT
        Remitos_A
        Remitos_AjustarStockRemitoAnulado
        Remitos_E
        Remitos_M
        Remitos_T
        Remitos_TT
        Remitos_TX_DetalladoPorFechas
        Remitos_TX_DetallesPendientesDeFacturarPorIdCliente
        Remitos_TX_DetallesPendientesDeFacturarPorIdDetalleOrdenCompra
        Remitos_TX_DetallesPorIdRemito
        Remitos_TX_FacturasPorIdRemito
        Remitos_TX_ItemsPendientesDeFacturar
        Remitos_TX_ItemsPendientesDeFacturarPorFechaCliente
        Remitos_TX_OrdenCompraPorIdRemito
        Remitos_TX_PorId
        Remitos_TX_TT
        Remitos_TXAnio
        Remitos_TXFecha
        Remitos_TXMes
        REP_COTIZACION_MARK
        REP_COTIZACION_SEL
        REP_CTAPRO_MARK
        REP_CTAPRO_SEL
        REP_CUENTAS
        REP_IMPUTAC_MARK
        REP_IMPUTAC_SEL
        REP_OBRAS
        REP_PROVEEDO_MARK
        REP_PROVEEDO_SEL
        Requerimientos_A
        Requerimientos_ActualizarDetalles
        Requerimientos_ActualizarEstado
        Requerimientos_AnularItem
        Requerimientos_E
        Requerimientos_EliminarRequerimientosAConfirmar
        Requerimientos_M
        Requerimientos_RegistrarImpresion
        Requerimientos_T
        Requerimientos_TT
        Requerimientos_TX_AConfirmar
        Requerimientos_TX_ALiberar
        Requerimientos_TX_Cumplidos
        Requerimientos_TX_DadosPorCumplidos
        Requerimientos_TX_DatosObra
        Requerimientos_TX_DatosRequerimiento
        Requerimientos_TX_DesarrolloItems1
        Requerimientos_TX_DesarrolloItems2
        Requerimientos_TX_EntregasConcretadas
        Requerimientos_TX_ItemsPorObra
        Requerimientos_TX_ItemsPorObra1
        Requerimientos_TX_ItemsPorObra2
        Requerimientos_TX_ItemsPorObra3
        Requerimientos_TX_Pendientes
        Requerimientos_TX_Pendientes1
        Requerimientos_TX_PendientesDeAsignacion
        Requerimientos_TX_PendientesDeFirma
        Requerimientos_TX_PendientesPlaneamiento
        Requerimientos_TX_PendientesPorIdRM
        Requerimientos_TX_PendientesPorRM
        Requerimientos_TX_PendientesPorRM1
        Requerimientos_TX_PendientesPorSolicitud
        Requerimientos_TX_PorCC
        Requerimientos_TX_PorDetLmat
        Requerimientos_TX_PorId
        Requerimientos_TX_PorIdObra
        Requerimientos_TX_PorIdOrigen
        Requerimientos_TX_PorIdOrigenDetalle
        Requerimientos_TX_PorIdSectorFecha
        Requerimientos_TX_PorNumero
        Requerimientos_TX_PorObra
        Requerimientos_TX_PorPRESTOContrato
        Requerimientos_TX_SinControl
        Requerimientos_TX_SinFechaNecesidad
        Requerimientos_TX_Sumarizadas
        Requerimientos_TX_TodosLosDetalles
        Requerimientos_TX_TodosPorIdSector
        Requerimientos_TX_TT
        Requerimientos_TX_ValidarNumero
        Requerimientos_TXAnio
        Requerimientos_TXFecha
        Requerimientos_TXMes
        Requerimientos_TXPorNumeroObra
        Requerimientos_TXPorObra
        Reservas_A
        Reservas_E
        Reservas_Generar
        Reservas_M
        Reservas_T
        Reservas_TT
        Reservas_TX_DesdeDetalle
        Reservas_TX_PorObra
        Reservas_TX_Reservar
        Reservas_TX_Reservar_Acopios
        Reservas_TX_Reservar_PorObra
        Reservas_TX_Reservar_RM
        Reservas_TX_Sumarizadas
        Reservas_TX_Todas
        Reservas_TX_TT
        Revaluos_A
        Revaluos_E
        Revaluos_M
        Revaluos_T
        Revaluos_TL
        Revaluos_TT
        Revaluos_TX_TT
        Rubros_A
        Rubros_E
        Rubros_M
        Rubros_T
        Rubros_TL
        Rubros_TT
        Rubros_TX_ParaTransmitir
        Rubros_TX_ParaTransmitir_Todos
        Rubros_TX_PorId
        Rubros_TX_SetearComoTransmitido
        Rubros_TX_TT
        RubrosContables_A
        RubrosContables_E
        RubrosContables_M
        RubrosContables_T
        RubrosContables_TL
        RubrosContables_TT
        RubrosContables_TX_EntreFechas
        RubrosContables_TX_Financieros
        RubrosContables_TX_ParaCombo
        RubrosContables_TX_ParaComboFinancierosEgresos
        RubrosContables_TX_ParaComboFinancierosIngresos
        RubrosContables_TX_ParaComboFinancierosTodos
        RubrosContables_TX_ParaGastosPorObra
        RubrosContables_TX_PorCodigo
        RubrosContables_TX_PorId
        RubrosContables_TX_TT
        RubrosContables_TX_TT_Financieros
        RubrosValores_A
        RubrosValores_E
        RubrosValores_M
        RubrosValores_T
        RubrosValores_TL
        RubrosValores_TT
        RubrosValores_TX_TT
        SalidasMateriales_A
        SalidasMateriales_ActualizarDetalles
        SalidasMateriales_ActualizarEstadoRM
        SalidasMateriales_AjustarStockSalidaMaterialesAnulada
        SalidasMateriales_E
        SalidasMateriales_M
        SalidasMateriales_T
        SalidasMateriales_TT
        SalidasMateriales_TX_ControlarParteDiarioEquipoDestino
        SalidasMateriales_TX_DatosPorIdDetalle
        SalidasMateriales_TX_DatosTransporte
        SalidasMateriales_TX_DetalladoPorFechas
        SalidasMateriales_TX_DetallesParametrizados
        SalidasMateriales_TX_DetallesPorNumero
        SalidasMateriales_TX_EntreFechas
        SalidasMateriales_TX_OTsOPs
        SalidasMateriales_TX_ParaTransmitir
        SalidasMateriales_TX_PendientesSAT
        SalidasMateriales_TX_PorId
        SalidasMateriales_TX_PorIdDetalle
        SalidasMateriales_TX_PorIdOrdenTrabajo_TipoSalida
        SalidasMateriales_TX_PorIdOrigen
        SalidasMateriales_TX_PorIdOrigenDetalle
        SalidasMateriales_TX_Recepciones_y_Envios
        SalidasMateriales_TX_SetearComoTransmitido
        SalidasMateriales_TX_Todas
        SalidasMateriales_TX_Todos
        SalidasMateriales_TX_TraerVale
        SalidasMateriales_TX_TT
        SalidasMateriales_TX_TT_DetallesParametrizados
        SalidasMateriales_TXAnio
        SalidasMateriales_TXFecha
        SalidasMateriales_TXMes
        SalidasMaterialesSAT_A
        SalidasMaterialesSAT_ActualizarDetalles
        SalidasMaterialesSAT_M
        SalidasMaterialesSAT_T
        SalidasMaterialesSAT_TX_PorIdOrigen
        SalidasMaterialesSAT_TX_PorIdOrigenDetalle
        SalidasMaterialesSAT_TX_Todas
        SalidasMaterialesSAT_TXAnio
        SalidasMaterialesSAT_TXFecha
        SalidasMaterialesSAT_TXMes
        Schedulers_A
        Schedulers_E
        Schedulers_M
        Schedulers_T
        Schedulers_TL
        Schedulers_TT
        Schedulers_TX_TT
        Sectores_A
        Sectores_E
        Sectores_M
        Sectores_T
        Sectores_TL
        Sectores_TT
        Sectores_TX_ParaHH
        Sectores_TX_ParaHH1
        Sectores_TX_ParaTransmitir
        Sectores_TX_ParaTransmitir_Todos
        Sectores_TX_PorDescripcion
        Sectores_TX_PorId
        Sectores_TX_SetearComoTransmitido
        Sectores_TX_SinSectorOrigen
        Sectores_TX_TT
        Series_A
        Series_E
        Series_M
        Series_T
        Series_TL
        Series_TT
        Series_TX_TT
        SiNo_T
        SiNo_TL
        SiNo_TT
        SiNo_TX_TT
        SISTEMA_TX_1
        SolicitudesCompra_A
        SolicitudesCompra_E
        SolicitudesCompra_M
        SolicitudesCompra_T
        SolicitudesCompra_TT
        SolicitudesCompra_TX_TT
        SolicitudesCompra_TXAnio
        SolicitudesCompra_TXFecha
        SolicitudesCompra_TXMes
        Stock_A
        Stock_ActualizarDesdeSAT
        Stock_M
        Stock_TX_CompletoPorArticulo
        Stock_TX_Control_Reposicion_Minimo
        Stock_TX_ControlContraCardex
        Stock_TX_ExistenciaPorArticulo
        Stock_TX_ExistenciaPorIdArticulo
        Stock_TX_PartidasDisponibles
        Stock_TX_PorIdArticuloUbicacion
        Stock_TX_PorNumeroCaja
        Stock_TX_RegistrosConStockDisponiblePorIdArticulo
        Stock_TX_RegistrosConStockNegativo
        Stock_TX_STK
        Subcontratos_A
        Subcontratos_ActualizarDetalles
        Subcontratos_E
        Subcontratos_M
        Subcontratos_Recalcular
        Subcontratos_T
        Subcontratos_TT
        Subcontratos_TX_Consumos
        Subcontratos_TX_DatosParaCombo
        Subcontratos_TX_DetallePxQ
        Subcontratos_TX_EtapasConConsumos
        Subcontratos_TX_EtapasParaCombo
        Subcontratos_TX_HojaRuta
        Subcontratos_TX_Ordenado
        Subcontratos_TX_ParaArbol
        Subcontratos_TX_PorNodo
        Subcontratos_TX_PorNodoPadre
        Subcontratos_TX_PorNumeroSubcontrato
        Subcontratos_TX_TT
        SubcontratosDatos_A
        SubcontratosDatos_M
        SubcontratosDatos_TX_PorNumeroSubcontrato
        Subdiarios_A
        Subdiarios_ActualizarComprobantes
        Subdiarios_BorrarComprasEntreFechas
        Subdiarios_BorrarEntreFechas
        Subdiarios_E
        Subdiarios_M
        Subdiarios_T
        Subdiarios_TT
        Subdiarios_TX_AgrupadosPorMesAño
        Subdiarios_TX_Estructura
        Subdiarios_TX_ParaTransmitir
        Subdiarios_TX_PorId
        Subdiarios_TX_PorIdComprobante
        Subdiarios_TX_PorIdOrigen
        Subdiarios_TX_ResumenPorIdCuentaSubdiario
        Subdiarios_TX_SetearComoTransmitido
        Subdiarios_TX_TodosSF_HastaFecha
        Subdiarios_TX_TotalesPorIdCuentaSubdiario
        Subdiarios_TX_TT
        Subdiarios_TXAnio
        Subdiarios_TXFecha
        Subdiarios_TXMes
        Subdiarios_TXSub
        Subrubros_A
        Subrubros_E
        Subrubros_M
        Subrubros_T
        Subrubros_TL
        Subrubros_TT
        Subrubros_TX_ParaTransmitir
        Subrubros_TX_ParaTransmitir_Todos
        Subrubros_TX_PorId
        Subrubros_TX_SetearComoTransmitido
        Subrubros_TX_TT
        Tareas_A
        Tareas_E
        Tareas_M
        Tareas_T
        Tareas_TL
        Tareas_TT
        Tareas_TX_PorId
        Tareas_TX_PorTipo
        Tareas_TX_PorTipoParaCombo
        Tareas_TX_TareasPorEquipo
        Tareas_TX_TareasPorEquipoSector
        Tareas_TX_TT
        TareasFijas_A
        TareasFijas_E
        TareasFijas_M
        TareasFijas_T
        TareasFijas_TT
        TareasFijas_TX_TT
        TarifasFletes_A
        TarifasFletes_E
        TarifasFletes_M
        TarifasFletes_T
        TarifasFletes_TL
        TarifasFletes_TT
        TarifasFletes_TX_TT
        TarjetasCredito_A
        TarjetasCredito_E
        TarjetasCredito_M
        TarjetasCredito_T
        TarjetasCredito_TL
        TarjetasCredito_TT
        TarjetasCredito_TX_PorId
        TarjetasCredito_TX_TT
        Tipos_A
        Tipos_E
        Tipos_M
        Tipos_T
        Tipos_TL
        Tipos_TT
        Tipos_TX_PorGrupo
        Tipos_TX_PorGrupoParaCombo
        Tipos_TX_TT
        Tipos_TX_TT_PorGrupo
        TiposCompra_TX_ParaCombo
        TiposCompra_TX_PorId
        TiposComprobante_A
        TiposComprobante_E
        TiposComprobante_M
        TiposComprobante_ModificarNumerador
        TiposComprobante_T
        TiposComprobante_TL
        TiposComprobante_TT
        TiposComprobante_TX_Buscar
        TiposComprobante_TX_ParaComboGastosBancarios
        TiposComprobante_TX_ParaComboProveedores
        TiposComprobante_TX_ParaComboVentas
        TiposComprobante_TX_PorAbreviatura
        TiposComprobante_TX_PorId
        TiposComprobante_TX_TT
        TiposCuenta_TL
        TiposCuentaGrupos_A
        TiposCuentaGrupos_ActualizarAjusteASubdiarios
        TiposCuentaGrupos_E
        TiposCuentaGrupos_M
        TiposCuentaGrupos_T
        TiposCuentaGrupos_TL
        TiposCuentaGrupos_TT
        TiposCuentaGrupos_TX_TT
        TiposEquipo_TL
        TiposImpuesto_TL
        TiposPoliza_TL
        TiposPoliza_TX_PorId
        TiposRetencionGanancia_A
        TiposRetencionGanancia_E
        TiposRetencionGanancia_M
        TiposRetencionGanancia_T
        TiposRetencionGanancia_TL
        TiposRetencionGanancia_TT
        TiposRetencionGanancia_TX_MaximoId
        TiposRetencionGanancia_TX_PorId
        TiposRetencionGanancia_TX_TT
        TiposRosca_A
        TiposRosca_E
        TiposRosca_M
        TiposRosca_T
        TiposRosca_TL
        TiposRosca_TT
        TiposRosca_TX_TT
        TiposValor_TL
        Titulos_TL
        Titulos_TX_PorId
        Traducciones_A
        Traducciones_E
        Traducciones_M
        Traducciones_T
        Traducciones_TT
        Traducciones_TX_TodosSinFormato
        Traducciones_TX_TT
        Transportistas_A
        Transportistas_E
        Transportistas_M
        Transportistas_T
        Transportistas_TL
        Transportistas_TT
        Transportistas_TX_ConDatos
        Transportistas_TX_ParaTransmitir
        Transportistas_TX_ParaTransmitir_Todos
        Transportistas_TX_PorId
        Transportistas_TX_SetearComoTransmitido
        Transportistas_TX_TT
        TTermicos_A
        TTermicos_E
        TTermicos_M
        TTermicos_T
        TTermicos_TL
        TTermicos_TT
        TTermicos_TX_TT
        Ubicaciones_A
        Ubicaciones_E
        Ubicaciones_M
        Ubicaciones_T
        Ubicaciones_TL
        Ubicaciones_TT
        Ubicaciones_TX_AbreviadoParaCombo
        Ubicaciones_TX_ParaTransmitir
        Ubicaciones_TX_PorId
        Ubicaciones_TX_PorObra
        Ubicaciones_TX_TT
        Unidades_A
        Unidades_E
        Unidades_M
        Unidades_T
        Unidades_TL
        Unidades_TT
        Unidades_TX_ParaTransmitir_Todos
        Unidades_TX_PorAbreviatura
        Unidades_TX_PorId
        Unidades_TX_TT
        UnidadesEmpaque_A
        UnidadesEmpaque_E
        UnidadesEmpaque_M
        UnidadesEmpaque_T
        UnidadesEmpaque_TT
        UnidadesEmpaque_TX_NetoPorPartidaConsolidada
        UnidadesEmpaque_TX_PorNumero
        UnidadesEmpaque_TX_TT
        UnidadesOperativas_A
        UnidadesOperativas_E
        UnidadesOperativas_M
        UnidadesOperativas_T
        UnidadesOperativas_TL
        UnidadesOperativas_TT
        UnidadesOperativas_TX_ParaTransmitir
        UnidadesOperativas_TX_ParaTransmitir_Todos
        UnidadesOperativas_TX_SetearComoTransmitido
        UnidadesOperativas_TX_TT
        ValesSalida_A
        ValesSalida_ActualizarDetalles
        ValesSalida_ActualizarEstado
        ValesSalida_AsignarEntrega
        ValesSalida_E
        ValesSalida_M
        ValesSalida_T
        ValesSalida_TT
        ValesSalida_TX_DetalladoPorFechas
        ValesSalida_TX_DetallesParametrizados
        ValesSalida_TX_DetallesPorIdValeSalida
        ValesSalida_TX_ItemsPorObra
        ValesSalida_TX_ItemsPorObra1
        ValesSalida_TX_ItemsPorObra2
        ValesSalida_TX_ItemsPorObra3
        ValesSalida_TX_PendientesDetallado
        ValesSalida_TX_PendientesResumido
        ValesSalida_TX_PorId
        ValesSalida_TX_PorIdOrigen
        ValesSalida_TX_PorIdOrigenDetalle
        ValesSalida_TX_SalidasPorIdValeSalida
        ValesSalida_TX_Todos
        ValesSalida_TX_TodosLosItems
        ValesSalida_TX_TT
        ValesSalida_TX_TT_DetallesParametrizados
        ValesSalida_TXAnio
        ValesSalida_TXFecha
        ValesSalida_TXMes
        Valores_A
        Valores_ActualizarComprobantes
        Valores_BorrarDepositoEfectivo
        Valores_BorrarPorIdDetalleAsiento
        Valores_BorrarPorIdDetalleComprobanteProveedor
        Valores_BorrarPorIdDetalleNotaCredito
        Valores_BorrarPorIdDetalleNotaDebito
        Valores_BorrarPorIdDetalleOrdenPagoCuentas
        Valores_BorrarPorIdDetalleOrdenPagoValores
        Valores_BorrarPorIdDetalleReciboCuentas
        Valores_BorrarPorIdDetalleReciboValores
        Valores_BorrarPorIdPlazoFijo
        Valores_BorrarPorIdPlazoFijoFin
        Valores_DesmarcarComoEmitido
        Valores_DesmarcarConciliacion
        Valores_DesmarcarConfirmacion
        Valores_E
        Valores_M
        Valores_MarcarComoConciliado
        Valores_MarcarComoConfirmado
        Valores_MarcarComoEmitido
        Valores_ModificarBeneficiario
        Valores_T
        Valores_TT
        Valores_TX_ADepositar
        Valores_TX_CajasConMovimientos
        Valores_TX_CajasConMovimientosPorAnio
        Valores_TX_CajasConMovimientosPorAnioMes
        Valores_TX_ChequesPendientes
        Valores_TX_DatosParaEmisionDeCheque
        Valores_TX_DepositadosNoAcreditadosAFecha
        Valores_TX_DepositoDelValorPorIdDetalleReciboValores
        Valores_TX_EmitidosNoAcreditadosAFecha
        Valores_TX_EnCartera
        Valores_TX_EnCarteraAFecha
        Valores_TX_EntreFechasSoloGastos
        Valores_TX_GastosEntreFechas
        Valores_TX_GastosPorAnio
        Valores_TX_GastosPorAnioMes
        Valores_TX_GastosPorIdConDatos
        Valores_TX_Headers
        Valores_TX_MovimientosPorIdCaja
        Valores_TX_MovimientosPorIdTarjetaCredito
        Valores_TX_NoEmitidosPorCuenta
        Valores_TX_OtrosIngresos
        Valores_TX_OtrosIngresosEntreFecha
        Valores_TX_ParaTransmitir
        Valores_TX_PorBancoAgrupado
        Valores_TX_PorId
        Valores_TX_PorIdCuentaBancariaNumeroValor
        Valores_TX_PorIdDetalleAsiento
        Valores_TX_PorIdDetalleComprobanteProveedor
        Valores_TX_PorIdDetalleNotaCredito
        Valores_TX_PorIdDetalleNotaDebito
        Valores_TX_PorIdDetalleOrdenPagoCuentas
        Valores_TX_PorIdDetalleOrdenPagoValores
        Valores_TX_PorIdDetalleReciboCuentas
        Valores_TX_PorIdDetalleReciboValores
        Valores_TX_PorIdOrigen
        Valores_TX_PorIdPlazoFijoFin
        Valores_TX_PorIdPlazoFijoInicio
        Valores_TX_PorNumero
        Valores_TX_PorNumeroInterno
        Valores_TX_PorNumeroValorIdBanco
        Valores_TX_Resolucion1547
        Valores_TX_SetearComoTransmitido
        Valores_TX_Struc
        Valores_TX_TarjetasConMovimientos
        Valores_TX_TarjetasConMovimientosPorAnio
        Valores_TX_TarjetasConMovimientosPorAnioMes
        Valores_TX_TodosEmitidos
        Valores_TX_TodosNoEmitidos
        Valores_TX_TodosSF_HastaFecha_DebitosYCreditos
        Valores_TX_TT
        Valores_TX_TT_OtrosIngresos
        Valores_TX_VencidosAFecha
        Valores_TXAnio
        Valores_TXFecha
        Valores_TXFecha1
        Valores_TXMes
        Valores_TXMes1
        ValoresIngresos_A
        ValoresIngresos_E
        ValoresIngresos_M
        ValoresIngresos_T
        ValoresIngresos_TT
        ValoresIngresos_TX_PorDatos
        ValoresIngresos_TX_TT
        ValoresIngresos_TXAnio
        ValoresIngresos_TXFecha
        ValoresIngresos_TXMes
        Vendedores_A
        Vendedores_E
        Vendedores_M
        Vendedores_T
        Vendedores_TL
        Vendedores_TT
        Vendedores_TX_PorCodigo
        Vendedores_TX_PorCuit
        Vendedores_TX_PorNombre
        Vendedores_TX_PorUsuario
        Vendedores_TX_TT
        Vendedores_TXCod
        VentasEnCuotas_A
        VentasEnCuotas_AnulacionDePago
        VentasEnCuotas_E
        VentasEnCuotas_Eliminar
        VentasEnCuotas_M
        VentasEnCuotas_ModificarVencimientos
        VentasEnCuotas_RegistrarIdNotaDebitoEnDetalle
        VentasEnCuotas_T
        VentasEnCuotas_TT
        VentasEnCuotas_TX_CuotasAGenerar
        VentasEnCuotas_TX_CuotasCobradasAgrupadasPorBancoFecha
        VentasEnCuotas_TX_CuotasGeneradas_UnNumero
        VentasEnCuotas_TX_CuotasGeneradasAgrupadasPorNumero
        VentasEnCuotas_TX_CuotasGeneradasDetalladasPorNumero
        VentasEnCuotas_TX_CuotasGeneradasParaModificarVencimientos
        VentasEnCuotas_TX_CuotasPorIdOperacion
        VentasEnCuotas_TX_CuotasPorIdVentaEnCuotas
        VentasEnCuotas_TX_DatosPorIdDetalleVentaEnCuotas
        VentasEnCuotas_TX_DetallesPorIdVentaEnCuotasYCuota
        VentasEnCuotas_TX_NotasDebitoGeneradasPorIdVentaEnCuotas
        VentasEnCuotas_TX_PorId
        VentasEnCuotas_TX_PorIdCliente
        VentasEnCuotas_TX_PorIdClienteParaCombo
        VentasEnCuotas_TX_TT
        ViasPago_A
        ViasPago_E
        ViasPago_M
        ViasPago_T
        ViasPago_TL
        ViasPago_TT
        ViasPago_TX_TT
        wActividadesProveedores_TL
        wArticulos_A
        wArticulos_E
        wArticulos_PorCodigo
        wArticulos_PorId
        wArticulos_T
        wArticulos_TL
        wArticulos_TX_Busqueda
        wCartasDePorte_E
        wClientes_TT
        wClientes_TX_Busqueda
        wComparativas_A
        wComparativas_E
        wComparativas_T
        wComparativas_TL
        wComprobantesProveedores_A
        wComprobantesProveedores_E
        wComprobantesProveedores_T
        wComprobantesProveedores_TX_FondosFijos
        wComprobantesProveedores_TX_UltimoComprobantePorIdProveedor
        wCondicionesCompra_TL
        wCotizaciones_TX_PorFechaMoneda
        wCtasCtesA_TXPorMayorParaInfoProv
        wCuentas_TL
        wCuentas_TX_CuentasGastoPorObraParaCombo
        wCuentas_TX_FondosFijos
        wCuentas_TX_PorCodigo
        wCuentas_TX_PorId
        wCuentas_TX_PorObraCuentaGasto
        wCuentasGastos_TL
        wDescripcionIva_TL
        wDetComparativas_A
        wDetComparativas_E
        wDetComparativas_T
        wDetComparativas_TT
        wDetComprobantesProveedores_A
        wDetComprobantesProveedores_E
        wDetComprobantesProveedores_T
        wDetComprobantesProveedores_TT
        wDetComprobantesProveedoresPrv_A
        wDetComprobantesProveedoresPrv_E
        wDetComprobantesProveedoresPrv_T
        wDetOrdenesCompra_T
        wDetPedidos_A
        wDetPedidos_E
        wDetPedidos_T
        wDetPedidos_TT
        wDetPresupuestos_A
        wDetPresupuestos_E
        wDetPresupuestos_T
        wDetPresupuestos_TT
        wDetProveedoresContactos_A
        wDetProveedoresContactos_E
        wDetProveedoresContactos_T
        wDetProveedoresContactos_TT
        wDetRemitos_A
        wDetRemitos_M
        wDetRequerimientos_A
        wDetRequerimientos_E
        wDetRequerimientos_T
        wDetRequerimientos_TT
        wEmpleados_A
        wEmpleados_E
        wEmpleados_T
        wEmpleados_TL
        wEmpleados_TX_UsuarioNT
        wEstadosProveedores_TL
        wFacturas_A
        wFacturas_M
        wFacturas_TT
        wFondosFijos_A
        wFondosFijos_E
        wFondosFijos_T
        wFondosFijos_TX_RendicionesPorIdCuentaParaCombo
        wFondosFijos_TX_ResumenPorIdCuenta
        wIBCondiciones_TL
        wImpuestosDirectos_TL
        wLocalidades_E
        wLocalidades_T
        wLocalidades_TL
        wLocalidades_TX_Busqueda
        wMonedas_TL
        wNotasCredito_TT
        wObras_A
        wObras_E
        wObras_T
        wObras_TL
        wObras_TX_DestinosParaComboPorIdObra
        wObras_TX_PorIdCuentaFFParaCombo
        wOrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente
        wOrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente
        wOrdenesPago_TX_EnCajaPorProveedor
        wPaises_A
        wPaises_E
        wPaises_T
        wPaises_TL
        wParametros_T
        wPedidos_A
        wPedidos_E
        wPedidos_T
        wPedidos_T_ByEmployee
        wPlazosEntrega_TL
        wPresupuestos_A
        wPresupuestos_E
        wPresupuestos_T
        wPresupuestos_TX_PorNumero
        wProveedores_A
        wProveedores_E
        wProveedores_T
        wProveedores_TL
        wProveedores_TX_Busqueda
        wProveedores_TX_PorCuit
        wProvincias_A
        wProvincias_E
        wProvincias_T
        wProvincias_TL
        wRemitos_A
        wRemitos_M
        wRemitos_TT
        wRequerimientos_A
        wRequerimientos_E
        wRequerimientos_N
        wRequerimientos_T
        wRequerimientos_T_ByEmployee
        wRequerimientos_TX_PendientesDeAsignacion
        wRubros_A
        wRubros_E
        wRubros_T
        wRubros_TL
        wSectores_TL
        wSubrubros_A
        wSubrubros_E
        wSubrubros_T
        wSubrubros_TL
        wTablasGenerales_ParaCombo
        wTiposComprobante_TX_ParaComboProveedores
        wTiposRetencionGanancia_TL
        wUnidades_TL
        wRequerimientos_TXFecha

    End Enum


End Module
















Public Module ProntoDebug

    Public Sub DebugDatatableAlEscritorio(ByVal dt As DataTable)
        Try
            'XP directorio
            'dt.WriteXml("C:\Documents and Settings\Administrador\Escritorio\datatable.xml")
            'SEVEN directorio
            dt.WriteXml("C:\Users\Mariano\Desktop\datatable.xml")
        Catch ex As Exception

        End Try
    End Sub


    Public Function DebugCadenaImprimible(ByVal s As String) As String
        DebugCadenaImprimible = ""

        For i As Integer = 0 To Len(s) - 1
            If s(i) = """" Then
                DebugCadenaImprimible += """"""
            ElseIf IsPrintable(s(i)) Then
                DebugCadenaImprimible += s(i)
            Else
                DebugCadenaImprimible += """& chr(" & Asc(s(i)) & ") & """
            End If
        Next

    End Function



    Function DebugGetDataTableColumnNamesRS(ByVal rs As ADOR.Recordset)
        DebugGetDataTableColumnNamesRS = ""
        For i As Integer = 0 To rs.Fields.Count - 1
            DebugGetDataTableColumnNamesRS += rs.Fields(i).Name + ", "
        Next
    End Function

    Function DebugGetDataTableColumnNamesRS(ByVal rs As adodb.Recordset)
        DebugGetDataTableColumnNamesRS = ""
        For i As Integer = 0 To rs.Fields.Count - 1
            DebugGetDataTableColumnNamesRS += rs.Fields(i).Name + ", "
        Next
    End Function

    Function DebugGetDataTableColumnNames(ByVal dt As Data.DataTable) As String
        DebugGetDataTableColumnNames = ""
        For i As Integer = 0 To dt.Columns.Count - 1
            DebugGetDataTableColumnNames += dt.Columns(i).ColumnName + ", "
        Next
    End Function

    Function DebugGetDataTableColumnNames(ByVal dr As Data.DataRow) As String
        Return DebugGetDataTableColumnNames(dr.Table)
    End Function



    Function DebugGetStoreProcedureParameters(ByRef myCommand As SqlCommand) As String()
        Try

            Dim params As New List(Of String)
            Dim faltan As New List(Of String)

            'Primero ve los que hay creados
            Dim s As String = ""
            For Each p As SqlParameter In myCommand.Parameters
                params.Add(p.ParameterName)
                's += p.ParameterName + ", "
            Next

            'Debug.Print(s)
            'Return Split(myCommand.Parameters.ToString)



            myCommand.Parameters.Clear()


            SqlCommandBuilder.DeriveParameters(myCommand)

            For Each p As SqlParameter In myCommand.Parameters
                s = p.ParameterName
                If params.Find(Function(o) o = s) = "" Then
                    'no lo encontró
                    faltan.Add(s)
                Else
                    params.Remove(s)
                End If
            Next

            Debug.Print(Join(faltan.ToArray))
            Debug.Print(Join(params.ToArray))
            ErrHandler.WriteError("Error en la llamada a " & myCommand.CommandText & " . Faltan parametros " & Join(faltan.ToArray) & " y sobran " & Join(params.ToArray))
            'los que queden al llegar acá, son sobrantes 

            'Stop
        Catch ex As Exception

        End Try
    End Function




















End Module