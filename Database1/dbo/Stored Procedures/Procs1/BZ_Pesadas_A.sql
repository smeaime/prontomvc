
CREATE Procedure [dbo].[BZ_Pesadas_A]
	@IdPesada  int output,
	@NumeroPesada int,

	@IdUsuarioIngreso int ,
	@FechaIngreso datetime ,
	@Anulada varchar(2) ,
	@IdUsuarioAnulo int ,
	@FechaAnulacion datetime ,
	@Observaciones varchar(200) ,

	@IdArticulo int  ,
	@IdStock int ,
	@Partida varchar(20),
	@IdUnidad int,
	@IdUbicacion int ,
	@Cantidad numeric(12,2) ,

	@PesoBruto numeric(18,2) ,
	@PesoNeto numeric(18,2) ,
	@Tara numeric(18,2) ,

	@Chofer int , --id?
	@TxtChofer varchar(30) , --mientras no haya id
	@IdCamion int , -- id?
	@TxtCamion varchar(30) ,	

	@IdTransportista int , --id? Sí, el pronto tiene tabla de transportistas
	@IdProveedor int ,
	@IdCliente int ,
	@IdObra int ,

	@RemitoMaterial int ,
	@RemitoTransportista int,

	@CantidadEnOrigen numeric(12,2) ,
	@PesoBrutoIngresadoManualmente varchar(2),
	@TaraIngresadaManualmente varchar(2),
	@IdDetallePedido int

AS 

INSERT INTO [BZ_Pesadas]
(

	NumeroPesada ,

	IdUsuarioIngreso  ,
	FechaIngreso  ,
	Anulada  ,
	IdUsuarioAnulo  ,
	FechaAnulacion  ,
	Observaciones  ,

	IdArticulo   ,
	IdStock  ,
	Partida ,
	IdUnidad ,
	IdUbicacion  ,
	Cantidad  ,

	PesoBruto  ,
	PesoNeto  ,
	Tara  ,

	Chofer  , 
	TxtChofer  ,
	IdCamion ,
	TxtCamion  ,	

	IdTransportista  , 
	IdProveedor  ,
	IdCliente  ,
	IdObra  ,

	RemitoMaterial  ,
	RemitoTransportista ,

	CantidadEnOrigen, 
	PesoBrutoIngresadoManualmente,
	TaraIngresadaManualmente,
	IdDetallePedido
)
VALUES
(

	@NumeroPesada ,

	@IdUsuarioIngreso  ,
	@FechaIngreso  ,
	@Anulada  ,
	@IdUsuarioAnulo  ,
	@FechaAnulacion  ,
	@Observaciones  ,

	@IdArticulo   ,
	@IdStock  ,
	@Partida ,
	@IdUnidad ,
	@IdUbicacion  ,
	@Cantidad  ,

	@PesoBruto  ,
	@PesoNeto  ,
	@Tara  ,

	@Chofer  , 
	@TxtChofer  ,
	@IdCamion ,
	@TxtCamion  ,	

	@IdTransportista  , 
	@IdProveedor  ,
	@IdCliente  ,
	@IdObra  ,

	@RemitoMaterial  ,
	@RemitoTransportista  ,

	@CantidadEnOrigen , 	
	@PesoBrutoIngresadoManualmente,
	@TaraIngresadaManualmente ,
	@IdDetallePedido
)

SELECT @IdPesada=@@identity
RETURN(@IdPesada)
