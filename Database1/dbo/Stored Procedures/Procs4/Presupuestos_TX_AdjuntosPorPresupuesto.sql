





























CREATE Procedure [dbo].[Presupuestos_TX_AdjuntosPorPresupuesto]
@IdPresupuesto int
AS 
Select 
IdPresupuesto,
ArchivoAdjunto1 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto1 is not null And Len(ArchivoAdjunto1)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto2 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto2 is not null And Len(ArchivoAdjunto2)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto3 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto3 is not null And Len(ArchivoAdjunto3)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto4 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto4 is not null And Len(ArchivoAdjunto4)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto5 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto5 is not null And Len(ArchivoAdjunto5)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto6 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto6 is not null And Len(ArchivoAdjunto6)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto7 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto7 is not null And Len(ArchivoAdjunto7)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto8 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto8 is not null And Len(ArchivoAdjunto8)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto9 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto9 is not null And Len(ArchivoAdjunto9)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto10 as [Adjunto]
From DetallePresupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto10 is not null And Len(ArchivoAdjunto10)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto1 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto1 is not null And Len(ArchivoAdjunto1)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto2 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto2 is not null And Len(ArchivoAdjunto2)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto3 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto3 is not null And Len(ArchivoAdjunto3)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto4 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto4 is not null And Len(ArchivoAdjunto4)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto5 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto5 is not null And Len(ArchivoAdjunto5)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto6 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto6 is not null And Len(ArchivoAdjunto6)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto7 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto7 is not null And Len(ArchivoAdjunto7)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto8 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto8 is not null And Len(ArchivoAdjunto8)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto9 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto9 is not null And Len(ArchivoAdjunto9)>3
Union
Select 
IdPresupuesto,
ArchivoAdjunto10 as [Adjunto]
From Presupuestos
Where IdPresupuesto=@IdPresupuesto And ArchivoAdjunto10 is not null And Len(ArchivoAdjunto10)>3
Order By IdPresupuesto






























