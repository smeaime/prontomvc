CREATE TABLE [dbo].[EstadosVentasEnCuotas] (
    [IdEstadoVentaEnCuotas] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]           VARCHAR (50) NULL,
    CONSTRAINT [PK_EstadosVentasEnCuotas] PRIMARY KEY CLUSTERED ([IdEstadoVentaEnCuotas] ASC) WITH (FILLFACTOR = 90)
);

