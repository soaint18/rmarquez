CREATE TABLE [dbo].[Proyectos] (
    [Nombre]              NVARCHAR (400) NOT NULL,
    [Tipo]                NVARCHAR (MAX) NOT NULL,
    [Cliente]             NVARCHAR (MAX) NOT NULL,
    [Responsable]         NVARCHAR (400) NULL,
    [FechaInicio]         DATE           DEFAULT (CONVERT([date],getdate())) NOT NULL,
    [FechaCierrePrevista] DATE           NULL,
    [HorasPrevistas]      INT            DEFAULT ((0)) NULL,
    [FechaCierreReal]     DATE           NULL,
    [HorasReales]         INT            DEFAULT ((0)) NULL,
    [Coste]               INT            DEFAULT ((0)) NULL,
    [Observaciones]       NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Nombre] ASC),
    FOREIGN KEY ([Responsable]) REFERENCES [dbo].[Usuarios] ([Nombre])
);

