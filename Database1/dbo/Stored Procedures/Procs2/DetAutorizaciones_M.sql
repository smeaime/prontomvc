﻿CREATE Procedure [dbo].[DetAutorizaciones_M]

@IdDetalleAutorizacion int,
@IdAutorizacion int,
@OrdenAutorizacion int,
@SectorEmisor1 varchar(1),
@IdSectorAutoriza1 int,
@IdCargoAutoriza1 int,
@SectorEmisor2 varchar(1),
@IdSectorAutoriza2 int,
@IdCargoAutoriza2 int,
@SectorEmisor3 varchar(1),
@IdSectorAutoriza3 int,
@IdCargoAutoriza3 int,
@SectorEmisor4 varchar(1),
@IdSectorAutoriza4 int,
@IdCargoAutoriza4 int,
@SectorEmisor5 varchar(1),
@IdSectorAutoriza5 int,
@IdCargoAutoriza5 int,
@SectorEmisor6 varchar(1),
@IdSectorAutoriza6 int,
@IdCargoAutoriza6 int,
@IdFirmante1 int,
@ImporteDesde1 numeric(18,2),
@ImporteHasta1 numeric(18,2),
@IdFirmante2 int,
@ImporteDesde2 numeric(18,2),
@ImporteHasta2 numeric(18,2),
@IdFirmante3 int,
@ImporteDesde3 numeric(18,2),
@ImporteHasta3 numeric(18,2),
@IdFirmante4 int,
@ImporteDesde4 numeric(18,2),
@ImporteHasta4 numeric(18,2),
@IdFirmante5 int,
@ImporteDesde5 numeric(18,2),
@ImporteHasta5 numeric(18,2),
@IdFirmante6 int,
@ImporteDesde6 numeric(18,2),
@ImporteHasta6 numeric(18,2),
@PersonalObra1 int,
@PersonalObra2 int,
@PersonalObra3 int,
@PersonalObra4 int,
@PersonalObra5 int,
@PersonalObra6 int,
@ADesignar varchar(2),
@IdsTipoCompra varchar(100)

AS 

UPDATE [DetalleAutorizaciones]
SET 
 IdAutorizacion=@IdAutorizacion,
 OrdenAutorizacion=@OrdenAutorizacion,
 SectorEmisor1=@SectorEmisor1,
 IdSectorAutoriza1=@IdSectorAutoriza1,
 IdCargoAutoriza1=@IdCargoAutoriza1,
 SectorEmisor2=@SectorEmisor2,
 IdSectorAutoriza2=@IdSectorAutoriza2,
 IdCargoAutoriza2=@IdCargoAutoriza2,
 SectorEmisor3=@SectorEmisor3,
 IdSectorAutoriza3=@IdSectorAutoriza3,
 IdCargoAutoriza3=@IdCargoAutoriza3,
 SectorEmisor4=@SectorEmisor4,
 IdSectorAutoriza4=@IdSectorAutoriza4,
 IdCargoAutoriza4=@IdCargoAutoriza4,
 SectorEmisor5=@SectorEmisor5,
 IdSectorAutoriza5=@IdSectorAutoriza5,
 IdCargoAutoriza5=@IdCargoAutoriza5,
 SectorEmisor6=@SectorEmisor6,
 IdSectorAutoriza6=@IdSectorAutoriza6,
 IdCargoAutoriza6=@IdCargoAutoriza6,
 IdFirmante1=@IdFirmante1,
 ImporteDesde1=@ImporteDesde1,
 ImporteHasta1=@ImporteHasta1,
 IdFirmante2=@IdFirmante2,
 ImporteDesde2=@ImporteDesde2,
 ImporteHasta2=@ImporteHasta2,
 IdFirmante3=@IdFirmante3,
 ImporteDesde3=@ImporteDesde3,
 ImporteHasta3=@ImporteHasta3,
 IdFirmante4=@IdFirmante4,
 ImporteDesde4=@ImporteDesde4,
 ImporteHasta4=@ImporteHasta4,
 IdFirmante5=@IdFirmante5,
 ImporteDesde5=@ImporteDesde5,
 ImporteHasta5=@ImporteHasta5,
 IdFirmante6=@IdFirmante6,
 ImporteDesde6=@ImporteDesde6,
 ImporteHasta6=@ImporteHasta6,
 PersonalObra1=@PersonalObra1,
 PersonalObra2=@PersonalObra2,
 PersonalObra3=@PersonalObra3,
 PersonalObra4=@PersonalObra4,
 PersonalObra5=@PersonalObra5,
 PersonalObra6=@PersonalObra6,
 ADesignar=@ADesignar,
 IdsTipoCompra=@IdsTipoCompra
WHERE (IdDetalleAutorizacion=@IdDetalleAutorizacion)

RETURN(@IdDetalleAutorizacion)