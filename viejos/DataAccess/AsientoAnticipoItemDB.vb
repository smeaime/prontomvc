Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class AsientoAnticipoItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As AsientoAnticiposItem
            Dim myAsientoItem As AsientoAnticiposItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.AnticiposAlPersonal_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleAsiento", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myAsientoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myAsientoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdAsiento As Integer) As AsientoAnticiposItemList
            Dim tempList As AsientoAnticiposItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetNotasDebito_TX_PorIdCabecera    trae los nombres como en la base
                'DetNotasDebito_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand("wAnticiposAlPersonal_TX_Asiento", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdAsiento", IdAsiento)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New AsientoAnticiposItemList
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

        Public Shared Function Save(ByVal SC As String, ByVal myAsientoItem As AsientoAnticiposItem) As Integer
            Dim result As Integer = 0

            With myAsientoItem
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



                        'NETtoSQL(myCommand, "@IdAsiento", .IdAsiento)
                        'NETtoSQL(myCommand, "@IdConcepto", .IdConcepto)
                        'NETtoSQL(myCommand, "@Importe", .ImporteTotalItem)
                        'NETtoSQL(myCommand, "@Gravado", .Gravado)
                        'NETtoSQL(myCommand, "@IdDiferenciaCambio", .IdDiferenciaCambio)
                        'NETtoSQL(myCommand, "@IvaNoDiscriminado", .IvaNoDiscriminado)
                        'NETtoSQL(myCommand, "@IdCuentaBancaria", .IdCuentaBancaria)
                        'NETtoSQL(myCommand, "@IdCaja", .IdCaja)

                        NETtoSQL(myCommand, "@IdOrdenPago", .IdOrdenPago)
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
                    If Not myAsientoItem.Nuevo Then Delete(SC, myAsientoItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("AnticiposAlPersonal_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdAnticipoAlPersonal", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As AsientoAnticiposItem
            Dim myAsientoItem As AsientoAnticiposItem = New AsientoAnticiposItem
            With myAsientoItem
                'SQLtoNET(.Id, "IdDetalleAsiento", myDataRecord)
                'SQLtoNET(.IdAsiento, "IdAsiento", myDataRecord)
                'SQLtoNET(.IdConcepto, "IdConcepto", myDataRecord)
                'SQLtoNET(.ImporteTotalItem, "Importe", myDataRecord)
                'SQLtoNET(.Gravado, "Gravado", myDataRecord)
                'SQLtoNET(.IdDiferenciaCambio, "IdDiferenciaCambio", myDataRecord)
                'SQLtoNET(.IvaNoDiscriminado, "IvaNoDiscriminado", myDataRecord)
                'SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                'SQLtoNET(.IdCaja, "IdCaja", myDataRecord)



                SQLtoNET(myDataRecord, "@IdAnticipoAlPersonal", .Id)
                'SQLtoNET(myDataRecord, "@Legajo", .LegajoDelIdEmpleado)
                SQLtoNET(myDataRecord, "@IdEmpleado", .IdEmpleado)
                SQLtoNET(myDataRecord, "@Importe", .Importe)
                'SQLtoNET(myDataRecord, "@IdAsiento", .IdAsiento)
                SQLtoNET(myDataRecord, "@Cuotas", .CantidadCuotas)
                SQLtoNET(myDataRecord, "@Detalle", .Detalle)
                'SQLtoNET(myDataRecord, "@IdRecibo", .IdRecibo)






                Return myAsientoItem
            End With
        End Function

    End Class
End Namespace