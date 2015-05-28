





























CREATE Procedure [dbo].[ProveedoresRubros_A]
@IdProveedorRubro int  output,
@IdProveedor int,
@IdRubro int,
@IdSubrubro int,
@IdFamilia int,
@Marca varchar(1)
AS 
Insert into [ProveedoresRubros]
(
IdProveedor,
IdRubro,
IdSubrubro,
IdFamilia
)
Values
(
@IdProveedor,
@IdRubro,
@IdSubrubro,
@IdFamilia
)
Select @IdProveedorRubro=@@identity
Return(@IdProveedorRubro)






























