﻿


--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////


--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////


--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionFichasProcesos_E

@IdDetalleProduccionFichaProceso int  

AS 

DELETE [detalleproduccionfichaprocesos]
WHERE (IdDetalleProduccionFichaProceso=@IdDetalleProduccionFichaProceso)
