--exec DetPedidos_TX_DetallesParametrizados 222,-1

select top 100 * from pedidos order by idpedido desc

select top 1000 * from detallepedidos order by iddetallepedido desc


exec ControlesCalidad_TL