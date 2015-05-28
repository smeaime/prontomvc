


CREATE Procedure [dbo].[DefinicionAnulaciones_A]
@IdDefinicionAnulacion int  output,
@IdFormulario int
As 
Insert into DefinicionAnulaciones
(
 IdFormulario
)
Values
(
 @IdFormulario
)
Select @IdDefinicionAnulacion=@@identity
Return(@IdDefinicionAnulacion)


