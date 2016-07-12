
drop FUNCTION [dbo].wCartasDePorteControlDescargas_TX_InformeControlDiario
go

CREATE FUNCTION [dbo].wCartasDePorteControlDescargas_TX_InformeControlDiario
(
	@IdDetalleFactura int
)

RETURNS int
AS
BEGIN

declare @i int


select 
    g.IdCartasDePorteControlDescarga,
    g.Destino,
    g.FechaDescarga,
    g.Sum(x => x.NetoFinal),
    g..TotalDescargaDia,
    g.TotalDescargaDia - g.Sum(x => x.NetoFinal),
    g.Count()
    --g.Select(x => x.NumeroCartaDePorte).ToList()

from 
(
	select from CartasDePorteControlDescargas D
	join CartasDePortes C on   C.FechaDescarga = D.Fecha  AND C.Destino = d.IdDestino AND  C.SubnumeroDeFacturacion <= 0
	group by d.IdCartasDePorteControlDescarga, c.Destino, c.FechaDescarga, d.TotalDescargaDia 
) as g
                      



END


wCartasDePorteControlDescargas_TX_InformeControlDiario 3