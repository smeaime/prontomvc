






CREATE Procedure [dbo].[_TempCondicionesCompra_A]
@IdAux int output,
@IdCondicionCompra int,
@Dias int,
@Porcentaje numeric(6,2)
As 
Insert into [_TempCondicionesCompra]
(
 IdCondicionCompra,
 Dias,
 Porcentaje
)
Values
(
 @IdCondicionCompra,
 @Dias,
 @Porcentaje
)
Select @IdAux=@@identity
Return(@IdAux)







