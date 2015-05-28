








CREATE Procedure [dbo].[EmpleadosAccesos_InhabilitarAccesosPorNodo]
@Nodo varchar(50) 
As 
Update EmpleadosAccesos
Set Acceso=0
Where (Nodo=@Nodo)








