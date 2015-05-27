CREATE TABLE [dbo].[Conceptos] (
    [IdConcepto]          INT             IDENTITY (1, 1) NOT NULL,
    [Descripcion]         VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCuenta]            INT             NULL,
    [ValorRechazado]      VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CodigoConcepto]      INT             NULL,
    [GravadoDefault]      VARCHAR (2)     NULL,
    [Grupo]               INT             NULL,
    [CodigoAFIP]          VARCHAR (20)    NULL,
    [CoeficienteAuxiliar] NUMERIC (18, 2) NULL,
    [GeneraComision]      VARCHAR (2)     NULL,
    [NoTomarEnRanking]    VARCHAR (2)     NULL,
    CONSTRAINT [PK_Conceptos] PRIMARY KEY NONCLUSTERED ([IdConcepto] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[Conceptos]([Descripcion] ASC, [IdConcepto] ASC) WITH (FILLFACTOR = 90);

