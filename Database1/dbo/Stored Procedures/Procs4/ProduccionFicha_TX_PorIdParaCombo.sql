﻿
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

--exec dbo.ProduccionFicha_TX_PorIdParaCombo
CREATE Procedure ProduccionFicha_TX_PorIdParaCombo
AS 
SELECT 
 IdProduccionFicha,
 Descripcion as Titulo
FROM ProduccionFichas
--WHERE IsNull(IdTipo,0)=@IdTipo and IsNull(Articulos.Activo,'')<>'NO'
ORDER by IdProduccionFicha


