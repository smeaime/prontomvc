﻿































CREATE Procedure [dbo].[AcoModelos_T]
@IdAcoModelo int
AS 
SELECT *
FROM AcoModelos
where (IdAcoModelo=@IdAcoModelo)
































