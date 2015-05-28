




CREATE Procedure [dbo].[AnticiposAlPersonal_T]
@IdAnticipoAlPersonal int
AS 
SELECT *
FROM AnticiposAlPersonal
WHERE (IdAnticipoAlPersonal=@IdAnticipoAlPersonal)




