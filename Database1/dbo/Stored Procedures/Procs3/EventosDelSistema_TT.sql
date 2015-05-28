





























CREATE Procedure [dbo].[EventosDelSistema_TT]
AS 
Select 
IdEventoDelSistema,
Descripcion as [Evento],
Case 	When Importancia=1 Then 'Alta' 
 	When Importancia=2 Then ' Regular' 
	Else 'Baja' 
End as [Importancia]
FROM EventosDelSistema
order by Descripcion






























