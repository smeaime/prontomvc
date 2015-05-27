CREATE TABLE [dbo].[DetalleAcoHHItemsDocumentacion] (
    [IdDetalleAcoHHItemDocumentacion] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoHHItemDocumentacion]        INT         NULL,
    [IdItemDocumentacion]             INT         NULL,
    [Marca]                           VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoHHItemsDocumentacion] PRIMARY KEY CLUSTERED ([IdDetalleAcoHHItemDocumentacion] ASC) WITH (FILLFACTOR = 90)
);

