CREATE  Procedure PROD_TiposControlCalidad_T
@IdPROD_TiposControlCalidad int
AS 

--SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)

SELECT *
FROM PROD_TiposControlCalidad p
WHERE (p.IdPROD_TiposControlCalidad=@IdPROD_TiposControlCalidad)
