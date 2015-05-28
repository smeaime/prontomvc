CREATE Procedure [dbo].[CondicionesCompra_TT]

AS 

SELECT 
 IdCondicionCompra,
 Descripcion,
 Codigo,
 CantidadDias1 as [Dias (1)],
 Porcentaje1 as [% (1)],
 CantidadDias2 as [Dias (2)],
 Porcentaje2 as [% (2)],
 CantidadDias3 as [Dias (3)],
 Porcentaje3 as [% (3)],
 CantidadDias4 as [Dias (4)],
 Porcentaje4 as [% (4)],
 CantidadDias5 as [Dias (5)],
 Porcentaje5 as [% (5)],
 CantidadDias6 as [Dias (6)],
 Porcentaje6 as [% (6)],
 CantidadDias7 as [Dias (7)],
 Porcentaje7 as [% (7)],
 CantidadDias8 as [Dias (8)],
 Porcentaje8 as [% (8)],
 CantidadDias9 as [Dias (9)],
 Porcentaje9 as [% (9)],
 CantidadDias10 as [Dias (10)],
 Porcentaje10 as [% (10)],
 CantidadDias11 as [Dias (11)],
 Porcentaje11 as [% (11)],
 CantidadDias12 as [Dias (12)],
 Porcentaje12 as [% (12)],
 PorcentajeBonificacion as [% Bonif.],
 ContraEntregaDeValores as [Contra entrega de valores]
FROM [Condiciones Compra]
ORDER by Descripcion