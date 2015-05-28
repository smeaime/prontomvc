


























CREATE Procedure [dbo].[OrdenesPago_ActualizarIdOrdenPagoComplementaria]

@IdOrdenPago int,
@IdOrdenPagoComplementaria int

As

Update OrdenesPago
Set IdOPComplementariaFF=@IdOrdenPagoComplementaria
Where IdOrdenPago=@IdOrdenPago



























