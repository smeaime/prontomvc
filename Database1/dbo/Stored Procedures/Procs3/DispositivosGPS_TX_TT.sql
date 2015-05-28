
CREATE Procedure [dbo].[DispositivosGPS_TX_TT]

@IdDispositivoGPS int

AS 

DECLARE @vector_X varchar(30), @vector_T varchar(30)
SET @vector_X='01133'
SET @vector_T='02400'

SELECT 
 IdDispositivoGPS,
 Descripcion as [Descripcion],
 Case When IsNull(Destino,'')='C' Then 'CARGA'
	When IsNull(Destino,'')='D' Then 'DESCARGA'
	When IsNull(Destino,'')='I' Then 'INSTALADO'
	Else 'S/D'
 End as [Destino],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DispositivosGPS
WHERE (IdDispositivoGPS=@IdDispositivoGPS)
