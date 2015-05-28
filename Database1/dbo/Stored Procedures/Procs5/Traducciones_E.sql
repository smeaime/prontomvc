

CREATE Procedure [dbo].[Traducciones_E]
@IdTraduccion int  AS 
Delete Traducciones
Where IdTraduccion=@IdTraduccion


