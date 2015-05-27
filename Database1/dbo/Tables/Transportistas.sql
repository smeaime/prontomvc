CREATE TABLE [dbo].[Transportistas] (
    [IdTransportista] INT          IDENTITY (1, 1) NOT NULL,
    [RazonSocial]     VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Direccion]       VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdLocalidad]     INT          NULL,
    [CodigoPostal]    VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdProvincia]     INT          NULL,
    [IdPais]          INT          NULL,
    [Telefono]        VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Fax]             VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Email]           VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCodigoIva]     TINYINT      NULL,
    [Cuit]            VARCHAR (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Contacto]        VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Observaciones]   NTEXT        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Horario]         VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Celular]         VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail]     TINYINT      NULL,
    [IdProveedor]     INT          NULL,
    [Codigo]          INT          NULL,
    CONSTRAINT [PK_Transportistas] PRIMARY KEY CLUSTERED ([IdTransportista] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Transportistas_Localidades] FOREIGN KEY ([IdLocalidad]) REFERENCES [dbo].[Localidades] ([IdLocalidad])
);

