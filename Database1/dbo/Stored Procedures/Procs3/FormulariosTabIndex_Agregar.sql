




CREATE Procedure [dbo].[FormulariosTabIndex_Agregar]
@Formulario varchar(100),
@Control varchar(100),
@Subindice int,
@TabIndex int
As 
Insert into [FormulariosTabIndex]
(
 Formulario,
 Control,
 Subindice,
 TabIndex
)
Values
(
 @Formulario,
 @Control,
 @Subindice,
 @TabIndex
)
Return(0)




