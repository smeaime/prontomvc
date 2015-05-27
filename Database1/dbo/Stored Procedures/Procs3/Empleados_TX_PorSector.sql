CREATE Procedure [dbo].[Empleados_TX_PorSector]

@Sector varchar(50),
@Cargo varchar(50) = Null,
@MasInactivos varchar(2) = Null

AS 

SET @Sector=Upper(@Sector)
SET @Cargo=IsNull(@Cargo,'')
SET @MasInactivos=IsNull(@MasInactivos,'')

SELECT E.IdEmpleado, E.Nombre as [Titulo]
FROM Empleados E
LEFT OUTER JOIN Sectores S1 ON S1.IdSector=E.IdSector
LEFT OUTER JOIN Sectores S2 ON S2.IdSector=E.IdSector1
LEFT OUTER JOIN Sectores S3 ON S3.IdSector=E.IdSector2
LEFT OUTER JOIN Sectores S4 ON S4.IdSector=E.IdSector3
LEFT OUTER JOIN Sectores S5 ON S5.IdSector=E.IdSector4
LEFT OUTER JOIN Cargos C1 ON C1.IdCargo=E.IdCargo
LEFT OUTER JOIN Cargos C2 ON C2.IdCargo=E.IdCargo1
LEFT OUTER JOIN Cargos C3 ON C3.IdCargo=E.IdCargo2
LEFT OUTER JOIN Cargos C4 ON C4.IdCargo=E.IdCargo3
LEFT OUTER JOIN Cargos C5 ON C5.IdCargo=E.IdCargo4
WHERE 
	(IsNull(E.Activo,'SI')='SI' or @MasInactivos='SI') and 
	(@Sector='' or 
	 (@Sector<>'' and 
	  (IsNull(Upper(S1.Descripcion),'')=@Sector or IsNull(Upper(S2.Descripcion),'')=@Sector or 
	   IsNull(Upper(S3.Descripcion),'')=@Sector or IsNull(Upper(S4.Descripcion),'')=@Sector or 
	   IsNull(Upper(S5.Descripcion),'')=@Sector))) and 
	(@Cargo='' or 
	 (@Cargo<>'' and 
	  (Patindex('%'+@Cargo+'%', IsNull(Upper(C1.Descripcion),''))<>0  or 
	   Patindex('%'+@Cargo+'%', IsNull(Upper(C2.Descripcion),''))<>0  or 
	   Patindex('%'+@Cargo+'%', IsNull(Upper(C3.Descripcion),''))<>0  or 
	   Patindex('%'+@Cargo+'%', IsNull(Upper(C4.Descripcion),''))<>0  or 
	   Patindex('%'+@Cargo+'%', IsNull(Upper(C5.Descripcion),''))<>0)))
ORDER BY E.Nombre