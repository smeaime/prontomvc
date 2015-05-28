CREATE TABLE [dbo].[DW_DimClientes] (
    [IdCliente]    INT           NOT NULL,
    [Codigo]       VARCHAR (10)  NULL,
    [Cliente]      VARCHAR (50)  NULL,
    [Direccion]    VARCHAR (50)  NULL,
    [IdLocalidad]  INT           NULL,
    [CodigoPostal] VARCHAR (30)  NULL,
    [IdProvincia]  INT           NULL,
    [IdPais]       INT           NULL,
    [Telefono]     VARCHAR (30)  NULL,
    [Email]        VARCHAR (200) NULL,
    [Cuit]         VARCHAR (13)  NULL,
    [IdCodigoIva]  TINYINT       NULL,
    CONSTRAINT [PK_DW_DimClientes] PRIMARY KEY CLUSTERED ([IdCliente] ASC) WITH (FILLFACTOR = 90)
);

