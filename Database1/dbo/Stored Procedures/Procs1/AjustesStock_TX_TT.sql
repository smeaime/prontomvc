CREATE  Procedure [dbo].[AjustesStock_TX_TT]

@IdAjusteStock int,
@TipoAjuste varchar(1) = Null

AS 

SET @TipoAjuste=IsNull(@TipoAjuste,'*')

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111133'
SET @vector_T='0343511133151533100'

SELECT 
 AjustesStock.IdAjusteStock,
 AjustesStock.NumeroAjusteStock as Numero,
 AjustesStock.FechaAjuste as Fecha,
 AjustesStock.NumeroMarbete as Marbete,
 Case When IsNull(AjustesStock.TipoAjuste,'N')='N' Then 'Ajuste normal' When IsNull(AjustesStock.TipoAjuste,'N')='I' Then'Inventario' When IsNull(AjustesStock.TipoAjuste,'N')='P' Then'Produccion' Else Null End as [Tipo de ajuste],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 E1.Nombre as [Realizada por],
 E2.Nombre as [Liberada por],
 (Select Count(*) From  DetalleAjustesStock Where DetalleAjustesStock.IdAjusteStock=AjustesStock.IdAjusteStock) as [Cant.Items],
 AjustesStock.Observaciones as [Observaciones],
 E3.Nombre as [Ingreso],
 AjustesStock.FechaIngreso as [Fecha ingreso],
 E4.Nombre as [Modifico],
 AjustesStock.FechaModifico as [Fecha modifico],
 (Select Top 1 Substring('0000',1,4-Len(Convert(varchar,RecepcionesSAT.NumeroRecepcion1)))+Convert(varchar,RecepcionesSAT.NumeroRecepcion1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,RecepcionesSAT.NumeroRecepcion2)))+Convert(varchar,RecepcionesSAT.NumeroRecepcion2)
  From RecepcionesSAT 
  Where AjustesStock.IdRecepcionSAT=RecepcionesSAT.IdRecepcion) as [Recepcion SAT],
 AjustesStock.ArchivoAdjunto1 as [Archivo adjunto 1],
 AjustesStock.ArchivoAdjunto2 as [Archivo adjunto 2],
 dbo.AjustesStock_SolicitudesDeMateriales(AjustesStock.IdAjusteStock)as [Solicitudes de materiales],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AjustesStock
LEFT OUTER JOIN ArchivosATransmitirDestinos ON AjustesStock.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Empleados E1 ON AjustesStock.IdRealizo = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON AjustesStock.IdAprobo = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON AjustesStock.IdUsuarioIngreso = E3.IdEmpleado
LEFT OUTER JOIN Empleados E4 ON AjustesStock.IdUsuarioModifico = E4.IdEmpleado
WHERE IdAjusteStock=@IdAjusteStock and 
	((@TipoAjuste='*' and (IsNull(AjustesStock.TipoAjuste,'N')='N' or IsNull(AjustesStock.TipoAjuste,'N')='I' or IsNull(AjustesStock.TipoAjuste,'N')='P')) or @TipoAjuste=IsNull(AjustesStock.TipoAjuste,'N'))