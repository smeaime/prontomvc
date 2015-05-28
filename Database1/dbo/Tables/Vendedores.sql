CREATE TABLE [dbo].[Vendedores] (
    [IdVendedor]             INT            IDENTITY (1, 1) NOT NULL,
    [CodigoVendedor]         INT            NOT NULL,
    [Nombre]                 VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Direccion]              VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdLocalidad]            SMALLINT       CONSTRAINT [DF_Vendedores_LocalidadID] DEFAULT (1) NOT NULL,
    [CodigoPostal]           INT            NULL,
    [IdProvincia]            TINYINT        CONSTRAINT [DF_Vendedores_IdProvincia] DEFAULT (1) NOT NULL,
    [Telefono]               VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Fax]                    VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Email]                  VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Comision]               NUMERIC (7, 2) NULL,
    [IdEmpleado]             INT            NULL,
    [Cuit]                   VARCHAR (13)   NULL,
    [TodasLasZonas]          VARCHAR (2)    NULL,
    [EmiteComision]          VARCHAR (2)    NULL,
    [IdsVendedoresAsignados] VARCHAR (1000) NULL,
    CONSTRAINT [PK_Vendedores] PRIMARY KEY NONCLUSTERED ([IdVendedor] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[Vendedores]([Nombre] ASC, [IdVendedor] ASC) WITH (FILLFACTOR = 90);

