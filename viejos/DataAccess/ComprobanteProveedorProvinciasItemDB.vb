Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ComprobanteProveedorProvinciasItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedorProvinciasItem
            Dim myComprobanteProveedorProvinciasItem As ComprobanteProveedorProvinciasItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetComprobanteProveedors_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleComprobanteProveedor", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myComprobanteProveedorProvinciasItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myComprobanteProveedorProvinciasItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdComprobanteProveedor As Integer) As ComprobanteProveedorPrvItemList
            Dim tempList As ComprobanteProveedorPrvItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetComprobantesProveedoresPrv_TXComp.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdComprobanteProveedor", IdComprobanteProveedor)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ComprobanteProveedorPrvItemList
                        While myReader.Read
                            tempList.Add(FillDataRecord(myReader))
                        End While
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return tempList
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myComprobanteProveedorItem As ComprobanteProveedorProvinciasItem) As Integer
            Dim result As Integer = 0
            With myComprobanteProveedorItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetComprobanteProveedorsProvincias_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleComprobanteProveedorProvincias", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetComprobanteProveedorsProvincias_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleComprobanteProveedorProvincias", .Id)
                        End If


                        NETtoSQL(myCommand, "@IdComprobanteProveedor", .IdComprobanteProveedor)
                        NETtoSQL(myCommand, "@IdProvinciaDestino", .IdProvinciaDestino)
                        NETtoSQL(myCommand, "@Porcentaje", .Porcentaje)
                        NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)


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
                Else
                    If Not myComprobanteProveedorItem.Nuevo Then Delete(SC, myComprobanteProveedorItem.Id)
                End If
            End With
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetComprobanteProveedors_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleComprobanteProveedor", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ComprobanteProveedorProvinciasItem
            Dim myItem As ComprobanteProveedorProvinciasItem = New ComprobanteProveedorProvinciasItem
            myItem.Id = myDataRecord.GetInt32(myDataRecord.GetOrdinal("IdDetalleComprobanteProveedor"))

            'Fijate que no estoy trayendo el id del padre. Esto es deliberado? Es conveniente?

            With myItem
                SQLtoNET(myDataRecord, "@IdRecibo", .Id)
                'SQLtoNET(myDataRecord, "@NumeroRecibo", .NumeroRecibo)

            End With
            Return myItem
        End Function
    End Class
End Namespace