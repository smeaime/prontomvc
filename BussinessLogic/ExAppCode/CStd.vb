Imports Microsoft.VisualBasic

Public Class CStd
    '    Option Explicit

    '    Public Enum SimpleDataType
    '        tdInteger
    '        tdNumber
    '        tdDecimal
    '        tdCurrency
    '        tdDateTime
    '        tdDate
    '        tdTime
    '        tdString
    '    End Enum

    '    Public Enum CmpOperators
    '        OP_EQUAL
    '        OP_MAJOR
    '        OP_MAJOROREQUAL
    '        OP_MINOR
    '        OP_MINOROREQUAL
    '        OP_LIKE
    '        OP_BETWEEN
    '    End Enum

    '    'Public Property Get FT_USR_CURRENCY() As String
    '    '    FT_USR_CURRENCY = "$ 0.00"
    '    '    End Property

    '    'Public Property Get FT_USR_INTEGER() As String
    '    '    FT_USR_INTEGER = "0"
    '    '    End Property

    '    'Public Property Get FT_USR_STRING() As String
    '    '    FT_USR_STRING = ""
    '    '    End Property

    '    'Public Property Get FT_USR_DATE() As String
    '    '    FT_USR_DATE = "dd/mm/yyyy"
    '    '    End Property

    '    'Public Property Get FT_USR_TIME() As String
    '    '    FT_USR_TIME = "hh:ss AMPM"
    '    '    End Property

    '    'Public Property Get FT_USR_DATETIME() As String
    '    '    FT_USR_DATETIME = "dd/mm/yyyy hh:ss AMPM"
    '    '    End Property

    '    'Public Property Get FT_DB_DATETIME() As String
    '    '    FT_DB_DATETIME = "dd/mm/yyyy hh:ss AMPM"
    '    '    End Property

    '    'Public Property Get FT_DB_NUMBER() As String
    '    '    FT_DB_NUMBER = "0.00"
    '    '    End Property
    '    'Public Property Get FT_DB_NULL() As String
    '    '    FT_DB_NULL = "NULL"
    '    '    End Property


    '    'Public Property Get FT_DB_TIME() As String
    '    '    FT_DB_TIME = "hh:ss AMPM"
    '    '    End Property

    '    'Public Property Get FT_DB_DATE() As String
    '    '    FT_DB_DATE = "dd/mm/yyyy"
    '    '    End Property

    '    'Public Property Get FT_DB_STRING() As String
    '    '    FT_DB_STRING = ""
    '    '    End Property

    '    'Public Property Get FT_DB_INTEGER() As String
    '    '    FT_DB_INTEGER = "0"
    '    '    End Property

    '    'Public Property Get FT_USR_NULL() As String
    '    '    FT_USR_NULL = "NULL"
    '    '    End Property

    '    'Public Property Get FT_DB_CURRENCY() As String
    '    '    FT_DB_CURRENCY = "$ 0.00"
    '    '    End Property

    '    'Public Property Get FT_USR_NUMBER() As String
    '    '    FT_USR_NUMBER = "0.00"
    '    '    End Property



    '    '//////////////////////////////////////////////////////////////////////
    '    ''#If Win32 Then
    '    '    'Declaraciones para 32 bits
    '    'Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" _
    '    '        (ByVal lpApplicationName As String, ByVal lpKeyName As Any, _
    '    '         ByVal lpDefault As String, ByVal lpReturnedString As String, _
    '    '         ByVal nSize As Long, ByVal lpFileName As String) As Long
    '    'Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" _
    '    '        (ByVal lpApplicationName As String, ByVal lpKeyName As Any, _
    '    '         ByVal lpString As Any, ByVal lpFileName As String) As Long
    '    ''#Else
    '    ''    'Declaraciones para 16 bits
    '    ''    Private Declare Function GetPrivateProfileString Lib "Kernel" _
    '    ''        (ByVal lpApplicationName As String, ByVal lpKeyName As Any, _
    '    ''         ByVal lpDefault As String, ByVal lpReturnedString As String, _
    '    ''         ByVal nSize As Integer, ByVal lpFileName As String) As Integer
    '    ''    Private Declare Function WritePrivateProfileString Lib "Kernel" _
    '    ''        (ByVal lpApplicationName As String, ByVal lpKeyName As Any, _
    '    ''         ByVal lpString As Any, ByVal lplFileName As String) As Integer
    '    ''#End If
    '    '//////////////////////////////////////////////////////////////////////

    '    Public Function GetFormatString(ByVal f As SimpleDataType) As String
    '        If f = tdCurrency Then
    '            GetFormatString = FT_USR_CURRENCY
    '        ElseIf f = tdInteger Then
    '            GetFormatString = FT_USR_INTEGER
    '        ElseIf f = tdString Then
    '            GetFormatString = ""
    '        ElseIf f = tdDate Then
    '            GetFormatString = FT_USR_DATE
    '        ElseIf f = tdTime Then
    '            GetFormatString = FT_USR_TIME
    '        ElseIf f = tdDateTime Then
    '            GetFormatString = FT_USR_DATETIME
    '        ElseIf f = tdNumber Then
    '            GetFormatString = FT_USR_NUMBER
    '        End If
    '    End Function

    '    '#Region String

    '    '////////////////////////////////////////////////////////////////////
    '    '   String
    '    '////////////////////////////////////////////////////////////////////
    '    Public Sub Split2(ByVal str As String, ByVal Delimiter As String, ByRef rv() As String)
    '        'Idem split pero no devuelve subcadenas del separador solo
    '        'trimea todo
    '        Dim m() As String, _
    '            i As Long, _
    '            j As Long, _
    '            SubCadenas As Long

    '        m = Split(str, Delimiter)
    '        SubCadenas = 0
    '        For i = LBound(m) To UBound(m)
    '            If m(i) <> "" Then SubCadenas = SubCadenas + 1
    '        Next
    '    ReDim rv(0 To SubCadenas - 1) As String

    '        j = 0
    '        For i = LBound(m) To UBound(m)
    '            If m(i) <> "" Then
    '                rv(j) = m(i)
    '                j = j + 1
    '            End If
    '        Next
    '    End Sub
    '    '#End Region

    '    '#Region ADO

    '    Sub ErrorCloseCN(ByVal cn As ADODB.Connection, ByVal ExtTrans As Boolean)
    '        'Para cerrar la conexion dentro de rutinas de error
    '        On Error Resume Next
    '        If Not ExtTrans Then
    '            cn.RollbackTrans()
    '            FreeCN(cn)
    '        End If
    '    End Sub

    '    Sub CopyErr(ByVal e As ErrObject, ByVal Number As Long, ByVal Source As String, ByVal Desc As String, ByVal HelpFile As String, ByVal HelpContext As String)
    '        'Como dentro de las rutinas de error si algun proc genera un error (que lo intercepta(lo DEBE interceptar))
    '        'Hay que guardar el error original para redispararlo
    '        Number = e.Number
    '        Desc = e.Description
    '        Source = e.Source
    '        HelpFile = e.HelpContext
    '        HelpContext = e.HelpContext
    '    End Sub


    '    Sub FreeCN(ByRef cn As ADODB.Connection)
    '        On Error Resume Next
    '        If cn Is Nothing Then Exit Sub
    '        If cn.State = adStateOpen Then cn.Close()
    '        cn = Nothing
    '    End Sub

    '    Public Sub FreeRS(ByRef rs As ADODB.Recordset)
    '        On Error Resume Next
    '        If rs Is Nothing Then Exit Sub
    '        If rs.State = adStateOpen Then rs.Close()
    '        rs = Nothing
    '    End Sub

    '    Public Function GetDisconnectedRs(ByVal Source As String, ByVal ConnString, Optional ByVal cnRef As ADODB.Connection = Nothing) As ADODB.Recordset
    '        On Error GoTo rErrores
    '        Dim rs As New ADODB.Recordset, cn As New ADODB.Connection

    '        If cnRef Is Nothing Then
    '            With cn
    '                .ConnectionString = ConnString
    '                .CursorLocation = adUseClient
    '                .Open()
    '            End With
    '        Else
    '            cn = cnRef
    '        End If

    '        With rs
    '            .LockType = adLockBatchOptimistic
    '            .CursorType = adOpenStatic
    '            .CursorLocation = adUseClient
    '            .Source = Source
    '            Debug.Print(Source)
    '            .ActiveConnection = cn
    '            .Open()
    '        End With
    '        rs.ActiveConnection = Nothing
    '        If cnRef Is Nothing Then FreeCN(cn)
    '        GetDisconnectedRs = rs
    '        rs = Nothing
    '        Exit Function
    'rErrores:
    '        FreeCN(cn)
    '        FreeRS(rs)
    '        Err.Raise(Err.Number, "GetDisconnectedRs", Err.Description, Err.HelpFile, Err.HelpContext)
    '    End Function



    '    Public Function HaveRows(ByRef rs As ADODB.Recordset) As Boolean
    '        With rs
    '            HaveRows = Not (.EOF And .BOF)
    '        End With
    '    End Function

    '    'Public Function RsCurrentRowToPropBag(ByRef rs As ADODB.Recordset) As PropertyBag
    '    '    Dim Prop As New PropertyBag, _
    '    '        f As ADODB.Field
    '    '    For Each f In rs.Fields
    '    '        Prop.WriteProperty(f.Name, CStr(rs(f.Name) & vbNullString))
    '    '    Next
    '    '    RsCurrentRowToPropBag = Prop
    '    '    Prop = Nothing
    '    'End Function

    '    'Public Function RunScalarQuery(ByVal Query As String, ByVal ConnString, Optional ByVal cn As ADODB.Connection = Nothing) As Object
    '    '    Dim rs As ADODB.Recordset
    '    '    rs = GetDisconnectedRs(Query, ConnString, cn)
    '    '    RunScalarQuery = rs(0)
    '    '    FreeRS(rs)
    '    'End Function

    '    Private Function FindFirst(ByRef rs As ADODB.Recordset, ByVal FieldName As String, ByVal FieldValue As Object) As Boolean
    '        With rs
    '            If HaveRows(rs) Then
    '                .MoveFirst()
    '                .Find(FieldName & "=" & CLng(FieldValue), , adSearchForward, 0)
    '                FindFirst = Not .EOF
    '            End If
    '        End With
    '    End Function
    '    '#End Region

    '    '#Region Consultas dinamicas y validacion
    '    Public Function GenDefaultFilter(ByVal FieldName As String, ByVal FieldType As SimpleDataType, ByVal Value As String) As String
    '        'Genera el filtro con el operador por defecto segun el tipo de datos del campo
    '        'Devuelve cadena vacia si value no puede ser interpretado como del tipo fieldtype
    '        If StrIsA(Value, FieldType) Then
    '            Dim op As String
    '            Select Case FieldType
    '                Case tdString
    '                    GenDefaultFilter = _
    '                        " " & FieldName & _
    '                        " LIKE " & _
    '                        csp(Value)

    '                Case Else
    '                    GenDefaultFilter = _
    '                        " " & FieldName & _
    '                        " = " _
    '                        & ToSqlFormat(Value, FieldType)
    '            End Select
    '        Else
    '            GenDefaultFilter = ""
    '        End If
    '    End Function

    'Public Function GenSearchFilter( _
    '        ByVal FieldName As String, _
    '        ByVal FieldType As SimpleDataType, _
    '        ByVal Operator As CmpOperators, _
    '        ByVal usrInput As String) As String
    '        'Para usar con combobox campo, cb operador txt value
    '        'ComboCampo -> text =nombre campo, Itemdata = tipo del campo
    '        'Cboperador -> text = > < como entre,etc itemdata = cmpOperator
    '        'Funca con estas busquedas
    '        'si campo es numero, fecha = >< > < entre
    '        'si campo es string = like
    '        'Toma str (string ingresada por el usuario), nombre de campo, operador
    '        'devuelve "" si los datos ingresados son incorrectos o la cadena de filtro
    '        'si esta todo ok

    '        Dim m() As String
    '    If Operator = OP_BETWEEN Then
    '            Split2(usrInput, " ", m)

    '            If UBound(m) = 1 Then 'Se ingresaron 2 valores
    '                If StrIsA(m(0), FieldType) And StrIsA(m(1), FieldType) Then
    '                GenSearchFilter = GenFilter( _
    '                                FieldName, _
    '                                Operator, _
    '                                FieldType, _
    '                                ToSqlFormat(m(0), FieldType), _
    '                                ToSqlFormat(m(1), FieldType))
    '                Else
    '                    GenSearchFilter = ""
    '                    Exit Function
    '                End If
    '            Else
    '                GenSearchFilter = ""
    '                Exit Function
    '            End If
    '    ElseIf Operator = OP_LIKE Then
    '            If StrIsA(usrInput, FieldType) Then
    '            GenSearchFilter = GenFilter(FieldName, Operator, FieldType, ToSqlFormat(usrInput & "%", tdString))
    '            Else
    '                GenSearchFilter = ""
    '                Exit Function
    '            End If
    '        Else
    '            If StrIsA(usrInput, FieldType) Then
    '            GenSearchFilter = GenFilter(FieldName, Operator, FieldType, ToSqlFormat(usrInput, FieldType))
    '            Else
    '                GenSearchFilter = ""
    '                Exit Function
    '            End If
    '        End If
    '    End Function

    'Public Function GenSearchFilter2( _
    '        ByVal FieldName As String, _
    '        ByVal FieldType As ADODB.DataTypeEnum, _
    '        ByVal Operator As CmpOperators, _
    '        ByVal usrInput As String) As String
    '        'Para usar con combobox campo, cb operador txt value
    '        'ComboCampo -> text =nombre campo, Itemdata = tipo del campo
    '        'Cboperador -> text = > < como entre,etc itemdata = cmpOperator
    '        'Funca con estas busquedas
    '        'si campo es numero, fecha = >< > < entre
    '        'si campo es string = like
    '        'Toma str (string ingresada por el usuario), nombre de campo, operador
    '        'devuelve "" si los datos ingresados son incorrectos o la cadena de filtro
    '        'si esta todo ok

    '        Dim m() As String
    '    If Operator = OP_BETWEEN Then
    '            Split2(usrInput, " ", m)

    '            If UBound(m) = 1 Then 'Se ingresaron 2 valores
    '                If StrIsA2(m(0), FieldType) And StrIsA2(m(1), FieldType) Then
    '                GenSearchFilter2 = GenFilter( _
    '                                FieldName, _
    '                                Operator, _
    '                                ToSqlFormat(m(0), FieldType), _
    '                                ToSqlFormat(m(1), FieldType))
    '                Else
    '                    GenSearchFilter2 = ""
    '                    Exit Function
    '                End If
    '            Else
    '                GenSearchFilter2 = ""
    '                Exit Function
    '            End If
    '    ElseIf Operator = OP_LIKE Then
    '            If StrIsA2(usrInput, FieldType) Then
    '            GenSearchFilter2 = GenFilter(FieldName, Operator, FieldType, ToSqlFormat(usrInput & "%", adVarWChar))
    '            Else
    '                GenSearchFilter2 = ""
    '                Exit Function
    '            End If
    '        Else
    '            If StrIsA2(usrInput, FieldType) Then
    '            GenSearchFilter2 = GenFilter(FieldName, Operator, FieldType, ToSqlFormat(usrInput, FieldType))
    '            Else
    '                GenSearchFilter2 = ""
    '                Exit Function
    '            End If
    '        End If
    '    End Function

    'Public Function StrIsA( _
    '                ByVal Value As String, _
    '                ByVal DataType As SimpleDataType, _
    '                Optional rv As Variant) As Boolean
    '        Select Case DataType
    '            Case tdInteger
    '                If Not esEntero(Value) Then
    '                    StrIsA = False
    '                    Exit Function
    '                Else
    '                    If Not IsMissing(rv) Then Value = CLng(Value)
    '                End If
    '            Case tdNumber
    '                If Not IsNumeric(Value) Then
    '                    StrIsA = False
    '                    Exit Function
    '                Else
    '                    Value = CDbl(Value)
    '                End If
    '            Case tdCurrency
    '                If Not IsNumeric(Value) Then
    '                    StrIsA = False
    '                    Exit Function
    '                Else
    '                    If Not IsMissing(rv) Then Value = CCur(Value)
    '                End If
    '            Case tdDate
    '                If Not IsDate(Value) Then
    '                    StrIsA = False
    '                    Exit Function
    '                Else
    '                    If Not IsMissing(rv) Then Value = CDate(Value)
    '                End If
    '            Case tdTime
    '                If Not IsDate(Value) Then
    '                    StrIsA = False
    '                    Exit Function
    '                Else
    '                    If Not IsMissing(rv) Then Value = CDate(Value)
    '                End If
    '            Case tdString
    '        End Select
    '        StrIsA = True
    '    End Function
    'Public Function StrIsA2( _
    '                ByVal Value As String, _
    '                ByVal DataType As ADODB.DataTypeEnum, _
    '                Optional rv As Variant) As Boolean
    '        StrIsA2 = False
    '        If DataType = adInteger Then
    '            If IsNumeric(Value) Then
    '                StrIsA2 = True
    '                If Not IsMissing(rv) Then Value = Val(Value) 'Para access adInteger = Numero (puede tener decimales)
    '            End If
    '        ElseIf DataType = adCurrency Then
    '            If IsNumeric(Value) Then
    '                StrIsA2 = True
    '                If Not IsMissing(rv) Then Value = Val(Value) 'Para access adInteger = Numero (puede tener decimales)
    '            End If
    '        ElseIf DataType = adDate Then
    '            If IsDate(Value) Then
    '                StrIsA2 = True
    '                If Not IsMissing(rv) Then Value = CDate(Value) 'Para access adInteger = Numero (puede tener decimales)
    '            End If
    '        ElseIf DataType = adVarWChar Then
    '            StrIsA2 = True
    '            rv = Value
    '        ElseIf DataType = adVarChar Then
    '            StrIsA2 = True
    '            rv = Value
    '        End If
    '    End Function

    'Public Function ValidateField(ByVal str As String, ByVal t As SimpleDataType, Optional min As Variant, Optional max As Variant)
    '        'Validacion + Rango
    '        'Tipo de dato correcto
    '        Dim Value As Object

    '        'Tipo de dato correcto
    '        If StrIsA(str, t) Then
    '            'TODO:
    '            'CAMBIAR PARA QUE SOPORTE MAX O MIN POR SEPARADO TAMBIEN

    '            'En rango --- que onda la comparacion entre horas

    '            If Not (IsMissing(min) And IsMissing(max)) Then
    '                ValidateField = Between(Value, min, max)
    '            End If
    '        Else
    '            ValidateField = False
    '        End If
    '    End Function

    '    Public Function AllowNull(ByRef Value As Object, ByVal DataType As VbVarType) As Boolean
    '        AllowNull = False
    '        If IsNull(Value) Then
    '            AllowNull = True
    '            Exit Function
    '        Else
    '            If VarType(Value) = DataType Then
    '                AllowNull = True
    '                Exit Function
    '            Else
    '                'TODO: Hay una conversion aceptable
    '            End If
    '        End If
    '    End Function
    '    Public Function C(ByRef str As String) As String
    '        'Encerrar entre comillas simples
    '        C = "'" & str & "'"
    '    End Function

    '    Public Function es(ByVal str As String) As String
    '        'Generar una codena con secuencias de escape
    '        es = Replace(str, "'", "''", 1)
    '    End Function

    '    Public Function cs(ByVal C As Object) As String
    '        'Incluir caracteres de escape en cadenas con comilla simple y las comillas
    '        'simples delimitadoras
    '        If IsNull(C) Then
    '            cs = "NULL"
    '        Else
    '            cs = "'" & Replace(C, "'", "''", 1) & "'"
    '        End If
    '    End Function

    '    Public Function csp(ByVal cad As String) As String
    '        'Incluir caracteres de escape en cadenas con comilla simple y las comillas
    '        'simples delimitadoras
    '        'y el caracter de busqueda % al final
    '        csp = "'" & Replace(cad, "'", "''", 1) & "%'"
    '    End Function

    '    Public Function opToString(ByVal cmpOP As CmpOperators) As String
    '        If cmpOP = OP_EQUAL Then
    '            opToString = "="
    '        ElseIf cmpOP = OP_LIKE Then
    '            opToString = "LIKE"
    '        ElseIf cmpOP = OP_MAJOR Then
    '            opToString = ">"
    '        ElseIf cmpOP = OP_MAJOROREQUAL Then
    '            opToString = ">="
    '        ElseIf cmpOP = OP_MINOROREQUAL Then
    '            opToString = "<="
    '        ElseIf cmpOP = OP_MINOR Then
    '            opToString = "<"
    '        ElseIf cmpOP = OP_BETWEEN Then
    '            opToString = "BETWEEN"
    '        End If
    '    End Function


    '    'Devuelve si una string ingresada por el usuario es un numero entero
    '    'Original
    '    'Public Function esEntero(ByRef str As String) As Boolean
    '    '    esEntero = False
    '    '    If IsNumeric(str) Then
    '    '        If Val(Round(str)) = Val(str) Then
    '    '            esEntero = True
    '    '        End If
    '    '    End If
    '    'End Function

    '    Public Function esEntero(ByVal Value As Object) As Boolean
    '        esEntero = False
    '        If IsNumeric(Value) Then
    '            If Val(Round(Value)) = Val(Value) Then
    '                esEntero = True
    '            End If
    '        End If
    '    End Function

    'Public Function GenFilter( _
    '            ByVal FieldName As String, _
    '            ByVal Operator As CmpOperators, _
    '            ByVal DataType As ADODB.DataTypeEnum, _
    '            ByVal Value1 As String, _
    '            Optional Value2 As Variant) As String
    '        'Para generar los pares en las clausulas Where,
    '        'Values deben ser strings en el formato sql adecuado
    '        'estar en el formato sql adecuado
    '        '(No se puede automatizar para poder incluir caracteres de busqueda, termina siendo peor)

    '    If Operator = OP_BETWEEN Then
    '            If IsEmpty(Value2) Then
    '                Err.Raise("KLKLK")
    '            Else
    '            GenFilter = _
    '                    FieldName & " " & _
    '                    opToString(Operator) & " " & Value1 & _
    '                    " AND " & Value2
    '            End If
    '        Else
    '        GenFilter = FieldName & " " & opToString(Operator) & " " & Value1
    '        End If
    '    End Function

    '    Public Function GetOpStr(ByVal op As CmpOperators) As String
    '        If op = OP_BETWEEN Then
    '            GetOpStr = "BETWEEN"
    '        ElseIf op = OP_EQUAL Then
    '            GetOpStr = "="
    '        ElseIf op = OP_LIKE Then
    '            GetOpStr = "LIKE"
    '        ElseIf op = OP_MAJOR Then
    '            GetOpStr = ">"
    '        ElseIf op = OP_MINOR Then
    '            GetOpStr = "<"
    '        End If
    '    End Function
    '    'Para escribir consultas
    'Public Function MergeQuery( _
    '            ByVal FieldList As String, _
    '            ByVal FROM As String, _
    '            Optional WHERE As Variant, _
    '            Optional ORDERBY As Variant, _
    '            Optional TOP As Variant) As String
    '        Dim Query As String
    '        Query = "SELECT "
    '        If Not IsMissing(TOP) Then
    '            If TOP <> -1 Then Query = Query & " TOP " & TOP
    '        End If
    '        Query = Query & " * FROM " & FROM & " "
    '        If Not IsMissing(WHERE) Then
    '            If WHERE <> "" Then Query = Query & " WHERE " & WHERE
    '        End If
    '        If Not IsMissing(ORDERBY) Then Query = Query & " ORDER BY " & ORDERBY
    '        MergeQuery = Query
    '    End Function

    '    Public Function ToSqlFormat2(ByVal Value As Object, ByVal DataType As SimpleDataType) As String
    '    End Function

    'Public Function MergeSELECTQuery( _
    '                    ByVal FROM As String, _
    '                    Optional FieldList As Variant, _
    '                    Optional TOP As Variant, _
    '                    Optional WHERE As Variant, _
    '                    Optional ORDERBY As Variant) As String

    '        Dim Query As String

    '        Query = "SELECT "
    '        If Not IsMissing(TOP) Then
    '            If TOP <> -1 Then Query = Query & "TOP " & TOP & " "
    '        End If
    '        If IsMissing(FieldList) Then
    '            Query = Query & "* FROM " & FROM & " "
    '        Else
    '            If FieldList = "" Then
    '                Query = Query & "* FROM " & FROM & " "
    '            Else
    '                Query = Query & FieldList & " FROM " & FROM & " "
    '            End If
    '        End If
    '        If Not IsMissing(WHERE) Then
    '            If WHERE <> "" Then Query = Query & "WHERE " & WHERE & " "
    '        End If
    '        If Not IsMissing(ORDERBY) Then
    '            If ORDERBY <> "" Then Query = Query & "ORDER BY " & ORDERBY
    '        End If
    '        MergeSELECTQuery = Query
    '    End Function

    '    'Devuelve List como una cadena separada por comas
    '    'Para que no sea tanto bardo la concatenacion
    '    Public Function ToList(ByVal ParamArray List() As Object) As String
    '        Dim i As Long, rv As String
    '        For i = LBound(List) To UBound(List)
    '            rv = rv & ", " & List(i)
    '        Next i
    '    End Function

    '    Public Function ToSqlF(ByVal Value As Object) As String
    '        'Variant debe ser un tipo basico vb
    '        'Devuelve la conversion a formato sql
    '        Select Case VarType(Value)
    '            Case vbNull
    '                ToSqlF = "NULL"
    '            Case vbInteger, vbLong, vbSingle, vbDouble, vbCurrency, vbDecimal, vbByte
    '                ToSqlF = Value
    '            Case vbDate
    '                ToSqlF = cs(Format(Value, FT_DB_DATE))
    '            Case vbString
    '                ToSqlF = cs(Value)
    '            Case vbBoolean
    '                'ToSqlF = IIf(Value = True, "TRUE", "FALSE") 'para campos bit
    '                'ToSqlF = IIf(Value = True, "'TRUE'", "'FALSE'") 'para campos bit
    '                ToSqlF = IIf(Value = True, 1, 0)   'para campos no-bit
    '            Case vbEmpty
    '                ToSqlF = "NULL"
    '            Case vbObjectError, vbError, vbDataObject, vbUserDefinedType, vbArray
    '                Err.Raise(vbObjectError + 512 + 100, "ToSqlF", "Bag arg")
    '            Case vbVariant 'Variant (utilizada solamente conmatrices de variantes)
    '                Err.Raise(vbObjectError + 512 + 100, "ToSqlF", "Bag arg")
    '        End Select
    '    End Function




    '    Public Function ToSqlFormat(ByVal Value As String, ByVal DataType As SimpleDataType) As String
    '        'Recibe entrada del usuario como string ya validada como que es
    '        'posible de convertir a datatype
    '        'Devuelve la cadena en formato DB
    '        Select Case DataType
    '            Case tdInteger, tdCurrency, tdNumber
    '                ToSqlFormat = CStr(Value)
    '            Case tdString
    '                ToSqlFormat = "'" & Replace(Value, "'", "''") & "'"
    '            Case tdDate
    '                ToSqlFormat = C(Format(Value, FT_DB_DATE))
    '            Case Else
    '                Err.Raise(vbError + 512, , "FALTA EL TIPO EN EL SELECT")
    '        End Select
    '    End Function
    '    '#End Region

    '    '#Region VArios

    '    Public Function iisNull(ByVal Value As Object, ByVal rv As Object) As Object
    '        'Igual que el isNnull de sql
    '        If IsNull(Value) Then
    '            iisNull = rv
    '        Else
    '            iisNull = Value
    '        End If
    '    End Function

    '    Public Function Between(ByVal Value As Object, ByVal minValue As Object, ByVal maxValue As Object) As Boolean
    '        Between = (Value >= minValue) And (Value <= maxValue)
    '    End Function



    'Public Sub MostrarMensajesError(er As ErrObject, Optional Titulo As Variant, Optional texto As Variant)
    '        If IsMissing(Titulo) Then
    '            Titulo = "SGPD - Error " & er.Number
    '            Select Case er.Number
    '                'Errores ADO
    '                Case -2147467259
    '                    texto = "No se pudo conectar a la base de datos. Verifique 'Bus.ini'"
    '                Case -2147217864
    '                    texto = "El registro ha sido modificado por otro usuario." & Chr(13) & _
    '                            "No se pueden guardar los nuevos valores."
    '                Case -2147217873
    '                    texto = "No se puede guardar el registro, la inserción genera duplicados."
    '                Case 10020
    '                    texto = "No se puede borrar el registro, esta siendo utilizado en otras tablas."
    '                Case 10010
    '                    texto = "El registro ya fue eliminado."
    '                    'Errores del modulo producto
    '                Case 1000
    '                    texto = "El nombre no puede estar vacío"
    '                Case 1001
    '                    texto = "Las unidades no pueden ser cero"
    '                Case 1002
    '                    texto = "El precio de referencia no puede ser cero"
    '                Case 1003
    '                    texto = "Debe seleccionar una categoria"
    '                Case 1200
    '                    'Errores de promocion
    '                    texto = "Debe asignar una fecha de inicio"
    '                Case 1201
    '                    texto = "La fecha de inicio es mayor que la fecha fin"
    '                Case 6000
    '                    texto = "El nombre de la provincia no puede estar vacío."
    '                    'Errores Varios
    '                Case 10000
    '                    texto = "No se encuentra el registro"
    '                Case 10001
    '                    texto = "No se puede establecer la conexión"
    '                    'Error Desconocido
    '                Case Else
    '                    Titulo = "Error " & Err.Number
    '                    texto = Err.Description
    '            End Select
    '            'MsgBox Linea1 & Chr(13) & Linea2, vbCritical, TituloVentanaError & " " & Numero
    '            MsgBox(texto, vbCritical, Titulo)
    '        Else
    '        End If
    '    End Sub

    '    Public Function MustRefreshCtls(ByRef LastTimeLoaded As Object)
    '        If IsNull(Time) Then
    '            LastTimeLoaded = Now
    '            MustRefreshCtls = True
    '        Else
    '            If DateDiff("m", LastTimeLoaded, Now) > 60 Then
    '                LastTimeLoaded = Now
    '                MustRefreshCtls = True
    '            End If
    '        End If
    '    End Function

    '    Public Function ShowLastError(ByRef e As ErrObject) As Boolean
    '        'Funcion para la capa de presentacion devuelve false si hay que
    '        'recargar el form, se debe releer el objeto de la base para poder hacer algo
    '        'true si se puede reintentar el guardado

    '        Dim texto As String
    '        texto = e.Description
    '        ShowLastError = True
    '        Select Case e.Number
    '            Case vbObjectError + 512 + 101, vbObjectError + 512 + 100 'No recuperables
    '                ShowLastError = False
    '                MsgBox(Err.Number & vbCrLf & e.Source & vbCrLf & e.Description & vbCrLf & texto & e.HelpFile & e.HelpContext, vbCritical + vbOKOnly, App.Title)
    '            Case vbObjectError + 512 + 102 'No hay stock
    '                ShowLastError = True
    '                MsgBox("No hay Stock suficiente", vbExclamation + vbOKOnly, App.Title)
    '            Case -2147217873
    '                ShowLastError = True
    '                MsgBox("No se puede borrar el registro, esta siendo utilizado en otras tablas.", vbExclamation + vbOKOnly, App.Title)
    '            Case Else
    '                ShowLastError = True
    '                MsgBox(Err.Number & vbCrLf & e.Source & vbCrLf & e.Description & vbCrLf & texto & e.HelpFile & e.HelpContext, vbCritical + vbOKOnly, App.Title)
    '        End Select

    '    End Function



    '    Private Sub CoordProximaCelda(ByVal FirstEditableCol As Long, ByVal Rows As Long, ByVal Cols As Long, ByVal CurrentRow As Long, ByVal CurrentCol As Long, ByRef NextRow As Long, ByRef Nextcol As Long)
    '        If CurrentCol + 1 > Cols Then
    '            If CurrentRow + 1 > Rows Then
    '                'Se acabo la grilla
    '                NextRow = Rows
    '                Nextcol = Cols
    '            Else
    '                NextRow = CurrentRow + 1
    '                Nextcol = FirstEditableCol
    '            End If
    '        Else
    '            Nextcol = CurrentCol + 1
    '            NextRow = CurrentRow
    '        End If
    '    End Sub
    '    '#End Region

    '    '#Region INIs

    '    Public Sub GuardaIni(ByVal lpFileName As String, ByVal lpAppName As String, ByVal lpKeyName As String, ByVal lpString As String)
    '        'Guarda los datos de configuración
    '        'Los parámetros son los mismos que en LeerIni
    '        'Siendo lpString el valor a guardar
    '        '
    '        Dim LTmp As Long

    '        LTmp = WritePrivateProfileString(lpAppName, lpKeyName, lpString, lpFileName)
    '    End Sub



    'Public Function LeeIni(lpFileName As String, lpAppName As String, lpKeyName As String, Optional vDefault) As String
    '        'Los parámetros son:
    '        'lpFileName:    La Aplicación (fichero INI)
    '        'lpAppName:     La sección que suele estar entrre corchetes
    '        'lpKeyName:     Clave
    '        'vDefault:      Valor opcional que devolverá
    '        '               si no se encuentra la clave.
    '        '
    '        Dim lpString As String
    '        Dim LTmp As Long
    '        Dim sRetVal As String

    '        'Si no se especifica el valor por defecto,
    '        'asignar incialmente una cadena vacía
    '        If IsMissing(vDefault) Then
    '            lpString = ""
    '        Else
    '            lpString = vDefault
    '        End If

    '        sRetVal = String$(255, 0)

    '        LTmp = GetPrivateProfileString(lpAppName, lpKeyName, lpString, sRetVal, Len(sRetVal), lpFileName)
    '        If LTmp = 0 Then
    '            LeeIni = lpString
    '        Else
    '            LeeIni = Left(sRetVal, LTmp)
    '        End If
    '    End Function
    '    '#End Region


    '    Public Function ExistsPrinter(ByVal PrinterDeviceName As String) As Boolean
    '        ExistsPrinter = False
    '        Dim x As Printer, f As Boolean
    '        f = False
    '        For Each x In Printers
    '            If x.DeviceName = PrinterDeviceName Then
    '                f = True
    '                Exit For
    '            End If
    '        Next
    '        ExistsPrinter = f
    '    End Function

    '    Public Function SetDefaultPrinter(ByVal PrinterDeviceName As String) As Boolean
    '        Dim x As Printer, f As Boolean
    '        f = False
    '        For Each x In Printers
    '            If x.DeviceName = PrinterDeviceName Then
    '                f = True
    '                Printer = x
    '                Exit For
    '            End If
    '        Next
    '        SetDefaultPrinter = False
    '    End Function




    '    '******************************************************
    '    'OPERADORES BINARIOS (http://www.romanpress.com/Articles/Bitwise_R/Bitwise.htm)

    '    'Modo de uso:
    '    'Sub MaskExample()
    '    '
    '    'Dim flag As Integer
    '    'Dim mask As Integer
    '    'Dim result As Integer
    '    '
    '    'flag = GetInteger("1101 1011")
    '    'mask = GetInteger("0110 1110")
    '    '
    '    'result = mask And flag
    '    '
    '    'Debug.Print "1101 1011 (flag)"
    '    'Debug.Print "0110 1110 (mask)"
    '    '
    '    'Debug.Print GetBinary(result) & " (result)"
    '    '
    '    'End Sub



    '    Function GetInteger(ByVal sBinary As String) As Integer

    '        ' Returns the integer that corresponds to a binary string of length 8

    '        Dim iRet As Integer, i As Integer, s As String

    '        ' Remove any spaces
    '        s = Replace(sBinary, " ", "")

    '        iRet = 0
    '        For i = 0 To Len(s) - 1
    '            iRet = iRet + 2 ^ i * CInt(Mid$(s, Len(s) - i, 1))
    '        Next

    '        GetInteger = iRet

    '    End Function

    '    Function GetBinary(ByVal iInput As Integer) As String

    '        ' Returns the 8-bit binary representation
    '        ' of an integer iInput where 0 <= iInput <= 255

    '        Dim s As String, i As Integer

    '        If iInput < 0 Or iInput > 255 Then
    '            GetBinary = ""
    '            Exit Function
    '        End If

    '        s = ""
    '        For i = 1 To 8
    '            s = CStr(iInput Mod 2) & s
    '            iInput = iInput \ 2
    '            If i = 4 Then s = " " & s
    '        Next

    '        GetBinary = s

    '    End Function


    '    Sub SetBit(ByVal rv As Long, ByVal bitmask As Long, ByVal Value As Boolean)
    '        'BIT = la mascara con el bit a setear
    '        If Value Then
    '            rv = rv Or bitmask
    '        Else
    '            rv = rv And (Not bitmask)
    '        End If
    '    End Sub


    '    Function AutoFilter(ByVal FieldName As String, ByVal FieldDataType As SimpleDataType, ByVal strUsrInput As String) As String
    '        Dim SEPARATOR As String
    '        SEPARATOR = "\"

    '        Dim Valores() As String

    '        Split2(strUsrInput, SEPARATOR, Valores)

    '        If UBound(Valores) - LBound(Valores) + 1 = 2 Then 'segun cant de valores ingresados
    '            'Se ingresaron dos valores, filtro BETWEEN
    '            If StrIsA(Valores(0), FieldDataType) And StrIsA(Valores(1), FieldDataType) Then
    '                AutoFilter = FieldName & " BETWEEN " & ToSqlFormat(Valores(0), FieldDataType) & " AND " & ToSqlFormat(Valores(1), FieldDataType)
    '            Else
    '                AutoFilter = vbNullString
    '            End If
    '        Else
    '            'Se ingresaro un valor, filtro por tipo de datos
    '            Select Case FieldDataType
    '                Case tdString 'Para string
    '                    If StrIsA(strUsrInput, FieldDataType) Then
    '                        AutoFilter = FieldName & " LIKE '" & es(strUsrInput) & "%'" 'es=incluir caracteres de escape
    '                    Else
    '                        AutoFilter = vbNullString
    '                    End If
    '                Case Else 'Para cualquier otro tipo dato usar "="
    '                    If StrIsA(strUsrInput, FieldDataType) Then
    '                        AutoFilter = FieldName & " = " & ToSqlFormat(strUsrInput, FieldDataType)
    '                    Else
    '                        AutoFilter = vbNullString
    '                    End If
    '            End Select
    '        End If
    '    End Function

    '    Sub UnloadAllForms()
    '        On Error GoTo rErrores

    '        Dim i As Form
    '        For Each i In Forms
    '            Unload(i)
    '        Next

    '        Exit Sub
    'rErrores:
    '        ShowLastError(Err)
    '    End Sub

End Class
