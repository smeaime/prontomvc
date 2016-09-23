Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class ReciboAnticiposAlPersonalItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ReciboAnticiposAlPersonalItem
            Dim myReciboItem As ReciboAnticiposAlPersonalItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.AnticiposAlPersonal_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleRecibo", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myReciboItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myReciboItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdRecibo As Integer) As ReciboAnticiposAlPersonalItemList
            Dim tempList As ReciboAnticiposAlPersonalItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetNotasDebito_TX_PorIdCabecera    trae los nombres como en la base
                'DetNotasDebito_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.AnticiposAlPersonal_TX_OPago.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdRecibo", IdRecibo)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New ReciboAnticiposAlPersonalItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myReciboItem As ReciboAnticiposAlPersonalItem) As Integer
            Dim result As Integer = 0

            With myReciboItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand(enumSPs.AnticiposAlPersonal_A.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdAnticipoAlPersonal", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand(enumSPs.AnticiposAlPersonal_M.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdAnticipoAlPersonal", .Id)
                        End If



                        'NETtoSQL(myCommand, "@IdRecibo", .IdRecibo)
                        'NETtoSQL(myCommand, "@IdConcepto", .IdConcepto)
                        'NETtoSQL(myCommand, "@Importe", .ImporteTotalItem)
                        'NETtoSQL(myCommand, "@Gravado", .Gravado)
                        'NETtoSQL(myCommand, "@IdDiferenciaCambio", .IdDiferenciaCambio)
                        'NETtoSQL(myCommand, "@IvaNoDiscriminado", .IvaNoDiscriminado)
                        'NETtoSQL(myCommand, "@IdCuentaBancaria", .IdCuentaBancaria)
                        'NETtoSQL(myCommand, "@IdCaja", .IdCaja)

                        NETtoSQL(myCommand, "@IdRecibo", .IdRecibo)
                        NETtoSQL(myCommand, "@IdEmpleado", .IdEmpleado)
                        NETtoSQL(myCommand, "@Importe", .Importe)
                        NETtoSQL(myCommand, "@IdAsiento", .IdAsiento)
                        NETtoSQL(myCommand, "@CantidadCuotas", .CantidadCuotas)
                        NETtoSQL(myCommand, "@Detalle", .Detalle)
                        NETtoSQL(myCommand, "@IdRecibo", .IdRecibo)





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
                    If Not myReciboItem.Nuevo Then Delete(SC, myReciboItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("AnticiposAlPersonal_BorrarPorIdRecibo", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleRecibo", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As ReciboAnticiposAlPersonalItem
            Dim myReciboItem As ReciboAnticiposAlPersonalItem = New ReciboAnticiposAlPersonalItem
            With myReciboItem
                'SQLtoNET(.Id, "IdDetalleRecibo", myDataRecord)
                'SQLtoNET(.IdRecibo, "IdRecibo", myDataRecord)
                'SQLtoNET(.IdConcepto, "IdConcepto", myDataRecord)
                'SQLtoNET(.ImporteTotalItem, "Importe", myDataRecord)
                'SQLtoNET(.Gravado, "Gravado", myDataRecord)
                'SQLtoNET(.IdDiferenciaCambio, "IdDiferenciaCambio", myDataRecord)
                'SQLtoNET(.IvaNoDiscriminado, "IvaNoDiscriminado", myDataRecord)
                'SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                'SQLtoNET(.IdCaja, "IdCaja", myDataRecord)



                SQLtoNET(myDataRecord, "@IdAnticipoAlPersonal", .Id)
                SQLtoNET(myDataRecord, "@IdRecibo", .IdRecibo)
                SQLtoNET(myDataRecord, "@IdEmpleado", .IdEmpleado)
                SQLtoNET(myDataRecord, "@Importe", .Importe)
                SQLtoNET(myDataRecord, "@IdAsiento", .IdAsiento)
                SQLtoNET(myDataRecord, "@CantidadCuotas", .CantidadCuotas)
                SQLtoNET(myDataRecord, "@Detalle", .Detalle)
                SQLtoNET(myDataRecord, "@IdRecibo", .IdRecibo)






                Return myReciboItem
            End With
        End Function

    End Class
End Namespace