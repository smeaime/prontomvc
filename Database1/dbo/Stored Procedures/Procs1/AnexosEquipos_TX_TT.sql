































CREATE Procedure [dbo].[AnexosEquipos_TX_TT]
@IdAnexoEquipos int
AS 
Select 
IdAnexoEquipos,
NumeroNCM,
Equipo
FROM AnexosEquipos
WHERE (IdAnexoEquipos=@IdAnexoEquipos)
































