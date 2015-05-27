




CREATE Procedure [dbo].[AnticiposAlPersonal_E]
@IdAnticipoAlPersonal int  
As 
Delete AnticiposAlPersonal
Where (IdAnticipoAlPersonal=@IdAnticipoAlPersonal)




