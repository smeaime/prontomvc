CREATE TABLE [dbo].[DescripcionIva] (
    [IdCodigoIva]          INT            IDENTITY (1, 1) NOT NULL,
    [Descripcion]          VARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IvaDiscriminado]      INT            NULL,
    [CodigoAFIP]           INT            NULL,
    [ExigirCUIT]           VARCHAR (2)    NULL,
    [ExigirCAI]            VARCHAR (2)    NULL,
    [InformacionAuxiliar]  VARCHAR (50)   NULL,
    [PorcentajePercepcion] NUMERIC (6, 2) NULL,
    CONSTRAINT [PK_DescripcionIva] PRIMARY KEY CLUSTERED ([IdCodigoIva] ASC)
);

