
CREATE Procedure [dbo].[AutorizacionesPorComprobante_GenerarFirmas]

@Desde Datetime = Null,
@Hasta Datetime = Null

AS

SET @Desde=IsNull(@Desde,0)
SET @Hasta=IsNull(@Hasta,GetDate())

DECLARE @CantidadAcopios int, @CantidadLMateriales int, @CantidadRequerimientos int, @CantidadPedidos int, 
	@CantidadComparativas int, @CantidadAjustesStock int

SET @CantidadAcopios=IsNull((Select Max(DetalleAutorizaciones.OrdenAutorizacion) From DetalleAutorizaciones
				Inner Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
				Where Autorizaciones.IdFormulario=1),0)
SET @CantidadLMateriales=IsNull((Select Max(DetalleAutorizaciones.OrdenAutorizacion) From DetalleAutorizaciones
				Inner Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
				Where Autorizaciones.IdFormulario=2),0)
SET @CantidadRequerimientos=IsNull((Select Max(DetalleAutorizaciones.OrdenAutorizacion) From DetalleAutorizaciones
					Inner Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
					Where Autorizaciones.IdFormulario=3),0)
SET @CantidadPedidos=IsNull((Select Max(DetalleAutorizaciones.OrdenAutorizacion) From DetalleAutorizaciones
				Inner Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
				Where Autorizaciones.IdFormulario=4),0)
SET @CantidadComparativas = IsNull((Select Max(DetalleAutorizaciones.OrdenAutorizacion) From DetalleAutorizaciones
					Inner Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
					Where Autorizaciones.IdFormulario=5),0)
SET @CantidadAjustesStock=IsNull((Select Max(DetalleAutorizaciones.OrdenAutorizacion) From DetalleAutorizaciones
					Inner Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
					Where Autorizaciones.IdFormulario=6),0)

TRUNCATE TABLE _TempEstadoDeFirmas

INSERT INTO _TempEstadoDeFirmas
SELECT 
 Aco.IdAcopio,
 'Acopio',
 str(Aco.NumeroAcopio,8),
 Aco.Fecha,
 @CantidadAcopios,
 Aco.Aprobo,
 Aco.FechaAprobacion,
 Case 	When @CantidadAcopios>=1
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=1)
	Else -1
 End, 
 Case 	When @CantidadAcopios>=1
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=1)
	Else Null
 End,
 Case 	When @CantidadAcopios>=2
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=2)
	Else -1
 End,
 Case 	When @CantidadAcopios>=2
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=2)
	Else Null
 End,
 Case 	When @CantidadAcopios>=3
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=3)
	Else -1
 End,
 Case 	When @CantidadAcopios>=3
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=3)
	Else Null
 End,
 Case 	When @CantidadAcopios>=4
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=4)
	Else -1
 End,
 Case 	When @CantidadAcopios>=4
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=4)
	Else Null
 End,
 Case 	When @CantidadAcopios>=5
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=5)
	Else -1
 End, Case 	When @CantidadAcopios>=5
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=5)
	Else Null
 End,
 Case 	When @CantidadAcopios>=6
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=6)
	Else -1
 End,
 Case 	When @CantidadAcopios>=6
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=6)
	Else Null
 End,
 Case 	When @CantidadAcopios>=7
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=7)
	Else -1
 End,
 Case 	When @CantidadAcopios>=7
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=7)
	Else Null
 End,
 Case 	When @CantidadAcopios>=8
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=8)
	Else -1
 End,
 Case 	When @CantidadAcopios>=8
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=8)
	Else Null
 End,
 Aco.IdObra,
 Null,
 Null,
 Null
FROM Acopios Aco
WHERE Aco.Fecha Between @Desde And @Hasta

UNION ALL

