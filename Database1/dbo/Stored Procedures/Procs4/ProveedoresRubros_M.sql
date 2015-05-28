





























CREATE  Procedure [dbo].[ProveedoresRubros_M]
@IdProveedorRubro int ,
@IdRubro int,
@IdSubrubro int,
@IdFamilia int,
@Marca varchar(1)
AS
Update ProveedoresRubros
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro,
IdFamilia=@IdFamilia
where (IdProveedorRubro=@IdProveedorRubro)
Return(@IdProveedorRubro)






























