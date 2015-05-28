
















CREATE Procedure [dbo].[Pedidos_TX_AdjuntosPorPedido]
@IdPedido int
AS 
Select 
IdPedido,
ArchivoAdjunto1 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto1 is not null And Len(ArchivoAdjunto1)>3
Union
Select 
IdPedido,
ArchivoAdjunto2 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto2 is not null And Len(ArchivoAdjunto2)>3
Union
Select 
IdPedido,
ArchivoAdjunto3 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto3 is not null And Len(ArchivoAdjunto3)>3
Union
Select 
IdPedido,
ArchivoAdjunto4 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto4 is not null And Len(ArchivoAdjunto4)>3
Union
Select 
IdPedido,
ArchivoAdjunto5 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto5 is not null And Len(ArchivoAdjunto5)>3
Union
Select 
IdPedido,
ArchivoAdjunto6 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto6 is not null And Len(ArchivoAdjunto6)>3
Union
Select 
IdPedido,
ArchivoAdjunto7 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto7 is not null And Len(ArchivoAdjunto7)>3
Union
Select 
IdPedido,
ArchivoAdjunto8 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto8 is not null And Len(ArchivoAdjunto8)>3
Union
Select 
IdPedido,
ArchivoAdjunto9 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto9 is not null And Len(ArchivoAdjunto9)>3
Union
Select 
IdPedido,
ArchivoAdjunto10 as [Adjunto]
From DetallePedidos
Where IdPedido=@IdPedido And ArchivoAdjunto10 is not null And Len(ArchivoAdjunto10)>3
Union
Select 
IdPedido,
ArchivoAdjunto1 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto1 is not null And Len(ArchivoAdjunto1)>3
Union
Select 
IdPedido,
ArchivoAdjunto2 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto2 is not null And Len(ArchivoAdjunto2)>3
Union
Select 
IdPedido,
ArchivoAdjunto3 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto3 is not null And Len(ArchivoAdjunto3)>3
Union
Select 
IdPedido,
ArchivoAdjunto4 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto4 is not null And Len(ArchivoAdjunto4)>3
Union
Select 
IdPedido,
ArchivoAdjunto5 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto5 is not null And Len(ArchivoAdjunto5)>3
Union
Select 
IdPedido,
ArchivoAdjunto6 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto6 is not null And Len(ArchivoAdjunto6)>3
Union
Select 
IdPedido,
ArchivoAdjunto7 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto7 is not null And Len(ArchivoAdjunto7)>3
Union
Select 
IdPedido,
ArchivoAdjunto8 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto8 is not null And Len(ArchivoAdjunto8)>3
Union
Select 
IdPedido,
ArchivoAdjunto9 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto9 is not null And Len(ArchivoAdjunto9)>3
Union
Select 
IdPedido,
ArchivoAdjunto10 as [Adjunto]
From Pedidos
Where IdPedido=@IdPedido And ArchivoAdjunto10 is not null And Len(ArchivoAdjunto10)>3
Order By IdPedido

















