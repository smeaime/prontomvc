CREATE TABLE [dbo].[ProduccionTerminados] (
    [IdProduccionTerminado] INT             IDENTITY (1, 1) NOT NULL,
    [NumeroOrdenProduccion] INT             NULL,
    [Fecha]                 DATETIME        NULL,
    [IdArticulo]            INT             NULL,
    [IdColor]               INT             NULL,
    [Talle]                 VARCHAR (2)     NULL,
    [Cantidad]              NUMERIC (18, 2) NULL,
    [RegistroOrigen]        VARCHAR (50)    NULL,
    [IdDetalleRecepcion]    INT             NULL,
    [CodigoArticulo]        VARCHAR (4)     NULL,
    [CodigoColor]           VARCHAR (4)     NULL,
    CONSTRAINT [PK_ProduccionTerminados] PRIMARY KEY CLUSTERED ([IdProduccionTerminado] ASC) WITH (FILLFACTOR = 90)
);

