CREATE TABLE [dbo].[wGrillaPersistencia] (
    [IdRenglon] INT          NOT NULL,
    [Sesion]    VARCHAR (50) NOT NULL,
    [Tilde]     BIT          NOT NULL,
    CONSTRAINT [U_Unicidad] UNIQUE NONCLUSTERED ([IdRenglon] ASC, [Sesion] ASC)
);

