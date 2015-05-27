





























CREATE Procedure [dbo].[EventosDelSistema_TX_TT]
@IdEventoDelSistema int
AS 
Select 
Descripcion as [Evento],
Case 	When Importancia=1 Then 'Alta' 
 	When Importancia=2 Then ' Regular' 
	Else 'Baja' 
End as [Importancia]
FROM EventosDelSistema
where (IdEventoDelSistema=@IdEventoDelSistema)






























