




CREATE Procedure [dbo].[AnticiposAlPersonalSyJ_E]
@IdAnticipoAlPersonalSyJ int  
As 
Delete AnticiposAlPersonalSyJ
Where (IdAnticipoAlPersonalSyJ=@IdAnticipoAlPersonalSyJ)




