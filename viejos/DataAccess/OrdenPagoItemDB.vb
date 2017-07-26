Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class OrdenPagoItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenPagoItem
            Dim myOrdenPagoItem As OrdenPagoItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPago_T, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleOrdenPago", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myOrdenPagoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myOrdenPagoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdOrdenPago As Integer) As OrdenPagoItemList
            Dim tempList As OrdenPagoItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetOrdenPagos_TX_PorIdCabecera    trae los nombres como en la base (como el sp usado en GetItem. GetList usa el mismo FillDataRecord, así que tendrían que tener las mismas columnas....)
                'DetOrdenPagos_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPago_TX_PorIdOrdenPago.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", IdOrdenPago)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New OrdenPagoItemList
                    If myReader.HasRows Then
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

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenPagoItem As OrdenPagoItem) As Integer
            Dim result As Integer = 0

            With myOrdenPagoItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand(enumSPs.DetOrdenesPago_A.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleOrdenPago", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand(enumSPs.DetOrdenesPago_M.ToString, myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleOrdenPago", .Id)
                        End If





                        NETtoSQL(myCommand, "@IdOrdenPago", .IdOrdenPago)
                        NETtoSQL(myCommand, "@IdImputacion", .IdImputacion)
                        NETtoSQL(myCommand, "@Importe", .Importe)

                        NETtoSQL(myCommand, "@ImporteRetencionIVA", .ImporteRetencionIVA)
                        NETtoSQL(myCommand, "@ImporteRetencionIngresosBrutos", .ImporteRetencionIngresosBrutos)
                        NETtoSQL(myCommand, "@ImportePagadoSinImpuestos", .ImportePagadoSinImpuestos)
                        NETtoSQL(myCommand, "@IdTipoRetencionGanancia", .IdTipoRetencionGanancia)
                        NETtoSQL(myCommand, "@IdIBCondicion", .IdIBCondicion)




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
                    If Not myOrdenPagoItem.Nuevo Then Delete(SC, myOrdenPagoItem.Id)
                End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPago_E.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleOrdenPago", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As OrdenPagoItem
            Dim myOrdenPagoItem As OrdenPagoItem = New OrdenPagoItem
            With myOrdenPagoItem
                'SQLtoNET(.Id, "IdDetalleOrdenPago", myDataRecord)
                'SQLtoNET(.IdOrdenPago, "IdOrdenPago", myDataRecord)
                'SQLtoNET(.IdConcepto, "IdConcepto", myDataRecord)
                'SQLtoNET(.ImporteTotalItem, "Importe", myDataRecord)
                'SQLtoNET(.Gravado, "Gravado", myDataRecord)
                'SQLtoNET(.IdDiferenciaCambio, "IdDiferenciaCambio", myDataRecord)
                'SQLtoNET(.IvaNoDiscriminado, "IvaNoDiscriminado", myDataRecord)
                'SQLtoNET(.IdCuentaBancaria, "IdCuentaBancaria", myDataRecord)
                'SQLtoNET(.IdCaja, "IdCaja", myDataRecord)



                SQLtoNET(.Id, "IdDetalleOrdenPago", myDataRecord)
                SQLtoNET(.IdOrdenPago, "IdOrdenPago", myDataRecord)
                SQLtoNET(.IdImputacion, "IdImputacion", myDataRecord)
                SQLtoNET(.Importe, "Importe", myDataRecord)

                SQLtoNET(myDataRecord, "@ImporteRetencionIVA", .ImporteRetencionIVA)
                SQLtoNET(myDataRecord, "@ImporteRetencionIngresosBrutos", .ImporteRetencionIngresosBrutos)
                SQLtoNET(myDataRecord, "@ImportePagadoSinImpuestos", .ImportePagadoSinImpuestos)
                SQLtoNET(myDataRecord, "@IdTipoRetencionGanancia", .IdTipoRetencionGanancia)
                SQLtoNET(myDataRecord, "@IdIBCondicion", .IdIBCondicion)


                Return myOrdenPagoItem
            End With
        End Function

    End Class
End Namespace