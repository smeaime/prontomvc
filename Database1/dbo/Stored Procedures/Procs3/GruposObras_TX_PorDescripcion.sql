
CREATE Procedure [dbo].[GruposObras_TX_PorDescripcion]

@Descripcion varchar(50)

AS 

SELECT 
 GruposObras.IdGrupoObra,
 GruposObras.Descripcion,
 (Select Top 1 Obras.IdObra From Obras Where Obras.IdGrupoObra=GruposObras.IdGrupoObra) as [IdObra]
 FROM GruposObras
WHERE GruposObras.Descripcion=@Descripcion
