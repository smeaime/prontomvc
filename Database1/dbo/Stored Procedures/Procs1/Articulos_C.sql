
CREATE PROCEDURE [dbo].[Articulos_C]
@codigo varchar(50),
@idRubro integer,
@Descripcion varchar(100)
 AS
if @codigo >'0'
BEGIN
SELECT 
Articulos.IdArticulo,
Articulos.Descripcion,
Articulos.IdCodigo, 
Articulos.Codigo,
Articulos.IdInventario,
Articulos.NumeroInventario,
Articulos.IdRubro,
Articulos.IdUnidad,
Articulos.AlicuotaIVA,
Articulos.CostoPPP,
Articulos.CostoPPPDolar,
Articulos.CostoReposicion,
Articulos.CostoReposicionDolar,
Articulos.Observaciones,
Articulos.IdSubrubro,
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],
 (Select Top 1 Unidades.Abreviatura From Unidades Where Articulos.IdUnidad=Unidades.IdUnidad) as [Un],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Unidades.Abreviatura as [Unidad]
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
WHERE IsNull(Articulos.Activo,'')<>'NO' 
and Articulos.Codigo = @codigo
END 
ELSE IF @Descripcion = '' 
BEGIN
SELECT TOP 250
Articulos.IdArticulo,
Articulos.Descripcion,
Articulos.IdCodigo, 
Articulos.Codigo,
Articulos.IdInventario,
Articulos.NumeroInventario,
Articulos.IdRubro,
Articulos.IdUnidad,
Articulos.AlicuotaIVA,
Articulos.CostoPPP,
Articulos.CostoPPPDolar,
Articulos.CostoReposicion,
Articulos.CostoReposicionDolar,
Articulos.Observaciones,
Articulos.IdSubrubro,
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],
 (Select Top 1 Unidades.Abreviatura From Unidades Where Articulos.IdUnidad=Unidades.IdUnidad) as [Un],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Unidades.Abreviatura as [Unidad]
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
WHERE IsNull(Articulos.Activo,'')<>'NO' 
and Articulos.IdRubro = @IdRubro
ORDER by Rubros.Descripcion,Subrubros.Descripcion,Articulos.Codigo
END ELSE BEGIN

declare @substring varchar (50)
declare @sentence varchar (4000)
declare @i int
set @sentence = ''

set @i = 0

WHILE (CHARINDEX(' ',@Descripcion ,1)<>0)
BEGIN
	SET @substring = substring(@Descripcion ,1,CHARINDEX(' ',@Descripcion ,1)-1)
	if @i = 0 
	    SET @sentence = @sentence + '(Articulos.Descripcion like ''%'+@substring+'%'')'
	else
	    SET @sentence = @sentence + 'and (Articulos.Descripcion like ''%'+@substring+'%'')'
	set @i = @i+1
	-- Find Substring up to Separator
	SET @Descripcion = substring(@Descripcion ,Len(@substring)+2,Len(@Descripcion ))
END

if @i = 0 
	    SET @sentence = @sentence + '(Articulos.Descripcion like ''%'+@Descripcion+'%'')'
	else
	    SET @sentence = @sentence + 'and (Articulos.Descripcion like ''%'+@Descripcion+'%'')'
set @sentence = '
SELECT TOP 250
Articulos.IdArticulo,
Articulos.Descripcion,
Articulos.IdCodigo, 
Articulos.Codigo,
Articulos.IdInventario,
Articulos.NumeroInventario,
Articulos.IdRubro,
Articulos.IdUnidad,
Articulos.AlicuotaIVA,
Articulos.CostoPPP,
Articulos.CostoPPPDolar,
Articulos.CostoReposicion,
Articulos.CostoReposicionDolar,
Articulos.Observaciones,
Articulos.IdSubrubro,
 Rubros.Descripcion as Rubro,
 Subrubros.Descripcion as Subrubro,
 (Select Sum(Stock.CantidadUnidades) From Stock 
	Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],
 (Select Top 1 Unidades.Abreviatura From Unidades 
	Where Articulos.IdUnidad=Unidades.IdUnidad) as [Un],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion)+
	IsNull('', ''+Ubicaciones.Descripcion,'''')+
	IsNull('' - Est.:''+Ubicaciones.Estanteria,'''')+
	IsNull('' - Mod.:''+Ubicaciones.Modulo,'''')+
	IsNull('' - Gab.:''+Ubicaciones.Gabeta,'''') as [Ubicacion],
 Unidades.Abreviatura as [Unidad]
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
WHERE IsNull(Articulos.Activo,'''')<>''NO'' AND' + @sentence
if @idRubro > 0
	SET @sentence = @sentence + ' and Articulos.IdRubro = '+ CAST(@IdRubro as VARCHAR(5))
SET @sentence = @sentence +  + ' ORDER by Rubros.Descripcion,Subrubros.Descripcion,Articulos.Codigo'
EXEC (@sentence)
END
