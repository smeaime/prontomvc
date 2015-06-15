Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class ReciboManager
        Inherits ServicedComponent



        Public Shared Sub RefrescarTalonario(ByVal SC As String, ByRef myRecibo As Recibo)
            With myRecibo
                'Dim ocli = ClienteManager.GetItem(SC, .IdCliente)

                ''estos debieran ser READ only, no?
                '.IdCodigoIva = ocli.IdCodigoIva
                '.TipoABC = EntidadManager.LetraSegunTipoIVA(.IdCodigoIva)
                '.IdPuntoVenta = IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(SC, .PuntoVenta, .TipoABC)
                '.Numero = ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(SC, .IdCodigoIva, .PuntoVenta)
                ''.Numero = ProximoNumeroFactura(SC, myFactura.IdPuntoVenta)


                .IdPuntoVenta = IdPuntoVentaComprobanteReciboSegunSubnumero(SC, .PuntoVenta)
                .NumeroRecibo = ReciboManager.ProximoNumeroReciboPorNumeroDePuntoVenta(SC, .PuntoVenta)

            End With
        End Sub


        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myRecibo As Recibo, Optional ByVal sError As String = "") As Integer
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            'Try




            Dim esNuevo As Boolean
            If myRecibo.Id = -1 Then esNuevo = True Else esNuevo = False

            If esNuevo Then
                RefrescarTalonario(SC, myRecibo)
            End If



            Dim ReciboId As Integer = ReciboDB.Save(SC, myRecibo)



            'For Each myReciboItem As ReciboItem In myRecibo.Detalles
            '    myReciboItem.IdRecibo = ReciboId
            '    ReciboItemDB.Save(myReciboItem)
            'Next

            If myRecibo.Id = -1 Then
                Try
                    'If myRecibo.CtaCte = "NO" Then
                    'ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximaReciboInterna", ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaReciboInterna") + 1)
                    'Else

                    ClaseMigrar.AsignarNumeroATalonario(SC, myRecibo.IdPuntoVenta, myRecibo.NumeroRecibo + 1)
                    'End If
                Catch ex As Exception
                    sError = "No se pudo incrementar el talonario. Verificar existencia de PuntosVenta_M. " & ex.Message
                    Exit Function
                End Try
            End If

            Guardar_CodigoOriginalDeVB6(SC, myRecibo)

            myRecibo.Id = ReciboId




            'myTransactionScope.Complete()
            'ContextUtil.SetComplete()
            Return ReciboId




            'Catch ex As Exception
            '    'ContextUtil.SetAbort()
            '    ErrHandler.WriteError(ex)
            '    'Debug.Print(ex.Message)
            '    Return -1
            'Finally
            '    'CType(myTransactionScope, IDisposable).Dispose()
            'End Try
        End Function



        Private Shared Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef Recibo As Recibo)
            '            'todo esto estaba en el mts



            Dim oCont 'As ObjectContext
            Dim oDet As ICompMTSManager
            Dim Resp ' As InterFazMTS.MisEstados
            Dim lErr As Long, sSource As String, sDesc As String
            Dim Datos As DataTable
            Dim DatosAnt As DataTable
            Dim DatosCtaCte As DataTable
            Dim DatosCtaCteNv As DataTable
            Dim DatosCliente As ClienteNuevo
            Dim oRsValores As DataTable
            Dim oRsValoresNv As DataTable
            Dim oRsComp As DataTable
            Dim DatosAsiento As DataTable
            Dim DatosAsientoNv As DataTable
            Dim oRsParametros As DataRow
            Dim DatosDetAsiento As DataTable
            Dim DatosDetAsientoNv As DataTable
            Dim oRsAux As DataTable
            Dim oFld As adodb.Field
            Dim i As Integer
            Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long
            Dim mIdDetalleRecibo As Long, mIdValor As Long, mvarIdCuenta As Long
            Dim mIdDetalleReciboValores As Long, mvarIdMonedaPesos As Long
            Dim mvarIdDetalleReciboCuentas As Long, mvarIdBanco As Long
            Dim Tot As Decimal, TotDol As Decimal, Sdo As Decimal, SdoDol As Decimal
            Dim mPagadoParteEnDolares As Double, mDeudores As Double, mvarCotizacion As Double
            Dim mvarCotizacionMoneda As Double, mvarCotizacionMonedaAnt As Double
            Dim mvarDebe As Double, mvarHaber As Double
            Dim mvarProcesa As Boolean, mvarLlevarAPesosEnValores As Boolean
            Dim mvarBorrarEnValores As Boolean, mvarAnulada As Boolean
            Dim mvarEsCajaBanco As String



            With Recibo
                mvarIdentificador = .Id
                mvarCotizacionMoneda = IIf(IsNull(.CotizacionMoneda), 1, .CotizacionMoneda)
                mvarCotizacion = IIf(.Cotizacion = 0, 1, .Cotizacion)
                mvarAnulada = False
                'If .Anulado = "OK" Then 'el tercer estado...
                '    mvarAnulada = True
                '    .Anulado = "SI"
                'End If


                oRsParametros = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                mvarIdMonedaPesos = ParametroManager.ParametroOriginal(SC, ParametroManager.ePmOrg.IdMoneda)





                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////
                'actualiza la cotizacion si es q cambió
                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////

                mDeudores = 0
                mvarCotizacionMonedaAnt = 1
                If mvarIdentificador > 0 Then
                    'si es una edicion, lo compara con el anterior
                    DatosAnt = oDet.LeerUno(SC, Entidades.Recibos, .Id)
                    If DatosAnt.Rows.Count > 0 Then
                        mvarCotizacionMonedaAnt = IIf(IsNull(DatosAnt.Rows(0).Item("CotizacionMoneda")), 1, DatosAnt.Rows(0).Item("CotizacionMoneda"))
                        mDeudores = DatosAnt.Rows(0).Item("Deudores")
                    End If

                End If

                'y acá? por qué pisa el encabezado de nuevo? no hay una manera mas elegante? (RESOLVER)
                'Resp = iCompMTS_GuardarPorRef("Recibos", Recibo) 




                '////////////////////////////
                '////////////////////////////
                'cambio el saldo del cliente
                '////////////////////////////
                '////////////////////////////

                If Not IsNull(.IdCliente) And Not mvarAnulada Then

                    DatosCliente = ClienteManager.GetItem(SC, .IdCliente)

                    DatosCliente.Saldo = DatosCliente.Saldo + _
                                             Math.Round(mDeudores * mvarCotizacionMonedaAnt, 2) - _
                                             Math.Round(.Deudores * mvarCotizacionMoneda, 2)

                    Try
                        ClienteManager.Save(SC, DatosCliente)
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                End If

                '//////////////////////////////////////
                '//////////////////////////////////////







                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                'modificacion de CtasCtesD
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////


                ''/////////////////////////////////////////////////
                'si es una anulacion
                ''/////////////////////////////////////////////////
                If .Id > 0 And .Anulado Then
                    DatosAnt = EntidadManager.GetListTX(SC, "DetRecibos", "_PorIdRecibo", mvarIdentificador).Tables(0)

                    For Each dr As DataRow In DatosAnt.Rows

                        Try
                            DatosCtaCteNv = EntidadManager.GetListTX(SC, "CtasCtesD", "_PorDetalleRecibo", dr.Item(0)).Tables(0)

                            Tot = DatosCtaCteNv.Rows(0).Item("ImporteTotal") - DatosCtaCteNv.Rows(0).Item("Saldo")
                            TotDol = DatosCtaCteNv.Rows(0).Item("ImporteTotalDolar") - DatosCtaCteNv.Rows(0).Item("SaldoDolar")

                            If Not IsNull(dr.Item("IdImputacion")) Then
                                DatosCtaCte = EntidadManager.GetListTX(SC, "CtasCtesD", "_Imputacion", dr.Item("IdImputacion")).Tables(0)

                                DatosCtaCte.Rows(0).Item("Saldo") = DatosCtaCte.Rows(0).Item("Saldo") + Tot
                                DatosCtaCte.Rows(0).Item("SaldoDolar") = DatosCtaCte.Rows(0).Item("SaldoDolar") + TotDol

                                CtaCteDeudorManager.Insert(SC, DatosCtaCte)


                            End If

                            CtaCteDeudorManager.Delete(SC, DatosCtaCteNv.Rows(0).Item(0))


                        Catch ex As Exception

                        End Try

                    Next

                    EntidadManager.Tarea(SC, "VentasEnCuotas_AnulacionDePago", mvarIdentificador)

                End If





                ''////////////////////////////////////////////////
                ''////////////////////////////////////////////////
                ' CtasCtesD segun las imputaciones
                ''////////////////////////////////////////////////
                ''////////////////////////////////////////////////


                For Each iImp As ReciboItem In .DetallesImputaciones
                    With iImp

                        If mvarIdentificador > 0 And Not mvarAnulada Then
                            'si es una edicion

                            DatosAnt = EntidadManager.GetListTX(SC, "DetRecibos", "_PorIdDetalleRecibo", .Id).Tables(0)
                            For Each dr As DataRow In DatosAnt.Rows

                                DatosCtaCteNv = EntidadManager.GetListTX(SC, "CtasCtesD", "_PorDetalleRecibo", .Id).Tables(0)
                                If DatosCtaCteNv.Rows.Count > 0 Then

                                    Tot = DatosCtaCteNv.Rows(0).Item("ImporteTotal") - DatosCtaCteNv.Rows(0).Item("Saldo")
                                    TotDol = DatosCtaCteNv.Rows(0).Item("ImporteTotalDolar") - DatosCtaCteNv.Rows(0).Item("SaldoDolar")

                                    If Not IsNull(dr.Item("IdImputacion")) Then
                                        DatosCtaCte = EntidadManager.GetListTX(SC, "CtasCtesD", "_Imputacion", dr.Item("IdImputacion")).Tables(0)
                                        If DatosCtaCte.Rows.Count > 0 Then

                                            DatosCtaCte.Rows(0).Item("Saldo") = DatosCtaCte.Rows(0).Item("Saldo") + Tot
                                            DatosCtaCte.Rows(0).Item("SaldoDolar") = DatosCtaCte.Rows(0).Item("SaldoDolar") + TotDol


                                            Resp = CtaCteDeudorManager.Insert(SC, DatosCtaCte) 'guardo

                                        End If
                                    End If

                                    CtaCteDeudorManager.Delete(SC, DatosCtaCteNv.Rows(0).Item(0)) 'elimino

                                End If
                            Next

                        ElseIf mvarIdentificador > 0 And mvarAnulada Then

                            EntidadManager.Tarea("DiferenciasCambio_Eliminar", 2, .Id)

                        End If




                        If .Eliminado Then

                            'oDet.Eliminar(SC, "DetRecibos", .Id)

                        ElseIf Not mvarAnulada Then



                            DatosCtaCte = CtaCteDeudorManager.TraerMetadata(SC)
                            DatosCtaCteNv = DatosCtaCte.Copy

                            DatosCtaCteNv.Rows.Add(DatosCtaCteNv.NewRow)

                            With DatosCtaCteNv.Rows(0)
                                Tot = Math.Round(Math.Abs(iImp.Importe) * mvarCotizacionMoneda, 2)
                                TotDol = Math.Round(Math.Abs(iImp.Importe) * mvarCotizacionMoneda / mvarCotizacion, 2)
                                .Item("IdCliente") = Recibo.IdCliente
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("Fecha") = iisValidSqlDate(Recibo.FechaRecibo, DBNull.Value)
                                .Item("IdTipoComp") = 2
                                .Item("IdComprobante") = Recibo.Id

                                If iImp.IdImputacion <> -1 Then
                                    .Item("IdImputacion") = iImp.IdImputacion
                                End If

                                .Item("ImporteTotal") = Tot
                                .Item("Saldo") = Tot
                                .Item("IdDetalleRecibo") = mIdDetalleRecibo
                                .Item("Cotizacion") = mvarCotizacion
                                .Item(0) = -1
                                .Item("ImporteTotalDolar") = TotDol
                                .Item("SaldoDolar") = TotDol
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda


                                If iImp.IdImputacion <> 0 Then

                                    DatosCtaCte = EntidadManager.GetListTX(SC, "CtasCtesD", "TX_Imputacion", iImp.IdImputacion).Tables(0)

                                    If DatosCtaCte.Rows.Count > 0 Then
                                        Sdo = DatosCtaCte.Rows(0).Item("Saldo")
                                        SdoDol = DatosCtaCte.Rows(0).Item("SaldoDolar")
                                    Else
                                        Sdo = 0
                                        SdoDol = 0
                                    End If

                                    'Esta rutina estaba remeada y se reactivo
                                    If Recibo.Dolarizada = "NO" Then
                                        If IsNull(DatosCtaCte.Rows(0).Item("Cotizacion")) Or DatosCtaCte.Rows(0).Item("Cotizacion") = 0 Then
                                            TotDol = 0
                                        Else
                                            TotDol = Math.Abs(iImp.Importe) * Recibo.CotizacionMoneda / DatosCtaCte.Rows(0).Item("Cotizacion")
                                        End If
                                        .Item("Cotizacion") = DatosCtaCte.Rows(0).Item("Cotizacion")
                                        .Item("ImporteTotalDolar") = TotDol
                                        .Item("SaldoDolar") = TotDol
                                    End If

                                    'Fin rutina reactivada
                                    If Tot > Sdo Then
                                        Tot = Math.Round(Tot - Sdo, 2)
                                        DatosCtaCte.Rows(0).Item("Saldo") = 0
                                        .Item("Saldo") = Tot
                                    Else
                                        Sdo = Math.Round(Sdo - Tot, 2)
                                        DatosCtaCte.Rows(0).Item("Saldo") = Sdo
                                        .Item("Saldo") = 0
                                    End If

                                    If TotDol > SdoDol Then
                                        TotDol = Math.Round(TotDol - SdoDol, 2)
                                        DatosCtaCte.Rows(0).Item("SaldoDolar") = 0
                                        .Item("SaldoDolar") = TotDol
                                    Else
                                        SdoDol = Math.Round(SdoDol - TotDol, 2)
                                        DatosCtaCte.Rows(0).Item("SaldoDolar") = SdoDol
                                        .Item("SaldoDolar") = 0
                                    End If

                                    .Item("IdImputacion") = DatosCtaCte.Rows(0).Item("IdImputacion")
                                    oRsComp = EntidadManager.GetListTX(SC, "TiposComprobante", "TX_Buscar", DatosCtaCte.Rows(0).Item("IdTipoComp")).Tables(0)

                                    'este anda MAL. RESOLVER (le está asignando tipo comprobante="CO" a todos)
                                    'If oRsComp.Rows(0).Item("Coeficiente") = -1 Then
                                    '    .Item("IdTipoComp") = 16
                                    'End If

                                    Resp = CtaCteDeudorManager.Insert(SC, DatosCtaCte)

                                End If
                            End With





                            If iisNull(DatosCtaCteNv.Rows(0).Item("IdImputacion"), 0) <> 0 Then
                                'si no hay imputacion, guarda normalmente 
                                Resp = CtaCteDeudorManager.Insert(SC, DatosCtaCteNv)
                            Else
                                'guarda, trae el id, y guarda de nuevo
                                Resp = CtaCteDeudorManager.Insert(SC, DatosCtaCteNv)
                                DatosCtaCteNv = CtaCteDeudorManager.TraerMetadata(SC, Resp)
                                DatosCtaCteNv.Rows(0).Item("IdImputacion") = Resp
                                .IdImputacion = Resp
                                Resp = CtaCteDeudorManager.Update(SC, DatosCtaCteNv)
                            End If



                            '////////////////////////////////////
                            '////////////////////////////////////
                            'diferencias de cambio (RESOLVER)

                            'If mvarIdentificador > 0 Then
                            '    EntidadManager.Tarea("DiferenciasCambio_Eliminar", 2, mIdDetalleRecibo)
                            'End If
                            'If Recibo.Dolarizada = "SI" Then
                            '    Datos = EntidadManager.GetListTX(SC, "DiferenciasCambio", "_Struc")
                            '    Datos.Rows(0).Item(0) = -1
                            '    Datos.Rows(0).Item("IdTipoComprobante") = 2
                            '    Datos.Rows(0).Item("IdRegistroOrigen") = mIdDetalleRecibo

                            '    ICompMTSManager.Insert(SC, "DiferenciasCambio", Datos)
                            'End If

                            '////////////////////////////////////
                            '////////////////////////////////////

                        End If


                    End With
                Next






                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''valores nuevos a partir de la coleccion de valores
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////


                For Each iVal As ReciboValoresItem In .DetallesValores
                    With iVal





                        If .IdCaja > 0 Then

                            mIdValor = -1
                            oRsValores = EntidadManager.GetListTX(SC, "Valores", "TX_PorIdDetalleReciboValores", mIdDetalleReciboValores).Tables(0)
                            If oRsValores.Rows.Count > 0 Then
                                mIdValor = oRsValores.Rows(0).Item(0)
                            End If

                            oRsValores = ICompMTSManager.TraerMetadata(SC, Entidades.Valores)
                            oRsValoresNv = oRsValores.Copy

                            oRsValores = Nothing
                            With oRsValoresNv.Rows(0)
                                .Item("IdTipoValor") = iVal.IdTipoValor
                                .Item("Importe") = iVal.Importe
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .Item("IdCliente") = Recibo.IdCliente
                                .Item("IdTipoComprobante") = 2
                                .Item("IdDetalleReciboValores") = mIdDetalleReciboValores
                                .Item("IdCaja") = iVal.IdCaja
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                                .Item(0) = mIdValor
                            End With
                            Resp = ICompMTSManager.Insert(SC, Entidades.Valores, oRsValoresNv)
                            mvarBorrarEnValores = False

                        Else

                            oRsComp = EntidadManager.GetListTX(SC, "TiposComprobante", "TX_PorId", iVal.IdTipoValor).Tables(0)
                            mvarProcesa = True
                            mvarLlevarAPesosEnValores = False
                            If oRsComp.Rows.Count > 0 Then
                                If Not IsNull(oRsComp.Rows(0).Item("VaAConciliacionBancaria")) Then
                                    If oRsComp.Rows(0).Item("VaAConciliacionBancaria") = "NO" Then
                                        mvarProcesa = False
                                    End If
                                End If
                                If Not IsNull(oRsComp.Rows(0).Item("LlevarAPesosEnValores")) Then
                                    If oRsComp.Rows(0).Item("LlevarAPesosEnValores") = "SI" Then
                                        mvarLlevarAPesosEnValores = True
                                    End If
                                End If
                            Else
                                mvarProcesa = False
                            End If



                            If mvarProcesa Then

                                mIdValor = -1
                                oRsValores = EntidadManager.GetListTX(SC, "Valores", "TX_PorIdDetalleReciboValores", mIdDetalleReciboValores).Tables(0)
                                If oRsValores.Rows.Count > 0 Then
                                    mIdValor = oRsValores.Rows(0).Item(0)


                                    'oRsValoresNv = CopiarUnRegistro(oRsValores)
                                    oRsValoresNv = oRsValores.Clone()
                                    oRsValoresNv.ImportRow(oRsValores.Rows(0))
                                Else
                                    oRsValores = EntidadManager.GetListTX(SC, "Valores", "TX_Struc").Tables(0)
                                    oRsValoresNv = oRsValores.Copy
                                End If


                                With oRsValoresNv.Rows(0)
                                    .Item("IdTipoValor") = iVal.IdTipoValor
                                    If iVal.IdCuentaBancariaTransferencia > 0 Then
                                        .Item("Estado") = "D"
                                        .Item("IdCuentaBancariaDeposito") = iVal.IdCuentaBancariaTransferencia
                                        .Item("IdBancoDeposito") = iVal.IdBancoTransferencia
                                        .Item("FechaDeposito") = iisValidSqlDate(Recibo.FechaRecibo, DBNull.Value)
                                        .Item("NumeroDeposito") = iVal.NumeroTransferencia
                                    Else
                                        .Item("Estado") = DBNull.Value
                                        .Item("NumeroValor") = iVal.NumeroValor
                                        .Item("NumeroInterno") = iVal.NumeroInterno
                                        .Item("FechaValor") = iisValidSqlDate(iVal.FechaVencimiento, DBNull.Value)
                                        .Item("IdBanco") = iVal.IdBanco
                                        .Item("CuitLibrador") = iVal.CuitLibrador
                                    End If
                                    If mvarLlevarAPesosEnValores Then
                                        .Item("Importe") = Math.Round(iVal.Importe * Recibo.CotizacionMoneda, 2)
                                        .Item("IdMoneda") = mvarIdMonedaPesos
                                        .Item("CotizacionMoneda") = 1
                                    Else
                                        .Item("Importe") = iVal.Importe
                                        .Item("IdMoneda") = Recibo.IdMoneda
                                        .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                                    End If
                                    .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                    .Item("FechaComprobante") = iisValidSqlDate(Recibo.FechaRecibo, DBNull.Value)
                                    .Item("IdCliente") = Recibo.IdCliente
                                    .Item("IdTipoComprobante") = 2
                                    .Item("IdDetalleReciboValores") = mIdDetalleReciboValores
                                    .Item(0) = mIdValor
                                End With

                                'Genera los valores
                                Resp = oDet.Insert(SC, Entidades.Valores, oRsValoresNv)
                                mvarBorrarEnValores = False

                            End If

                        End If



                        If mvarIdentificador > 0 And mvarBorrarEnValores Then
                            EntidadManager.Tarea(SC, "Valores_BorrarPorIdDetalleReciboValores", .Id)
                        End If


                    End With
                Next




                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                'valores nuevos a partir del asiento contable
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////

                For Each iCu As ReciboCuentasItem In .DetallesCuentas
                    With iCu


                        If .Eliminado Then

                            If .Id > 0 Then
                                oDet.Eliminar(SC, "DetRecibosCuentas", .Id)
                                EntidadManager.Tarea(SC, "Valores_BorrarPorIdDetalleReciboCuentas", .Id)
                            End If

                        Else


                            If iCu.Haber <> 0 Then
                                oRsAux = EntidadManager.GetListTX(SC, "Cuentas", "TX_CuentaCajaBanco", .IdCuenta).Tables(0)
                                If oRsAux.Rows.Count > 0 Then
                                    mvarEsCajaBanco = ""

                                    If iisNull(oRsAux.Rows(0).Item("EsCajaBanco")) = "BA" Or iisNull(oRsAux.Rows(0).Item("EsCajaBanco")) = "CA" Then
                                        mvarEsCajaBanco = oRsAux.Rows(0).Item("EsCajaBanco")
                                    End If

                                    If Len(mvarEsCajaBanco) > 0 Then
                                        mIdValor = -1
                                        oRsAux = EntidadManager.GetListTX(SC, "Valores", "TX_PorIdDetalleReciboCuentas", mvarIdDetalleReciboCuentas).Tables(0)
                                        If oRsAux.Rows.Count > 0 Then
                                            mIdValor = oRsAux.Rows(0).Item(0)
                                        End If


                                        mvarIdBanco = 0
                                        If mvarEsCajaBanco = "BA" And Not IsNull(iCu.IdCuentaBancaria) Then
                                            oRsAux = EntidadManager.GetListTX(SC, "CuentasBancarias", "TX_PorId", iCu.IdCuentaBancaria).Tables(0)
                                            If oRsAux.Rows.Count > 0 Then
                                                mvarIdBanco = oRsAux.Rows(0).Item("IdBanco")
                                            End If
                                        End If

                                        oRsValores = EntidadManager.GetListTX(SC, "Valores", "TX_Struc").Tables(0)
                                        oRsValoresNv = oRsValores.Copy

                                        With oRsValoresNv.Rows(0)

                                            If mvarEsCajaBanco = "BA" Then
                                                .Item("IdTipoValor") = 21
                                                .Item("IdBanco") = mvarIdBanco
                                                .Item("IdCuentaBancaria") = iCu.IdCuentaBancaria
                                            Else
                                                .Item("IdTipoValor") = 33
                                                .Item("IdCaja") = iCu.IdCaja
                                            End If

                                            .Item("NumeroValor") = 0
                                            .Item("NumeroInterno") = 0
                                            .Item("FechaValor") = Recibo.FechaRecibo


                                            If Not IsNull(iCu.CotizacionMonedaDestino) And _
                                                iCu.CotizacionMonedaDestino <> 0 Then
                                                If Not IsNull(iCu.Debe) And _
                                                    iCu.Debe <> 0 Then
                                                    .Item("Importe") = (iCu.Debe * Recibo.CotizacionMoneda) / _
                                                                                iCu.CotizacionMonedaDestino
                                                End If
                                                If iCu.Haber <> 0 Then
                                                    .Item("Importe") = (iCu.Haber * Recibo.CotizacionMoneda) / _
                                                                                iCu.CotizacionMonedaDestino * -1
                                                End If
                                                .Item("CotizacionMoneda") = iCu.CotizacionMonedaDestino
                                            Else

                                                If iCu.Debe <> 0 Then
                                                    .Item("Importe") = iCu.Debe
                                                End If
                                                If iCu.Haber <> 0 Then
                                                    .Item("Importe") = iCu.Haber * -1
                                                End If
                                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                                            End If

                                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                            .Item("FechaComprobante") = Recibo.FechaRecibo



                                            If Not IsNull(Recibo.IdCliente) Then
                                                .Item("IdCliente") = Recibo.IdCliente
                                            End If


                                            .Item("IdTipoComprobante") = 2
                                            .Item("IdDetalleReciboCuentas") = mvarIdDetalleReciboCuentas
                                            .Item("IdMoneda") = iCu.IdMoneda
                                            .Item(0) = mIdValor

                                        End With


                                        Resp = oDet.Insert(SC, Entidades.Valores, oRsValoresNv)

                                    End If
                                End If
                            End If

                        End If



                    End With
                Next




                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                'subdiarios nuevos segun el asiento
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////

                '///////////////////
                'Si es edicion, antes borra todos los subdiarios
                '///////////////////

                If mvarIdentificador > 0 Or mvarAnulada Then
                    DatosAnt = EntidadManager.GetListTX(SC, "Subdiarios", "_PorIdComprobante", mvarIdentificador, 2).Tables(0)

                    For Each dr As DataRow In DatosAnt.Rows
                        oDet.Eliminar(SC, Entidades.Subdiarios, dr.Item(0))
                    Next

                End If


                '///////////////////
                'genera el subdiario desde 0
                '///////////////////

                mvarDebe = 0
                mvarHaber = 0

                Dim RegistroContable As DataTable = RecalcularRegistroContable(SC, Recibo)

                With RegistroContable
                    If Not mvarAnulada Then

                        For Each dr As DataRow In .Rows

                            With dr
                                If Not IsNull(.Item("Debe")) Then
                                    .Item("Debe") = Math.Round(.Item("Debe") * mvarCotizacionMoneda, 2)
                                    mvarDebe = mvarDebe + .Item("Debe")
                                End If
                                If Not IsNull(.Item("Haber")) Then
                                    .Item("Haber") = Math.Round(.Item("Haber") * mvarCotizacionMoneda, 2)
                                    mvarHaber = mvarHaber + .Item("Haber")
                                End If
                            End With
                        Next


                        If .Rows.Count > 0 Then
                            If mvarDebe - mvarHaber <> 0 Then
                                If Not IsNull(.Rows(0).Item("Debe")) Then
                                    .Rows(0).Item("Debe") = .Rows(0).Item("Debe") - Math.Round(mvarDebe - mvarHaber, 2)
                                Else
                                    .Rows(0).Item("Haber") = .Rows(0).Item("Haber") + Math.Round(mvarDebe - mvarHaber, 2)
                                End If
                            End If
                        End If

                        Datos = RegistroContable.Copy
                        For Each dr As DataRow In Datos.Rows
                            dr.Item(0) = -1
                            dr.Item("IdComprobante") = Recibo.Id

                            dr.Item("FechaComprobante") = fechaNETtoSQL(Recibo.FechaRecibo)
                            dr.Item("FechaImportacionTransmision") = fechaNETtoSQL(Recibo.FechaImportacionTransmision)
                        Next
                        Resp = oDet.Insert(SC, Entidades.Subdiarios, Datos)


                    End If
                End With


                ''////////////////////////////////////////////////
                ''////////////////////////////////////////////////
                ''////////////////////////////////////////////////




            End With

        End Function




        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As ReciboList
            Return ReciboDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As Recibo
            If id <= 0 Then Return Nothing

            GetCopyOfItem = GetItem(SC, id, True)
            'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
            GetCopyOfItem.Id = -1
            For Each item As ReciboItem In GetCopyOfItem.DetallesImputaciones
                item.Id = -1
            Next
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As ReciboList
            Dim ReciboList As Pronto.ERP.BO.ReciboList = ReciboDB.GetListByEmployee(SC, IdSolicito)
            If ReciboList IsNot Nothing Then
                Select Case orderBy
                    'Case "Fecha"
                    '    ReciboList.Sort(AddressOf Pronto.ERP.BO.ReciboList.CompareFecha)
                    'Case "Obra"
                    '    ReciboList.Sort(AddressOf Pronto.ERP.BO.ReciboList.CompareObra)
                    'Case "Sector"
                    '    ReciboList.Sort(AddressOf Pronto.ERP.BO.ReciboList.CompareSector)
                    'Case Else 'Ordena por id
                    '    ReciboList.Sort(AddressOf Pronto.ERP.BO.ReciboList.CompareId)
                End Select
            End If
            Return ReciboList
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return ReciboDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String) As System.Data.DataTable



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With


            Try
                ds = GeneralDB.TraerDatos(SC, "Recibos_TT")
                'ds = GeneralDB.TraerDatos(SC, "wRecibos_T", -1)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Recibos_TT")
            End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdRecibo").ColumnName = "Id"
                .Columns("Recibo").ColumnName = "Numero"
                '.Columns("FechaRecibo").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Dim dt As DataTable = ds.Tables(0)
            dt.DefaultView.Sort = "Id DESC"
            Return dt.DefaultView.Table
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTXDetallesPendientes(ByVal SC As String) As System.Data.DataSet
            Return GetListTX(SC, "_Pendientes1", "P")
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String, ByVal ParamArray Parametros() As Object) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wRecibos_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Recibos_TX" & TX, Parametros)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox


            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wRecibos_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Recibos_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function





        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Recibo
            Return GetItem(SC, id, False)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getReciboDetalles As Boolean) As Recibo
            Dim myRecibo As Recibo
            myRecibo = ReciboDB.GetItem(SC, id)

            If Not (myRecibo Is Nothing) AndAlso getReciboDetalles Then
                'traigo el detalle
                myRecibo.DetallesImputaciones = reciboItemDB.GetList(SC, id)
                myRecibo.DetallesCuentas = ReciboCuentasItemDB.GetList(SC, id)
                myRecibo.DetallesRubrosContables = ReciboRubrosContablesItemDB.GetList(SC, id)
                myRecibo.DetallesValores = ReciboValoresItemDB.GetList(SC, id)
                'myRecibo.DetallesAnticiposAlPersonal = ReciboAnticiposAlPersonalItemDB.GetList(SC, id)


                RefrescarDesnormalizados(SC, myRecibo)


            End If

            Return myRecibo
        End Function

        Private Shared Sub RefrescarDesnormalizados(ByVal SC As String, ByRef myRecibo As Recibo)
            'traigo las descripciones de los items
            If Not IsNothing(myRecibo.DetallesImputaciones) Then
                For Each i As ReciboItem In myRecibo.DetallesImputaciones
                    If i.IdImputacion > 0 Then
                        Dim dr As DataRow = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion).Rows(0)
                        i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
                        i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(SC, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
                    Else
                        i.TipoComprobanteImputado = "PA" 'pagoanticipado
                    End If
                Next
            End If

            If Not IsNothing(myRecibo.DetallesCuentas) Then
                For Each i As ReciboCuentasItem In myRecibo.DetallesCuentas
                    i.DescripcionCuenta = EntidadManager.NombreCuenta(SC, i.IdCuenta, i.CodigoCuenta)
                Next
            End If

            If Not IsNothing(myRecibo.DetallesValores) Then
                For Each i As ReciboValoresItem In myRecibo.DetallesValores
                    i.Tipo = EntidadManager.NombreValorTipo(SC, i.IdTipoValor)
                Next
            End If

            If Not IsNothing(myRecibo.DetallesRubrosContables) Then
                For Each i As ReciboRubrosContablesItem In myRecibo.DetallesRubrosContables
                    i.DescripcionRubroContable = EntidadManager.NombreRubroContable(SC, i.IdRubroContable)
                Next
            End If

        End Sub



        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As ReciboItemList
            Dim list As ReciboItemList = reciboItemDB.GetList(SC, id)
            For Each i As ReciboItem In list
                If i.IdImputacion > 0 Then
                    Dim dr As DataRow = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion).Rows(0)
                    i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
                    i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(SC, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
                End If
            Next
            Return list
        End Function


        



     






        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myRecibo As Recibo) As Boolean
            Return ReciboDB.Delete(SC, myRecibo.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            Return ReciboDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal Id As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

            'Dim myRemito As Pronto.ERP.BO.Remito = GetItem(SC, IdRemito)
            Dim myRecibo As Pronto.ERP.BO.Recibo = GetItem(SC, Id, True)

            With myRecibo
                '.MotivoAnulacion = motivo
                '.FechaAnulacion = Today
                '.UsuarioAnulacion = IdUsuario
                '.Anulada = "SI"
                '.IdAutorizaAnulacion = cmbUsuarioAnulo.SelectedValue
                '.Cumplido = "AN"
                '.Anulada = "SI"
                '.IdAutorizaAnulacion = IdUsuario

                For Each i As ReciboItem In .DetallesImputaciones
                    With i
                        '.Cumplido = "AN"
                        '.EnviarEmail = 1
                    End With
                Next






                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                'TO DO: No encontré el campo CAE en la nota de debito
                'If iisNull(.CAE, "") <> "" Then
                '    Return "No puede anular un comprobante electronico (CAE)"
                'End If



                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                ''reviso si hay facturas que esten imputadas al remito que se quiere anular
                'Dim dr As DataRow
                'Try
                '    dr = EntidadManager.GetStoreProcedureTop1(SC, "CtasCtesD_TX_BuscarComprobante", Id, EntidadManager.IdTipoComprobante.Recibo)
                'Catch ex As Exception

                'End Try

                'If Not IsNothing(dr) Then
                '    If dr.Item("ImporteTotal") <> dr.Item("Saldo") Then
                '        Return "La nota de debito ha sido cancelada parcial o totalmente y no puede anularse"
                '    End If
                'End If

                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////







                'If ExistenAnticiposAplicados() Then
                '    MsgBox("El recibo contiene anticipos que en cuenta corriente han sido aplicados." & vbCrLf & _
                '          "No puede anular este recibo", vbInformation)
                '    Exit Function
                'End If

                'Dim oRs As adodb.Recordset
                'Dim mError As String
                'oRs = Aplicacion.Recibos.TraerFiltrado("_PorEstadoValores", mvarId)
                'mError = ""
                'If oRs.RecordCount > 0 Then
                '    mError = "El recibo no puede anularse porque tiene valores ingresados "
                '    Do While Not oRs.EOF
                '        If oRs.Fields("Estado").Value = "E" Then
                '            mError = mError & "endosados "
                '        ElseIf oRs.Fields("Estado").Value = "D" Then
                '            mError = mError & "depositados "
                '        End If
                '        oRs.MoveNext()
                '    Loop
                'End If



                .Anulado = EnumPRONTO_SiNo.SI '  "SI" ?????


                Save(SC, myRecibo)
            End With


        End Function


        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Return ReciboDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function


        Public Shared Function IsValid(ByVal SC As String, ByRef myRecibo As Recibo, Optional ByRef ms As String = "") As Boolean

            With myRecibo

                RecalcularTotales(myRecibo)

                Dim eliminados As Integer
                'verifico el detalle
                For Each det As ReciboItem In .DetallesImputaciones
                    If det.IdImputacion = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    If det.Eliminado Then eliminados = eliminados + 1

                Next




                For Each det As ReciboCuentasItem In .DetallesCuentas
                    If det.IdCuenta = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    'If det.Eliminado Then eliminados = eliminados + 1

                Next

                For Each det As ReciboValoresItem In .DetallesValores
                    If det.IdTipoValor = 0 And det.IdCaja = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    'If det.Eliminado Then eliminados = eliminados + 1

                Next

                For Each det As ReciboRubrosContablesItem In .DetallesRubrosContables
                    If det.IdRubroContable = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    'If det.Eliminado Then eliminados = eliminados + 1

                Next
                '          If DTFields(0).Value <= gblFechaUltimoCierre And _
                'Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
                '              MsgBox("La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation)
                '              Exit Function
                '          End If

                '          If Not IsNumeric(txtNumeroRecibo.Text) Or Len(txtNumeroRecibo.Text) = 0 Then
                '              MsgBox("No ingreso el numero de recibo", vbCritical)
                '              Exit Function
                '          End If

                '          If Not IsNumeric(dcfields(10).BoundText) Or Len(dcfields(10).Text) = 0 Then
                '              MsgBox("No ha ingresado el punto de venta", vbCritical)
                '              Exit Function
                '          End If



                If .Tipo = Recibo.tipoRecibo.CC And (.DetallesImputaciones.Count = eliminados Or .DetallesImputaciones.Count = 0) Then
                    ms = "La lista de items no puede estar vacía"
                    Return False
                End If

                If Val(.NumeroRecibo) = 0 Then
                    ms = "Debe ingresar el numero de orden de compra del cliente"
                    Return False
                End If

                If .TotalDiferencia <> 0 And Not .Tipo = Recibo.tipoRecibo.OT Then
                    ms = "El recibo no cierra, ajuste los valores e intente nuevamente"
                    Return False
                End If

                '          If Val(Replace(txtTotal(1).Text, ",", "")) <> Val(Replace(txtTotal(2).Text, ",", "")) Then
                '              MsgBox("No balancea el registro contable", vbInformation)
                '              Exit Function
                '          End If

                '          If Lista.ListItems.Count = 0 And Not Option2.Value Then
                '              MsgBox("No se puede almacenar un Recibo sin detalles")
                '              Exit Function
                '          End If

                '          If Len(txtCotizacionMoneda.Text) = 0 Then
                '              MsgBox("No ingreso el valor de conversion a pesos", vbInformation)
                '              Exit Function
                '          End If

                '          If Val(txtCotizacionMoneda.Text) <= 0 Then
                '              MsgBox("La cotizacion debe ser mayor a cero", vbInformation)
                '              Exit Function
                '          End If

                '          If mvarCotizacion = 0 Then
                '              MsgBox("No hay cotizacion dolar al " & DTFields(0).Value, vbInformation)
                '              Exit Function
                '          End If

                '          If txtNumeroCertificadoRetencionGanancias.Visible Then
                '              If Len(txtNumeroCertificadoRetencionGanancias.Text) > 0 And Not IsNumeric(dcfields1(3).BoundText) Then
                '                  MsgBox("Debe indicar el tipo de retencion ganancias")
                '                  Exit Function
                '              End If
                '          End If

                '          If Option2.Value And Len(Combo1(0).Text) = 0 Then
                '              MsgBox("Debe indicar el tipo de operacion", vbInformation)
                '              Exit Function
                '          End If

                '          If mvarId > 0 Then
                '              If ExistenAnticiposAplicados() Then
                '                  MsgBox("Hay anticipos que en cuenta corriente tienen aplicado el saldo" & vbCrLf & _
                '                        "No puede modificar este recibo", vbInformation)
                '                  Exit Function
                '              End If
                '          End If

                '          If mvarControlarRubrosContablesEnOP = "SI" Then
                '              If mvarTotalValores <> mvarTotalRubrosContables And _
                '                    (Not Combo1(0).Visible Or (Combo1(0).Visible And Combo1(0).ListIndex = 1)) Then
                '                  MsgBox("El total de rubros contables asignados debe ser igual al total de valores", vbExclamation)
                '                  Exit Function
                '              End If
                '          End If

                '          If Option1.Value Then
                '              If EstadoEntidad("Clientes", origen.Registro.Fields("IdCliente").Value) = "INACTIVO" Then
                '                  MsgBox("Cliente inhabilitado", vbExclamation)
                '                  Exit Function
                '              End If
                '          End If

                '          If ListaCta.ListItems.Count = 0 Then
                '              MsgBox("No hay registro contable, revise la definicion de cuentas utilizadas en este recibo.", vbExclamation)
                '              Exit Function
                '          End If

                '          If Not (mvarId <= 0 And mNumeroReciboPagoAutomatico = "SI") Then
                '              oRs = Aplicacion.Recibos.TraerFiltrado("Cod", Array(dcfields(10).Text, Val(txtNumeroRecibo.Text)))
                '              If oRs.RecordCount > 0 Then
                '                  If oRs.Fields("IdRecibo").Value <> mvarId Then
                '                      MsgBox("Numero de recibo existente ( " & oRs.Fields("FechaRecibo").Value & " )", vbCritical)
                '                      oRs.Close()
                '                      oRs = Nothing
                '                      Exit Function
                '                  End If
                '              End If
                '              oRs.Close()
                '          End If

                '          oRs = origen.DetRecibosCuentas.TodosLosRegistros
                '          If oRs.Fields.Count > 0 Then
                '              If oRs.RecordCount > 0 Then
                '                  oRs.MoveFirst()
                '                  Do While Not oRs.EOF
                '                      If Not oRs.Fields("Eliminado").Value Then
                '                          If IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value) = 0 Then
                '                              oRs = Nothing
                '                              MsgBox("Hay cuentas contables no definidas, no puede registrar el recibo", vbExclamation)
                '                              Exit Function
                '                          End If
                '                      End If
                '                      oRs.MoveNext()
                '                  Loop
                '              End If
                '          End If
                '          oRs = Nothing

                '          Dim dc As DataCombo
                '          Dim dtp As DTPicker
                '          Dim est As EnumAcciones
                '          Dim i As Integer
                '          Dim mAux1 As String

                '          If mvarId > 0 Then
                '              oRs = Aplicacion.Recibos.TraerFiltrado("_ValoresEnConciliacionesPorIdRecibo", mvarId)
                '              If oRs.RecordCount > 0 Then
                '                  mAux1 = ""
                '                  oRs.MoveFirst()
                '                  Do While Not oRs.EOF
                '                      mAux1 = mAux1 & IIf(IsNull(oRs.Fields("Numero").Value), 0, oRs.Fields("Numero").Value) & " "
                '                      oRs.MoveNext()
                '                  Loop
                '                  MsgBox("Cuidado, hay valores en este recibo que estan en" & vbCrLf & _
                '                        "la(s) conciliacion(es) : " & mAux1 & vbCrLf & _
                '                        "tome las precauciones del caso." & vbCrLf & _
                '                        "El mensaje es solo informativo.", vbExclamation)
                '              End If
                '              oRs.Close()
                '          End If

                '          oRs = Nothing

                '          With origen.Registro
                '              .Fields("NumeroRecibo").Value = Val(txtNumeroRecibo.Text)
                '              .Fields("PuntoVenta").Value = IIf(Len(dcfields(10).Text) > 0, Val(dcfields(10).Text), 1)
                '              .Fields("Cotizacion").Value = mvarCotizacion
                '              If IsNull(.Fields("Efectivo").Value) Then
                '                  .Fields("Efectivo").Value = 0
                '              End If
                '              If IsNull(.Fields("Valores").Value) Then
                '                  .Fields("Valores").Value = 0
                '              End If
                '              If IsNull(.Fields("Documentos").Value) Then
                '                  .Fields("Documentos").Value = 0
                '              End If
                '              If IsNull(.Fields("RetencionGanancias").Value) Then
                '                  .Fields("RetencionGanancias").Value = 0
                '              End If
                '              If IsNull(.Fields("RetencionIBrutos").Value) Then
                '                  .Fields("RetencionIBrutos").Value = 0
                '              End If
                '              If IsNull(.Fields("RetencionIVA").Value) Then
                '                  .Fields("RetencionIVA").Value = 0
                '              End If
                '              If IsNull(.Fields("GastosGenerales").Value) Then
                '                  .Fields("GastosGenerales").Value = 0
                '              End If

                '              If Check1.Value = 1 Then
                '                  .Fields("Dolarizada").Value = "SI"
                '              Else
                '                  .Fields("Dolarizada").Value = "NO"
                '              End If

                '              For Each dtp In DTFields
                '                  .Fields(dtp.DataField).Value = dtp.Value
                '              Next

                '              For Each dc In dcfields
                '                  If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 3 And _
                '                        dc.Index <> 4 And dc.Index <> 5 And dc.Index <> 8 And dc.Index <> 10 And _
                '                        dc.Visible Then
                '                      MsgBox("Falta completar el campo " & dc.Tag, vbCritical)
                '                      Exit Function
                '                  End If
                '                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
                '              Next

                '              If Option1.Value Then
                '                  .Fields("Tipo").Value = "CC"
                '              Else
                '                  .Fields("Tipo").Value = "OT"
                '              End If

                '              If Check3.Value = 1 Then
                '                  .Fields("AsientoManual").Value = "SI"
                '              Else
                '                  .Fields("AsientoManual").Value = "NO"
                '              End If

                '              .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text

                '              If mvarId < 0 Then
                '                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                '                  .Fields("FechaIngreso").Value = Now
                '              Else
                '                  .Fields("IdUsuarioModifico").Value = glbIdUsuario
                '                  .Fields("FechaModifico").Value = Now
                '              End If

                '              .Fields("Observaciones").Value = rchObservaciones.Text

                '              If Option2.Value Then
                '                  .Fields("TipoOperacionOtros").Value = Combo1(0).ListIndex
                '              Else
                '                  .Fields("TipoOperacionOtros").Value = Null
                '              End If

                '              .Fields("CuitOpcional").Value = Null
                '              If CUIT1.Visible Then .Fields("CuitOpcional").Value = CUIT1.Text
                '          End With

                '          If mvarId < 0 Then
                '              Dim mvarNumero As Long
                '              Dim oPar 

                '              mvarNumero = origen.Registro.Fields("NumeroRecibo").Value

                '              oPar = Aplicacion.Parametros.Item(1)
                '              With oPar.Registro
                '                  If IsNull(.Fields("NumeroReciboPagoAutomatico").Value) Or .Fields("NumeroReciboPagoAutomatico").Value = "SI" Then
                '                  Else
                '                      oPar = Nothing
                '                      oRs = Aplicacion.Recibos.TraerFiltrado("_PorIdPuntoVenta_Numero", Array(dcfields(10).BoundText, mvarNumero))
                '                      If oRs.RecordCount > 0 Then
                '                          oRs.Close()
                '                          MsgBox("El recibo ya existe, verifique el numero")
                '                          Exit Function
                '                      End If
                '                      oRs.Close()
                '                  End If
                '              End With
                '              oPar = Nothing
                '          End If

            End With



            Return True
        End Function





        ''' <summary>
        ''' ' OJO: es el numero, no el ID del punto de venta. El recibo es letra X, no necesita el IdCodigoIVA
        ''' </summary>
        ''' <param name="SC"></param>
        ''' <param name="NumeroDePuntoVenta"></param>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Shared Function ProximoNumeroReciboPorNumeroDePuntoVenta(ByVal SC As String, ByVal NumeroDePuntoVenta As Integer) As Long

            Try
                ' la letra del recibo de pago es X

                'averiguo el id del talonario 
                Dim IdPuntoVenta = IdPuntoVentaComprobanteReciboSegunSubnumero(SC, NumeroDePuntoVenta)


                Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
                Return oPto.Item("ProximoNumero")
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                Return -1
            End Try

        End Function

        Shared Function IdPuntoVentaComprobanteReciboSegunSubnumero(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer) As Long
            Dim mvarPuntoVenta = EntidadManager.TablaSelectId(sc, "PuntosVenta", "PuntoVenta=" & NumeroDePuntoVenta & " AND Letra='X' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Recibo)
            Return mvarPuntoVenta
        End Function

        Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdRecibo As Long) As Integer

            Dim oRs As adodb.Recordset
            Dim UltItem As Integer



            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetRecibos", "TX_Req", IdRecibo))

            If oRs.RecordCount = 0 Then
                UltItem = 0
            Else
                oRs.MoveLast()
                UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
            End If

            oRs.Close()

            'oRs = Me.Registros

            If oRs.Fields.Count > 0 Then
                If oRs.RecordCount > 0 Then
                    oRs.MoveFirst()
                    While Not oRs.EOF
                        If Not oRs.Fields("Eliminado").Value Then
                            If oRs.Fields("NumeroItem").Value > UltItem Then
                                UltItem = oRs.Fields("NumeroItem").Value
                            End If
                        End If
                        oRs.MoveNext()
                    End While
                End If
            End If

            oRs = Nothing

            UltimoItemDetalle = UltItem + 1

        End Function

        Public Shared Function UltimoItemDetalle(ByVal myRecibo As Recibo) As Integer

            For Each i As ReciboItem In myRecibo.DetallesImputaciones
                'If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
            Next

        End Function


        Public Shared Sub RefrescaTalonarioIVA(ByRef myRecibo As Recibo)
            'myRecibo.letra=

            ' If glbIdCodigoIva = 1 Then
            '     Select Case mvarTipoIVA
            '         Case 1
            '             mvarTipoABC = "A"
            '             mvarIVA1 = Round(TSumaGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
            '         Case 2
            '             mvarTipoABC = "A"
            '             mvarIVA1 = Round(TSumaGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
            '             mvarIVA2 = Round(TSumaGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
            '         Case 3
            '             mvarTipoABC = "E"
            '         Case 8
            '             mvarTipoABC = "B"
            '         Case 9
            '             mvarTipoABC = "A"
            '         Case Else
            '             mvarTipoABC = "B"
            '     End Select
            ' Else
            '     mvarTipoABC = "C"
            ' End If

            'If .ctacte = 2 Then
            '    txtNumeroRecibo2.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaReciboInterna")
            'Else
            '    txtNumeroRecibo2.Text = ReciboManager.ProximoNumeroReciboPorIdCodigoIvaYNumeroDePuntoVenta(SC, cmbCondicionIVA.SelectedValue, cmbPuntoVenta.Text) 'ParametroOriginal(SC, "ProximoFactura")
            'End If
        End Sub





        Public Function GuardarRegistroContable(ByVal RegistroContable As adodb.Recordset)

            Dim oCont ' As ObjectContext
            Dim oDet 'As iCompMTS
            Dim Resp 'As InterFazMTS.MisEstados
            Dim oRsComprobante As adodb.Recordset
            Dim Datos As adodb.Recordset
            Dim DatosAsiento As adodb.Recordset
            Dim DatosAsientoNv As adodb.Recordset
            Dim oRsParametros As adodb.Recordset
            Dim DatosDetAsiento As adodb.Recordset
            Dim DatosDetAsientoNv As adodb.Recordset
            Dim oFld As adodb.Field
            Dim lErr As Long, sSource As String, sDesc As String
            Dim i As Integer
            Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdCuenta As Long
            Dim mvarCotizacionMoneda As Double, mvarDebe As Double, mvarHaber As Double

            On Error GoTo Mal

            'oCont = GetObjectContext

            oDet = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto

            mvarCotizacionMoneda = 0
            mvarDebe = 0
            mvarHaber = 0

            'With RegistroContable
            '    If .State <> adStateClosed Then
            '        If .RecordCount > 0 Then
            '            .Update()
            '            .MoveFirst()
            '            oRsComprobante = oDet.LeerUno("Recibos", RegistroContable.Fields("IdComprobante").Value)
            '            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
            '            oRsComprobante.Close()
            '            oRsComprobante = Nothing
            '        End If
            '        Do While Not .EOF
            '            If Not IsNull(.Fields("Debe").Value) Then
            '                .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
            '                .Update()
            '                mvarDebe = mvarDebe + .Fields("Debe").Value
            '            End If
            '            If Not IsNull(.Fields("Haber").Value) Then
            '                .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
            '                .Update()
            '                mvarHaber = mvarHaber + .Fields("Haber").Value
            '            End If
            '            .MoveNext()
            '        Loop
            '        If .RecordCount > 0 Then
            '            .MoveFirst()
            '            If mvarDebe - mvarHaber <> 0 Then
            '                If Not IsNull(.Fields("Debe").Value) Then
            '                    .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
            '                Else
            '                    .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
            '                End If
            '            End If
            '        End If
            '        Do While Not .EOF
            '            Datos = CreateObject("adodb.Recordset")
            '            For i = 0 To .Fields.Count - 1
            '                With .Fields(i)
            '                    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
            '                    Datos.Fields(.Name).Precision = .Precision
            '                    Datos.Fields(.Name).NumericScale = .NumericScale
            '                End With
            '            Next
            '            Datos.Open()
            '            Datos.AddNew()
            '            For i = 0 To .Fields.Count - 1
            '                With .Fields(i)
            '                    Datos.Fields(i).Value = .Value
            '                End With
            '            Next
            '            Datos.Update()
            '            Resp = oDet.Guardar("Subdiarios", Datos)
            '            Datos.Close()
            '            Datos = Nothing
            '            .MoveNext()
            '        Loop
            '    End If
            'End With

            If Not oCont Is Nothing Then
                With oCont
                    If .IsInTransaction Then .SetComplete()
                End With
            End If

Salir:
            GuardarRegistroContable = Resp
            oDet = Nothing
            oCont = Nothing
            On Error GoTo 0
            If lErr Then
                Err.Raise(lErr, sSource, sDesc)
            End If
            Exit Function

Mal:
            If Not oCont Is Nothing Then
                With oCont
                    If .IsInTransaction Then .SetAbort()
                End With
            End If
            With Err()
                lErr = .Number
                sSource = .Source
                sDesc = .Description
            End With
            Resume Salir

        End Function

        Private Shared Sub RecalcularRegistroContable_SubRecalculoAutomatico(ByVal SC As String, ByRef Recibo As Recibo, ByRef oRsCont As DataTable, _
                                        ByVal mvarCliente As Long, ByVal mvarCuentaClienteMonedaLocal As Long, _
                                        ByVal mvarCuentaClienteMonedaExtranjera As Long, _
                                        ByVal mvarEjercicio As Long, ByVal mvarCuentaCajaTitulo As Long, ByVal mvarCuentaCliente As Long)


            Dim oSrv 'As InterFazMTS.iCompMTS
            Dim oRs As DataRow
            Dim oRsDetCtas As adodb.Recordset
            Dim oRsAux As adodb.Recordset
            Dim oFld As adodb.Field
            Dim mvarCuentaCaja As Long
            Dim mvarCuentaValores As Long, mvarCuentaRetencionIva As Long
            Dim mvarCuentaRetencionGanancias As Long, mvarCuentaRetencionIBrutos As Long
            Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long
            Dim mvarCuentaReventas As Long, mvarCuentaDescuentos As Long
            Dim mvarCuentaDescuentosyRetenciones As Long, mvarCuenta As Long
            Dim mvarCuentaValoresTitulo As Long
            Dim mvarCuentaDescuentosyRetencionesTitulo As Long
            Dim mvarTotalValores As Double
            Dim mvarAux1 As Double, mvarAux2 As Double
            Dim mvarDetalleValor As String
            Dim mvarEsta As Boolean
            Dim mvarIdMonedaPesos As Integer
            Dim mvarTotalMonedaLocal As Double, mvarTotalMonedaExtranjera As Double

            oSrv = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto

            oRs = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
            mvarEjercicio = oRs.Item("EjercicioActual")
            mvarCuentaCaja = oRs.Item("IdCuentaCaja")
            mvarCuentaCajaTitulo = oRs.Item("IdCuentaCajaTitulo")
            mvarCuentaValores = oRs.Item("IdCuentaValores")
            mvarCuentaValoresTitulo = oRs.Item("IdCuentaValoresTitulo")
            mvarCuentaRetencionIva = oRs.Item("IdCuentaRetencionIva")
            mvarCuentaRetencionGanancias = oRs.Item("IdCuentaRetencionGananciasCobros")
            mvarCuentaRetencionIBrutos = oRs.Item("IdCuentaRetencionIBrutos")
            mvarCuentaDescuentos = oRs.Item("IdCuentaDescuentos")
            mvarCuentaDescuentosyRetenciones = oRs.Item("IdCuentaDescuentosyRetenciones")
            mvarCuentaDescuentosyRetencionesTitulo = oRs.Item("IdCuentaDescuentosyRetencionesTitulo")
            mvarIdMonedaPesos = oRs.Item("IdMoneda")
            'oRs.Close()

            'sub que es llamado por RecalcularRegistroContable
            'separado solo para hacer mas claro el codigo

            'recalculo automatico, aplica restricciones


            Dim oRsDet As adodb.Recordset
            Dim oRsDetBD As DataTable


            With Recibo




                If Not IsNull(.Efectivo) Then
                    If .Efectivo <> 0 Then
                        With oRsCont
                            Dim dr As DataRow = .NewRow()
                            With dr
                                .Item("Ejercicio") = mvarEjercicio
                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                .Item("IdCuenta") = mvarCuentaCaja
                                .Item("IdTipoComprobante") = 2
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .Item("IdComprobante") = Recibo.Id
                                .Item("Debe") = Recibo.Efectivo
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda ") = Recibo.CotizacionMoneda
                            End With
                            .Rows.Add(dr)
                        End With
                        mvarCliente = mvarCliente + .Efectivo
                    End If
                End If


                If Not IsNull(.Descuentos) Then
                    If .Descuentos <> 0 Then
                        With oRsCont
                            Dim dr As DataRow = .NewRow()
                            With dr
                                .Item("Ejercicio") = mvarEjercicio
                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                .Item("IdCuenta") = mvarCuentaDescuentos
                                .Item("IdTipoComprobante") = 2
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .Item("IdComprobante") = Recibo.Id
                                If Recibo.Descuentos > 0 Then
                                    .Item("Debe") = Recibo.Descuentos
                                Else
                                    .Item("Haber") = Math.Abs(Recibo.Descuentos)
                                End If
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                            End With
                            .Rows.Add(dr)
                        End With
                        If .Descuentos > 0 Then
                            mvarCliente = mvarCliente + .Descuentos
                        Else
                            mvarCliente = mvarCliente - .Descuentos
                        End If

                    End If
                End If


                If Not IsNull(.RetencionIVA) Then
                    If .RetencionIVA <> 0 Then
                        With oRsCont
                            Dim dr As DataRow = .NewRow()
                            With dr
                                .Item("Ejercicio") = mvarEjercicio
                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                .Item("IdCuenta") = mvarCuentaRetencionIva
                                .Item("IdTipoComprobante") = 2
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .Item("IdComprobante") = Recibo.Id
                                If Recibo.RetencionIVA > 0 Then
                                    .Item("Debe") = Recibo.RetencionIVA
                                Else
                                    .Item("Haber") = Math.Abs(Recibo.RetencionIVA)
                                End If
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                            End With
                            .Rows.Add(dr)

                        End With
                        If .RetencionIVA > 0 Then
                            mvarCliente = mvarCliente + .RetencionIVA
                        Else
                            mvarCliente = mvarCliente - .RetencionIVA
                        End If
                    End If
                End If



                If Not IsNull(.RetencionGanancias) Then
                    If .RetencionGanancias <> 0 Then
                        With oRsCont
                            Dim dr As DataRow = .NewRow
                            With dr
                                .Item("Ejercicio") = mvarEjercicio
                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                .Item("IdCuenta") = mvarCuentaRetencionGanancias
                                .Item("IdTipoComprobante") = 2
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .Item("IdComprobante") = Recibo.Id
                                If Recibo.RetencionGanancias > 0 Then
                                    .Item("Debe") = Recibo.RetencionGanancias
                                Else
                                    .Item("Haber") = Math.Abs(Recibo.RetencionGanancias)
                                End If
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                            End With
                            .Rows.Add(dr)
                        End With
                        If .RetencionGanancias > 0 Then
                            mvarCliente = mvarCliente + .RetencionGanancias
                        Else
                            mvarCliente = mvarCliente - .RetencionGanancias
                        End If
                    End If
                End If

                If Not IsNull(.RetencionIBrutos) Then
                    If .RetencionIBrutos <> 0 Then
                        With oRsCont
                            Dim dr As DataRow = .NewRow
                            With dr
                                .Item("Ejercicio") = mvarEjercicio
                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                .Item("IdCuenta") = mvarCuentaRetencionIBrutos
                                .Item("IdTipoComprobante") = 2
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .Item("IdComprobante") = Recibo.Id
                                If Recibo.RetencionIBrutos > 0 Then
                                    .Item("Debe") = Recibo.RetencionIBrutos
                                Else
                                    .Item("Haber") = Math.Abs(Recibo.RetencionIBrutos)
                                End If
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                            End With
                            .Rows.Add(dr)

                        End With
                        If .RetencionIBrutos > 0 Then
                            mvarCliente = mvarCliente + .RetencionIBrutos
                        Else
                            mvarCliente = mvarCliente - .RetencionIBrutos
                        End If
                    End If
                End If



                '/////////////////////////////////////////////////
                '/////////////////////////////////////////////////
                'para "Otros Conceptos"
                '/////////////////////////////////////////////////
                '/////////////////////////////////////////////////

                'For i = 1 To 10
                '    If Not IsNull(.Otros & i).Value) Then
                '        If .Otros" & i).Value <> 0 Then
                '            With oRsCont
                '                . Dim dr = .NewRow()      with dr()
                '                .item("Ejercicio = mvarEjercicio
                '                .item("IdCuentaSubdiario = mvarCuentaCajaTitulo
                '                .item("IdCuenta = .IdCuenta" & i).Value()
                '                .item("IdTipoComprobante = 2
                '                .item("NumeroComprobante = .NumeroRecibo
                '                .item("FechaComprobante = .FechaRecibo
                '                .item("IdComprobante = Registro.Fields(0).Value
                '                If .Otros" & i).Value > 0 Then
                '                    .item("Debe = .Otros" & i).Value()
                '                Else
                '                    .item("Haber = Abs(.Otros" & i).Value)
                '                End If
                '                .item("IdMoneda = .IdMoneda
                '                .item("CotizacionMoneda = .CotizacionMoneda
                '                 End With    .Rows.Add(dr)
                '                If .Otros" & i).Value > 0 Then
                '                    mvarCliente = mvarCliente + .Otros" & i).Value
                '                Else
                '                    mvarCliente = mvarCliente - .Otros" & i).Value
                '                End If
                '            End With
                '        End If
                '    End If
                'Next
                '/////////////////////////////////////////////////
                '/////////////////////////////////////////////////
                '/////////////////////////////////////////////////




                '//////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////

                mvarTotalValores = 0


                For Each i As ReciboValoresItem In .DetallesValores
                    With i
                        If Not .Eliminado Then




                            mvarTotalValores = mvarTotalValores + .Importe
                            If Not IsNull(.NumeroInterno) Then
                                mvarDetalleValor = "Ch." & .NumeroValor & " [" & .NumeroInterno & "] Vto.:" & .FechaVencimiento
                            ElseIf Not IsNull(.NumeroTransferencia) Then
                                mvarDetalleValor = "Transf." & .NumeroTransferencia
                            End If
                            mvarCuenta = mvarCuentaValores


                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////
                            'se fija qué tipo de cuenta es
                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////



                            If Not IsNull(IdNull(.IdCuenta)) Then
                                mvarCuenta = .IdCuenta
                            ElseIf Not IsNull(IdNull(.IdCaja)) Then
                                Dim dr = EntidadManager.LeerUno(SC, EntidadManager.enumTablas.Cajas, .IdCaja)
                                If Not IsNull(dr.Item("IdCuenta")) Then
                                    mvarCuenta = dr.Item("IdCuenta")
                                End If
                            ElseIf Not IsNull(IdNull(.IdTarjetaCredito)) Then
                                Dim dr = EntidadManager.LeerUno(SC, EntidadManager.enumTablas.TarjetasCredito, .IdTarjetaCredito)
                                If Not IsNull(dr.Item("IdCuenta")) Then
                                    mvarCuenta = dr.Item("IdCuenta")

                                End If
                                oRsAux.Close()
                                oRsAux = Nothing
                            Else
                                'Continue For 'no, porque si es distinto, usa el mvarcuentavalores que asignó antes
                            End If

                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////


                            With oRsCont
                                Dim dr As DataRow = .NewRow()
                                With dr
                                    .Item("Ejercicio") = mvarEjercicio
                                    .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                    .Item("IdCuenta") = mvarCuenta
                                    .Item("IdTipoComprobante") = 2
                                    .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                    .Item("FechaComprobante") = Recibo.FechaRecibo
                                    .Item("Detalle") = mvarDetalleValor
                                    .Item("IdComprobante") = Recibo.Id
                                    .Item("Debe") = i.Importe
                                    .Item("IdMoneda") = Recibo.IdMoneda
                                    .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                                End With
                                .Rows.Add(dr)
                            End With


                        End If
                    End With
                Next







                '//////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////
                'aparentenmente los compara con el original, no?
                '//////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////

                oRsDetBD = EntidadManager.GetListTX(SC, "DetRecibosValores", "TX_PorIdCabecera", Recibo.Id).Tables(0)

                For Each draux As DataRow In oRsDetBD.Rows
                    With draux


                        mvarEsta = False

                        For Each i As ReciboValoresItem In Recibo.DetallesValores
                            If i.Eliminado Then Continue For

                            If .Item(0) = i.Id Then
                                mvarEsta = True
                                Exit For
                            End If
                        Next



                        If Not mvarEsta Then
                            mvarTotalValores = mvarTotalValores + .Item("Importe")




                            If Not IsNull(.Item("NumeroInterno")) Then
                                mvarDetalleValor = "Ch." & .Item("NumeroValor") & " [" & .Item("NumeroInterno") & "] Vto.:" & .Item("FechaVencimiento")
                            ElseIf Not IsNull(.Item("NumeroTransferencia")) Then
                                mvarDetalleValor = "Transf." & .Item("NumeroTransferencia")
                            End If
                            mvarCuenta = mvarCuentaValores





                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////
                            'se fija qué tipo de cuenta es
                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////

                            If Not IsNull(.Item("IdCuenta")) Then
                                mvarCuenta = .Item("IdCuenta")
                            ElseIf Not IsNull(.Item("IdCaja")) Then

                                Dim dr = EntidadManager.LeerUno(SC, EntidadManager.enumTablas.Cajas, .Item("IdCaja"))
                                If Not IsNull(dr.Item("IdCuenta")) Then
                                    mvarCuenta = dr.Item("IdCuenta")
                                End If

                            ElseIf Not IsNull(.Item("IdTarjetaCredito")) Then

                                Dim dr = EntidadManager.LeerUno(SC, EntidadManager.enumTablas.TarjetasCredito, .Item("IdTarjetaCredito"))
                                If Not IsNull(dr.Item("IdCuenta")) Then
                                    mvarCuenta = dr.Item("IdCuenta")
                                End If

                            End If



                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////////



                            With oRsCont
                                Dim dr As DataRow = .NewRow()
                                With dr
                                    .Item("Ejercicio") = mvarEjercicio
                                    .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                    .Item("IdCuenta") = mvarCuenta
                                    .Item("IdTipoComprobante") = 2
                                    .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                    .Item("FechaComprobante") = Recibo.FechaRecibo
                                    .Item("Detalle") = mvarDetalleValor
                                    .Item("IdComprobante") = Recibo.Id
                                    .Item("Debe") = draux.Item("Importe")
                                    .Item("IdMoneda") = Recibo.IdMoneda
                                    .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                                End With
                                .Rows.Add(dr)
                            End With



                        End If


                    End With

                Next










                '/////////////////////////////////////////////////////////////////////////////
                'IMPUTACIONES
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                'cómo lo arma dependiendo de si hay moneda extranjera o tomar cotizacion
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////

                mvarCliente = mvarCliente + mvarTotalValores
                mvarTotalMonedaLocal = 0
                mvarTotalMonedaExtranjera = 0


                If mvarCuentaClienteMonedaLocal = 0 Or mvarCuentaClienteMonedaExtranjera = 0 Then
                    '/////////////////////////////////////////////////////////////////////////////
                    'Creo que acá se mete si es "a Cuentas" (la grilla de imputaciones no se ve)
                    '/////////////////////////////////////////////////////////////////////////////

                    With oRsCont
                        Dim dr As DataRow = .NewRow()
                        With dr
                            .Item("Ejercicio") = mvarEjercicio
                            .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                            .Item("IdCuenta") = mvarCuentaCliente
                            .Item("IdTipoComprobante") = 2
                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
                            .Item("FechaComprobante") = Recibo.FechaRecibo
                            .Item("IdComprobante") = Recibo.Id
                            If mvarCliente > 0 Then
                                .Item("Haber") = mvarCliente
                            Else
                                .Item("Debe") = mvarCliente * -1
                            End If
                            .Item("IdMoneda") = Recibo.IdMoneda
                            .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                        End With
                        .Rows.Add(dr)
                    End With


                Else

                    '/////////////////////////////////////////////////////////////////////////////
                    'acá vienen las imputaciones
                    '/////////////////////////////////////////////////////////////////////////////


                    For Each i As ReciboItem In Recibo.DetallesImputaciones
                        If i.Eliminado Then Continue For

                        If i.IdImputacion <= 0 Then
                            mvarTotalMonedaLocal = mvarTotalMonedaLocal + i.Importe
                        Else
                            Dim dt As DataTable = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion)
                            If dt.Rows.Count > 0 Then
                                If dt.Rows(0).Item("IdMoneda") = mvarIdMonedaPesos Then
                                    mvarTotalMonedaLocal = mvarTotalMonedaLocal + i.Importe
                                Else
                                    mvarTotalMonedaExtranjera = mvarTotalMonedaExtranjera + i.Importe
                                End If
                            Else
                                mvarTotalMonedaLocal = mvarTotalMonedaLocal + i.Importe
                            End If

                        End If
                    Next






                    mvarAux1 = mvarTotalMonedaLocal
                    mvarAux2 = mvarTotalMonedaExtranjera

                    If mvarAux1 <> 0 Then
                        With oRsCont
                            Dim dr As DataRow = .NewRow()
                            With dr
                                .Item("Ejercicio") = mvarEjercicio
                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                .Item("IdCuenta") = mvarCuentaClienteMonedaLocal
                                .Item("IdTipoComprobante") = 2
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .Item("IdComprobante") = Recibo.Id
                                If mvarAux1 > 0 Then
                                    .Item("Haber") = mvarAux1
                                Else
                                    .Item("Debe") = mvarAux1 * -1
                                End If
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                            End With
                            .Rows.Add(dr)
                        End With
                    End If


                    If mvarAux2 <> 0 Then
                        With oRsCont
                            Dim dr As DataRow = .NewRow()
                            With dr
                                .Item("Ejercicio") = mvarEjercicio
                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                .Item("IdCuenta") = mvarCuentaClienteMonedaExtranjera
                                .Item("IdTipoComprobante") = 2
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .Item("IdComprobante") = Recibo.Id
                                If mvarAux2 > 0 Then
                                    .Item("Haber") = mvarAux2
                                Else
                                    .Item("Debe") = mvarAux2 * -1
                                End If
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
                            End With
                            .Rows.Add(dr)
                        End With
                    End If



                End If




            End With




        End Sub

        Public Shared Function RecalcularRegistroContable(ByVal SC As String, ByRef Recibo As Recibo) As DataTable

            Dim oRsCont As DataTable
            Dim mvarEjercicio As Long, mvarCuentaCajaTitulo As Long
            Dim mvarCuentaClienteMonedaLocal As Long, mvarCuentaClienteMonedaExtranjera As Long
            Dim mvarCliente As Double
            Dim mvarCuentaCliente As Long

            IsValid(SC, Recibo) 'para marcar los vacios

            mvarCuentaClienteMonedaLocal = 0
            mvarCuentaClienteMonedaExtranjera = 0
            mvarCliente = 0

            With Recibo

                '//////////////////////////////////
                'no sé qué hace con el cliente 
                '-Dependiendo si el recibo es a Cliente o a Cuenta, asigna las cuentas de moneda
                '//////////////////////////////////

                If Not IsNull(.IdCliente) And .IdCliente > 0 And .Tipo = BO.Recibo.tipoRecibo.CC Then
                    'Recibo normal a Cliente

                    Dim oCli = ClienteManager.GetItem(SC, .IdCliente)
                    mvarCuentaCliente = oCli.IdCuenta
                    mvarCuentaClienteMonedaLocal = oCli.IdCuenta
                    If Not oCli.idcuentaMonedaExt Then
                        mvarCuentaClienteMonedaExtranjera = oCli.idcuentaMonedaExt
                    End If

                Else
                    'Recibo a Cuentas

                    mvarCuentaCliente = .IdCuenta
                    mvarCuentaClienteMonedaLocal = .IdCuenta
                End If

                '//////////////////////////////////
                '//////////////////////////////////




                '//////////////////////////////////
                'trae el formato de un subdiario
                '//////////////////////////////////

                oRsCont = EntidadManager.GetListTX(SC, "Subdiarios", "TX_Estructura").Tables(0)

                oRsCont.Rows.Clear()


                If Not IsNull(.AsientoManual) And .AsientoManual = "SI" Then

                    'Recalculo de edicion manual

                    For Each i As ReciboCuentasItem In .DetallesCuentas
                        If i.Eliminado Then Continue For

                        With oRsCont
                            Dim dr = .NewRow()
                            With dr

                                .item("Ejercicio") = mvarEjercicio
                                .item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
                                .item("IdCuenta") = i.IdCuenta
                                .item("IdTipoComprobante") = 2
                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
                                .Item("FechaComprobante") = Recibo.FechaRecibo
                                .item("IdComprobante") = Recibo.Id
                                If Not IsNull(i.Debe) Then
                                    .item("Debe") = i.Debe
                                End If
                                If Not IsNull(i.Haber) Then
                                    .item("Haber") = i.Haber
                                End If
                                .Item("IdMoneda") = Recibo.IdMoneda
                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda

                            End With
                            .Rows.Add(dr)
                        End With
                    Next

                Else

                    'recalculo automatico, aplica restricciones

                    RecalcularRegistroContable_SubRecalculoAutomatico(SC, Recibo, oRsCont, mvarCliente, mvarCuentaClienteMonedaLocal, mvarCuentaClienteMonedaExtranjera, mvarEjercicio, mvarCuentaCajaTitulo, mvarCuentaCliente)
                End If


            End With
            '/////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////






            Return oRsCont


        End Function














        Public Shared Sub RecalcularTotales(ByRef myRecibo As Recibo)

            Dim mvarSubTotal, mvarIVA1 As Single

            With myRecibo


                RefrescaTalonarioIVA(myRecibo)




                Dim i As Integer
                Dim oRs As adodb.Recordset

                myRecibo.TotalImputaciones = 0
                myRecibo.TotalDebe = 0
                myRecibo.TotalHaber = 0
                myRecibo.TotalValores = 0
                myRecibo.TotalRubrosContables = 0
                myRecibo.TotalOtrosConceptos = 0
                myRecibo.TotalAnticipos = 0




                If .Tipo = Recibo.tipoRecibo.CC Then
                    'tipo de recibo: cliente
                    For Each det As ReciboItem In .DetallesImputaciones

                        With det
                            If .Eliminado Then Continue For
                            myRecibo.TotalImputaciones += .Importe
                        End With
                    Next

                ElseIf .Tipo = Recibo.tipoRecibo.OT Then
                    'tipo de recibo: otros
                    For Each det As ReciboAnticiposAlPersonalItem In .DetallesAnticiposAlPersonal
                        With det
                            If .Eliminado Then Continue For
                            myRecibo.TotalAnticipos += .ImporteTotalItem
                        End With
                    Next
                End If



                For Each det As ReciboValoresItem In .DetallesValores
                    With det
                        If .Eliminado Then Continue For
                        myRecibo.TotalValores += .Importe
                    End With
                Next


                For Each det As ReciboCuentasItem In .DetallesCuentas
                    With det

                        If .Eliminado Then Continue For

                        myRecibo.TotalDebe += .Debe


                        myRecibo.TotalHaber += .Haber

                    End With
                Next



                For Each det As ReciboRubrosContablesItem In .DetallesRubrosContables
                    With det
                        If .Eliminado Then Continue For

                        myRecibo.TotalRubrosContables += .Importe
                    End With
                Next



                .TotalOtrosConceptos = .Otros1 + .Otros2 + .Otros3 + .Otros4 + .Otros5 + _
                                       .Otros6 + .Otros7 + .Otros8 + .Otros9 + .Otros10
                'With origen.Registro
                '    For i = 1 To 10
                '        mvarTotalOtrosConceptos = mvarTotalOtrosConceptos + _
                '              IIf(IsNull(.Fields("Otros" & i).Value), 0, .Fields("Otros" & i).Value)
                '    Next
                'End With



                .TotalDiferencia = Math.Round(.TotalImputaciones - (.TotalValores + .Efectivo + .RetencionIVA + .RetencionGanancias + .TotalOtrosConceptos), 2)

                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////







            End With
        End Sub

        Sub refrescar()
            '    RefrescarNumeroTalonario()
            '    refrescartotales()
            '    refrescarRegistroContable()
        End Sub


        Public Shared Sub AgregarImputacionSinAplicacionOPagoAnticipado(ByRef myRecibo As Recibo)

            With myRecibo
                'If mvarId > 0 Then
                '    MsgBox("No puede modificar una nota de credito ya registrada!", vbCritical)
                '    Exit Sub
                'End If

                'If Len(Trim(dcfields(0).BoundText)) = 0 Then
                '    MsgBox("Falta completar el campo cliente", vbCritical)
                '    Exit Sub
                'End If

                'If Len(Trim(txtNumeroNotaCredito.Text)) = 0 Then
                '    MsgBox("Falta completar el campo numero de nota de credito", vbCritical)
                '    Exit Sub
                'End If


                Dim oRs As adodb.Recordset
                Dim mvarDif As Double

                RecalcularTotales(myRecibo)
                mvarDif = Math.Round(.TotalValores - .TotalImputaciones, 2)

                If mvarDif > 0 Then
                    Dim mItemImp As ReciboItem = New ReciboItem
                    mItemImp.Id = -1
                    mItemImp.Nuevo = True
                    mItemImp.IdImputacion = -1
                    mItemImp.ComprobanteImputadoNumeroConDescripcionCompleta = "PA"
                    mItemImp.Importe = mvarDif
                    mvarDif = 0
                    .DetallesImputaciones.Add(mItemImp)
                End If

                RecalcularTotales(myRecibo)
            End With
        End Sub


        Public Shared Function FaltanteDePagar(ByRef myRecibo As Recibo) As Double

            With myRecibo
                Dim mvarDif As Double

                RecalcularTotales(myRecibo)
                mvarDif = Math.Round(.TotalImputaciones - .TotalValores, 2)
                If mvarDif < 0 Then mvarDif = 0
                Return mvarDif

            End With
        End Function

    End Class
End Namespace