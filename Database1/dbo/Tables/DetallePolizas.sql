CREATE TABLE [dbo].[DetallePolizas] (
    [IdDetallePoliza]  INT             IDENTITY (1, 1) NOT NULL,
    [IdPoliza]         INT             NULL,
    [IdBienAsegurado]  INT             NULL,
    [ImporteAsegurado] NUMERIC (18, 2) NULL,
    [IdObraActual]     INT             NULL,
    [EnUsoPor]         VARCHAR (30)    NULL,
    CONSTRAINT [PK_DetallePolizas] PRIMARY KEY CLUSTERED ([IdDetallePoliza] ASC) WITH (FILLFACTOR = 90)
);

