





























CREATE Procedure [dbo].[ItemsPopUpMateriales_A]
@IdItemPopUpMateriales int  output,
@IdRubro int,
@IdSubrubro int,
@IdFamilia int,
@Campo01_Nombre varchar(50),
@Campo01_Tabla varchar(50),
@Campo02_Nombre varchar(50),
@Campo02_Tabla varchar(50),
@Campo03_Nombre varchar(50),
@Campo03_Tabla varchar(50),
@Campo04_Nombre varchar(50),
@Campo04_Tabla varchar(50),
@Campo05_Nombre varchar(50),
@Campo05_Tabla varchar(50),
@Campo06_Nombre varchar(50),
@Campo06_Tabla varchar(50),
@Campo07_Nombre varchar(50),
@Campo07_Tabla varchar(50),
@Campo08_Nombre varchar(50),
@Campo08_Tabla varchar(50),
@Campo09_Nombre varchar(50),
@Campo09_Tabla varchar(50),
@Campo10_Nombre varchar(50),
@Campo10_Tabla varchar(50)
AS 
Insert into [ItemsPopUpMateriales]
(
 IdRubro,
 IdSubrubro,
 IdFamilia,
 Campo01_Nombre,
 Campo01_Tabla,
 Campo02_Nombre,
 Campo02_Tabla,
 Campo03_Nombre,
 Campo03_Tabla,
 Campo04_Nombre,
 Campo04_Tabla,
 Campo05_Nombre,
 Campo05_Tabla,
 Campo06_Nombre,
 Campo06_Tabla,
 Campo07_Nombre,
 Campo07_Tabla,
 Campo08_Nombre,
 Campo08_Tabla,
 Campo09_Nombre,
 Campo09_Tabla,
 Campo10_Nombre,
 Campo10_Tabla
)
Values
(
 @IdRubro,
 @IdSubrubro,
 @IdFamilia,
 @Campo01_Nombre,
 @Campo01_Tabla,
 @Campo02_Nombre,
 @Campo02_Tabla,
 @Campo03_Nombre,
 @Campo03_Tabla,
 @Campo04_Nombre,
 @Campo04_Tabla,
 @Campo05_Nombre,
 @Campo05_Tabla,
 @Campo06_Nombre,
 @Campo06_Tabla,
 @Campo07_Nombre,
 @Campo07_Tabla,
 @Campo08_Nombre,
 @Campo08_Tabla,
 @Campo09_Nombre,
 @Campo09_Tabla,
 @Campo10_Nombre,
 @Campo10_Tabla
)
Select @IdItemPopUpMateriales=@@identity
Return(@IdItemPopUpMateriales)





























