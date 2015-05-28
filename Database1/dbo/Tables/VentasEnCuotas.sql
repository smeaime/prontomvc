CREATE TABLE [dbo].[VentasEnCuotas] (
    [IdVentaEnCuotas]        INT             IDENTITY (1, 1) NOT NULL,
    [IdCliente]              INT             NULL,
    [IdArticulo]             INT             NULL,
    [FechaOperacion]         DATETIME        NULL,
    [FechaPrimerVencimiento] DATETIME        NULL,
    [CantidadCuotas]         INT             NULL,
    [ImporteCuota]           NUMERIC (18, 2) NULL,
    [IdRealizo]              INT             NULL,
    [Observaciones]          NTEXT           NULL,
    [Estado]                 VARCHAR (2)     NULL,
    [IdEstadoVentaEnCuotas]  INT             NULL,
    CONSTRAINT [PK_VentasEnCuotas] PRIMARY KEY CLUSTERED ([IdVentaEnCuotas] ASC) WITH (FILLFACTOR = 90)
);

