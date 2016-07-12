
drop PROCEDURE [dbo].wCartasDePorteControlDescargas_TX_InformeControlDiario
go

CREATE PROCEDURE [dbo].wCartasDePorteControlDescargas_TX_InformeControlDiario
(
	@FechaDesde DateTime,
	@FechaHasta DateTime,
	@IdDestino int
)
AS
BEGIN

declare @i int



select 
    IdCartasDePorteControlDescarga,
    Destino,
    FechaDescarga,
    Sum(NetoFinal),
    TotalDescargaDia,
    TotalDescargaDia - Sum(NetoFinal),
    Count(*)
    --g.Select(x => x.NumeroCartaDePorte).ToList()

	from CartasDePorteControlDescarga D
	inner join CartasDePorte C on   C.FechaDescarga = D.Fecha  AND C.Destino = d.IdDestino AND  C.SubnumeroDeFacturacion <= 0
	group by d.IdCartasDePorteControlDescarga, c.Destino, c.FechaDescarga, d.TotalDescargaDia 
                      
end
go





exec wCartasDePorteControlDescargas_TX_InformeControlDiario '','',3

/*
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[CartasDePorte] ([SubnumeroDeFacturacion])
INCLUDE ([NetoFinal],[Destino],[FechaDescarga])
GO
*/