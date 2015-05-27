CREATE Procedure [dbo].[Obras_TX_ActivasConDatos]

@Orden varchar(1)  = Null

AS 

SET @Orden=IsNull(@Orden,'N')

DECLARE @ObrasADescartar varchar(2000)

SET @ObrasADescartar=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Obras a descartar en informe de analisis de contribucion'),'')

IF @Orden='N'
	SELECT 
	 Obras.*,
	 CASE WHEN TipoObra=1 THEN 'Taller' WHEN TipoObra=2 THEN 'Montaje' WHEN TipoObra=3 THEN 'Servicio' ELSE Null END as [TipoObra],
	 Obras.Descripcion as [Obra],
	 Clientes.RazonSocial as [Cliente],
	 UnidadesOperativas.Descripcion as [UnidadOperativa],
	 Empleados.Nombre as [Jefe de obra]
	FROM Obras
	LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
	LEFT OUTER JOIN Empleados ON Obras.IdJefe = Empleados.IdEmpleado
	LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
	WHERE Obras.Activa='SI' and Patindex('%('+Obras.NumeroObra+')%', @ObrasADescartar)=0
	ORDER BY Obras.NumeroObra
ELSE
	SELECT 
	 Obras.*,
	 CASE WHEN TipoObra=1 THEN 'Taller' WHEN TipoObra=2 THEN 'Montaje' WHEN TipoObra=3 THEN 'Servicio' ELSE Null END as [TipoObra],
	 Obras.Descripcion as [Obra],
	 Clientes.RazonSocial as [Cliente],
	 UnidadesOperativas.Descripcion as [UnidadOperativa],
	 Empleados.Nombre as [Jefe de obra]
	FROM Obras
	LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
	LEFT OUTER JOIN Empleados ON Obras.IdJefe = Empleados.IdEmpleado
	LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
	WHERE Obras.Activa='SI' and Patindex('%('+Obras.NumeroObra+')%', @ObrasADescartar)=0
	ORDER BY Obras.OrdenamientoSecundario, Obras.NumeroObra