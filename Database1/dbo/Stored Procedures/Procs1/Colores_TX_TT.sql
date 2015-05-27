CREATE Procedure [dbo].[Colores_TX_TT]

@IdColor int

AS 

DECLARE @TablaColoresAmpliada varchar(2), @SistemaVentasPorTalle varchar(2), @vector_X varchar(30), @vector_T varchar(30)

SET @TablaColoresAmpliada=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Tabla de colores ampliada' and IsNull(ProntoIni.Valor,'')='SI'),'')
SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

IF @TablaColoresAmpliada='SI'
    BEGIN
	SET @vector_X='01111166133'
	SET @vector_T='02770044300'

	SELECT 
	 Colores.IdColor,
	 Substring('000000',1,6-Len(Convert(varchar,IsNull(Colores.Codigo,0))))+
		Convert(varchar,IsNull(Colores.Codigo,0))+' '+IsNull(Colores.Codigo1,'') as [Codigo],
	 Colores.Descripcion as [Color],
	 Articulos.Descripcion as [Articulo para el que se desarrollo],
	 Clientes.RazonSocial as [Cliente para el que se desarrollo],
	 Vendedores.Nombre as [Vendedor],
	 @Vector_T as [Vector_T],
	 @Vector_X as [Vector_X]
	FROM Colores 
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Colores.IdArticulo
	LEFT OUTER JOIN Clientes ON Clientes.IdCliente = Colores.IdCliente
	LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor = Colores.IdVendedor
	WHERE Colores.IdColor=@IdColor
    END
ELSE
    BEGIN
	SET @vector_X='01133'
	IF @SistemaVentasPorTalle='SI'
		SET @vector_T='05500'
	ELSE
		SET @vector_T='05900'

	SELECT 
	 IdColor,
	 Descripcion as [Color],
	 Codigo2 as [Codigo],
	 @Vector_T as [Vector_T],
	 @Vector_X as [Vector_X]
	FROM Colores 
	WHERE IdColor=@IdColor
    END