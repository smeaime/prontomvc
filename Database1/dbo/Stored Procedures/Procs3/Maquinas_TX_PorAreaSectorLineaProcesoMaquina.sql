
CREATE Procedure Maquinas_TX_PorAreaSectorLineaProcesoMaquina
	@Area int =NULL,
	@Sector int=NULL,
	@Linea int=NULL,
	@Proceso int=NULL,
	@Maquina int=NULL
AS 

if @area=-1 begin set @area=null end
if @Sector=-1 begin set @Sector=null end
if @Linea=-1 begin set @Linea=null end
if @Proceso=-1 begin set @Proceso=null end
if @Maquina=-1 begin set @Maquina=null end

SELECT distinct ART.idArticulo as IdArticuloOrig
		,ART.Codigo,ART.Descripcion,PROD_Maquinas.*,ProduccionSectores.idProduccionArea,ProduccionProcesos.idProduccionSector,ProduccionSectores.idProduccionSector
FROM Articulos ART
left outer join Tipos on Tipos.idTipo=ART.idTipo
left outer join PROD_Maquinas on PROD_Maquinas.idArticulo=ART.idArticulo --este agrega las maquinas en PROD_maquinas
--faltaría agregar los del prontoMantenimiento


left outer join ProduccionProcesos on ProduccionProcesos.idProduccionProceso=PROD_Maquinas.idProduccionProceso
left outer join ProduccionSectores on ProduccionSectores.idProduccionSector=ProduccionProcesos.idProduccionSector
left outer join ProduccionLineas Lineas on Lineas.idProduccionLinea=PROD_Maquinas.idProduccionLinea

WHERE 
    (ProduccionProcesos.idProduccionSector=IsNull(@Sector,ProduccionProcesos.idProduccionSector) or ProduccionProcesos.idProduccionSector is null)
and (ProduccionProcesos.idProduccionProceso=IsNull(@Proceso,ProduccionProcesos.idProduccionProceso)  or ProduccionProcesos.idProduccionProceso is null)
--and Maquinas.idPROD_Maquina=IsNull(@Maquina,Maquinas.idPROD_Maquina)
and (Lineas.idProduccionLinea=IsNull(@Linea,Lineas.idProduccionLinea) or Lineas.idProduccionLinea is null)
and (ART.idArticulo=IsNull(@Maquina,ART.IdArticulo) or ART.IdArticulo is null)
and (idProduccionArea=IsNull(@Area,idProduccionArea) or idProduccionArea is null)
and (IsNull(Tipos.Descripcion,'')='Equipo' or not PROD_Maquinas.idarticulo is null)
-- IsNull(Tipos.IdTipo,0)=3 
