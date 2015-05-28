CREATE TABLE [dbo].[DetalleAcoCodigos] (
    [IdDetalleAcoCodigo] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoCodigo]        INT         NULL,
    [IdCodigo]           INT         NULL,
    [Marca]              VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoCodigos] PRIMARY KEY CLUSTERED ([IdDetalleAcoCodigo] ASC) WITH (FILLFACTOR = 90)
);

