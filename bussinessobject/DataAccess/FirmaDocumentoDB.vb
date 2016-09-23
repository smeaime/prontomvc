Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO

Namespace Pronto.ERP.Dal

    Public Class FirmaDocumentoDB

        Public Shared Function GetDocumentosAFirmar(ByVal SC As String, ByVal Usuario As String) As DataSet
            Dim ds As New DataSet()
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wFirmasDocumentos_DocumentosAFirmar", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.CommandTimeout = 1000
                myCommand.Parameters.AddWithValue("@Usuario", Usuario)
                myConnection.Open()
                Dim DA As New SqlDataAdapter(myCommand)
                DA.Fill(ds)
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return ds
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myFirmaDocumento As FirmaDocumento) As Integer
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wFirmasDocumentos_A", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                If myFirmaDocumento.Id = -1 Then
                    myCommand.Parameters.AddWithValue("@IdAutorizacionPorComprobante", DBNull.Value)
                Else
                    myCommand.Parameters.AddWithValue("@IdAutorizacionPorComprobante", myFirmaDocumento.Id)
                End If
                myCommand.Parameters.AddWithValue("@IdFormulario", myFirmaDocumento.IdFormulario)
                myCommand.Parameters.AddWithValue("@IdComprobante", myFirmaDocumento.IdComprobante)
                myCommand.Parameters.AddWithValue("@OrdenAutorizacion", myFirmaDocumento.OrdenAutorizacion)
                myCommand.Parameters.AddWithValue("@IdAutorizo", myFirmaDocumento.IdAutorizo)
                myCommand.Parameters.AddWithValue("@FechaAutorizacion", myFirmaDocumento.FechaAutorizacion)
                Dim returnValue As DbParameter
                returnValue = myCommand.CreateParameter
                returnValue.Direction = ParameterDirection.ReturnValue
                myCommand.Parameters.Add(returnValue)
                myConnection.Open()
                myCommand.ExecuteNonQuery()
                result = Convert.ToInt32(returnValue.Value)
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function

        Public Shared Function SaveBlock(ByVal SC As String, ByVal BDs As String, ByVal IdFormularios As String, _
                                         ByVal IdComprobantes As String, ByVal NumerosOrden As String, _
                                         ByVal Autorizo As String) As Integer
            Dim result As Integer = 0
            Dim BD As Array, IdFormulario As Array, IdComprobante As Array, NumeroOrden As Array
            Dim i As Integer
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wFirmasDocumentos_PorBD", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.Add("@BD")
                myCommand.Parameters.Add("@IdFormulario")
                myCommand.Parameters.Add("@IdComprobante")
                myCommand.Parameters.Add("@OrdenAutorizacion")
                myCommand.Parameters.Add("@Usuario")
                myConnection.Open()

                BD = Split(BDs, ",")
                IdFormulario = Split(IdFormularios, ",")
                IdComprobante = Split(IdComprobantes, ",")
                NumeroOrden = Split(NumerosOrden, ",")
                For i = 0 To UBound(BD)
                    If Len(BD(i)) > 0 Then
                        myCommand.Parameters.Item("@BD").Value = BD(i)
                        myCommand.Parameters.Item("@IdFormulario").Value = IdFormulario(i)
                        myCommand.Parameters.Item("@IdComprobante").Value = IdComprobante(i)
                        myCommand.Parameters.Item("@OrdenAutorizacion").Value = NumeroOrden(i)
                        myCommand.Parameters.Item("@IdFormulario").Value = IdFormulario(i)
                        myCommand.Parameters.Item("@Usuario").Value = Autorizo
                        myCommand.ExecuteNonQuery()
                    End If
                Next
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            ' Using
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("FirmasDocumentos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdAutorizacionPorComprobante", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As FirmaDocumento
            Dim myFirmaDocumento As FirmaDocumento = New FirmaDocumento
            myFirmaDocumento.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizacionPorComprobante"))
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("BD")) Then
                myFirmaDocumento.BD = myDataRecord.GetString(myDataRecord.GetOrdinal("BD"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdFormulario")) Then
                myFirmaDocumento.IdFormulario = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdFormulario"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdComprobante")) Then
                myFirmaDocumento.IdComprobante = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdComprobante"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("OrdenAutorizacion")) Then
                myFirmaDocumento.OrdenAutorizacion = myDataRecord.GetInt32(myDataRecord.GetOrdinal("OrdenAutorizacion"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("IdAutorizo")) Then
                myFirmaDocumento.IdAutorizo = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdAutorizo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("Autorizo")) Then
                myFirmaDocumento.Autorizo = myDataRecord.GetString(myDataRecord.GetOrdinal("Autorizo"))
            End If
            If Not myDataRecord.IsDBNull(myDataRecord.GetOrdinal("FechaAutorizacion")) Then
                myFirmaDocumento.FechaAutorizacion = myDataRecord.GetDateTime(myDataRecord.GetOrdinal("FechaAutorizacion"))
            End If
            Return myFirmaDocumento
        End Function

    End Class

End Namespace