SELECT 
 LMat.IdLMateriales,
 'L.Materiales',
 str(LMat.NumeroLMateriales,8),
 LMat.Fecha,
 @CantidadLMateriales,
 LMat.Aprobo,
 Null,
 Case 	When @CantidadLMateriales>=1
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=1)
	Else -1
 End,
 Case 	When @CantidadLMateriales>=1
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=1)
	Else Null
 End,
 Case 	When @CantidadLMateriales>=2
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=2)
	Else -1
 End,
 Case 	When @CantidadLMateriales>=2
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=2)
	Else Null
 End,
 Case 	When @CantidadLMateriales>=3
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=3)
	Else -1
 End,
 Case 	When @CantidadLMateriales>=3
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=3)
	Else Null
 End,
 Case 	When @CantidadLMateriales>=4
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=4)
	Else -1
 End,
 Case 	When @CantidadLMateriales>=4
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=4)
	Else Null
 End,
 Case 	When @CantidadLMateriales>=5
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=5)
	Else -1
 End,
 Case 	When @CantidadLMateriales>=5
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=5)
	Else Null
 End,
 Case 	When @CantidadLMateriales>=6
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=6)
	Else -1
 End, Case 	When @CantidadLMateriales>=6
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=6)
	Else Null
 End,
 Case 	When @CantidadLMateriales>=7
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=7)
	Else -1
 End,
 Case 	When @CantidadLMateriales>=7
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=7)
	Else Null
 End,
 Case 	When @CantidadLMateriales>=8
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=8)
	Else -1
 End,
 Case 	When @CantidadLMateriales>=8
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=8)
	Else Null
 End,
 LMat.IdObra,
 LMat.IdEquipo,
 Null,
 LMat.CircuitoFirmasCompleto
FROM LMateriales LMat
WHERE LMat.Fecha Between @Desde And @Hasta

UNION ALL

SELECT 
 Req.IdRequerimiento,
 'R.M.',
 str(Req.NumeroRequerimiento,8),
 Req.FechaRequerimiento,
 @CantidadRequerimientos,
 Req.Aprobo,
 Req.FechaAprobacion,
 Case 	When @CantidadRequerimientos>=1
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=1)
	Else -1
 End,
 Case 	When @CantidadRequerimientos>=1
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=1)
	Else Null
 End,
 Case 	When @CantidadRequerimientos>=2
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=2)
	Else -1
 End,
 Case 	When @CantidadRequerimientos>=2
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=2)
	Else Null
 End,
 Case 	When @CantidadRequerimientos>=3
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=3)
	Else -1
 End,
 Case 	When @CantidadRequerimientos>=3
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=3)
	Else Null
 End,
 Case 	When @CantidadRequerimientos>=4
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=4)
	Else -1
 End,
 Case 	When @CantidadRequerimientos>=4
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=4)
	Else Null
 End,
 Case 	When @CantidadRequerimientos>=5
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=5)
	Else -1
 End,
 Case 	When @CantidadRequerimientos>=5
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=5)
	Else Null
 End,
 Case 	When @CantidadRequerimientos>=6
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=6)
	Else -1
 End, Case 	When @CantidadRequerimientos>=6
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=6)
	Else Null
 End,
 Case 	When @CantidadRequerimientos>=7
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=7)
	Else -1
 End,
 Case 	When @CantidadRequerimientos>=7
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=7)
	Else Null
 End,
 Case 	When @CantidadRequerimientos>=8
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=8)
	Else -1
 End,
 Case 	When @CantidadRequerimientos>=8
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=8)
	Else Null
 End,
 Req.IdObra,
 Null,
 Req.IdCentroCosto,
 Req.CircuitoFirmasCompleto
FROM Requerimientos Req
WHERE IsNull(Req.Cumplido,'NO')<>'AN' and Req.FechaRequerimiento Between @Desde And @Hasta

UNION ALL

SELECT 
 Ped.IdPedido,
 'Pedido',
 Case 	When Ped.SubNumero is not null 
	Then str(Ped.NumeroPedido,8)+' / '+str(Ped.SubNumero,2)
	Else str(Ped.NumeroPedido,8)
 End,
 Ped.FechaPedido,
 @CantidadPedidos,
 Ped.Aprobo,
 Ped.FechaAprobacion,
 Case 	When @CantidadPedidos>=1
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=1)
	Else -1
 End,
 Case 	When @CantidadPedidos>=1
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=1)
	Else Null
 End,
 Case 	When @CantidadPedidos>=2
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=2)
	Else -1
 End,
 Case 	When @CantidadPedidos>=2
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=2)
	Else Null
 End,
 Case 	When @CantidadPedidos>=3
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=3)
	Else -1
 End,
 Case 	When @CantidadPedidos>=3
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=3)
	Else Null
 End,
 Case 	When @CantidadPedidos>=4
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=4)
	Else -1
 End,
 Case 	When @CantidadPedidos>=4
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=4)
	Else Null
 End,
 Case 	When @CantidadPedidos>=5
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=5)
	Else -1
 End,
 Case 	When @CantidadPedidos>=5
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=5)
	Else Null
 End,
 Case 	When @CantidadPedidos>=6
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=6)
	Else -1
 End,
 Case 	When @CantidadPedidos>=6
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=6)
	Else Null
 End,
 Case 	When @CantidadPedidos>=7
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=7)
	Else -1
 End,
 Case 	When @CantidadPedidos>=7
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=7)
	Else Null
 End,
 Case 	When @CantidadPedidos>=8
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=8)
	Else -1
 End,
 Case 	When @CantidadPedidos>=8
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=8)
	Else Null
 End,
 Null,
 Null,
 Null,
 Ped.CircuitoFirmasCompleto
