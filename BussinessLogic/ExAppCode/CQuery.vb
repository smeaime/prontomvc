Imports Microsoft.VisualBasic

Public Class CQuery
    '    Public TOP As Long
    '    Public FieldList As String
    '    Public FROM As String
    '    Public WHERE As String
    '    Public ORDERBY As String
    '    Public TABLE As String

    '    Private m_InsFields As String
    '    Private m_InsValues As String
    '    Private m_UpdateSets As String
    '    Private m_Batch As String

    '    Private B As New CStd


    '    Public Sub AddToBatch(ByVal str As String)
    '        'Add to batch hace el clear automaticamente
    '        m_Batch = m_Batch & str & vbCrLf
    '        Clear()
    '    End Sub
    '    Public Function IsBatchEmpty() As Boolean
    '        'Mejor se puede contar la veces que se ejecuta  addtobatch
    '        If m_Batch = "" Then
    '            IsBatchEmpty = True
    '        Else
    '            IsBatchEmpty = False
    '        End If
    '    End Function
    '    Public Sub ClearBatch()
    '        m_Batch = ""
    '    End Sub
    '    Private Sub Class_Initialize()
    '        Clear()
    '    End Sub

    'Public Property Get SelectQuery()
    '    Dim Query As String

    '    Query = "SELECT "
    '    If TOP <> -1 Then Query = Query & " TOP " & TOP & " "
    '    Query = Query & " " & FieldList & " FROM " & FROM
    '    If WHERE <> "" Then Query = Query & " WHERE " & WHERE & " "
    '    If ORDERBY <> "" Then Query = Query & " ORDER BY " & ORDERBY

    '    SelectQuery = Query
    'End Property

    'Public Property Get UpdateQuery()
    '    Dim rv As String
    '    rv = "UPDATE " & TABLE & " SET " & m_UpdateSets
    '    If WHERE <> "" Then
    '        rv = rv & " WHERE " & WHERE
    '    End If
    '    UpdateQuery = rv
    'End Property

    'Public Property Get InsertQuery()
    '    InsertQuery = "INSERT INTO " & TABLE & " (" & m_InsFields & ") VALUES (" & m_InsValues & ")"
    '    End Property

    'Public Property Let SetF(ByVal Field As String, ByVal Value As Variant)
    '    If m_InsFields = "" Then
    '        m_InsFields = Field
    '    Else
    '        m_InsFields = m_InsFields & ", " & Field
    '    End If
    '    If m_InsValues = "" Then
    '        m_InsValues = B.ToSqlF(Value)
    '    Else
    '        m_InsValues = m_InsValues & ", " & B.ToSqlF(Value)
    '    End If
    '    '//
    '    If m_UpdateSets = "" Then
    '        m_UpdateSets = Field & "=" & B.ToSqlF(Value)
    '    Else
    '        m_UpdateSets = m_UpdateSets & ", " & Field & "=" & B.ToSqlF(Value)
    '    End If
    'End Property

    'Public Property Let SetL(ByVal Field As String, ByVal Value As String)
    '    If m_InsFields = "" Then
    '        m_InsFields = Field
    '    Else
    '        m_InsFields = m_InsFields & ", " & Field
    '    End If
    '    If m_InsValues = "" Then
    '        m_InsValues = Value
    '    Else
    '        m_InsValues = m_InsValues & ", " & Value
    '    End If
    '    '//
    '    If m_UpdateSets = "" Then
    '        m_UpdateSets = Field & "=" & Value
    '    Else
    '        m_UpdateSets = m_UpdateSets & ", " & Field & "=" & Value
    '    End If
    'End Property

    '    Public Sub Clear()
    '        TOP = -1
    '        FieldList = ""
    '        FROM = ""
    '        WHERE = ""
    '        ORDERBY = ""
    '        TABLE = ""
    '        m_InsFields = ""
    '        m_InsValues = ""
    '        m_UpdateSets = ""
    '    End Sub

    '    Public Sub ClearAll()
    '        Clear()
    '        ClearBatch()
    '    End Sub

    'Public Property Get Batch() As String
    '    Batch = m_Batch
    '    End Property

    'Public Property Let Batch(ByVal vNewValue As String)
    '    m_Batch = vNewValue
    '    End Property

    'Public Property Get DeleteQuery() As String
    '    DeleteQuery = "DELETE FROM " & TABLE & IIf(WHERE = "", "", " WHERE " & WHERE)
    '    End Property

End Class
