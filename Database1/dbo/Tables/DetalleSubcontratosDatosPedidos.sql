CREATE TABLE [dbo].[DetalleSubcontratosDatosPedidos] (
    [IdDetalleSubcontratoDatosPedido] INT           IDENTITY (1, 1) NOT NULL,
    [IdSubcontratoDatos]              INT           NULL,
    [IdPedido]                        INT           NULL,
    [ArchivoAdjunto1]                 VARCHAR (100) NULL,
    CONSTRAINT [PK_DetalleSubcontratosDatosPedidos] PRIMARY KEY CLUSTERED ([IdDetalleSubcontratoDatosPedido] ASC) WITH (FILLFACTOR = 90)
);

