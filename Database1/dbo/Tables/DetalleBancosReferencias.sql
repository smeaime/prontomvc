CREATE TABLE [dbo].[DetalleBancosReferencias] (
    [IdDetalleBancoReferencias] INT          IDENTITY (1, 1) NOT NULL,
    [IdBanco]                   INT          NULL,
    [IdTipoComprobante]         INT          NULL,
    [Referencia]                VARCHAR (50) NULL,
    [CodigoOperacion]           VARCHAR (50) NULL,
    CONSTRAINT [PK_DetalleBancosReferencias] PRIMARY KEY CLUSTERED ([IdDetalleBancoReferencias] ASC) WITH (FILLFACTOR = 90)
);

