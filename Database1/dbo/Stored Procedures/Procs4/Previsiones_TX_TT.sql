CREATE Procedure [dbo].[Previsiones_TX_TT]

@IdPrevision int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111133'
SET @vector_T='02422324352242400'

SELECT 
 Previsiones.IdPrevision as [IdPrevision],
 Previsiones.Numero as [Numero],
 Previsiones.Fecha as [Fecha],
 RubrosContables.Descripcion as [Rubro financiero],
 Bancos.Nombre as [Banco],
 Case When IsNull(TipoMovimiento,'I')='I' Then 'Ingreso' Else 'Egreso' End as [Tipo mov.],
 Previsiones.Importe as [Importe],
 Previsiones.FechaCaducidad as [Fecha caducidad],
 Obras.Descripcion as [Obra],
 Previsiones.PostergarFechaCaducidad as [Post. fecha caducidad],
 Previsiones.Observaciones as [Observaciones],
 E1.Nombre as [Usuario ingreso],
 Previsiones.FechaIngreso as [Fecha ingreso],
 E2.Nombre as [Usuario modifico],
 Previsiones.FechaModifico as [Fecha modificacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Previsiones
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Previsiones.IdRubroFinanciero
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Previsiones.IdBanco
LEFT OUTER JOIN Obras ON Obras.IdObra=Previsiones.IdObra
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Previsiones.IdUsuarioIngreso
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Previsiones.IdUsuarioModifico
WHERE (Previsiones.IdPrevision=@IdPrevision)