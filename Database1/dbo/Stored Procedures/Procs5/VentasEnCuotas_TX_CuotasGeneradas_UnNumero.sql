






CREATE Procedure [dbo].[VentasEnCuotas_TX_CuotasGeneradas_UnNumero]

@NumeroGeneracion int

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111133'
Set @vector_T='05555555500'

SELECT DISTINCT 
 DetVta.NumeroGeneracion as [IdNro],
 DetVta.NumeroGeneracion as [Nro.Generacion],
 DetVta.FechaGeneracion as [Fecha Generacion],
 DetVta.FechaPrimerVencimiento as [Fecha 1er.Vto.],
 DetVta.FechaSegundoVencimiento as [Fecha 2do.Vto.],
 DetVta.FechaTercerVencimiento as [Fecha 3er.Vto.],
 DetVta.InteresPrimerVencimiento as [% Interes 1er.Vto.],
 DetVta.InteresSegundoVencimiento as [% Interes 1er.Vto.],
 Bancos.Nombre as [Ente Recaudador],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleVentasEnCuotas DetVta
LEFT OUTER JOIN VentasEnCuotas vec ON vec.IdVentaEnCuotas=DetVta.IdVentaEnCuotas
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetVta.IdBanco
WHERE DetVta.NumeroGeneracion=@NumeroGeneracion
ORDER by DetVta.FechaGeneracion,DetVta.NumeroGeneracion






