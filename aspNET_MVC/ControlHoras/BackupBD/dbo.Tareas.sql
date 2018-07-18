CREATE TABLE [dbo].[Tareas] (
    [Nombre]         NVARCHAR (400) NOT NULL,
    [Proyecto]       NVARCHAR (400) NOT NULL,
    [FechaInicio]    DATE           DEFAULT (CONVERT([date],getdate())) NOT NULL,
    [FechaFin]       DATE           NULL,
    [HorasEstimadas] INT            DEFAULT ((0)) NULL,
    [HorasReales]    INT            DEFAULT ((0)) NULL,
    [Tecnico]        NVARCHAR (400) NULL,
    [Coste]          INT            DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([Nombre] ASC),
    FOREIGN KEY ([Tecnico]) REFERENCES [dbo].[Usuarios] ([Nombre]),
    FOREIGN KEY ([Proyecto]) REFERENCES [dbo].[Proyectos] ([Nombre])
);

