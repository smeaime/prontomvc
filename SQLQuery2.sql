
CREATE NONCLUSTERED INDEX IDX_CartasDePorte_FechaDescarga
ON [dbo].[CartasDePorte] ([FechaDescarga])
INCLUDE ([NumeroCartaDePorte],[Anulada],[Vendedor],[CuentaOrden1],[CuentaOrden2],[Corredor],[Entregador],
[Procedencia],[Patente],[IdArticulo],[NetoProc],[NetoFinal],[Contrato],[Destino],[IdFacturaImputada],[PuntoVenta],
[SubnumeroVagon],[FechaArribo],[Corredor2],[SubnumeroDeFacturacion],[IdClienteAuxiliar],[Acopio1],[Acopio2],[Acopio3],[Acopio4],[Acopio5],[Acopio6])
GO