FROM Pedidos Ped
WHERE IsNull(Ped.Cumplido,'NO')<>'AN' and Ped.FechaPedido Between @Desde And @Hasta

UNION ALL

SELECT
 Com.IdComparativa,
 'Comparativa', 
 str(Com.Numero,8),
 Com.Fecha,
 @CantidadComparativas,
 Com.IdAprobo,
 Com.FechaAprobacion,
 Case 	When @CantidadComparativas>=1
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=1)
	Else -1
 End,
 Case 	When @CantidadComparativas>=1
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=1)
	Else Null
 End,
 Case 	When @CantidadComparativas>=2
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=2)
	Else -1
 End,
 Case 	When @CantidadComparativas>=2
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=2)
	Else Null
 End,
 Case 	When @CantidadComparativas>=3
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=3)
	Else -1
 End,
 Case 	When @CantidadComparativas>=3
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=3)
	Else Null
 End,
 Case 	When @CantidadComparativas>=4
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=4)
	Else -1
 End,
 Case 	When @CantidadComparativas>=4
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=4)
	Else Null
 End,
 Case 	When @CantidadComparativas>=5
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=5)
	Else -1
 End,
 Case 	When @CantidadComparativas>=5
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=5)
	Else Null
 End,
 Case 	When @CantidadComparativas>=6
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=6)
	Else -1
 End,
 Case 	When @CantidadComparativas>=6
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=6)
	Else Null
 End,
 Case 	When @CantidadComparativas>=7
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=7)
	Else -1
 End,
 Case 	When @CantidadComparativas>=7
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=7)
	Else Null
 End,
 Case 	When @CantidadComparativas>=8
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=8)
	Else -1
 End,
 Case 	When @CantidadComparativas>=8
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=5 and Aut.IdComprobante=Com.IdComparativa and Aut.OrdenAutorizacion=8)
	Else Null
 End,
 Null,
 Null,
 Null,
 Com.CircuitoFirmasCompleto
FROM Comparativas Com
WHERE Com.Fecha Between @Desde And @Hasta

UNION ALL

SELECT
 Aju.IdAjusteStock,
 'Ajuste Stock',
 str(Aju.NumeroAjusteStock,8),
 Aju.FechaAjuste,
 @CantidadAjustesStock,
 Aju.IdAprobo,
 Aju.FechaRegistro,
 Case 	When @CantidadAjustesStock>=1
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=1)
	Else -1
 End,
 Case 	When @CantidadAjustesStock>=1
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=1)
	Else Null
 End,
 Case 	When @CantidadAjustesStock>=2
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=2)
	Else -1
 End,
 Case 	When @CantidadAjustesStock>=2
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=2)
	Else Null
 End,
 Case 	When @CantidadAjustesStock>=3
 	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=3)
	Else -1
 End,
 Case 	When @CantidadAjustesStock>=3
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=3)
	Else Null
 End,
 Case 	When @CantidadAjustesStock>=4
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=4)
	Else -1
 End,
 Case 	When @CantidadAjustesStock>=4
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=4)
	Else Null
 End,
 Case 	When @CantidadAjustesStock>=5
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=5)
	Else -1
 End,
 Case 	When @CantidadAjustesStock>=5
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=5)
	Else Null
 End,
 Case 	When @CantidadAjustesStock>=6
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=6)
	Else -1
 End,
 Case 	When @CantidadAjustesStock>=6
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=6)
	Else Null
 End,
 Case 	When @CantidadAjustesStock>=7
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=7)
	Else -1
 End,
 Case 	When @CantidadAjustesStock>=7
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=7)
	Else Null
 End,
 Case 	When @CantidadAjustesStock>=8
	Then (Select Top 1 Aut.IdAutorizo
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=8)
	Else -1
 End,
 Case 	When @CantidadAjustesStock>=8
	Then (Select Top 1 Aut.FechaAutorizacion
		from AutorizacionesPorComprobante Aut 
		Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=8)
	Else Null
 End,
 Null,
 Null,
 Null,
 Aju.CircuitoFirmasCompleto
FROM AjustesStock Aju
WHERE Aju.FechaAjuste Between @Desde And @Hasta
