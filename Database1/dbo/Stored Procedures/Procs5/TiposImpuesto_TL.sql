




CREATE Procedure [dbo].[TiposImpuesto_TL]
As 
Select 
 IdTipoImpuesto,
 Descripcion as [Titulo]
From TiposImpuesto
Order By Descripcion




